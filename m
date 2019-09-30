Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640181F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfI3Bve (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37431 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfI3Bve (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so6434764qkd.4
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCXLfX08GEjmLMIhE6ljGeSzKkdsW1qzo97krZsV1tE=;
        b=olhFkpZ9Dpy8H9ckaxqRoiaird5Nbu97mAdS9cNW95yg0p2LPsfkSr0tgnsfabPoc+
         wQSyl0sZWBIgTrBtoewJFodBEDiOxPS6KWJvIxZlqTy/O8dAsQyUQA4xIo9DgQtBsJWw
         IW3pRBAc1jWCS9DrmFefzz0AnLA1vq7dxQtBzZy5AHGDnyiEASMak2w/D51c4z59Y6hI
         C+Kx4tBk+HShlnnD1y9R/1jTEzBpWnlH1XBhqBV5Czv8Khc6eJ5UHAXaPo/LyGhUGkWT
         91a9eXjmwgVPByxmqb2WkO7uJ9bmdDhg39fxI43/XBUMi1ftzUpZL8uZkBJI8n8jwRyE
         S04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCXLfX08GEjmLMIhE6ljGeSzKkdsW1qzo97krZsV1tE=;
        b=qKM2jhlf7Lo6R9GPFiOtjvpyfKVWMcEDfupT4+TLnoYiRDi+pPzBC8CGM1CA/XuAiX
         YI0m+eR1MVvO4/iVSzNJDXQPnDWtAFi5WeHUppZYm3qQLphKhpYcDnp6XJzGGK9g0kEp
         IH+91+CVtOix0RAyWKtftIivgK6v6KiYRIDHKexZ5ZHldgs8OJvBBhZM8fmyld58A/zs
         K88+rzvc3zTuXUNaZxMZKQk5kFsYq4QoeDFulzM7xJed2rdrnLdKV6napeJOR8jSGUvx
         sMaAfQD2W0rBK+MxkmkmXEb9xcbggLadbNfm/AbQKh+lc7vUbkhTfNmWUFK4GUKJRNzU
         pCVQ==
X-Gm-Message-State: APjAAAUjheqfI9uUebI5RLgP6hLLhwWBYOZ4B7Xt9BihAtCFfFTkoto0
        e0xEwFRRUyMBfmI5BS8zBKdNniV1gcI=
X-Google-Smtp-Source: APXvYqyFENJtt8UMEpu0IiLhhrnv/N8EcYgJIeyDJmsbcWTDbMCylBUSmP5HTeoLtp7oLgUnmEb7iQ==
X-Received: by 2002:a37:af87:: with SMTP id y129mr15915368qke.98.1569808292530;
        Sun, 29 Sep 2019 18:51:32 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:32 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Stefan Beller <stefanbeller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH v2 06/11] grep: replace grep_read_mutex by internal obj read lock
Date:   Sun, 29 Sep 2019 22:50:52 -0300
Message-Id: <48b632d7a0278f4abb4f0b0390f316a631a9d0ef.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep uses 'grep_read_mutex' to protect its calls to object reading
operations. But these have their own internal lock now, which ensures a
better performance (allowing parallel access to more regions). So, let's
remove the former and, instead, activate the latter with
enable_obj_read_lock().

Sections that are currently protected by 'grep_read_mutex' but are not
internally protected by the object reading lock should be surrounded by
obj_read_lock() and obj_read_unlock(). These guarantee mutual exclusion
with object reading operations, keeping the current behavior and
avoiding race conditions. Namely, these places are:

  In grep.c:

  - fill_textconv() at fill_textconv_grep().
  - userdiff_get_textconv() at grep_source_1().

  In builtin/grep.c:

  - parse_object_or_die() and the submodule functions at
    grep_submodule().
  - deref_tag() and gitmodules_config_oid() at grep_objects().

If these functions become thread-safe, in the future, we might remove
the locking and probably get some speedup.

Note that some of the submodule functions will already be thread-safe
(or close to being thread-safe) with the internal object reading lock.
However, as some of them will require additional modifications to be
removed from the critical section, this will be done in its own patch.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 46 ++++++++++++++++------------------------------
 grep.c         | 39 +++++++++++++++++++--------------------
 grep.h         | 13 -------------
 3 files changed, 35 insertions(+), 63 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fa8b9996d1..5a404ee1db 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -200,12 +200,12 @@ static void start_threads(struct grep_opt *opt)
 	int i;
 
 	pthread_mutex_init(&grep_mutex, NULL);
-	pthread_mutex_init(&grep_read_mutex, NULL);
 	pthread_mutex_init(&grep_attr_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
 	grep_use_locks = 1;
+	enable_obj_read_lock();
 
 	for (i = 0; i < ARRAY_SIZE(todo); i++) {
 		strbuf_init(&todo[i].out, 0);
@@ -257,12 +257,12 @@ static int wait_all(void)
 	free(threads);
 
 	pthread_mutex_destroy(&grep_mutex);
-	pthread_mutex_destroy(&grep_read_mutex);
 	pthread_mutex_destroy(&grep_attr_mutex);
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
 	grep_use_locks = 0;
+	disable_obj_read_lock();
 
 	return hit;
 }
@@ -295,16 +295,6 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
-static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
-{
-	void *data;
-
-	grep_read_lock();
-	data = read_object_file(oid, type, size);
-	grep_read_unlock();
-	return data;
-}
-
 static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		     const char *filename, int tree_name_len,
 		     const char *path)
@@ -413,20 +403,20 @@ static int grep_submodule(struct grep_opt *opt,
 
 	/*
 	 * NEEDSWORK: submodules functions need to be protected because they
-	 * access the object store via config_from_gitmodules(): the latter
-	 * uses get_oid() which, for now, relies on the global the_repository
-	 * object.
+	 * call config_from_gitmodules(): the latter contains in its call stack
+	 * many thread-unsafe operations that are racy with object reading, such
+	 * as parse_object() and is_promisor_object().
 	 */
-	grep_read_lock();
+	obj_read_lock();
 	sub = submodule_from_path(superproject, &null_oid, path);
 
 	if (!is_submodule_active(superproject, path)) {
-		grep_read_unlock();
+		obj_read_unlock();
 		return 0;
 	}
 
 	if (repo_submodule_init(&subrepo, superproject, sub)) {
-		grep_read_unlock();
+		obj_read_unlock();
 		return 0;
 	}
 
@@ -443,7 +433,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * object.
 	 */
 	add_to_alternates_memory(subrepo.objects->odb->path);
-	grep_read_unlock();
+	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
 	subopt.repo = &subrepo;
@@ -455,13 +445,12 @@ static int grep_submodule(struct grep_opt *opt,
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
-		grep_read_lock();
+		obj_read_lock();
 		object = parse_object_or_die(oid, oid_to_hex(oid));
+		obj_read_unlock();
 		data = read_object_with_reference(&subrepo,
 						  &object->oid, tree_type,
 						  &size, NULL);
-		grep_read_unlock();
-
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&object->oid));
 
@@ -586,7 +575,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_oid_file(&entry.oid, &type, &size);
+			data = read_object_file(&entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(&entry.oid));
@@ -624,12 +613,9 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		struct strbuf base;
 		int hit, len;
 
-		grep_read_lock();
 		data = read_object_with_reference(opt->repo,
 						  &obj->oid, tree_type,
 						  &size, NULL);
-		grep_read_unlock();
-
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
 
@@ -659,17 +645,17 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
 
-		grep_read_lock();
+		obj_read_lock();
 		real_obj = deref_tag(opt->repo, list->objects[i].item,
 				     NULL, 0);
-		grep_read_unlock();
+		obj_read_unlock();
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
-			grep_read_lock();
+			obj_read_lock();
 			gitmodules_config_oid(&real_obj->oid);
-			grep_read_unlock();
+			obj_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
 				list->objects[i].path)) {
diff --git a/grep.c b/grep.c
index b29946def2..0ca400f7b6 100644
--- a/grep.c
+++ b/grep.c
@@ -1533,11 +1533,6 @@ static inline void grep_attr_unlock(void)
 		pthread_mutex_unlock(&grep_attr_mutex);
 }
 
