Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B3BC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiCBNXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbiCBNXf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1329726CC
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i8so2770382wrr.8
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fBsLr3iwm0Ad8GRR+jmtCwPL5fJVrwxokEBnBHeEjb0=;
        b=WyPxDIuT14tu1i7NWpIMgZF2Xban1xCtERG2H9v16wOps1dtcCkp2atGkK4O7bg10O
         mvwH8ZbY9/oqU9O3yxtnn3CMyiXPKAOkoYRXEvymQmwrwmmFZ+zT1lVmJlO+UYIzDemi
         38pdbB6G9CjIGILkDa0o2PWus+Ect+MV8HNratFfa7NfBJ0D+Y3e4tg0guZi+/kjjGJH
         iIWVDUO/w/PIo6Bw+sLVj19O7Yd0KGcVtjSPoDrThp2YLRlGUJPp+RRGx4tXm/tf6JGQ
         IqdlRb9IVQE/LtvWQQO75Of6Wy1bP6mmvAuXk+V2VHC1utSzWLPVBo21KcfeQA2BvUMn
         rndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBsLr3iwm0Ad8GRR+jmtCwPL5fJVrwxokEBnBHeEjb0=;
        b=hSlLeyOsyMoLuqIGx8msn8+8J5kkixAXwc8GemxIA6YL7+7HdY1ldaec7dm7r4ZWGv
         fu9IgicUHS7FVhRf7BRwm2iFWrCjzV7D36IOpqu38W5M/z3rILS7zoXSjzrRdSrIsq3d
         Eca+q7R+L+TfvsDiSoFrnrHGJJje20ng/LHbkdI7CMETIu9lPGvwMxxXLGfZEFIhJ7qU
         UREp3i270TczlNl5CFCtdYUdE4wcbVvyZg/GeFdw5ffRmNRIscsVzZfum3MSVjSq2oH3
         vWdDI5ZGGKG32DEJlpBq4Gqc0o3+W1PBiPKuMGdCUhHMIrRifwviEGc2iQeCwb1FpGq+
         2wwg==
X-Gm-Message-State: AOAM530osBURIVdiBa4Emf79nhyuoMjHhSavC2glofXFiUfSWmj/7nWY
        a9+wtH2b4K8fFP0++URGz3hjPNXE9cermg==
X-Google-Smtp-Source: ABdhPJwiVfPTDF6FiRyPLCjCQ3kRInXtKdGoy7xCblmU2P4LOnJ35OZyIAXj/AHZz1zhiuTaV0XgEg==
X-Received: by 2002:a5d:500e:0:b0:1f0:2509:ee3f with SMTP id e14-20020a5d500e000000b001f02509ee3fmr3246254wrt.381.1646227361267;
        Wed, 02 Mar 2022 05:22:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] test-lib-functions: add and use a "test_hook" wrapper
Date:   Wed,  2 Mar 2022 14:22:27 +0100
Message-Id: <patch-08.10-d4102e9b929-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
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
 t/t0091-bugreport.sh                |  4 +--
 t/t1416-ref-transaction-hooks.sh    | 26 +++++++--------
 t/t1800-hook.sh                     | 14 +++++---
 t/t5406-remote-rejects.sh           |  2 +-
 t/t5409-colorize-remote-messages.sh |  2 +-
 t/t5411-proc-receive-hook.sh        |  4 +--
 t/t5510-fetch.sh                    |  6 ++--
 t/t5516-fetch-push.sh               |  4 +--
 t/t5521-pull-options.sh             |  4 +--
 t/t5540-http-push-webdav.sh         |  2 +-
 t/t5547-push-quarantine.sh          |  4 +--
 t/t5548-push-porcelain.sh           |  2 +-
 t/t6500-gc.sh                       |  4 +--
 t/t7519-status-fsmonitor.sh         | 18 +++++-----
 t/test-lib-functions.sh             | 52 +++++++++++++++++++++++++++++
 15 files changed, 101 insertions(+), 47 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 3025e685aaa..e4701da26aa 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -61,10 +61,10 @@ test_expect_success 'can create leading directories outside of a git dir' '
 test_expect_success 'indicates populated hooks' '
 	test_when_finished rm git-bugreport-hooks.txt &&
 
