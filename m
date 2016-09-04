Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236C01F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754421AbcIDQL5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:11:57 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61523 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754367AbcIDQLw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:52 -0400
X-AuditID: 12074413-aa3ff70000000955-a2-57cc4757e819
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id AA.21.02389.7574CC75; Sun,  4 Sep 2016 12:10:00 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5v026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:57 -0400
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
Subject: [PATCH v2 35/38] refs: add methods to init refs db
Date:   Sun,  4 Sep 2016 18:08:41 +0200
Message-Id: <2bf161a94fa06317c95c5336ec384c7a7d262741.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqBvhfibc4M80ZYv5m04wWnRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li5lVrizNvGhkdOD3+vv/A5LFz1l12j672I2we
        z3r3MHpcvKTssX/pNjaPxQ+8PBY8v8/u8XmTXABnFJdNSmpOZllqkb5dAlfGmYYGtoLLyhXL
        T7o0MM6S7WLk5JAQMJG49f0aYxcjF4eQwFZGieN3zrNAOCeZJPqmHWECqWIT0JVY1NMMZosI
        qElMbDsEVsQs8JtJ4sLW5+wgCWEBa4lPMy8ydzFycLAIqEp03lYBCfMKREnMODWLEWKbnMSl
        bV+YQWxOAQuJM7vngpULCZhLtL/InsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrle
        bmaJXmpK6SZGSAgK72DcdVLuEKMAB6MSD+8E3TPhQqyJZcWVuYcYJTmYlER5Zx08GS7El5Sf
        UpmRWJwRX1Sak1p8iFGCg1lJhFfbBaicNyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUg
        tQgmK8PBoSTBe8ENqFGwKDU9tSItM6cEIc3EwQkynAdoeB9IDW9xQWJucWY6RP4Uo6KUOO9L
        V6CEAEgiozQPrheWIl4xigO9IsybANLOA0wvcN2vgAYzAQ1et/s0yOCSRISUVAOjQYzPxZXX
        ji6xiPY9fkrvXMH175Ma+Z6WLurs9bXxOZqzuH7jv+qLNV3hbosYtrtvWH9ijurz0GtyfOoc
        Pj/n7UnNXFd736bH54ZV3sUtqbJNXA7/zCW/9V/K+OFbljlvyhqG2tnK9hVeFwUP1R7MZ5B9
        vCgtpCv/550X0xuTc9YXt+pv/75IiaU4I9FQi7moOBEAP2UsvewCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Alternate refs backends might not need the refs/heads directory and so
on, so we make ref db initialization part of the backend.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/init-db.c    | 21 +++++++++++----------
 refs.c               |  8 ++++++++
 refs.h               |  2 ++
 refs/files-backend.c | 18 ++++++++++++++++++
 refs/refs-internal.h |  3 +++
 5 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 3a45f0b..80192f6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -180,13 +180,7 @@ static int create_default_files(const char *template_path)
 	char junk[2];
 	int reinit;
 	int filemode;
-
-	/*
-	 * Create .git/refs/{heads,tags}
-	 */
-	safe_create_dir(git_path_buf(&buf, "refs"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/heads"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/tags"), 1);
+	struct strbuf err = STRBUF_INIT;
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -210,12 +204,19 @@ static int create_default_files(const char *template_path)
 	 */
 	if (get_shared_repository()) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path_buf(&buf, "refs"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
 	}
 
 	/*
+	 * We need to create a "refs" dir in any case so that older
+	 * versions of git can tell that this is a repository.
+	 */
+	safe_create_dir(git_path("refs"), 1);
+	adjust_shared_perm(git_path("refs"));
+
+	if (refs_init_db(&err))
+		die("failed to set up refs db: %s", err.buf);
+
+	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
diff --git a/refs.c b/refs.c
index 6efa859..fcaf3ba 100644
--- a/refs.c
+++ b/refs.c
@@ -1292,6 +1292,14 @@ static const char *resolve_ref_recursively(struct ref_store *refs,
 	return NULL;
 }
 
+/* backend functions */
+int refs_init_db(struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->init_db(refs, err);
+}
+
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
diff --git a/refs.h b/refs.h
index 17e8cfb..d42458c 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,8 @@ int ref_exists(const char *refname);
 
 int is_branch(const char *refname);
 
+extern int refs_init_db(struct strbuf *err);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bcaa958..56397af 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4068,10 +4068,28 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	return -1;
 }
 
+static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "init_db");
+
+	/*
+	 * Create .git/refs/{heads,tags}
+	 */
+	safe_create_dir(git_path("refs/heads"), 1);
+	safe_create_dir(git_path("refs/tags"), 1);
+	if (get_shared_repository()) {
+		adjust_shared_perm(git_path("refs/heads"));
+		adjust_shared_perm(git_path("refs/tags"));
+	}
+	return 0;
+}
+
 struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_ref_store_create,
+	files_init_db,
 	files_transaction_commit,
 	files_initial_transaction_commit,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ade6501..b3a2095 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -479,6 +479,8 @@ struct ref_store;
  */
 typedef struct ref_store *ref_store_init_fn(const char *submodule);
 
+typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
+
 typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
@@ -583,6 +585,7 @@ struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_store_init_fn *init;
+	ref_init_db_fn *init_db;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
 
-- 
2.9.3

