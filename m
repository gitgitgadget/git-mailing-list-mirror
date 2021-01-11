Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ACBC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E392255F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbhAKOsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbhAKOsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 09:48:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D63C0617A3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c133so76493wme.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9ny3fGATbrydJEs1BcurYg6Kyux9DJEVjRFQzTNcmk=;
        b=RI4ehsVHL8Jn60mr6s+1JwotQNOW3w04UtxKBl+5CdSPRZzDW0qB5AaQz3f3Z+aT31
         8uWN+XjY9RNwmPhW4688NBuMn+2I0H9I7XdhYyu1bClOhYZ3mqOVFh/wGqlWswrYh5HE
         etR6i6jXAp7KQYgTwkQ3NYVwQAThY3dRKj46J2I7S5CWtH8ms36BLiblevqJQ7ERSW4G
         LJJ5OQn48uEZJzNfd+ZFabUAkrhAiWWnC8zw1ix89tdXpxdJObPayufGSq0QZEfabTu4
         YFDS/Hja7kGL+IKJq2CVROwlOCBsadVod6EvstADvMZaIej3qXG21QDB2ySk7RSdLfAo
         dnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9ny3fGATbrydJEs1BcurYg6Kyux9DJEVjRFQzTNcmk=;
        b=ppbto/g/1F+zxfXNhLr5rVLrA5Sb/zpjTJCctqpOfyCXuGdGTeN7q0Cp3Aq7rRNBB9
         RRmPo2NGDo26J385MrHmOSCbQp4SE/ndGXkz6BjYOApxh2TFHkAcFmtbZbtHLW6XM8nh
         QUh88HPzREvLDWP1fhNVReqo1lZPhBt86jsnRuesjdfuELkB+M0IeuS5aXs9zLPRRCi2
         rzJ9wh6SMNYS07KX6I4lb53AS0BgyaC5aTuDhvM1x1SbcwH4O8ZTJgVA4IThn0wa2WUp
         //C9IYuzCUuAb+vgmYJuOyZCjnSmFK3+Sc9g8J2q5lptgXhaTrFA0Pq59xUuGRzsb4pZ
         BW8w==
X-Gm-Message-State: AOAM531gQMCoihjZOuFAXdxrs5PGHeUK5l1JvUZIkzpn2gjG8D23JwBZ
        /QHuiPzcrDukUmiCJk/loJPZfNNrcjR6zw==
X-Google-Smtp-Source: ABdhPJwqc9qoFASCV1AXzz5A44rlXGFItinaIDGMHss3wDQcu2NrD2BqIppz9FgG92OhmJUNoJFx2A==
X-Received: by 2002:a7b:c319:: with SMTP id k25mr72212wmj.142.1610376470470;
        Mon, 11 Jan 2021 06:47:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5sm26132697wrz.18.2021.01.11.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:47:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] tests: (almost) remove use of "test_i18ngrep !"
Date:   Mon, 11 Jan 2021 15:47:38 +0100
Message-Id: <20210111144740.6092-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in previous commits we are removing uses of
test_i18ngrep. Let's start with the more rare negated form. This
leaves us with "test_i18ngrep" as a mere wrapper for "grep" at the
end.

Done with:

    cd t &&
    perl -pi -e 's/test_i18ngrep ! /! grep /g' *.sh

