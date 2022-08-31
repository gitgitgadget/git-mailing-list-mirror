Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C0DECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiHaXTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiHaXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13785A00FB
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c7so13469769wrp.11
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5IEzgIiCsaeSKDz38WxSYB6++bcBbals46a+WKxg8Fw=;
        b=Wvm96l6zCgjmyP1VFDg+fB0cdtw7mZcTPqLTQ4OFOyHdV2kgssGKmOqG4Jm5yeUROi
         ulXkkM7ji1xv3ydnE6oml86hC9zsR3CTEgP0PrhbX0eOFjmZjXLN94YzL+N0upJCBkdG
         fp/XaifQ2a/O2kBCgNxmQtYMzDkzzjdCStVCmZZ7YLN78Ca5myLNbdqHIWi6HnFB+V8z
         BzxKwzAXtMuTwodDxNSeESvqkrdbUMj6Zd/2cQ/OIY/7W3CC1/y4FP1cOuBE69+OGiIC
         zY7LzeRmrviWi3YTQ9yYG9RlqBissDQMS2wAq1toH/hWPOSWNxbO649t3SiNaaNwitRV
         vQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5IEzgIiCsaeSKDz38WxSYB6++bcBbals46a+WKxg8Fw=;
        b=4B/MgpzzT60u8g98vzUdjsqr/SU3vp5qcWe8fgmVlQ8ze7SgVUDjpnAMO0ygOq+xLK
         5LQmyJfAKXOjGBu/uvcWnDtVvL3hKT+JtxzAvWPXfM4gYwOAtFYP88INTTRHtaWVSqpk
         c3kfCvaLe1QpPgIeQrlvRuTJxSgYWrsl/b0HUmNhHRj51x+MwdYLH3R12Ces/BAHzsrF
         gQxnBJjXWrzlO5T8xZkgvqg0wTGYTReeWJ6+QkJuZGET93MDHD4Jrw7x8vtIbwP5CPUW
         mbmxfpR8HTdEql4Vj56alzJPeS02CXYXY1canPCW4Vym3cSZscgzZLj1xzf7g/EdpC0w
         V5Lg==
X-Gm-Message-State: ACgBeo0yWF4QZIWoEnhwCyfDwAFRgsugxHhgK710cCaAFlczQ5eMpq7u
        RhXydmWYMQnvD8urlYwaE6xI/HP9HrbnmA==
X-Google-Smtp-Source: AA6agR51RT6QssIuccfNlGfFnK5n17+WKgiZkAnhPxBwTsAXsdS/pWuCn7Wug+Zs/74x9QhJqRN8HQ==
X-Received: by 2002:a05:6000:137b:b0:226:d465:c8a9 with SMTP id q27-20020a056000137b00b00226d465c8a9mr11450591wrz.267.1661987908484;
        Wed, 31 Aug 2022 16:18:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/33] submodule--helper style: add \n\n after variable declarations
