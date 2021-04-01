Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18852C43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34E161130
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhDARxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbhDARua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:50:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B7C02D54B
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c8so2257618wrq.11
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BEeFqLDIv6plqXsqBDn5z4EEnMESEOm+rnS6UnhW4j4=;
        b=F15Bhq0rb1nZfyHT6X4kf7YmUhunMDb4dn/0oamPj/m6mQ+bAINRe2/FlmL5YnQXmR
         AyoM9JnSg5F/jGVXN7UfUOLTNvKz8GIyHkWib1T/YrBTvHyXlLDOFZOy2I6blzZQQhf0
         y6DPmpAP8YNbql+68IECYNUcYlp3La9OJuRCd9uyQK2pQYUJ2c8EOBPYqBgUvDJi8yOA
         qhatcbr0spw+k46JOfSDMXVsH9VYGK9VZCFoYAsFJOc0xcKp8BSP5YynhI1ILvtxIPZX
         HynJCSWSl2g1GCdQjjDWSN9rAayUiMuyM4806prm9KBTKWPgLCuex1RI5/KBTAvttvvd
         EFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BEeFqLDIv6plqXsqBDn5z4EEnMESEOm+rnS6UnhW4j4=;
        b=RmcMqpfId94W2viKltsHgBsfi+TOoRCV6fxQNSWSCyCZVgLJJ2q44pN2iDIWiH75E+
         NcU9ydyzMhCeWg7zPSOtrHP2PARbLvozzUj24ewvE+3AmwGOiuigKtz1PQOkgD/0pFwa
         AgopJGWiv0irqdMIfA5/VHdWQsdT0jprf7uXOrLPec6eI1PftbCi/L7Bw+ma3UTMW7tE
         yNWc1Y+nD5xLlITq3ARlQB271FteXILAz2SVYvZsoMDpDkMuPniY86xAXetFsW4ywPB0
         k1If4+zFOD8uIJFVWloVtT+B0wzf9IJnK7en9tdz2Y92OFXgN1YOQsKovdt+aD2PHROr
         Vd+g==
X-Gm-Message-State: AOAM5328n7PW9GlWIHfOBQ3sFmC1xe7BzdD1/xe4GGscN/zSEQlTkdFm
        JqJ/mvwAcKj1S2BMS/5KtKtqxmeS1jI=
X-Google-Smtp-Source: ABdhPJwzmNDRFb6DtuOqtu00YxxlLUwy2rKagfjd0x7yqjFVoEu9hDmnDPHQ50S4/dwhD7J0gCv+zg==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr10529829wro.337.1617291680932;
        Thu, 01 Apr 2021 08:41:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm10158048wrx.46.2021.04.01.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:20 -0700 (PDT)
