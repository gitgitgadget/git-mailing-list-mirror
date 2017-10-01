Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DEB20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdJAOtl (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:49:41 -0400
Received: from mout.web.de ([212.227.15.3]:52543 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdJAOtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:49:40 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lp7Lg-1dMKXc29pc-00ewQp; Sun, 01
 Oct 2017 16:49:36 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] coccinelle: add rules to use strbuf_add() for adding
 buffers to strbufs
Message-ID: <85605bc6-2e91-7132-ce63-f6e08a08a768@web.de>
Date:   Sun, 1 Oct 2017 16:49:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hiMwdNzPEMbzG5b1MhLyP1O+RXGQaCnn+jUwv7nss+dyzxghGLU
 LEnAh4XEsbmgpgEPG5+aTSlc1rpfteTJ76gRox+kOfBrpGLZTx9Ql+/Jm9Uk2S09Kh3raNS
 fFnaJwINuQvHwKEbJx+jU64aCXjTfV+jECjGL6KAPzNxRevwcTzdpwNcLMOMhlLwXyrPU6V
 6tNd083OBIC2A5eNla8Iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M0Dk/YMuz7c=:IUWDLrYGko/tNXz+qU6nQI
 jZVHOZl82rxZg6FSEmW7jWXdBt/eWi8H07FeaW8l9m04d1ou9iKUFSADS+svGZn9nU14KLHxE
 1V6rQ9NdFbchSDw5P/n6zWRgthJQRTOtyCje1PV0+iH0kQQz+f6g2ejZvpiRA50suRtI3auMz
 yPh/hho2c1/BRTSKtDm5yhCN4rywKNibq2JK2qlVFYSJejtDDn8kBMVQ7Iq8Ahvj5zuvkmkB0
 eBY+4P8mLxrLyrzqwoMSdSS4IeBZDpztcjvyinbRE33l15aYUX1jNkKi/4IVS0Z7uvcCTei47
 hYXe0dc1zS4doMvH/eEYrpS7EHL8wBYUqaOgE4kcyXfAGrQggCrPcERRk5QtDnORuVOfm8pJw
 wGGgc9VMGjzbG0rCVEdun+RfI4VPbWB0v0KACAVwx+GXNBDv4qcxf0I16/SE1Nugu5tlbMVBd
 5W6OmeZ2NoTH8fKeBk3Sm9rrI0D2vq/VqoF7AsYQK3TyCWmFhi21eSpU+RbUSq5IC+VStSIB5
 OG6WQ3oPp5v1d/mzuqgTAGnb3vn/AkHDXLse8FqnV8zp1epDiRwtaFD3cHVu6q1ED1glLUgal
 Bf2oVZg/0hfe1aRfzRioSEmUHs0VFsNKUL86eEHVcRaz5X9UM0WF+Sh11caylfhK/lQRADvYQ
 8dNv4zJMnE+pFOCBakyDWt095bHylSGxXjcqWlgBmfUZd+tSKrC9DjJtT0D9N/kFKy5960eoB
 j27ouO84PXDQyKbIyTY/xoHvpYewWQs+BYklHBhNwjQfikHwg/JLK7lCtT+9JBZNb/hxwJQ78
 OO/p2eSYCHKqy3i8U1C+AowLogUmR8M5XKuiF+c1C6snbNNgOg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_addf() can be used with "%.*s" to add a buffer of a specific size
to a strbuf, but the resulting code is longer, may require casting the
length to int and is less efficient than simply calling strbuf_add().
Add Coccinelle rules for transforming calls of the former type to the
latter.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/strbuf.cocci | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 1d580e49b0..700a5f9c13 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -44,3 +44,15 @@ expression E1, E2;
 @@
 - strbuf_addstr(E1, real_path(E2));
 + strbuf_add_real_path(E1, E2);
+
+@@
+expression sb, buf, len;
+@@
+- strbuf_addf(sb, "%.*s", len, buf)
++ strbuf_add(sb, buf, len)
+
+@@
+expression sb, buf, len;
+@@
+- strbuf_addf(sb, "%.*s", (int)(len), buf)
++ strbuf_add(sb, buf, len)
-- 
2.14.2