I excluded those things that would conflict with other in-flight
changes on the "seen" branch, as well as not removing support from
this invocation from "test_i18ngrep" for those & any other in-flight
and soon-to-be-submitted changes. We can do a later final cleanup and
removal of the unused code in some later change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0041-usage.sh                    | 12 +++++-----
 t/t1060-object-corruption.sh        |  2 +-
 t/t1091-sparse-checkout-builtin.sh  | 10 ++++-----
 t/t1450-fsck.sh                     |  4 ++--
 t/t1506-rev-parse-diagnosis.sh      |  2 +-
 t/t2019-checkout-ambiguous-ref.sh   |  4 ++--
 t/t2020-checkout-detach.sh          |  4 ++--
 t/t2024-checkout-dwim.sh            |  2 +-
 t/t3418-rebase-continue.sh          |  2 +-
 t/t3507-cherry-pick-conflict.sh     |  2 +-
 t/t3600-rm.sh                       |  2 +-
 t/t4001-diff-rename.sh              |  2 +-
 t/t4014-format-patch.sh             |  2 +-
 t/t4018-diff-funcname.sh            |  8 +++----
 t/t4153-am-resume-override-opts.sh  |  2 +-
 t/t5324-split-commit-graph.sh       |  2 +-
 t/t5505-remote.sh                   |  2 +-
 t/t5510-fetch.sh                    |  2 +-
 t/t5534-push-signed.sh              |  2 +-
 t/t5541-http-push-smart.sh          |  4 ++--
 t/t5580-unc-paths.sh                |  2 +-
 t/t5606-clone-options.sh            |  2 +-
 t/t6001-rev-list-graft.sh           |  2 +-
 t/t6050-replace.sh                  |  2 +-
 t/t6423-merge-rename-directories.sh | 12 +++++-----
 t/t6433-merge-toplevel.sh           |  2 +-
 t/t6437-submodule-merge.sh          |  2 +-
 t/t6500-gc.sh                       |  2 +-
 t/t7400-submodule-basic.sh          | 16 +++++++-------
 t/t7414-submodule-mistakes.sh       |  6 ++---
 t/t7415-submodule-names.sh          |  2 +-
 t/t7416-submodule-dash-url.sh       |  2 +-
 t/t7502-commit-porcelain.sh         | 10 ++++-----
 t/t7508-status.sh                   |  8 +++----
 t/t7518-ident-corner-cases.sh       |  2 +-
 t/t7519-status-fsmonitor.sh         |  4 ++--
 t/t7520-ignored-hook-warning.sh     |  6 ++---
 t/t7601-merge-pull-config.sh        | 34 ++++++++++++++---------------
 t/t7810-grep.sh                     |  2 +-
 t/t7816-grep-binary-pattern.sh      |  2 +-
 t/t9800-git-p4-basic.sh             |  2 +-
 t/t9807-git-p4-submit.sh            |  2 +-
 42 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 5b927b76fe..7d84671941 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -18,7 +18,7 @@ test_expect_success 'tag --contains <inexistent_tag>' '
 	test_must_fail git tag --contains "notag" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	! grep "usage" actual.err
 '
 
 test_expect_success 'tag --no-contains <existent_tag>' '
@@ -31,7 +31,7 @@ test_expect_success 'tag --no-contains <inexistent_tag>' '
 	test_must_fail git tag --no-contains "notag" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	! grep "usage" actual.err
 '
 
 test_expect_success 'tag usage error' '
@@ -50,7 +50,7 @@ test_expect_success 'branch --contains <inexistent_commit>' '
 	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	! grep "usage" actual.err
 '
 
 test_expect_success 'branch --no-contains <existent_commit>' '
@@ -63,7 +63,7 @@ test_expect_success 'branch --no-contains <inexistent_commit>' '
 	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	! grep "usage" actual.err
 '
 
 test_expect_success 'branch usage error' '
@@ -82,7 +82,7 @@ test_expect_success 'for-each-ref --contains <inexistent_object>' '
 	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	! grep "usage" actual.err
 '
 
 test_expect_success 'for-each-ref --no-contains <existent_object>' '
@@ -95,7 +95,7 @@ test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
 	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	! grep "usage" actual.err
 '
 
 test_expect_success 'for-each-ref usage error' '
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index bc89371f53..18dd448c7a 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -123,7 +123,7 @@ test_expect_success 'fetch into corrupted repo with index-pack' '
 		cd bit-error-cp &&
 		test_must_fail git -c transfer.unpackLimit=1 \
 			fetch ../no-bit-error 2>stderr &&
