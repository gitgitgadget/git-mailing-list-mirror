Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCFA1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeCTEO5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:14:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:35406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750888AbeCTEO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:14:56 -0400
Received: (qmail 29130 invoked by uid 109); 20 Mar 2018 04:14:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 04:14:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28889 invoked by uid 111); 20 Mar 2018 04:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 00:15:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 00:14:54 -0400
Date:   Tue, 20 Mar 2018 00:14:54 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: [PATCH] doc/gitattributes: mention non-recursive behavior
Message-ID: <20180320041454.GA15213@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320040411.GB12938@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 12:04:11AM -0400, Jeff King wrote:

> > I guess my takeaway is that it would be _good_ if the gitattributes
> > documentation contained the caveat about not matching directories
> > recursively, but _great_ if gitattributes and gitignore (and whatever
> > else there is) were consistent.
> 
> I agree it would be nice if they were consistent (and pathspecs, too).
> But unfortunately at this point there's a maze of backwards
> compatibility to deal with.

So let's not forget to do the easy half there. Here's a patch.

-- >8 --
Subject: [PATCH] doc/gitattributes: mention non-recursive behavior

The gitattributes documentation claims that the pattern
rules are largely the same as for gitignore. However, the
rules for recursion are different.

In an ideal world, we would make them the same (if for
nothing else than consistency and simplicity), but that
would create backwards compatibility issues. For some
discussion, see this thread:

  https://public-inbox.org/git/slrnkldd3g.1l4.jan@majutsushi.net/

But let's at least document the differences instead of
actively misleading the user by claiming that they're the
same.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitattributes.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d52b254a22..1094fe2b5b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -56,9 +56,16 @@ Unspecified::
 
 When more than one pattern matches the path, a later line
 overrides an earlier line.  This overriding is done per
-attribute.  The rules how the pattern matches paths are the
-same as in `.gitignore` files; see linkgit:gitignore[5].
-Unlike `.gitignore`, negative patterns are forbidden.
+attribute.
+
+The rules by which the pattern matches paths are the same as in
+`.gitignore` files (see linkgit:gitignore[5]), with a few exceptions:
+
+  - negative patterns are forbidden
+
+  - patterns that match a directory do not recursively match paths
+    inside that directory (so using the trailing-slash `path/` syntax is
+    pointless in an attributes file; use `path/**` instead)
 
 When deciding what attributes are assigned to a path, Git
 consults `$GIT_DIR/info/attributes` file (which has the highest
-- 
2.17.0.rc0.402.ged0b3fd1ee

