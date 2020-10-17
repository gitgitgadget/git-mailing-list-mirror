Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF1C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63482076D
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gai4d7xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437945AbgJQQCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 12:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437930AbgJQQCf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 12:02:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF9C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 09:02:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so6748069wrq.11
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=c1GL5rjAlQCccKQBlnI4pzdX36ev4SnSX2dbXbFU1m0=;
        b=Gai4d7xkwa1J/E2/hBByLxJaxQr6azyptSbZ0GV0T/mrOTkvwl3S5/RhvBK6JeG/aH
         0hUAENDVrZ1ISjyjBEOJbmNEK9TlRNiytcperb7q/08NoxyymNqVziaiKLBIuoPQVeKv
         KnvbUuVUgWEYmAlYSLZOpZsWfg9cKg+MUeOjcOBhzNXjx74EQE09Bxf6pOuO8jXrfaxb
         XtDknWNu7xzJIJDKsAiXRx2P5lOvUuXW6q0lpLIhPV9TMQoQaIv81BKSW9vXGTt3impJ
         rXguZwsM+iGVlw+qJerIjQRXTcNA9pqG1/JYdeamuGWomP85VComQH9P5bKSUKEhiYqt
         a2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c1GL5rjAlQCccKQBlnI4pzdX36ev4SnSX2dbXbFU1m0=;
        b=J3ZN00mEga4kZGI06VTyQHNUjnhHhlvS0zcwjfVZfzaTfg6XFKnYIbZgj5nGq1Rk1E
         hmYUrSs1mfvl229tsP0GzyYVDvy7tOIXjRk3jDTlnCvDkIyaqlVzQ7yQt8qh0Ol6LG4t
         RUDex5IlkCzZ+I/apiP4XXVmy2vYj0Nt3d1SGJX0aALo2wE9PvjJLZVyzB1ih2WHuzlb
         GpZ9Wg13MCiahKgnzJzyvl9eTwBvJhWp+g9X9KoQ2HV3ZgbXx5KHYU6rdli25HbFGYHH
         q+WA5QlojNO+rpWMaTBpr/2tiet9yszA2Ikcjb/ItZDyN3DZMEUhdkwIOYQD4ryoTaZw
         Qx/w==
X-Gm-Message-State: AOAM531Woos3By3p/A4wMdU9zprQxSbJaLhJG+QowmB/AnM05vyYvxWy
        ByU4qdpJx473RkOpoMRba0J+pmhLiVU=
X-Google-Smtp-Source: ABdhPJz+rinepEn4YFvoF1/0VUnf8P2PDogmLtNEfHoyPshKovdEfkEwNGfs+CwUwiw4tGl6O23Jfg==
X-Received: by 2002:a5d:488e:: with SMTP id g14mr10895413wrq.203.1602950553532;
        Sat, 17 Oct 2020 09:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm9946075wrs.54.2020.10.17.09.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 09:02:32 -0700 (PDT)
Message-Id: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
From:   "Amanda  Shafack  via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 16:02:30 +0000
Subject: [PATCH 0/2] [Outreachy][Patch v1] t9832,t2200: avoid using pipes in git related commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the upstream of a pipe throws an error, the downstream still executes
normally. This happens because the exit code of the upstream in a pipe is
ignored. This behavior can make debugging very hard in case a test fails.
Also, pipes are prone to deadlocks. If the upstream gets full, the commands
downstream will never start.

Write out the output of the git command to a file, so as to test the exit
codes of both commands.

Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) noticed that the
exit code of upstream in the pipe is ignored, thus using pipes should be
avoided.

Signed-off-by: Amanda Shafack shafack.likhene@gmail.com
[shafack.likhene@gmail.com]

Amanda  Shafack (1):
  t2200: modify code syntax

Amanda Shafack (1):
  t9832,t2200: avoid using pipes in git commands

 t/t2200-add-update.sh | 3 ++-
 t/t9832-unshelve.sh   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)


base-commit: a5fa49ff0a8f3252c6bff49f92b85e7683868f8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-885%2Flkmandy%2Favoid-pipes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-885/lkmandy/avoid-pipes-v1
Pull-Request: https://github.com/git/git/pull/885
-- 
gitgitgadget
