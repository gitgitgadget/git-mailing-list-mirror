Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321AF1FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdBJLQh (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:37 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752639AbdBJLQg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:36 -0500
X-AuditID: 1207440d-97fff70000000a35-8a-589da10cad98
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 23.1C.02613.C01AD985; Fri, 10 Feb 2017 06:16:28 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLf025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:26 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/9] refs: make some ref_store lookup functions private
Date:   Fri, 10 Feb 2017 12:16:12 +0100
Message-Id: <439c55a57aee7bd5c34c1a39cefcf35daab78f62.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqMuzcG6EwfEjMhZdV7qZLBp6rzBb
        9C/vYrO4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+7x4WOcx4JNpR5d
        7UfYPJ717mH0uHhJ2ePzJrkAjigum5TUnMyy1CJ9uwSujDWdJ5kLfopWfD5znrGB8aNgFyMn
        h4SAicSn3e1sXYxcHEIClxkl7n1ZygzhnGKSOLvlPhNIFZuArsSinmYwW0RATWJi2yEWEJsZ
        pOjcArC4sICXxO9Vx1lBbBYBVYmtF1vB4rwCURLTl55jhNgmJ3Fp2xdmEJtTwELi34kzYLaQ
        gLnE8VVHmScw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJyvDsY
        /6+TOcQowMGoxMP7omZOhBBrYllxZe4hRkkOJiVR3u8z5kYI8SXlp1RmJBZnxBeV5qQWH2KU
        4GBWEuG16QDK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeBkWADUK
        FqWmp1akZeaUIKSZODhBhvMADWcHqeEtLkjMLc5Mh8ifYlSUEuetmw+UEABJZJTmwfXCUsIr
        RnGgV4R5xUDaeYDpBK77FdBgJqDB10/PAhlckoiQkmpgdHgpwFX1+Ivn7BLLPVNWh5U93B5v
        qCawQvv108pl3oViF8NmyEy8wT3Fs9ftpGi2rspOL4V5Igbf1rDb2fxJi2Ngv8LzbE11Zn/F
        u4SQ0IQb88SSnhR3n1jx47Fp4tLrl7n2O8os/8xUmvrlcOrXdYpfZrMYmPB9/hQjOvvZ801p
        1h+v8dY0K7EUZyQaajEXFScCADC3InnkAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following functions currently don't need to be exposed:

* ref_store_init()
* lookup_ref_store()

That might change in the future, but for now make them private.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 19 +++++++++++++++++--
 refs/refs-internal.h | 19 -------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 707092f..d7265cc 100644
--- a/refs.c
+++ b/refs.c
@@ -1358,7 +1358,15 @@ static struct ref_store *main_ref_store;
 /* A linked list of ref_stores for submodules: */
 static struct ref_store *submodule_ref_stores;
 
-struct ref_store *lookup_ref_store(const char *submodule)
+/*
+ * Return the ref_store instance for the specified submodule (or the
+ * main repository if submodule is NULL). If that ref_store hasn't
+ * been initialized yet, return NULL.
+ *
+ * For backwards compatibility, submodule=="" is treated the same as
+ * submodule==NULL.
+ */
+static struct ref_store *lookup_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
 
@@ -1373,7 +1381,14 @@ struct ref_store *lookup_ref_store(const char *submodule)
 	return NULL;
 }
 
-struct ref_store *ref_store_init(const char *submodule)
+/*
+ * Create, record, and return a ref_store instance for the specified
+ * submodule (or the main repository if submodule is NULL).
+ *
+ * For backwards compatibility, submodule=="" is treated the same as
+ * submodule==NULL.
+ */
+static struct ref_store *ref_store_init(const char *submodule)
 {
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 708b260..d8a7eb1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -653,25 +653,6 @@ void base_ref_store_init(struct ref_store *refs,
 			 const char *submodule);
 
 /*
- * Create, record, and return a ref_store instance for the specified
- * submodule (or the main repository if submodule is NULL).
- *
- * For backwards compatibility, submodule=="" is treated the same as
- * submodule==NULL.
- */
-struct ref_store *ref_store_init(const char *submodule);
-
-/*
- * Return the ref_store instance for the specified submodule (or the
- * main repository if submodule is NULL). If that ref_store hasn't
- * been initialized yet, return NULL.
- *
- * For backwards compatibility, submodule=="" is treated the same as
- * submodule==NULL.
- */
-struct ref_store *lookup_ref_store(const char *submodule);
-
-/*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
  * a submodule, the submodule must exist and be a nonbare repository,
-- 
2.9.3