-/*
- * Same as git_attr_mutex, but protecting the thread-unsafe object db access.
- */
-pthread_mutex_t grep_read_mutex;
-
 static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bol, char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
@@ -1734,13 +1729,20 @@ static int fill_textconv_grep(struct repository *r,
 	}
 
 	/*
-	 * fill_textconv is not remotely thread-safe; it may load objects
-	 * behind the scenes, and it modifies the global diff tempfile
-	 * structure.
+	 * fill_textconv is not remotely thread-safe; it modifies the global
+	 * diff tempfile structure, writes to the_repo's odb and might
+	 * internally call thread-unsafe functions such as the
+	 * prepare_packed_git() lazy-initializator. Because of the last two, we
+	 * must ensure mutual exclusion between this call and the object reading
+	 * API, thus we use obj_read_lock() here.
+	 *
+	 * TODO: allowing text conversion to run in parallel with object
+	 * reading operations might increase performance in the multithreaded
+	 * non-worktreee git-grep with --textconv.
 	 */
-	grep_read_lock();
+	obj_read_lock();
 	size = fill_textconv(r, driver, df, &buf);
-	grep_read_unlock();
+	obj_read_unlock();
 	free_filespec(df);
 
 	/*
@@ -1806,13 +1808,16 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		grep_source_load_driver(gs, opt->repo->index);
 		/*
 		 * We might set up the shared textconv cache data here, which
-		 * is not thread-safe.
+		 * is not thread-safe. Also, get_oid_with_context() and
+		 * parse_object() might be internally called. As they are not
+		 * currenty thread-safe and might be racy with object reading,
+		 * obj_read_lock() must be called.
 		 */
+		obj_read_lock();
 		grep_attr_lock();
-		grep_read_lock();
 		textconv = userdiff_get_textconv(opt->repo, gs->driver);
-		grep_read_unlock();
 		grep_attr_unlock();
+		obj_read_unlock();
 	}
 
 	/*
@@ -2111,10 +2116,7 @@ static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
 
-	grep_read_lock();
 	gs->buf = read_object_file(gs->identifier, &type, &gs->size);
-	grep_read_unlock();
-
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
@@ -2179,11 +2181,8 @@ void grep_source_load_driver(struct grep_source *gs,
 		return;
 
 	grep_attr_lock();
-	if (gs->path) {
-		grep_read_lock();
+	if (gs->path)
 		gs->driver = userdiff_find_by_path(istate, gs->path);
-		grep_read_unlock();
-	}
 	if (!gs->driver)
 		gs->driver = userdiff_find_by_name("default");
 	grep_attr_unlock();
diff --git a/grep.h b/grep.h
index 1875880f37..54bf3a1ed4 100644
--- a/grep.h
+++ b/grep.h
@@ -235,18 +235,5 @@ int grep_threads_ok(const struct grep_opt *opt);
  */
 extern int grep_use_locks;
 extern pthread_mutex_t grep_attr_mutex;
-extern pthread_mutex_t grep_read_mutex;
-
-static inline void grep_read_lock(void)
-{
-	if (grep_use_locks)
-		pthread_mutex_lock(&grep_read_mutex);
-}
-
-static inline void grep_read_unlock(void)
-{
-	if (grep_use_locks)
-		pthread_mutex_unlock(&grep_read_mutex);
-}
 
 #endif
-- 
2.23.0