-		test_i18ngrep ! -i collision stderr
+		! grep -i collision stderr
 	)
 '
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 84acfc48b6..e0b3c7e5e4 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -180,7 +180,7 @@ test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
 	git -C repo read-tree -mu HEAD 2>err &&
-	test_i18ngrep ! "disabling cone patterns" err &&
+	! grep "disabling cone patterns" err &&
 	git -C repo reset --hard &&
 	check_files repo a folder1 folder2
 '
@@ -323,8 +323,8 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
 		git add file &&
 		git commit -m "test" &&
 		git sparse-checkout set nothing 2>err &&
-		test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
-		test_i18ngrep ! ".git/index.lock" err &&
+		! grep "Sparse checkout leaves no entry on working directory" err &&
+		! grep ".git/index.lock" err &&
 		git sparse-checkout set file
 	)
 '
@@ -340,7 +340,7 @@ test_expect_success '.gitignore should not warn about cone mode' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	echo "**/bin/*" >repo/.gitignore &&
 	git -C repo reset --hard 2>err &&
-	test_i18ngrep ! "disabling cone patterns" err
+	! grep "disabling cone patterns" err
 '
 
 test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
@@ -417,7 +417,7 @@ test_expect_success 'sparse-checkout reapply' '
 
 	git -C tweak checkout HEAD deep/deeper2/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
-	test_i18ngrep ! "warning.*The following paths are not up to date" err &&
+	! grep "warning.*The following paths are not up to date" err &&
 	test_path_is_missing tweak/deep/deeper2/a &&
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 	test_path_is_file tweak/folder1/a &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b17f5c21fb..884b33569c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -301,7 +301,7 @@ test_expect_success 'unparseable tree object' '
 	test_must_fail git fsck 2>out &&
 	test_i18ngrep "error: empty filename in tree entry" out &&
 	test_i18ngrep "$tree_sha1" out &&
-	test_i18ngrep ! "fatal: empty filename in tree entry" out
+	! grep "fatal: empty filename in tree entry" out
 '
 
 test_expect_success 'tree entry with type mismatch' '
@@ -319,7 +319,7 @@ test_expect_success 'tree entry with type mismatch' '
 	git update-ref refs/heads/type_mismatch $commit &&
 	test_must_fail git fsck >out 2>&1 &&
 	test_i18ngrep "is a blob, not a tree" out &&
-	test_i18ngrep ! "dangling blob" out
+	! grep "dangling blob" out
 '
 
 test_expect_success 'tag pointing to nonexistent' '
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index e2ae15a2cf..80006b3707 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -167,7 +167,7 @@ test_expect_success 'relative path when cwd is outside worktree' '
 
 test_expect_success '<commit>:file correctly diagnosed after a pathname' '
 	test_must_fail git rev-parse file.txt HEAD:file.txt 1>actual 2>error &&
-	test_i18ngrep ! "exists on disk" error &&
+	! grep "exists on disk" error &&
 	test_i18ngrep "no such path in the working tree" error &&
 	cat >expect <<-\EOF &&
 	file.txt
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index b99d5192a9..2a46257c76 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -31,7 +31,7 @@ test_expect_success 'checkout chooses branch over tag' '
 
 test_expect_success 'checkout reports switch to branch' '
 	test_i18ngrep "Switched to branch" stderr &&
-	test_i18ngrep ! "^HEAD is now at" stderr
+	! grep "^HEAD is now at" stderr
 '
 
 test_expect_success 'checkout vague ref succeeds' '
@@ -53,7 +53,7 @@ test_expect_success VAGUENESS_SUCCESS 'checkout chooses branch over tag' '
 
 test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to branch' '
 	test_i18ngrep "Switched to branch" stderr &&
