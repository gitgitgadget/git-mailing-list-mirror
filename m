Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79E3C6379F
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBIACg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBIAC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:02:29 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C01F5DD
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:02:27 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r126-20020a632b84000000b004393806c06eso259212pgr.4
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ8P+iFvLwZz+A/MsVMwA/SDS9YJo2o6hfl3X1HRuok=;
        b=MV99hhytA9vHMbB+N9rQi/0OcfsA2UTm88dTzFs2ktRI6RdJeBwtAnpCCzoALpHTxC
         eVB7ovLODqFsIUzg/W8R75RiF3lZyw4bwXRCEyE/EJclMjdOXrnfgSFsgv/s+N7vfvV8
         GFzG1oVIkohfqHFw+lUnW7iLuIrZGCINWv5CkBxCG5sFq4dGrBY9cOD7FGxyrvnJ9t5h
         kCzQIkX3iQzUeVXn2CELzxfzkrUwmK/3kZvCHbCvifIlDu4cnHxiSd7vUHgRK9xgmgm7
         VZUWch4huU3qaN0Mgu8tAMguVjT0Zh1aALrdjCvddjtl3cHKnWvE/N1DyBtZKDUWmmM+
         BUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ8P+iFvLwZz+A/MsVMwA/SDS9YJo2o6hfl3X1HRuok=;
        b=r441WFSYov47mHXpCyUmHO5wO/znt1HJZJqSlYVyhBWl78MWsF3dWOhkNJQovlmvWr
         r3LAA3JccPMfJCuADXudBuXpu29Pa2vFiySuPMm6apVzVKS1/qWBBTYK2q+fqsay7vfn
         xpSxg/6QToqk0quwXfpLhHJBiyCBpTO+UcWS0g41B+BuPYIE+rSZb93/5drTzZ4qVfKo
         ob9LAHTsMjjVTdkFUUPYJ4GSvspmwziKHnLkec6vj9395yRGS2jhXA57uHgvERoMzXYE
         Z/TuC9GjX1MIetRNTFEOQxFX0GFKt8RUzJa3/3A6cGU9vbaWzM0iKFA0BW6ZBE/ubQpL
         4r5A==
X-Gm-Message-State: AO0yUKWYg9cRJc+NdMcpiDfNR0sHVOSwQYybJRXQOECB2TWVP9aZrIOE
        mSoTsMP8Y7FQqyCqmdP1mF8yAMXnveVc1W2OM0jho896FYQKDo75D5PcQRGAtnhwa5HWEHen8+/
        7uuT9tmOaOwu+eu/WCE0bg9azFcyBYukyabQhX862BTp4lvhrIDE2P9x9K0Fz1vDeqQ==
X-Google-Smtp-Source: AK7set8PbrIC7pzJlSaCAUVHt/ZoN2glx+0+gf7XfCW4GKk+EqJ7OaiuwVIEtmweKX4t+zwU7DW1dn4fEfTBLqg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:aa7:9d8e:0:b0:5a8:2b97:e92d with SMTP id
 f14-20020aa79d8e000000b005a82b97e92dmr962990pfq.36.1675900946707; Wed, 08 Feb
 2023 16:02:26 -0800 (PST)
Date:   Thu,  9 Feb 2023 00:02:12 +0000
In-Reply-To: <20230207181706.363453-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230209000212.1892457-7-calvinwan@google.com>
Subject: [PATCH v8 6/6] diff-lib: parallelize run_diff_files for submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the iteration of the index entries in run_diff_files, whenever
a submodule is found and needs its status checked, a subprocess is
spawned for it. Instead of spawning the subprocess immediately and
waiting for its completion to continue, hold onto all submodules and
relevant information in a list. Then use that list to create tasks for
run_processes_parallel. Subprocess output is duplicated and passed to
status_pipe_output which stores it to be parsed on completion of the
subprocess.

Add config option submodule.diffJobs to set the maximum number
of parallel jobs. The option defaults to 1 if unset. If set to 0, the
number of jobs is set to online_cpus().

