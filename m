Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBAD2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbcFXTox (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:44:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:59951 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbcFXTox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:44:53 -0400
Received: (qmail 31367 invoked by uid 102); 24 Jun 2016 19:44:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:44:52 -0400
Received: (qmail 22116 invoked by uid 107); 24 Jun 2016 19:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:45:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:44:50 -0400
Date:	Fri, 24 Jun 2016 15:44:50 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 2/4] t0005: use test_match_signal as appropriate
Message-ID: <20160624194450.GB6441@sigill.intra.peff.net>
References: <20160624193924.GA6282@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160624193924.GA6282@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The first test already uses this more portable construct
(that was where it was factored from initially), but the
later tests do a raw comparison against 141 to look for
SIGPIPE, which can fail on some shells and platforms.

Signed-off-by: Jeff King <peff@peff.net>
---
Again, I couldn't test these. They're skipped on MINGW, and ksh93 barfs
before even executing the tests.

 t/t0005-signals.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 2d96265..c80c995 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -36,12 +36,12 @@ test_expect_success 'create blob' '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
 	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
-	test "$OUT" -eq 141
+	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
 	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
-	test "$OUT" -eq 141
+	test_match_signal 13 "$OUT"
 '
 
 test_done
-- 
2.9.0.215.gc5c4261

