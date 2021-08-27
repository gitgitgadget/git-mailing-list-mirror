Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A3C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CC160F6F
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbhH0GEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 02:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbhH0GEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 02:04:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C09C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 23:03:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o39-20020a05600c512700b002e74638b567so3552904wms.2
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 23:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C25KAxIG7qtUQb+9BA12Ga1N5fJeU28k5H2yX7N3oZ0=;
        b=bWytjzAHwykeiknGkscwPkm8jqCp8qYJHkh4DLdJmj4b6HID77S5y8TXAuyjp7ckv9
         1FH557esaRb+fRoJG0+e4D5E9vMMcSJSs6bGKcpR/kYHmaPcWWR3IXyvg3nOkr71ou+L
         msq+SwGDPROFvteBlZgsxnxfkD81u32b1zdOnF5D+RQSEQbAIbzjPLEodOXdlEYIkp65
         da4eeOMTmMF55HfMBbNidQC8U+GqA738PmJaRZfdD9RFeaGn5onRmSPexcIRxaKEpNF3
         SLEgqd2HmP9CnpFFAHrQRJk6tcGe7zAjefMvQ7RH7JBNXuMVBtj0rEtTVhph0PNq3i0q
         A4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C25KAxIG7qtUQb+9BA12Ga1N5fJeU28k5H2yX7N3oZ0=;
        b=OuuvQ3sR+cdul4cefNltPv9MvSm4f1lSAgLIc3JTI8gAI7gU0uytCoonr9DinEw+3V
         bFFgIEnHrXKd+syyTicXvp/BVhW9wsGICVyYAD2rmzVmV66H7DeXDE2oarT1BLSp2mTH
         Zi1n6whOrttc6DisB9DebjUBQRcPkcxHy/qEC81QHyQmASMzsVNC8gjSeqNzwJX1PDvA
         w5A2Ta8tFfPTk2IZyo2TK0FK4uwtxxvzokU3dWruIdRDOCWS4P9VWFrQ6X6Kio9yUhng
         4Rrs7WaqUb9TGr2jT/Szxr21xUf/V96NQ3DBReJfIn6sfayFrSWx/QVqTibrF3NNY6+O
         RWgg==
X-Gm-Message-State: AOAM533ybOHJScaXSQgRCiUsMsXgism1mRbUAAM4087qk7GGBScKatYB
        hibRv4tHYT/Xwf9DgcneMf2MknmBRQQ=
X-Google-Smtp-Source: ABdhPJwh+fCSe3qZSgjWPidNXjgGshO5KZZM5iEzu7Be0Q4/78gzWWJuyTQKTYLRsiJ4YfOa74fGCA==
X-Received: by 2002:a05:600c:4a23:: with SMTP id c35mr17565185wmp.140.1630044220159;
        Thu, 26 Aug 2021 23:03:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm5541924wrz.61.2021.08.26.23.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 23:03:39 -0700 (PDT)
Message-Id: <pull.1078.v2.git.git.1630044219145.gitgitgadget@gmail.com>
In-Reply-To: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com>
References: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com>
From:   "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 06:03:38 +0000
Subject: [PATCH v2] submodule: absorb git dir instead of dying on deinit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mugdha Pattnaik <mugdhapattnaik@gmail.com>,
        mugdha <mugdhapattnaik@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: mugdha <mugdhapattnaik@gmail.com>

Currently, running 'git submodule deinit' on repos where the
submodule's '.git' is a folder aborts with a message that is not
exactly user friendly. Let's change this to instead warn the user
to rerun the command with '--force'.

This internally calls 'absorb_git_dir_into_superproject()', which
moves the '.git' folder into the superproject and replaces it with
a '.git' file. The rest of the deinit function can operate as it
already does with new-style submodules.

We also edit a test case such that it matches the new behaviour of
deinit.

Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
---
    submodule: absorb git dir instead of dying on deinit
    
    We also edit a test case such that it matches the new behaviour of
    deinit.
    
    I have changed the 'cp -R ../.git/modules/example .git' to 'mv
    ../.git/modules/example .git' since, at the time of testing, the test
    would fail - deinit now would be moving the '.git' folder into the
    superproject's '.git/modules/' folder, and since this same folder
    already existed before, it was causing errors. So, before running
    deinit, instead of copying the '.git' folder into the submodule, if we
    move it there instead, this functionality can be appropriately tested.
    
    Changes since v1:
    
     * Removed extra indent within the if statements
     * Moved absorb_git_dir_into_superproject() call outside the if
       condition checking for --quiet flag
    
    Thank you, Mugdha

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v2
Pull-Request: https://github.com/git/git/pull/1078

