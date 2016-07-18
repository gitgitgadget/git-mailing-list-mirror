Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E4B1FEAA
	for <e@80x24.org>; Mon, 18 Jul 2016 06:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbcGRGoe (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 02:44:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45442 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbcGRGoc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 02:44:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F501FEAA;
	Mon, 18 Jul 2016 06:44:31 +0000 (UTC)
Date:	Mon, 18 Jul 2016 06:44:31 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org
Subject: [PATCH] test-lib: stricter unzip(1) check
Message-ID: <20160718064431.GA10819@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On FreeBSD 10.3 (but presumably any FreeBSD 8+), /usr/bin/unzip
exists, but is insufficient for t5003 due to its non-standard
handling of the -a option[1].  This version of unzip exits
with "1" when given the "-v" flag.

However, the common Info-ZIP version may be installed at
/usr/local/bin/unzip (via "pkg install unzip") to pass t5003.
This Info-ZIP version exits with "0" when given "-v",
so limit the prereq to only versions which return 0 on "-v".

[1] https://www.freebsd.org/cgi/man.cgi?query=unzip&sektion=1&manpath=FreeBSD+10.3-RELEASE

Signed-off-by: Eric Wong <e@80x24.org>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11201e9..938f788 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1103,7 +1103,7 @@ test_lazy_prereq SANITY '
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
 	"$GIT_UNZIP" -v
-	test $? -ne 127
+	test $? -eq 0
 '
 
 run_with_limited_cmdline () {
-- 
EW
