Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390ACC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021CF2084D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="h+9Kk13L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgAPClA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43194 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgAPCk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:40:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so17792883qke.10
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLfrKxTEYFKcGXRIFTaPIJJCPaI4tCMwoQmhUAGlnVA=;
        b=h+9Kk13L3LHB2ui6r68mAEdW6Og1zQ3gz0+nQGfSAd7OQqzGrcXzZnDKy6J4HOk3RL
         2KaUF6FEka6LXs0T+f41+tw2dirfNnYcGbioqFK2J0f/1p7xwHbyCH31f6RCIAV1Y9ga
         bb7z6Tcd9UWR7Gb2zGgQt4988zN3fJgppsd7xXvX/NAXSQ95pJ9PpFP83Edg16QAmcxJ
         t/3DM2mXiFp+8IeE1YxZ9vmBrT95A+uKcoJA6xFMWJJPyeg4Dby70TtBVdMZoluzVUKt
         wJrKuhLNYgeyjIU4w0CSmlWSNtrEmMXhwuTSZqFjKYja7K6wBbG9fKIuGMQCLDFTNJdD
         BAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLfrKxTEYFKcGXRIFTaPIJJCPaI4tCMwoQmhUAGlnVA=;
        b=LUd5xqjYMms8bF/g9fAvVxLTLflC2xwZF3MpxKvzadjI1kJhmkSM7DDGJvrnrTs6+Q
         KGKgufYQ9tW4+8bzHYtfb2A5Dv9CNlaquXs+j4+IYRyV6fuidAuo148EAVgkucNlLgRm
         WSOtLuOmbt7/VFJJ0EOTqCUvVtO/EbZ7Pr+RmPEgC5yhaaM1Fx0EyQpJzPCxIBsHna09
         Wr0lpUiDuw7JgvHztjS4Ph8M80zkwtZAke6z5Gl2wHEX6ypRk/7iB9NlQpBJx3+ju2lv
         rbvQ00PIk47JGe2KZZUYF4VuDBlQTIiBPMWs0Ud4Z+iuP1HSuBo0bzspB0edDI5gt7Af
         Mhlw==
X-Gm-Message-State: APjAAAW256rEH3SfMkEqJRsrZIXCw0JwQOePQfCKC1js07fuUD7HNO4R
        AgUzM7xhvuxzTQg76/rUtLTvOAIvY/Y=
X-Google-Smtp-Source: APXvYqysC794Xui5djfPhFhoy7xNV6xN3VXeqRPnodmKsUeXAJNhFTkG3nk69/41SB81Ys8SPpE0kw==
X-Received: by 2002:a05:620a:25d:: with SMTP id q29mr29428249qkn.158.1579142457515;
        Wed, 15 Jan 2020 18:40:57 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:40:56 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH v3 06/12] grep: replace grep_read_mutex by internal obj read lock
Date:   Wed, 15 Jan 2020 23:39:54 -0300
Message-Id: <fc1200bb07f749420dad044d39dfe30ae73ad640.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
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
index 91fc032a32..4a436d6c99 100644
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
index c028f70aba..13232a904a 100644
--- a/grep.c
+++ b/grep.c
@@ -1540,11 +1540,6 @@ static inline void grep_attr_unlock(void)
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
@@ -1741,13 +1736,20 @@ static int fill_textconv_grep(struct repository *r,
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
@@ -1813,12 +1815,15 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		grep_source_load_driver(gs, opt->repo->index);
 		/*
 		 * We might set up the shared textconv cache data here, which
-		 * is not thread-safe.
+		 * is not thread-safe. Also, get_oid_with_context() and
+		 * parse_object() might be internally called. As they are not
+		 * currenty thread-safe and might be racy with object reading,
+		 * obj_read_lock() must be called.
 		 */
 		grep_attr_lock();
-		grep_read_lock();
+		obj_read_lock();
 		textconv = userdiff_get_textconv(opt->repo, gs->driver);
-		grep_read_unlock();
+		obj_read_unlock();
 		grep_attr_unlock();
 	}
 
@@ -2118,10 +2123,7 @@ static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
 
-	grep_read_lock();
 	gs->buf = read_object_file(gs->identifier, &type, &gs->size);
-	grep_read_unlock();
-
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
@@ -2186,11 +2188,8 @@ void grep_source_load_driver(struct grep_source *gs,
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
index 811fd274c9..9115db8515 100644
--- a/grep.h
+++ b/grep.h
@@ -220,18 +220,5 @@ int grep_threads_ok(const struct grep_opt *opt);
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
2.24.1

