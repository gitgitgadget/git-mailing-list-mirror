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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0652EC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09D160FDA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhH0Swg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhH0Swf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:52:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326EFC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 11:51:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g138so4469907wmg.4
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SAhfvQAXGr1NpD1bWQTY3eTLZipFNDLHmdS8q4a+H8g=;
        b=Zu+fIVYIYrAoXK1G5jbu3kzPmJ0xbAQ6xdbU9QeZcHuXWipjydAkmE02+HvzPBzZtl
         2NJVfCvKbTlld+6yQeaN9idk+LNxwkxZuDT0mCVWI2KUFIzp7OXiV1Vg3OYAwKnXJRn9
         cx9pXuVJpmJLBl5BEIq5mzogEEEgC4SowUtT63OEZEhfjG0ZeWyQuJ+9hQOWNAmZbhJ8
         rJlGDkqxp8+JBSrh+hK9Sc6PW3QNTXSbadOfwAK2d7GH7Edb4dx3rbpn82GTC1+mf0n8
         hUoDJTg0KZDE3BRnuyD8sCqxL4QGTr8eQjAPUNefSLSA0QrP1qgffqpVCbVfLZ6X4clo
         23lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SAhfvQAXGr1NpD1bWQTY3eTLZipFNDLHmdS8q4a+H8g=;
        b=S/ZPkQKGm/2WUC67cOBywqC69OUHNQmtspwI4eLTsIwXHdTXv9ArxuIgDu4fVlmswK
         /s7rMKicH12GKoN6JBkkaVX1FpFvDNJ8G/wFo29cD/WnblNqdhpH0t4Ihf3ao/b/tcUe
         rU1pU+dTdCK4Xg069w0bStkuT8J+pVel9+T6UxWXcqn25ACG2NwRY3P3+uTGMpJf6e+m
         mEsOz4fDAC7LRrOR8FW/ORoSzoFDh1jAjrxIqY8FZMzkHtVMDVxa7Y/xNE65jZ/j/wp5
         uQwhK2KvxapxtMiERWwX5v3lSGEhgX5bu8K55QXCc+cjZRkbNxhAwuRvScEmun+hp/9A
         /MOQ==
X-Gm-Message-State: AOAM533PQK/kwj0+AYNMNi1LTZD6xiExiDv/hl0rQlXNFB5mo5wz8ZHR
        rqzRf8SxUhFa1/4f4GwN/whmj10Xh2U=
X-Google-Smtp-Source: ABdhPJwuEGPrivFQ5sVXNJwFXZkXfbcsKEWOS4qh+J7FtmHoEdCzpaEETY2vX5EUriGIm054ruXp6A==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr7308513wmq.39.1630090304627;
        Fri, 27 Aug 2021 11:51:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q195sm6447654wme.37.2021.08.27.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:51:44 -0700 (PDT)
Message-Id: <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com>
In-Reply-To: <pull.1078.v3.git.git.1630087821429.gitgitgadget@gmail.com>
References: <pull.1078.v3.git.git.1630087821429.gitgitgadget@gmail.com>
From:   "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 18:51:43 +0000
Subject: [PATCH v4] submodule: absorb git dir instead of dying on deinit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Mugdha Pattnaik <mugdhapattnaik@gmail.com>,
        mugdha <mugdhapattnaik@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: mugdha <mugdhapattnaik@gmail.com>

Currently, running 'git submodule deinit' on repos where the
submodule's '.git' is a directory, aborts with a message that is not
exactly user friendly. Let's change this to instead warn the user
to rerun the command with '--force'.

This internally calls 'absorb_git_dir_into_superproject()', which
moves the git dir into the superproject and replaces it with
a '.git' file. The rest of the deinit function can operate as it
already does with new-style submodules.

We also edit a test case such that it matches the new behaviour of
deinit.

Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
---
    submodule: absorb git dir instead of dying on deinit
    
    Changes since v3:
    
     * Replaced 1 instance of the word "folder" with "directory"
     * Fixed tab spacing
    
    Thank you, Mugdha

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v4
Pull-Request: https://github.com/git/git/pull/1078

Range-diff vs v3:

 1:  1ac65b2458b ! 1:  7460fc0e12a submodule: absorb git dir instead of dying on deinit
     @@ builtin/submodule--helper.c: static void deinit_submodule(const char *path, cons
      +		if (is_directory(sub_git_dir)) {
      +			if (!(flags & OPT_FORCE))
      +				die(_("Submodule work tree '%s' contains a "
     -+					  ".git directory.\nUse --force if you want "
     -+					  "to move its contents to superproject's "
     -+					  "module folder and convert .git to a file "
     -+					  "and then proceed with deinit."),
     -+					displaypath);
     ++				      ".git directory.\nUse --force if you want "
     ++				      "to move its contents to superproject's "
     ++				      "module directory and convert .git to a file "
     ++				      "and then proceed with deinit."),
     ++				    displaypath);
      +
      +			if (!(flags & OPT_QUIET))
      +				warning(_("Submodule work tree '%s' contains a .git "
     -+						  "directory. This will be replaced with a "
     -+						  ".git file by using absorbgitdirs."),
     -+						displaypath);
     ++					  "directory. This will be replaced with a "
     ++					  ".git file by using absorbgitdirs."),
     ++					displaypath);
      +
      +			absorb_git_dir_into_superproject(displaypath, flags);
      +


 builtin/submodule--helper.c | 28 ++++++++++++++++++----------
 t/t7400-submodule-basic.sh  | 10 +++++-----
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e45..040b26f149d 100644
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
+				      ".git directory.\nUse --force if you want "
+				      "to move its contents to superproject's "
+				      "module directory and convert .git to a file "
+				      "and then proceed with deinit."),
+				    displaypath);
+
+			if (!(flags & OPT_QUIET))
+				warning(_("Submodule work tree '%s' contains a .git "
+					  "directory. This will be replaced with a "
+					  ".git file by using absorbgitdirs."),
+					displaypath);
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
