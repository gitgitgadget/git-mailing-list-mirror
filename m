Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A573C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757ED61076
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhFPOSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhFPOSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B7C06175F
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o3so2890586wri.8
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0+Ozy8A7/LqyW+J43emN0lVACvMfxiXS1kifAC1q/4=;
        b=SfXtX/gasCzvEHU4nqBshGklDh0NVjUNIKKsqUdZERW2DcvdY97imE/+40FE2VM1IB
         oPuX+lnyInmQHoMimS5cAL/23XoAYxfcKE5l8FTl6gwlLqJtLdw5kmJ43HDUPn4uLTJe
         Kb3RFa6RTbS//g5LjJaJK2L/7X5RdWjTk4/7z8+n8BBGdZCZge60h7hayBS2bLluSzB9
         pSSPcWoVZ2B734KhHJht1UircfQgzJwymgbHsK4wfa6J3lxkj/BD6QTlL5BM7OjKJu4Y
         EpGlO3YVE32wWSWNxO5RyKr6piJq7fcjZfQg54jTMXmFuoe0GeaqbazL6rJV6yFPCkzU
         NwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0+Ozy8A7/LqyW+J43emN0lVACvMfxiXS1kifAC1q/4=;
        b=jFNndQF9XJ6MchaSj4oRfSzsF/F0RBfoXfVmYUg+Xn79zLqSM1pRt2b0WzDcuHbtdh
         NJVqGWYJvw4Vj+tZGbLjmnLIQhr7F/L87E8wM9sP4Z0dR33auookoeNj+grMv80hkQmw
         MLi7ln839Nz/sMwzjsPUuMtDL+z2BISGhUi6fcwGJCR2DJY/I4NhWRxcjqQRE2pQS5Uh
         PTTnRiYvt9wHreiMo0j6tU9/aRY8fFtPhSk6/29gXPT1UyCwQvJsIb9s1TnMeM/ujDP1
         N6UdaN6AtnKA3kFc2WzxvEa5EtFadfS9IPl5K4xJODEgCj72Kx3ZCcP8RQi8lKaMyFdq
         /OTw==
X-Gm-Message-State: AOAM533fUZmT1uJvfnL4FgUqjvSHlkPHZ1zj+YUuO0sJ/orWqCldK9Y9
        rjndEDdsdfuyxQdyzpTSmtZBJ/G+WtU9uQ==
X-Google-Smtp-Source: ABdhPJz0IcSEcibdGs3KrsJQ+pcZOII/NRZJTjSo6yJPOrvJw646YoIWfC/LsQIz8btYs+ugTpDBug==
X-Received: by 2002:a5d:4e12:: with SMTP id p18mr5959093wrt.105.1623852989426;
        Wed, 16 Jun 2021 07:16:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm2258555wrv.37.2021.06.16.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:16:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] serve: add "configure" callback
Date:   Wed, 16 Jun 2021 16:16:16 +0200
Message-Id: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a refactoring of what a callback in serve.c needs to do to
aquire config. Currently two of them want that, and grab it in ad-hoc
ways themselves, now they can insted configure a "configure" callback
along with the existing "advertise" and "command", by the time they're
called their config will already be read with their callback.

I split this prep work off from an upcoming series where I wanted to
add a new capability, but I think this stands nicely on its own, and
simplifies the existing code.

The line count increase is mostly converting things to designated
initializers.

Ævar Arnfjörð Bjarmason (5):
  serve: mark has_capability() as static
  transport: rename "fetch" in transport_vtable to "fetch_refs"
  transport: use designated initializers
  serve: use designated initializers
  serve: add support for a git_config() callback

 ls-refs.c            | 55 +++++++++++---------------------
 ls-refs.h            |  1 +
 serve.c              | 76 ++++++++++++++++++++++++++++++++++++++------
 serve.h              |  3 --
 transport-helper.c   | 18 +++++------
 transport-internal.h |  2 +-
 transport.c          | 32 ++++++++-----------
 7 files changed, 108 insertions(+), 79 deletions(-)

-- 
2.32.0.576.g59759b6ca7d

