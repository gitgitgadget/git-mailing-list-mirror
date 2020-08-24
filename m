Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1EAC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EF42078D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DumyLpzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHXOv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgHXOvu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 10:51:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6063C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:51:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w13so8667167wrk.5
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=s0ZCRNI0/7+H9gtupCpUG5D7jjsu4n0GAJguf34rfLg=;
        b=DumyLpzcQ6b1qIxdAwHqX/2EamdD0Otx2j2eH2Fjma+RNCvVpfSv2xx/bvm8Yt7h5Z
         sWTyaQmQdcmyzZYZIR9goBGDcJrggr2ugf3MEdNo42pJG25uG9N5m+vZpLaVwtUiJvuB
         zX58/cZNHPQ8qEst/SDpxRO5dq34f+kDXc8VkGNXSYMHjDWJTerl/n1e56AvTsgmgyye
         7NToPMdr970dTmjaWLClHowBuqSfQn+WTr/PN/CgOb+Q4BXcyW0iBlmyjB1R2Scf92vx
         /MwFJF4max23Ey0egru5zVb86WNlsiDX6c2CkZyIe+9if0zdcW79PpO5ysqKG2THfY10
         wqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s0ZCRNI0/7+H9gtupCpUG5D7jjsu4n0GAJguf34rfLg=;
        b=BcIbQB53XOfFiKiT56Suh3QKaLh69eOJAZqocQI8nBDTwh6QN3yPRZsoNuTpmf+8HB
         bjsm6Z3lc1ocFVkICjLUqDUxgxwSkz2LU2q3buxhChj/anWFv9e0+Gcm1g2dvxKk8FFe
         HpD61IYe/UrqUWfjy8jiHyphyib0MbE8q4tmEA7NfZXbc6Zxk6lkKo7+C7cUt73HXhO/
         PqX+29DBoH4WYHbY5YSQle/VrvMVqOipYv4e8TuHSM09mv4bLGSrAvWqd2d4jdJPz4XM
         fTNCdjwLjy/fP9VdUgL5lEcCwSJkM/JObtFZNbFgASHWmu7neERO27c5psvD60yeG1Qp
         i65Q==
X-Gm-Message-State: AOAM530fyhYoq9ttlNAHfCaHqO+0CXeTXoC0Dj/F5jcG7fzUkmseDtWo
        TG89I6ik35LY5i00BUSK7auyQyUE8g4=
X-Google-Smtp-Source: ABdhPJxhNeWAWGI+nafaUHcdT8A6eCwDIhUR1yXFyhNavjXw8sY3KLd6FqXj1Zez+z6S3VKfHVFM6w==
X-Received: by 2002:adf:8b12:: with SMTP id n18mr938848wra.192.1598280708331;
        Mon, 24 Aug 2020 07:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2sm25053544wrg.73.2020.08.24.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:51:47 -0700 (PDT)
Message-Id: <pull.708.git.1598280703.gitgitgadget@gmail.com>
From:   "Vadim Sannikov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 14:51:41 +0000
Subject: [PATCH 0/2] Update update-index --cacheinfo entries' format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vadim Sannikov <vsj.vadim@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to git-update-index manual page:

> --cacheinfo <mode>,<object>,<path>--cacheinfo <mode> <object> <path>
> Directly insert the specified info into the index. For backward
> compatibility, you can also give these three arguments as three separate
> parameters, but new users are encouraged to use a single-parameter form.

So, my commits change every old-style entry in code to the new format. It's
not entirely necessary, but it unifies --cacheinfo usage across the code.

Vadim Sannikov (2):
  Unify `update-index --cacheinfo` usage
  Unify `update-index --cacheinfo` usage (tests)

 git-merge-one-file.sh             |  6 +++---
 git-mergetool.sh                  |  2 +-
 merge-recursive.c                 |  2 +-
 po/bg.po                          |  4 ++--
 po/ca.po                          |  4 ++--
 po/de.po                          |  4 ++--
 po/el.po                          |  2 +-
 po/es.po                          |  4 ++--
 po/fr.po                          |  4 ++--
 po/git.pot                        |  2 +-
 po/it.po                          |  4 ++--
 po/ko.po                          |  4 ++--
 po/ru.po                          |  8 ++++++--
 po/sv.po                          |  4 ++--
 po/tr.po                          |  4 ++--
 po/vi.po                          |  4 ++--
 po/zh_CN.po                       |  4 ++--
 po/zh_TW.po                       |  4 ++--
 t/lib-submodule-update.sh         |  2 +-
 t/t0028-working-tree-encoding.sh  |  4 ++--
 t/t1006-cat-file.sh               |  2 +-
 t/t1010-mktree.sh                 |  2 +-
 t/t1050-large.sh                  |  2 +-
 t/t1450-fsck.sh                   |  4 ++--
 t/t3600-rm.sh                     |  4 ++--
 t/t5520-pull.sh                   |  2 +-
 t/t5526-fetch-submodules.sh       | 18 +++++++++---------
 t/t5531-deep-submodule-push.sh    |  2 +-
 t/t6130-pathspec-noglob.sh        |  2 +-
 t/t6430-merge-recursive.sh        |  2 +-
 t/t7003-filter-branch.sh          |  2 +-
 t/t7011-skip-worktree-reading.sh  |  4 ++--
 t/t7012-skip-worktree-writing.sh  |  4 ++--
 t/t7113-post-index-change-hook.sh |  2 +-
 t/t7406-submodule-update.sh       |  4 ++--
 t/t9350-fast-export.sh            |  8 ++++----
 t/test-lib-functions.sh           |  2 +-
 37 files changed, 73 insertions(+), 69 deletions(-)


base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-708%2Fvadim-vj%2Fcacheinfo-modern-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-708/vadim-vj/cacheinfo-modern-format-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/708
-- 
gitgitgadget
