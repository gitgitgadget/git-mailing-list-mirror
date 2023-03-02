Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9FEC678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCBWDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCBWDh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:03:37 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2C65AA
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:03:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536be78056eso4648497b3.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 14:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBQtc7oLap20tvuHKP0ZsC95XKy4EHg1LfrEHNOYvL4=;
        b=cG54kCIQIXARVsj0oJ+zjeq7TmlF7/iRVQj0yjx9s4tW8vleUnWd9BUnMq1poqS9x2
         LXCI374+vpXVyyESSExSgziEX/dNknGMa71gTPtXeYQl1Ktet8NFInh1Ng+jdXn4B4IV
         FL8mL4y6UcORz+yBlAH5tpYFzaSuQCmprj9G37S4vN1XaDod7alNGwDoga4yFSv2aXRz
         KPibE1mjojGrBsgozfoF7lgiyUXPhbCPh4jZuTJoKt1m6hvwpX2oEnddwwdJ1ix/+pEK
         8tpUX1/+4EIgQ7Kr8grdxnEBxZda6rk8ouXKBSZXvw0pwPpqYilSPhnVzb35AeOEoPlf
         YxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBQtc7oLap20tvuHKP0ZsC95XKy4EHg1LfrEHNOYvL4=;
        b=FWLiyFQ7O/2rMS0VQqqQp1i57Dk/XXBEJ+WtE2/noC9lOu8kHb3q86F1zQWNAJ5Ukd
         EV2OBLCmBv8j6Znt+YwviT3inRqrOt4VfpbPcDq6iklOqwtnh4qT0N5j4OvIrHIasZKD
         yqb+xntaaWiFjAqImvAMovIRffVoA5UkVjsr4SMWVazrM1Ef2OlyH6jL5aBFgpRnPASM
         HHWhPmWPjxtSJS0Msbj0PDnYpZ/JvDeDy1IBYNEoL/nzZj6P6Vz9fqa/qHcnnXytFSld
         HkWJB41tpwStutFD+HMs8gYZ3f0mOl0n3eICWXh5omdva1wK0VD+XyBzDbESEW6IHGht
         W4nA==
X-Gm-Message-State: AO0yUKV0awdX4FRDsBpT9PAqZuIdZLezqvSzIGxBu45Rf42caYn8aEPR
        widhYM2pY7V2qs3jzIWqBNqXrJyXqGtzU0WowGgOqKaA8WhmP8+iNdDyyMopdqj6Zd85B7dSdPV
        4NqbnMJDN/+A2oTSWoDdLLGSGuoLJCH6ds4Plz2FxQmOEW3K1lRZVzwkSCEFIy3UMZA==
X-Google-Smtp-Source: AK7set9gLruO9PDg73uetafY97F079sUJrI5V6sR1xDOjFaZOsgHky+XAmQ9Xx677xTVNMLpNns27htu0DKhts8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:4416:0:b0:533:9ffb:cb13 with SMTP id
 r22-20020a814416000000b005339ffbcb13mr7139045ywa.3.1677794587894; Thu, 02 Mar
 2023 14:03:07 -0800 (PST)
Date:   Thu,  2 Mar 2023 22:02:51 +0000
In-Reply-To: <20230302215237.1473444-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302220251.1474923-6-calvinwan@google.com>
Subject: [PATCH v9 6/6] diff-lib: parallelize run_diff_files for submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the iteration of the index entries in run_diff_files, whenever a
submodule is found and needs its status checked, a subprocess is spawned
for it. Instead of spawning the subprocess immediately and waiting for
its completion to continue, hold onto all submodules and relevant
information in a list. Then use that list to create tasks for
run_processes_parallel. Subprocess output is passed to
status_on_stderr_output which stores it to be parsed on completion of
the subprocess.

Add config option submodule.diffJobs to set the maximum number of
parallel jobs. The option defaults to 1 if unset. If set to 0, the
number of jobs is set to online_cpus().

