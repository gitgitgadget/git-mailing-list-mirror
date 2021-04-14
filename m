Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28EBC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CA461220
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352796AbhDNTPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352685AbhDNTPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 15:15:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5839C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:14:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so33080445ejo.13
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRoGWrwm9/ZVHvC7zfd59LF2xsBEL7JKlp8CVTrhR14=;
        b=qmseWrR3FKMP8kF5WTDRUzjMkikWinqZv8SuBaZNxkRc8h/e/9sYnImTUBvKpmNKzW
         gMtGngxjl+pnNIJUIzdX/W0UE2j3gddsoJc9rcR2lHh8isqc/aT1P/QWXXZ+SmraW6wa
         ngE11KVYjY3y4Oen/mu8z4QHwaBg4DEardmssDqJGhYK4xGIyPdWF04bnbUQQ/O7fjeG
         hFdKIKlqw9qNDLm4Ko17eOt2UBWVhdUpUWQKhi/f7D4VzM2crtlPg8Fp/ZqhBv+siu72
         SU43fu1Ihf+rOJ/CyGXPpnVYwTeKRK3KvXssJsjLwL1ntUlgQyWjjfwK28TNQIocDazN
         fauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRoGWrwm9/ZVHvC7zfd59LF2xsBEL7JKlp8CVTrhR14=;
        b=o4HnikbGhX4xEMso/pZN7sGFSE7F4t7wgkLP34Hi0HH84YyTcNB84DwEHrbYWOXht4
         ZD5AaSXdvB/2owPE3RgxVvY3lXwURqtwgYiG/4wsVm1stYqOg93pTerHL2mpsKZfdGCi
         MNd2tWAtJfATENR4PuEqk5ND4f8TTp1+xrlcj95FPGCSfPzowXAwkzAWSCUb0L6FAuGU
         N9/LQvCbXXpcAGLxsEdwan4/U4U5yI7jGuOtZUkd3oFhmWAdqF1NkX6QQQpwCJQt2P+6
         0E6jDz9H7U9Lq8ClqW4LjmPNKNwmpFJgnr1f/woxl6qkxt5jj0M2cION7gi+eGg4vxyw
         7E1g==
X-Gm-Message-State: AOAM532ZY1yM4C2QEn6AKSwd9+DgsYJ3D/ARAD6HPWzVTl6uznTCb1F/
        7IzhhagZN8BIlgBe/y73UT59tTbZG4nZrUQH
X-Google-Smtp-Source: ABdhPJwDvN7VVsi1zIFqk4uVSWwzSyHC7+pLyLCXcXNOiADumroz6tXHDCO3yCnIxZ7/bp930SOpRA==
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr374153eje.247.1618427698274;
        Wed, 14 Apr 2021 12:14:58 -0700 (PDT)
Received: from localhost.localdomain ([212.86.35.110])
        by smtp.gmail.com with ESMTPSA id cq26sm363547edb.60.2021.04.14.12.14.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 12:14:57 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 0/2] prevent `repack` to unpack and delete promisor objects
Date:   Wed, 14 Apr 2021 21:14:01 +0200
Message-Id: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.31.0.565.gcc42f43761
In-Reply-To: <20210403090412.GH2271@szeder.dev>
References: <20210403090412.GH2271@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is built on top of jk/promisor-optim. It conflicts with
changes on p5600 otherwise.

The following patches fixes the issue where we unnecessarily turn loose
all the promisor objects and deletes them right after when running
`repack -A -d ..` (via `git gc) for a partial repository. 

Special thanks to Peff, for proposing a better approach for managing
the situation and for Jonathan Tan for earlier interaction on the
solution. Previously, I thought we should skip the promisor objects
by just adding a check in loosened_object_can_be_discarded(). However,
Peff pointed out that we can do better by realizing much sooner that
we should not even consider loosening the objects for the _old_ promisor
packs.

It took me a bit to come up with the test because it seems `repack`
doesn't offer an option to skip the "deletion of unpacked objects",
so this series adds a new option to `repack` for skip the
`git prune-packed` execution thus allowing us to easily inspect the
unpacked objects before they are removed and simplification of our
test suite. Furthermore, The test will now test the `repack` code
path instead of performing the operations by calling
`pack-objects`.

Rafael Silva (2):
  repack: teach --no-prune-packed to skip `git prune-packed`
  repack: avoid loosening promisor pack objects in partial clones

 Documentation/git-repack.txt  |  5 +++++
 builtin/repack.c              | 15 ++++++++++++---
 t/perf/p5600-partial-clone.sh |  4 ++++
 t/t5616-partial-clone.sh      |  9 +++++++++
 t/t7700-repack.sh             | 23 +++++++++++------------
 5 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.31.0.565.gcc42f43761

