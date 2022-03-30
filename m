Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA7C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiC3FHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiC3FHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9FD65D19
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w21so23002462wra.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ETQWjPAg822k9khu4mIJKXMJixXYibnuC996RznaLNQ=;
        b=UDoiSC26BoyaFpwiMm25IJ3mxFoTXawRa2NujJDioQkR8dxdthDGUgK1rPjRHZUkjP
         yjn5XeuoQYgkEE5W2M6ABqskOFKK04q9NoLye+uZZKptpWf/MLZTxbdROiPtiqL7WoSy
         xBIqk8Jo1o2oUH1n/AGxoC1TKfbnS0jGKtoam8oGGHGZQ2/cf6TmgjdMnJ5SKlVmPGwW
         /omrOGoflo66O8tGjfVx+dE2DfsWNXbpvaWIB1fFUyKamCpZ6w68r8FJ/80hxkq3Z7xh
         IB83Cwbd4VkvYg24i3jcSf/1qdJiuz1kdD/fxUZtKw4grDzmWk2+QkAdwCu6YLnf6Qrp
         KDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ETQWjPAg822k9khu4mIJKXMJixXYibnuC996RznaLNQ=;
        b=sTq3UFzYxOJwP88Ivb1FnHnrocd8KfzhzROeHVOSBaF01P4Go+oUeUQ/7T0cjzpQUn
         fgAMaYZjlwNzJ0o6lR45VQz51Ty1Ib3nlZxUcllYOdsD/uOu9k/UdXeHUS8PUsp2J5i9
         W8B0/ly0JILY6wm4EO7VMa8qw4bNB2sM+0UnUIprc1QdP1XexRLYAdMZeoN5E1eTlkHI
         y+wRDQ3q5X+ZbKl7C23G4lThifbPs6iJMRXeCXoBp8cTTEzQ+pjK5fSd0n9EoPGifM5u
         uSeJDRJGkxHWfBOo2hPvWPR35BJFvuRK16HuhuLf0Nx8VIsERLAXzl8dPYsX3Whs44B8
         +aPw==
X-Gm-Message-State: AOAM530CGYBk5CruSLEhJHYcfqvSilW9YUia88/65Theg3sx5biFsgQV
        b8aZU8Pg9humPqtrQu+RGqEIkA+oDHM=
X-Google-Smtp-Source: ABdhPJzhtfdca/It2BDcuBr903spUGqQby8pNIktg+H5pcRJSy+lJ6YZR7qXu+COhNBNXO8UOCPuGQ==
X-Received: by 2002:adf:a497:0:b0:203:d9cd:4c94 with SMTP id g23-20020adfa497000000b00203d9cd4c94mr35443089wrb.368.1648616735710;
        Tue, 29 Mar 2022 22:05:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm17860898wrs.43.2022.03.29.22.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:35 -0700 (PDT)
Message-Id: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:18 +0000
Subject: [PATCH v5 00/14] core.fsyncmethod: add 'batch' mode for faster fsyncing of multiple objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V5 changes:

 * Remove 'local-with-assignment' from perf-lib.sh
 * Add a new patch to put an ODB transaction around add_files_to_cache.
 * Move the perf tests to t/perf/p0008-odb-fsync.sh and add more perf tests.

V4 changes:

 * Make ODB transactions nestable.
 * Add an ODB transaction around writing out the cached tree.
 * Change update-index to use a more straightforward way of managing ODB
   transactions.
 * Fix missing 'local's in lib-unique-files
 * Add a per-iteration setup mechanism to test_perf.
 * Fix camelCasing in warning message.

