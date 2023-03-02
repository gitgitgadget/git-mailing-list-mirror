Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE545C7EE39
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCBWAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCBWAW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:00:22 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD0E5A6C5
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:00:18 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id d3-20020a17090acd0300b00237659aae8dso2107856pju.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 14:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qi7ojpTxDRSqwncuolYy1zv/qrIn71NUmz9oN2i2AR4=;
        b=NhYoxlnqIbzCtMUjWY0kBstVJYZwCY3MB4Z6piunrUlygYGbaBt8fepHdQxMCXvRrg
         Q65fDZhK30jp82jvBJmfqWCSJEZYNkMOxCnk6ASfToZOpI8OkvouNovkHU8sn1oB+Dze
         pkNR1zvtbZg12VmUnVM63et5ad0QBdnvaFVO6cDUJW0NJpouT7GZRjyu1qViW15VvGlP
         F+SwfALsKGscJ2d0Dzy65rvQUkp5kBybQSWCr4L0OxJm42hUR1DJLNo5+6h0OJ+WcyNk
         iy/1xH8pD5noUOW8ag7LRvmmy5SU3dIosuGlX4weaBezYNbhckh7Aq1xyOGyzgTeKz06
         /1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qi7ojpTxDRSqwncuolYy1zv/qrIn71NUmz9oN2i2AR4=;
        b=Eq4+oByMVjx7LynicIbR8SmttO/0gIAerQMrQCFt7AVDBqF0BhhWCxkm8js5EEX5kI
         JGjylcgkzFeeUMCbOdBX8Ch5DQa43yRIxpMrMsHgU8yixGUKioX/JZNMDjl+j0gEO9j+
         sHlxVgheNh45QjU7Yap1mM9VIkmdfcv4KWV39komevN/S6ZfzpzxNpXC6h3iYgtBIACE
         syVkP2bkByut31iGwp6SVLSAtjGYg/8jHhO7pjOJDMxoJrJGrnL+pOsqkmNgmp+7mUAC
         8y5SkNfvSwwgvswee+j/5MowYug4cEZpx4zyoRr5pTzjJZCZcZgBJNyxGaKB1pGaczxf
         DQ5w==
X-Gm-Message-State: AO0yUKWdy6OWjV3TeYTjIIpJjS636UoVUyd/QxI58OYBT42qPmZOB+Vn
        E2fxVA4xMA8tIXR9bHqLK8hp1nwNOBQ6zYis10FfRKUrmP1q0re7M7K+toX/gZOC5vJsMU9JKUh
        D1PsGhDzqMtPMu9bQ9QSM/bnEXkWxdKXKZ6CK6Vc0MHSLMODDLIF+HHdY0XbQLikv4A==
X-Google-Smtp-Source: AK7set9rb2jYPcdl3IqqedpHvjacG+3xQjACstpk8QOLJF1Y+OslAfmcUCX+eaeaW2xSg5bY1x467HDJSytDVeg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:4c2:b0:8ea:3d09:b125 with SMTP
 id v2-20020a05690204c200b008ea3d09b125mr5319077ybs.0.1677793966607; Thu, 02
 Mar 2023 13:52:46 -0800 (PST)
Date:   Thu,  2 Mar 2023 21:52:31 +0000
In-Reply-To: <20230209000212.1892457-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302215237.1473444-1-calvinwan@google.com>
Subject: [PATCH v9 0/6] submodule: parallelize diff
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

I appreciate all the reviewers that have stuck through this entire series!
Hoping this can be the final reroll as I believe I've addressed all feedback
and personally am happy with the state of the patches.

Changes from v8
 - renamed duplicate_output_fn to on_stderr_output_fn
 - renamed diff_change_helper() to record_file_diff() and added comments
 - reworded commit message for patch 5
 - removed the refactoring of match_stat_with_submodule()
 - inlined parse_status_porcelain_strbuf()
 - fixed stylistic nits and cleaned up unnecessary variables and logic

Calvin Wan (6):
  run-command: add on_stderr_output_fn to run_processes_parallel_opts
  submodule: rename strbuf variable
  submodule: move status parsing into function
  submodule: refactor is_submodule_modified()
  diff-lib: refactor out diff_change logic
  diff-lib: parallelize run_diff_files for submodules

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 123 +++++++++++---
 run-command.c                      |  16 +-
 run-command.h                      |  25 +++
 submodule.c                        | 254 +++++++++++++++++++++++------
 submodule.h                        |   9 +
 t/helper/test-run-command.c        |  20 +++
 t/t0061-run-command.sh             |  39 +++++
 t/t4027-diff-submodule.sh          |  31 ++++
 t/t7506-status-submodule.sh        |  25 +++
 10 files changed, 478 insertions(+), 76 deletions(-)