-	test_i18ngrep ! "^HEAD is now at" stderr
+	! grep "^HEAD is now at" stderr
 '
 
 test_done
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index b748db9946..552dd9f505 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -14,10 +14,10 @@ check_not_detached () {
 PREV_HEAD_DESC='Previous HEAD position was'
 check_orphan_warning() {
 	test_i18ngrep "you are leaving $2 behind" "$1" &&
-	test_i18ngrep ! "$PREV_HEAD_DESC" "$1"
+	! grep "$PREV_HEAD_DESC" "$1"
 }
 check_no_orphan_warning() {
-	test_i18ngrep ! "you are leaving .* commit.*behind" "$1" &&
+	! grep "you are leaving .* commit.*behind" "$1" &&
 	test_i18ngrep "$PREV_HEAD_DESC" "$1"
 }
 
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index a4f8d3a67e..6e5042c606 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -118,7 +118,7 @@ test_expect_success PERL 'checkout -p with multiple remotes does not print advic
 	test_might_fail git branch -D foo &&
 
 	git checkout -p foo 2>stderr &&
-	test_i18ngrep ! "^hint: " stderr &&
+	! grep "^hint: " stderr &&
 	status_uno_is_clean
 '
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 7a2da972fd..958653aebf 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -178,7 +178,7 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 
 	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 	git show HEAD >out &&
-	test_i18ngrep ! "# This is a combination" out &&
+	! grep "# This is a combination" out &&
 
 	: Final squash failed, but there was still a squash &&
 	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index a21adcf0e4..2cc7338b75 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -555,7 +555,7 @@ test_expect_success 'cherry-pick preserves sparse-checkout' '
 	echo /unrelated >.git/info/sparse-checkout &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick -Xours picked>actual &&
-	test_i18ngrep ! "Changes not staged for commit:" actual
+	! grep "Changes not staged for commit:" actual
 '
 
 test_expect_success 'cherry-pick --continue remembers --keep-redundant-commits' '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..aa407095e9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -264,7 +264,7 @@ test_expect_success 'Resolving by removal is not a warning-worthy event' '
 		echo "100644 $blob $stage	blob"
 	done | git update-index --index-info &&
 	git rm blob >msg 2>&1 &&
-	test_i18ngrep ! "needs merge" msg &&
+	! grep "needs merge" msg &&
 	test_must_fail git ls-files -s --error-unmatch blob
 '
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index c16486a9d4..9fa37836c0 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -145,7 +145,7 @@ test_expect_success 'test diff.renames=true for git status' '
 
 test_expect_success 'test diff.renames=false for git status' '
 	git -c diff.renames=false status >out &&
-	test_i18ngrep ! "renamed: .*path1 -> subdir/path1" out &&
+	! grep "renamed: .*path1 -> subdir/path1" out &&
 	test_i18ngrep "new file: .*subdir/path1" out &&
 	test_i18ngrep "deleted: .*[^/]path1" out
 '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c5e5e0da3f..dce16a4741 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2242,7 +2242,7 @@ test_expect_success 'interdiff: cover-letter' '
 	EOF
 	git format-patch --cover-letter --interdiff=boop~2 -1 boop &&
 	test_i18ngrep "^Interdiff:$" 0000-cover-letter.patch &&
-	test_i18ngrep ! "^Interdiff:$" 0001-fleep.patch &&
+	! grep "^Interdiff:$" 0001-fleep.patch &&
 	sed "1,/^@@ /d; /^-- $/q" 0000-cover-letter.patch >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db..b75b6358d1 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -60,15 +60,15 @@ do
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index \
 			A.java B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		! grep fatal msg &&
+		! grep error msg
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index --word-diff \
 			A.java B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		! grep fatal msg &&
+		! grep error msg
 	'
 done
 
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index 8ea22d1bcb..74d4e07632 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -53,7 +53,7 @@ test_expect_success '--no-quiet overrides --quiet' '
 	# Applying side1 will be quiet.
 	test_must_fail git am --quiet side[123].eml >out &&
 	test_path_is_dir .git/rebase-apply &&
-	test_i18ngrep ! "^Applying: " out &&
+	! grep "^Applying: " out &&
 	echo side1 >file &&
 	git add file &&
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 4d3842b83b..5dc03be6e6 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -342,7 +342,7 @@ test_expect_success 'add octopus merge' '
 	git commit-graph write --reachable --split &&
 	git commit-graph verify --progress 2>err &&
 	test_line_count = 3 err &&
-	test_i18ngrep ! warning err &&
+	! grep warning err &&
 	test_line_count = 3 $graphdir/commit-graph-chain
 '
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ecadf02d64..8db6c1feaf 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1341,7 +1341,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 			test_must_fail git -c advice.pushUnqualifiedRefName=false \
 				push origin $oid:dst 2>err &&
 			test_i18ngrep "error: The destination you" err &&
-			test_i18ngrep ! "hint: Did you mean" err ||
+			! grep "hint: Did you mean" err ||
 			exit_with=false
 		done &&
 		$exit_with
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2013051a64..bfb282744e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -993,7 +993,7 @@ test_expect_success '--no-show-forced-updates' '
 	(
 		cd no-forced-update-clone &&
 		git fetch --no-show-forced-updates origin 2>output &&
-		test_i18ngrep ! "(forced update)" output
+		! grep "(forced update)" output
 	)
 '
 
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index af0385fb89..a9a4df21b2 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -284,7 +284,7 @@ test_expect_success GPG 'failed atomic push does not execute GPG' '
 			--signed --atomic --porcelain \
 			dst noop ff noff >out 2>err &&
 
-	test_i18ngrep ! "gpg failed to sign" err &&
+	! grep "gpg failed to sign" err &&
 	cat >expect <<-EOF &&
 	To dst
 	=	refs/heads/noop:refs/heads/noop	[up to date]
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 187454f5dd..6969744d93 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -321,7 +321,7 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep ! "^Writing objects" output
+	! grep "^Writing objects" output
 '
 
 test_expect_success 'push --progress shows progress to non-tty' '
@@ -503,7 +503,7 @@ test_expect_success 'colorize errors/hints' '
 	test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
 	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep ! "^hint: " decoded
+	! grep "^hint: " decoded
 '
 
 test_done
diff --git a/t/t5580-unc-paths.sh b/t/t5580-unc-paths.sh
index cf768b3a27..c143989456 100755
--- a/t/t5580-unc-paths.sh
+++ b/t/t5580-unc-paths.sh
@@ -71,7 +71,7 @@ test_expect_success push '
 test_expect_success MINGW 'remote nick cannot contain backslashes' '
 	BACKSLASHED="$(winpwd | tr / \\\\)" &&
 	git ls-remote "$BACKSLASHED" 2>err &&
-	test_i18ngrep ! "unable to access" err
+	! grep "unable to access" err
 '
 
 test_expect_success 'unc alternates' '
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 7f082fb23b..2eb221adb3 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -89,7 +89,7 @@ test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
 	! grep % err &&
-	test_i18ngrep ! "Checking connectivity" err
+	! grep "Checking connectivity" err
 
 '
 
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 7504ba4751..5af149f58a 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -116,7 +116,7 @@ test_expect_success 'show advice that grafts are deprecated' '
 	test_i18ngrep "git replace" err &&
 	test_config advice.graftFileDeprecated false &&
 	git show HEAD 2>err &&
-	test_i18ngrep ! "git replace" err
+	! grep "git replace" err
 '
 
 test_done
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c80dc10b8f..a6641e8874 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -489,7 +489,7 @@ test_expect_success '--convert-graft-file' '
 	git status 2>stderr &&
 	test_i18ngrep "hint:.*grafts is deprecated" stderr &&
 	git replace --convert-graft-file 2>stderr &&
-	test_i18ngrep ! "hint:.*grafts is deprecated" stderr &&
+	! grep "hint:.*grafts is deprecated" stderr &&
 	test_path_is_missing .git/info/grafts &&
 
 	: verify that the history is now "grafted" &&
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4ab133f489..089f220160 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -591,7 +591,7 @@ test_expect_success '2b: Directory split into two on one side, with equal number
 		git rev-parse >expect \
 			 O:z/b  O:z/c  B:x/d &&
 		test_cmp expect actual &&
-		test_i18ngrep ! "CONFLICT.*directory rename split" out
+		! grep "CONFLICT.*directory rename split" out
 	)
 '
 
