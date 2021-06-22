Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F30C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222B1611BF
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFVQGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:06:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:36006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVQGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:06:11 -0400
Received: (qmail 5796 invoked by uid 109); 22 Jun 2021 16:03:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 16:03:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28265 invoked by uid 111); 22 Jun 2021 16:03:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 12:03:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 12:03:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/5] pretty.h: update and expand docstring for
 userformat_find_requirements()
Message-ID: <YNIJ6tZMhn5wZ4Io@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment only mentions "notes", but there are more fields now (and
I'm about to add another). Let's make it more general, and stick the
struct next to the function to make the list of possibilities obvious.

While we're touching this comment, let's also mention the behavior of
NULL, which some callers rely on (though in the long run, this global is
pretty nasty and probably should get moved into rev_info).

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/pretty.h b/pretty.h
index f034609e4d..c81cf40d38 100644
--- a/pretty.h
+++ b/pretty.h
@@ -65,12 +65,15 @@ static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
 	return (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_MBOXRD);
 }
 
+/*
+ * Examine the user-specified format given by "fmt" (or if NULL, the global one
+ * previously saved by get_commit_format()), and set flags based on which items
+ * the format will need when it is expanded.
+ */
 struct userformat_want {
 	unsigned notes:1;
 	unsigned source:1;
 };
-
-/* Set the flag "w->notes" if there is placeholder %N in "fmt". */
 void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 
 /*
-- 
2.32.0.352.gff02c21e72