Range-diff against v8:
1:  5d51250c67 ! 1:  49749ae3a5 run-command: add duplicate_output_fn to run_processes_parallel_opts
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    run-command: add duplicate_output_fn to run_processes_parallel_opts
    +    run-command: add on_stderr_output_fn to run_processes_parallel_opts
     
      ## run-command.c ##
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      		BUG("you need to specify a get_next_task function");
      
     +	if (opts->ungroup) {
    -+		if (opts->duplicate_output)
    -+			BUG("duplicate_output and ungroup are incompatible with each other");
    ++		if (opts->on_stderr_output)
    ++			BUG("on_stderr_output and ungroup are incompatible with each other");
     +	}
     +
      	CALLOC_ARRAY(pp->children, n);
    @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp,
     +			} else if (n < 0) {
      				if (errno != EAGAIN)
      					die_errno("read");
    -+			} else if (opts->duplicate_output) {
    -+				opts->duplicate_output(&pp->children[i].err,
    ++			} else if (opts->on_stderr_output) {
    ++				opts->on_stderr_output(&pp->children[i].err,
     +					pp->children[i].err.len - n,
     +					opts->data, pp->children[i].data);
     +			}
    @@ run-command.h: typedef int (*start_failure_fn)(struct strbuf *out,
      
     +/**
     + * This callback is called whenever output from a child process is buffered
    -+ * 
    ++ *
     + * See run_processes_parallel() below for a discussion of the "struct
     + * strbuf *out" parameter.
    -+ * 
    ++ *
     + * The offset refers to the number of bytes originally in "out" before
     + * the output from the child process was buffered. Therefore, the buffer
     + * range, "out + buf" to the end of "out", would contain the buffer of
    @@ run-command.h: typedef int (*start_failure_fn)(struct strbuf *out,
     + *
     + * This function is incompatible with "ungroup"
     + */
    -+typedef void (*duplicate_output_fn)(struct strbuf *out, size_t offset,
    ++typedef void (*on_stderr_output_fn)(struct strbuf *out, size_t offset,
     +				    void *pp_cb, void *pp_task_cb);
     +
      /**
    @@ run-command.h: struct run_process_parallel_opts
      	start_failure_fn start_failure;
      
     +	/**
    -+	 * duplicate_output: See duplicate_output_fn() above. Unless you need
    ++	 * on_stderr_output: See on_stderr_output_fn() above. Unless you need
     +	 * to capture output from child processes, leave this as NULL.
     +	 */
    -+	duplicate_output_fn duplicate_output;
    ++	on_stderr_output_fn on_stderr_output;
     +
      	/**
      	 * task_finished: See task_finished_fn() above. This can be
    @@ t/helper/test-run-command.c: static int no_job(struct child_process *cp,
      	return 0;
      }
      
    -+static void duplicate_output(struct strbuf *out,
    ++static void on_stderr_output(struct strbuf *out,
     +			size_t offset,
     +			void *pp_cb UNUSED,
     +			void *pp_task_cb UNUSED)
    @@ t/helper/test-run-command.c: static int no_job(struct child_process *cp,
     +
     +	string_list_split(&list, out->buf + offset, '\n', -1);
     +	for_each_string_list_item(item, &list)
    -+		fprintf(stderr, "duplicate_output: %s\n", item->string);
    ++		fprintf(stderr, "on_stderr_output: %s\n", item->string);
     +	string_list_clear(&list, 0);
     +}
     +
    @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
      		opts.ungroup = 1;
      	}
      
    -+	if (!strcmp(argv[1], "--duplicate-output")) {
    ++	if (!strcmp(argv[1], "--on-stderr-output")) {
     +		argv += 1;
     +		argc -= 1;
    -+		opts.duplicate_output = duplicate_output;
    ++		opts.on_stderr_output = on_stderr_output;
     +	}
     +
      	jobs = atoi(argv[2]);
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
      	test_cmp expect actual
      '
      
    -+test_expect_success 'run_command runs in parallel with more jobs available than tasks --duplicate-output' '
    -+	test-tool run-command --duplicate-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++test_expect_success 'run_command runs in parallel with more jobs available than tasks --on-stderr-output' '
    ++	test-tool run-command --on-stderr-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    -+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
    -+	test 4 = $(grep -c "duplicate_output: World" err) &&
    -+	sed "/duplicate_output/d" err >err1 &&
    ++	test 4 = $(grep -c "on_stderr_output: Hello" err) &&
    ++	test 4 = $(grep -c "on_stderr_output: World" err) &&
    ++	sed "/on_stderr_output/d" err >err1 &&
     +	test_cmp expect err1
     +'
     +
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with a
      	test_cmp expect actual
      '
      
    -+test_expect_success 'run_command runs in parallel with as many jobs as tasks --duplicate-output' '
    -+	test-tool run-command --duplicate-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++test_expect_success 'run_command runs in parallel with as many jobs as tasks --on-stderr-output' '
    ++	test-tool run-command --on-stderr-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    -+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
    -+	test 4 = $(grep -c "duplicate_output: World" err) &&
    -+	sed "/duplicate_output/d" err >err1 &&
    ++	test 4 = $(grep -c "on_stderr_output: Hello" err) &&
    ++	test 4 = $(grep -c "on_stderr_output: World" err) &&
    ++	sed "/on_stderr_output/d" err >err1 &&
     +	test_cmp expect err1
     +'
     +
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
      	test_cmp expect actual
      '
      
    -+test_expect_success 'run_command runs in parallel with more tasks than jobs available --duplicate-output' '
    -+	test-tool run-command --duplicate-output run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++test_expect_success 'run_command runs in parallel with more tasks than jobs available --on-stderr-output' '
    ++	test-tool run-command --on-stderr-output run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    -+	test 4 = $(grep -c "duplicate_output: Hello" err) &&
    -+	test 4 = $(grep -c "duplicate_output: World" err) &&
    -+	sed "/duplicate_output/d" err >err1 &&
    ++	test 4 = $(grep -c "on_stderr_output: Hello" err) &&
    ++	test 4 = $(grep -c "on_stderr_output: World" err) &&
    ++	sed "/on_stderr_output/d" err >err1 &&
     +	test_cmp expect err1
     +'
     +
    @@ t/t0061-run-command.sh: test_expect_success 'run_command is asked to abort grace
      	test_cmp expect actual
      '
      
    -+test_expect_success 'run_command is asked to abort gracefully --duplicate-output' '
    -+	test-tool run-command --duplicate-output run-command-abort 3 false >out 2>err &&
    ++test_expect_success 'run_command is asked to abort gracefully --on-stderr-output' '
    ++	test-tool run-command --on-stderr-output run-command-abort 3 false >out 2>err &&
     +	test_must_be_empty out &&
     +	test_cmp expect err
     +'
    @@ t/t0061-run-command.sh: test_expect_success 'run_command outputs ' '
      	test_cmp expect actual
      '
      
    -+test_expect_success 'run_command outputs --duplicate-output' '
    -+	test-tool run-command --duplicate-output run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++test_expect_success 'run_command outputs --on-stderr-output' '
    ++	test-tool run-command --on-stderr-output run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
     +	test_cmp expect err
     +'
2:  6ded5b6788 ! 2:  6c62e670f9 submodule: strbuf variable rename
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    submodule: strbuf variable rename
    +    submodule: rename strbuf variable
     
      ## submodule.c ##
     @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untracked)
3:  0c71cea8cd = 3:  24e02f2a24 submodule: move status parsing into function
4:  5c8cc93f9f = 4:  86c1f734a0 submodule: refactor is_submodule_modified()
5:  6c2b62abc8 ! 5:  811a1fee55 diff-lib: refactor out diff_change logic
    @@ diff-lib.c: static int match_stat_with_submodule(struct diff_options *diffopt,
      	return changed;
      }
      
    -+static int diff_change_helper(struct diff_options *options,
    -+	      unsigned newmode, unsigned dirty_submodule,
    -+	      int changed, struct index_state *istate,
    -+	      struct cache_entry *ce)
    ++/**
    ++ * Records diff_change if there is a change in the entry from run_diff_files.
    ++ * If there is no change, then the cache entry is marked CE_UPTODATE and
    ++ * CE_FSMONITOR_VALID. If there is no change and the find_copies_harder flag
    ++ * is not set, then the function returns early.
    ++ */
    ++static void record_file_diff(struct diff_options *options, unsigned newmode,
    ++			     unsigned dirty_submodule, int changed,
    ++			     struct index_state *istate,
    ++			     struct cache_entry *ce)
     +{
     +	unsigned int oldmode;
     +	const struct object_id *old_oid, *new_oid;
    @@ diff-lib.c: static int match_stat_with_submodule(struct diff_options *diffopt,
     +		ce_mark_uptodate(ce);
     +		mark_fsmonitor_valid(istate, ce);
     +		if (!options->flags.find_copies_harder)
    -+			return 1;
    ++			return;
     +	}
     +	oldmode = ce->ce_mode;
     +	old_oid = &ce->oid;
     +	new_oid = changed ? null_oid() : &ce->oid;
    -+	diff_change(options, oldmode, newmode,
    -+			old_oid, new_oid,
    -+			!is_null_oid(old_oid),
    -+			!is_null_oid(new_oid),
    -+			ce->name, 0, dirty_submodule);
    -+	return 0;
    ++	diff_change(options, oldmode, newmode, old_oid, new_oid,
    ++		    !is_null_oid(old_oid), !is_null_oid(new_oid),
    ++		    ce->name, 0, dirty_submodule);
     +}
     +
      int run_diff_files(struct rev_info *revs, unsigned int option)
    @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
     -			    !is_null_oid(new_oid),
     -			    ce->name, 0, dirty_submodule);
     -
    -+		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
    -+				       changed, istate, ce))
    -+			continue;
    ++		record_file_diff(&revs->diffopt, newmode, dirty_submodule,
    ++				 changed, istate, ce);
      	}
      	diffcore_std(&revs->diffopt);
      	diff_flush(&revs->diffopt);
