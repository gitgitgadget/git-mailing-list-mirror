Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7431F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbcIDQMS (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:18 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55325 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754339AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 12074414-ca3ff70000000931-53-57cc4759e9b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 7A.9A.02353.9574CC75; Sun,  4 Sep 2016 12:10:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5w026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 36/38] refs: add method to rename refs
Date:   Sun,  4 Sep 2016 18:08:42 +0200
Message-Id: <596373545ace1cf29cc4f2c76db9299dc99deb9e.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqBvpfibcoH+FvMX8TScYLbqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2wx86q1xZk3jYwOnB5/339g8tg56y67R1f7ETaP
        Z717GD0uXlL22L90G5vH4gdeHgue32f3+LxJLoAzissmJTUnsyy1SN8ugSuj49pR9oKrMhXN
        /y6zNzDuFu9i5OCQEDCR6FkW18XIxSEksJVR4urh16wQzkkmid/tPexdjJwcbAK6Eot6mplA
        bBEBNYmJbYdYQIqYBX4zSVzY+hysSFjAUmLehUuMIFNZBFQlFnazgYR5BaIkPnevBOuVEJCT
        uLTtCzOIzSlgIXFm91xmkHIhAXOJ9hfZExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3S
        tdDLzSzRS00p3cQICUGRHYxHTsodYhTgYFTi4bXQPhMuxJpYVlyZe4hRkoNJSZR31sGT4UJ8
        SfkplRmJxRnxRaU5qcWHGCU4mJVEeLVdgMp5UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGan
        phakFsFkZTg4lCR4r7sCNQoWpaanVqRl5pQgpJk4OEGG8wANvwlSw1tckJhbnJkOkT/FqCgl
        zvsSJCEAksgozYPrhaWIV4ziQK8I8ya4AVXxANMLXPcroMFMQIPX7T4NMrgkESEl1cBoXbOB
        be90Ya4ZWsv8rwoEdK9jfnu2bZqFbz7XoQ+mE5f+3N9tvWONScnU1/Pfi/3av3u3tWKZ+/Jw
        1lwPxj0NhScb3nikhrx4va2LZV1+qp9u/4efph2iWQbMnFf5T7m/9chmYfIXkJvx/m1HhX6V
        6Rl57jnHFwfVfN8oILhixapHWW6GZolKLMUZiYZazEXFiQBwevrQ7AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

This removes the last caller of function get_files_ref_store(), so
remove it.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               |  7 +++++++
 refs/files-backend.c | 24 ++++++------------------
 refs/refs-internal.h |  4 ++++
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index fcaf3ba..113e3c8 100644
--- a/refs.c
+++ b/refs.c
@@ -1547,3 +1547,10 @@ int delete_refs(struct string_list *refnames, unsigned int flags)
 
 	return refs->be->delete_refs(refs, refnames, flags);
 }
+
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->rename_ref(refs, oldref, newref, logmsg);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 56397af..7cc4191 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -997,22 +997,6 @@ static struct files_ref_store *files_downcast(
 	return (struct files_ref_store *)ref_store;
 }
 
-/*
- * Return a pointer to the reference store for the specified
- * submodule. For the main repository, use submodule==NULL; such a
- * call cannot fail. For a submodule, the submodule must exist and be
- * a nonbare repository, otherwise return NULL. Verify that the
- * reference store is a files_ref_store, and cast it to that type
- * before returning it.
- */
-static struct files_ref_store *get_files_ref_store(const char *submodule,
-						   const char *caller)
-{
-	struct ref_store *refs = get_ref_store(submodule);
-
-	return refs ? files_downcast(refs, 1, caller) : NULL;
-}
-
 /* The length of a peeled reference line in packed-refs, including EOL: */
 #define PEELED_LINE_LENGTH 42
 
@@ -2580,9 +2564,12 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(struct ref_store *ref_store,
+			    const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
-	struct files_ref_store *refs = get_files_ref_store(NULL, "rename_ref");
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -4097,6 +4084,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b3a2095..c598cb1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -494,6 +494,9 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *logmsg);
 typedef int delete_refs_fn(struct ref_store *ref_store,
 			   struct string_list *refnames, unsigned int flags);
+typedef int rename_ref_fn(struct ref_store *ref_store,
+			  const char *oldref, const char *newref,
+			  const char *logmsg);
 
 /*
  * Iterate over the references in the specified ref_store that are
@@ -593,6 +596,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
+	rename_ref_fn *rename_ref;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
-- 
2.9.3

