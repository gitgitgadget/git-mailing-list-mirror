Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638AEC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhLTOdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhLTOdA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:33:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CFC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:32:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so20492169wrd.9
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=RCQ+Uotd3aop8KKADqmz/XqtDiLDnNxjbGGwpEDxL0U=;
        b=P/xjVlmgj9e9ENxW/krHXKdgMRClKsM/aGIdV3eFKXjpQKs6EYjqYgAKua8oI4tNlL
         5InF1IozchdPtT3eHBzWVPrqn42lNCpfHthqTAksJPv57YOdVbCbnz5MzAnrX1kwY9gi
         KsBmW2zKuGSR6ctjDO2a4bKkWBG8OW05AuEjhM+PsAA1kynjRSr5QsS/fb5o9blGyww1
         NGDVLGZd2DSgByXJblY5wWU7HC9EFLLLicbj+jnOw47yAttBL4wQp5JwhRUgiAMe+YRf
         Uz8PP5tHREN+AQKT7C3e0yXcB0I5Wi7sOKNOffLDWXndmFVanXKFrUqd0iMkJUWYZ8wt
         Uamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=RCQ+Uotd3aop8KKADqmz/XqtDiLDnNxjbGGwpEDxL0U=;
        b=XDfTBK7jMRUd/92Cy+LtDpu3t9kiteGAkVdUAlmI5EE+JRtREqhbB1bDWCNzRoHzBR
         +EgQ0o/Lh2bFL0TGOW0BqucJurHsU/56vIeXLwygHCaDnMSHESZcpi16uZRoOSxk93HG
         2qucyu69ghXX6E5WrCNxM6xh0xF6gRlXQJ3iUeVH4FO6zp3iWGXE3UaxLhFquplEyGHV
         hGNMXsBYcFlfakxe4Bt7JLQx3bninrz5Dn10w+xMjxS5cX8U4rstk0Cdf7sg6ZMjLgYN
         9a4XugTWf1dB4MGqHRv1FeNaC7fPBMoUOowLgR7I/p7HvQzPV90QmOO9c6xuGtmKAO2u
         MSAQ==
X-Gm-Message-State: AOAM5312+MTgRhBhM3Ckby5Yg1CSbypkxz9PjlaAvZ4HDX4FXkQSGa0S
        Z8whWMCsbVcfZiifwEwOWgJNtpCICTc=
X-Google-Smtp-Source: ABdhPJz0Lwa0lkdljz9vMUCYEfa9K4JAoMRpUSQ/G209ErNVUctr+X61/IWs8J/w8Wetw0Zd8X/t2w==
X-Received: by 2002:adf:c751:: with SMTP id b17mr13030003wrh.560.1640010778351;
        Mon, 20 Dec 2021 06:32:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm9295095wmq.27.2021.12.20.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:32:57 -0800 (PST)
Message-Id: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 14:32:55 +0000
Subject: [PATCH 0/2] builtin add -p: fix hunk splitting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a small regression in the hunk splitting of the builtin version compared
to the perl version. Thanks to Szeder for the easy to follow bug report.

Phillip Wood (2):
  t3701: clean up hunk splitting tests
  builtin add -p: fix hunk splitting

 add-patch.c                |  7 ++++++
 t/t3701-add-interactive.sh | 48 ++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 5 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1100%2Fphillipwood%2Fwip%2Fadd-p-fix-hunk-splitting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1100/phillipwood/wip/add-p-fix-hunk-splitting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1100
-- 
gitgitgadget
