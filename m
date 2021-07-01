Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB6C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0888E6141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhGAOur (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhGAOuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF2C0613E8
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l8so8544243wry.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=isJoYhm2+oaxv7Cx3ZTwRhx3+algwlrSdiIX84BJk2M=;
        b=Y6AJ8if8NNi0iq4C4Xl7k3eOHvff2W5J8BbT3I8NyQPZ2f+7V8kCpK3jfwunCEEYlV
         b9OxaXFOSuvgsq6PdZ0e5gIeyz5jqirvid4ibGzLG2zVWybvE3MZOE3IMYaD+DbdTVr6
         9rbAWgusDfd/wiOckj1O1zmUeKYL9bobiWBfHzFk9lmNzAUsXLZTP4cQvjl8brQiNArU
         cU4VEJbXJGlplQM/qTiHpawDjpWOfh9NgsC4GCC4IkHvutwmkYZSb15/eDS/yQYQvoiN
         Gh1HpRkVSdDyp54Ax8ViitPhNH0msIzo3VsuKibTaTUKr7LXIwZhzTLqW1LtlmzQheIk
         c1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=isJoYhm2+oaxv7Cx3ZTwRhx3+algwlrSdiIX84BJk2M=;
        b=h3FRQtz1z5SHu7iQYkZGp6uoSDyunDZszsFXjtd2s0uRBCtGb9agOWd1Z+3HKTfmO/
         I3hXZ0DRUVWdTU0069ZdEEmislvz+YeTPWPpqGx3dTC/W9BYL5OyA1Zq87mO83SUe3Dj
         RWWKH6d9c72EO5bgmdXVLvRXurxo8jZ5Xz4DRuCeo80Ww/JTPktdleAwZKN7rJz17sGs
         EGtZ9TTO68r2KMHuf5TY4GVgHpG9/18+PAeGYWm+Nl1/UVRitW8Glil4AVdBj4misoEs
         E9EfAGnIVrXGnYbd3JZCFeFMHzJEUmnQQk1ZHLg9iDvPz8o4BBzBoukbnvNDFTV+mdQt
         0HOg==
X-Gm-Message-State: AOAM530k5B2oAGmKvPKsFF0TE6cXTsJ+uMoUfy6cJARq22IzqQ6+GXiE
        p/hRsFL38uFVjNb71w+5QrQlaO/NRWE=
X-Google-Smtp-Source: ABdhPJzTjQmJg63pe1oJJvxQduENIFMuGAasDbFkuCDi9+RNnUp2uE7IKQsxpSyoimXqnhKS5gtRzg==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr46909417wre.393.1625150881196;
        Thu, 01 Jul 2021 07:48:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17sm157565wrw.31.2021.07.01.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:00 -0700 (PDT)
Message-Id: <99279c0ebd2b36fe276301f018ca4e24e4cdff36.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:37 +0000
Subject: [PATCH v3 27/34] t7527: create test for fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 497 +++++++++++++++++++++++++++++++++++
 1 file changed, 497 insertions(+)
 create mode 100755 t/t7527-builtin-fsmonitor.sh

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
new file mode 100755
index 00000000000..58b56dc9940
--- /dev/null
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -0,0 +1,497 @@
+#!/bin/sh
+
+test_description='built-in file system watcher'
+
+. ./test-lib.sh
+
+if ! test_have_prereq FSMONITOR_DAEMON
+then
+	skip_all="fsmonitor--daemon is not supported on this platform"
+	test_done
+fi
+
+stop_daemon_delete_repo () {
+	r=$1
+	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
+	rm -rf $1
+	return 0
+}
+
+start_daemon () {
+	case "$#" in
+		1) r="-C $1";;
+		*) r="";
+	esac
+
+	git $r fsmonitor--daemon start || return $?
+	git $r fsmonitor--daemon status || return $?
+
+	return 0
+}
+
+test_expect_success 'explicit daemon start and stop' '
+	test_when_finished "stop_daemon_delete_repo test_explicit" &&
+
+	git init test_explicit &&
+	start_daemon test_explicit &&
+
+	git -C test_explicit fsmonitor--daemon stop &&
+	test_must_fail git -C test_explicit fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon start' '
+	test_when_finished "stop_daemon_delete_repo test_implicit" &&
+
+	git init test_implicit &&
+	test_must_fail git -C test_implicit fsmonitor--daemon status &&
+
+	# query will implicitly start the daemon.
+	#
+	# for test-script simplicity, we send a V1 timestamp rather than
+	# a V2 token.  either way, the daemon response to any query contains
+	# a new V2 token.  (the daemon may complain that we sent a V1 request,
+	# but this test case is only concerned with whether the daemon was
+	# implicitly started.)
+
+	GIT_TRACE2_EVENT="$(pwd)/.git/trace" \
+		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
+	nul_to_q <actual >actual.filtered &&
+	grep "builtin:" actual.filtered &&
+
+	# confirm that a daemon was started in the background.
+	#
+	# since the mechanism for starting the background daemon is platform
+	# dependent, just confirm that the foreground command received a
+	# response from the daemon.
+
+	grep :\"query/response-length\" .git/trace &&
+
+	git -C test_implicit fsmonitor--daemon status &&
+	git -C test_implicit fsmonitor--daemon stop &&
+	test_must_fail git -C test_implicit fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon stop (delete .git)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_1" &&
+
+	git init test_implicit_1 &&
+
+	start_daemon test_implicit_1 &&
+
+	# deleting the .git directory will implicitly stop the daemon.
+	rm -rf test_implicit_1/.git &&
+
+	# [1] Create an empty .git directory so that the following Git
+	#     command will stay relative to the `-C` directory.
+	#
+	#     Without this, the Git command will override the requested
+	#     -C argument and crawl out to the containing Git source tree.
+	#     This would make the test result dependent upon whether we
+	#     were using fsmonitor on our development worktree.
+	#
+	sleep 1 &&
+	mkdir test_implicit_1/.git &&
+
+	test_must_fail git -C test_implicit_1 fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon stop (rename .git)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_2" &&
+
+	git init test_implicit_2 &&
+
+	start_daemon test_implicit_2 &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	mv test_implicit_2/.git test_implicit_2/.xxx &&
+
+	# See [1] above.
+	#
+	sleep 1 &&
+	mkdir test_implicit_2/.git &&
+
+	test_must_fail git -C test_implicit_2 fsmonitor--daemon status
+'
+
+test_expect_success 'cannot start multiple daemons' '
+	test_when_finished "stop_daemon_delete_repo test_multiple" &&
+
+	git init test_multiple &&
+
+	start_daemon test_multiple &&
+
+	test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
+	grep "fsmonitor--daemon is already running" actual &&
+
+	git -C test_multiple fsmonitor--daemon stop &&
+	test_must_fail git -C test_multiple fsmonitor--daemon status
+'
+
+# These tests use the main repo in the trash directory
+
+test_expect_success 'setup' '
+	>tracked &&
+	>modified &&
+	>delete &&
+	>rename &&
+	mkdir dir1 &&
+	>dir1/tracked &&
+	>dir1/modified &&
+	>dir1/delete &&
+	>dir1/rename &&
+	mkdir dir2 &&
+	>dir2/tracked &&
+	>dir2/modified &&
+	>dir2/delete &&
+	>dir2/rename &&
+	mkdir dirtorename &&
+	>dirtorename/a &&
+	>dirtorename/b &&
+
+	cat >.gitignore <<-\EOF &&
+	.gitignore
+	expect*
+	actual*
+	EOF
+
+	git -c core.useBuiltinFSMonitor= add . &&
+	test_tick &&
+	git -c core.useBuiltinFSMonitor= commit -m initial &&
+
+	git config core.useBuiltinFSMonitor true
+'
+
+# The test already explicitly stopped (or tried to stop) the daemon.
+# This is here in case something else fails first.
+#
+redundant_stop_daemon () {
+	git fsmonitor--daemon stop
+	return 0
+}
+
+test_expect_success 'update-index implicitly starts daemon' '
+	test_when_finished redundant_stop_daemon &&
+
+	test_must_fail git fsmonitor--daemon status &&
+
+	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_1" \
+		git update-index --fsmonitor &&
+
+	git fsmonitor--daemon status &&
+	test_might_fail git fsmonitor--daemon stop &&
+
+	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_1
+'
+
+test_expect_success 'status implicitly starts daemon' '
+	test_when_finished redundant_stop_daemon &&
+
+	test_must_fail git fsmonitor--daemon status &&
+
+	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_2" \
+		git status >actual &&
+
+	git fsmonitor--daemon status &&
+	test_might_fail git fsmonitor--daemon stop &&
+
+	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_2
+'
+
+edit_files() {
+	echo 1 >modified
+	echo 2 >dir1/modified
+	echo 3 >dir2/modified
+	>dir1/untracked
+}
+
+delete_files() {
+	rm -f delete
+	rm -f dir1/delete
+	rm -f dir2/delete
+}
+
+create_files() {
+	echo 1 >new
+	echo 2 >dir1/new
+	echo 3 >dir2/new
+}
+
+rename_files() {
+	mv rename renamed
+	mv dir1/rename dir1/renamed
+	mv dir2/rename dir2/renamed
+}
+
+file_to_directory() {
+	rm -f delete
+	mkdir delete
+	echo 1 >delete/new
+}
+
+directory_to_file() {
+	rm -rf dir1
+	echo 1 >dir1
+}
+
+verify_status() {
+	git status >actual &&
+	GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
+	GIT_INDEX_FILE=.git/fresh-index git -c core.useBuiltinFSMonitor= status >expect &&
+	test_cmp expect actual &&
+	echo HELLO AFTER &&
+	cat .git/trace &&
+	echo HELLO AFTER
+}
+
+# The next few test cases confirm that our fsmonitor daemon sees each type
+# of OS filesystem notification that we care about.  At this layer we just
+# ensure we are getting the OS notifications and do not try to confirm what
+# is reported by `git status`.
+#
+# We run a simple query after modifying the filesystem just to introduce
+# a bit of a delay so that the trace logging from the daemon has time to
+# get flushed to disk.
+#
+# We `reset` and `clean` at the bottom of each test (and before stopping the
+# daemon) because these commands might implicitly restart the daemon.
+
+clean_up_repo_and_stop_daemon () {
+	git reset --hard HEAD
+	git clean -fd
+	git fsmonitor--daemon stop
+	rm -f .git/trace
+}
+
+test_expect_success 'edit some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	edit_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/modified$"  .git/trace &&
+	grep "^event: dir2/modified$"  .git/trace &&
+	grep "^event: modified$"       .git/trace &&
+	grep "^event: dir1/untracked$" .git/trace
+'
+
+test_expect_success 'create some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	create_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/new$" .git/trace &&
+	grep "^event: dir2/new$" .git/trace &&
+	grep "^event: new$"      .git/trace
+'
+
+test_expect_success 'delete some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	delete_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/delete$" .git/trace &&
+	grep "^event: dir2/delete$" .git/trace &&
+	grep "^event: delete$"      .git/trace
+'
+
+test_expect_success 'rename some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	rename_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/rename$"  .git/trace &&
+	grep "^event: dir2/rename$"  .git/trace &&
+	grep "^event: rename$"       .git/trace &&
+	grep "^event: dir1/renamed$" .git/trace &&
+	grep "^event: dir2/renamed$" .git/trace &&
+	grep "^event: renamed$"      .git/trace
+'
+
+test_expect_success 'rename directory' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	mv dirtorename dirrenamed &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dirtorename/*$" .git/trace &&
+	grep "^event: dirrenamed/*$"  .git/trace
+'
+
+test_expect_success 'file changes to directory' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	file_to_directory &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: delete$"     .git/trace &&
+	grep "^event: delete/new$" .git/trace
+'
+
+test_expect_success 'directory changes to a file' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	directory_to_file &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1$" .git/trace
+'
+
+# The next few test cases exercise the token-resync code.  When filesystem
+# drops events (because of filesystem velocity or because the daemon isn't
+# polling fast enough), we need to discard the cached data (relative to the
+# current token) and start collecting events under a new token.
+#
+# the 'test-tool fsmonitor-client flush' command can be used to send a
+# "flush" message to a running daemon and ask it to do a flush/resync.
+
+test_expect_success 'flush cached data' '
+	test_when_finished "stop_daemon_delete_repo test_flush" &&
+
+	git init test_flush &&
+
+	(
+		GIT_TEST_FSMONITOR_TOKEN=true &&
+		export GIT_TEST_FSMONITOR_TOKEN &&
+
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace_daemon" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon test_flush
+	) &&
+
+	# The daemon should have an initial token with no events in _0 and
+	# then a few (probably platform-specific number of) events in _1.
+	# These should both have the same <token_id>.
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
+	nul_to_q <actual_0 >actual_q0 &&
+
+	touch test_flush/file_1 &&
+	touch test_flush/file_2 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
+	nul_to_q <actual_1 >actual_q1 &&
+
+	grep "file_1" actual_q1 &&
+
+	# Force a flush.  This will change the <token_id>, reset the <seq_nr>, and
+	# flush the file data.  Then create some events and ensure that the file
+	# again appears in the cache.  It should have the new <token_id>.
+
+	test-tool -C test_flush fsmonitor-client flush >flush_0 &&
+	nul_to_q <flush_0 >flush_q0 &&
+	grep "^builtin:test_00000002:0Q/Q$" flush_q0 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
+	nul_to_q <actual_2 >actual_q2 &&
+
+	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+
+	touch test_flush/file_3 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
+	nul_to_q <actual_3 >actual_q3 &&
+
+	grep "file_3" actual_q3
+'
+
+# The next few test cases create repos where the .git directory is NOT
+# inside the one of the working directory.  That is, where .git is a file
+# that points to a directory elsewhere.  This happens for submodules and
+# non-primary worktrees.
+
+test_expect_success 'setup worktree base' '
+	git init wt-base &&
+	echo 1 >wt-base/file1 &&
+	git -C wt-base add file1 &&
+	git -C wt-base commit -m "c1"
+'
+
+test_expect_success 'worktree with .git file' '
+	git -C wt-base worktree add ../wt-secondary &&
+
+	(
+		GIT_TRACE2_PERF="$(pwd)/trace2_wt_secondary" &&
+		export GIT_TRACE2_PERF &&
+
+		GIT_TRACE_FSMONITOR="$(pwd)/trace_wt_secondary" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon wt-secondary
+	) &&
+
+	git -C wt-secondary fsmonitor--daemon stop &&
+	test_must_fail git -C wt-secondary fsmonitor--daemon status
+'
+
+# NEEDSWORK: Repeat one of the "edit" tests on wt-secondary and
+# confirm that we get the same events and behavior -- that is, that
+# fsmonitor--daemon correctly watches BOTH the working directory and
+# the external GITDIR directory and behaves the same as when ".git"
+# is a directory inside the working directory.
+
+test_expect_success 'cleanup worktrees' '
+	stop_daemon_delete_repo wt-secondary &&
+	stop_daemon_delete_repo wt-base
+'
+
+test_done
-- 
gitgitgadget

