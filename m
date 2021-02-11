Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4528AC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BE864DBD
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhBKB76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhBKB43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 20:56:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6075C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:10 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j11so3548920wmi.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3KgFwhseXbILEDH9SU95O8cOaxYs81ke76M07Eu3Z0=;
        b=gwGbsZhA6WDH4/tPQca5xCEGsdYB0vYYJDkwtUFz63TOH949PZWO/CP1BVf4uA3vaF
         QbC+5dzC5Jb6SkZqy7A9zk4zuBSnPqJQzB1BZPeIfztymsRrGUwId5YeLsEyxftbatfl
         /ytoY2xPaomh5hY4o4O7dWXsWUNpTPeWVpc5/hqBGHg2HY1uikS5rxLnQZshk2E8p6+2
         d37vBA3typh0PvuQ34PO8FX60DvvQO1TOdlEB30S9aY8korCIvI1cUT5rr/s/ZvhQkR0
         7mW3IAZNi/QC+waJyOwMbKjOhbk0e0E9y6fy+6aR0vjjIhjmRpdvbRNtFWrapdNTyJX2
         qu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3KgFwhseXbILEDH9SU95O8cOaxYs81ke76M07Eu3Z0=;
        b=tu9yio97kJHz4IqBj4cmR+Iqi2cpk1gcJGP5s02ckFisvQnkDZ0BxTJas9sptplDaX
         0YJ25JgfkrNmN5wavYCgBUczTuHccWxmBpJ9CpIrERaj9dtTBUOufowHBLJ8klBz5V7p
         sOHEh0vrHwqQ9+75ufhW6qxWjfaAxW+16q8+W7FQpLK9O0fPBZW/tHxqm9ItrgziwdCU
         ZV/cTLObemOFnzxWHQNYkNcvSnjCRSsmgiDvkFUSVKkdaVm5nqKM92EIgWpfVRzE9Bxr
         qFOGFYjWtBDSnYLBy0Pl94l768eG65hMEMDDXY+N7Hc9AFOcShOZdwO+5ctJP1+mAgIy
         qV0w==
X-Gm-Message-State: AOAM5329Mxn0eXLhlz90+GpKWD+frYraRbLhI+gj2RAyB70Ht9k6tZXX
        q57cRmX//Qj4n58YF2MFTTeEMxzgEex/aA==
X-Google-Smtp-Source: ABdhPJz4pE+e/FyFXUZLnYESxI+IoV9KFCHwCuJt7lEIR1UnKm+JeEJ25tVFaBBCYp9jS6i1AQ9bGw==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr2133351wmc.131.1613008449001;
        Wed, 10 Feb 2021 17:54:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2sm5362486wml.34.2021.02.10.17.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 17:54:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] tests: remove most uses of C_LOCALE_OUTPUT
Date:   Thu, 11 Feb 2021 02:53:51 +0100
Message-Id: <20210211015353.28680-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210120182759.31102-1-avarab@gmail.com>
References: <20210120182759.31102-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to d162b25f956 (tests: remove support for
GIT_TEST_GETTEXT_POISON, 2021-01-20) remove those uses of the now
always true C_LOCALE_OUTPUT prerequisite from those tests which
declare it as an argument to test_expect_{success,failure}.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh                    |  2 +-
 t/t0201-gettext-fallbacks.sh        |  2 +-
 t/t1430-bad-ref-name.sh             |  2 +-
 t/t1512-rev-parse-disambiguation.sh | 14 +++++++-------
 t/t3404-rebase-interactive.sh       | 14 +++++++-------
 t/t3415-rebase-autosquash.sh        | 10 +++++-----
 t/t3701-add-interactive.sh          |  2 +-
 t/t4012-diff-binary.sh              |  4 ++--
 t/t4205-log-pretty-formats.sh       |  2 +-
 t/t5300-pack-object.sh              |  4 ++--
 t/t5505-remote.sh                   |  6 +++---
 t/t5510-fetch.sh                    |  4 ++--
 t/t5601-clone.sh                    |  2 +-
 t/t6423-merge-rename-directories.sh |  2 +-
 t/t7300-clean.sh                    |  6 +++---
 t/t7505-prepare-commit-msg-hook.sh  |  4 ++--
 t/t7810-grep.sh                     |  2 +-
 17 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index a6e570d674a..705d62cc27a 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -271,7 +271,7 @@ test_expect_success 'pretend we have a mix of all possible results' '
 	EOF
 '
 
-test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
+test_expect_success 'test --verbose' '
 	run_sub_test_lib_test_err \
 		t1234-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 90da1c7ddc4..a7b3e4a2c73 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -18,7 +18,7 @@ test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_TEST_FALLBACKS is set' '
     test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
 '
 
-test_expect_success C_LOCALE_OUTPUT 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallthrough' '
+test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallthrough' '
     echo fallthrough >expect &&
     echo $GIT_INTERNAL_GETTEXT_SH_SCHEME >actual &&
     test_cmp expect actual
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 354902e514f..b1839e08771 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -125,7 +125,7 @@ test_expect_success 'push cannot create a badly named ref' '
 	! grep -e "broken\.\.\.ref" output
 '
 
