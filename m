Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458BF1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 14:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbcLNOc4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 09:32:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:56403 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755436AbcLNOcz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 09:32:55 -0500
Received: (qmail 31537 invoked by uid 109); 14 Dec 2016 14:32:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 14:32:37 +0000
Received: (qmail 25368 invoked by uid 111); 14 Dec 2016 14:33:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 09:33:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 09:32:35 -0500
Date:   Wed, 14 Dec 2016 09:32:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 4/4] Makefile: exclude contrib from FIND_SOURCE_FILES
Message-ID: <20161214143234.pvtvn456ijltvueu@sigill.intra.peff.net>
References: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you're working on the git project, you're unlikely to
care about random bits in contrib/ (e.g., you would not want
to jump to the copy of xmalloc in the wincred credential
helper). Nobody has really complained because there are
relatively few C files in contrib.

Now that we're matching shell scripts, too, we get quite a
few more hits, especially in the obsolete contrib/examples
directory. Looking for usage() should turn up the one in
git-sh-setup, not in some long-dead version of git-clone.

Let's just exclude all of contrib. Any specific projects
there which are big enough to want tags can generate them
separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index ef8de4a75..76267262c 100644
--- a/Makefile
+++ b/Makefile
@@ -2154,10 +2154,12 @@ FIND_SOURCE_FILES = ( \
 		'*.[hcS]' \
 		'*.sh' \
 		':!*[tp][0-9][0-9][0-9][0-9]*' \
+		':!contrib' \
 		2>/dev/null || \
 	$(FIND) . \
 		\( -name .git -type d -prune \) \
 		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
+		-o \( -name contrib -type d -prune \) \
 		-o \( -name build -type d -prune \) \
 		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
-- 
2.11.0.341.g202cd3142
