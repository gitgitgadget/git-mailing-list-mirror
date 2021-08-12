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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4AAC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAD761077
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 13:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhHLNmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 09:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbhHLNmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 09:42:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF9FC061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 06:42:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k4so4533778wms.3
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s8803Qj+cCzTVmS/YWvpNopsUeJk0QxyqXdhXmgworY=;
        b=VgjoymDzBDy2TX+qnB3q/QudAzdspA617wbQgRbEZHM+3MukZUYg+EGzC3k4IIU4eW
         Sf3JaI1yL2XVywxGYw9Bo5qoBAmB+MYwnJFrjQYScUOHn9pF7O8wmLs6pFj6I7/4XyDV
         CRNg/wHCn9nZ00HIKOhVech3GXypKZAz0zGJAyWSf2WY3OllDahb6jTmVN8NKuA/1j6J
         O2qJ/IVUkPWDaA09VljVrxaCFJDGqKelHrSwwKPQdrc069tPF6FqwEp7qiUA9GtjKPeL
         A54FVqhlKF5NR9dhc1uqUGlM/xGkzy8p7p+3ei+MAjl1dqy0wwbv/kjWJ6gAzkcXYTJU
         AjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s8803Qj+cCzTVmS/YWvpNopsUeJk0QxyqXdhXmgworY=;
        b=CEdWR2OXJoJ8YoFkp8TDX5TrZXjmJ/9KNt6oblHRPKD6zQ7FWy5Srg01pDUVYcMH5Y
         9oZkAc2wVSqpgj5UYv3qB2o4qV1AGFkiPbUDhlMs2sh6NUCAsb7UF0nWVmcdnBec2X3S
         7jkZKsQc8oNWhpkWIvZgTwXve0gJCyomqZ0WOW8up65fvmgrQOrszphYlMV3WcNomQP9
         kR2e4WnrlPa3ltjE+dzGhdqj87Dw/dvL3aDuXAuCmp2+UMt/dkRj4EaB2Qx4e6czdA2x
         HR8gcngjkOTC4PqR7Dekmry9vsZOZFopq5nQoc479QF6pCmr723y8ELB+usWpxtn2fPG
         Oqkg==
X-Gm-Message-State: AOAM5315hRkwEcFQhUenwZ5A97vqbRBdpv+E+j4T72iviA5dFyCo75Hd
        zrgqv3HHmGStUmcvLqtu2J4+SNccuAw=
X-Google-Smtp-Source: ABdhPJwueg+3JsxelTct9WvozicWIw5JM7OaM+AXTJUXqn/AiRE/mX8VDSlIRTohvP33hAiD81VjHw==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr15818071wml.187.1628775731289;
        Thu, 12 Aug 2021 06:42:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm2940580wrq.69.2021.08.12.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:42:10 -0700 (PDT)
Message-Id: <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Aug 2021 13:42:06 +0000
Subject: [PATCH v2 0/3] rebase --continue: remove .git/MERGE_MSG
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments on V1. I have expanded the commit message for the
first patch to give a bit more context and reworded a couple of test
descriptions in patch 2 as suggested by Elijah. Patch 3 is unchanged.

V1 Cover Letter:

If the user removes all the changes from the worktree without running git
reset then rebase --continue leaves behind .git/MERGE_MSG which will then
seed the message of the next commit. While working on this I noticed a
couple of fixups for the test files I was adding to, I've cc'd Elijah in
case my reasoning for patch 2 is off. Thanks to Victor for the bug report.

cc: Victor Gambier vgambier@excilys.com cc: Elijah Newren newren@gmail.com
cc: Johannes Schindelin Johannes.Schindelin@gmx.de

Phillip Wood (3):
  t3403: fix commit authorship
  rebase --apply: restore some tests
  rebase --continue: remove .git/MERGE_MSG

 sequencer.c                |  3 +++
 t/t3403-rebase-skip.sh     | 13 +++++++++++--
 t/t3418-rebase-continue.sh | 18 ++++++++++++++----
 3 files changed, 28 insertions(+), 6 deletions(-)


