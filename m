Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320BF1FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbdBJLQw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:52 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:46389 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752921AbdBJLQu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:50 -0500
X-AuditID: 12074411-fa3ff700000009b7-48-589da10eb4fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 20.C1.02487.E01AD985; Fri, 10 Feb 2017 06:16:30 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLg025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:28 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/9] refs: remove some unnecessary handling of submodule == ""
Date:   Fri, 10 Feb 2017 12:16:13 +0100
Message-Id: <c005d19654fd1aae2d542560911b2a92437b89fe.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqMu3cG6EQd9kXYuuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJa/GjpYbbYvLmdxYHD4+/7D0weO2fdZff48DHOY8GmUo+u
        9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxtwV7ewFJ/kq5nzcztjA+Iq7i5GT
        Q0LAROLSxsvsXYxcHEIClxkltn6bzgLhnGKSOHXtHwtIFZuArsSinmYmEFtEQE1iYtshsDgz
        SNG5BWBxYYFAiSfX5gLFOThYBFQlrrwPAwnzCkRJTPrTwQqxTE7i0rYvzCA2p4CFxL8TZ8Bs
        IQFzieOrjjJPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMk4AR3
        MM44KXeIUYCDUYmH90XNnAgh1sSy4srcQ4ySHExKorzfZ8yNEOJLyk+pzEgszogvKs1JLT7E
        KMHBrCTCa9MBlONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBGLwBq
        FCxKTU+tSMvMKUFIM3FwggznARrODlLDW1yQmFucmQ6RP8WoKCXOWzcfKCEAksgozYPrhSWE
        V4ziQK8I8waCtPMAkwlc9yugwUxAg6+fngUyuCQRISXVwBhgJsY+8bO2W5hdo+si/99lE7vk
        p/R/lj7bvfJPqvmZzT9KmpP9z6aLGlqGb/uQOefmIdfPjumHBarFZHkzmBcm3zDoOvAl9UDc
        lktbDimXaa2dHxko4Vu98PSftKxuz2Mbdm6+uPvSrmmP7Y5HHT4/2amk+qSR4M/KKQ1W903C
        9pzL5Xqxo1qJpTgj0VCLuag4EQDWuO9l4wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only external entry point to the ref_store lookup functions is
get_ref_store(), which ensures that submodule == "" is passed along as
NULL. So ref_store_init() and lookup_ref_store() don't have to handle
submodule being specified as the empty string.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index d7265cc..6348414 100644
--- a/refs.c
+++ b/refs.c
@@ -1362,15 +1362,12 @@ static struct ref_store *submodule_ref_stores;
  * Return the ref_store instance for the specified submodule (or the
  * main repository if submodule is NULL). If that ref_store hasn't
  * been initialized yet, return NULL.
- *
- * For backwards compatibility, submodule=="" is treated the same as
- * submodule==NULL.
  */
 static struct ref_store *lookup_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
 
-	if (!submodule || !*submodule)
+	if (!submodule)
 		return main_ref_store;
 
 	for (refs = submodule_ref_stores; refs; refs = refs->next) {
@@ -1384,9 +1381,6 @@ static struct ref_store *lookup_ref_store(const char *submodule)
 /*
  * Create, record, and return a ref_store instance for the specified
  * submodule (or the main repository if submodule is NULL).
- *
- * For backwards compatibility, submodule=="" is treated the same as
- * submodule==NULL.
  */
 static struct ref_store *ref_store_init(const char *submodule)
 {
@@ -1396,10 +1390,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	if (!submodule || !*submodule)
-		return be->init(NULL);
-	else
-		return be->init(submodule);
+	return be->init(submodule);
 }
 
 struct ref_store *get_ref_store(const char *submodule)
-- 
2.9.3

