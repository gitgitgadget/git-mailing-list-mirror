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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB7C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E678A22D58
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405636AbhALIse (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389517AbhALIs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:48:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C1EC061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r4so1262125wmh.5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xDbTyy2k8ddneaa0zG+v58ARtgrWMBVCHMC1Twpq0lE=;
        b=hPi7AnNIysc6v3MA0FdR+uLRc9FcmArXo+MH4m99H2YAgzYtp/odyjUGP37/TkCSoK
         cz40UuXxaULb+z74R+hpvCMx6mdbgaRspV5Vy2CiBBIhnjnDuYxRscOcPN5sGDBpiQfs
         plful8j1nPaqde7xf8kwa6pfCur68KjFRpiM4aLmcJTcZT6vy0pQVEdOZlmW9JvUJ5do
         GOA/2WoR5YrElh7a53MNBBNHU2puKpsgCi9La3OulL6moEqV00QAgwYe21quyeC6422x
         v3N3PEF6+ZFaS+q0NCuSDMu96GH4HKgTytWFnOrOSKgqIlbgxS2Rzj89/EiTyB2yD3Jc
         6f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xDbTyy2k8ddneaa0zG+v58ARtgrWMBVCHMC1Twpq0lE=;
        b=m2miV+mns2KjxDmF8krsrFvCbPlOJ1rNc3UV94q7WkD1jcvYKalHJm1UxO6y3nOZxJ
         RnX725vk7xK4yHF2kbyM69Qt1rGwrx7YaBP9Zyt2Rjytl/Jx4a/Bk0xIeNpiifamr9sq
         wBt2fAb+qvtrpHbqpTjQKJT+GnHdKQpuStqcgwP8KtrW0UDrzmRlUL5JWg+Guc+DBHYh
         lC2dzcmfPYNkKHP9zog26zy04BTiYzEUMph0mYorYUnZ/ayBYtdOlSNofGhxk6OwRWLT
         1NCnKruC9yYqEQgtyCODG5Bh1tDB9YHC/qLyMTY7LF1qLvb1SneEPeUsWB/3tsQpalHu
         uOaA==
X-Gm-Message-State: AOAM5311WFssJuQkEHlFl7GcPaumCa43a+8GFeEa2I6TD1bFWrFXstsr
        YxWP5bH2YA3CmnOyc8sj24qD2sYyjF4=
X-Google-Smtp-Source: ABdhPJw8kiS+yiKpV/BrcX5kk+eYDHXVZWzK2DmxDwMk0olVKTDX5zIOMEbU5bA/2bX/ykOoTH14PA==
X-Received: by 2002:a1c:988f:: with SMTP id a137mr2477467wme.130.1610441265639;
        Tue, 12 Jan 2021 00:47:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm4179541wre.54.2021.01.12.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:45 -0800 (PST)
Message-Id: <004f90026031cb7ce71689481fabd27aa63485dd.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:32 +0000
Subject: [PATCH 01/11] tests: remove unnecessary GIT_TEST_GETTEXT_POISON=false
 constructs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The idea of the `GETTEXT_POISON` mode is to test translated messages, at
least _somewhat_.

There is not really any point in turning off that mode by force, except
_maybe_ to test the mode itself.

So let's avoid overriding `GIT_TEST_GETTEXT_POISON` in the test suite
unless testing the `GETTEXT_POISON` functionality itself.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0017-env-helper.sh     | 6 ++----
 t/t1305-config-include.sh | 6 ++----
 t/t7201-co.sh             | 4 ++--
 t/t9902-completion.sh     | 1 -
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index c1ecf6aeac6..e0931310306 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -85,10 +85,8 @@ test_expect_success 'env--helper reads config thanks to trace2' '
 	git config -f home/.gitconfig include.path cycle &&
 	git config -f home/cycle include.path .gitconfig &&
 
-	test_must_fail \
-		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=false \
-		git config -l 2>err &&
-	grep "exceeded maximum include depth" err &&
+	test_must_fail env HOME="$(pwd)/home" git config -l 2>err &&
+	test_i18ngrep "exceeded maximum include depth" err &&
 
 	test_must_fail \
 		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=true \
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f1e1b289f98..308c5d530b3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -352,10 +352,8 @@ test_expect_success 'include cycles are detected' '
 	git init --bare cycle &&
 	git -C cycle config include.path cycle &&
 	git config -f cycle/cycle include.path config &&
-	test_must_fail \
-		env GIT_TEST_GETTEXT_POISON=false \
-		git -C cycle config --get-all test.value 2>stderr &&
-	grep "exceeded maximum include depth" stderr
+	test_must_fail git -C cycle config --get-all test.value 2>stderr &&
+	test_i18ngrep "exceeded maximum include depth" stderr
 '
 
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b36a93056fd..630406a73c5 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -245,8 +245,8 @@ test_expect_success 'checkout to detach HEAD' '
 	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer &&
 	git clean -f &&
-	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
-	grep "HEAD is now at $rev" messages &&
+	git checkout renamer^ 2>messages &&
+	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a1c4f1f6d40..e5adee27d41 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2363,7 +2363,6 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 '
 
 test_expect_success 'sourcing the completion script clears cached merge strategies' '
-	GIT_TEST_GETTEXT_POISON=false &&
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-- 
gitgitgadget