Since run_diff_files is called from many different commands, I chose
to grab the config option in the function rather than adding variables
to every git command and then figuring out how to pass them all in.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/config/submodule.txt |  12 +++
 diff-lib.c                         |  91 ++++++++++++++++---
 submodule.c                        | 140 +++++++++++++++++++++++++++++
 submodule.h                        |   9 ++
 t/t4027-diff-submodule.sh          |  31 +++++++
 t/t7506-status-submodule.sh        |  25 ++++++
 6 files changed, 294 insertions(+), 14 deletions(-)

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
index 7101cfda3f..2dde575ec6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "fsmonitor.h"
 #include "commit-reach.h"
+#include "config.h"
 
 /*
  * diff-files
@@ -65,26 +66,46 @@ static int check_removed(const struct index_state *istate, const struct cache_en
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
-	if (S_ISGITLINK(ce->ce_mode)) {
-		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.ignore_submodules)
-			changed = 0;
-		else if (!diffopt->flags.ignore_dirty_submodules &&
-			 (!changed || diffopt->flags.dirty_submodules))
+	struct diff_flags orig_flags;
+	int defer = 0;
+
+	if (!S_ISGITLINK(ce->ce_mode))
+		goto ret;
+
+	orig_flags = diffopt->flags;
+	if (!diffopt->flags.override_submodule_config)
+		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
+	if (diffopt->flags.ignore_submodules) {
+		changed = 0;
+		goto cleanup;
+	}
+	if (!diffopt->flags.ignore_dirty_submodules &&
+	    (!changed || diffopt->flags.dirty_submodules)) {
+		if (defer_submodule_status && *defer_submodule_status) {
+			defer = 1;
+			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
+		} else {
 			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.ignore_untracked_in_submodules);
-		diffopt->flags = orig_flags;
+					 diffopt->flags.ignore_untracked_in_submodules);
+		}
 	}
+cleanup:
+	diffopt->flags = orig_flags;
+ret:
+	if (defer_submodule_status)
+		*defer_submodule_status = defer;
 	return changed;
 }
 
@@ -121,6 +142,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	uint64_t start = getnanotime();
 	struct index_state *istate = revs->diffopt.repo->index;
+	struct string_list submodules = STRING_LIST_INIT_NODUP;
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
@@ -244,6 +266,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			newmode = ce->ce_mode;
 		} else {
 			struct stat st;
+			unsigned ignore_untracked = 0;
+			int defer_submodule_status = 1;
 
 			changed = check_removed(istate, ce, &st);
 			if (changed) {
@@ -265,14 +289,53 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
-							    ce_option, &dirty_submodule);
+							    ce_option, &dirty_submodule,
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
 
 		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
 				       changed, istate, ce))
 			continue;
 	}
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
+			if (diff_change_helper(&revs->diffopt, util->newmode,
+				       util->dirty_submodule, util->changed,
+				       istate, util->ce))
+				continue;
+		}
+	}
+	string_list_clear(&submodules, 1);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	trace_performance_since(start, "diff-files");
@@ -320,7 +383,7 @@ static int get_stat_data(const struct index_state *istate,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, NULL, NULL);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = null_oid();
diff --git a/submodule.c b/submodule.c
index 426074cebb..e175fb8d3f 100644
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
@@ -1947,6 +1960,25 @@ static int parse_status_porcelain(char *str, size_t len,
 	return 0;
 }
 
+static void parse_status_porcelain_strbuf(struct strbuf *buf,
+				   unsigned *dirty_submodule,
+				   int ignore_untracked)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	string_list_split(&list, buf->buf, '\n', -1);
+
+	for_each_string_list_item(item, &list) {
+		if (parse_status_porcelain(item->string,
+					   strlen(item->string),
+					   dirty_submodule,
+					   ignore_untracked))
+			break;
+	}
+	string_list_clear(&list, 0);
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1981,6 +2013,114 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
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
+static void status_duplicate_output(struct strbuf *out,
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
+
+	if (retvalue) {
+		sps->result = 1;
+		strbuf_addf(err, _(STATUS_PORCELAIN_FAIL_ERROR), task->path);
+	}
+
+	parse_status_porcelain_strbuf(&task->out,
+			      &util->dirty_submodule,
+			      util->ignore_untracked);
+
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
+		.duplicate_output = status_duplicate_output,
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
2.39.1.519.gcb327c4b5f-goog