@@ -727,7 +727,7 @@ test_expect_success '3b: Avoid implicit rename if involved as source on current
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
-		test_i18ngrep ! CONFLICT.*rename/rename.*y/d out &&
+		! grep CONFLICT.*rename/rename.*y/d out &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
@@ -3606,7 +3606,7 @@ test_expect_merge_algorithm failure success '10e: Does git complain about untrac
 		echo random >z/c &&
 
 		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep ! "following untracked working tree files would be overwritten by merge" err &&
+		! grep "following untracked working tree files would be overwritten by merge" err &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -5356,9 +5356,9 @@ test_expect_success '13e: directory rename detection in recursive case' '
 
 		git -c merge.directoryRenames=conflict merge -s recursive C^0 >out 2>err &&
 
-		test_i18ngrep ! CONFLICT out &&
-		test_i18ngrep ! BUG: err &&
-		test_i18ngrep ! core.dumped err &&
+		! grep CONFLICT out &&
+		! grep BUG: err &&
+		! grep core.dumped err &&
 		test_must_be_empty err &&
 
 		git ls-files >paths &&
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index e29c284b9b..8418050d2d 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -148,7 +148,7 @@ test_expect_success 'refuse two-project merge by default, quit before --autostas
 	echo change >>one.t &&
 	git diff >expect &&
 	test_must_fail git merge --autostash five 2>err &&
