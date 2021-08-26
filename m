Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC10C4320A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDA660FE6
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbhHZSeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbhHZSeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:34:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC89C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 11:33:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x12so6491083wrr.11
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8ync9m2L1FjKhKUyF99249GEcOe/UJVYgMpq/g6D4NU=;
        b=uEKcnOm5HJSYOo9KboQlOcJ+suEVT4XeskU5+HtHOE2Ov7DbY0hy0hr5mJ6yIQzUvj
         q1Ij0MEB6lmnFEQkeEqH4NuiDpf6NhDhlck9zjln6jh9E0uHQlSd4V+XDrwJLwMawHOR
         jjgaD4VUDfqtu4EhujINCQ417NIL0XyWdxoIuVOSpebEuxM40T473R2t5g6BYj+djLK6
         BPqw1g8J+1M9umTy+ghMwLF5XpDujpPz7egosDKc6JPPnEVT2WkHPO2u91smUnQKeLYo
         Z9VoVX5tVDrv0W0PiEkl1hBdVw7KUy8hwB+m/bHwYhVk3IkyHLRCVSzMqTKeK33RnC/Q
         u3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8ync9m2L1FjKhKUyF99249GEcOe/UJVYgMpq/g6D4NU=;
        b=jdl5mphx4hsj1f5b2gb4Nsz3vePJ08TgIHjKro9ue7zww510JSYR50ApgWDhzmCGs2
         C0PoVNfz2AH/OzgJUU3xB5DsR+wASZxWEa4YAyJ7Se6JtGJkUNp4E60Ni15FT+JM9ire
         +9Uy6rl10ayAAYJDuBQeAiXqwju1Wal9JcIrSmtN/wdjaUBctxjGekw1CN8hji2JXqxW
         NTZRv3dT6KX+w6wqGYl2JeQCC3r3aGXfS7+bVpE8Dt9XIR5oHuzs2h0yGB/vacUIC51g
         CFTOOjkf+ek2j6E5omDJ0tMMMBynobAfZ076IRlzkCcMVjGVS71SNO8UTUuaa/tvq64r
         p8mA==
X-Gm-Message-State: AOAM533E7HMlFfugu/Yb6I1gHRKtM8+S5/1v6CAw7DmHKNf3F5jayAM9
        1dnWAGsakxASyVurwxmBd4Et/Y/DvTA=
X-Google-Smtp-Source: ABdhPJwYLzOfG/AX6MbfzvjXs83lsNaBPpugWOlHJf7hIUAMBifBX2u7c0w6owzKzDt/Vv86DQZcWw==
X-Received: by 2002:a5d:6d8f:: with SMTP id l15mr5786661wrs.42.1630002795733;
        Thu, 26 Aug 2021 11:33:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm3806669wrp.49.2021.08.26.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 11:33:15 -0700 (PDT)
Message-Id: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com>
From:   "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Aug 2021 18:33:14 +0000
Subject: [PATCH] submodule: absorb git dir instead of dying on deinit
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
    
    Thank you, Mugdha

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v1
Pull-Request: https://github.com/git/git/pull/1078

 builtin/submodule--helper.c | 27 +++++++++++++++++----------
 t/t7400-submodule-basic.sh  | 10 +++++-----
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e45..253ddce1c41 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1539,16 +1539,23 @@ static void deinit_submodule(const char *path, const char *prefix,
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
+					die(_("Submodule work tree '%s' contains a "
+						  ".git directory (use --force if you want "
+						  "to move its contents to superproject's "
+						  "module folder and convert .git to a file "
+						  "and then proceed with deinit)"),
+						displaypath);
+
+			if (!(flags & OPT_QUIET)) {
+					warning(_("Submodule work tree '%s' contains a .git "
+							  "directory (this will be replaced with a "
+							  ".git file by using absorbgitdirs"),
+							displaypath);
+					absorb_git_dir_into_superproject(displaypath, flags);
+			}
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
