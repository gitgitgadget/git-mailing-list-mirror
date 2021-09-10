Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4512AC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F3F610C8
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhIJKbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhIJKbK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:31:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F988C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:29:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w29so1154984wra.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=azrHGlFBxpY2WcVsSGH/q4iBKGUiKsb/4Kes5RjGzIY=;
        b=I1Ji4NBK4dO1dJdJDlqs14Iw5dMCQ0k4M7HSVMFI21VB3graix4p+PYq1Q+4udaTWn
         dR0Xk3n1qCX2c106C98Z1Uh0suPQNb0Xwpq2gEAB2iSKC2lZoCuySaJ1FtGcTjlrnw4f
         ZuOzlLGQr3PitVO4YeZe+ivFaqxvYnyYtZFwIIZETH214yj4pue32a6bGLnrixf4rqgm
         X8Ai9QFarSALD5jDnZ6Oi5uY4OhyyBiwPff2DDN/FLhWQwsBqN/xLy7SBjmq3hoc7WlJ
         52U4I8iS/LWEp/K7CYyMHtC6E05WfGd9yhQCqr/NjF1HHXLrzZjw7WP9P6AXEXjnngdK
         xc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=azrHGlFBxpY2WcVsSGH/q4iBKGUiKsb/4Kes5RjGzIY=;
        b=ksu7IWQbzekyVNZ0JM4CVWHd+xvLknVqvVG0pKq+rraePxkP/tli3sxxbOIYx0s/Qk
         TrDUv0W0ulUoAxojLbmQEqGrG7E0jAgglmD3jgtge+nMuYAh/Gzv753ILAkzbcF+5w3u
         4kZ/GREkwPoOK5e8kmt+P2MA3caJd5RjdFvRetVDbt18tcJboyem/ZXXXaUTH4iXUzgX
         W9h2/2J9TUek7TcfNDMzDwwKiOaRUwni84+act2vqtT67nrfnV7sEv7r0rbU9O3NKbqj
         msHy2VZW09/kHfdxe7IO616RBTQGoDda6NAWrAHAd1P291wheAhlnjnRx8nJNGVr/5Pv
         ppdw==
X-Gm-Message-State: AOAM531F0YdU+bDbe1CK5QbjecCyjN7qNu5tvH7M1mJi99jCn/cDT32S
        aMyosV9xCojh2CM8u8j5vZ8eEfq7Hjc=
X-Google-Smtp-Source: ABdhPJw1Yyp1OtzUy1xHHRPD36TItRI5K61djiB7XSxrn7o9B/54eNcBv9vsXKeohyHWCBZznDKHKw==
X-Received: by 2002:a5d:6792:: with SMTP id v18mr6744280wru.416.1631269798137;
        Fri, 10 Sep 2021 03:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j98sm800080wrj.88.2021.09.10.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:29:57 -0700 (PDT)
Message-Id: <pull.1086.v2.git.git.1631269796.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:29:53 +0000
Subject: [PATCH v2 0/3] Fix D/F issues in stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few D/F issues in the stash command. These were some
issues I found while working on unintentional removal of untracked
files/directories and the current working directory, and I'm just submitting
them separately.

Changes since v1:

 * Fix accidental creation of file named 'expect' (copy-paste problem...)
 * Documented the reason for adding is_path_a_directory() and not using
   is_directory()
 * Removed typo, fixed up confusing wording, and added a companion test to
   show that F->D and D->F have the same fix.

Elijah Newren (3):
  t3903: document a pair of directory/file bugs
  stash: avoid feeding directories to update-index
  stash: restore untracked files AFTER restoring tracked files

 builtin/stash.c  | 20 ++++++++++++++---
 t/t3903-stash.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 3 deletions(-)


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1086%2Fnewren%2Fstash-df-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1086/newren/stash-df-fixes-v2
Pull-Request: https://github.com/git/git/pull/1086

