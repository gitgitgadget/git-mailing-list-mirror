Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A4C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBIACZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBIACW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:02:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F21F5DD
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:02:18 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y9-20020a1709027c8900b00195e237dc8bso292251pll.13
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFP0aSRb8QO7e5C8ah4pkbqhcruo5YVuU+piiZE7QCs=;
        b=DOqCXEAIOtIRRbcfvj+TVb61qIpK0VdM3wDlRbyvqV4KdxbMygbvWCBRnFNLw7vVbK
         OHyMB+L3bFU1t29f1eWrNTWj3WPuahW0UCj0ux4oppBINleovQ6iUyfU3R6ZnTt+iwFr
         m9IQ/rrZ3QmlpYMTlTVhkNAhJBHlW8NYuFkg279f6nkbUirWabVsWrDiB3A5lm+mC75l
         KU2xUBqHmYXMJKLT8KQJUa6hI/+FsXl4/MQqgy5GJnVg4tAKkuHbX93hvlio4c++n9SX
         QBt8CbsJkOa1iQv00Q3Oo1XV6mzaCbOOvkNHJQBg95dd02uQAxxNL6S/V8zlBNcVDHxY
         24hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFP0aSRb8QO7e5C8ah4pkbqhcruo5YVuU+piiZE7QCs=;
        b=ZJZAFD5+DTwFORRd77WH1Ve3iDGm6bui2q/yAAslyJlTUpb8OqebVuTBBnr19iXZZD
         oL+dVOPG5qZmoloYtBV1hAVbCd9XJTXZ1Gn2nFNdMgcYVkZ80vf3oRbn8ODrVbIixhff
         MLaoMJS//kDaRPUwSqZzc3yD9s1T1ffIybCgjc6Suxo4MkuOgMULOpzVe2+iQSAdKLav
         n/K0QK/vh2+O3Bhy4XMpeuX5e4Sy391gTaOCr5XO0oD4/MOC7AJM9W/ONFCorvYiZ8cw
         7IjNoj8tATUgGjT69vLg7uvlcfTJ3jNxRw2s3/jdPksTD0qyWaHyB5nYsSpISioihSlz
         uDHA==
X-Gm-Message-State: AO0yUKXuvimhFbgGDMilnDO3s1khCXRXjt4wK3kYCYarMXThMLEDSrFO
        45n42D7ZhoKiep+d0PA+AEalsjg+zMVTflrKchc/XhltWXqcGS9ycVEdGs6WpKy8UnjZy4bW+Lv
        zHe2QJ6CFe/0vkm6YPSlZGT9vMC+e9VzB336IEMpeP2tgm1hRrS+tQXhdNFlAWYdlfA==
X-Google-Smtp-Source: AK7set+wyUXA2Ygk2Rd6RuzqtISkN72i6dRJejy2a+tyrmMFkd/Nm2QrWbU/1ekBDWLDTH4+k+yVgX9iHqLhwN0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:9104:b0:225:eaa2:3f5d with SMTP
 id k4-20020a17090a910400b00225eaa23f5dmr123545pjo.2.1675900937140; Wed, 08
 Feb 2023 16:02:17 -0800 (PST)
Date:   Thu,  9 Feb 2023 00:02:06 +0000
In-Reply-To: <20230207181706.363453-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230209000212.1892457-1-calvinwan@google.com>
Subject: [PATCH v8 0/6] submodule: parallelize diff
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter for context:
https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

This reroll contains stylistic changes suggested by Avar and Phillip,
and includes a range-diff below.

Calvin Wan (6):
  run-command: add duplicate_output_fn to run_processes_parallel_opts
  submodule: strbuf variable rename
  submodule: move status parsing into function
  submodule: refactor is_submodule_modified()
  diff-lib: refactor out diff_change logic
  diff-lib: parallelize run_diff_files for submodules

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 133 +++++++++++----
 run-command.c                      |  16 +-
 run-command.h                      |  25 +++
 submodule.c                        | 266 ++++++++++++++++++++++++-----
 submodule.h                        |   9 +
 t/helper/test-run-command.c        |  20 +++
 t/t0061-run-command.sh             |  39 +++++
 t/t4027-diff-submodule.sh          |  31 ++++
 t/t7506-status-submodule.sh        |  25 +++
 10 files changed, 497 insertions(+), 79 deletions(-)

