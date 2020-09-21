Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F36EC43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368B6206A2
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en/atC+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgIUNa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgIUNax (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:30:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A06C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so12153263wme.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wBY9T7tGgA6VMkdlw8PulQT76cO8LOyYj15zcODQui8=;
        b=en/atC+N934SXF8Q0Bs/9wcUIg89+TzNPApMRIqlpQD/ckoAz+Ia4CM/loOkXGHSq9
         /6+hBlSMPGqq6EYdJhEQfgpWdh/4dSwHTdzW/qk5xTqEzB9W1ER7lDQXwyAPJnHuRaeK
         myBk1bB8OdfQ0CyKcmXsO/A6pssDPxuxvgwMLeYaeim0fFcy+SYcsbubKlzYj6udQrBR
         wzeYLR0rtdd2tiGlnhL2Mz6FHZCcEXHoSWvGBxObgauPn+/YXNcD/becFd5at1OWfOr7
         VNa/ISTmyjRc8W+3aVoSoe3PmA8FiXQnI78Tm/RZERj/6efXrOqA7gs4I/95XtA/gBSx
         JHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wBY9T7tGgA6VMkdlw8PulQT76cO8LOyYj15zcODQui8=;
        b=bsWe9gLF+GaV+8j8SA8p4oxId+meTS3i3SrOx7217aIYKQ3p0kPqU7vNqztBwe5aCE
         DFzgap53dIuwEL1NgrZI3V+mF3nXRYxToyh9rqxocpp35wViV+rQrvv7TSZFkqErMNoj
         +Gwypje3CJnjUfrjB2suYS3QqRst7GcEQm160WoN4cX5MxcDYs2FEyDLJdykKTNSgNxc
         Ax0brzhhC9I9J9Tfa2SHn5cpb1Iti1GHgjF/h36mwABdQSH2Zhd7vCRRi/OkE56uNd2l
         c/LBpqZ5g6g0A/VQAVVkflpsPYC6SkIAzcr4jHzUdaW7KTnfIYsr0yjjZSpZo/VTuGgq
         rKew==
X-Gm-Message-State: AOAM532kQV2QIDINVN4ixztxsVstIGBDeLqTms/fxDqbdhD8WTZtN0xc
        xJ3gSS9QmFfF0eL8NbvBDyXQEEnVOm4=
X-Google-Smtp-Source: ABdhPJwFd6waQlSNkf6KOHMWs84kdZYw5/YnTcTvrOeX49cw9pm/QRm6KcpZj9xz4/rzlh5oNonMqg==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr31070119wmg.117.1600695051560;
        Mon, 21 Sep 2020 06:30:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm20901164wro.5.2020.09.21.06.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 06:30:51 -0700 (PDT)
Message-Id: <pull.736.git.1600695050.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 13:30:47 +0000
Subject: [PATCH 0/3] commit: add an option to reword the last commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If one notices a typo in the last commit after starting to stage changes for
the next commit it is useful to be able to reword the last commit without
changing its contents. Currently the way to do that is by specifying --amend
--only with no pathspec which is not that obvious to new users (so much so
that before beb635ca9c ("commit: remove 'Clever' message for --only
--amend", 2016-12-09) commit printed a message to congratulate the user on
figuring out how to do it). If the last commit is empty one has to pass
--allow-empty as well even though the contents are not being changed. These
patches contain a couple of small clean ups for the commit documentation add
a --reword option for commit that rewords the last commit without changing
its contents.

Phillip Wood (3):
  commit docs: use backquotes when quoting options
  commit: reorder synopsis
  commit: add an option the reword HEAD

 Documentation/git-commit.txt          | 30 +++++++++-----
 builtin/commit.c                      | 46 +++++++++++++++++++++-
 t/t7501-commit-basic-functionality.sh | 56 +++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 11 deletions(-)


base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-736%2Fphillipwood%2Fwip%2Fcommit-reword-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-736/phillipwood/wip/commit-reword-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/736
-- 
gitgitgadget
