Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40ECC20193
	for <e@80x24.org>; Tue,  1 Nov 2016 08:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168063AbcKAItm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 04:49:42 -0400
Received: from mout.web.de ([212.227.15.4]:61801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168041AbcKAItj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 04:49:39 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0McWbQ-1cJ1dk2K00-00Hd68; Tue, 01 Nov 2016 09:49:16
 +0100
X-Mozilla-News-Host: news://news.gmane.org:119
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] cocci: avoid self-references in object_id
 transformations
Message-ID: <3d93136a-2cf4-de0a-e19f-b51cad1b40ec@web.de>
Date:   Tue, 1 Nov 2016 09:49:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:m46Naf1fbkwnoHCGBqxKbDWLBVXCEEBGRRNkNuUpAJZgKjQByXA
 bkkcJWyxWpM406xWqENeD4dnRC2UkyGO/s6TKAx+97CJo15rIK62sBeLtL2dy/SxIqsfj3a
 +E0MkgjVOeO6tYHLRXObGdXxIEvhQlQ6YaKvt1QgWLkLi5VT5qduabgiZ2HrQ23ERXCRpgT
 ASHAsddlM0lYzhfem2NGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I1MTPPwvpsw=:5lgat88ETIjtATl4+DdZ5c
 3PsXM5zpVvesqxCzm8Ku6vaB+bvbhKWws4bUFlv58OHDJl4nCk84mnuw3O5sXfBhU1leNRGP9
 ZPIT4zGg44v2AwZEcfeuozvHAReJcOvDwod1+zc2pqQ3IKRvVUnqBPAIFbGcpzNHzuxOMhi1i
 Q6KcWQMS6swNrAARNMwaEkukZrhPotr7PNZjYN9YTUFV0cQCRXuUIxFqyDHEKv0lw//6J6v84
 5leBJQojvPCxvV8PKMz6svIsNr75hQxBY5ix5VtGlgKl93UywdWFSBeaIzOY7gZGpmrrmsO3d
 H0Sii02Dx4cLwPKnCTQ/HNNUlelrcPKmuWoRNAs0b1QaCbCOiGiTzIoN9Omcw1yQJz1u1fFNP
 6a5RnzvWva2z0YciqlPdcOnZvFAoZoPDGETWqSgufxF2WYbK8n1aa/j5VgEsdH0tY+zkFJGze
 Er8sOYsXsyhqwu7tF2v1RKSMJK0ft33wF++AVC8eX8ZM0ggI9sL3qhkQlwiBGHpm3fqgjca4g
 Ke2OJ4WxFa2bPqv29pNyM00ItdEdsMUavi+RS2XsF1iD+Sf0L04U5kwFo9NcIQ0r0txt9Vhxg
 Ws2A6H6iFD/SllH5/c8YcADch6XgLIbjviH1Na45W+1nSi11H77rCKqpqUefAFPitq61eA2Rk
 UDtJd5LbnFRuL7lTVfHPnE2HcGJOI/QVFQ94swMjMf97JzDf0W1j98wRsqeshZaIc07CLZua9
 9EcCtPVJjKTkoCQusFDa4mTqcrDTyU+IKIcFebLnOb/OJk2C1j5zP0rKw/E3a+TraJNUNf6uB
 yvBOLjI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object_id functions oid_to_hex, oid_to_hex_r, oidclr, oidcmp, and
oidcpy are defined as wrappers of their legacy counterparts sha1_to_hex,
sha1_to_hex_r, hashclr, hashcmp, and hashcpy, respectively.  Make sure
that the Coccinelle transformations for converting legacy function calls
are not applied to these wrappers themselves, which would result in
tautological declarations.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/object_id.cocci | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 0307624..09afdbf 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -17,10 +17,13 @@ expression E1;
 + oid_to_hex(&E1)
 
 @@
+identifier f != oid_to_hex;
 expression E1;
 @@
+  f(...) {...
 - sha1_to_hex(E1->hash)
 + oid_to_hex(E1)
+  ...}
 
 @@
 expression E1, E2;
@@ -29,10 +32,13 @@ expression E1, E2;
 + oid_to_hex_r(E1, &E2)
 
 @@
+identifier f != oid_to_hex_r;
 expression E1, E2;
 @@
+   f(...) {...
 - sha1_to_hex_r(E1, E2->hash)
 + oid_to_hex_r(E1, E2)
+  ...}
 
 @@
 expression E1;
@@ -41,10 +47,13 @@ expression E1;
 + oidclr(&E1)
 
 @@
+identifier f != oidclr;
 expression E1;
 @@
+  f(...) {...
 - hashclr(E1->hash)
 + oidclr(E1)
+  ...}
 
 @@
 expression E1, E2;
@@ -53,10 +62,13 @@ expression E1, E2;
 + oidcmp(&E1, &E2)
 
 @@
+identifier f != oidcmp;
 expression E1, E2;
 @@
+  f(...) {...
 - hashcmp(E1->hash, E2->hash)
 + oidcmp(E1, E2)
+  ...}
 
 @@
 expression E1, E2;
@@ -77,10 +89,13 @@ expression E1, E2;
 + oidcpy(&E1, &E2)
 
 @@
+identifier f != oidcpy;
 expression E1, E2;
 @@
+  f(...) {...
 - hashcpy(E1->hash, E2->hash)
 + oidcpy(E1, E2)
+  ...}
 
 @@
 expression E1, E2;
-- 
2.10.2