Since run_diff_files is called from many different commands, I chose to
grab the config option in the function rather than adding variables to
every git command and then figuring out how to pass them all in.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/config/submodule.txt |  12 +++
 diff-lib.c                         |  81 +++++++++++++++---
 submodule.c                        | 128 +++++++++++++++++++++++++++++
 submodule.h                        |   9 ++
 t/t4027-diff-submodule.sh          |  31 +++++++
 t/t7506-status-submodule.sh        |  25 ++++++
 6 files changed, 274 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 6490527b45..3209eb8117 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -93,6 +93,18 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.diffJobs::
+	Specifies how many submodules are diffed at the same time. A
+	positive integer allows up to that number of submodules diffed
+	in parallel. A value of 0 will give some reasonable default.
+	If unset, it defaults to 1. The diff operation is used by many
+	other git commands such as add, merge, diff, status, stash and
+	more. Note that the expensive part of the diff operation is
+	reading the index from cache or memory. Therefore multiple jobs
+	may be detrimental to performance if your hardware does not
+	support parallel reads or if the number of jobs greatly exceeds
+	the amount of supported reads.
+
 submodule.alternateLocation::
 	Specifies how the submodules obtain alternates when submodules are
 	cloned. Possible values are `no`, `superproject`.
diff --git a/diff-lib.c b/diff-lib.c
index 744ae98a69..7fe6ced950 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "fsmonitor.h"
 #include "commit-reach.h"
+#include "config.h"
 
 /*
  * diff-files
@@ -65,26 +66,41 @@ static int check_removed(const struct index_state *istate, const struct cache_en
  * Return 1 when changes are detected, 0 otherwise. If the DIRTY_SUBMODULES
  * option is set, the caller does not only want to know if a submodule is
  * modified at all but wants to know all the conditions that are met (new
- * commits, untracked content and/or modified content).
+ * commits, untracked content and/or modified content). If
+ * defer_submodule_status bit is set, dirty_submodule will be left to the
+ * caller to set. defer_submodule_status can also be set to 0 in this
+ * function if there is no need to check if the submodule is modified.
  */
 static int match_stat_with_submodule(struct diff_options *diffopt,
 				     const struct cache_entry *ce,
 				     struct stat *st, unsigned ce_option,
-				     unsigned *dirty_submodule)
+				     unsigned *dirty_submodule, int *defer_submodule_status,
+				     unsigned *ignore_untracked)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
+	int defer = 0;
+
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
 		if (!diffopt->flags.override_submodule_config)
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.ignore_submodules)
+		if (diffopt->flags.ignore_submodules) {
 			changed = 0;
-		else if (!diffopt->flags.ignore_dirty_submodules &&
-			 (!changed || diffopt->flags.dirty_submodules))
-			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.ignore_untracked_in_submodules);
+		} else if (!diffopt->flags.ignore_dirty_submodules &&
+			   (!changed || diffopt->flags.dirty_submodules)) {
+			if (defer_submodule_status && *defer_submodule_status) {
+				defer = 1;
+				*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
+			} else {
+				*dirty_submodule = is_submodule_modified(ce->name,
+					 diffopt->flags.ignore_untracked_in_submodules);
+			}
+		}
 		diffopt->flags = orig_flags;
 	}
+
+	if (defer_submodule_status)
+		*defer_submodule_status = defer;
 	return changed;
 }
 
@@ -124,6 +140,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	uint64_t start = getnanotime();
 	struct index_state *istate = revs->diffopt.repo->index;
+	struct string_list submodules = STRING_LIST_INIT_NODUP;
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
@@ -136,7 +153,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		unsigned int newmode;
 		struct cache_entry *ce = istate->cache[i];
 		int changed;
-		unsigned dirty_submodule = 0;
+		int defer_submodule_status = 1;
 
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
@@ -247,6 +264,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			newmode = ce->ce_mode;
 		} else {
 			struct stat st;
+			unsigned ignore_untracked = 0;
 
 			changed = check_removed(istate, ce, &st);
 			if (changed) {
@@ -268,13 +286,52 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
-							    ce_option, &dirty_submodule);
+							    ce_option, NULL,
+							    &defer_submodule_status,
+							    &ignore_untracked);
 			newmode = ce_mode_from_stat(ce, st.st_mode);