V3 changes:

 * Rebrand plug/unplug-bulk-checkin to "begin_odb_transaction" and
   "end_odb_transaction"
 * Add a patch to pass filenames to fsync_or_die, rather than the string
   "loose object"
 * Update the commit description for "core.fsyncmethod to explain why we do
   not directly expose objects until an fsync occurs.
 * Also explain in the commit description why we're using a dummy file for
   the fsync.
 * Create the bulk-fsync tmp-objdir lazily the first time a loose object is
   added. We now do fsync iff that objdir exists.
 * Do batch fsync if core.fsyncMethod=batch and core.fsync contains
   loose-object, regardless of the core.fsyncObjectFiles setting.
 * Mitigate the risk in update-index of an object not being visible due to
   bulk checkin.
 * Add a perf comment to justify the unpack-objects usage of bulk-checkin.
 * Add a new patch to create helpers for parsing OIDs from git commands.
 * Add a comment to the lib-unique-files.sh helper about uniqueness only
   within a repo.
 * Fix style and add '&&' chaining to test helpers.
 * Comment on some magic numbers in tests.
 * Take the object list as an argument in
   ./t5300-pack-object.sh:check_unpack ()
 * Drop accidental change to t/perf/perf-lib.sh

V2 changes:

 * Change doc to indicate that only some repo updates are batched
 * Null and zero out control variables in do_batch_fsync under
   unplug_bulk_checkin
 * Make batch mode default on Windows.
 * Update the description for the initial patch that cleans up the
   bulk-checkin infrastructure.
 * Rebase onto 'seen' at 0cac37f38f9.

--Original definition-- When core.fsync includes loose-object, we issue an
fsync after every written object. For a 'git-add' or similar command that
adds a lot of files to the repo, the costs of these fsyncs adds up. One
major factor in this cost is the time it takes for the physical storage
controller to flush its caches to durable media.

This series takes advantage of the writeout-only mode of git_fsync to issue
OS cache writebacks for all of the objects being added to the repository
followed by a single fsync to a dummy file, which should trigger a
filesystem log flush and storage controller cache flush. This mechanism is
known to be safe on common Windows filesystems and expected to be safe on
macOS. Some linux filesystems, such as XFS, will probably do the right thing
as well. See [1] for previous discussion on the predecessor of this patch
series.

This series is important on Windows, where loose-objects are included in the
fsync set by default in Git-For-Windows. In this series, I'm also setting
the default mode for Windows to turn on loose object fsyncing with batch
mode, so that we can get CI coverage of the actual git-for-windows
configuration upstream. We still don't actually issue fsyncs for the test
suite since GIT_TEST_FSYNC is set to 0, but we exercise all of the
surrounding batch mode code.

This work is based on 'next' at c54b8eb302. It's dependent on
ns/core-fsyncmethod.

[1]
https://lore.kernel.org/git/2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com/

Neeraj Singh (14):
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
  object-file: pass filename to fsync_or_die
  core.fsyncmethod: batched disk flushes for loose-objects
  cache-tree: use ODB transaction around writing a tree
  builtin/add: add ODB transaction around add_files_to_cache
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsync: use batch mode and sync loose objects by default on
    Windows
  test-lib-functions: add parsing helpers for ls-files and ls-tree
  core.fsyncmethod: tests for batch mode
  t/perf: add iteration setup mechanism to perf-lib
  core.fsyncmethod: performance tests for batch mode
  core.fsyncmethod: correctly camel-case warning message

 Documentation/config/core.txt          |   8 ++
 builtin/add.c                          |  13 +++-
 builtin/unpack-objects.c               |   3 +
 builtin/update-index.c                 |  24 ++++++
 bulk-checkin.c                         | 101 ++++++++++++++++++++++---
 bulk-checkin.h                         |  17 ++++-
 cache-tree.c                           |   3 +
 cache.h                                |  12 ++-
 compat/mingw.h                         |   3 +
 config.c                               |   6 +-
 git-compat-util.h                      |   2 +
 object-file.c                          |  15 ++--
 t/lib-unique-files.sh                  |  34 +++++++++
 t/perf/p0008-odb-fsync.sh              |  81 ++++++++++++++++++++
 t/perf/p4220-log-grep-engines.sh       |   3 +-
 t/perf/p4221-log-grep-engines-fixed.sh |   3 +-
 t/perf/p5302-pack-index.sh             |  15 ++--
 t/perf/p7519-fsmonitor.sh              |  18 +----
 t/perf/p7820-grep-engines.sh           |   6 +-
 t/perf/perf-lib.sh                     |  62 +++++++++++++--
 t/t3700-add.sh                         |  28 +++++++
 t/t3903-stash.sh                       |  20 +++++
 t/t5300-pack-object.sh                 |  41 ++++++----
 t/t5317-pack-objects-filter-objects.sh |  91 +++++++++++-----------
 t/test-lib-functions.sh                |  10 +++
 25 files changed, 501 insertions(+), 118 deletions(-)
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p0008-odb-fsync.sh


