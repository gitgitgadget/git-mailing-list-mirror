Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1FC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6491D20674
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4nVVm73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGJRT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJRT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 13:19:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6579C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so6690803wrj.13
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4lOawa4rN8Z2voV0YsHZFBndWV+D/orA5IU4R9uPbGY=;
        b=K4nVVm73EFgMmzhzdvPwED5hqCTTgNSaYjD9hkXvu8D/uOpq7BBEHWUOCKAGvE0lNC
         yHN+tNG56KCbeY7bJBeTlbFvSCWnglyDEGtwzVBNM+nwLbM59Nja2jQBgdT/i6S3fGu0
         juxylhD2gkpRXUDdezyF7irBoFK2J/oJIDKxvymJZkIDR1CFpoPeBxhSrUXUh4iqnNO+
         RT+25gp7Pmx8htGDP6KvQ2z6WETmJEyBprxZsu1jcT6PlHyM8G5J5r1jAV2eSjwkcPDQ
         l6vNi1manAk3etwf6guzv98bERbre4h89VPfbUfWFLDGhBmwl5rSCNBO/MLG6piGQ5+y
         h80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4lOawa4rN8Z2voV0YsHZFBndWV+D/orA5IU4R9uPbGY=;
        b=i0H5DGpKgsMy1MAh6y/jfjKYTCWLtzmi10W55YiYjgGA5BY+YxLOuDgKcOIJK0iUHU
         QyDx1k2/ouk8pAJ+yr8Ytm8lVkbu43Uai6eaw9RiMXlwDag/XyqkWszG/LlH7YJcZ+xP
         FybtENeE4Rall9JbCGCbaB/XHSAhuCiY4FsN0AI/a2EKw7lCH14tvL4O+uOA7BhTgtFp
         cl3TDe5Bc7O3cJsVBQDu9GHFYhs54wfPorkuU1+G1xApunwvrXM1norZmbX+l8/aGxaJ
         P0s6mikWXn1WunWAZdTSBBrMe59yjO5it4bzV/SmTKE/hmhjLn5xzxzDQH3E53aZgsPe
         7Czg==
X-Gm-Message-State: AOAM5307aikbQ5Sjt4BgXcpOJvukPKqfONEclk8W8M6wJcBP7PWdRP+R
        +TBiXql7j5gzTogSq7bxpm8zn5zg
X-Google-Smtp-Source: ABdhPJwO0oxs1dS4RcYozJF17ZLF+XMQ2EVx4EdnAYAg65FOyVVf8ukvJfMpIav/SYxXjSGqh6llog==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr67804522wrv.35.1594401595221;
        Fri, 10 Jul 2020 10:19:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm9503962wml.16.2020.07.10.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:19:54 -0700 (PDT)
Message-Id: <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.git.1593518738.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 17:19:49 +0000
Subject: [PATCH v2 0/4] Preliminary fixes for reftable support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are assorted small fixes split out from the reftable topic.

Han-Wen Nienhuys (3):
  lib-t6000.sh: write tag using git-update-ref
  t3432: use git-reflog to inspect the reflog for HEAD
  Treat BISECT_HEAD as a pseudo ref

Junio C Hamano (1):
  Cleanse reflog messages in the refs.c layer

 builtin/bisect--helper.c       |  3 +-
 git-bisect.sh                  |  4 +--
 refs.c                         | 50 ++++++++++++++++++++++++++++------
 refs/files-backend.c           |  2 +-
 refs/refs-internal.h           |  6 ----
 t/lib-t6000.sh                 |  5 ++--
 t/t3432-rebase-fast-forward.sh |  7 +++--
 7 files changed, 51 insertions(+), 26 deletions(-)


base-commit: bd42bbe1a46c0fe486fc33e82969275e27e4dc19
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-669%2Fhanwen%2Fpreliminaries-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-669/hanwen/preliminaries-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/669

Range-diff vs v1:

 1:  b7b2ad8e79 = 1:  0f244ed6cb lib-t6000.sh: write tag using git-update-ref
 2:  f238d1d7f8 ! 2:  123d246edf t3432: use git-reflog to inspect the reflog for HEAD
     @@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head_ () {
       		oldhead=\$(git rev-parse HEAD) &&
       		test_when_finished 'git reset --hard \$oldhead' &&
      -		cp .git/logs/HEAD expect &&
     -+		git reflog HEAD > expect &&
     ++		git reflog HEAD >expect &&
       		git rebase$flag $* >stdout &&
     -+		git reflog HEAD > actual &&
     ++		git reflog HEAD >actual &&
       		if test $what = work
       		then
       			old=\$(wc -l <expect) &&
 3:  8a62cc2668 < -:  ---------- checkout: add '\n' to reflog message
 4:  2b7eb58c15 = 3:  d4007c2a5b Treat BISECT_HEAD as a pseudo ref
 -:  ---------- > 4:  6ca5b99c8d Cleanse reflog messages in the refs.c layer

-- 
gitgitgadget
