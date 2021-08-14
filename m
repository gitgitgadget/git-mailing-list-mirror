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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A8C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7634560F4B
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhHNVlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 17:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHNVlC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 17:41:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ADBC061764
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 14:40:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q6so6609583wrv.6
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+BdkStR9WjtB4JCUgsFA1/nVqZCV/zr4jPBDTpAYWaI=;
        b=uAC6GAiUdKRwnqbXoIMJcNAWUFKm1nLlU5DoammoD75j5tCqBwnBBmA66RWXJslKsT
         mrLIXZIvqweqaKGUAcHI5MY981sg3mvEXI7mghtVpJXIwK7fY2MdMMFt3dnfCTKxEt5W
         ZQTNkamiaCFcChXKqZsHy10q3tERNrk2tXP8Y9s5ay3DASteJRQCO7c7uMqCYyKAV5Q6
         1BoxvbLh+dCBNtHaqCPWleB/C50reYKLpdEIIT7d3S9PJo56letVYOItIXcbPDJSGTRx
         xDO7GK57gnS65KW034YsZ18Pm5EDQl2oRdr2QkxV9cPeNVpfwlKxSUFK84eN69w2bZxe
         naTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+BdkStR9WjtB4JCUgsFA1/nVqZCV/zr4jPBDTpAYWaI=;
        b=EPstN0uDbgTGAZayBpEdVMfRgzSUS5Gqf3FiY7nGy4WcIzOj0rv3dT++xIc7lZpnfp
         pS7PVpOd/rKDusVzRzVYDW78HUf8wqwKg7XBrYvzatHkaHtRX1lEmUMrOglrxk8SCeWE
         N0QKYqzGffngBEg7Pj2Csc3aA1aO+eXZ19pa1QYuNXTdToTT0bDvWLvdQqQjkn+G16s/
         ZLxCXzb40iWiHxp5qZ1yviTxGJ9L1iJIL8FCXTS7ErJRxKnFazDrEaVx99CFmFaZcI4N
         myG9DkFuftJZ3X65ljpd3oRs7ZjWxSuchx6HM/8yMp0NeqvP1XYBzFG4I/m+4Lt3B/Xf
         t4sw==
X-Gm-Message-State: AOAM533uOSS221fU6f8Hlx4nyOtQgmJqRnvex05YKdvZVo0h1tdi2vIj
        7oEM2ZUISuEmeU0/ZrBP65jiGJlqwgs=
X-Google-Smtp-Source: ABdhPJy0gO/45mhhGi2sO5gQwMqz0ceo+VKo6rMVOfbvhWrDLRd6N25HydTca7iczdkKLjrzTEDD2g==
X-Received: by 2002:adf:f245:: with SMTP id b5mr9742863wrp.78.1628977231669;
        Sat, 14 Aug 2021 14:40:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm6186795wrv.37.2021.08.14.14.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:40:31 -0700 (PDT)
Message-Id: <pull.1014.v5.git.1628977230247.gitgitgadget@gmail.com>
In-Reply-To: <pull.1014.v4.git.1628769334197.gitgitgadget@gmail.com>
References: <pull.1014.v4.git.1628769334197.gitgitgadget@gmail.com>
From:   "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Aug 2021 21:40:30 +0000
Subject: [PATCH v5] commit: restore --edit when combined with --fixup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Joel Klinghed <the_jk@spawned.biz>,
        Joel Klinghed <the_jk@spawned.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Klinghed <the_jk@spawned.biz>

Recent changes to --fixup, adding amend suboption, caused the
--edit flag to be ignored as use_editor was always set to zero.

Restore edit_flag having higher priority than fixup_message when
deciding the value of use_editor by moving the edit flag condition
later in the method.