Range-diff vs v1:

 1:  bc66a6ae75d ! 1:  5ddb70d332b t3903: document a pair of directory/file bugs
     @@ Metadata
       ## Commit message ##
          t3903: document a pair of directory/file bugs
      
     +    There are three tests here, because the second bug is documented with
     +    two tests: a file -> directory change and a directory -> file change.
     +    The reason for the two tests is just to verify that both are indeed
     +    broken but that both will be fixed by the same simple change (which will
     +    be provided in a subsequent patch).
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t3903-stash.sh ##
     @@ t/t3903-stash.sh: test_expect_success 'stash -c stash.useBuiltin=false warning '
      +		git rm filler &&
      +		mkdir filler &&
      +		echo contents >filler/file &&
     -+		cp filler/file expect &&
      +		git stash push
      +	)
      +'
      +
     -+test_expect_failure 'git stash can pop directory/file saved changes' '
     ++test_expect_failure 'git stash can pop file -> directory saved changes' '
      +	test_create_repo directory_file_switch_v2 &&
      +	(
      +		cd directory_file_switch_v2 &&
     @@ t/t3903-stash.sh: test_expect_success 'stash -c stash.useBuiltin=false warning '
      +		test_cmp expect filler/file
      +	)
      +'
     ++
     ++test_expect_failure 'git stash can pop directory -> file saved changes' '
     ++	test_create_repo directory_file_switch_v3 &&
     ++	(
     ++		cd directory_file_switch_v3 &&
     ++		test_commit init &&
     ++
     ++		mkdir filler &&
     ++		test_write_lines some words >filler/file1 &&
     ++		test_write_lines and stuff >filler/file2 &&
     ++		git add filler &&
     ++		git commit -m filler &&
     ++
     ++		git rm -rf filler &&
     ++		echo contents >filler &&
     ++		cp filler expect &&
     ++		git stash push --include-untracked &&
     ++		git stash apply --index &&
     ++		test_cmp expect filler
     ++	)
     ++'
      +
       test_done
 2:  c7f5ae66a92 ! 2:  31e38c6c33c stash: avoid feeding directories to update-index
     @@ builtin/stash.c: static int reset_head(void)
       
      +static int is_path_a_directory(const char *path)
      +{
     ++	/*
     ++	 * This function differs from abspath.c:is_directory() in that
     ++	 * here we use lstat() instead of stat(); we do not want to
     ++	 * follow symbolic links here.
     ++	 */
      +	struct stat st;
      +	return (!lstat(path, &st) && S_ISDIR(st.st_mode));
      +}
 3:  ac8ca07481d ! 3:  6254938948c stash: restore untracked files AFTER restoring tracked files
     @@ Commit message
          removed.  So, restore changes to tracked files before restoring
          untracked files.
      
     -    There is no similar problem to worry about in the opposite directory,
     -    because untracked files are always additive.  Said another way, there's
     -    no way to "stash a removal of an untracked file" because if an untracked
     -    file is removed, git simply doesn't know about it.
     +    There is no counterpart problem to worry about with the user deleting an
     +    untracked file and then add a tracked one in its place.  Git does not
     +    track untracked files, and so will not know the untracked file was
     +    deleted, and thus won't be able to stash the removal of that file.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ t/t3903-stash.sh: test_expect_success 'git stash succeeds despite directory/file
       	)
       '
       
     --test_expect_failure 'git stash can pop directory/file saved changes' '
     -+test_expect_success 'git stash can pop directory/file saved changes' '
     +-test_expect_failure 'git stash can pop file -> directory saved changes' '
     ++test_expect_success 'git stash can pop file -> directory saved changes' '
       	test_create_repo directory_file_switch_v2 &&
       	(
       		cd directory_file_switch_v2 &&
     +@@ t/t3903-stash.sh: test_expect_failure 'git stash can pop file -> directory saved changes' '
     + 	)
     + '
     + 
     +-test_expect_failure 'git stash can pop directory -> file saved changes' '
     ++test_expect_success 'git stash can pop directory -> file saved changes' '
     + 	test_create_repo directory_file_switch_v3 &&
     + 	(
     + 		cd directory_file_switch_v3 &&

-- 
gitgitgadget