6:  bb25dadbe5 ! 6:  17010fc179 diff-lib: parallelize run_diff_files for submodules
    @@ diff-lib.c: static int check_removed(const struct index_state *istate, const str
     +				     unsigned *ignore_untracked)
      {
      	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
    --	if (S_ISGITLINK(ce->ce_mode)) {
    --		struct diff_flags orig_flags = diffopt->flags;
    --		if (!diffopt->flags.override_submodule_config)
    --			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
    ++	int defer = 0;
    ++
    + 	if (S_ISGITLINK(ce->ce_mode)) {
    + 		struct diff_flags orig_flags = diffopt->flags;
    + 		if (!diffopt->flags.override_submodule_config)
    + 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
     -		if (diffopt->flags.ignore_submodules)
    --			changed = 0;
    ++		if (diffopt->flags.ignore_submodules) {
    + 			changed = 0;
     -		else if (!diffopt->flags.ignore_dirty_submodules &&
     -			 (!changed || diffopt->flags.dirty_submodules))
    -+	struct diff_flags orig_flags;
    -+	int defer = 0;
    -+
    -+	if (!S_ISGITLINK(ce->ce_mode))
    -+		goto ret;
    -+
    -+	orig_flags = diffopt->flags;
    -+	if (!diffopt->flags.override_submodule_config)
    -+		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
    -+	if (diffopt->flags.ignore_submodules) {
    -+		changed = 0;
    -+		goto cleanup;
    -+	}
    -+	if (!diffopt->flags.ignore_dirty_submodules &&
    -+	    (!changed || diffopt->flags.dirty_submodules)) {
    -+		if (defer_submodule_status && *defer_submodule_status) {
    -+			defer = 1;
    -+			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
    -+		} else {
    - 			*dirty_submodule = is_submodule_modified(ce->name,
    +-			*dirty_submodule = is_submodule_modified(ce->name,
     -								 diffopt->flags.ignore_untracked_in_submodules);
    --		diffopt->flags = orig_flags;
    ++		} else if (!diffopt->flags.ignore_dirty_submodules &&
    ++			   (!changed || diffopt->flags.dirty_submodules)) {
    ++			if (defer_submodule_status && *defer_submodule_status) {
    ++				defer = 1;
    ++				*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
    ++			} else {
    ++				*dirty_submodule = is_submodule_modified(ce->name,
     +					 diffopt->flags.ignore_untracked_in_submodules);
    ++			}
     +		}
    + 		diffopt->flags = orig_flags;
      	}
    -+cleanup:
    -+	diffopt->flags = orig_flags;
    -+ret:
    ++
     +	if (defer_submodule_status)
     +		*defer_submodule_status = defer;
      	return changed;
    @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      
      	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
      
    +@@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
    + 		unsigned int newmode;
    + 		struct cache_entry *ce = istate->cache[i];
    + 		int changed;
    +-		unsigned dirty_submodule = 0;
    ++		int defer_submodule_status = 1;
    + 
    + 		if (diff_can_quit_early(&revs->diffopt))
    + 			break;
     @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      			newmode = ce->ce_mode;
      		} else {
      			struct stat st;
     +			unsigned ignore_untracked = 0;
    -+			int defer_submodule_status = 1;
      
      			changed = check_removed(istate, ce, &st);
      			if (changed) {
    @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      
      			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
     -							    ce_option, &dirty_submodule);
    -+							    ce_option, &dirty_submodule,
    ++							    ce_option, NULL,
     +							    &defer_submodule_status,
     +							    &ignore_untracked);
      			newmode = ce_mode_from_stat(ce, st.st_mode);
    @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
     +			}
      		}
      
    - 		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
    - 				       changed, istate, ce))
    - 			continue;
    - 	}
    +-		record_file_diff(&revs->diffopt, newmode, dirty_submodule,
    +-				 changed, istate, ce);
    ++		if (!defer_submodule_status)
    ++			record_file_diff(&revs->diffopt, newmode, 0,
    ++					   changed,istate, ce);
    ++	}
     +	if (submodules.nr) {
     +		unsigned long parallel_jobs;
     +		struct string_list_item *item;
    @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
     +		for_each_string_list_item(item, &submodules) {
     +			struct submodule_status_util *util = item->util;
     +
    -+			if (diff_change_helper(&revs->diffopt, util->newmode,
    -+				       util->dirty_submodule, util->changed,
    -+				       istate, util->ce))
    -+				continue;
    ++			record_file_diff(&revs->diffopt, util->newmode,
    ++					 util->dirty_submodule, util->changed,
    ++					 istate, util->ce);
     +		}
    -+	}
    + 	}
     +	string_list_clear(&submodules, 1);
      	diffcore_std(&revs->diffopt);
      	diff_flush(&revs->diffopt);
    @@ submodule.c: struct fetch_task {
      /**
       * When a submodule is not defined in .gitmodules, we cannot access it
       * via the regular submodule-config. Create a fake submodule, which we can
    -@@ submodule.c: static int parse_status_porcelain(char *str, size_t len,
    - 	return 0;
    - }
    - 
    -+static void parse_status_porcelain_strbuf(struct strbuf *buf,
    -+				   unsigned *dirty_submodule,
    -+				   int ignore_untracked)
    -+{
    -+	struct string_list list = STRING_LIST_INIT_DUP;
    -+	struct string_list_item *item;
    -+
    -+	string_list_split(&list, buf->buf, '\n', -1);
    -+
    -+	for_each_string_list_item(item, &list) {
    -+		if (parse_status_porcelain(item->string,
    -+					   strlen(item->string),
    -+					   dirty_submodule,
    -+					   ignore_untracked))
    -+			break;
    -+	}
    -+	string_list_clear(&list, 0);
    -+}
    -+
    - unsigned is_submodule_modified(const char *path, int ignore_untracked)
    - {
    - 	struct child_process cp = CHILD_PROCESS_INIT;
     @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untracked)
      	return dirty_submodule;
      }
    @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
     +	return 0;
     +}
     +
    -+static void status_duplicate_output(struct strbuf *out,
    ++static void status_on_stderr_output(struct strbuf *out,
     +				    size_t offset,
     +				    void *cb, void *task_cb)
     +{
    @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
     +	struct string_list_item *it =
     +		string_list_lookup(sps->submodule_names, task->path);
     +	struct submodule_status_util *util = it->util;
    ++	struct string_list list = STRING_LIST_INIT_DUP;
    ++	struct string_list_item *item;
     +
     +	if (retvalue) {
     +		sps->result = 1;
     +		strbuf_addf(err, _(STATUS_PORCELAIN_FAIL_ERROR), task->path);
     +	}
     +
    -+	parse_status_porcelain_strbuf(&task->out,
    -+			      &util->dirty_submodule,
    -+			      util->ignore_untracked);
    -+
    ++	string_list_split(&list, task->out.buf, '\n', -1);
    ++	for_each_string_list_item(item, &list) {
    ++		if (parse_status_porcelain(item->string,
    ++					   strlen(item->string),
    ++					   &util->dirty_submodule,
    ++					   util->ignore_untracked))
    ++			break;
    ++	}
    ++	string_list_clear(&list, 0);
     +	strbuf_release(&task->out);
     +	free(task);
     +
    @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
     +
     +		.get_next_task = get_next_submodule_status,
     +		.start_failure = status_start_failure,
    -+		.duplicate_output = status_duplicate_output,
    ++		.on_stderr_output = status_on_stderr_output,
     +		.task_finished = status_finish,
     +		.data = &sps,
     +	};
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

