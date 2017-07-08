Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A73202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 08:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbdGHI7o (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 04:59:44 -0400
Received: from mout.web.de ([212.227.15.14]:62887 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752712AbdGHI7n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 04:59:43 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lechi-1e2HJc1fjy-00qSQH; Sat, 08
 Jul 2017 10:59:22 +0200
To:     Git List <git@vger.kernel.org>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] urlmatch: use hex2chr() in append_normalized_escapes()
Message-ID: <eb5e7bb5-d0a9-c8df-e89c-a2bd2430e8b6@web.de>
Date:   Sat, 8 Jul 2017 10:59:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OP73C5/o4rw8J1BBSbDfxBaMISTAeRwCeWNl3+sWigBRrJ3Ga1/
 uhom+B0Hk688bm2OufpfSIAl/roqEx5Q++oMYUGRLf/sTRWpiDWCNiQ5rsJ0dnw1jZekFVG
 mJlsf27w54/njSgXqNysyd2oSR5X7n1M0RTnpcsIsDrhaRjTuwSHiBb+f30k7+/4zy6+nkM
 ChEG+526mofgkwNYaGTtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMHVeRJooCc=:1oqJPw/urQKcZ+Xs5a32Em
 9v9sxMIeGV7wNo9RkxCkeY6SqesBjXHCr2GpdJQ05WuCQx/COCSn3parN3PNx36tjFC/a5wt8
 omQ3tToHUZeiGknl3wD9wl2U6zwpZLt0rcXtheQPZaN5poMq0ryMLUxrHT/KCvIQGL0yO1pOb
 4xsEb0UwzqZOnHATrbPVgUBChHlEONXIJLfTlpGX+lFMgmhHYJIy1EW77sw8P+uEum6SqGQLT
 gHO52AtqaafGs3n63QIBzs7sqAiafV0w9lgf4Kqa9fgxxuU/72A78OKWF5bnRo7OjauWhB8wJ
 QMWG/Ch0T17/zveJcJJ38+9ve+8WzyrXBsmEu2AQH+qhhGvmhCThhnYFV3N5TmnwGe06SmpnP
 Kdmu7iRx+7TZyFYx98AwWhvLa1sy3/qmAAo6zXvUgG/iN6GMPpuKXxqEgKgsU8jQq4ZgD40gr
 Wj29DXSv2VTQpdcdlaUvtcU36NVs5ry67ykk67/YKNqq9jN7WmLbMVnSuz++NjP1Q73m6hKFp
 w6130tf9jqRszIR8o+kBEh9RhX9EqScBx4AfxHPqUMX4oQnOKeyAjDir1Bg9HXz8aP7pxkkxh
 1Yb77u15geq7xt53Vx18IOU4jLfUdhV/F7YhO2zMSRhXlvuov5f3L4zY0vsbFimQ2SC5D9Yq5
 sPC90D3lUPdRFbVpqV8BvPrvVG1cmnYagHNMqokT4mfcUElQ0wG6SxBO5uUjBzk6T5U8fk0ez
 QuaKLDn8jiG+9/ycLSkf9taANQBdY5v1mmVXhU7md6N1GLvGWC5OzNe6Ro/j4IbRg6DHApm3R
 qY2eNWh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the code by using hex2chr() to convert and check for invalid
characters at the same time instead of doing that sequentially with
one table lookup for each.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 urlmatch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/urlmatch.c b/urlmatch.c
index 4bbde924e8..3e42bd7504 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -42,12 +42,12 @@ static int append_normalized_escapes(struct strbuf *buf,
 
 		from_len--;
 		if (ch == '%') {
-			if (from_len < 2 ||
-			    !isxdigit(from[0]) ||
-			    !isxdigit(from[1]))
+			if (from_len < 2)
 				return 0;
-			ch = hexval(*from++) << 4;
-			ch |= hexval(*from++);
+			ch = hex2chr(from);
+			if (ch < 0)
+				return 0;
+			from += 2;
 			from_len -= 2;
 			was_esc = 1;
 		}
-- 
2.13.2