+			if (defer_submodule_status) {
+				struct submodule_status_util tmp = {
+					.changed = changed,
+					.dirty_submodule = 0,
+					.ignore_untracked = ignore_untracked,
+					.newmode = newmode,
+					.ce = ce,
+					.path = ce->name,
+				};
+				struct string_list_item *item;
+
+				item = string_list_append(&submodules, ce->name);
+				item->util = xmalloc(sizeof(tmp));
+				memcpy(item->util, &tmp, sizeof(tmp));
+				continue;
+			}
 		}
 
-		record_file_diff(&revs->diffopt, newmode, dirty_submodule,
-				 changed, istate, ce);
+		if (!defer_submodule_status)
+			record_file_diff(&revs->diffopt, newmode, 0,
+					   changed,istate, ce);
+	}
+	if (submodules.nr) {
+		unsigned long parallel_jobs;
+		struct string_list_item *item;
+
+		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
+			parallel_jobs = 1;
+		else if (!parallel_jobs)
+			parallel_jobs = online_cpus();
+
+		if (get_submodules_status(&submodules, parallel_jobs))
+			die(_("submodule status failed"));
+		for_each_string_list_item(item, &submodules) {
+			struct submodule_status_util *util = item->util;
+
+			record_file_diff(&revs->diffopt, util->newmode,
+					 util->dirty_submodule, util->changed,
+					 istate, util->ce);
+		}
 	}
+	string_list_clear(&submodules, 1);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	trace_performance_since(start, "diff-files");
@@ -322,7 +379,7 @@ static int get_stat_data(const struct index_state *istate,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, NULL, NULL);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = null_oid();
diff --git a/submodule.c b/submodule.c
index 426074cebb..6f6e150a3f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1373,6 +1373,13 @@ int submodule_touches_in_range(struct repository *r,
 	return ret;
 }
 
