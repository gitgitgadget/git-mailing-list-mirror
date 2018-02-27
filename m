Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B931F576
	for <e@80x24.org>; Tue, 27 Feb 2018 09:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeB0J7t (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 04:59:49 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39839 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbeB0J7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 04:59:12 -0500
Received: by mail-pl0-f66.google.com with SMTP id s13so11067973plq.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 01:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bd4J24K3WVQwx4mEQp1vlMA+9oz/wVRsgF61Rm0uKLw=;
        b=eloclKJTg1mqSyNkyMUsMg1MS6rsp7tCkPD6OZDo5U4morx9COBzGgUVlQT0HqYftQ
         q1CwtByapwe6UVlZnuXf79dc0Xg1GywZPV0XM2RxC8Hf48ZUM/w9olNXQnDtmmKRAki4
         KFpiCJxHPNihhTLuSqBEtI1UBjSmK7zFu8tTR3kcnxBi6LW2XVGCuXHtjVHTw43zlzDZ
         KBPnEqL4o7XBugx1o5IV/9ijOWgv3oHqwrtgpqD9RnP0osVf5eUwz1PUlQ5SDWoE6nWd
         SZnKV9fwMkAQpSxlHgecvQihE6cRMpCNH8N6bwf7/SmF12E3hzu2QL+kdJB4XroJVl4J
         zjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bd4J24K3WVQwx4mEQp1vlMA+9oz/wVRsgF61Rm0uKLw=;
        b=JnHxjWm7eRZ1jc1hZmhina0ldd6WmpHP0U/z31aEQs2kK1KV6+eegcJKp4lZoH7V0f
         nmYd/rOTzgYre0usQYiPmgLFVe2ol65fjeysUnSy2xna8LDXSGI6bue4iuADzJHYo+ZB
         K13y+nM/CUiu2r7qskJMuaPYQqdidFKplKV+NHUubB4nAfzqAGXLcMni9QG8sgOdCOyQ
         kimz3Opo45jjnNRyAMKs0NgXCSkXRJOcsGHF4KfGRFyvnV0ePZu6a8RLGY44WH8iLcoO
         BpLUqHpQFJJ6bwYo+3P5hfNLlCMA2ijkrsBKUwhIJxps7nBlC+/x3j+513cD8RyExnMy
         Wn7w==
X-Gm-Message-State: APf1xPCygRDjiUjMfBnPWN11XX/awDL09d1Sfp4Zmb37pYpLfoHEngzZ
        r4HhQrZN6UsY9i55lQ+TVc5vNQ==
X-Google-Smtp-Source: AH8x227p+E6e0cGt+3UlCwIP9iyVjcqdbIlziol1b9OCiGvCiKVOTM1dvznz9XnWu3TNfJM71uwW6w==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4-v6mr13800107plb.338.1519725551625;
        Tue, 27 Feb 2018 01:59:11 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w3sm24624282pfw.30.2018.02.27.01.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 01:59:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:59:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 3/4] sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
Date:   Tue, 27 Feb 2018 16:58:45 +0700
Message-Id: <20180227095846.9238-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180227095846.9238-1-pclouds@gmail.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
 <20180227095846.9238-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

getenv() is supposed to work on the main repository only. This delayed
getenv() code in sha1_file.c makes it more difficult to convert
sha1_file.c to a generic object store that could be used by both
submodule and main repositories.

Move the getenv() back in setup_git_env() where other env vars are
also fetched.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 environment.c  | 1 +
 object-store.h | 5 ++++-
 object.c       | 1 +
 repository.c   | 2 ++
 repository.h   | 1 +
 sha1_file.c    | 6 +-----
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/environment.c b/environment.c
index 74a2900ddf..47c6e31559 100644
--- a/environment.c
+++ b/environment.c
@@ -174,6 +174,7 @@ void setup_git_env(const char *git_dir)
 	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	repo_set_gitdir(the_repository, git_dir, &args);
 	argv_array_clear(&to_free);
 
diff --git a/object-store.h b/object-store.h
index afe2f93459..9b1303549b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -87,6 +87,9 @@ struct raw_object_store {
 	 */
 	char *objectdir;
 
+	/* Path to extra alternate object database if not NULL */
+	char *alternate_db;
+
 	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
@@ -109,7 +112,7 @@ struct raw_object_store {
 	unsigned packed_git_initialized : 1;
 };
 
-#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
+#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/object.c b/object.c
index a7c238339b..5317cfc390 100644
--- a/object.c
+++ b/object.c
@@ -464,6 +464,7 @@ static void free_alt_odbs(struct raw_object_store *o)
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->objectdir);
+	FREE_AND_NULL(o->alternate_db);
 
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
diff --git a/repository.c b/repository.c
index 7654b8ada9..e326f0fcbc 100644
--- a/repository.c
+++ b/repository.c
@@ -61,6 +61,8 @@ void repo_set_gitdir(struct repository *repo,
 	repo_set_commondir(repo, o->shared_root);
 	expand_base_dir(&repo->objects.objectdir, o->object_dir,
 			repo->commondir, "objects");
+	free(repo->objects.alternate_db);
+	repo->objects.alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,
diff --git a/repository.h b/repository.h
index b5b5d138aa..b1da2a6384 100644
--- a/repository.h
+++ b/repository.h
@@ -94,6 +94,7 @@ struct set_gitdir_args {
 	const char *object_dir;
 	const char *graft_file;
 	const char *index_file;
+	const char *alternate_db;
 };
 
 extern void repo_set_gitdir(struct repository *repo,
diff --git a/sha1_file.c b/sha1_file.c
index dfc8deec38..ad1cd441e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -673,15 +673,11 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 
 void prepare_alt_odb(struct repository *r)
 {
-	const char *alt;
-
 	if (r->objects.alt_odb_tail)
 		return;
 
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
-
 	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
-	link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(r, r->objects.alternate_db, PATH_SEP, NULL, 0);
 
 	read_info_alternates(r, r->objects.objectdir, 0);
 }
-- 
2.16.1.435.g8f24da2e1a