Date:   Thu,  1 Sep 2022 01:17:52 +0200
Message-Id: <patch-v4-10.33-44b27475864-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the preceding commit fixed style issues with \n\n among the
declared variables let's fix the minor stylistic issues with those
variables not being consistently followed by a \n\n.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 02552410679..a492ea3cfed 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -167,6 +167,7 @@ static int module_list_compute(int argc, const char **argv,
 {
 	int i, result = 0;
 	char *ps_matched = NULL;
+
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
@@ -248,6 +249,7 @@ static void for_each_listed_submodule(const struct module_list *list,
 				      each_submodule_fn fn, void *cb_data)
 {
 	int i;
+
 	for (i = 0; i < list->nr; i++)
 		fn(list->entries[i], cb_data);
 }
@@ -267,7 +269,6 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	struct foreach_cb *info = cb_data;
 	const char *path = list_item->name;
 	const struct object_id *ce_oid = &list_item->oid;
-
 	const struct submodule *sub;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *displaypath;
@@ -456,6 +457,7 @@ static void init_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
+
 			url = resolve_relative_url(oldurl, NULL, 0);
 			free(oldurl);
 		}
@@ -493,6 +495,7 @@ static void init_submodule(const char *path, const char *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct init_cb *info = cb_data;
+
 	init_submodule(list_item->name, info->prefix, info->flags);
 }
 
@@ -562,6 +565,7 @@ static int handle_submodule_head_ref(const char *refname,
 				     void *cb_data)
 {
 	struct object_id *output = cb_data;
+
 	if (oid)
 		oidcpy(output, oid);
 
@@ -668,6 +672,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 				void *cb_data)
 {
 	struct status_cb *info = cb_data;
+
 	status_submodule(list_item->name, &list_item->oid, list_item->ce_flags,
 			 info->prefix, info->flags);
 }
@@ -820,6 +825,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
 		if (S_ISGITLINK(p->mod_dst)) {
 			struct ref_store *refs = get_submodule_ref_store(p->sm_path);
+
 			if (refs)
 				refs_head_ref(refs, handle_submodule_head_ref, &p->oid_dst);
 		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
@@ -1161,6 +1167,7 @@ static void sync_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(sub->url) ||
 		    starts_with_dot_slash(sub->url)) {
 			char *up_path = get_up_path(path);
+
 			sub_origin_url = resolve_relative_url(sub->url, up_path, 1);
 			super_config_url = resolve_relative_url(sub->url, NULL, 1);
 			free(up_path);
@@ -1236,6 +1243,7 @@ static void sync_submodule(const char *path, const char *prefix,
 static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct sync_cb *info = cb_data;
+
 	sync_submodule(list_item->name, info->prefix, info->flags);
 }
 
@@ -1315,6 +1323,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 
 		if (!(flags & OPT_FORCE)) {
 			struct child_process cp_rm = CHILD_PROCESS_INIT;
+
 			cp_rm.git_cmd = 1;
 			strvec_pushl(&cp_rm.args, "rm", "-qn",
 				     path, NULL);
@@ -1351,6 +1360,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	/* remove the .git/config entries (unless the user already did it) */
 	if (!capture_command(&cp_config, &sb_config, 0) && sb_config.len) {
 		char *sub_key = xstrfmt("submodule.%s", sub->name);
+
 		/*
 		 * remove the whole section so we have a clean state when
 		 * the user later decides to init this submodule again
@@ -1588,6 +1598,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
 		if (clone_data->reference.nr) {
 			struct string_list_item *item;
+
 			for_each_string_list_item(item, &clone_data->reference)
 				strvec_pushl(&cp.args, "--reference",
 					     item->string, NULL);
@@ -1938,6 +1949,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strvec_pushl(&child->args, "--url", url, NULL);
 	if (suc->update_data->references.nr) {
 		struct string_list_item *item;
+
 		for_each_string_list_item(item, &suc->update_data->references)
 			strvec_pushl(&child->args, "--reference", item->string, NULL);
 	}
@@ -1970,6 +1982,7 @@ static int update_clone_get_next_task(struct child_process *child,
 		ce = suc->update_data->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			int *p = xmalloc(sizeof(*p));
+
 			*p = suc->current;
 			*idx_task_cb = p;
 			suc->current++;
@@ -1985,6 +1998,7 @@ static int update_clone_get_next_task(struct child_process *child,
 	index = suc->current - suc->update_data->list.nr;
 	if (index < suc->failed_clones_nr) {
 		int *p;
+
 		ce = suc->failed_clones[index];
 		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			suc->current ++;
@@ -2008,6 +2022,7 @@ static int update_clone_start_failure(struct strbuf *err,
 				      void *idx_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
+
 	suc->quickstop = 1;
 	return 1;
 }
@@ -2019,9 +2034,9 @@ static int update_clone_task_finished(int result,
 {
 	const struct cache_entry *ce;
 	struct submodule_update_clone *suc = suc_cb;
-
 	int *idxP = idx_task_cb;
 	int idx = *idxP;
+
 	free(idxP);
 
 	if (!result)
@@ -2054,6 +2069,7 @@ static int git_update_clone_config(const char *var, const char *value,
 				   void *cb)
 {
 	int *max_jobs = cb;
+
 	if (!strcmp(var, "submodule.fetchjobs"))
 		*max_jobs = parse_submodule_fetchjobs(var, value);
 	return 0;
@@ -2094,6 +2110,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	if (oid) {
 		char *hex = oid_to_hex(oid);
 		char *remote = get_default_remote();
+
 		strvec_pushl(&cp.args, remote, hex, NULL);
 		free(remote);
 	}
@@ -2343,6 +2360,7 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 	if (update_data->references.nr) {
 		struct string_list_item *item;
+
 		for_each_string_list_item(item, &update_data->references)
 			strvec_pushl(args, "--reference", item->string, NULL);
 	}
@@ -2875,8 +2893,10 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
 		char *next_line;
 		char *line = sb_remote_out.buf;
+
 		while ((next_line = strchr(line, '\n')) != NULL) {
 			size_t len = next_line - line;
+
 			if (strip_suffix_mem(line, &len, " (fetch)"))
 				strbuf_addf(msg, "  %.*s\n", (int)len, line);
 			line = next_line + 1;
@@ -3183,6 +3203,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		int exit_code = -1;
 		struct strbuf sb = STRBUF_INIT;
 		struct child_process cp = CHILD_PROCESS_INIT;
+
 		cp.git_cmd = 1;
 		cp.no_stdout = 1;
 		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
-- 
2.37.3.1420.g76f8a3d556c

