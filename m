Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B45C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 05:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9D46124B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 05:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhFOFST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 01:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOFSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 01:18:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10EFC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 22:16:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f2so16814794wri.11
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 22:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=YOYsgvDSSK6ayOxZ7Qy+bv/ZRBBsFMLuXOiznPevGuQ=;
        b=Ir83bvNINv1NjDTpQ7GWEfjoV6SwFfie60p+e7ZBETAfnh13L+5xxcx99iLbtiL0yM
         Cu3s2ak5Jh6aNEGajSYq+vUF6OTn6n6o2snhHVbO1Y06qnNT2z+9Ifa6vpTCwA8FJR9E
         TvVvs/rNpj/9+TPviJyMgOY3epKRbTesk+47u+4AQFa75jYUssIqFILItc/wVdSp0IsA
         w7Lsn/hoOPVOdYaEkBCBciTEi2HModCRwcp6LrITEoijB06Lrh5/4mLcWudanqnEh0NG
         mw3rR889v9AvlUhLBGLqRo+jULF5fNul14DLvWlpdSwyvqwEFQ9BjpuV/xev3gz3rJfD
         JQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=YOYsgvDSSK6ayOxZ7Qy+bv/ZRBBsFMLuXOiznPevGuQ=;
        b=Z4k/2OYOcQxlkQ+8K6FzhN05Amudg4NvKWHQ5wgnuo+KqcUEfwOW9l65UatIcBAr0d
         frZOJVZHdvLqjCvBaI4ll+3xQFCHKQI0U0u0ugP9nmkOPNu8cSVOnH0tMV4dPeF9lOKP
         XcinBK6XHge2s2EDNVbv3ytljksdCIMkyOL9X6cUVAdl9AgSVd1em/AAm5K/3/XrK8m6
         CTm4s8IJZQ4ZTI50+rgO9vYXoU4Vw/FptLV/YXGCwFcaYLCNmajgQAdFQAMnNrgxKpss
         vOW5QgeYV3A8eDkNrPEgg9jW8598BawHPmbh9BbYA2UDrrkY8icHaMhI0tkQPszEfXlX
         S5Eg==
X-Gm-Message-State: AOAM530m907gREfxQgM0PAgRXBqJeAfnBB+7ailKhW0+Nh+M4qnzGvhy
        tQC+/+h+DVTWdu7+Hi1IQtWSmeGc2e0=
X-Google-Smtp-Source: ABdhPJx0RNd+dq51nd8tw3EAnm6JZ70KPYKVHazu1CoX1JJsy49lTWHYf+O9vc8Lfl8p6Jyp6WBCpA==
X-Received: by 2002:adf:a291:: with SMTP id s17mr22624675wra.399.1623734172478;
        Mon, 14 Jun 2021 22:16:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm18878338wru.56.2021.06.14.22.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 22:16:12 -0700 (PDT)
Message-Id: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 05:16:08 +0000
Subject: [PATCH 0/2] RFC: implement new zdiff3 conflict style
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement a zealous diff3, or "zdiff3". This new mode is identical to
ordinary diff3 except that it allows compaction of common lines between the
two sides of history, if those common lines occur at the beginning or end of
a conflict hunk.

This is just RFC, because I need to add tests. Also, while I've remerged
every merge, revert, or duly marked cherry-pick from both git.git and
linux.git with this patch using the new zdiff3 mode, that only shows it
doesn't segfault. (Though I also reran 10% of the linux remerges with zdiff3
under valgrind without issues.) I looked through some differences between
--remerge-diff with diff3 and --remerge-diff with zdiff3, but those are
essentially diffs of a diff of a diff, which I found hard to read. I'd like
to look through more examples, and use it for a while before submitting the
patches without the RFC tag.

Elijah Newren (2):
  xdiff: implement a zealous diff3, or "zdiff3"
  update documentation for new zdiff3 conflictStyle

 Documentation/config/merge.txt         |  9 ++++-
 Documentation/git-checkout.txt         |  3 +-
 Documentation/git-merge-file.txt       |  3 ++
 Documentation/git-merge.txt            | 32 +++++++++++++---
 Documentation/git-rebase.txt           |  6 +--
 Documentation/git-restore.txt          |  3 +-
 Documentation/git-switch.txt           |  3 +-
 Documentation/technical/rerere.txt     | 10 ++---
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +--
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 52 ++++++++++++++++++++++++--
 14 files changed, 107 insertions(+), 27 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1036%2Fnewren%2Fzdiff3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1036/newren/zdiff3-v1
Pull-Request: https://github.com/git/git/pull/1036
-- 
gitgitgadget