Range-diff against v7:
1:  311b1abfbe ! 1:  5d51250c67 run-command: add duplicate_output_fn to run_processes_parallel_opts
    @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      	if (!opts->get_next_task)
      		BUG("you need to specify a get_next_task function");
      
    -+	if (opts->duplicate_output && opts->ungroup)
    -+		BUG("duplicate_output and ungroup are incompatible with each other");
    ++	if (opts->ungroup) {
    ++		if (opts->duplicate_output)
    ++			BUG("duplicate_output and ungroup are incompatible with each other");
    ++	}
     +
      	CALLOC_ARRAY(pp->children, n);
      	if (!opts->ungroup)
    @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp,
     +			} else if (n < 0) {
      				if (errno != EAGAIN)
      					die_errno("read");
    -+			} else {
    -+				if (opts->duplicate_output)
    -+					opts->duplicate_output(&pp->children[i].err,
    -+					       strlen(pp->children[i].err.buf) - n,
    -+					       opts->data,
    -+					       pp->children[i].data);
    ++			} else if (opts->duplicate_output) {
    ++				opts->duplicate_output(&pp->children[i].err,
    ++					pp->children[i].err.len - n,
    ++					opts->data, pp->children[i].data);
     +			}
      		}
      	}
    @@ run-command.h: typedef int (*start_failure_fn)(struct strbuf *out,
     + *
     + * This function is incompatible with "ungroup"
     + */
    -+typedef void (*duplicate_output_fn)(struct strbuf *out,
    -+				    size_t offset,
    -+				    void *pp_cb,
    -+				    void *pp_task_cb);
    ++typedef void (*duplicate_output_fn)(struct strbuf *out, size_t offset,
    ++				    void *pp_cb, void *pp_task_cb);
     +
      /**
       * This callback is called on every child process that finished processing.
    @@ run-command.h: struct run_process_parallel_opts
      	start_failure_fn start_failure;
      
     +	/**
    -+	 * duplicate_output: See duplicate_output_fn() above. This should be
    -+	 * NULL unless process specific output is needed
    ++	 * duplicate_output: See duplicate_output_fn() above. Unless you need
    ++	 * to capture output from child processes, leave this as NULL.
     +	 */
     +	duplicate_output_fn duplicate_output;
     +
    @@ t/helper/test-run-command.c: static int no_job(struct child_process *cp,
     +			void *pp_task_cb UNUSED)
     +{
     +	struct string_list list = STRING_LIST_INIT_DUP;
    ++	struct string_list_item *item;
     +
     +	string_list_split(&list, out->buf + offset, '\n', -1);
    -+	for (size_t i = 0; i < list.nr; i++) {
    -+		if (strlen(list.items[i].string) > 0)
    -+			fprintf(stderr, "duplicate_output: %s\n", list.items[i].string);
    -+	}
    ++	for_each_string_list_item(item, &list)
    ++		fprintf(stderr, "duplicate_output: %s\n", item->string);
     +	string_list_clear(&list, 0);
     +}
     +
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
     +	test_must_be_empty out &&
     +	test 4 = $(grep -c "duplicate_output: Hello" err) &&
     +	test 4 = $(grep -c "duplicate_output: World" err) &&
    -+	sed "/duplicate_output/d" err > err1 &&
    ++	sed "/duplicate_output/d" err >err1 &&
     +	test_cmp expect err1
     +'
     +
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with a
     +	test_must_be_empty out &&
     +	test 4 = $(grep -c "duplicate_output: Hello" err) &&
     +	test 4 = $(grep -c "duplicate_output: World" err) &&
    -+	sed "/duplicate_output/d" err > err1 &&
    ++	sed "/duplicate_output/d" err >err1 &&
     +	test_cmp expect err1
     +'
     +
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
     +	test_must_be_empty out &&
     +	test 4 = $(grep -c "duplicate_output: Hello" err) &&
     +	test 4 = $(grep -c "duplicate_output: World" err) &&
    -+	sed "/duplicate_output/d" err > err1 &&
    ++	sed "/duplicate_output/d" err >err1 &&
     +	test_cmp expect err1
     +'
     +
2:  d00a18dd84 = 2:  6ded5b6788 submodule: strbuf variable rename
3:  dcda518922 = 3:  0c71cea8cd submodule: move status parsing into function
4:  c6fc5ba13b ! 4:  5c8cc93f9f submodule: refactor is_submodule_modified()
    @@ submodule.c: static int config_update_recurse_submodules = RECURSE_SUBMODULES_OF
      static int initialized_fetch_ref_tips;
      static struct oid_array ref_tips_before_fetch;
      static struct oid_array ref_tips_after_fetch;
    -+static const char *status_porcelain_start_error =
    -+	N_("could not run 'git status --porcelain=2' in submodule %s");
    -+static const char *status_porcelain_fail_error =
    -+	N_("'git status --porcelain=2' failed in submodule %s");
    ++#define STATUS_PORCELAIN_START_ERROR \
    ++	N_("could not run 'git status --porcelain=2' in submodule %s")
    ++#define STATUS_PORCELAIN_FAIL_ERROR \
    ++	N_("'git status --porcelain=2' failed in submodule %s")
      
      /*
       * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
    @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
     +	prepare_status_porcelain(&cp, path, ignore_untracked);
      	if (start_command(&cp))
     -		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
    -+		die(_(status_porcelain_start_error), path);
    ++		die(_(STATUS_PORCELAIN_START_ERROR), path);
      
      	fp = xfdopen(cp.out, "r");
      	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
    @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
      
      	if (finish_command(&cp) && !ignore_cp_exit_code)
     -		die(_("'git status --porcelain=2' failed in submodule %s"), path);
    -+		die(_(status_porcelain_fail_error), path);
    ++		die(_(STATUS_PORCELAIN_FAIL_ERROR), path);
      
      	strbuf_release(&buf);
      	return dirty_submodule;
5:  1ea8eae9c9 = 5:  6c2b62abc8 diff-lib: refactor out diff_change logic
6:  0d35fcc38d < -:  ---------- diff-lib: refactor match_stat_with_submodule
7:  fd1eec974d ! 6:  bb25dadbe5 diff-lib: parallelize run_diff_files for submodules
    @@ diff-lib.c: static int check_removed(const struct index_state *istate, const str
     +				     unsigned *ignore_untracked)
      {
      	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
    - 	struct diff_flags orig_flags;
    +-	if (S_ISGITLINK(ce->ce_mode)) {
    +-		struct diff_flags orig_flags = diffopt->flags;
    +-		if (!diffopt->flags.override_submodule_config)
    +-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
    +-		if (diffopt->flags.ignore_submodules)
    +-			changed = 0;
    +-		else if (!diffopt->flags.ignore_dirty_submodules &&
    +-			 (!changed || diffopt->flags.dirty_submodules))
    ++	struct diff_flags orig_flags;
     +	int defer = 0;
    - 
    - 	if (!S_ISGITLINK(ce->ce_mode))
    --		return changed;
    ++
    ++	if (!S_ISGITLINK(ce->ce_mode))
     +		goto ret;
    - 
    - 	orig_flags = diffopt->flags;
    - 	if (!diffopt->flags.override_submodule_config)
    -@@ diff-lib.c: static int match_stat_with_submodule(struct diff_options *diffopt,
    - 		goto cleanup;
    - 	}
    - 	if (!diffopt->flags.ignore_dirty_submodules &&
    --	    (!changed || diffopt->flags.dirty_submodules))
    --		*dirty_submodule = is_submodule_modified(ce->name,
    ++
    ++	orig_flags = diffopt->flags;
    ++	if (!diffopt->flags.override_submodule_config)
    ++		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
    ++	if (diffopt->flags.ignore_submodules) {
    ++		changed = 0;
    ++		goto cleanup;
    ++	}
    ++	if (!diffopt->flags.ignore_dirty_submodules &&
     +	    (!changed || diffopt->flags.dirty_submodules)) {
     +		if (defer_submodule_status && *defer_submodule_status) {
     +			defer = 1;
     +			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
     +		} else {
    -+			*dirty_submodule = is_submodule_modified(ce->name,
    - 					 diffopt->flags.ignore_untracked_in_submodules);
    + 			*dirty_submodule = is_submodule_modified(ce->name,
    +-								 diffopt->flags.ignore_untracked_in_submodules);
    +-		diffopt->flags = orig_flags;
    ++					 diffopt->flags.ignore_untracked_in_submodules);
     +		}
    -+	}
    - cleanup:
    - 	diffopt->flags = orig_flags;
    + 	}
    ++cleanup:
    ++	diffopt->flags = orig_flags;
     +ret:
     +	if (defer_submodule_status)
     +		*defer_submodule_status = defer;
    @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      				       changed, istate, ce))
      			continue;
      	}
    -+	if (submodules.nr > 0) {
    -+		int parallel_jobs;
    -+		if (git_config_get_int("submodule.diffjobs", &parallel_jobs))
    ++	if (submodules.nr) {
    ++		unsigned long parallel_jobs;
    ++		struct string_list_item *item;
    ++
    ++		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
     +			parallel_jobs = 1;
     +		else if (!parallel_jobs)
     +			parallel_jobs = online_cpus();
    -+		else if (parallel_jobs < 0)
    -+			die(_("submodule.diffjobs cannot be negative"));
     +
     +		if (get_submodules_status(&submodules, parallel_jobs))
     +			die(_("submodule status failed"));
    -+		for (size_t i = 0; i < submodules.nr; i++) {
    -+			struct submodule_status_util *util = submodules.items[i].util;
    ++		for_each_string_list_item(item, &submodules) {
    ++			struct submodule_status_util *util = item->util;
     +
     +			if (diff_change_helper(&revs->diffopt, util->newmode,
     +				       util->dirty_submodule, util->changed,
    @@ submodule.c: int submodule_touches_in_range(struct repository *r,
     +	int result;
     +
     +	struct string_list *submodule_names;
    -+
    -+	/* Pending statuses by OIDs */
    -+	struct status_task **oid_status_tasks;
    -+	int oid_status_tasks_nr, oid_status_tasks_alloc;
     +};
     +
      struct submodule_parallel_fetch {
    @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
     +	struct status_task *task = task_cb;
     +
     +	sps->result = 1;
    -+	strbuf_addf(err,
    -+	    _(status_porcelain_start_error),
    -+	    task->path);
    ++	strbuf_addf(err, _(STATUS_PORCELAIN_START_ERROR), task->path);
     +	return 0;
     +}
     +
    @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
     +
     +	if (retvalue) {
     +		sps->result = 1;
    -+		strbuf_addf(err,
    -+		    _(status_porcelain_fail_error),
    -+		    task->path);
    ++		strbuf_addf(err, _(STATUS_PORCELAIN_FAIL_ERROR), task->path);
     +	}
     +
     +	parse_status_porcelain_strbuf(&task->out,
-- 
2.39.1.519.gcb327c4b5f-goog

