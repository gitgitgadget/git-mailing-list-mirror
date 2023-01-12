Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3127C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbjALP1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjALP0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0033DBDC
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:18 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk9so45592924ejc.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/6mhAFgT+R6RRQRyBR+fuFU9MX8tMqfcg5M3QFaPl4=;
        b=oeXDbJRfPoEU4ReVzjQa/B9TS+SmRw4LwU6uckwPupRsOyW7RZNQb8hC9pqiHQvBIR
         gnPYZRs+rNOI7pVI7wgQnevlza7Qtz1wR9zk8PAKBeHv+qhKkwJ2we/tmdCzp+ZFD+WI
         IX1t0VyQKN/d18IFBF0HGyYRKltpYekvGLBETQ+cZo0WXOg1XxzQ2FWBRZT+Gsg/zmRR
         99ioAy9MNggEDkfMC1b9icy6brApw3nhW15TAy33dYwTLPpuycXtzV/H3AmI1p9oeLek
         A20x5cwnyaZXfZMo3DwTyntOCUuwQH+T9Sy93rY2t2+nXWU/HLZc1YUktsZA7XIYwlsO
         svUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/6mhAFgT+R6RRQRyBR+fuFU9MX8tMqfcg5M3QFaPl4=;
        b=Y9EGZgcxRlaP0a4ah+v5BJ+zHgjkAW2PTmeNFUWC6TvIhYqdKSG1WlEPIWJUt1g1Pc
         29l8eCf/mMui+4AV4MViOugteFTexzwGYKy+TpjGccWcjkPNFNMSbio0QNi6f7rXvuPP
         aBkAtSS71Sk1H4c4yzDvWn1HB/mA2g50NbLmmTHCAftiGwd6K1dhrpGuIF2xpDH8vSaU
         O++dPnBOYIw7FedDN8iSXRnU9mS4RZRkmAf5+b/OUUAExiQ3KtHriYh/VFDMyU0byt57
         AMocUBDWjBX5xHY62QbTxZkdKIcGf3dMngH41xoqg6veLtiFKESWGL03qWiCiq5n9qeU
         XkiA==
X-Gm-Message-State: AFqh2kr1qWhbIZgx7UPlJbvjPvPKKq/crd99banjmRDXFOR/dXZ+T6jx
        eCWggPKGO//h8bX49o8ISXpcE1zXFppTIQ==
X-Google-Smtp-Source: AMrXdXt0cyyUQDwUWoKuo4yUPjcWCZW0Bs1x07Lr0q9rSwsVGXSF3sZqH30gpVeyvofC3lgl/8zWZQ==
X-Received: by 2002:a17:907:674e:b0:7c1:92b2:fa9e with SMTP id qm14-20020a170907674e00b007c192b2fa9emr68929914ejc.59.1673536756484;
        Thu, 12 Jan 2023 07:19:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b0084d44553af9sm5493291ejc.215.2023.01.12.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:19:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] bisect: follow-up fixes from js/bisect-in-c
Date:   Thu, 12 Jan 2023 16:19:08 +0100
Message-Id: <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1215.g1ba3f685d4f
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial update to this topic of follow-up fixes to "bisect", which
is now a built-in. See
https://lore.kernel.org/git/cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com/
for the v1 & general summary.

Change since v1:

 * Rephrased & updated a commit message which was outdated as of
   f37d0bdd42d, see the range-diff. Thanks to Đoàn Trần Công Danh for
   spotting it.

Johannes Schindelin (5):
  bisect--helper: simplify exit code computation
  bisect: verify that a bogus option won't try to start a bisection
  bisect run: fix the error message
  bisect: remove Cogito-related code
  bisect: no longer try to clean up left-over `.git/head-name` files

Ævar Arnfjörð Bjarmason (1):
  bisect--helper: make the order consistently `argc, argv`

 bisect.c                    |  3 ---
 builtin/bisect.c            | 52 ++++++++++++++-----------------------
 t/t6030-bisect-porcelain.sh | 21 ++++++++++++++-
 3 files changed, 40 insertions(+), 36 deletions(-)

Range-diff against v1:
1:  c8c648e4b8c = 1:  32c45bbf851 bisect--helper: simplify exit code computation
2:  a0de7ad6836 = 2:  1f4449dd081 bisect--helper: make the order consistently `argc, argv`
3:  e1e31278fef = 3:  0cfb7dc572c bisect: verify that a bogus option won't try to start a bisection
4:  59a8a3085b1 ! 4:  4dda1019767 bisect run: fix the error message
    @@ Commit message
     
         However, the error message was supposed to print out whether the state
         was "good" or "bad", but used a bogus (because non-populated) `args`
    -    variable for it. This was fixed in 80c2e9657f2 (bisect--helper: report
    -    actual bisect_state() argument on error, 2022-01-18), but the error
    -    message still talks about `bisect--helper`, which is an implementation
    -    detail that should not concern end users.
    +    variable for it. This was fixed in [1], but as of [2] (when
    +    `bisect--helper` was changed to the present `bisect-state') the error
    +    message still talks about implementation details that should not
    +    concern end users.
     
         Fix that, and add a regression test to ensure that the intended form of
         the error message.
     
    +    1. 80c2e9657f2 (bisect--helper: report actual bisect_state() argument
    +       on error, 2022-01-18
    +    2. f37d0bdd42d (bisect: fix output regressions in v2.30.0, 2022-11-10)
    +
         Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
5:  1b70cd79cae = 5:  1600ef41608 bisect: remove Cogito-related code
6:  2ad89aca728 = 6:  817fe726b4b bisect: no longer try to clean up left-over `.git/head-name` files
-- 
2.39.0.1215.g1ba3f685d4f

