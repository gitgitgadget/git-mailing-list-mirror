Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE9BC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKUDA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiKUDA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:00:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819EB2F65A
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s5so712024wru.1
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qip8725Xdyy/G9SgFq3JHKJcKd8iVtuwo7qpVj5e2y8=;
        b=oDyQpFvOVRV38N6pDMKL5ipMt/sgNB9E11cOHyswyn7Dve2LFscd4hvwNuD99HEUiI
         18wh1+KK9K0/Ergd7xsjHb+E4Eqbb/jvCcDuQ11dP0WYUqbOzByG2053SpHAWzEoUxbX
         eI0teNjj4bbtr2EnuqyAgJjAAUvBqaCZKPB4czKON+yUuUMAICwlRkCs8iJk1okgoAXm
         UvEWI8I4pgtl6nGE7BkTcXff+ntqP25YDydjmgcosUtXejJK9SbdZ9X/x3jGYkR4byjS
         5RFDjrb+aB5t6hs0ZeFOF7kcX/LQn5lJirTBUaMsDrb7rq9bUyn5uCPlNVREx6a1xjXE
         uPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qip8725Xdyy/G9SgFq3JHKJcKd8iVtuwo7qpVj5e2y8=;
        b=TOw9KwDb9Kc+ZaGxWX/SS+cV2dK42mHo3CNOTwAFV2gwgWkVmqJKswO6+C799awvHA
         58qV/f7F5o0g33jJYitlxFzJplGmd7FccMyGLOhVWKvCe/9Cgm4dC5HIe1Si78MmRANU
         jV/+wEoF+igBe1GZ07GzPwlafpXuV8v/r9P8UZKddHWzLq5+TfKb3dA2lYiNvNV0O4IC
         DmsUu5fgnopUk/3i7UsIGcKDLPDy0wkEDO0BXv34lZyucRJjgYTFs+8rPQnWyZjrA/oZ
         jbirjxnXtCx9SwYk9PFHLi/1cj/IGYdKX/1moV2tgipg2kE94Eoat1DiDlri9zVxAS/J
         uitg==
X-Gm-Message-State: ANoB5pmIHnmZDY5F2qXgr53V+uCABlf0K1HXl16cd5cQIClV+b8t1SLz
        jfY+TFDhRnlLCuf+kp4oXT2fOf+qXvs=
X-Google-Smtp-Source: AA0mqf6SWFInD0VFEmOHMzKpEmmsJ+0jAUK/8tPCYRilUg7crYaNLdGjkBz8bkjd3KupuGPfibG+RA==
X-Received: by 2002:a5d:5411:0:b0:22f:f92d:1236 with SMTP id g17-20020a5d5411000000b0022ff92d1236mr9613889wrv.187.1668999622811;
        Sun, 20 Nov 2022 19:00:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d6543000000b002356c051b9csm9893433wrv.66.2022.11.20.19.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:00:22 -0800 (PST)
Message-Id: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 03:00:18 +0000
Subject: [PATCH 0/3] fix t1509-root-work-tree failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The t1509-root-work-tree script started failing earlier this year but went
unnoticed because the script is rarely run since it requires setting up a
chroot environment or a sacrificial virtual machine. This patch series fixes
the failure and makes it a bit easier to run the script repeatedly without
it tripping over itself.

Eric Sunshine (3):
  t1509: fix failing "root work tree" test due to owner-check
  t1509: make "setup" test more robust
  t1509: facilitate repeated script invocations

 t/t1509-root-work-tree.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: a0789512c5a4ae7da935cd2e419f253cb3cb4ce7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1425%2Fsunshineco%2Ft1509fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1425/sunshineco/t1509fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1425
-- 
gitgitgadget
