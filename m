Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D8C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AFD60EE5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbhIWP2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbhIWP14 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 11:27:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4457C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:26:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t7so18193616wrw.13
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5z/52X8UezEXnW47//C9AVqAmZ3qX1S0frmfGsKzG2E=;
        b=MVfqMwrp9JGQZvdBrBhwlUqzkArUEHGUXi0csJB0dKDmKDFL/mT4nZhFgJoVKfCcGe
         6nOKxVlB3ItvbxLSP7qcey74OS264fFSZWQAvcblLyN2AUDPwUhrJDb/BLmPP1b3li+v
         rdgEfbWVblbNFey7L/TwCKRATcOdQM0E5JNPJu5sNRjmQjEvng9/gHOjAyov3Tv2kG+l
         UjGYCYWdlqZzaCSC6zGYHvT2CfQB2IyA0PVN8MYILX4vQb6uqW5HyGjpZqETEMpIK2TW
         I9KWukbnuOrL1dnev7vNoZApHYCCMV7b8Xh7ZZh/kh0QdF7DQbzlH+2L/UYvZVdKIAuk
         utsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5z/52X8UezEXnW47//C9AVqAmZ3qX1S0frmfGsKzG2E=;
        b=b4kABw38qvVZjqB6Gn+Nfh2/7asnnrUV0vSDXIDN4chQEun3alrHuCRttRkwAsP+bN
         F27vCB8kwFKwjjDKwwSdMgky7NHqo2IZ8YBs8WS4Ui75VJbPXmiUGMM0jZrFNxJDFX5V
         53I80QDAlXtiEEY/Rul/A2m43K2LH+QWm0KJcf2gqZprxxAM3MzWgNsCluThJkkhiuFh
         2oJ+25GAVDOIvaI7czQCWVhcmeHxiAlO5x8NMRZLXyWcpKvF83ZkVwUji24nD7K6fy4W
         q6YgmwzBYbxBc7p1lwxqnGwbct/g0XTrsqZpmEWM8Ajl0bRNEsRJc8qf+W+hnyjW90tP
         pHnQ==
X-Gm-Message-State: AOAM533rtKpEvNOmIDgnRr2xwH1suXNSRjKdmG2wVuktqsFIyilM5pkO
        cDBS0xBsdo/STrBd/FUcmyxnyyVEIZw=
X-Google-Smtp-Source: ABdhPJw3vXoKwNK7HWNEl+RLg26nZ4k30ALuGS7BpAzcyjxWeSXr0vs8MdYT+IR/SnyKI2JNdt8j1Q==
X-Received: by 2002:a05:6000:168b:: with SMTP id y11mr5882282wrd.350.1632410783483;
        Thu, 23 Sep 2021 08:26:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm6734557wrg.18.2021.09.23.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:26:23 -0700 (PDT)
Message-Id: <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Sep 2021 15:26:19 +0000
Subject: [PATCH v2 0/2] rebase -i: a couple of small improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback on V1. I have decided to split this series so I'm
just posting a re-roll of the first two patches here. The only change is to
reword the commit message of the first patch as suggested by Eric and Dscho

Cover letter for V1: Fix the re-reading of the todo list after an exec or
reword command and stop forking "git checkout" when checking out "onto"

Phillip Wood (2):
  sequencer.c: factor out a function
  rebase: fix todo-list rereading

 sequencer.c | 47 +++++++++++++++++++++++++++--------------------
 sequencer.h |  1 -
 2 files changed, 27 insertions(+), 21 deletions(-)


base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1034%2Fphillipwood%2Fwip%2Frebase-reread-todo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1034/phillipwood/wip/rebase-reread-todo-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1034

Range-diff vs v1:

 1:  53cde4825b4 ! 1:  98ebefc140e sequencer.c: factor out a function
     @@ Commit message
          sequencer.c: factor out a function
      
          This code is heavily indented and obscures the high level logic within
     -    the loop. Lets move it to its own function before modifying it in the
     -    next commit.
     +    the loop. Let's move it to its own function before modifying it in the
     +    next commit. Note that there is a subtle change in behavior if the
     +    todo list cannot be reread. Previously todo_list->current was
     +    incremented before returning, now it returns immediately.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 2:  3b17a4e3d3f = 2:  0d89c506192 rebase: fix todo-list rereading
 3:  614555fc10f < -:  ----------- reset_head(): mark oid parameter as const
 4:  39ad40c9297 < -:  ----------- rebase -i: don't fork git checkout
 5:  c8a92d4242b < -:  ----------- rebase: remove unused parameter

-- 
gitgitgadget