-test_expect_failure C_LOCALE_OUTPUT 'push --mirror can delete badly named ref' '
+test_expect_failure 'push --mirror can delete badly named ref' '
 	top=$(pwd) &&
 	git init src &&
 	git init dest &&
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 242abbfa0bc..7891a6becf3 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -314,39 +314,39 @@ test_expect_success 'ambiguous short sha1 ref' '
 	grep "refname.*${REF}.*ambiguous" err
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated (raw)' '
+test_expect_success 'ambiguity errors are not repeated (raw)' '
 	test_must_fail git rev-parse 00000 2>stderr &&
 	grep "is ambiguous" stderr >errors &&
 	test_line_count = 1 errors
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated (treeish)' '
+test_expect_success 'ambiguity errors are not repeated (treeish)' '
 	test_must_fail git rev-parse 00000:foo 2>stderr &&
 	grep "is ambiguous" stderr >errors &&
 	test_line_count = 1 errors
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated (peel)' '
+test_expect_success 'ambiguity errors are not repeated (peel)' '
 	test_must_fail git rev-parse 00000^{commit} 2>stderr &&
 	grep "is ambiguous" stderr >errors &&
 	test_line_count = 1 errors
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguity hints' '
+test_expect_success 'ambiguity hints' '
 	test_must_fail git rev-parse 000000000 2>stderr &&
 	grep ^hint: stderr >hints &&
 	# 16 candidates, plus one intro line
 	test_line_count = 17 hints
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
+test_expect_success 'ambiguity hints respect type' '
 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
 	# 5 commits, 1 tag (which is a committish), plus intro line
 	test_line_count = 7 hints
 '
 
-test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
+test_expect_success 'failed type-selector still shows hint' '
 	# these two blobs share the same prefix "ee3d", but neither
 	# will pass for a commit
 	echo 851 | git hash-object --stdin -w &&
@@ -370,7 +370,7 @@ test_expect_success 'core.disambiguate does not override context' '
 		git -c core.disambiguate=committish rev-parse $sha1^{tree}
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first, then hash order' '
+test_expect_success 'ambiguous commits are printed by type first, then hash order' '
 	test_must_fail git rev-parse 0000 2>stderr &&
 	grep ^hint: stderr >hints &&
 	grep 0000 hints >objects &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1e738df81d5..dc45552b4d6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -450,7 +450,7 @@ test_expect_success 'verbose flag is heeded, even after --continue' '
 	grep "^ file1 | 2 +-$" output
 '
 