-	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	test_hook applypatch-msg <<-\EOF &&
 	true
 	EOF
-	write_script .git/hooks/unknown-hook <<-\EOF &&
+	test_hook unknown-hook <<-\EOF &&
 	true
 	EOF
 	git bugreport -s hooks &&
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index d21dd5e5df0..085a7a46f21 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -15,9 +15,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'hook allows updating ref if successful' '
-	test_when_finished "rm .git/hooks/reference-transaction" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		echo "$*" >>actual
 	EOF
 	cat >expect <<-EOF &&
@@ -29,9 +28,8 @@ test_expect_success 'hook allows updating ref if successful' '
 '
 
 test_expect_success 'hook aborts updating ref in prepared state' '
-	test_when_finished "rm .git/hooks/reference-transaction" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		if test "$1" = prepared
 		then
 			exit 1
@@ -42,9 +40,9 @@ test_expect_success 'hook aborts updating ref in prepared state' '
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
@@ -65,9 +63,9 @@ test_expect_success 'hook gets all queued updates in prepared state' '
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
@@ -85,9 +83,9 @@ test_expect_success 'hook gets all queued updates in committed state' '
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
@@ -114,11 +112,11 @@ test_expect_success 'interleaving hook calls succeed' '
 
 	git init --bare target-repo.git &&
 
-	write_script target-repo.git/hooks/reference-transaction <<-\EOF &&
+	test_hook -C target-repo.git reference-transaction <<-\EOF &&
 		echo $0 "$@" >>actual
 	EOF
 
-	write_script target-repo.git/hooks/update <<-\EOF &&
+	test_hook -C target-repo.git update <<-\EOF &&
 		echo $0 "$@" >>actual
 	EOF
 
@@ -139,7 +137,7 @@ test_expect_success 'hook does not get called on packing refs' '
 	# Pack references first such that we are in a known state.
 	git pack-refs --all &&
 
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		echo "$@" >>actual
 		cat >>actual
 	EOF
@@ -165,7 +163,7 @@ test_expect_success 'deleting packed ref calls hook once' '
 	git update-ref refs/heads/to-be-deleted $POST_OID &&
 	git pack-refs --all &&
 
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	test_hook reference-transaction <<-\EOF &&
 		echo "$@" >>actual
 		cat >>actual
 	EOF
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index ff64597e959..26ed5e11bc8 100755
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
@@ -56,7 +56,7 @@ test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
 for code in 1 2 128 129
 do
 	test_expect_success "git hook run: exit code $code is passed along" '
-		write_script .git/hooks/test-hook <<-EOF &&
+		test_hook test-hook <<-EOF &&
 		exit $code
 		EOF
 
@@ -69,7 +69,7 @@ test_expect_success 'git hook run arg u ments without -- is not allowed' '
 '
 
 test_expect_success 'git hook run -- pass arguments' '
-	write_script .git/hooks/test-hook <<-\EOF &&
+	test_hook test-hook <<-\EOF &&
 	echo $1
 	echo $2
 	EOF
@@ -84,7 +84,7 @@ test_expect_success 'git hook run -- pass arguments' '
 '
 
 test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	write_script .git/hooks/test-hook <<-EOF &&
+	test_hook test-hook <<-EOF &&
 	echo Test hook
 	EOF
 
@@ -105,6 +105,10 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	Hook ran four
 	EOF
 
+	test_hook test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
 	# Test various ways of specifying the path. See also
 	# t1350-config-hooks-path.sh
 	>actual &&
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
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ef0da0a63b5..4620f0ca7fa 100755
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
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fbe0a72b0b2..b689baf01a9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1685,7 +1685,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	git -C testrepo reset --hard HEAD^^ &&
 	git -C testrepo tag initial &&
 	git -C testrepo config receive.denyCurrentBranch updateInstead &&
