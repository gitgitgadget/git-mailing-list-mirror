Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFEFEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 13:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjF2NXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2NXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 09:23:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0D2707
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so1062246e87.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688044993; x=1690636993;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xGhogLxfLYaVXWv2DBCj5Ddl6wx+xSwzlJkYxwXt59E=;
        b=BY497Y8L1LYsRvZcOIybZSG3CAnJge/o0J5MxRB6Cwu+S8jgBtou/namj4QvNKrCUi
         /xMaYXswSHQINVldnbkDLsAhKvOnW+E17HlOo7IrdUc189mnNNrKqGxzeP8+VbOJJcRD
         9l1GqGXbn1Y+XWE2fjnBgjD75mEx/Mpr6QLg8gtXUWceyfv48w4l8vwcpbvMp52Xz/UN
         2T2xCiHYkNjj4+zpLr4OALGOnbROkdvxq2xK+0jPZteoOW3o7nnYx/uwGmOZ59vOO8eU
         7rYDqWNmPceYKiWhtGC8vaG+IEwqWffj5wW9EMm9mjtliIMFb4kg+ypy70bvI2kuZalr
         bbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044993; x=1690636993;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGhogLxfLYaVXWv2DBCj5Ddl6wx+xSwzlJkYxwXt59E=;
        b=M8s2ASDQBxVvw2KyZf15V9kV1NGAWlcsrbmWtEWmpYQlFPgtJ/MJsoqIMKC2j8RIHp
         N16o9RSljZF8XRyscOhs60Piy4zntwK0nKtMp4l32yIW31Ib7OsGMzkWL3F3WNqp8upB
         OkCCcJ0kFlBJ5lTsMR94LwylRFhCGsmenLDHJkOLexYtkPTG1mmBTKBPugAIdJ9Bi6im
         AeCN9GXBZkQaToL5dHvMWX8iDBsOXHOe+Tvumxxx+OsMY19czR50aRZrT9FjC7eC2xmy
         7fMCBE0S/fBmiA+PDj5uLDm8jic6czfEn21EthVR3jVAGsq4hIw8JQwFclFHcah8kHSN
         5qjw==
X-Gm-Message-State: AC+VfDywYiK+iKIOfiHinHvEV79nD4Wa4GzA2wlY+CjYg5667Q/VoiAm
        pgQzO79CVOtR241PBYH8vxKtQlSFmhY=
X-Google-Smtp-Source: ACHHUZ4Khkh4NDgxDIU3iuy91eMkFixoWTbaYdCOHGiRGwf96h31wbRzMdZ8vFpxUxezUDH74ge8jg==
X-Received: by 2002:a05:6512:250b:b0:4f9:a542:91c with SMTP id be11-20020a056512250b00b004f9a542091cmr10133012lfb.3.1688044992374;
        Thu, 29 Jun 2023 06:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm7043824wmf.17.2023.06.29.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:23:12 -0700 (PDT)
Message-Id: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 13:23:07 +0000
Subject: [PATCH 0/3] commit -a -m: allow the top-level tree to become empty again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is in response to the bug report in
https://github.com/git-for-windows/git/issues/4462 that demonstrates that
git commit -a -m <msg> would no longer always stage all updates to tracked
files. The bug has been introduced in Git v2.40.0.

Johannes Schindelin (3):
  do_read_index(): always mark index as initialized unless erroring out
  split-index: accept that a base index can be empty
  commit -a -m: allow the top-level tree to become empty again

 builtin/commit.c      |  7 ++-----
 read-cache.c          | 15 +++++++++------
 t/t2200-add-update.sh | 11 +++++++++++
 3 files changed, 22 insertions(+), 11 deletions(-)


base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1554%2Fdscho%2Ffix-git-commit-a-m-when-tree-becomes-empty-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1554/dscho/fix-git-commit-a-m-when-tree-becomes-empty-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1554
-- 
gitgitgadget
