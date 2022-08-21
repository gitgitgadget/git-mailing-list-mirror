Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5F9C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiHUN67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiHUN6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D578E14D05
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so2365886wms.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OMMN1wDfVJjIDccNQXy2fAFFOYAehx0B9gZf8DS42o0=;
        b=Py0SyTuMCQnofGyAWbLlaZ38F6Fiff98feS0JzCYbeTKGN17hG3Njkmiv+ChadWsy4
         7STMqoz1gucgee72ObpLR+jodx+5F75oXE1HPE6X9JxZ83K7toJuJt6fyYrUTWfxCLI5
         q+c2jeta6upEvnd/6xI4RJ/ocslF99fi2cbxSrwrHvWmV42C1HiSlvnx/W1eJB+LUEcK
         s+kO9Rzr61dCSREGl1dRmt0LxabeA7oU6mNCMl1j8i2I5raY/R1VVVKUod9+VAbsn81z
         MkUcK75xzEz59Y/7KqRoIb/dlhpq9TNn7dxUVTCiXUoBk+vp0iPsFNCl4iPY5p8P9m2I
         mSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OMMN1wDfVJjIDccNQXy2fAFFOYAehx0B9gZf8DS42o0=;
        b=r48JZ+lolaFOTV1PMHi4HyfIcQeBujSOl0+GeveDaNFlQxCAPnq1HrxUoYIxdSQo/h
         ZwSwI84BAOlVF71Ej9Duaw1iA57ryywWfj+8HI2SAZ/VOSuepoL0BsSv4ABshRmWLtSX
         9pv1+OEY9AaWWhQYQKiUwPPbBKlljZbGIyL1KMEtaiCrjM/AnIDD4kBD8hwLTlfq2Izt
         H6eIjGjVdX2qgj7CXxJ4dSuZYOgttLhMqz6JWiBa3KVGAuZOwW/DpP2CjIqdP2HvmxmF
         VzqDvm2jqXnIJbFRALClHfYR34wLas23gkp5kw0nUTbPHkgnPFOph3ibSH2V17/Xs4MO
         8c2Q==
X-Gm-Message-State: ACgBeo2wL6yl4/uuE57Oz5kOxPULr1SyjKnFCb7RccXZ3x/8+6eqSth3
        ditlrxTnmXNT3RCfTkwanaTaYqdry6Ct8pGE
X-Google-Smtp-Source: AA6agR6p34CRIo+2RnSj5LSrOPUhZzBmpDjYsgDxVhj+6rQJoxLsJHFC+51RRWc9p++4mV4OFUyHuQ==
X-Received: by 2002:a1c:7916:0:b0:3a6:3540:5b3c with SMTP id l22-20020a1c7916000000b003a635405b3cmr6837528wme.178.1661090315972;
        Sun, 21 Aug 2022 06:58:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/32] submodule--helper style: add \n\n after variable declarations
Date:   Sun, 21 Aug 2022 15:57:19 +0200
Message-Id: <patch-v3-10.32-fd7fbe08536-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
2.37.2.1279.g64dec4e13cf