-	write_script testrepo/.git/hooks/push-to-checkout <<-\EOF &&
+	test_hook -C testrepo push-to-checkout <<-\EOF &&
 	echo >&2 updating from $(git rev-parse HEAD)
 	echo >&2 updating to "$1"
 
@@ -1741,7 +1741,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	test_when_finished "rm -rf void" &&
 	git init void &&
 	git -C void config receive.denyCurrentBranch updateInstead &&
-	write_script void/.git/hooks/push-to-checkout <<-\EOF &&
+	test_hook -C void push-to-checkout <<-\EOF &&
 	if git rev-parse --quiet --verify HEAD
 	then
 		has_head=yes
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
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 380e97c1762..37db3dec0c5 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -42,7 +42,7 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git --bare update-server-info &&
-	write_script hooks/post-update <<-\EOF &&
+	test_hook --setup post-update <<-\EOF &&
 	exec git update-server-info
 	EOF
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
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
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index a6b0db22867..39871b9901e 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -101,7 +101,7 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 	EOF
 
 	git init pre-auto-gc-hook &&
-	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
+	test_hook -C pre-auto-gc-hook pre-auto-gc <<-\EOF &&
 	echo >&2 no gc for you &&
 	exit 1
 	EOF
@@ -128,7 +128,7 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 	See "git help gc" for manual housekeeping.
 	EOF
 
-	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
+	test_hook -C pre-auto-gc-hook --clobber pre-auto-gc <<-\EOF &&
 	echo >&2 will gc for you &&
 	exit 0
 	EOF
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 63a0f609866..d8b0fc4681c 100755
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
@@ -107,7 +107,7 @@ EOF
 
 # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
 test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook fsmonitor-test<<-\EOF &&
 		printf "last_update_token\0"
 	EOF
 	git update-index --fsmonitor &&
@@ -168,7 +168,7 @@ EOF
 
 # test that newly added files are marked valid
 test_expect_success 'newly added files are marked valid' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook --setup --clobber fsmonitor-test<<-\EOF &&
 		printf "last_update_token\0"
 	EOF
 	git add new &&
@@ -209,7 +209,7 @@ EOF
 
 # test that *only* files returned by the integration script get flagged as invalid
 test_expect_success '*only* files returned by the integration script get flagged as invalid' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook --clobber fsmonitor-test<<-\EOF &&
 	printf "last_update_token\0"
 	printf "dir1/modified\0"
 	EOF
@@ -230,7 +230,7 @@ test_expect_success 'refresh_index() invalidates fsmonitor cache' '
 	dirty_repo &&
 	write_integration_script &&
 	git add . &&
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	test_hook --clobber fsmonitor-test<<-\EOF &&
 	EOF
 	git commit -m "to reset" &&
 	git reset HEAD~1 &&
@@ -279,7 +279,7 @@ do
 		# Make sure it's actually skipping the check for modified and untracked
 		# (if enabled) files unless it is told about them.
 		test_expect_success "status doesn't detect unreported modifications" '
-			write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			test_hook --clobber fsmonitor-test<<-\EOF &&
 			printf "last_update_token\0"
 			:>marker
 			EOF
@@ -405,14 +405,14 @@ test_expect_success 'status succeeds with sparse index' '
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
@@ -430,7 +430,7 @@ test_expect_success 'status succeeds with sparse index' '
 
 		# This one modifies outside the sparse-checkout definition
 		# and hence we expect to expand the sparse-index.
-		write_script .git/hooks/fsmonitor-test <<-\EOF &&
+		test_hook --clobber fsmonitor-test <<-\EOF &&
 			printf "last_update_token\0"
 			printf "dir1a/modified\0"
 		EOF
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 85385d2ede7..0bef5913100 100644
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
2.35.1.1228.g56895c6ee86

