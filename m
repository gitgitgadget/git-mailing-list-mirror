Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CBDC433E3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BD3207D3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGknWutz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHROZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHROZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85512C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so18453805wrm.12
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5zQFRausMPCIZdHfZpeof/sRkUjUCWwQYaXTLqsstk8=;
        b=rGknWutzHJNvVZXorOgWaEHUTvJglqSnS++AVYvWtC6uRM5hTMjbYBsfAUGBiPbMAa
         0R1pCSkAGh7/sMLncFzecjqDIhHvOsLZN0Rsu80kMhWb47L+5R2scxZbnhSL7YdvBKlR
         GQUbITcg5ByB4xmEIvoVyYT2nZ1dCAcoKm8Ije0vocKYsEM0xRcG8X8+5dnyflwQ5Ark
         iINAQxKD4FWlD0500p5Jn0snEl3CYBs3sWaiOZqcJneVdzvxPHyY/mXobxAGMjz+qIvd
         rAP7M+VgW0egnW84jpCZ/75VvMAeUZoRcN1nhxecb+ZTpnu3U52JOXYlY43eXdekpJol
         IWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5zQFRausMPCIZdHfZpeof/sRkUjUCWwQYaXTLqsstk8=;
        b=jDWgMA3h+/JFlVw537K830olemkwSk7RHVl5gcRG5TE6sUoU6BDO7RslTDbogZhsv6
         pwXFyOj3dVJNqcN0a4v0gUrRZtGXv0b+KcJ8Q8DUZymvEHNRP3h/rx9IfLGC5MN3ck/x
         tqFnJaLXgzfW9NH+1Jd9oc7iobf27DRNogRVEDUAfZOwaTh5k2XvG/5sd2L2XmOvEm3D
         Yp14TWxToOiq4lNaIw7F4lmYTpTJTaV2VtPfgPSfwUzou9+RHzj5/wcw/QPUS/oTdzqk
         mzqBGM9L119imMS4R6UPm3+OA79p09xIpFnDoOr8hS2eErgdddm1ijnjsuyFvO65g578
         1W1w==
X-Gm-Message-State: AOAM533JxPpcnvYoE5JxV5dLaJS3p4whN3KxSO1ad5GKhydLStn7+3+r
        pQKnFNfWBMIXTfsa+Vy4AltjwF0zIbI=
X-Google-Smtp-Source: ABdhPJz5zzAJZXTQDcNDVebk8Kx9ieBMxcjiXVR8JZ2C6CHwD+VLTei2LWVmNQinzQ9pU6p3yXbOVQ==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr21315878wrs.9.1597760732516;
        Tue, 18 Aug 2020 07:25:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h189sm171189wme.17.2020.08.18.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:31 -0700 (PDT)
Message-Id: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.git.1596731424.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:21 +0000
Subject: [PATCH v2 0/9] Maintenance II: prefetch, loose-objects, incremental-repack tasks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on part I [2].

This patch series contains 9 patches that were going to be part of v4 of
ds/maintenance [1], but the discussion has gotten really long. To help, I'm
splitting out the portions that create and test the 'maintenance' builtin
from the additional tasks (prefetch, loose-objects, incremental-repack) that
can be brought in later.

[1] 
https://lore.kernel.org/git/pull.671.git.1594131695.gitgitgadget@gmail.com/
[2] 
https://lore.kernel.org/git/pull.695.git.1596728921.gitgitgadget@gmail.com/

As detailed in [2], the 'git maintenance run' subcommand will run certain
tasks based on config options or the --task= arguments. The --auto option
indicates to the task to only run based on some internal check that there
has been "enough" change in that domain to merit the work. In the case of
the 'gc' task, this also reduces the amount of work done. 

The new maintenance tasks in this series are:

 * 'loose-objects' : prune packed loose objects, then create a new pack from
   a batch of loose objects.
 * 'pack-files' : expire redundant packs from the multi-pack-index, then
   repack using the multi-pack-index's incremental repack strategy.
 * 'prefetch' : fetch from each remote, storing the refs in 'refs/prefetch/
   /'.

