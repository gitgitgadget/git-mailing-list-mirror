Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE9C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiI3SIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiI3SIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686831E555E
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f11so5349082wrm.6
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iy7dR8/Abr3dhe7BRag2bClwykGSjjDANdsGXG+aadI=;
        b=po7xcakNDOzAhmnllfiG2ZKKzAcphWwg6vRuj+9Z2qFsZgBuuwlfUYT0zHvAtqPwmq
         tqXrR/w8YiMFA1RN2k0mj33DhU07V75d9LQPD8AFRvnEKsNcYVe7Ub1EVRvmH4l4yi9/
         a0oX5FDCJAr+4D+XkKlM9B/wKHS4eT2aFcZ8/MJTDYoXeHlve60gU8RbWfDx5DmYjZP1
         w1F4Ym5lhwR3jUtSasDytiQcDcST5DR289EGs7ZKTGCIjGZLHTvMtdC3/ygUYUVJTZPS
         lAOJ5FIy6nqKN5a2OhUo5MnC13LO3NWDTcMEUcYV2UsUqLApsfIhni0anakgJv4VzEWo
         qGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iy7dR8/Abr3dhe7BRag2bClwykGSjjDANdsGXG+aadI=;
        b=6O3XJFjivARtVF1vcUnE70JnEw7Gz99Y2iPtxwcdEAKZ+81+nugN5GeDQ2bygNDSBo
         U0LlaI7j+3H88jPI+VEPqs1hFQIGSXRTYSpQwxd5Mu2dUjrEhqILyQZp8k5px+asCGWL
         2Zvb76TyFAvpYIJ7TN+Nm1eq8URrqD/3hPKupoaw2YpAaW7f1d9LTIVE+MR4psz+dNzv
         fUUcrZJUUpFrzWJ8i7aLW+X6Og71hlO/EW+1M3fC/PJfcPMD6SQlqHn5i2NZ0v842bEN
         FICYVmGHif88KMzUMacD06qFIoWhbvI93juIC8YjhKtGtzddeazcC6nd0VobMbn2Z99N
         2JFQ==
X-Gm-Message-State: ACrzQf2d3tO/tYSLpVRboh2zfw5I/pgW3EyL9KFNFrXQJa+8NI1Tbbwf
        oBh0YuYsccx3kS5GcD8tYFWZDa25C7gIvQ==
X-Google-Smtp-Source: AMsMyM6EDcsP0Xzzc5OxmAUSZfuYPXrtqHXkSY+RdcCtx4QjXT4PzfU3Q/Sl80bvd7MuRkpAKnc9nA==
X-Received: by 2002:a05:6000:1cc:b0:22a:e8c6:9f57 with SMTP id t12-20020a05600001cc00b0022ae8c69f57mr6353664wrx.527.1664561309389;
        Fri, 30 Sep 2022 11:08:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/36] doc SYNOPSIS: consistently use ' for commands
Date:   Fri, 30 Sep 2022 20:07:29 +0200
Message-Id: <patch-v3-06.36-b0ae035500c-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our commands use ''-quotation only for the name of the command
itself, and not its (optional) arguments. Let's do the same for these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-export.txt     | 2 +-
 Documentation/git-sparse-checkout.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6ad..4643ddbe68f 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -9,7 +9,7 @@ git-fast-export - Git data exporter
 SYNOPSIS
 --------
 [verse]
-'git fast-export [<options>]' | 'git fast-import'
+'git fast-export' [<options>] | 'git fast-import'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 3776705bf53..872436d7426 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [<options>]'
+'git sparse-checkout' <subcommand> [<options>]
 
 
 DESCRIPTION
-- 
2.38.0.rc2.935.g6b421ae1592