-	test_i18ngrep ! "stash" err &&
+	! grep "stash" err &&
 	git diff >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 3ead2b726f..e42a96cad4 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -446,7 +446,7 @@ test_expect_failure !FAIL_PREREQS 'directory/submodule conflict; should not trea
 		# We do not want files within the submodule to prevent the
 		# merge from starting; we should not be writing to such paths
 		# anyway.
-		test_i18ngrep ! "refusing to lose untracked file at" err
+		! grep "refusing to lose untracked file at" err
 	)
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 4a3b8f48ac..8670da6bf9 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -111,7 +111,7 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_commit "$(test_oid obj4)" &&
 
 	git gc --auto 2>err &&
-	test_i18ngrep ! "^warning:" err &&
+	! grep "^warning:" err &&
 	ls .git/objects/pack/ | sort >post_packs &&
 	comm -1 -3 existing_packs post_packs >new &&
 	comm -2 -3 existing_packs post_packs >del &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fec7e0299d..113b25892b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -158,7 +158,7 @@ test_expect_success 'redirected submodule add does not show progress' '
 	git -C addtest submodule add "file://$submodurl/parent" submod-redirected \
 		2>err &&
 	! grep % err &&
-	test_i18ngrep ! "Checking connectivity" err
+	! grep "Checking connectivity" err
 '
 
 test_expect_success 'redirected submodule add --progress does show progress' '
@@ -1101,7 +1101,7 @@ test_expect_success 'submodule deinit deinits a submodule when its work tree is
 	git submodule deinit init example2 >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-	test_i18ngrep ! "Cleared directory .init" actual &&
+	! grep "Cleared directory .init" actual &&
 	test_i18ngrep "Cleared directory .example2" actual &&
 	rmdir init
 '
@@ -1151,19 +1151,19 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit init >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	! grep "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	! grep "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
-	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	! grep "Submodule .example. (.*) unregistered for path .init" actual &&
+	! grep "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit --all >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
-	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	! grep "Submodule .example. (.*) unregistered for path .init" actual &&
+	! grep "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init example2
 '
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index f2e7df59cf..2bae75228e 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -17,7 +17,7 @@ test_expect_success 'git-add on embedded repository warns' '
 test_expect_success '--no-warn-embedded-repo suppresses warning' '
 	test_when_finished "git rm --cached -f embed" &&
 	git add --no-warn-embedded-repo embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	! grep warning stderr
 '
 
 test_expect_success 'no warning when updating entry' '
