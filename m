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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CCC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8CB60F92
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhH0SLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhH0SLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:11:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65246C061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 11:10:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso7824447wmj.0
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/KJMlJnCdVx8b/Q/CXsuFDMNkc6ZjtR4W3BiY81v8Ok=;
        b=Vmy3lQVhqp3Nli9Tg45pA53fvaUNMTdA+Wiy6q0HnYuvCjDPvqrQXaDHsM8BGJR+4Q
         Q7UufcR8R7D4VK3o5J063FnyMHFDoEyfC9J/afoiwK0vDjxXdckfYl2eC2idpfcGPM6D
         FWDsL6xIyLhCCPm0dw6aaRJuBVKTyKczVZV/jeMKEqit0Tll7jWKog/anGh2bT2UF45u
         8yMB8rhPIxCv+Y6/eyPz1OS14R0rTbqz9QtPaKx9a2cw6Qmn7t/4chjP4M9NxE1+Wxq7
         qyI973TlFPqc4mAN0ZMuIY07eQjz9dTX70MhQMKFvMLQ1ObtILymuAxDktLjNR/RcbWD
         uBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/KJMlJnCdVx8b/Q/CXsuFDMNkc6ZjtR4W3BiY81v8Ok=;
        b=TTwL/ag7OvUDPQjrwwYkqsnilMMZTXFgTU+910t8C/oCdYdsXcQcz0YGQRiR9Oxdtl
         iMA2b1eEiDX9RJ+kSCxBvMe0fEVLF81rLM51parQu+Pt+C9aJ5gaFMoB8nePsEuIBdwV
         G2dQlEjK498s1n9AcKsVbj74B/baXiXc2eYeDQXWOb2kZifXoVCxeDsSl5e+vrCrsseD
         uHHE39EItsqQNKiG958Md3/BlAL/A8TryLvWcr3hBY6defENDnmd0LedjGL1ShLUqHCd
         2cMxicH8vn4B7bKl7N6qDOln5LjvO+b8wF2j0HslyCcla//GQovH3INlIDL8BnugAPiA
         DYyQ==
X-Gm-Message-State: AOAM531koC+fnmlE/prAxhmA6H1iGmMLlXIk9bHm4RESY39nBZLJZbrL
        4GXoRvUvhP1dK9VUnOKZ4kqv2dmGLjw=
X-Google-Smtp-Source: ABdhPJxSqtdJemH7NxPKE3KHF1yqUKiEcKryLvXcs4MpJWHFNMfU21EyJVjwWRCelWxPIA+QToAsXA==
X-Received: by 2002:a1c:4407:: with SMTP id r7mr21480570wma.150.1630087823047;
        Fri, 27 Aug 2021 11:10:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm6913740wrb.62.2021.08.27.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:10:22 -0700 (PDT)
Message-Id: <pull.1078.v3.git.git.1630087821429.gitgitgadget@gmail.com>
In-Reply-To: <pull.1078.v2.git.git.1630044219145.gitgitgadget@gmail.com>
References: <pull.1078.v2.git.git.1630044219145.gitgitgadget@gmail.com>
From:   "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 18:10:21 +0000
Subject: [PATCH v3] submodule: absorb git dir instead of dying on deinit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
    
    Changes since v2:
    
     * Replaced all instances of the word "folder" with either "directory"
       or "git dir"
    
    Thank you, Mugdha
    
    cc: Bagas Sanjaya bagasdotme@gmail.com
    
    cc: Atharva Raykar raykar.ath@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v3
Pull-Request: https://github.com/git/git/pull/1078

Range-diff vs v2:

 1:  37c9b598fde ! 1:  1ac65b2458b submodule: absorb git dir instead of dying on deinit
     @@ Commit message
          submodule: absorb git dir instead of dying on deinit
      
          Currently, running 'git submodule deinit' on repos where the
     -    submodule's '.git' is a folder aborts with a message that is not
     +    submodule's '.git' is a directory, aborts with a message that is not
          exactly user friendly. Let's change this to instead warn the user
          to rerun the command with '--force'.
      
          This internally calls 'absorb_git_dir_into_superproject()', which
     -    moves the '.git' folder into the superproject and replaces it with
     +    moves the git dir into the superproject and replaces it with
          a '.git' file. The rest of the deinit function can operate as it
          already does with new-style submodules.
      


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
