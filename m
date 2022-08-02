Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC94C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiHBPqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiHBPqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C93217E13
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v5so7419209wmj.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+zjfSt/Y5PoTEIr//LzW1kJ0b0Zhl4mqyGuR4k24GlU=;
        b=fgWIRgt8uA7JrpjsqFaXOQAFtD+zC9je5/L7a1pYlDpLlziQmcfz3H0j4J4obzhIRV
         /qtWPSGpLu6CRsH0POvAmngFBJJxSjh6qjFo6v1tJzPwo3IYJuM+gHPnqsyHobYYG+OS
         Fb6W0851Ae6hnOqc0Gh5oDQj4pIxc/c8b6qEITt8Xd7KQspWw7rh2+9LyAROGGkbFs/e
         ZaXh10ZnabsZ6LU0H0Q32QXUik9RXqY0MF/G764sw3rPuedcfUAnzI0XP8cEkPwS6UEw
         2NepBWNqlTHC/omiDnmCMz5/3nWd28O3MkIvyFmmoKyQNhTat6WefGf5fOTzgE+JqaQQ
         lBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+zjfSt/Y5PoTEIr//LzW1kJ0b0Zhl4mqyGuR4k24GlU=;
        b=Ocr0i2/1TJPOfckYcjliISm7nRfPAwLY3sVOB4bX5PBqmYdim4x/L4PNVEgIbQNY6M
         ejH8pRx20JnLu1w7uydikRbt6q1nTRxRa/9cLPLXfIrT+dTja9X1U50hbJd8b7aQwsRI
         L5tic8TWir+tB80mn5AwxV5rbqbW6kNfQJkZi/nrGzTyDxCEkR8tdI+W7N4Oj9TRH4Dk
         71sJHnw9y3VEPXUQDBygUy/hA5yNOwu0Dt+mqdorXaNqZgPeJvW/VdCS3XUt1HTi7sLG
         dUpqbkDsR4uplFMPdlRnYLS+5JXzqg8mfT44KrovedObSFC3a/a93wFftfF0TJRelP/O
         dt7g==
X-Gm-Message-State: ACgBeo3aXZdEiqyo91sIoi20bNouNWVuDHMT7GfecCQFQT6lBP9OkYFj
        2x2qw509WZ7pyP82Js3EKNeRJ6EAloCA7w==
X-Google-Smtp-Source: AA6agR6/KA5DHdKQXQJzVH4K0fQmqUDJTYEHjxS99XHE5l/zNfLsWMlvAIoTmesDjWqtHbcHQXnUrA==
X-Received: by 2002:a05:600c:4e01:b0:3a3:342:5f55 with SMTP id b1-20020a05600c4e0100b003a303425f55mr63901wmq.150.1659455186972;
        Tue, 02 Aug 2022 08:46:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/28] submodule--helper style: add \n\n after variable declarations
Date:   Tue,  2 Aug 2022 17:45:54 +0200
Message-Id: <patch-v2-10.28-5f5e68a868b-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index 53b9e14767d..15bf89910f4 100644
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
@@ -1158,6 +1164,7 @@ static void sync_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(sub->url) ||
 		    starts_with_dot_slash(sub->url)) {
 			char *up_path = get_up_path(path);
+
 			sub_origin_url = resolve_relative_url(sub->url, up_path, 1);
 			super_config_url = resolve_relative_url(sub->url, NULL, 1);
 			free(up_path);
@@ -1233,6 +1240,7 @@ static void sync_submodule(const char *path, const char *prefix,
 static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct sync_cb *info = cb_data;
+
 	sync_submodule(list_item->name, info->prefix, info->flags);
 }
 
@@ -1312,6 +1320,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 
 		if (!(flags & OPT_FORCE)) {
 			struct child_process cp_rm = CHILD_PROCESS_INIT;
+
 			cp_rm.git_cmd = 1;
 			strvec_pushl(&cp_rm.args, "rm", "-qn",
 				     path, NULL);
@@ -1348,6 +1357,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	/* remove the .git/config entries (unless the user already did it) */
 	if (!capture_command(&cp_config, &sb_config, 0) && sb_config.len) {
 		char *sub_key = xstrfmt("submodule.%s", sub->name);
+
 		/*
 		 * remove the whole section so we have a clean state when
 		 * the user later decides to init this submodule again
@@ -1585,6 +1595,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
 		if (clone_data->reference.nr) {
 			struct string_list_item *item;
+
 			for_each_string_list_item(item, &clone_data->reference)
 				strvec_pushl(&cp.args, "--reference",
 					     item->string, NULL);
@@ -1935,6 +1946,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strvec_pushl(&child->args, "--url", url, NULL);
 	if (suc->update_data->references.nr) {
 		struct string_list_item *item;
+
 		for_each_string_list_item(item, &suc->update_data->references)
 			strvec_pushl(&child->args, "--reference", item->string, NULL);
 	}
@@ -1967,6 +1979,7 @@ static int update_clone_get_next_task(struct child_process *child,
 		ce = suc->update_data->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			int *p = xmalloc(sizeof(*p));
+
 			*p = suc->current;
 			*idx_task_cb = p;
 			suc->current++;
@@ -1982,6 +1995,7 @@ static int update_clone_get_next_task(struct child_process *child,
 	index = suc->current - suc->update_data->list.nr;
 	if (index < suc->failed_clones_nr) {
 		int *p;
+
 		ce = suc->failed_clones[index];
 		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			suc->current ++;
@@ -2005,6 +2019,7 @@ static int update_clone_start_failure(struct strbuf *err,
 				      void *idx_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
+
 	suc->quickstop = 1;
 	return 1;
 }
@@ -2016,9 +2031,9 @@ static int update_clone_task_finished(int result,
 {
 	const struct cache_entry *ce;
 	struct submodule_update_clone *suc = suc_cb;
-
 	int *idxP = idx_task_cb;
 	int idx = *idxP;
+
 	free(idxP);
 
 	if (!result)
@@ -2051,6 +2066,7 @@ static int git_update_clone_config(const char *var, const char *value,
 				   void *cb)
 {
 	int *max_jobs = cb;
+
 	if (!strcmp(var, "submodule.fetchjobs"))
 		*max_jobs = parse_submodule_fetchjobs(var, value);
 	return 0;
@@ -2091,6 +2107,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	if (oid) {
 		char *hex = oid_to_hex(oid);
 		char *remote = get_default_remote();
+
 		strvec_pushl(&cp.args, remote, hex, NULL);
 		free(remote);
 	}
@@ -2340,6 +2357,7 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 	if (update_data->references.nr) {
 		struct string_list_item *item;
+
 		for_each_string_list_item(item, &update_data->references)
 			strvec_pushl(args, "--reference", item->string, NULL);
 	}
@@ -2872,8 +2890,10 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
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
@@ -3180,6 +3200,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		int exit_code = -1;
 		struct strbuf sb = STRBUF_INIT;
 		struct child_process cp = CHILD_PROCESS_INIT;
+
 		cp.git_cmd = 1;
 		cp.no_stdout = 1;
 		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
-- 
2.37.1.1233.ge8b09efaedc

