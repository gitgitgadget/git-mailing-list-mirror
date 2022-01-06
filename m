Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84525C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbiAFWfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiAFWfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:35:02 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5301C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:35:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v123so2808076wme.2
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wkWKk/eYKaXuMreAneDTGiExf4e9gtOKffudc69Gjjg=;
        b=K+q1UML42jZalcbN+54wb2bUtPFYavFg7NFHjhIhmQHUVswYYeQWElCO472hVIWILW
         Pgx7veHs40Hjzlumxjc54uVybpkQuY14z+0eJYc1zBYArua+ihAWb6yVhZqwdppgIdI5
         zCFUdKZzU8PnJ7vY9CUwIPJcl/9VmEAFqWnpcjVSD/DrdaJ4RVO/YhpjlbmM+/5fjTxr
         1Oj0dsUxF2az6yO6MGm59/gHkYxCQ64n9qpn+t2jjEechG0YA/PKU6cdM1BUVrSeqWTo
         AY1eBC8SbWwy+Ettig3JMEfShupw5gGr0fqmXzTa1EflO3wPwfBWjJ/m4SHxmGcjcOQi
         bhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wkWKk/eYKaXuMreAneDTGiExf4e9gtOKffudc69Gjjg=;
        b=kiJWg6U9zQnQKXF4vdIrMMWNzSteftjKoJN417r/AGNErkCdCHL/k7FBNqpnzD4tIO
         Dd7266GmRwlapHdzhoi6BWEXLu7IsOvTNvGsK9pwm8gLbep6TaZIYU3tD0r2je6rVGKC
         cJvS4IGGlgtAsttHjSMOlGnGZRh9IutuC0wIpaUH7HPEqwOfOig0Uzssa7ugmCNBQnCG
         AuEnihNjJmTtJAziBy1E6prRt6aixCM/lzsbXta/0gt+wBYutWs2D26M4Yw688RwVgTK
         eLuUZ68Qn/eqh7aSw38DIRyoFqj0TI6EZi5u/gNEyrtA8k46eOIXumK1YEhYSLpywOH7
         BtpQ==
X-Gm-Message-State: AOAM5331Ox4vVYNMUkpblQygHdE0qvRL05ahj4NtF+E0h4Vi+AAlbpym
        IOw+scIVmcSmqYziUIx5NMGLRk/Mm+I=
X-Google-Smtp-Source: ABdhPJyR876JMOd46QxiUwEFEVXkjjUiNV0yV95ZRLfkwcg+akkfKWDoVdBiABxYOq+9zHgimL3/QA==
X-Received: by 2002:a05:600c:3ba3:: with SMTP id n35mr8621758wms.116.1641508500254;
        Thu, 06 Jan 2022 14:35:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm3102051wrz.82.2022.01.06.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:34:59 -0800 (PST)
Message-Id: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
References: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 22:34:54 +0000
Subject: [PATCH v3 0/4] update-index: refresh should rewrite index in case of racy timestamps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch makes update-index --refresh write the index if it contains racy
timestamps, as discussed at [1].

Changes since v2:

 * new patch: test-lib: introduce API for verifying file mtime
 * new patch: t7508: fix bogus mtime verification for test
   "--no-optional-locks prevents index update"
 * change new tests in t2108 and t7508 to use new test-lib mtime API
 * fix "--refresh has no racy timestamps to fix" to use +60s mtime to be
   save on VFAT

Changes since v1:

 * main commit message now uses 'git update-index' and the paragraph was
   dropped
 * t/t7508-status.sh: two tests added which capture status racy handling
 * builtin/update-index.c: comment improved
 * t/t2108-update-index-refresh-racy.sh: major overhaul
   * one test case added
   * mtime-manipulations simplified and aligned to t7508
   * code style fixes, as discussed

[1]
https://lore.kernel.org/git/d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com/

Marc Strapetz (4):
  test-lib: introduce API for verifying file mtime
  t7508: fix bogus mtime verification
  t7508: add tests capturing racy timestamp handling
  update-index: refresh should rewrite index in case of racy timestamps

 builtin/update-index.c               | 11 +++++
 cache.h                              |  1 +
 read-cache.c                         |  2 +-
 t/t2108-update-index-refresh-racy.sh | 64 ++++++++++++++++++++++++++++
 t/t7508-status.sh                    | 30 ++++++++++---
 t/test-lib-functions.sh              | 28 ++++++++++++
 6 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100755 t/t2108-update-index-refresh-racy.sh