base-commit: c54b8eb302ffb72f31e73a26044c8a864e2cb307
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1134%2Fneerajsi-msft%2Fns%2Fbatched-fsync-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1134/neerajsi-msft/ns/batched-fsync-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1134

Range-diff vs v4:

  1:  c7a2a7efe6d =  1:  c7a2a7efe6d bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  2:  d045b13795b =  2:  d045b13795b bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
  3:  2d1bc4568ac =  3:  2d1bc4568ac object-file: pass filename to fsync_or_die
  4:  9e7ae22fa4a =  4:  9e7ae22fa4a core.fsyncmethod: batched disk flushes for loose-objects
  5:  83fa4a5f3a5 =  5:  83fa4a5f3a5 cache-tree: use ODB transaction around writing a tree
  -:  ----------- >  6:  d514842ad49 builtin/add: add ODB transaction around add_files_to_cache
  6:  f03ebee695a =  7:  8cac94598a5 update-index: use the bulk-checkin infrastructure
  7:  d85013f7d2c =  8:  523e5fbd63e unpack-objects: use the bulk-checkin infrastructure
  8:  73e54f94c20 =  9:  faacc19aab2 core.fsync: use batch mode and sync loose objects by default on Windows
  9:  124450c86d9 = 10:  4de7300a7b0 test-lib-functions: add parsing helpers for ls-files and ls-tree
 10:  282fbdef792 = 11:  1a4aff8c350 core.fsyncmethod: tests for batch mode
 11:  ee7ecf4cabe ! 12:  47cc63e1dda t/perf: add iteration setup mechanism to perf-lib
     @@ t/perf/perf-lib.sh: exit $ret' >&3 2>&4
       }
       
       test_wrapper_ () {
     --	test_wrapper_func_=$1; shift
     -+	local test_wrapper_func_=$1; shift
     -+	local test_title_=$1; shift
     ++	local test_wrapper_func_ test_title_
     + 	test_wrapper_func_=$1; shift
     ++	test_title_=$1; shift
       	test_start_
      -	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
      -	test "$#" = 2 ||
     @@ t/perf/perf-lib.sh: exit $ret' >&3 2>&4
       	export test_prereq
      -	if ! test_skip "$@"
      +	export test_perf_setup_
     ++
      +	if ! test_skip "$test_title_" "$@"
       	then
       		base=$(basename "$0" .sh)
 12:  fdf90d45f52 ! 13:  26be6ecb28b core.fsyncmethod: performance tests for add and stash
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    core.fsyncmethod: performance tests for add and stash
     +    core.fsyncmethod: performance tests for batch mode
      
     -    Add basic performance tests for "git add" and "git stash" of a lot of
     -    new objects with various fsync settings. This shows the benefit of batch
     -    mode relative to full fsync.
     +    Add basic performance tests for git commands that can add data to the
     +    object database. We cover:
     +    * git add
     +    * git stash
     +    * git update-index (via git stash)
     +    * git unpack-objects
     +    * git commit --all
     +
     +    We cover all currently available fsync methods as well.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     - ## t/perf/p3700-add.sh (new) ##
     + ## t/perf/p0008-odb-fsync.sh (new) ##
      @@
      +#!/bin/sh
      +#
     -+# This test measures the performance of adding new files to the object database
     -+# and index. The test was originally added to measure the effect of the
     -+# core.fsyncMethod=batch mode, which is why we are testing different values
     -+# of that setting explicitly and creating a lot of unique objects.
     ++# This test measures the performance of adding new files to the object
     ++# database. The test was originally added to measure the effect of the
     ++# core.fsyncMethod=batch mode, which is why we are testing different values of
     ++# that setting explicitly and creating a lot of unique objects.
      +
      +test_description="Tests performance of adding things to the object database"
      +
     -+# Fsync is normally turned off for the test suite.
     -+GIT_TEST_FSYNC=1
     -+export GIT_TEST_FSYNC
     -+
      +. ./perf-lib.sh
      +
      +. $TEST_DIRECTORY/lib-unique-files.sh
     @@ t/perf/p3700-add.sh (new)
      +files_per_dir=50
      +total_files=$((dir_count * files_per_dir))
      +
     -+for mode in false true batch
     -+do
     -+	case $mode in
     -+	false)
     -+		FSYNC_CONFIG='-c core.fsync=-loose-object -c core.fsyncmethod=fsync'
     -+		;;
     -+	true)
     -+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=fsync'
     -+		;;
     -+	batch)
     -+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=batch'
     -+		;;
     -+	esac
     ++populate_files () {
     ++	test_create_unique_files $dir_count $files_per_dir files
     ++}
     ++
     ++setup_repo () {
     ++	(rm -rf .git || 1) &&
     ++	git init &&
     ++	test_commit first &&
     ++	populate_files
     ++}
     ++
     ++test_perf_fsync_cfgs () {
     ++	local method cfg &&
     ++	for method in none fsync batch writeout-only
     ++	do
     ++		case $method in
     ++		none)
     ++			cfg="-c core.fsync=none"
     ++			;;
     ++		*)
     ++			cfg="-c core.fsync=loose-object -c core.fsyncMethod=$method"
     ++		esac &&
     ++
     ++		# Set GIT_TEST_FSYNC=1 explicitly since fsync is normally
     ++		# disabled by t/test-lib.sh.
     ++		if ! test_perf "$1 (fsyncMethod=$method)" \
     ++						--setup "$2" \
     ++						"GIT_TEST_FSYNC=1 git $cfg $3"
     ++		then
     ++			break
     ++		fi
     ++	done
     ++}
     ++
     ++test_perf_fsync_cfgs "add $total_files files" \
     ++	"setup_repo" \
     ++	"add -- files"
     ++
     ++test_perf_fsync_cfgs "stash $total_files files" \
     ++	"setup_repo" \
     ++	"stash push -u -- files"
      +
     -+	test_perf "add $total_files files (object_fsyncing=$mode)" \
     -+		--setup "
     -+		(rm -rf .git || 1) &&
     -+		git init &&
     -+		test_create_unique_files $dir_count $files_per_dir files_$mode
     -+	" "
     -+		git $FSYNC_CONFIG add files_$mode
     ++test_perf_fsync_cfgs "unpack $total_files files" \
      +	"
     ++	setup_repo &&
     ++	git -c core.fsync=none add -- files &&
     ++	git -c core.fsync=none commit -q -m second &&
     ++	echo HEAD | git pack-objects -q --stdout --revs >test_pack.pack &&
     ++	setup_repo
     ++	" \
     ++	"unpack-objects -q <test_pack.pack"
      +
     -+	test_perf "stash $total_files files (object_fsyncing=$mode)" \
     -+		--setup "
     -+		(rm -rf .git || 1) &&
     -+		git init &&
     -+		test_commit first &&
     -+		test_create_unique_files $dir_count $files_per_dir stash_files_$mode
     -+	" "
     -+		git $FSYNC_CONFIG stash push -u -- stash_files_$mode
     ++test_perf_fsync_cfgs "commit $total_files files" \
      +	"
     -+done
     ++	setup_repo &&
     ++	git -c core.fsync=none add -- files &&
     ++	populate_files
     ++	" \
     ++	"commit -q -a -m test"
      +
      +test_done
 13:  fb30bd02c8d = 14:  88c1f84d4c3 core.fsyncmethod: correctly camel-case warning message

-- 
gitgitgadget
