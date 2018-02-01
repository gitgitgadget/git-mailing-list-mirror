Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DFE1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 18:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbeBAS4p (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 13:56:45 -0500
Received: from mout.web.de ([212.227.17.12]:63915 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753562AbeBAS4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 13:56:44 -0500
Received: from [192.168.178.36] ([91.20.50.7]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIeUW-1ejWxi1TRI-002Imr; Thu, 01
 Feb 2018 19:56:38 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] cocci: simplify check for trivial format strings
Message-ID: <376eb2e8-0a95-233b-743b-cdc1caa49015@web.de>
Date:   Thu, 1 Feb 2018 19:56:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:MC84i/GXyuEuZL3BmdKq8bvZ6bb4X2vluk9AuSfgDynhnx9XacD
 2YlWTTtYYQ+dRvxu9X5NH9njdda1ZeISYE23ud1+hrZ3e88aRwnn+dVjNMlS5VJPi8x1Jvi
 35P9HF0pBZWjDMz9hXZyhythP/q9Mg3BkLw9yQq+JeC3kM3+BTNG8d+YTMAurUA15ECHoFv
 s/85BHWEmmivIMg9I/VuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:skkvYbjxQ3o=:shWZECmkDPuvGWpv17XcBw
 byfz8y/MTMW3tbPPylKBysiKYtz32Tku/xllgP2iD15cRyR8EdTWc0votaj1EBECZEhgQU6wH
 pcy6tBb9Nol1cadE2zs/Igtta8oiYdJKMX1Di200M4H6B7REewjXsE6/pyCD7fDpOUlhQ+xl5
 n6ysEfVmJgGsiFEk9CIfhnb25ADgE+sY21Z435+L//xN06tFeiLc28QBXPIPhuSD0qYeOTY5o
 abLd0LWyx6zCMyeJwvxskEx/FagjPMK3M85MMRmVXMGVah2tzGHhjW7vSYG0byGvjWh9WLsMg
 3I4WMmq6mtOfhJF30DtzvcyIDGq4nFkYwieBxlzcyP7yHmlbQGVNOzWisdax5PKcjRHkJQvlo
 HewyjSPARc2WzOCK9XvjigEy4yTjP1PCmQSCRw50u0JaZeX9hBnIh4y1y3smKfalTTYLyPfsU
 VzYhrTH9yJmUAGRVATBQ4gfsu7mz2jJoJTXvNRmo9IPUSnbfak9Kp6zP5MBzysNXe20oveGmX
 I4+tbN+Wb/PbroOkGU8sG/CxDTWGrRswI1zNj9i4LoDj6yQ2nnQaefGIkFlYcd9uzjARHa8Xu
 YVBnieDFrami6EoFj9gwn7kE5JM11hgnjO8nQpFLGTOF+9jnGucVPHkZz3uUaFoW2SK8m1wBK
 M78N2Umi2CfzUqRLrZzbNY4qTcy6OBfn7CpzXbQBpW5C1nseGokjYBesQcyIr0/yannZ5XKv+
 tusLLoMMef4NA7nL3eDKBzNquFSu3l6bqZ5Mw5jG5r/KtP3Mvu39xt344oyoj6BhnCWT7CZlm
 NlMZDzrjY4xF+XTvfs6iDffbbkflaG53uWjqj6t6XQ3tfVHbeA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

353d84c537 (coccicheck: make transformation for strbuf_addf(sb, "...")
more precise) added a check to avoid transforming calls with format
strings which contain percent signs, as that would change the result.
It uses embedded Python code for that.  Simplify this rule by using the
regular expression matching operator instead.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Inspired by the Coccinelle package in Debian experimental, which lost
support for Python for some reason.  Tested only with that version
(1.0.6.deb-3) and Debian testing's 1.0.4.deb-3+b3.

 contrib/coccinelle/strbuf.cocci | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 6fe8727421..e34eada1ad 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -1,21 +1,6 @@
 @ strbuf_addf_with_format_only @
 expression E;
-constant fmt;
-@@
-  strbuf_addf(E,
-(
-  fmt
-|
-  _(fmt)
-)
-  );
-
-@ script:python @
-fmt << strbuf_addf_with_format_only.fmt;
-@@
-cocci.include_match("%" not in fmt)
-
-@ extends strbuf_addf_with_format_only @
+constant fmt !~ "%";
 @@
 - strbuf_addf
 + strbuf_addstr
-- 
2.16.1
