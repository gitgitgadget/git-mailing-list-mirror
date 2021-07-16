Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94042C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C187613DF
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 07:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhGPHqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhGPHqe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 03:46:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67185C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 00:43:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l6so5243831wmq.0
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=V5bQMnNYeWGsV/Vzvd0tJVj8+QH8FLBJPfCqovULDHc=;
        b=AV8AeB3LkcBkMCy8l2mTjFh/TdMI+EFny5wwyuEazUwTgAxvo68hBympyT6mBUzE+j
         0uLYuaeiryaW7mJZdVVI1rADrwedclvp3dgsb1Rozjaq1J642MBCHSlS9fJ1HBwWy+8W
         8GZp2VCZxfsKgpK36zmD7wxWoWOfX5SaLjnYIl89xxCtBc8VFQgfp4RpZ+kKPi3yLph7
         B1PnNwlCGXqrfg1JtztkQSQnsO/xR/SuBkZQAEfF/J/y1s3PRma4qaLgd6JeNtz+DVos
         6+ZcmEKTM9IiV42XjshV7FNHlo5iec9tQmL9LKk3quHZXksGM8pGIKV8q5fv9u7tfglR
         1hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V5bQMnNYeWGsV/Vzvd0tJVj8+QH8FLBJPfCqovULDHc=;
        b=BanZnzmkfyy9SzbOT8rnfNBJL3lWjYczad1r+Ebh5/wJaTQIBany+X6ht6OHevlMnx
         wow+tcoxA8xWKxglE642+lBytkm2w/VQ/R3g9V73qGaCyZdatmRdQFbY5jDuZ1/Mv248
         LHb0rS0lhfoYyvt8eiyGoZL/dVZhqrdW6Gqy5MpofeVc20iTKpVNIcXNxeROvwJCnZPT
         GorlOSHYKAJs1PwzPcWjKDmUl0tRI/bavGNohjJfZOdp18qPbVxY6NDNwz4GmiT9cR8Z
         HsRsSYDyw4BaH4BNkB5UTmoPSX+3KYw15E4Ukv0xph64ViCqOcnmL/zC5H+AHMPYfoc3
         R4ew==
X-Gm-Message-State: AOAM531nTUwb2uEHyldgacE5zx6U1zPppcedlLPVyXSP+mAR6+ChPDYq
        8HrLjcQZSN3L0Se2FtCceZPbQsAyNv4=
X-Google-Smtp-Source: ABdhPJy6YXBQGdU/0jzho8Q1Gk/yxiYwBYJepzsieamBTWLL0fHjvRoPdWaSRUgPIfgjevt6qBjPtg==
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr9079624wmh.85.1626421418096;
        Fri, 16 Jul 2021 00:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm6503924wma.19.2021.07.16.00.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 00:43:37 -0700 (PDT)
Message-Id: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
From:   "Luca Weiss via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 07:43:34 +0000
Subject: [PATCH 0/2] Normalize newlines in merge & interpret-trailer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches fix a problem where the trailer would be appended to the
commit message without an empty line, so parsing the trailers again
afterwards would fail.

In practice either one of the patches fixes the exact behavior I see but in
both cases it makes sense to normalize the newlines.

The exact use case where this issue was found is a "git merge --no-edit"
with a commit-msg hook that adds a trailer immediately afterwards. The input
the commit-msg script gets is not terminated by a newline (which is fixed by
the second commit) while the first one makes interpret-trailer capable of
handling such input without a final newline.

Luca Weiss (2):
  trailer: handle input without trailing newline
  merge: make sure to terminate message with newline

 builtin/merge.c               | 1 +
 t/t7513-interpret-trailers.sh | 7 +++++++
 trailer.c                     | 3 +++
 3 files changed, 11 insertions(+)


base-commit: 75ae10bc75336db031ee58d13c5037b929235912
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1048%2Fz3ntu%2Fmaster-newline-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1048/z3ntu/master-newline-v1
Pull-Request: https://github.com/git/git/pull/1048
-- 
gitgitgadget
