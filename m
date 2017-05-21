Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB89201CF
	for <e@80x24.org>; Sun, 21 May 2017 22:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbdEUWZo (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 18:25:44 -0400
Received: from avasout07.plus.net ([84.93.230.235]:48055 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757261AbdEUWZn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 18:25:43 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id PARf1v0061keHif01ARggD; Sun, 21 May 2017 23:25:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=iHgncD99ot6ZOeLuFXUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] usage: add NORETURN to BUG() function definitions
Message-ID: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
Date:   Sun, 21 May 2017 23:25:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit d8193743e0 ("usage.c: add BUG() function", 12-05-2017) added the
BUG() functions and macros as a replacement for calls to die("BUG: ..").
The use of NORETURN on the declarations (in git-compat-util.h) and the
lack of NORETURN on the function definitions, however, leads sparse to
complain thus:

      SP usage.c
  usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type
  (originally declared at git-compat-util.h:1074) - different modifiers

In order to suppress the sparse error, add the NORETURN to the function
definitions.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This is built on 'next', which has now merged the 'jk/bug-to-abort'
branch.

Thanks!

ATB,
Ramsay Jones

 usage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/usage.c b/usage.c
index 7e6cb2028..1f63e033e 100644
--- a/usage.c
+++ b/usage.c
@@ -217,7 +217,7 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 }
 
 #ifdef HAVE_VARIADIC_MACROS
-void BUG_fl(const char *file, int line, const char *fmt, ...)
+NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
@@ -225,7 +225,7 @@ void BUG_fl(const char *file, int line, const char *fmt, ...)
 	va_end(ap);
 }
 #else
-void BUG(const char *fmt, ...)
+NORETURN void BUG(const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
-- 
2.13.0