These tasks are all disabled by default, but can be enabled with config
options or run explicitly using "git maintenance run --task=". 

Since [2] replaced the 'git gc --auto' calls with 'git maintenance run
--auto' at the end of some Git commands, users could replace the 'gc' task
with these lighter-weight changes for foreground maintenance.

The 'git maintenance' builtin has a 'run' subcommand so it can be extended
later with subcommands that manage background maintenance, such as 'start'
or 'stop'. These are not the subject of this series, as it is important to
focus on the maintenance activities themselves. I have a WIP series for this
available at [3].

[3] https://github.com/gitgitgadget/git/pull/680

Updates since v1 (of this series)
=================================

 * PATCH 1 ("fetch: optionally allow disabling FETCH_HEAD update") was
   rewritten on-list. Getting a version out with this patch is the main
   reason for rolling a v2. (That, and Part I is re-rolled with a v2 and I
   want to make sure this series applies cleanly.)
   
   
 * The 'prefetch' and 'loose-objects' tasks had some review, but my proposed
   changes were not acked, so they may need another review.
   
   

UPDATES since v3 of [1]
=======================

 * The biggest change here is the use of "test_subcommand", based on
   Jonathan Nieder's approach. This requires having the exact command-line
   figured out, which now requires spelling out all --no- [quiet%7Cprogress] 
   options. I also added a bunch of "2>/dev/null" checks because of the
   isatty(2) calls. Without that, the behavior will change depending on
   whether the test is run with -x/-v or without.
   
   
 * The 0x7FFF/0x7FFFFFFF constant problem is fixed with an EXPENSIVE test
   that verifies it.
   
   
 * The option parsing has changed to use a local struct and pass that struct
   to the helper methods. This is instead of having a global singleton.
   
   

Thanks, -Stolee

Derrick Stolee (8):
  maintenance: add prefetch task
  maintenance: add loose-objects task
  maintenance: create auto condition for loose-objects
  midx: enable core.multiPackIndex by default
  midx: use start_delayed_progress()
  maintenance: add incremental-repack task
  maintenance: auto-size incremental-repack batch
  maintenance: add incremental-repack auto condition

Junio C Hamano (1):
  fetch: optionally allow disabling FETCH_HEAD update

 Documentation/config/core.txt        |   4 +-
 Documentation/config/maintenance.txt |  18 ++
 Documentation/fetch-options.txt      |   9 +
 Documentation/git-maintenance.txt    |  45 ++++
 builtin/fetch.c                      |  15 +-
 builtin/gc.c                         | 363 +++++++++++++++++++++++++++
 midx.c                               |  23 +-
 midx.h                               |   1 +
 repo-settings.c                      |   6 +
 repository.h                         |   2 +
 t/t5319-multi-pack-index.sh          |  15 +-
 t/t5510-fetch.sh                     |  15 +-
 t/t5521-pull-options.sh              |   7 +
 t/t7900-maintenance.sh               | 191 ++++++++++++++
 14 files changed, 686 insertions(+), 28 deletions(-)


base-commit: 46fbe161aa154de9406117ee916b1bd5f549905c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-696%2Fderrickstolee%2Fmaintenance%2Fgc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-696/derrickstolee/maintenance/gc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/696

