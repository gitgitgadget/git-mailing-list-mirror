Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E727C433E1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4DE207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+9+zwfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFPXdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFPXdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 19:33:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89176C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:33:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j10so373152wrw.8
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=aqJd2AToqbUPY/FTCnlibb20cF77Qn38gv7myCxFKPc=;
        b=f+9+zwfzAajkdJSb0vJE00Uu9pYGTEUk3RuMMoTZrwXidfGfxr8TX3IkMZwrnyAOEy
         a9e85wJEd6uKqIjLHI27F00wJ3YS14bJBEGIB/91+IsrEv4k+r8E0eM8uHf+2Lz/hhvE
         7t0N63hnZCk0FlAwEgS1Zx09Ja69APGM1k2hEPaK8VfMn7HJmdS7alXOlUMaUljPs1kk
         +QJydYs4e30NGxTx49nmrjnP7OV4mn2K9/1ihyv7wHKTznJKbt8MNjlWZruJBBxKgC79
         Psr+WlkVJ9L/zpmO1ZFCKKtvnSQWmop7oj7EwxwDJd59+lVeirgnd7y+uRf/LC6PDsPm
         SPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aqJd2AToqbUPY/FTCnlibb20cF77Qn38gv7myCxFKPc=;
        b=eL+OnwXMFqAV+GiQlQBip31HouLlgqvoO+8udMWQXqnKmmH/w3VnYoYcwPRuRLOdMv
         vFVZZCSHIVani/em9sTbXFKFYTYVIHtH32HxynKIQ0CS8Ko2n98TkTQcEH8oCZ4hRmES
         x2sgqojSEITxARNdGWszCXHSMdKxrwPxIRpPA132GtI35QDsI5f6ryLMRtZL2RJkUgUA
         mZcedQ2ETzunZ5yt58CvbTNxfZqE0Jn5AXDIfPrkghqdq3C970ngSbxu9FXzmw8s1Qjy
         IJN4W22+P3aSQf4LImgBzUvYVhkks2HjcDpI6eEZu5BhNunxGQRQi8F39QTLudI7TQxl
         pGKQ==
X-Gm-Message-State: AOAM531a2F+FuS/Y0oVv1DJnMAupDyotnZihu7oZn4lQ0HdtJ8x4NmqE
        7cHZ3F0wQxBmuhIQeYf1m41X9HBj
X-Google-Smtp-Source: ABdhPJzIxnByvxMbixdhp+EtCG55ZkrlSJPzuoYSmkiH0PgvyB0uPtLtobK8pUt9CZ34PawsA7XZAQ==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr5559744wrp.426.1592350415103;
        Tue, 16 Jun 2020 16:33:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm6051777wmh.27.2020.06.16.16.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 16:33:34 -0700 (PDT)
Message-Id: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 23:33:31 +0000
Subject: [PATCH 0/2] Sparse checkout status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the feedback of folks trying out sparse-checkouts at $dayjob is that
sparse checkouts can sometimes be disorienting; users can forget that they
had a sparse-checkout and then wonder where files went. This series adds
some output to 'git status' and modifies git-prompt slightly as an attempt
to help.

For reference, I suspect that in repositories that are large enough that
people always use sparse-checkouts (e.g. windows or office repos), that this
isn't a problem. But when the repository is approximately
linux-kernel-sized, then it is reasonable for some folks to have a full
checkout. sparse-checkouts, however, can provide various build system and
IDE performance improvements, so we have a split of users who have
sparse-checkouts and those who have full checkouts. It's easy for users who
are bridging in between the two worlds or just trying out sparse-checkouts
for the first time to get confused.

Elijah Newren (2):
  [RFC] wt-status: show sparse checkout status as well
  [RFC] git-prompt: include sparsity state as well

 contrib/completion/git-prompt.sh |  7 ++++++-
 wt-status.c                      | 35 ++++++++++++++++++++++++++++++++
 wt-status.h                      |  1 +
 3 files changed, 42 insertions(+), 1 deletion(-)


base-commit: eebb51ba8cab97c0b3f3f18eaab7796803b8494b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-808%2Fnewren%2Fsparse-checkout-status-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-808/newren/sparse-checkout-status-v1
Pull-Request: https://github.com/git/git/pull/808
-- 
gitgitgadget
