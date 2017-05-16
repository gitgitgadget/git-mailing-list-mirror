Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2120201A7
	for <e@80x24.org>; Tue, 16 May 2017 01:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbdEPBLo (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 21:11:44 -0400
Received: from avasout07.plus.net ([84.93.230.235]:52344 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdEPBLo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 21:11:44 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id LpBg1v0081keHif01pBioZ; Tue, 16 May 2017 02:11:42 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=cx_BOnk6NZS1wjL5MxcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] usage: fix a sparse 'redeclared with different type' error
Message-ID: <52ef158a-0719-c71a-b72b-4961cf8f96d5@ramsayjones.plus.com>
Date:   Tue, 16 May 2017 02:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jk/bug-to-abort' branch, could you please
squash this into the relevant patch (commit d8193743e0 "usage.c: add
BUG() function", 12-05-2017).

[Just FYI, sparse complains thus:
  usage.c:212:6: error: symbol 'BUG_fl' redeclared with different type
  (originally declared at git-compat-util.h:1076) - different modifiers
]

Thanks!

ATB,
Ramsay Jones

 usage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/usage.c b/usage.c
index 545136734..918b539bc 100644
--- a/usage.c
+++ b/usage.c
@@ -209,6 +209,7 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 }
 
 #ifdef HAVE_VARIADIC_MACROS
+__attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
@@ -217,6 +218,7 @@ void BUG_fl(const char *file, int line, const char *fmt, ...)
 	va_end(ap);
 }
 #else
+__attribute__((format (printf, 1, 2))) NORETURN
 void BUG(const char *fmt, ...)
 {
 	va_list ap;
-- 
2.13.0
