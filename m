Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7FDE2018B
	for <e@80x24.org>; Fri, 24 Jun 2016 19:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbcFXTpI (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:45:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59959 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbcFXTpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:45:07 -0400
Received: (qmail 31388 invoked by uid 102); 24 Jun 2016 19:45:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:45:07 -0400
Received: (qmail 22136 invoked by uid 107); 24 Jun 2016 19:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:45:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:45:04 -0400
Date:	Fri, 24 Jun 2016 15:45:04 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 3/4] test_must_fail: use test_match_signal
Message-ID: <20160624194504.GC6441@sigill.intra.peff.net>
References: <20160624193924.GA6282@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160624193924.GA6282@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In 8bf4bec (add "ok=sigpipe" to test_must_fail and use it to
fix flaky tests, 2015-11-27), test_must_fail learned to
recognize "141" as a sigpipe failure. However, testing for
a signal is more complicated than that; we should use
test_match_signal to implement more portable checking.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 51d3775..91d3b58 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -612,7 +612,7 @@ test_must_fail () {
 	then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
-	elif test $exit_code -eq 141 && list_contains "$_test_ok" sigpipe
+	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
 	then
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
-- 
2.9.0.215.gc5c4261