Signed-off-by: Joel Klinghed <the_jk@spawned.biz>
---
    commit: restore --edit when combined with --fixup
    
    Recent changes to --fixup, adding amend suboption, caused the --edit
    flag to be ignored as use_editor was always set to zero.
    
    Restore edit_flag having higher priority than fixup_message when
    deciding the value of use_editor by only changing the default if
    edit_flag is not set.
    
    Changes since v1: Added test verifying that --fixup --edit brings up
    editor.
    
    Changes since v2: Clarify if condition and use write_script helper in
    test.
    
    Changes since v3: Simplify test.
    
    Changes since v4: Using cleaner fix by Phillip Wood instead and added an
    explicit verification to a test for --fixup without --edit.
    
    Signed-off-by: Joel Klinghed the_jk@spawned.biz

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1014%2Fthejk%2Ffixup_edit-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1014/thejk/fixup_edit-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1014

Range-diff vs v4:

 1:  0c0cb647e03 ! 1:  1c608daf0cd commit: restore --edit when combined with --fixup
     @@ Commit message
          --edit flag to be ignored as use_editor was always set to zero.
      
          Restore edit_flag having higher priority than fixup_message when
     -    deciding the value of use_editor by only changing the default
     -    if edit_flag is not set.
     +    deciding the value of use_editor by moving the edit flag condition
     +    later in the method.
      
          Signed-off-by: Joel Klinghed <the_jk@spawned.biz>
      
       ## builtin/commit.c ##
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
     - 		} else {
     - 			fixup_commit = fixup_message;
     - 			fixup_prefix = "fixup";
     --			use_editor = 0;
     -+			if (edit_flag < 0)
     -+				use_editor = 0;
     + 
     + 	if (logfile || have_option_m || use_message)
     + 		use_editor = 0;
     +-	if (0 <= edit_flag)
     +-		use_editor = edit_flag;
     + 
     + 	/* Sanity check options */
     + 	if (amend && !current_head)
     +@@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
       		}
       	}
       
     ++	if (0 <= edit_flag)
     ++		use_editor = edit_flag;
     ++
     + 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
     + 
     + 	handle_untracked_files_arg(s);
      
       ## t/t7500-commit-template-squash-signoff.sh ##
     +@@ t/t7500-commit-template-squash-signoff.sh: EOF
     + 
     + test_expect_success 'commit --fixup provides correct one-line commit message' '
     + 	commit_for_rebase_autosquash_setup &&
     +-	git commit --fixup HEAD~1 &&
     ++	EDITOR="echo ignored >>" git commit --fixup HEAD~1 &&
     + 	commit_msg_is "fixup! target message subject line"
     + '
     + 
      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup -m"something" -m"extra"' '
       
       extra"


 builtin/commit.c                          | 5 +++--
 t/t7500-commit-template-squash-signoff.sh | 9 ++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43b..854903ad113 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1246,8 +1246,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (logfile || have_option_m || use_message)
 		use_editor = 0;
-	if (0 <= edit_flag)
-		use_editor = edit_flag;
 
 	/* Sanity check options */
 	if (amend && !current_head)
@@ -1337,6 +1335,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		}
 	}
 
+	if (0 <= edit_flag)
+		use_editor = edit_flag;
+
 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 7d02f79c0de..8515736003a 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -270,7 +270,7 @@ EOF
 
 test_expect_success 'commit --fixup provides correct one-line commit message' '
 	commit_for_rebase_autosquash_setup &&
-	git commit --fixup HEAD~1 &&
+	EDITOR="echo ignored >>" git commit --fixup HEAD~1 &&
 	commit_msg_is "fixup! target message subject line"
 '
 
@@ -281,6 +281,13 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
 
 extra"
 '
+test_expect_success 'commit --fixup --edit' '
+	commit_for_rebase_autosquash_setup &&
+	EDITOR="printf \"something\nextra\" >>" git commit --fixup HEAD~1 --edit &&
+	commit_msg_is "fixup! target message subject linesomething
+extra"
+'
+
 get_commit_msg () {
 	rev="$1" &&
 	git log -1 --pretty=format:"%B" "$rev"

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