Range-diff vs v1:

  1:  83401c5200 !  1:  f3bc0b2d92 fetch: optionally allow disabling FETCH_HEAD update
     @@ Commit message
          refs (e.g. you fetch and then merge origin/branchname separately),
          you can get away with having no FETCH_HEAD at all.
      
     -    Teach "git fetch" a command line option "--[no-]write-fetch-head"
     -    and "fetch.writeFetchHEAD" configuration variable.  Without either,
     -    the default is to write FETCH_HEAD, and the usual rule that the
     -    command line option defeats configured default applies.
     +    Teach "git fetch" a command line option "--[no-]write-fetch-head".
     +    The default is to write FETCH_HEAD, and the option is primarily
     +    meant to be used with the "--no-" prefix to override this default,
     +    because there is no matching fetch.writeFetchHEAD configuration
     +    variable to flip the default to off (in which case, the positive
     +    form may become necessary to defeat it).
      
          Note that under "--dry-run" mode, FETCH_HEAD is never written;
          otherwise you'd see list of objects in the file that you do not
          actually have.  Passing `--write-fetch-head` does not force `git
          fetch` to write the file.
      
     -    Also note that this option is explicitly passed when "git pull"
     -    internally invokes "git fetch", so that those who configured their
     -    "git fetch" not to write FETCH_HEAD would not be able to break the
     -    cooperation between these two commands.  "git pull" must see what
     -    "git fetch" got recorded in FETCH_HEAD to work correctly.
     -
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     -
     - ## Documentation/config/fetch.txt ##
     -@@ Documentation/config/fetch.txt: fetch.writeCommitGraph::
     - 	merge and the write may take longer. Having an updated commit-graph
     - 	file helps performance of many Git commands, including `git merge-base`,
     - 	`git push -f`, and `git log --graph`. Defaults to false.
     -+
     -+fetch.writeFetchHEAD::
     -+	Setting it to false tells `git fetch` not to write the list
     -+	of remote refs fetched in the `FETCH_HEAD` file directly
     -+	under `$GIT_DIR`.  Can be countermanded from the command
     -+	line with the `--[no-]write-fetch-head` option.  Defaults to
     -+	true.
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/fetch-options.txt ##
      @@ Documentation/fetch-options.txt: documented in linkgit:git-config[1].
     @@ Documentation/fetch-options.txt: documented in linkgit:git-config[1].
      +ifndef::git-pull[]
      +--[no-]write-fetch-head::
      +	Write the list of remote refs fetched in the `FETCH_HEAD`
     -+	file directly under `$GIT_DIR`.  This is the default unless
     -+	the configuration variable `fetch.writeFetchHEAD` is set to
     -+	false.  Passing `--no-write-fetch-head` from the command
     -+	line tells Git not to write the file.  Under `--dry-run`
     -+	option, the file is never written.
     ++	file directly under `$GIT_DIR`.  This is the default.
     ++	Passing `--no-write-fetch-head` from the command line tells
     ++	Git not to write the file.  Under `--dry-run` option, the
     ++	file is never written.
      +endif::git-pull[]
      +
       -f::
     @@ builtin/fetch.c: static int prune_tags = -1; /* unspecified */
       static int verbosity, deepen_relative, set_upstream;
       static int progress = -1;
       static int enable_auto_gc = 1;
     -@@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v, void *cb)
     - 		return 0;
     - 	}
     - 
     -+	if (!strcmp(k, "fetch.writefetchhead")) {
     -+		write_fetch_head = git_config_bool(k, v);
     -+		return 0;
     -+	}
     - 	return git_default_config(k, v, cb);
     - }
     - 
      @@ builtin/fetch.c: static struct option builtin_fetch_options[] = {
       		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
       	OPT_BOOL(0, "dry-run", &dry_run,
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
       		if (argc == 1)
       			die(_("fetch --all does not take a repository argument"));
      
     - ## builtin/pull.c ##
     -@@ builtin/pull.c: static int run_fetch(const char *repo, const char **refspecs)
     - 	struct strvec args = STRVEC_INIT;
     - 	int ret;
     - 
     --	strvec_pushl(&args, "fetch", "--update-head-ok", NULL);
     -+	strvec_pushl(&args, "fetch", "--update-head-ok",
     -+		     "--write-fetch-head", NULL);
     - 
     - 	/* Shared options */
     - 	argv_push_verbosity(&args);
     -
       ## t/t5510-fetch.sh ##
      @@ t/t5510-fetch.sh: test_expect_success 'fetch into the current branch with --update-head-ok' '
       
     @@ t/t5510-fetch.sh: test_expect_success 'fetch into the current branch with --upda
      +	git fetch --dry-run --write-fetch-head . &&
      +	! test -f .git/FETCH_HEAD
      +'
     -+
     -+test_expect_success 'fetch.writeFetchHEAD and FETCH_HEAD' '
     -+	rm -f .git/FETCH_HEAD &&
     -+	git -c fetch.writeFetchHEAD=no fetch . &&
     -+	! test -f .git/FETCH_HEAD
     -+'
     -+
     -+test_expect_success 'fetch.writeFetchHEAD gets defeated by --dry-run' '
     -+	rm -f .git/FETCH_HEAD &&
     -+	git -c fetch.writeFetchHEAD=yes fetch --dry-run . &&
     -+	! test -f .git/FETCH_HEAD
     -+'
     -+
     -+test_expect_success 'fetch.writeFetchHEAD and --no-write-fetch-head' '
     -+	rm -f .git/FETCH_HEAD &&
     -+	git -c fetch.writeFetchHEAD=yes fetch --no-write-fetch-head . &&
     -+	! test -f .git/FETCH_HEAD
     -+'
     -+
     -+test_expect_success 'fetch.writeFetchHEAD and --write-fetch-head' '
     -+	rm -f .git/FETCH_HEAD &&
     -+	git -c fetch.writeFetchHEAD=no fetch --write-fetch-head . &&
     -+	test -f .git/FETCH_HEAD
     -+'
      +
       test_expect_success "should be able to fetch with duplicate refspecs" '
       	mkdir dups &&
       	(
      
       ## t/t5521-pull-options.sh ##
     -@@ t/t5521-pull-options.sh: test_expect_success 'git pull -q -v --no-rebase' '
     - 	test_must_be_empty out &&
     - 	test -s err)
     - '
     -+
     - test_expect_success 'git pull --cleanup errors early on invalid argument' '
     - 	mkdir clonedcleanup &&
     - 	(cd clonedcleanup && git init &&
      @@ t/t5521-pull-options.sh: test_expect_success 'git pull --cleanup errors early on invalid argument' '
       	test -s err)
       '
     @@ t/t5521-pull-options.sh: test_expect_success 'git pull --cleanup errors early on
      +test_expect_success 'git pull --no-write-fetch-head fails' '
      +	mkdir clonedwfh &&
      +	(cd clonedwfh && git init &&
     -+	test_must_fail git pull --no-write-fetch-head "../parent" >out 2>err &&
     ++	test_expect_code 129 git pull --no-write-fetch-head "../parent" >out 2>err &&
      +	test_must_be_empty out &&
      +	test_i18ngrep "no-write-fetch-head" err)
     -+'
     -+
     -+test_expect_success 'git pull succeeds with fetch.writeFetchHEAD=false' '
     -+	mkdir clonedwfhconfig &&
     -+	(cd clonedwfhconfig && git init &&
     -+	git config fetch.writeFetchHEAD false &&
     -+	git pull "../parent" >out 2>err &&
     -+	grep FETCH_HEAD err)
      +'
       
       test_expect_success 'git pull --force' '
  2:  85118ed5f1 !  2:  8779c6c20d maintenance: add prefetch task
     @@ Documentation/git-maintenance.txt: since it will not expire `.graph` files that
      +any object transfer.
      +
       gc::
     - 	Cleanup unnecessary files and optimize the local repository. "GC"
     + 	Clean up unnecessary files and optimize the local repository. "GC"
       	stands for "garbage collection," but this task performs many
      
       ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_opts *
      +
      +	child.git_cmd = 1;
      +	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
     -+		     "--no-write-fetch-head", "--refmap=", NULL);
     ++		     "--no-write-fetch-head", "--recurse-submodules=no",
     ++		     "--refmap=", NULL);
      +
      +	if (opts->quiet)
      +		strvec_push(&child.args, "--quiet");
     @@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_opts *
      +	return !!run_command(&child);
      +}
      +
     -+static int fill_each_remote(struct remote *remote, void *cbdata)
     ++static int append_remote(struct remote *remote, void *cbdata)
      +{
      +	struct string_list *remotes = (struct string_list *)cbdata;
      +
     @@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_opts *
      +	struct string_list_item *item;
      +	struct string_list remotes = STRING_LIST_INIT_DUP;
      +
     -+	if (for_each_remote(fill_each_remote, &remotes)) {
     ++	if (for_each_remote(append_remote, &remotes)) {
      +		error(_("failed to fill remotes"));
      +		result = 1;
      +		goto cleanup;
      +	}
      +
     -+	for (item = remotes.items;
     -+	     item && item < remotes.items + remotes.nr;
     -+	     item++)
     ++	for_each_string_list_item(item, &remotes)
      +		result |= fetch_remote(item->string, opts);
      +
      +cleanup:
     @@ t/t7900-maintenance.sh: test_expect_success 'run --task duplicate' '
      +	test_commit -C clone1 one &&
      +	test_commit -C clone2 two &&
      +	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
     -+	fetchargs="--prune --no-tags --no-write-fetch-head --refmap= --quiet" &&
     ++	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
      +	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
      +	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
      +	test_path_is_missing .git/refs/remotes &&
     -+	test_cmp clone1/.git/refs/heads/one .git/refs/prefetch/remote1/one &&
     -+	test_cmp clone2/.git/refs/heads/two .git/refs/prefetch/remote2/two &&
      +	git log prefetch/remote1/one &&
     -+	git log prefetch/remote2/two
     ++	git log prefetch/remote2/two &&
     ++	git fetch --all &&
     ++	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
     ++	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two
      +'
      +
       test_done
  3:  621375a3c9 !  3:  4fa9d298b9 maintenance: add loose-objects task
     @@ Commit message
      
       ## Documentation/git-maintenance.txt ##
      @@ Documentation/git-maintenance.txt: gc::
     - 	It can also be disruptive in some situations, as it deletes stale
     - 	data.
     + 	be disruptive in some situations, as it deletes stale data. See
     + 	linkgit:git-gc[1] for more details on garbage collection in Git.
       
      +loose-objects::
      +	The `loose-objects` job cleans up loose objects and places them into
     @@ Documentation/git-maintenance.txt: gc::
      +	object. Second, it creates a new pack-file (starting with "loose-")
      +	containing a batch of loose objects. The batch size is limited to 50
      +	thousand objects to prevent the job from taking too long on a
     -+	repository with many loose objects.
     ++	repository with many loose objects. The `gc` task writes unreachable
     ++	objects as loose objects to be cleaned up by a later step only if
     ++	they are not re-added to a pack-file; for this reason it is not
     ++	advisable to enable both the `loose-objects` and `gc` tasks at the
     ++	same time.
      +
       OPTIONS
       -------
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
     - 	git log prefetch/remote2/two
     + 	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two
       '
       
      +test_expect_success 'loose-objects task' '
  4:  e787403ea7 =  4:  3432bc3167 maintenance: create auto condition for loose-objects
  5:  37e59b1a8d =  5:  0ee2434bdb midx: enable core.multiPackIndex by default
  6:  aba087f663 =  6:  e157ea8dd7 midx: use start_delayed_progress()
  7:  68727c555b !  7:  a8d956dad6 maintenance: add incremental-repack task
     @@ Commit message
      
       ## Documentation/git-maintenance.txt ##
      @@ Documentation/git-maintenance.txt: loose-objects::
     - 	thousand objects to prevent the job from taking too long on a
     - 	repository with many loose objects.
     + 	advisable to enable both the `loose-objects` and `gc` tasks at the
     + 	same time.
       
      +incremental-repack::
      +	The `incremental-repack` job repacks the object directory
  8:  c3487fb8e3 =  8:  f0e7276755 maintenance: auto-size incremental-repack batch
  9:  407c123c51 !  9:  5659a23ad5 maintenance: add incremental-repack auto condition
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
       		"gc",
      
       ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
     - '
     - 
     - test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
     -+
     - 	for i in $(test_seq 1 5)
     - 	do
     - 		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
      @@ t/t7900-maintenance.sh: test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
       		 --no-progress --batch-size=2147483647 <run-2g.txt
       '

-- 
gitgitgadget