base-commit: 2d755dfac9aadab25c3e025b849252b8c0a61465
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1013%2Fphillipwood%2Fwip%2Frebase-remove-merge-msg-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1013/phillipwood/wip/rebase-remove-merge-msg-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1013

Range-diff vs v1:

 1:  7559781ca92 ! 1:  8755dfa9d04 t3403: fix commit authorship
     @@ Commit message
          t3403: fix commit authorship
      
          Setting GIT_AUTHOR_* when committing with --amend will only change the
     -    author if we also pass --reset-author
     +    author if we also pass --reset-author.  This commit is used in some
     +    tests that ensure the author ident does not change when rebasing.
     +    Creating this commit without changing the authorship meant that the
     +    test would not catch regressions that caused rebase to discard the
     +    original authorship information.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 2:  f7722dab21d ! 2:  84fe5823b4f rebase --apply: restore some tests
     @@ Commit message
          from "am" to "merge"", 2020-02-15). However some tests seem to have
          been missed leading to us testing the "merge" backend twice. This
          patch fixes some cases that I noticed while adding tests to these
     -    files, I have not audited all the other rebase test files.
     +    files, I have not audited all the other rebase test files. I've
     +    reworded a couple of the test descriptions to make it clear which
     +    backend they are testing.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ t/t3403-rebase-skip.sh: test_expect_success setup '
       test_expect_success 'rebase --skip can not be used with other options' '
      
       ## t/t3418-rebase-continue.sh ##
     -@@ t/t3418-rebase-continue.sh: test_expect_success 'non-interactive rebase --continue works with touched file'
     +@@ t/t3418-rebase-continue.sh: test_expect_success 'setup' '
     + 	git checkout main
     + '
     + 
     +-test_expect_success 'interactive rebase --continue works with touched file' '
     ++test_expect_success 'merge based rebase --continue with works with touched file' '
     + 	rm -fr .git/rebase-* &&
     + 	git reset --hard &&
     + 	git checkout main &&
     +@@ t/t3418-rebase-continue.sh: test_expect_success 'interactive rebase --continue works with touched file' '
     + 	git rebase --continue
     + '
     + 
     +-test_expect_success 'non-interactive rebase --continue works with touched file' '
     ++test_expect_success 'apply based rebase --continue works with touched file' '
     + 	rm -fr .git/rebase-* &&
       	git reset --hard &&
       	git checkout main &&
       
 3:  6a63b657f13 ! 3:  028c9dfc460 rebase --continue: remove .git/MERGE_MSG
     @@ t/t3403-rebase-skip.sh: test_expect_success 'moved back to branch correctly' '
       	test_must_fail git rebase -i --onto goodbye \
      
       ## t/t3418-rebase-continue.sh ##
     -@@ t/t3418-rebase-continue.sh: test_expect_success 'interactive rebase --continue works with touched file' '
     +@@ t/t3418-rebase-continue.sh: test_expect_success 'merge based rebase --continue with works with touched file'
       	git rebase --continue
       '
       
     -+test_expect_success 'rebase --continue removes .git/MERGE_MSG' '
     ++test_expect_success 'merge based rebase --continue removes .git/MERGE_MSG' '
      +	git checkout -f --detach topic &&
      +
      +	test_must_fail git rebase --onto main HEAD^ &&
     @@ t/t3418-rebase-continue.sh: test_expect_success 'interactive rebase --continue w
      +	test_path_is_missing .git/MERGE_MSG
      +'
      +
     - test_expect_success 'non-interactive rebase --continue works with touched file' '
     + test_expect_success 'apply based rebase --continue works with touched file' '
       	rm -fr .git/rebase-* &&
       	git reset --hard &&

-- 
gitgitgadget
