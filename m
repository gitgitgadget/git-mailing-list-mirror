Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3879BC11F69
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDBD61DE3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhF2TGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhF2TGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:06:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD8C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i8so491419wrc.0
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spwsbNPxOc1mX6MyV+q029gV39EI5LrG7BaJly2wTxM=;
        b=lqcQnEBVhbKMPfzMt+M+7cXXdPCtIq/5RYZXGv3yDEONM4im/njrzLX22rTakPAMEB
         wbP1Fb21BSPQWyU/IWuARsItDssAb+giOKEjwqOKsd54V/lHcA8Zule84UTmrrHweKUx
         nkEYdwqRHLJ9QLWsTNKZall7BuA2xyECNArrla60g/+MHWpSX8QDpu4awpe2N6jIK5PI
         IMFo77owJ/dBECRV+2qHLHYYKcQUhkRQiA462Rzdwoh/dwRWKbydevmRL++ReK4ptYsm
         fT3yueA288Bu6N2iVhd3yOwM1WqYpQ7UWU5jxNBn03K5bQv0Q7fp/geFTjQYEGcAH/hS
         NEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spwsbNPxOc1mX6MyV+q029gV39EI5LrG7BaJly2wTxM=;
        b=M8saaaF8JBasZPjCNE0G7blwNMRGwV5PIODZWk3y/t6lS+xvjRQWN3pFZ2gxv0nQUf
         x4uErXPM7dnt1XOjJTYG6Cl2efFpBCJogQrQmyIyuE/QGNxTPNBfANHH65fxXA5GGYwV
         Lgmwly2++2v6RfSG9L/WiUcnST76W285jzlFoR2QJqymc0mo8etlxnT7Ivk65OM38Qm8
         5KfUnKq/ohWuG/mVbeuTlnywOeSO0NQa9EJXPUxDqaBFavQe9YdTbhcgHL+otC7foSrz
         NZCKCly7n8KyKJyplQnBlQP6uL/eXmoG0Hg+JcV5tLLh+GAIpUSH8EQTFuQJmJmTvXfw
         32/Q==
X-Gm-Message-State: AOAM530+mwLbg0FKB9P/AWe14CUS/SIVaRgQ9tadFm/PsHdoNuA3GMzH
        lH2EkL/3jfU2+v/r5hRhY2JlwjTuNshZjg==
X-Google-Smtp-Source: ABdhPJxUOWWXja05ReWyzepYXYM0/smeNIjcPZXdc1q5PcWJ3PwWG5zYcGLMy6UxhyNBPFzGmP99/g==
X-Received: by 2002:a05:6000:1a87:: with SMTP id f7mr34858913wry.172.1624993418508;
        Tue, 29 Jun 2021 12:03:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm17641188wmb.35.2021.06.29.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:03:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] Makefile: remove an out-of-date comment
Date:   Tue, 29 Jun 2021 21:03:33 +0200
Message-Id: <patch-3.3-44a4781218-20210629T190137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.615.g90fb4d7369
In-Reply-To: <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com> <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comment added in dfea575017 (Makefile: lazily compute header
dependencies, 2010-01-26) has been out of date since
92b88eba9f (Makefile: use `git ls-files` to list header files, if
possible, 2019-03-04), when we did exactly what it tells us not to do
and added $(GENERATED_H) to $(OBJECTS) dependencies.

The rest of it was also somewhere between inaccurate and outdated,
since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
it's not followed by a list of header files, that got moved earlier in
the file into LIB_H in 60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H
into LIB_H, 2012-07-06).

Let's just remove it entirely, to the extent that we have anything
useful to say here the comment on the
"USE_COMPUTED_HEADER_DEPENDENCIES" variable a few lines above this
change does the job for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Makefile b/Makefile
index 66f5ded3a4..14996b6840 100644
--- a/Makefile
+++ b/Makefile
@@ -2503,13 +2503,6 @@ ifneq ($(dep_files_present),)
 include $(dep_files_present)
 endif
 else
-# Dependencies on header files, for platforms that do not support
-# the gcc -MMD option.
-#
-# Dependencies on automatically generated headers such as command-list.h
-# should _not_ be included here, since they are necessary even when
-# building an object for the first time.
-
 $(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
 
-- 
2.32.0.615.g90fb4d7369

