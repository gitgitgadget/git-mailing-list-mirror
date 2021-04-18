Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D4C433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7758C60249
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 18:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhDRSd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhDRSd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 14:33:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA2C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 11:33:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e5so3030923wrg.7
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ejLcOnTxwgPM9c5HAbaFYeVpvHf+fniHfB8AqzEapzc=;
        b=JxuoAVCecROh7eq48UGTlKDDruj+Z4PlygL8Az6pJ4SLrIffKQd2eSvFYYcmG5x2iu
         QeLaC828gjmG2PA6gOmhHO9D4lKWpG0u9QmQozQGUNP92NtBkhXzWcAetmSuqyRX2YbP
         RegM5NZaRHt2IPEZIOd4H7BrGkdKz1PfXbprlOnjYr/b8/vReBGXPdZTamw6jjlGsHV+
         o26MfZMIHZ9k/pjHSQGh50pIzTlwSWBzcCA5d7AgY5XeWMvuydVQ4R5B2IQy4J41ASYO
         KGVInk3dek+Nir3uhUTCAq9RQ5FcvKUsKt9bj5FyVrwxn+M2fmBkk+j09LC72dLo7C4X
         gN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ejLcOnTxwgPM9c5HAbaFYeVpvHf+fniHfB8AqzEapzc=;
        b=Um7uoE/a9bsQEaMnf7zgk0Krsa6++IIB3/cNqTWTjeNpoGOds4zRc+vSS3lcNrfPnU
         f8vXmYgJs4yhGRL1eJpD/NjwvE6htmVkx5/x22yrQKBVUBJzOwZZn8Fg1f8RzjMityjn
         mc9jdkJjr7xRqjw7Gu8Z1Hj3BJIhNm8wtDbjHNex364RAAtZTFdi2SYJuPveuk1Xd19o
         0RcsR03kCcdAx6tJBIlvISu6lY5Y8dV7ITqp2BKOvolJnVk+SzAacWMs0hkW9tF2eLdU
         Z1ViYLLCAt+nyVNNZhgx7AupoDUZTLSIsIH2Coyeh7kAhBll+RA8EPI0m0sTWCWSuemn
         RJXg==
X-Gm-Message-State: AOAM5318/NcfTaR2snID6OErPrXODDUQuhTB8+fQTppOhW58aA/1MNxt
        cttYGZJGjX6e0feEyQHBN1E3Ho4ewOM=
X-Google-Smtp-Source: ABdhPJxIZlBb2ZjwfwkCA0QLpzPpZGFYObsVQ9N1QdPIi/S3wIghjHPOMlwe8YtVbyMQ7ByU1guysg==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr10806100wrq.244.1618770807642;
        Sun, 18 Apr 2021 11:33:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f23sm17062240wmf.37.2021.04.18.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 11:33:27 -0700 (PDT)
Message-Id: <pull.934.git.1618770806366.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Apr 2021 18:33:25 +0000
Subject: [PATCH] git-merge: move space to between strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
    git-merge: move space to between strings
    
    GitHub Actions show things like:
    
     * branch                  master     -> FETCH_HEAD
     (nothing to squash)Already up to date.
    
    
    The expected results are:
    
     * branch                  master     -> FETCH_HEAD
    (nothing to squash) Already up to date.
    
    
    This commit should change that. Other than breaking all the
    localizations, and anyone who actively parses the output, this shouldn't
    have much impact.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-934%2Fjsoref%2Fnothing-to-squash-already-up-to-date-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-934/jsoref/nothing-to-squash-already-up-to-date-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/934

 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 062e91144125..0d8c782cccb2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -383,7 +383,7 @@ static void restore_state(const struct object_id *head,
 static void finish_up_to_date(const char *msg)
 {
 	if (verbosity >= 0)
-		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
+		printf("%s%s\n", squash ? _("(nothing to squash) ") : "", msg);
 	remove_merge_branch_state(the_repository);
 }
 

base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
-- 
gitgitgadget
