Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F571F406
	for <e@80x24.org>; Thu, 10 May 2018 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965845AbeEJO31 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:29:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:34864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965503AbeEJO30 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:29:26 -0400
Received: (qmail 5676 invoked by uid 109); 10 May 2018 14:29:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 14:29:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24867 invoked by uid 111); 10 May 2018 14:29:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 10:29:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 10:29:24 -0400
Date:   Thu, 10 May 2018 10:29:24 -0400
From:   Jeff King <peff@peff.net>
To:     kelly elton <its.the.doc@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] apply: clarify "-p" documentation
Message-ID: <20180510142924.GB25617@sigill.intra.peff.net>
References: <CALVfKe_em046aO9QUqJ0TXcLh6Oe7ydYQKr9Zwvheq8RV4=43g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALVfKe_em046aO9QUqJ0TXcLh6Oe7ydYQKr9Zwvheq8RV4=43g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 12:40:05PM -0500, kelly elton wrote:

> >  -p<n>
> > Remove <n> leading slashes from traditional diff paths. The default is 1.
> 
> This suggests to me the following outcomes:
> 1) home/user/repos/myrepo with -p1 becomes home/user/repos/myrepo
> 2) home/user/repos/myrepo with -p2 becomes home/user/repos/myrepo
> 3) /home/user/repos/myrepo with -p1 becomes home/user/repos/myrepo
> 4) /home/user/repos/myrepo with -p2 becomes home/user/repos/myrepo
> 5) //home/user/repos/myrepo with -p1 becomes /home/user/repos/myrepo
> 6) //home/user/repos/myrepo with -p2 becomes home/user/repos/myrepo
> 
> `Remove <n> leading slashes`...That's not really what's happening.
> 
> What seems to actually happen is that it is removing directories from the path:
> 1) home/user/repos/myrepo with -p1 becomes home/user/repos/myrepo
> 2) home/user/repos/myrepo with -p2 becomes user/repos/myrepo
> 
> This argument seems to be removing folders from the path, not slashes.

Yes. I agree the current documentation is quite misleading.

How about this?

-- >8 --
Subject: [PATCH] apply: clarify "-p" documentation

We're not really removing slashes, but slash-separated path
components. Let's make that more clear.

Reported-by: kelly elton <its.the.doc@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-apply.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4ebc3d3271..c993fbf714 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -113,8 +113,10 @@ explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
 -p<n>::
-	Remove <n> leading slashes from traditional diff paths. The
-	default is 1.
+	Remove <n> leading path components (separated by slashes) from
+	traditional diff paths. E.g., with `-p2`, a patch against
+	`a/dir/file` will be applied directly to `file`. The default is
+	1.
 
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
-- 
2.17.0.984.g9b00a423a4