@@ -25,13 +25,13 @@ test_expect_success 'no warning when updating entry' '
 	git add embed &&
 	git -C embed commit --allow-empty -m two &&
 	git add embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	! grep warning stderr
 '
 
 test_expect_success 'submodule add does not warn' '
 	test_when_finished "git rm -rf submodule .gitmodules" &&
 	git submodule add ./embed submodule 2>stderr &&
-	test_i18ngrep ! warning stderr
+	! grep warning stderr
 '
 
 test_done
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index f70368bc2e..5228c88b9f 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -187,7 +187,7 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 
 		git fsck 2>output &&
 		test_i18ngrep gitmodulesParse output &&
-		test_i18ngrep ! "bad config" output
+		! grep "bad config" output
 	)
 '
 
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index eec96e0ba9..80b36914c4 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -57,7 +57,7 @@ test_expect_success 'trailing backslash is handled correctly' '
 	mv .new .gitmodules &&
 	git commit -am "Add testmodule" &&
 	test_must_fail git clone --verbose --recurse-submodules . dolly 2>err &&
-	test_i18ngrep ! "unknown option" err
+	! grep "unknown option" err
 '
 
 test_expect_success 'fsck rejects missing URL scheme' '
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 14c92e4c25..6639a849c9 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -526,7 +526,7 @@ try_commit () {
 	GIT_EDITOR=.git/FAKE_EDITOR git commit -a $* $use_template &&
 	case "$use_template" in
 	'')
-		test_i18ngrep ! "^## Custom template" .git/COMMIT_EDITMSG ;;
+		! grep "^## Custom template" .git/COMMIT_EDITMSG ;;
 	*)
 		test_i18ngrep "^## Custom template" .git/COMMIT_EDITMSG ;;
 	esac