-test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor once' '
+test_expect_success 'multi-squash only fires up editor once' '
 	base=$(git rev-parse HEAD~4) &&
 	(
 		set_fake_editor &&
@@ -463,7 +463,7 @@ test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor once' '
 	test 1 = $(git show | grep ONCE | wc -l)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'multi-fixup does not fire up editor' '
+test_expect_success 'multi-fixup does not fire up editor' '
 	git checkout -b multi-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
 	(
@@ -514,7 +514,7 @@ test_expect_success 'commit message retained after conflict' '
 	git branch -D conflict-squash
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messages' '
+test_expect_success 'squash and fixup generate correct log messages' '
 	cat >expect-squash-fixup <<-\EOF &&
 	B
 
@@ -541,7 +541,7 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 	git branch -D squash-fixup
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
+test_expect_success 'squash ignores comments' '
 	git checkout -b skip-comments E &&
 	base=$(git rev-parse HEAD~4) &&
 	(
@@ -557,7 +557,7 @@ test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
 	git branch -D skip-comments
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash ignores blank lines' '
+test_expect_success 'squash ignores blank lines' '
 	git checkout -b skip-blank-lines E &&
 	base=$(git rev-parse HEAD~4) &&
 	(
@@ -995,7 +995,7 @@ test_expect_success 'rebase -ix with several instances of --exec' '
 	test_cmp expected actual
 '
 
-test_expect_success C_LOCALE_OUTPUT 'rebase -ix with --autosquash' '
+test_expect_success 'rebase -ix with --autosquash' '
 	git reset --hard execute &&
 	git checkout -b autosquash &&
 	echo second >second.txt &&
@@ -1136,7 +1136,7 @@ test_expect_success 'rebase -i --root reword root when root has untracked file c
 	test "$(git rev-list --count HEAD)" = 2
 '
 
-test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
+test_expect_success 'rebase --edit-todo does not work on non-interactive rebase' '
 	git checkout reword-original-root-branch &&
 	git reset --hard &&
 	git checkout conflict-branch &&
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 36f169d7f15..908016c2f88 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -306,23 +306,23 @@ test_auto_fixup_fixup () {
 	fi
 }
 
-test_expect_success C_LOCALE_OUTPUT 'fixup! fixup!' '
+test_expect_success 'fixup! fixup!' '
 	test_auto_fixup_fixup fixup fixup
 '
 
-test_expect_success C_LOCALE_OUTPUT 'fixup! squash!' '
+test_expect_success 'fixup! squash!' '
 	test_auto_fixup_fixup fixup squash
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash! squash!' '
+test_expect_success 'squash! squash!' '
 	test_auto_fixup_fixup squash squash
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash! fixup!' '
+test_expect_success 'squash! fixup!' '
 	test_auto_fixup_fixup squash fixup
 '
 
-test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
+test_expect_success 'autosquash with custom inst format' '
 	git reset --hard base &&
 	git config --add rebase.instructionFormat "[%an @ %ar] %s"  &&
 	echo 2 >file1 &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b2f90997dbc..ed00c40370b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -370,7 +370,7 @@ test_expect_success 'setup expected' '
 '
 
 # Test splitting the first patch, then adding both
-test_expect_success C_LOCALE_OUTPUT 'add first line works' '
+test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	printf "%s\n" s y y | git add -p file 2>error |
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 6579c81216a..bd59328e4b2 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -63,7 +63,7 @@ test_expect_success 'apply --numstat understands diff --binary format' '
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
+test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff >output &&
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
@@ -73,7 +73,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	test "$detected" = xCIT
 '
 
-test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
+test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 749bc1431ac..5ec0f47b567 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -126,7 +126,7 @@ test_expect_success 'NUL separation with --stat' '
 	test_i18ncmp expected actual
 '
 
-test_expect_failure C_LOCALE_OUTPUT 'NUL termination with --stat' '
+test_expect_failure 'NUL termination with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n0" >expected &&
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 392201cabdf..d586fdc7a95 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -427,7 +427,7 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
-test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
@@ -445,7 +445,7 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=N or pack.th
 	grep -F "no threads support, ignoring pack.threads" err
 '
 
-test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
 	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 045398b94e6..d3a3bb0a42b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -59,7 +59,7 @@ test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
 	git remote add myremote git@host.com:team/repo.git
 '
 
-test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
+test_expect_success 'remote information for the origin' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
@@ -81,7 +81,7 @@ test_expect_success 'add another remote' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'check remote-tracking' '
+test_expect_success 'check remote-tracking' '
 	(
 		cd test &&
 		check_remote_track origin main side &&
@@ -107,7 +107,7 @@ test_expect_success 'remove remote' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'remove remote' '
+test_expect_success 'remove remote' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 42f55030047..a37df6d35a7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1097,7 +1097,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
+test_expect_success 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -1112,7 +1112,7 @@ test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	test_cmp expect actual
 '
 
-test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
+test_expect_success 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 664c9138662..e7e6c089554 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -40,7 +40,7 @@ test_expect_success 'clone with excess parameters (2)' '
 
 '
 
-test_expect_success C_LOCALE_OUTPUT 'output from clone' '
+test_expect_success 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
 	test $(grep Clon output | wc -l) = 1
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4ab133f489c..5d3b711fe68 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -2905,7 +2905,7 @@ test_setup_9e () {
 	)
 }
 
-test_expect_success C_LOCALE_OUTPUT '9e: N-to-1 whammo' '
+test_expect_success '9e: N-to-1 whammo' '
 	test_setup_9e &&
 	(
 		cd 9e &&
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index cb5e34d94c3..a74816ca8b4 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -110,7 +110,7 @@ test_expect_success 'git clean with prefix' '
 
 '
 
-test_expect_success C_LOCALE_OUTPUT 'git clean with relative prefix' '
+test_expect_success 'git clean with relative prefix' '
 
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
@@ -123,7 +123,7 @@ test_expect_success C_LOCALE_OUTPUT 'git clean with relative prefix' '
 	verbose test "$would_clean" = ../src/part3.c
 '
 
-test_expect_success C_LOCALE_OUTPUT 'git clean with absolute path' '
+test_expect_success 'git clean with absolute path' '
 
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
@@ -407,7 +407,7 @@ test_expect_success 'clean.requireForce and -f' '
 
 '
 
-test_expect_success C_LOCALE_OUTPUT 'core.excludesfile' '
+test_expect_success 'core.excludesfile' '
 
 	echo excludes >excludes &&
 	echo included >included &&
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 321b4bc0fc6..7a8194ce720 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -218,7 +218,7 @@ test_expect_success 'with hook and editor (merge)' '
 test_rebase () {
 	expect=$1 &&
 	mode=$2 &&
-	test_expect_$expect C_LOCALE_OUTPUT "with hook (rebase ${mode:--i})" '
+	test_expect_$expect "with hook (rebase ${mode:--i})" '
 		test_when_finished "\
 			git rebase --abort
 			git checkout -f main
@@ -307,7 +307,7 @@ test_expect_success 'with failing hook (merge)' '
 
 '
 
-test_expect_success C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
+test_expect_success 'with failing hook (cherry-pick)' '
 	test_when_finished "git checkout -f main" &&
 	git checkout -B other b &&
 	test_must_fail git cherry-pick rebase-1 2>actual &&
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8f7591c9ccd..edfaa9a6d1c 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -969,7 +969,7 @@ do
 	"
 done
 
-test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'grep --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS 'grep --threads=N or pack.threads=N warns when no pthreads' '
 	git grep --threads=2 Hello hello_world 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-- 
2.30.0.284.gd98b1dd5eaa7