base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1105%2Fmstrap%2Ffeature%2Fupdate-index-refresh-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1105/mstrap/feature/update-index-refresh-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1105

Range-diff vs v2:

 -:  ----------- > 1:  e6301e9d770 test-lib: introduce API for verifying file mtime
 -:  ----------- > 2:  d15a23cc804 t7508: fix bogus mtime verification
 1:  7d58f806111 ! 3:  3567ef91e7a t7508: add tests capturing racy timestamp handling
     @@ Commit message
      
       ## t/t7508-status.sh ##
      @@ t/t7508-status.sh: test_expect_success '--no-optional-locks prevents index update' '
     - 	! grep ^1234567890 out
     + 	! test_is_magic_mtime .git/index
       '
       
      +test_expect_success 'racy timestamps will be fixed for clean worktree' '
     @@ t/t7508-status.sh: test_expect_success '--no-optional-locks prevents index updat
      +	# no more index writes unless caused by racy timestamps; note that
      +	# timestamps may already be racy now (depending on previous tests)
      +	git status &&
     -+	test-tool chmtime =1234567890 .git/index &&
     -+	test-tool chmtime --get .git/index >out &&
     -+	grep ^1234567890 out &&
     ++	test_set_magic_mtime .git/index &&
      +	git status &&
     -+	test-tool chmtime --get .git/index >out &&
     -+	! grep ^1234567890 out
     ++	! test_is_magic_mtime .git/index
      +'
      +
      +test_expect_success 'racy timestamps will be fixed for dirty worktree' '
      +	echo content2 >racy-dirty &&
      +	git status &&
     -+	test-tool chmtime =1234567890 .git/index &&
     -+	test-tool chmtime --get .git/index >out &&
     -+	grep ^1234567890 out &&
     ++	test_set_magic_mtime .git/index &&
      +	git status &&
     -+	test-tool chmtime --get .git/index >out &&
     -+	! grep ^1234567890 out
     ++	! test_is_magic_mtime .git/index
      +'
      +
       test_done
 2:  dfeabf6af15 ! 4:  4a6b18fb304 update-index: refresh should rewrite index in case of racy timestamps
     @@ t/t2108-update-index-refresh-racy.sh (new)
      +reset_files () {
      +	echo content >file &&
      +	echo content >other &&
     -+	test-tool chmtime =1234567890 file &&
     -+	test-tool chmtime =1234567890 other
     ++	test_set_magic_mtime file &&
     ++	test_set_magic_mtime other
      +}
      +
      +update_assert_changed () {
     -+	test-tool chmtime =1234567890 .git/index &&
     ++	test_set_magic_mtime .git/index &&
      +	test_might_fail git update-index "$1" &&
     -+	test-tool chmtime --get .git/index >.git/out &&
     -+	! grep ^1234567890 .git/out
     ++	! test_is_magic_mtime .git/index
      +}
      +
      +test_expect_success 'setup' '
     @@ t/t2108-update-index-refresh-racy.sh (new)
      +
      +test_expect_success '--refresh has no racy timestamps to fix' '
      +	reset_files &&
     -+	test-tool chmtime =1234567891 .git/index &&
     ++	# set the index time far enough to the future;
     ++	# it must be at least 3 seconds for VFAT
     ++	test_set_magic_mtime .git/index +60 &&
      +	git update-index --refresh &&
     -+	test-tool chmtime --get .git/index >.git/out &&
     -+	grep ^1234567891 .git/out
     ++	test_is_magic_mtime .git/index +60
      +'
      +
      +test_expect_success '--refresh should fix racy timestamp' '
     @@ t/t2108-update-index-refresh-racy.sh (new)
      +test_expect_success '--refresh should fix racy timestamp if other file needs update' '
      +	reset_files &&
      +	echo content2 >other &&
     -+	test-tool chmtime =1234567890 other &&
     ++	test_set_magic_mtime other &&
      +	update_assert_changed --refresh
      +'
      +
      +test_expect_success '--refresh should fix racy timestamp if racy file needs update' '
      +	reset_files &&
      +	echo content2 >file &&
     -+	test-tool chmtime =1234567890 file &&
     ++	test_set_magic_mtime file &&
      +	update_assert_changed --refresh
      +'
      +

-- 
gitgitgadget
