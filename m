Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3561FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbdBJLQl (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:41 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57449 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752886AbdBJLQh (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:37 -0500
X-AuditID: 1207440f-d47ff700000009a2-76-589da10ff942
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id BD.2C.02466.F01AD985; Fri, 10 Feb 2017 06:16:32 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLh025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:30 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/9] register_ref_store(): new function
Date:   Fri, 10 Feb 2017 12:16:14 +0100
Message-Id: <5569188834dd39bf40bcae034a8d23d21d31a7e9.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCuwcG6EwY0GVouuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJa/GjpYbbYvLmdxYHD4+/7D0weO2fdZff48DHOY8GmUo+u
        9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxoq+6awF14Urlu59zdjA+JS/i5GT
        Q0LAROLo97vsXYxcHEIClxklXp/6xAbhnGKSuLJxKyNIFZuArsSinmYmEFtEQE1iYtshFhCb
        GaTo3AKwuLCAlcSDH5OYQWwWAVWJVWtfsoLYvAJREv9vvGSE2CYncWnbF7AaTgELiX8nzoDZ
        QgLmEsdXHWWewMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZIyPHv
        YOxaL3OIUYCDUYmH90XNnAgh1sSy4srcQ4ySHExKorzfZ8yNEOJLyk+pzEgszogvKs1JLT7E
        KMHBrCTCa9MBlONNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfAyLABq
        FCxKTU+tSMvMKUFIM3FwggznARruCFLDW1yQmFucmQ6RP8WoKCXOWzcfKCEAksgozYPrhaWE
        V4ziQK8I8waCtPMA0wlc9yugwUxAg6+fngUyuCQRISXVwOgWsrulJi1L0nZTwyw1VdssYa7k
        oLaDsWyyYbrtwQ6FjzbPfb3E/pv5OzWXmofb5x0vTl6ePWdpkLIfX9w2q8/izVM++m6vKr/v
        x/6wfjrj64oqgTvB8dPmOBzoWVzXv/z8qhztD5qFm06s11xxc8bTQ0lxIiEz1L7wRK3TaSuS
        DBNf8XeqrBJLcUaioRZzUXEiAOtoIA7kAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the responsibility for registering the ref_store for a submodule
from base_ref_store_init() to a new function, register_ref_store(). Call
the latter from ref_store_init().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 6348414..d7158b6 100644
--- a/refs.c
+++ b/refs.c
@@ -1379,6 +1379,29 @@ static struct ref_store *lookup_ref_store(const char *submodule)
 }
 
 /*
+ * Register the specified ref_store to be the one that should be used
+ * for submodule (or the main repository if submodule is NULL). It is
+ * a fatal error to call this function twice for the same submodule.
+ */
+static void register_ref_store(struct ref_store *refs, const char *submodule)
+{
+	if (!submodule) {
+		if (main_ref_store)
+			die("BUG: main_ref_store initialized twice");
+
+		refs->next = NULL;
+		main_ref_store = refs;
+	} else {
+		if (lookup_ref_store(submodule))
+			die("BUG: ref_store for submodule '%s' initialized twice",
+			    submodule);
+
+		refs->next = submodule_ref_stores;
+		submodule_ref_stores = refs;
+	}
+}
+
+/*
  * Create, record, and return a ref_store instance for the specified
  * submodule (or the main repository if submodule is NULL).
  */
@@ -1386,11 +1409,14 @@ static struct ref_store *ref_store_init(const char *submodule)
 {
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct ref_store *refs;
 
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	return be->init(submodule);
+	refs = be->init(submodule);
+	register_ref_store(refs, submodule);
+	return refs;
 }
 
 struct ref_store *get_ref_store(const char *submodule)
@@ -1423,22 +1449,11 @@ void base_ref_store_init(struct ref_store *refs,
 			 const char *submodule)
 {
 	refs->be = be;
-	if (!submodule) {
-		if (main_ref_store)
-			die("BUG: main_ref_store initialized twice");
 
+	if (!submodule)
 		refs->submodule = "";
-		refs->next = NULL;
-		main_ref_store = refs;
-	} else {
-		if (lookup_ref_store(submodule))
-			die("BUG: ref_store for submodule '%s' initialized twice",
-			    submodule);
-
+	else
 		refs->submodule = xstrdup(submodule);
-		refs->next = submodule_ref_stores;
-		submodule_ref_stores = refs;
-	}
 }
 
 void assert_main_repository(struct ref_store *refs, const char *caller)
-- 
2.9.3