Range-diff vs v1:

 1:  58814531d17 ! 1:  37c9b598fde submodule: absorb git dir instead of dying on deinit
     @@ builtin/submodule--helper.c: static void deinit_submodule(const char *path, cons
      -			    displaypath);
      +		if (is_directory(sub_git_dir)) {
      +			if (!(flags & OPT_FORCE))
     -+					die(_("Submodule work tree '%s' contains a "
     -+						  ".git directory (use --force if you want "
     -+						  "to move its contents to superproject's "
     -+						  "module folder and convert .git to a file "
     -+						  "and then proceed with deinit)"),
     ++				die(_("Submodule work tree '%s' contains a "
     ++					  ".git directory.\nUse --force if you want "
     ++					  "to move its contents to superproject's "
     ++					  "module folder and convert .git to a file "
     ++					  "and then proceed with deinit."),
     ++					displaypath);
     ++
     ++			if (!(flags & OPT_QUIET))
     ++				warning(_("Submodule work tree '%s' contains a .git "
     ++						  "directory. This will be replaced with a "
     ++						  ".git file by using absorbgitdirs."),
      +						displaypath);
      +
     -+			if (!(flags & OPT_QUIET)) {
     -+					warning(_("Submodule work tree '%s' contains a .git "
     -+							  "directory (this will be replaced with a "
     -+							  ".git file by using absorbgitdirs"),
     -+							displaypath);
     -+					absorb_git_dir_into_superproject(displaypath, flags);
     -+			}
     ++			absorb_git_dir_into_superproject(displaypath, flags);
     ++
      +		}
       
       		if (!(flags & OPT_FORCE)) {


 builtin/submodule--helper.c | 28 ++++++++++++++++++----------
 t/t7400-submodule-basic.sh  | 10 +++++-----
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e45..4730dc141d4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1539,16 +1539,24 @@ static void deinit_submodule(const char *path, const char *prefix,
 		struct strbuf sb_rm = STRBUF_INIT;
 		const char *format;
 
-		/*
-		 * protect submodules containing a .git directory
-		 * NEEDSWORK: instead of dying, automatically call
-		 * absorbgitdirs and (possibly) warn.
-		 */
-		if (is_directory(sub_git_dir))
-			die(_("Submodule work tree '%s' contains a .git "
-			      "directory (use 'rm -rf' if you really want "
-			      "to remove it including all of its history)"),
-			    displaypath);
+		if (is_directory(sub_git_dir)) {
+			if (!(flags & OPT_FORCE))
+				die(_("Submodule work tree '%s' contains a "
+					  ".git directory.\nUse --force if you want "
+					  "to move its contents to superproject's "
+					  "module folder and convert .git to a file "
+					  "and then proceed with deinit."),
+					displaypath);
+
+			if (!(flags & OPT_QUIET))
+				warning(_("Submodule work tree '%s' contains a .git "
+						  "directory. This will be replaced with a "
+						  ".git file by using absorbgitdirs."),
+						displaypath);
+
+			absorb_git_dir_into_superproject(displaypath, flags);
+
+		}
 
 		if (!(flags & OPT_FORCE)) {
 			struct child_process cp_rm = CHILD_PROCESS_INIT;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cb1b8e35dbf..3df71478d06 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1182,18 +1182,18 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	rmdir init example2
 '
 
-test_expect_success 'submodule deinit fails when submodule has a .git directory even when forced' '
+test_expect_success 'submodule deinit fails when submodule has a .git directory unless forced' '
 	git submodule update --init &&
 	(
 		cd init &&
 		rm .git &&
-		cp -R ../.git/modules/example .git &&
+		mv ../.git/modules/example .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git submodule deinit init &&
-	test_must_fail git submodule deinit -f init &&
-	test -d init/.git &&
-	test -n "$(git config --get-regexp "submodule\.example\.")"
+	git submodule deinit -f init &&
+	! test -d init/.git &&
+	test -z "$(git config --get-regexp "submodule\.example\.")"
 '
 
 test_expect_success 'submodule with UTF-8 name' '

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
gitgitgadget
