Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9122D2018D
	for <e@80x24.org>; Thu, 11 May 2017 13:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbdEKNur (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:50:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:62824 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbdEKNuo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:50:44 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOkQc-1d3sWu2ml4-0063GR; Thu, 11
 May 2017 15:50:22 +0200
Date:   Thu, 11 May 2017 15:50:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] compat/regex: fix compilation on Windows
Message-ID: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:A/ADwkQzX6/+CKq/kLoodju+dtl7nqdrN60mZl1NQYp2VmiJT1l
 dC0v354vr0nDxJchBuhvAlpA0B9mvH3/VztN7IGV9YkX1GNvo0GI4fFDFrmRdk5pOgHVf2V
 CHLLEr+CXRovku6mH3mcVaKCSoTUFUvIaJ9WubgSR4jUVgCB9vz0qRFqf0jurPvtRou6F4Z
 XEH4MY7JPQpsHfTjAIKOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rc/Ji36bMTE=:zEjfrL8x4pvOPjobqdwkhQ
 FBiLTmkxjibAlnHOl96HlbxPBGTEzTt2zFEQS0po6rbDTaurd/NdQP7rsJAUzeAIDbwJe2+nd
 KYTaA2wOv6WzyeXSV7cEekihaLunuj67QzYJiprnLcWUWhB/Htn7M+3hNKJ49siJPQCvE8+KH
 k1ED7TKSgtXbYyU40Xgc34WitZ8IwNwehN1PM3u+fRaJcAu6P5JVhHrTeN+6zbUNMGs8xi/jZ
 mhhidPDcjnxjqRbTUc0U7MPcQGDt7+7sUA//dj2a/dnsOcHcY2ihoXcqwaRjNlQZKxpdNQJjS
 dKdlxWiY4x/PhBPgEvJKx2fTS5JDYhWC4Hd7HpZHigNZ3lr7bM3zPe2Q1HCtHtu/qN8JebSXI
 D9D3+sQ0p9D6ogML3neszZlP6AknS8/auUv+/WF5rL21nwG98kXKX3gZnhBHQ7Ckrx84nK4+j
 odiSgS2xEWe+okoe2GEQJo1uo9DEywl6sFpKI3+RNz3Q+xVe8ECibwz18jrxn7RmQPF8HttpM
 U2t0ikc/xHPsgBBuzFbYUlCxXaa2lmKwfcCedQOQXLW5qjx+QFks3EmAEUgoS8/a3FH115sal
 CbRtKZUDUlnJoDUazJqNzxmhrP5lvgzkFxjGMSlDFPg8FHcAhQAWnsRbTFxOC4BHFGJLB0BvS
 KtXnpGWUuyeQyG+r2108GBPCo17Q/BJdX9p+YEq3JmVm/ATXzUTphh0OrfJdG/jFGx87Yq9U/
 dgjl6UorID6nOX1PetTFXYysc9kCoxO+rrD1bc7Yjoyi/mMU0+o0E2T2yUGch4bhpQwO19X2b
 ThtQ00J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The real issue here is that GNU awk's regex implementation assumes a bit
too much about the relative sizes of pointers and long integers. What they
really want is to use intptr_t.

This patch recapitulates what 56a1a3ab449 (Silence GCC's "cast of pointer
to integer of a different size" warning, 2015-10-26) did to our previous
copy of GNU awk's regex engine.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/compat-regex-fixes-v1
Fetch-It-Via: git fetch https://github.com/dscho/git compat-regex-fixes-v1

 .../0003-Use-intptr_t-instead-of-long.patch        | 22 ++++++++++++++++++++++
 compat/regex/regcomp.c                             |  4 ++--
 2 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch

diff --git a/compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch b/compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch
new file mode 100644
index 00000000000..246ff256fb8
--- /dev/null
+++ b/compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch
@@ -0,0 +1,22 @@
+diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
+index 5e9ea26cd46..e6469167a80 100644
+--- a/compat/regex/regcomp.c
++++ b/compat/regex/regcomp.c
+@@ -2641,7 +2641,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
+     old_tree = NULL;
+ 
+   if (elem->token.type == SUBEXP)
+-    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
++    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
+ 
+   tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
+   if (BE (tree == NULL, 0))
+@@ -3868,7 +3868,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
+ static reg_errcode_t
+ mark_opt_subexp (void *extra, bin_tree_t *node)
+ {
+-  int idx = (int) (long) extra;
++  int idx = (int) (intptr_t) extra;
+   if (node->token.type == SUBEXP && node->token.opr.idx == idx)
+     node->token.opt_subexp = 1;
+ 
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 5e9ea26cd46..e6469167a80 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2641,7 +2641,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
     old_tree = NULL;
 
   if (elem->token.type == SUBEXP)
-    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
+    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
 
   tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
   if (BE (tree == NULL, 0))
@@ -3868,7 +3868,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
 static reg_errcode_t
 mark_opt_subexp (void *extra, bin_tree_t *node)
 {
-  int idx = (int) (long) extra;
+  int idx = (int) (intptr_t) extra;
   if (node->token.type == SUBEXP && node->token.opr.idx == idx)
     node->token.opt_subexp = 1;
 

base-commit: 4e23cefb4da69a2d884c2d5a303825f40008ca42
-- 
2.12.2.windows.2.800.gede8f145e06
