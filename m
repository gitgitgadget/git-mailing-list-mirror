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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74103C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CC860FC4
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 11:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhHLL4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 07:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhHLL4B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 07:56:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43CC061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 04:55:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h13so7941313wrp.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qqiiCZwwY3gXOfLGPSGN/pVYlXEZsq8DL6fN15wT31U=;
        b=JdBORc1eme/Q+vjaqNZVjBwHxVXUh7LicRJNRcXMXeDJhjiABi8xjsqGlAYFAS9skZ
         5YLwEm7dzO7snAqacfuOPXZOvUH50yJFkzNmJiUDyKyuhn4kw5GaqJ6KiUna2SSZJVey
         MUzoYi/wkMbU7/ohbxRo2Q+ynL3wZhMkXRiUbe2unOApJz8aXgLRlquJ8h2xpbWpOY/f
         hSkdDgemDeQO3M22tt5vK61wFbxPo1IdI2fx0FsAxJ5kFRQxNDT0RNJllpuCtUWjBXW8
         VPpmXVMioyNI2yo7LAb4Hu93fb3kHpHCrwDGxAc+PASaMIOM1unoK1v2GK9o8J9E550B
         5MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qqiiCZwwY3gXOfLGPSGN/pVYlXEZsq8DL6fN15wT31U=;
        b=RYR78oxTXg76j6NrSPssZyzaqVhSdB3qMPnl0KULYKNqvnKODin9UT34f+12ZlkrGD
         mdrWjeHHnO/PGEi4XiQ1peT6j9xKCP1doBJ37IDARLPcQWbNHk34q1+Ru3RYeSkiqMTh
         u7fFRIDj/mUJl7ff6KOMbbK+czs2R4M9kADMJ/lKlBXQYIk1O0Y39+sBJwsnP6YvXr1R
         ybFHHd3vODDT9EgfeMPZ2mtHCN34W3w6OBLHyHv8K+YfV+PiTKHpux3OOhGqusIia5lx
         mmoK6pgJ4xLLSfGv5SkJBTJpOdxE8InjmdKsYvt0qz5nPWY8rMX8BSNo0gOaBzdtmmTA
         4TWw==
X-Gm-Message-State: AOAM531fX8VODwAZxbQZWaDzwLFj75/07WJ2oTFqjV7whE75lIGRXIux
        OpaqUTZWxs45Vc7eilMFKb7kKxovhOQ=
X-Google-Smtp-Source: ABdhPJyK5o99yJb+soC6vrMRH+/PE+nE9kArVqqRLcNO2iF+oWRvqMmg0oKyz44u0E9+G4w0COz8NA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr3712923wro.266.1628769335225;
        Thu, 12 Aug 2021 04:55:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm2519571wmi.4.2021.08.12.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 04:55:34 -0700 (PDT)
Message-Id: <pull.1014.v4.git.1628769334197.gitgitgadget@gmail.com>
In-Reply-To: <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
References: <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
From:   "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Aug 2021 11:55:33 +0000
Subject: [PATCH v4] commit: restore --edit when combined with --fixup
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
deciding the value of use_editor by only changing the default
if edit_flag is not set.

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
    
    Signed-off-by: Joel Klinghed the_jk@spawned.biz

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1014%2Fthejk%2Ffixup_edit-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1014/thejk/fixup_edit-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1014

Range-diff vs v3:

 1:  6bc5d8bbe61 ! 1:  0c0cb647e03 commit: restore --edit when combined with --fixup
     @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup -
       '
      +test_expect_success 'commit --fixup --edit' '
      +	commit_for_rebase_autosquash_setup &&
     -+	write_script e-append <<-\EOF &&
     -+	sed -e "2a\\
     -+something\\
     -+extra" <"$1" >"$1-"
     -+	mv "$1-" "$1"
     -+	EOF
     -+	EDITOR="./e-append" git commit --fixup HEAD~1 --edit &&
     ++	EDITOR="printf \"something\nextra\" >>" git commit --fixup HEAD~1 --edit &&
      +	commit_msg_is "fixup! target message subject linesomething
      +extra"
      +'


 builtin/commit.c                          | 3 ++-
 t/t7500-commit-template-squash-signoff.sh | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43b..560aecd21b1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1333,7 +1333,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		} else {
 			fixup_commit = fixup_message;
 			fixup_prefix = "fixup";
-			use_editor = 0;
+			if (edit_flag < 0)
+				use_editor = 0;
 		}
 	}
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 7d02f79c0de..811566bf847 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
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
