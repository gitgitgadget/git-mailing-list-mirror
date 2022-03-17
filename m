Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA81C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiCQKOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCQKOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB1972B5
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2860756wmb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQKjhdWE+rwxQ4vr7wCwTfh4JpDHueyxql1Le5tzdK4=;
        b=QmQvnjEcvE5MwVyjtwtB82JVQuAA8quwg8jLpAlSyXGf9JWDGq3TCWOwdYRSy+tWnq
         LzA4JeqwO/HH1FvVQbVyIwfb37GmmEQ0yP13i8BTnFvLNoo0GYF8wDin9Bk0bZ0sh5vW
         9Xzuj6E9ng6E4zx8mcWerIa+8m4p0aQn5Zmn32/xabTrVeCGAShgOoBSiL3Orbfe+97z
         2TCVzhkGeShaIIaJ3ectdTUBr0RWDTsmHSp/lv5z8ZmAI4xUkPQc7mA2EIjlF/LSXbej
         6N+OGEomgUmrQSiOdPHPf+IblMdV92F0jcQQN0b36G4UcAzv02dAdVQklQGX+2wv8wRh
         12kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQKjhdWE+rwxQ4vr7wCwTfh4JpDHueyxql1Le5tzdK4=;
        b=NLabqqjCS8iq3ybKLR8O/8xcvh831YUPCHoY3CdCGGOjq/VrbMd+WLNJHyNqyCxu8T
         IZcZDqRSxy2UupnLFe1WZJyYyIlytkgFzgom8vP9i5MGQldpdUSdvDBJBavD/BSfIhy2
         A40t8/RgIb9aQ2Tax/WTE/L4amqCoe+IP/L3zU7C+VjOH75H1xqv3hVCfm6KVnz2RrYZ
         f2Q4qzvVwzVXTkLBNnJm14fsL6KEbZ6ZxBPAiYx7fo/hxUTm00/KGKBks2BUM4E/Q1BT
         bb0M8riE7v9txvw1+RO6ckxSNCgC/qZiqTWGxqXLZ/V20dUrhAqnULtdDN+p8bfTc9AP
         89aA==
X-Gm-Message-State: AOAM5320l/mwkIrLXPRLPUdEpsO8bGd34hfO87SjRXxZRIQsha2VtJ/D
        iSgE7hSYg9GIxFx9A37adMBBd1bvSh0=
X-Google-Smtp-Source: ABdhPJyFbTLFZMh4gY8qQwz/9aopwwONjIwunbesHY6eurHBr4vp0Eh+re3DORDC6Nue0W8gNKXsXw==
X-Received: by 2002:a05:600c:1d19:b0:389:f9b6:ba52 with SMTP id l25-20020a05600c1d1900b00389f9b6ba52mr10711879wms.69.1647512003934;
        Thu, 17 Mar 2022 03:13:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/13] test-lib-functions: add and use a "test_hook" wrapper
Date:   Thu, 17 Mar 2022 11:13:06 +0100
Message-Id: <patch-v3-01.13-7761d777e9c-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "test_hook" wrapper similar to the existing "test_config"
wrapper added in d960c47a881 (test-lib: add helper functions for
config, 2011-08-17).

This wrapper:

 - Will clean up the hook with "test_when_finished", unless --setup is
   provided.

 - Will error if we clobber a hook, unless --clobber is provided.

 - Takes a name like "update" instead of ".git/hooks/update".

 - Accepts -C <dir>, like "test_config" and "test_commit".

By using a wrapper we'll be able to easily change all the hook-related
code that assumes that the template-created ".git/hooks" directory is
created by "init", "clone" etc. once another topic follows-up and
changes the test suite to stop creating trash directories using those
templates.

