Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75115C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiLBAH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiLBAHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BAECAFA3
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ml11so8028893ejb.6
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfkSuwqGq1tKx1Utf0WUuru+Hn9E6BHQOy/sGUq5NIg=;
        b=OsTfHnkw1jqQdcjoeMITqO5UXRH7x0dbb6Ciw3pii6X38f1L2pGwUFok87X/oQcocK
         NKCdo58VgaH9D2AL+qlzSrmrigI91jHEZuOGjktR9SmVJ9ResuGtEzsoKx5DjBJhFsEC
         IvCMFLMLjzSuZRnIasOItID9GhDeDib1/jRDnu1lAPGcc2a/VOkxDxW8p7NopulVt4dH
         FdO0O0oHADbmU6XWrvMSWvkLZncirBh4NCGJZUZaov7zoWLi6TpNUf+kq92i4zIQB7UV
         wuAZzWBJg+bDpk5vQ0490wg5O7e1RpspvTBB4bkjcHwpHGq6ddEcwLpm5ZIh5E+GaaN7
         WT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfkSuwqGq1tKx1Utf0WUuru+Hn9E6BHQOy/sGUq5NIg=;
        b=1pjXv10+9wzmKEo3fjvBiVKNPoM+bCSZr41fliLBZLonc3P3iQt7tWxCMa2ZmSjMCP
         cZ6Gfr4PvKjYHOF67dTtxjy3Z2LHVmHH2uaLtpSm01wizNfING4XRh8eK5dyTVXUsOQN
         HF7rNQf26LF9y8XSd2znXZdtLNjSxmg08dCRjXTkl+GEXa9MEzEs7qfC0JoL11Jxcya1
         d4MREdJJNM867S9rRU1omj2rGCcq3my2pIckr4OxvnGLYdaR+S/ChfgC/fAO/wRKvM99
         fio4dd32kkpPk/yMxPn1P+jwm6yBaA6EG978zoUxFbcloJE+y/8m2RFcqfY8xjxyR4Xt
         88nA==
X-Gm-Message-State: ANoB5pmoQPsumDtPP1OrxGwkucfiMLhUK3111R28SQLFBKawVx7TD3g1
        5r5eIqZHa6s4eKx1UolZYTVO/08/NWSf5Q==
X-Google-Smtp-Source: AA0mqf6K0YRsQxe2OQ+OBcNS6iqhKH7/9rRfmQnPcJ4cg8mxJ1UzA2vdSiP33Sr7ghVYO7c7/PjqLg==
X-Received: by 2002:a17:906:f157:b0:7c0:b0fe:263a with SMTP id gw23-20020a170906f15700b007c0b0fe263amr4155151ejb.496.1669939646053;
        Thu, 01 Dec 2022 16:07:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] tests: use "test_cmp_cmd" in misc tests
Date:   Fri,  2 Dec 2022 01:06:34 +0100
Message-Id: <patch-v2-8.8-979a7f003f8-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a few miscellaneous tests to use "test_cmp_cmd" to avoid losing
the exit code of "git".

There's many offenders left that match patterns like:

	/test .*\$\((test-tool|git)/

What these all have in common is that they were the rare odd cases out
in test files that were otherwise consistently checking the exit code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1401-symbolic-ref.sh            | 3 ++-
 t/t2005-checkout-index-symlinks.sh | 2 +-
 t/t3701-add-interactive.sh         | 9 ++++++---
 t/t5522-pull-symlink.sh            | 2 +-
 t/t7402-submodule-rebase.sh        | 4 ++--
 t/t7504-commit-msg-hook.sh         | 2 +-
 t/t7516-commit-races.sh            | 3 ++-
 t/t7810-grep.sh                    | 2 +-
 8 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index d708acdb819..5e36899d207 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -33,7 +33,8 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 reset_to_sane
 
 test_expect_success 'symbolic-ref refuses bare sha1' '
-	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
+	rev=$(git rev-parse HEAD) &&
+	test_must_fail git symbolic-ref HEAD "$rev"
 '
 
 reset_to_sane
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index 112682a45a1..aee80d39221 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -24,6 +24,6 @@ test -f symlink'
 
 test_expect_success \
 'the file must be the blob we added during the setup' '
-test "$(git hash-object -t blob symlink)" = $l'
+test_cmp_cmd "$l" git hash-object -t blob symlink'
 
 test_done
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5841f280fb2..3e59ffd18a0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -296,9 +296,12 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff --cached file | grep "+content" &&
-	test -z "$(git diff file)"
+	git diff --cached file >out &&
+	grep "new mode" <out &&
+	git diff --cached file >out &&
+	grep "+content" <out &&
+	git diff file >out &&
+	test_must_be_empty out
 '
 
 # end of tests disabled when filemode is not usable
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index bcff460d0a2..b36dd40e34e 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -78,7 +78,7 @@ test_expect_success SYMLINKS 'pushing from symlinked subdir' '
 		git commit -m push ./file &&
 		git push
 	) &&
-	test push = $(git show HEAD:subdir/file)
+	test_cmp_cmd push git show HEAD:subdir/file
 '
 
 test_done
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 277bb8ae520..b27d8da69ee 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -55,11 +55,11 @@ chmod a+x fake-editor.sh
 
 test_expect_success 'interactive rebase with a dirty submodule' '
 
-	test submodule = $(git diff --name-only) &&
+	test_cmp_cmd submodule git diff --name-only &&
 	HEAD=$(git rev-parse HEAD) &&
 	GIT_EDITOR="\"$(pwd)/fake-editor.sh\"" EDITOR_TEXT="pick $HEAD" \
 		git rebase -i HEAD^ &&
-	test submodule = $(git diff --name-only)
+	test_cmp_cmd submodule git diff --name-only
 
 '
 
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index a39de8c1126..2b94237f9d1 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -101,7 +101,7 @@ test_expect_success 'setup: commit-msg hook that always fails' '
 '
 
 commit_msg_is () {
-	test "$(git log --pretty=format:%s%b -1)" = "$1"
+	test_cmp_cmd "$1" git log --pretty=tformat:%s%b -1
 }
 
 test_expect_success 'with failing hook' '
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index f2ce14e9071..2d38a16480e 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -10,7 +10,8 @@ test_expect_success 'race to create orphan commit' '
 	test_must_fail env EDITOR=./hare-editor git commit --allow-empty -m tortoise -e &&
 	git show -s --pretty=format:%s >subject &&
 	grep hare subject &&
-	test -z "$(git show -s --pretty=format:%P)"
+	git show -s --pretty=format:%P >out &&
+	test_must_be_empty out
 '
 
 test_expect_success 'race to create non-orphan commit' '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8eded6ab274..232b041b0cf 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1001,7 +1001,7 @@ test_expect_success 'log --committer does not search in timestamp' '
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
-	test "$(git grep test)" = "t/t:test" &&
+	test_cmp_cmd "t/t:test" git grep test &&
 	git update-index --no-assume-unchanged t/t &&
 	git checkout t/t
 '
-- 
2.39.0.rc1.980.g92d3d4579ad

