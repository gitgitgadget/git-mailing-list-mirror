Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA19220193
	for <e@80x24.org>; Thu, 27 Oct 2016 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbcJ0Rad (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 13:30:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:34931 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934200AbcJ0Rad (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 13:30:33 -0400
Received: (qmail 15848 invoked by uid 109); 27 Oct 2016 17:30:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 17:30:32 +0000
Received: (qmail 21647 invoked by uid 111); 27 Oct 2016 17:30:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 13:30:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2016 13:30:30 -0400
Date:   Thu, 27 Oct 2016 13:30:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] git-compat-util: move content inside ifdef/endif guards
Message-ID: <20161027173029.bu233oiekpfoh6lw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 3f2e2297b9 (add an extra level of indirection to
main(), 2016-07-01) added a declaration to git-compat-util.h,
but it was accidentally placed after the final #endif that
guards against multiple inclusions.

This doesn't have any actual impact on the code, since it's
not incorrect to repeat a function declaration in C. But
it's a bad habit, and makes it more likely for somebody else
to make the same mistake. It also defeats gcc's optimization
to avoid opening header files whose contents are completely
guarded.

Signed-off-by: Jeff King <peff@peff.net>
---
I just happened to notice this today while doing something unrelated in
the file.

 git-compat-util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 91e366d1dd..771ea29f31 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1042,6 +1042,6 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
-#endif
-
 extern int cmd_main(int, const char **);
+
+#endif
-- 
2.10.1.916.g0d2035c