In addition this will make it easy to have the hooks configured using
the "configuration-based hooks" topic, once we get around to
integrating that. I.e. we'll be able to run the tests in a mode where
we sometimes create a .git/hooks/<name>, and other times create a
script in another location, and point the relevant configuration
snippet to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1416-ref-transaction-hooks.sh    | 26 +++++++--------
 t/t1800-hook.sh                     | 12 ++++---
 t/t5401-update-hooks.sh             |  2 +-
 t/t5406-remote-rejects.sh           |  2 +-
 t/t5409-colorize-remote-messages.sh |  2 +-
 t/t5411-proc-receive-hook.sh        |  4 +--
 t/t5503-tagfollow.sh                |  4 +--
 t/t5510-fetch.sh                    |  8 ++---
 t/t5521-pull-options.sh             |  4 +--
 t/t5547-push-quarantine.sh          |  4 +--
 t/t5548-push-porcelain.sh           |  2 +-
 t/t7519-status-fsmonitor.sh         | 18 +++++-----
 t/test-lib-functions.sh             | 52 +++++++++++++++++++++++++++++
 13 files changed, 97 insertions(+), 43 deletions(-)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 4e1e84a91f3..6fca1f08d9a 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -16,9 +16,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'hook allows updating ref if successful' '
-	test_when_finished "rm .git/hooks/reference-transaction" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		echo "$*" >>actual
 	EOF
 	cat >expect <<-EOF &&
@@ -30,9 +29,8 @@ test_expect_success 'hook allows updating ref if successful' '
 '
 
 test_expect_success 'hook aborts updating ref in prepared state' '
-	test_when_finished "rm .git/hooks/reference-transaction" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		if test "$1" = prepared
 		then
 			exit 1
@@ -43,9 +41,9 @@ test_expect_success 'hook aborts updating ref in prepared state' '
 '
 
 test_expect_success 'hook gets all queued updates in prepared state' '
-	test_when_finished "rm .git/hooks/reference-transaction actual" &&
+	test_when_finished "rm actual" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		if test "$1" = prepared
 		then
 			while read -r line
@@ -66,9 +64,9 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 '
 
 test_expect_success 'hook gets all queued updates in committed state' '
-	test_when_finished "rm .git/hooks/reference-transaction actual" &&
+	test_when_finished "rm actual" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		if test "$1" = committed
 		then
 			while read -r line
@@ -86,9 +84,9 @@ test_expect_success 'hook gets all queued updates in committed state' '
 '
 
 test_expect_success 'hook gets all queued updates in aborted state' '
-	test_when_finished "rm .git/hooks/reference-transaction actual" &&
+	test_when_finished "rm actual" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		if test "$1" = aborted
 		then
 			while read -r line
@@ -115,11 +113,11 @@ test_expect_success 'interleaving hook calls succeed' '
 
 	git init --bare target-repo.git &&
 
-	write_script target-repo.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C target-repo.git reference-transaction <<-\EOF &&
 		echo $0 "$@" >>actual
 	EOF
 
-	write_script target-repo.git/hooks/update <<-\EOF &&
+	test_hook -C target-repo.git update <<-\EOF &&
 		echo $0 "$@" >>actual
 	EOF
 
@@ -140,7 +138,7 @@ test_expect_success 'hook does not get called on packing refs' '
 	# Pack references first such that we are in a known state.
 	git pack-refs --all &&
 
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		echo "$@" >>actual
 		cat >>actual
 	EOF
@@ -166,7 +164,7 @@ test_expect_success 'deleting packed ref calls hook once' '
 	git update-ref refs/heads/to-be-deleted $POST_OID &&
 	git pack-refs --all &&
 
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		echo "$@" >>actual
 		cat >>actual
 	EOF
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 29718aa9913..93540b1fa12 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -27,7 +27,7 @@ test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
 '
 
 test_expect_success 'git hook run: basic' '
-	write_script .git/hooks/test-hook <<-EOF &&
+	test_hook test-hook <<-EOF &&
 	echo Test hook
 	EOF
 
@@ -39,7 +39,7 @@ test_expect_success 'git hook run: basic' '
 '
 
 test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