+struct submodule_parallel_status {
+	size_t index_count;
+	int result;
+
+	struct string_list *submodule_names;
+};
+
 struct submodule_parallel_fetch {
 	/*
 	 * The index of the last index entry processed by
@@ -1455,6 +1462,12 @@ struct fetch_task {
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
 
+struct status_task {
+	const char *path;
+	struct strbuf out;
+	int ignore_untracked;
+};
+
 /**
  * When a submodule is not defined in .gitmodules, we cannot access it
  * via the regular submodule-config. Create a fake submodule, which we can
@@ -1981,6 +1994,121 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	return dirty_submodule;
 }
 
+static struct status_task *
+get_status_task_from_index(struct submodule_parallel_status *sps,
+			   struct strbuf *err)
+{
+	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
+		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
+		struct status_task *task;
+
+		if (!verify_submodule_git_directory(util->path))
+			continue;
+
+		task = xmalloc(sizeof(*task));
+		task->path = util->path;
+		task->ignore_untracked = util->ignore_untracked;
+		strbuf_init(&task->out, 0);
+		sps->index_count++;
+		return task;
+	}
+	return NULL;
+}
+
+static int get_next_submodule_status(struct child_process *cp,
+				     struct strbuf *err, void *data,
+				     void **task_cb)
+{
+	struct submodule_parallel_status *sps = data;
+	struct status_task *task = get_status_task_from_index(sps, err);
+
+	if (!task)
+		return 0;
+
+	child_process_init(cp);
+	prepare_submodule_repo_env_in_gitdir(&cp->env);
+	prepare_status_porcelain(cp, task->path, task->ignore_untracked);
+	*task_cb = task;
+	return 1;
+}
+
+static int status_start_failure(struct strbuf *err,
+				void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+	struct status_task *task = task_cb;
+
+	sps->result = 1;
+	strbuf_addf(err, _(STATUS_PORCELAIN_START_ERROR), task->path);
+	return 0;
+}
+
+static void status_on_stderr_output(struct strbuf *out,
+				    size_t offset,
+				    void *cb, void *task_cb)
+{
+	struct status_task *task = task_cb;
+
+	strbuf_add(&task->out, out->buf + offset, out->len - offset);
+	strbuf_setlen(out, offset);
+}
+
+static int status_finish(int retvalue, struct strbuf *err,
+			 void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+	struct status_task *task = task_cb;
+	struct string_list_item *it =
+		string_list_lookup(sps->submodule_names, task->path);
+	struct submodule_status_util *util = it->util;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	if (retvalue) {
+		sps->result = 1;
+		strbuf_addf(err, _(STATUS_PORCELAIN_FAIL_ERROR), task->path);
+	}
+
+	string_list_split(&list, task->out.buf, '\n', -1);
+	for_each_string_list_item(item, &list) {
+		if (parse_status_porcelain(item->string,
+					   strlen(item->string),
+					   &util->dirty_submodule,
+					   util->ignore_untracked))
+			break;
+	}
+	string_list_clear(&list, 0);
+	strbuf_release(&task->out);
+	free(task);
+
+	return 0;
+}
+
+int get_submodules_status(struct string_list *submodules,
+			  int max_parallel_jobs)
+{
+	struct submodule_parallel_status sps = {
+		.submodule_names = submodules,
+	};
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/status",
+
+		.processes = max_parallel_jobs,
+
+		.get_next_task = get_next_submodule_status,
+		.start_failure = status_start_failure,
+		.on_stderr_output = status_on_stderr_output,
+		.task_finished = status_finish,
+		.data = &sps,
+	};
+
+	string_list_sort(sps.submodule_names);
+	run_processes_parallel(&opts);
+
+	return sps.result;
+}
+
 int submodule_uses_gitfile(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
diff --git a/submodule.h b/submodule.h
index b52a4ff1e7..08d278a414 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,13 @@ struct submodule_update_strategy {
 	.type = SM_UPDATE_UNSPECIFIED, \
 }
 
+struct submodule_status_util {
+	int changed, ignore_untracked;
+	unsigned dirty_submodule, newmode;
+	struct cache_entry *ce;
+	const char *path;
+};
+
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
@@ -94,6 +101,8 @@ int fetch_submodules(struct repository *r,
 		     int command_line_option,
 		     int default_option,
 		     int quiet, int max_parallel_jobs);
+int get_submodules_status(struct string_list *submodules,
+			  int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 40164ae07d..1c747cc325 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -34,6 +34,25 @@ test_expect_success setup '
 	subtip=$3 subprev=$2
 '
 
+test_expect_success 'diff in superproject with submodules respects parallel settings' '
+	test_when_finished "rm -f trace.out" &&
+	(
+		GIT_TRACE=$(pwd)/trace.out git diff &&
+		grep "1 tasks" trace.out &&
+		>trace.out &&
+
+		git config submodule.diffJobs 8 &&
+		GIT_TRACE=$(pwd)/trace.out git diff &&
+		grep "8 tasks" trace.out &&
+		>trace.out &&
+
+		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 diff &&
+		grep "preparing to run up to [0-9]* tasks" trace.out &&
+		! grep "up to 0 tasks" trace.out &&
+		>trace.out
+	)
+'
+
 test_expect_success 'git diff --raw HEAD' '
 	hexsz=$(test_oid hexsz) &&
 	git diff --raw --abbrev=$hexsz HEAD >actual &&
@@ -70,6 +89,18 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree)' '
 	test_cmp expect.body actual.body
 '
 
+test_expect_success 'git diff HEAD with dirty submodule (work tree, parallel)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		echo >>world
+	) &&
+	git -c submodule.diffJobs=8 diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
 test_expect_success 'git diff HEAD with dirty submodule (index)' '
 	(
 		cd sub &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d050091345..7da64e4c4c 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -412,4 +412,29 @@ test_expect_success 'status with added file in nested submodule (short)' '
 	EOF
 '
 
+test_expect_success 'status in superproject with submodules respects parallel settings' '
+	test_when_finished "rm -f trace.out" &&
+	(
+		GIT_TRACE=$(pwd)/trace.out git status &&
+		grep "1 tasks" trace.out &&
+		>trace.out &&
+
+		git config submodule.diffJobs 8 &&
+		GIT_TRACE=$(pwd)/trace.out git status &&
+		grep "8 tasks" trace.out &&
+		>trace.out &&
+
+		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 status &&
+		grep "preparing to run up to [0-9]* tasks" trace.out &&
+		! grep "up to 0 tasks" trace.out &&
+		>trace.out
+	)
+'
+
+test_expect_success 'status in superproject with submodules (parallel)' '
+	git -C super status --porcelain >output &&
+	git -C super -c submodule.diffJobs=8 status --porcelain >output_parallel &&
+	diff output output_parallel
+'
+
 test_done
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

