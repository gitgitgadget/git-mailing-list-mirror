Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC1C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiBPKyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:54:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiBPKyr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:54:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CD329E97C
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so2748946wrg.11
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1vyQHQlf/ttqcNeXK3gNuBHXMRyO2PeI0MGpp/ipsFU=;
        b=J8TzJXI9VRmdycabLrIkeWxru0VlL+Yc53lgpJD55gBvn9dgmgDTAK2bJ4kMdPN20s
         ZgzfrQ8UuOPf39YGRY++mUe8sC/mJsh873FfaamD50ZDQH64e3Oyleqh0JqXN3StCt64
         Am6MJ2IMhjddepwI9ZCbpzODFRJxQUUG1aEXz/r0rLsAwRcZr8NJzITbRsvQMk1pys4G
         xMzbVFE/HO/8+uST+3jRzZRqvF8VsJdNX3R4HUEmD+on/yvFdJWmYuAGMj+ONN6AteNB
         E2yWiwguIEkz0MnE4mUs9SJ9IOdGuebgc++Uh5fempJQ884R1kEdg3beh3zOsxcybAUV
         I5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1vyQHQlf/ttqcNeXK3gNuBHXMRyO2PeI0MGpp/ipsFU=;
        b=A4ixzysKzJGHNzlh/52rREFnml8Mk3MtOT5/o48zNTJjfZeEGMlWsPlvwtWY5jSPEC
         UljJwaKXgsgQlTWCsVc30xtItqNOVz3SBUNcy4VKGShoChg/GiLGv+hE5wWVT71r3dLY
         5hOWU8a7AY6l4xGgZM0grFutSn9WkCpI852bNhqMIaaEu1tswPVeFaJ4kX+wzJri+l+6
         QHSASD32Uz/5iPtC7/lQYD1viqNy0VjkxlAlYRILQ8Z1vvpqhYX4xBLEsJ6aRsi8IxUP
         Qni6z3L6/88/cST2N2wvMXG4OD/cuDxa4wR2IQBFQ8DR5UWP3kdxnf4kLapky2dOyh2p
         zsVw==
X-Gm-Message-State: AOAM530GK8RANnmZeH+ofSqzzNLW+XQ7PQXmQIOzR3xEyfHj60VNWVz5
        wKhoCc0435qDZgsrNmWSrRo0CUEcovM=
X-Google-Smtp-Source: ABdhPJxARbSisrx/ZdxdFHl8hfrzq4ylyFjCoJnchgLnId1reuQb8GeVVx3OfQmCqU55Vr4qaeU7wg==
X-Received: by 2002:a5d:64c3:0:b0:1e5:94d3:5bf2 with SMTP id f3-20020a5d64c3000000b001e594d35bf2mr1872055wri.488.1645008874057;
        Wed, 16 Feb 2022 02:54:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm26269482wrt.28.2022.02.16.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:54:33 -0800 (PST)
Message-Id: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:54:29 +0000
Subject: [PATCH 0/3] a couple of read_key_without_echo() fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a couple of bugs I noticed when using the builtin "add -p" with
interactive.singlekey=true. The first patch is a general fix for the
terminal save/restore functionality which forgot to call sigchain_pop() when
it restored the terminal. The last two fix reading single keys in
non-canonical mode by making sure we wait for an initial key press and only
read one byte at a time from the underlying file descriptor.

Note that these are untested on windows beyond our CI compiling them

Phillip Wood (3):
  terminal: pop signal handler when terminal is restored
  terminal: set VMIN and VTIME in non-canonical mode
  add -p: disable stdin buffering when interactive.singlekey is set

 add-interactive.c |  2 ++
 compat/terminal.c | 27 ++++++++++++++++++++++-----
 compat/terminal.h |  8 ++++++++
 3 files changed, 32 insertions(+), 5 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1146%2Fphillipwood%2Fwip%2Fadd-p-vmin-v2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1146/phillipwood/wip/add-p-vmin-v2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1146
-- 
gitgitgadget