-	write_script .git/hooks/test-hook <<-EOF &&
+	test_hook test-hook <<-EOF &&
 	echo >&1 Will end up on stderr
 	echo >&2 Will end up on stderr
 	EOF
@@ -84,7 +84,7 @@ test_expect_success 'git hook run arg u ments without -- is not allowed' '
 '
 
 test_expect_success 'git hook run -- pass arguments' '
-	write_script .git/hooks/test-hook <<-\EOF &&
+	test_hook test-hook <<-\EOF &&
 	echo $1
 	echo $2
 	EOF
@@ -99,7 +99,7 @@ test_expect_success 'git hook run -- pass arguments' '
 '
 
 test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	write_script .git/hooks/test-hook <<-EOF &&
+	test_hook test-hook <<-EOF &&
 	echo Test hook
 	EOF
 
@@ -120,6 +120,10 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	Hook ran four
 	EOF
 
+	test_hook test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
 	# Test various ways of specifying the path. See also
 	# t1350-config-hooks-path.sh
 	>actual &&
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 6012cc8172a..799349a416c 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -136,7 +136,7 @@ test_expect_success 'send-pack stderr contains hook messages' '
 '
 
 test_expect_success 'pre-receive hook that forgets to read its input' '
-	write_script victim.git/hooks/pre-receive <<-\EOF &&
+	test_hook --clobber -C victim.git pre-receive <<-\EOF &&
 	exit 0
 	EOF
 	rm -f victim.git/hooks/update victim.git/hooks/post-update &&
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index 5c509db6fc3..dcbeb420827 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -5,7 +5,7 @@ test_description='remote push rejects are reported by client'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	write_script .git/hooks/update <<-\EOF &&
+	test_hook update <<-\EOF &&
 	exit 1
 	EOF
 	echo 1 >file &&
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 9f1a483f426..fa5de4500a4 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -5,7 +5,7 @@ test_description='remote messages are colorized on the client'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	write_script .git/hooks/update <<-\EOF &&
+	test_hook --setup update <<-\EOF &&
 	echo error: error
 	echo ERROR: also highlighted
 	echo hint: hint
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 98b0e812082..92cf52c6d4a 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -36,7 +36,7 @@ setup_upstream_and_workbench () {
 		TAG=$(git -C workbench rev-parse v123) &&
 
 		# setup pre-receive hook
-		write_script upstream.git/hooks/pre-receive <<-\EOF &&
+		test_hook --setup -C upstream.git pre-receive <<-\EOF &&
 		exec >&2
 		echo "# pre-receive hook"
 		while read old new ref
@@ -46,7 +46,7 @@ setup_upstream_and_workbench () {
 		EOF
 
 		# setup post-receive hook
-		write_script upstream.git/hooks/post-receive <<-\EOF &&
+		test_hook --setup -C upstream.git post-receive <<-\EOF &&
 		exec >&2
 		echo "# post-receive hook"
 		while read old new ref
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index a3c01014b7e..acdb731edfe 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -169,7 +169,7 @@ test_expect_success 'atomic fetch with failing backfill' '
 	# one of both fails to update correctly.
 	#
 	# To trigger failure we simply abort when backfilling a tag.
-	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C clone3 reference-transaction <<-\EOF &&
 		while read oldrev newrev reference
 		do
 			if test "$reference" = refs/tags/tag1
@@ -201,7 +201,7 @@ test_expect_success 'atomic fetch with backfill should use single transaction' '
 		$ZERO_OID $T refs/tags/tag1
 	EOF
 
-	write_script clone4/.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C clone4 reference-transaction <<-\EOF &&
 		( echo "$*" && cat ) >>actual
 	EOF
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 48e14e2dab1..6f38a69fbb2 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -273,7 +273,7 @@ test_expect_success 'fetch --atomic executes a single reference transaction only
 	EOF
 
 	rm -f atomic/actual &&
-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C atomic reference-transaction <<-\EOF &&
 		( echo "$*" && cat ) >>actual
 	EOF
 
@@ -306,7 +306,7 @@ test_expect_success 'fetch --atomic aborts all reference updates if hook aborts'
 	EOF
 
 	rm -f atomic/actual &&
-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C atomic/.git reference-transaction <<-\EOF &&
 		( echo "$*" && cat ) >>actual
 		exit 1
 	EOF
@@ -334,7 +334,7 @@ test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
 	test_line_count = 2 atomic/.git/FETCH_HEAD &&
 	cp atomic/.git/FETCH_HEAD expected &&
 
-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C atomic reference-transaction <<-\EOF &&
 		exit 1
 	EOF
 
@@ -364,7 +364,7 @@ test_expect_success 'fetch --atomic --prune executes a single reference transact
 		$ZERO_OID $head_oid refs/remotes/origin/new-branch
 	EOF
 
-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C atomic reference-transaction <<-\EOF &&
 		( echo "$*" && cat ) >>actual
 	EOF
 
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 66cfcb09c55..264de29c35c 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -233,7 +233,7 @@ test_expect_success 'git pull --no-verify flag passed to merge' '
 	git init src &&
 	test_commit -C src one &&
 	git clone src dst &&
-	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	test_hook -C dst commit-msg <<-\EOF &&
 	false
 	EOF
 	test_commit -C src two &&
@@ -245,7 +245,7 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
 	git init src &&
 	test_commit -C src one &&
 	git clone src dst &&
-	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	test_hook -C dst commit-msg <<-\EOF &&
 	false
 	EOF
 	test_commit -C src two &&
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index faaa51ccc56..1876fb34e51 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -5,7 +5,7 @@ test_description='check quarantine of objects during push'
 
 test_expect_success 'create picky dest repo' '
 	git init --bare dest.git &&
-	write_script dest.git/hooks/pre-receive <<-\EOF
+	test_hook --setup -C dest.git pre-receive <<-\EOF
 	while read old new ref; do
 		test "$(git log -1 --format=%s $new)" = reject && exit 1
 	done
@@ -60,7 +60,7 @@ test_expect_success 'push to repo path with path separator (colon)' '
 
 test_expect_success 'updating a ref from quarantine is forbidden' '
 	git init --bare update.git &&
-	write_script update.git/hooks/pre-receive <<-\EOF &&
+	test_hook -C update.git pre-receive <<-\EOF &&
 	read old new refname
 	git update-ref refs/heads/unrelated $new
 	exit 1
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index f11ff57e549..6282728eaf3 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -168,7 +168,7 @@ run_git_push_porcelain_output_test() {
 	'
 
 	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
-		write_script "$upstream/hooks/pre-receive" <<-EOF
+		test_hook --setup -C "$upstream" pre-receive <<-EOF
 		exit 1
 		EOF
 	'
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index fffc57120d6..4c7c00c94f1 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -26,7 +26,7 @@ dirty_repo () {
 }
 
 write_integration_script () {
-	write_script .git/hooks/fsmonitor-test<<-\EOF
+	test_hook --setup --clobber fsmonitor-test<<-\EOF
 	if test "$#" -ne 2
 	then
 		echo "$0: exactly 2 arguments expected"
@@ -108,7 +108,7 @@ EOF
 
 # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
 test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook fsmonitor-test<<-\EOF &&
 		printf "last_update_token\0"
 	EOF
 	git update-index --fsmonitor &&
@@ -169,7 +169,7 @@ EOF
 
 # test that newly added files are marked valid
 test_expect_success 'newly added files are marked valid' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook --setup --clobber fsmonitor-test<<-\EOF &&
 		printf "last_update_token\0"
 	EOF
 	git add new &&
@@ -210,7 +210,7 @@ EOF
 
 # test that *only* files returned by the integration script get flagged as invalid
 test_expect_success '*only* files returned by the integration script get flagged as invalid' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook --clobber fsmonitor-test<<-\EOF &&
 	printf "last_update_token\0"
 	printf "dir1/modified\0"
 	EOF
@@ -231,7 +231,7 @@ test_expect_success 'refresh_index() invalidates fsmonitor cache' '
 	dirty_repo &&
 	write_integration_script &&
 	git add . &&
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook --clobber fsmonitor-test<<-\EOF &&
 	EOF
 	git commit -m "to reset" &&
 	git reset HEAD~1 &&
@@ -280,7 +280,7 @@ do
 		# Make sure it's actually skipping the check for modified and untracked
 		# (if enabled) files unless it is told about them.
 		test_expect_success "status doesn't detect unreported modifications" '
-			write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			test_hook --clobber fsmonitor-test<<-\EOF &&
 			printf "last_update_token\0"
 			:>marker
 			EOF
@@ -414,14 +414,14 @@ test_expect_success 'status succeeds with sparse index' '
 		git -C sparse sparse-checkout init --cone --sparse-index &&
 		git -C sparse sparse-checkout set dir1 dir2 &&
 
-		write_script .git/hooks/fsmonitor-test <<-\EOF &&
+		test_hook --clobber fsmonitor-test <<-\EOF &&
 			printf "last_update_token\0"
 		EOF
 		git -C full config core.fsmonitor ../.git/hooks/fsmonitor-test &&
 		git -C sparse config core.fsmonitor ../.git/hooks/fsmonitor-test &&
 		check_sparse_index_behavior ! &&
 
-		write_script .git/hooks/fsmonitor-test <<-\EOF &&
+		test_hook --clobber fsmonitor-test <<-\EOF &&
 			printf "last_update_token\0"
 			printf "dir1/modified\0"
 		EOF
@@ -439,7 +439,7 @@ test_expect_success 'status succeeds with sparse index' '
 
 		# This one modifies outside the sparse-checkout definition
 		# and hence we expect to expand the sparse-index.
-		write_script .git/hooks/fsmonitor-test <<-\EOF &&
+		test_hook --clobber fsmonitor-test <<-\EOF &&
 			printf "last_update_token\0"
 			printf "dir1a/modified\0"
 		EOF
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d61..6c9c61c79c2 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -551,6 +551,58 @@ write_script () {
 	chmod +x "$1"
 }
 
+# Usage: test_hook [options] <hook-name> <<-\EOF
+#
+#   -C <dir>:
+#	Run all git commands in directory <dir>
+#   --setup
+#	Setup a hook for subsequent tests, i.e. don't remove it in a
+#	"test_when_finished"
+#   --clobber
+#	Overwrite an existing <hook-name>, if it exists. Implies
+#	--setup (i.e. the "test_when_finished" is assumed to have been
+#	set up already).
+test_hook () {
+	setup= &&
+	clobber= &&
+	indir= &&
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			indir="$2" &&
+			shift
+			;;
+		--setup)
+			setup=t
+			;;
+		--clobber)
+			clobber=t
+			;;
+		-*)
+			BUG "invalid argument: $1"
+			;;
+		*)
+			break
+			;;
+		esac &&
+		shift
+	done &&
+
+	git_dir=$(git -C "$indir" rev-parse --absolute-git-dir) &&
+	hook_dir="$git_dir/hooks" &&
+	hook_file="$hook_dir/$1" &&
+	if test -z "$clobber"
+	then
+		test_path_is_missing "$hook_file"
+	fi &&
+	if test -z "$setup$clobber"
+	then
+		test_when_finished "rm \"$hook_file\""
+	fi &&
+	write_script "$hook_file"
+}
+
 # Use test_set_prereq to tell that a particular prerequisite is available.
 # The prerequisite can later be checked for in two ways:
 #
-- 
2.35.1.1384.g7d2906948a1

