Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114C8C56201
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969B722256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PagmCO2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgKSPw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgKSPw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB60C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so7175906wmh.4
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tDzXpsm8eW6mloM68/FD0rXKP2odAu0Dxs8rPY1E8/g=;
        b=PagmCO2ZX7dI8oBrtjNBQcjt3NSoYAuR5DxVKwYn/2KhO/vOaVttiVoUq3jJcyil3s
         zVsLqrIPZBcId+kbuz+7msIjmlA/pJem1wI5A1XXPmeJ4NEQM+PP+5fF7X7kig/FuKSa
         MQRcK4ArFVyRgPDye9JZiyX9cZ8y1+vq6KNHhoMCBG9cDwL/4+mqgTu0sAvZAczZQQcR
         1/Dz2ppeKOMR0HwEgiazBMLeyJZR2jDXdyszxxs2zNDKTBAH3SktT+IpcI1pjqGFnZ4s
         RkAciozWT2a24QNBJMRLks7FFSSDZ5/jOtQoid9P0CqThoWyPjqH0j8j7YolNZRoEGen
         u52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tDzXpsm8eW6mloM68/FD0rXKP2odAu0Dxs8rPY1E8/g=;
        b=ebnqaXLs74RSRC9Y1MZZ/0Cr/hoSOG8lSIYr1Yesxz9d8uL9haI6BQOK1e5CETO+sW
         wgqEgwNVHwI3MU/kkS07AM6c+nxlONBQWNKlxOcs5+F96ukTVQSMoC4n28qOMQvbGfvF
         gymqe9zw49GSSj3MSkuh1xs/4g5P6p0w/AmcjRIN6ojLheeZa3IYgtDDDAEKIUHkXRsK
         X1LXr0s0AwcjOKeZJ5J7PehlUU5Ejf1F2I1THWmZjOOWGklWXVPdGh0wkeuzb+OR1aHI
         ITjRRfc03ssh1gGLRBpaE7ek+qdR5cHw9G1m9d5zRetFga/7b0VnZhjQnbG01xjjnPFZ
         IWFQ==
X-Gm-Message-State: AOAM533zR3oB2D8uQCx9rJfFZ34ToxW+JEAClzpnpwE63PNAFkIjP9cy
        ecTAz1KYVy5Yz4S8DS+bDXZh52Tg2o8=
X-Google-Smtp-Source: ABdhPJwF0gVEdVCIf/gCMjBw49i6gRgGCNgJuQ054CPaTvEfsRUvbqxfkHxj1jwnZZStu3sRPwHYUQ==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr5125955wme.173.1605801144324;
        Thu, 19 Nov 2020 07:52:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm168691wro.85.2020.11.19.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:23 -0800 (PST)
Message-Id: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:16 +0000
Subject: [PATCH 0/7] config: add --literal-value option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported [1], 'git maintenance unregister' fails when a repository is
located in a directory with regex glob characters.

[1] 
https://lore.kernel.org/git/2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com/T/#mb96fa4187a0d6aeda097cd95804a8aafc0273022

The discussed solution was to modify 'git config' to specify that the
'value_regex' argument should be treated as an exact string match. This is
the primary change in this series, with an additional patch at the end to
make 'git maintenance [un]register' use this option, when necessary.

Thanks, -Stolee

Derrick Stolee (7):
  t1300: test "set all" mode with value_regex
  t1300: add test for --replace-all with value_regex
  config: convert multi_replace to flags
  config: add --literal-value option, un-implemented
  config: plumb --literal-value into config API
  config: implement --literal-value with --get*
  maintenance: use 'git config --literal-value'

 Documentation/git-config.txt |  20 ++++--
 builtin/branch.c             |   4 +-
 builtin/config.c             |  50 ++++++++++---
 builtin/gc.c                 |   5 +-
 builtin/remote.c             |   8 ++-
 config.c                     |  29 ++++----
 config.h                     |  24 +++++--
 t/t1300-config.sh            | 136 +++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh       |  12 ++++
 9 files changed, 248 insertions(+), 40 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-796%2Fderrickstolee%2Fmaintenance%2Fconfig-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-796/derrickstolee/maintenance/config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/796
-- 
gitgitgadget
