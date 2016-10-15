Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A2C209A9
	for <e@80x24.org>; Sat, 15 Oct 2016 08:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbcJOI1p (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 04:27:45 -0400
Received: from mout.web.de ([217.72.192.78]:55926 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753038AbcJOI1j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 04:27:39 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MWRzK-1cSmYT2xZa-00XbqK; Sat, 15 Oct 2016 10:25:39
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] cocci: avoid self-references in object_id transformations
Message-ID: <a5ed26c0-7fea-259c-74c1-0cd870a35290@web.de>
Date:   Sat, 15 Oct 2016 10:25:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZEijRmUU7wU5Tas+NEYf8DJqIYDH7mPwNiJsV2bWNcKwlOeqytr
 zlQ1tDXggz8Y2IVgDWngE8vM2gx0roRvxV7ydqhts4irZ3aDBgG+0BSp+u82PbDX3YUNyDd
 z4/zeoGoApPfaLg2kuzMUb+cBHuLgFUCaH97D4TQO/af98OMhpRcwL0t4dFw0xS4vYgxbh0
 5khpwnCL3auISj3VdJrng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UU9uNmmrfB4=:fUksZ4N0N4BCgi9NBMcyky
 eLKX4tX5EqZCsRsoHf6TtckBeZ5hcenWNSsCHNQW+jGyoB2II3uJGFs+v7Q8gY1jm1aMCoK+T
 Cbz5/43A4VQ5wM7XKQXkDIdglyrpnmv0G20EwhkQubrn0RyYVUSDg6MmEn2W7VW5SypdtLPtQ
 pQwW1eogDeBtCUKdKCScq7lylff38GjZZjtaQFrdkRtOsSehuTdpNkrb0T4xr0U2Sq9GRcvQ3
 T4KXdleEeLDOXJ7NzkMETvzXUDaQ5kX9n6QXrseE7kFXwsTU7XynrvO5TOW+3GeatKMRVO0Tu
 uuFOrJXSIsWZ/2gdzjIAxFY9MkCl89bXuaC7C6oRLGkRnBqd3Vyjt1J68ICgM/88DZ3TTYdKp
 UEEnWX++OMXBjVuH1Xfpda/4LIp6Z6CvP58n7oHD+lB2WhqmdTN+5jJSZ3FrRmu1rVmFW/HfT
 YkMe2DHdSSUzb0iBCEDA+JRgNCeKZ72kFne2GVG1W3DiljzkaBrjtoI0Ebdk3lPlvJNb+2UUF
 7KDztQMHF/FK+v8vmdeXB0QDHnYB4UXW5hY93GUpFQYcb6YZg6mUnTfaOtecljiF26hcrSIeR
 MVzFsguiquxm/nb0FV8Z0t+zSLrPJezdQthtu3qFTGxy2uukkMoMrVKk7gNmWppgRJmZWsapB
 fv+U2oEfkSfSqk0cC8dqgAoU5MwkXeBXBpfOiVpwYhEkspsD/y1r/oQL+WptjVVfvb53RqmOW
 2dtIQZDsa/TgWfuOazyVAf7iOiBm/80/GxTtlJ3FeOkOtth0zDv6vMYgRfpKsGvoQ9LAFxKyj
 e0AAgAM
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

We can remove the added guards once the object_id functions stand on
their own.

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
2.10.1

