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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B386C43381
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251F22255F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbhAKOs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbhAKOs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 09:48:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD49C0617A4
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t16so60508wra.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNvdlV+inKRYOudlb1/O8epV30d2P3y8YyoOEbdlUnY=;
        b=rP8eZSjjCSX9OxF2r/hxpId42Cr4nwIFCCXtv9fHWOgooqTBUsm7iNv/w90sEWHjfJ
         WSecwfIujVB+SgPzeizXijRlMQEOl1RNbwjMjKNmt+IIC8vr7HArKaROEA9FdEN+KDf0
         BncXDYfEF60sQMdwZx7tgnDp9dHi6tq9zWRcmLSkEs7/p0XZd07deOFJUK1cQ4m0eVd3
         fksHyD0uM+eE8ohCmUvVZcHNTMa865ZTm3WcwkKySY/MBYCC9JSlaTmZY/ly+jF590sa
         mP9NE064VpQDgrPVlftg0DUxoV1xd5DzEZgGwAe38LO3zFUj9EjZLOH0dxZblQwbqVj+
         1zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNvdlV+inKRYOudlb1/O8epV30d2P3y8YyoOEbdlUnY=;
        b=dg8EcFCme7aBTsV73Hi21RCeAGcdBZdd1lEfXSpDsJZnLXLIVnkpw4O1rmucw8I3MO
         ckyKXdWSuz7XMAgpGLux06i6UOZUtsUl+wBPWINZ8A1cIEhZNOkBvCa1G0I3N/bHIURw
         HnV/eskKzeKBidzSe/ENVoP8T/JjRW8iFfrTreBgH+BmAj7AijxPHZHGksTQNTx4+O+m
         Jn073Gi81s3qZa+Qwg9mkv13bHtJyqtC/GghiKg8FgStPmwU9vxOptCS7q6hmgztlOHt
         mV7FKZhpOtt/eUBV83seOdaoIxGSlVngmGj+bPusDgPD7kV8Wnj9PXKB6+Rv81/1HNNH
         BqHA==
X-Gm-Message-State: AOAM532LAdVZ4qP2qnrUT7NHjKONrsm97VlMtdk5kXb5bDGJuQz4OZki
        e6xJIhjAthtjFMD0WShkucgm2JAeuEym+Q==
X-Google-Smtp-Source: ABdhPJzwfB6uofV4Se3nqkT4cS1LAAcf5b7+NSpm4KLag1sdxFOr/nM02IULmd/L4tPeCJepCqd61g==
X-Received: by 2002:adf:a201:: with SMTP id p1mr16610451wra.65.1610376471901;
        Mon, 11 Jan 2021 06:47:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5sm26132697wrz.18.2021.01.11.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:47:50 -0800 (PST)
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
Subject: [PATCH 5/6] tests: (almost) remove C_LOCALE_OUTPUT prerequisites
Date:   Mon, 11 Jan 2021 15:47:39 +0100
Message-Id: <20210111144740.6092-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Almost entirely Remove the C_LOCALE_OUTPUT prerequisites and its uses
as a part of getting rid of the GIT_TEST_GETTEXT_POISON facility.

As with test_i18ngrep we're not removing the stub C_LOCALE_OUTPUT
prerequisite yet for the benefit of other in-flight code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh                    |  2 +-
 t/t0020-crlf.sh                     |  6 ++----
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
 t/t7810-grep.sh                     |  2 +-
 t/t9003-help-autocorrect.sh         |  7 ++-----
 18 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ba2e8c85..45a88315ad 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -271,7 +271,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	EOF
 "
 
-test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
+test_expect_success 'test --verbose' '
 	run_sub_test_lib_test_err \
 		t1234-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index b63ba62e5d..7081485e21 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -84,10 +84,8 @@ test_expect_success 'safecrlf: print warning only once' '
 	git commit -m "nowarn" &&
 	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >doublewarn &&
 	git add doublewarn 2>err &&
-	if test_have_prereq C_LOCALE_OUTPUT
-	then
-		test $(grep "CRLF will be replaced by LF" err | wc -l) = 1
-	fi
+	grep "CRLF will be replaced by LF" err >err.lines &&
+	test_line_count = 1 err.lines
 '
 
 
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 90da1c7ddc..a7b3e4a2c7 100755
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
index c7878a60ed..138fc9b1c3 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -122,7 +122,7 @@ test_expect_success 'push cannot create a badly named ref' '
 	! grep -e "broken\.\.\.ref" output
 '
 
-test_expect_failure C_LOCALE_OUTPUT 'push --mirror can delete badly named ref' '
+test_expect_failure 'push --mirror can delete badly named ref' '
 	top=$(pwd) &&
 	git init src &&
 	git init dest &&
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 18fa6cf40d..3a4b337ae0 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -311,39 +311,39 @@ test_expect_success 'ambiguous short sha1 ref' '
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
@@ -367,7 +367,7 @@ test_expect_success 'core.disambiguate does not override context' '
 		git -c core.disambiguate=committish rev-parse $sha1^{tree}
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first, then hash order' '
+test_expect_success 'ambiguous commits are printed by type first, then hash order' '
 	test_must_fail git rev-parse 0000 2>stderr &&
 	grep ^hint: stderr >hints &&
 	grep 0000 hints >objects &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b06fc36159..c53ae6b5c7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -447,7 +447,7 @@ test_expect_success 'verbose flag is heeded, even after --continue' '
 	grep "^ file1 | 2 +-$" output
 '
 