@@ -546,7 +546,7 @@ try_commit_status_combo () {
 
 	test_expect_success 'commit --no-status' '
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit with commit.status = yes' '
@@ -558,7 +558,7 @@ try_commit_status_combo () {
 	test_expect_success 'commit with commit.status = no' '
 		test_config commit.status no &&
 		try_commit "" &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --status with commit.status = yes' '
@@ -570,7 +570,7 @@ try_commit_status_combo () {
 	test_expect_success 'commit --no-status with commit.status = yes' '
 		test_config commit.status yes &&
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --status with commit.status = no' '
@@ -582,7 +582,7 @@ try_commit_status_combo () {
 	test_expect_success 'commit --no-status with commit.status = no' '
 		test_config commit.status no &&
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 }
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 963fed6821..091c4dadea 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1547,7 +1547,7 @@ test_expect_success 'git commit will commit a staged but ignored submodule' '
 	export GIT_EDITOR &&
 	git commit -uno &&
 	git status -s --ignore-submodules=dirty >output &&
-	test_i18ngrep ! "^M. sm" output
+	! grep "^M. sm" output
 '
 
 test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
@@ -1579,7 +1579,7 @@ EOF
 test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=dirty >output &&
-	test_i18ngrep ! "^M. sm" output &&
+	! grep "^M. sm" output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1626,7 +1626,7 @@ test_expect_success '"No commits yet" should not be noted in status output' '
 	git checkout --orphan empty-branch-2 &&
 	test_commit test-commit-1 &&
 	git status >output &&
-	test_i18ngrep ! "No commits yet" output
+	! grep "No commits yet" output
 '
 
 test_expect_success '"Initial commit" should be noted in commit template' '
@@ -1643,7 +1643,7 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
 	touch to_be_committed_2 &&
 	git add to_be_committed_2 &&
 	git commit --dry-run >output &&
-	test_i18ngrep ! "Initial commit" output
+	! grep "Initial commit" output
 '
 
 test_expect_success '--no-optional-locks prevents index update' '
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index 905957bd0a..1310b4381e 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -13,7 +13,7 @@ test_expect_success 'empty name and missing email' '
 		sane_unset GIT_AUTHOR_EMAIL &&
 		GIT_AUTHOR_NAME= &&
 		test_must_fail git commit --allow-empty -m foo 2>err &&
-		test_i18ngrep ! "(null)" err
+		! grep "(null)" err
 	)
 '
 
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index fbfdcca000..f2c1e0b741 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -290,10 +290,10 @@ do
 			rm -f marker &&
 			git status >actual &&
 			test_path_is_file marker &&
-			test_i18ngrep ! "Changes not staged for commit:" actual &&
+			! grep "Changes not staged for commit:" actual &&
 			if test $uc_val = true
 			then
-				test_i18ngrep ! "Untracked files:" actual
+				! grep "Untracked files:" actual
 			fi &&
 			if test $uc_val = false
 			then
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
index 634fb7f23a..06682b20d0 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 
 test_expect_success 'no warning if hook is not ignored' '
 	git commit --allow-empty -m "more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	! grep -e "hook was ignored" message
 '
 
 test_expect_success POSIXPERM 'warning if hook is ignored' '
@@ -28,14 +28,14 @@ test_expect_success POSIXPERM 'no warning if advice.ignoredHook set to false' '
 	test_config advice.ignoredHook false &&
 	chmod -x "$hook" &&
 	git commit --allow-empty -m "even more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	! grep -e "hook was ignored" message
 '
 
 test_expect_success 'no warning if unset advice.ignoredHook and hook removed' '
 	rm -f "$hook" &&
 	test_unconfig advice.ignoredHook &&
 	git commit --allow-empty -m "even more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	! grep -e "hook was ignored" message
 '
 
 test_done
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933..10b392028e 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -30,58 +30,58 @@ test_expect_success 'setup' '
 test_expect_success 'pull.rebase not set' '
 	git reset --hard c0 &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
 	git reset --hard c0 &&
 	test_config pull.ff only &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c0 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
 	git reset --hard c0 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c0 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
 	git reset --hard c0 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c0 &&
 	git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set (not-fast-forward)' '
@@ -96,51 +96,51 @@ test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	! grep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'merge c1 with c2' '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 991d5bd9c0..a7e17b1a5e 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1268,7 +1268,7 @@ test_expect_success 'grep --no-index prefers paths to revs' '
 
 test_expect_success 'grep --no-index does not "diagnose" revs' '
 	test_must_fail git grep --no-index o :1:hello.c 2>err &&
-	test_i18ngrep ! -i "did you mean" err
+	! grep -i "did you mean" err
 '
 
 cat >expected <<EOF
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 60bab291e4..25cbc16446 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -25,7 +25,7 @@ nul_match_internal () {
 			>stderr &&
 			printf '$pattern' | q_to_nul >f &&
 			test_must_fail env LC_ALL=\"$lc_all\" git grep $extra_flags -f f $flags a 2>stderr &&
-			test_i18ngrep ! 'This is only supported with -P under PCRE v2' stderr
+			! grep 'This is only supported with -P under PCRE v2' stderr
 		"
 	elif test "$matches" = P
 	then
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index c98c1dfc23..3f656bbbaa 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -202,7 +202,7 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 		export PATH &&
 		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
 	) &&
-	test_i18ngrep ! Traceback errs
+	! grep Traceback errs
 '
 
 # Hide a file from p4d, make sure we catch its complaint.  This won't fail in
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index eaaae414a1..22c8106b13 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -460,7 +460,7 @@ test_expect_success 'submit --prepare-p4-only' '
 		git p4 submit --prepare-p4-only >out &&
 		test_i18ngrep "prepared for submission" out &&
 		test_i18ngrep "must be deleted" out &&
-		test_i18ngrep ! "everything below this line is just the diff" out
+		! grep "everything below this line is just the diff" out
 	) &&
 	(
 		cd "$cli" &&
-- 
2.29.2.222.g5d2a92d10f8