Message-Id: <8b2280e5c4d2cec1fe39e90bfc93f059a1d0eb05.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:41:03 +0000
Subject: [PATCH 21/23] t7527: create test for fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 485 +++++++++++++++++++++++++++++++++++
 1 file changed, 485 insertions(+)
 create mode 100755 t/t7527-builtin-fsmonitor.sh

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
new file mode 100755
index 000000000000..1fd230f1d4c6
--- /dev/null
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -0,0 +1,485 @@
+#!/bin/sh
+
+test_description='built-in file system watcher'
+
+. ./test-lib.sh
+
+# Ask the fsmonitor daemon to insert a little delay before responding to
+# client commands like `git status` and `git fsmonitor--daemon --query` to
+# allow recent filesystem events to be received by the daemon.  This helps
+# the CI/PR builds be more stable.
+#
+# An arbitrary millisecond value.
+#
+GIT_TEST_FSMONITOR_CLIENT_DELAY=1000
+export GIT_TEST_FSMONITOR_CLIENT_DELAY
+
+git version --build-options | grep "feature:" | grep "fsmonitor--daemon" || {
+	skip_all="The built-in FSMonitor is not supported on this platform"
+	test_done
+}
+
+kill_repo () {
+	r=$1
+	git -C $r fsmonitor--daemon --stop >/dev/null 2>/dev/null
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
+	git $r fsmonitor--daemon --start || return $?
+	git $r fsmonitor--daemon --is-running || return $?
+
+	return 0
+}
+
+test_expect_success 'explicit daemon start and stop' '
+	test_when_finished "kill_repo test_explicit" &&
+
+	git init test_explicit &&
+	start_daemon test_explicit &&
+
+	git -C test_explicit fsmonitor--daemon --stop &&
+	test_must_fail git -C test_explicit fsmonitor--daemon --is-running
+'
+
+test_expect_success 'implicit daemon start' '
+	test_when_finished "kill_repo test_implicit" &&
+
+	git init test_implicit &&
+	test_must_fail git -C test_implicit fsmonitor--daemon --is-running &&
+
+	# query will implicitly start the daemon.
+	#
+	# for test-script simplicity, we send a V1 timestamp rather than
+	# a V2 token.  either way, the daemon response to any query contains
+	# a new V2 token.  (the daemon may complain that we sent a V1 request,
+	# but this test case is only concerned with whether the daemon was
+	# implicitly started.)
+
+	GIT_TRACE2_EVENT="$PWD/.git/trace" \
+		git -C test_implicit fsmonitor--daemon --query 0 >actual &&
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
+	git -C test_implicit fsmonitor--daemon --is-running &&
+	git -C test_implicit fsmonitor--daemon --stop &&
+	test_must_fail git -C test_implicit fsmonitor--daemon --is-running
+'
+
+test_expect_success 'implicit daemon stop (delete .git)' '
+	test_when_finished "kill_repo test_implicit_1" &&
+
+	git init test_implicit_1 &&
+
+	start_daemon test_implicit_1 &&
+
+	# deleting the .git directory will implicitly stop the daemon.
+	rm -rf test_implicit_1/.git &&
+
+	# Create an empty .git directory so that the following Git command
+	# will stay relative to the `-C` directory.  Without this, the Git
+	# command will (override the requested -C argument) and crawl out
+	# to the containing Git source tree.  This would make the test
+	# result dependent upon whether we were using fsmonitor on our
+	# development worktree.
+
+	sleep 1 &&
+	mkdir test_implicit_1/.git &&
+
+	test_must_fail git -C test_implicit_1 fsmonitor--daemon --is-running
+'
+
+test_expect_success 'implicit daemon stop (rename .git)' '
+	test_when_finished "kill_repo test_implicit_2" &&
+
+	git init test_implicit_2 &&
+
+	start_daemon test_implicit_2 &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	mv test_implicit_2/.git test_implicit_2/.xxx &&
+
+	# Create an empty .git directory so that the following Git command
+	# will stay relative to the `-C` directory.  Without this, the Git
+	# command will (override the requested -C argument) and crawl out
+	# to the containing Git source tree.  This would make the test
+	# result dependent upon whether we were using fsmonitor on our
+	# development worktree.
+
+	sleep 1 &&
+	mkdir test_implicit_2/.git &&
+
+	test_must_fail git -C test_implicit_2 fsmonitor--daemon --is-running
+'
+
+test_expect_success 'cannot start multiple daemons' '
+	test_when_finished "kill_repo test_multiple" &&
+
+	git init test_multiple &&
+
+	start_daemon test_multiple &&
+
+	test_must_fail git -C test_multiple fsmonitor--daemon --start 2>actual &&
+	grep "fsmonitor--daemon is already running" actual &&
+
+	git -C test_multiple fsmonitor--daemon --stop &&
+	test_must_fail git -C test_multiple fsmonitor--daemon --is-running
+'
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
+test_expect_success 'update-index implicitly starts daemon' '
+	test_must_fail git fsmonitor--daemon --is-running &&
+
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
+		git update-index --fsmonitor &&
+
+	git fsmonitor--daemon --is-running &&
+	test_might_fail git fsmonitor--daemon --stop &&
+
+	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_1
+'
+
+test_expect_success 'status implicitly starts daemon' '
+	test_must_fail git fsmonitor--daemon --is-running &&
+
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
+		git status >actual &&
+
+	git fsmonitor--daemon --is-running &&
+	test_might_fail git fsmonitor--daemon --stop &&
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
+	git fsmonitor--daemon --stop
+	rm -f .git/trace
+}
+
+test_expect_success 'edit some files' '
+	test_when_finished "clean_up_repo_and_stop_daemon" &&
+
+	(
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	edit_files &&
+
+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/modified$"  .git/trace &&
+	grep "^event: dir2/modified$"  .git/trace &&
+	grep "^event: modified$"       .git/trace &&
+	grep "^event: dir1/untracked$" .git/trace
+'
+
+test_expect_success 'create some files' '
+	test_when_finished "clean_up_repo_and_stop_daemon" &&
+
+	(
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	create_files &&
+
+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/new$" .git/trace &&
+	grep "^event: dir2/new$" .git/trace &&
+	grep "^event: new$"      .git/trace
+'
+
+test_expect_success 'delete some files' '
+	test_when_finished "clean_up_repo_and_stop_daemon" &&
+
+	(
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	delete_files &&
+
+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/delete$" .git/trace &&
+	grep "^event: dir2/delete$" .git/trace &&
+	grep "^event: delete$"      .git/trace
+'
+
+test_expect_success 'rename some files' '
+	test_when_finished "clean_up_repo_and_stop_daemon" &&
+
+	(
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	rename_files &&
+
+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
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
+	test_when_finished "clean_up_repo_and_stop_daemon" &&
+
+	(
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	mv dirtorename dirrenamed &&
+
+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
+
+	grep "^event: dirtorename/*$" .git/trace &&
+	grep "^event: dirrenamed/*$"  .git/trace
+'
+
+test_expect_success 'file changes to directory' '
+	test_when_finished "clean_up_repo_and_stop_daemon" &&
+
+	(
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	file_to_directory &&
+
+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
+
+	grep "^event: delete$"     .git/trace &&
+	grep "^event: delete/new$" .git/trace
+'
+
+test_expect_success 'directory changes to a file' '
+	test_when_finished "clean_up_repo_and_stop_daemon" &&
+
+	(
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	directory_to_file &&
+
+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1$" .git/trace
+'
+
+# The next few test cases exercise the token-resync code.  When filesystem
+# drops events (because of filesystem velocity or because the daemon isn't
+# polling fast enough), we need to discard the cached data (relative to the
+# current token) and start collecting events under a new token.
+#
+# the 'git fsmonitor--daemon --flush' command can be used to send a "flush"
+# message to a running daemon and ask it to do a flush/resync.
+
+test_expect_success 'flush cached data' '
+	test_when_finished "kill_repo test_flush" &&
+
+	git init test_flush &&
+
+	(
+		GIT_TEST_FSMONITOR_TOKEN=true &&
+		export GIT_TEST_FSMONITOR_TOKEN &&
+
+		GIT_TRACE_FSMONITOR="$PWD/.git/trace_daemon" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon test_flush
+	) &&
+
+	# The daemon should have an initial token with no events in _0 and
+	# then a few (probably platform-specific number of) events in _1.
+	# These should both have the same <token_id>.
+
+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000001:0" >actual_0 &&
+	nul_to_q <actual_0 >actual_q0 &&
+
+	touch test_flush/file_1 &&
+	touch test_flush/file_2 &&
+
+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000001:0" >actual_1 &&
+	nul_to_q <actual_1 >actual_q1 &&
+
+	grep "file_1" actual_q1 &&
+
+	# Force a flush.  This will change the <token_id>, reset the <seq_nr>, and
+	# flush the file data.  Then create some events and ensure that the file
+	# again appears in the cache.  It should have the new <token_id>.
+
+	git -C test_flush fsmonitor--daemon --flush >flush_0 &&
+	nul_to_q <flush_0 >flush_q0 &&
+	grep "^builtin:test_00000002:0Q/Q$" flush_q0 &&
+
+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000002:0" >actual_2 &&
+	nul_to_q <actual_2 >actual_q2 &&
+
+	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+
+	touch test_flush/file_3 &&
+
+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000002:0" >actual_3 &&
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
+		GIT_TRACE2_PERF="$PWD/trace2_wt_secondary" &&
+		export GIT_TRACE2_PERF &&
+
+		GIT_TRACE_FSMONITOR="$PWD/trace_wt_secondary" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon wt-secondary
+	) &&
+
+	git -C wt-secondary fsmonitor--daemon --stop &&
+	test_must_fail git -C wt-secondary fsmonitor--daemon --is-running
+'
+
+test_done
-- 
gitgitgadget

