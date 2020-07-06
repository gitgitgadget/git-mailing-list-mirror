Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B8C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0941A2070C
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfUSNvrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgGFR3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgGFR3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 13:29:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE9C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 10:29:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 22so40185172wmg.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ZHKgaZTZP20rZXS8wtjeMgBqH9P2XhfgsqRtSD7QUz8=;
        b=dfUSNvrw/sIztGUP1gpixWf2geNRH6Bqiy/jIplPFE6fs9km9kP5LZwAtAF246WWwK
         tXnGqpEJFu890/EnTJTcpbhEkXZcaVLw0cFbTHQ7Z0gVD9XGg93RFs+rgRZL3pe65R10
         5x9uqKPrXye3DhagxjYaGew0K1PYXM0sT8/wH1QE+vO5b3FJGtIAuxTKF58DLSLJbSET
         I4MHzo+LQcDvaGzdr4WsAKcIvl764v+yklUwiumhskMPSErdznunYLkbW24jWJE2e4LY
         aTvBYCD8ghLTsObBQ2PSPi9ZB9nOLM47khIxCN9HhiFqaEC6xNl34YZtUBCDjvYEI47i
         fziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZHKgaZTZP20rZXS8wtjeMgBqH9P2XhfgsqRtSD7QUz8=;
        b=JDuiHnmYrSd57JMb5Ew8rmR390V1tCe+q3djAcUVPjsafFvXNOIDAtkLVBfl93FIeo
         7fivGbOhm1NkxxVSLb8Cg1FzHq0STaqKZMYxgmd4C97D8dZXlio1psWNRhI72VMXnPlB
         yMPKkZFg2xknru2liZv5MZAAt7mDf9Afd8ZQe24cE3MXv6gyINhdOnRi+Bk0fICBRTKj
         O4KJu9pALxZM8lCQALWPM9dZrSt9xSkFmAtQTc2Q4YOMHEDTbuTbcF4ssYLISNMXeqbG
         5mrq5YcAvXWSHNI9zt60PG8Qhs2oPR8spIeC1ErHscCCFCD1SS2Yom8e3XWgE+13lqtQ
         x1vQ==
X-Gm-Message-State: AOAM530VnSH6Eg+WmcbQrQ2doVsBf3xsPEG2mRTK9QCY0OvAQEIpYxPo
        SMBr+J9QTKfLULlxvp4T6de5GNIs
X-Google-Smtp-Source: ABdhPJzP3flR3lOWKI9ztsc+9/f+inTgDtLW9VEVl7FQsDXqO+eeDN8FYGk7nDKBHn02bR6i75ZaIA==
X-Received: by 2002:a1c:2d0c:: with SMTP id t12mr245795wmt.43.1594056574268;
        Mon, 06 Jul 2020 10:29:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm24781557wrm.93.2020.07.06.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:29:33 -0700 (PDT)
Message-Id: <pull.673.git.1594056572.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 17:29:30 +0000
Subject: [PATCH 0/2] Remove special casing for PSEUDOREF updates
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

This gets rid of the special casing code for pseudorefs in refs.c

This is in preparation for reftable.

Han-Wen Nienhuys (2):
  Modify pseudo refs through ref backend storage
  Make HEAD a PSEUDOREF rather than PER_WORKTREE.

 refs.c                | 127 ++++--------------------------------------
 refs/files-backend.c  |  11 ++--
 t/t1400-update-ref.sh |   6 +-
 3 files changed, 20 insertions(+), 124 deletions(-)


base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-673%2Fhanwen%2Fpseudoref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-673/hanwen/pseudoref-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/673
-- 
gitgitgadget