-test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor once' '
+test_expect_success 'multi-squash only fires up editor once' '
 	base=$(git rev-parse HEAD~4) &&
 	(
 		set_fake_editor &&
@@ -460,7 +460,7 @@ test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor once' '
 	test 1 = $(git show | grep ONCE | wc -l)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'multi-fixup does not fire up editor' '
+test_expect_success 'multi-fixup does not fire up editor' '
 	git checkout -b multi-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
 	(
@@ -511,7 +511,7 @@ test_expect_success 'commit message retained after conflict' '
 	git branch -D conflict-squash
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messages' '
+test_expect_success 'squash and fixup generate correct log messages' '
 	cat >expect-squash-fixup <<-\EOF &&
 	B
 
@@ -538,7 +538,7 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 	git branch -D squash-fixup
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
+test_expect_success 'squash ignores comments' '
 	git checkout -b skip-comments E &&
 	base=$(git rev-parse HEAD~4) &&
 	(
@@ -554,7 +554,7 @@ test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
 	git branch -D skip-comments
 '
 
-test_expect_success C_LOCALE_OUTPUT 'squash ignores blank lines' '
+test_expect_success 'squash ignores blank lines' '
 	git checkout -b skip-blank-lines E &&
 	base=$(git rev-parse HEAD~4) &&
 	(
@@ -992,7 +992,7 @@ test_expect_success 'rebase -ix with several instances of --exec' '
 	test_cmp expected actual
 '
 
-test_expect_success C_LOCALE_OUTPUT 'rebase -ix with --autosquash' '
+test_expect_success 'rebase -ix with --autosquash' '
 	git reset --hard execute &&
 	git checkout -b autosquash &&
 	echo second >second.txt &&
@@ -1133,7 +1133,7 @@ test_expect_success 'rebase -i --root reword root when root has untracked file c
 	test "$(git rev-list --count HEAD)" = 2
 '
 
-test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
+test_expect_success 'rebase --edit-todo does not work on non-interactive rebase' '
 	git checkout reword-original-root-branch &&
 	git reset --hard &&
 	git checkout conflict-branch &&
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 7bab6000dc..e678f26c01 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -303,23 +303,23 @@ test_auto_fixup_fixup () {
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
index cc3f434a97..6cdde711e0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -367,7 +367,7 @@ test_expect_success 'setup expected' '
 '
 
 # Test splitting the first patch, then adding both
-test_expect_success C_LOCALE_OUTPUT 'add first line works' '
+test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	printf "%s\n" s y y | git add -p file 2>error |
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 6579c81216..bd59328e4b 100755
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
index 749bc1431a..5ec0f47b56 100755
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
index 392201cabd..d586fdc7a9 100755
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
index 8db6c1feaf..3d5360d7cd 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -56,7 +56,7 @@ test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
 	git remote add myremote git@host.com:team/repo.git
 '
 
-test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
+test_expect_success 'remote information for the origin' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
@@ -78,7 +78,7 @@ test_expect_success 'add another remote' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'check remote-tracking' '
+test_expect_success 'check remote-tracking' '
 	(
 		cd test &&
 		check_remote_track origin main side &&
@@ -104,7 +104,7 @@ test_expect_success 'remove remote' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'remove remote' '
+test_expect_success 'remove remote' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index bfb282744e..b7233fc8ce 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -944,7 +944,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
+test_expect_success 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -959,7 +959,7 @@ test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	test_cmp expect actual
 '
 
-test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
+test_expect_success 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 7df3c5373a..d2b02fd25e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -37,7 +37,7 @@ test_expect_success 'clone with excess parameters (2)' '
 
 '
 
-test_expect_success C_LOCALE_OUTPUT 'output from clone' '
+test_expect_success 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
 	test $(grep Clon output | wc -l) = 1
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 089f220160..2ca70f6274 100755
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
index cb5e34d94c..a74816ca8b 100755
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
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a7e17b1a5e..0c4a0e3865 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -978,7 +978,7 @@ do
 	"
 done
 
-test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'grep --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS 'grep --threads=N or pack.threads=N warns when no pthreads' '
 	git grep --threads=2 Hello hello_world 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 03cd5c5423..f00deaf381 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -56,11 +56,8 @@ test_expect_success 'autocorrect can be declined altogether' '
 	git config help.autocorrect never &&
 
 	test_must_fail git lfg 2>actual &&
-	if test_have_prereq C_LOCALE_OUTPUT
-	then
-		grep "is not a git command" actual &&
-		test_line_count = 1 actual
-	fi
+	grep "is not a git command" actual &&
+	test_line_count = 1 actual
 '
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

