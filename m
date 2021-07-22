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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4679C63797
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EF3613AA
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhGVMOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhGVMOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF738C0613D3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 14-20020a05600c028eb0290228f19cb433so1522280wmk.0
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BaTcA4Pw6YAbdti/IFIkJuLoqPKanlTk+2jSFeMI9DI=;
        b=fm6qUTylfi5O15ElPoZAbcGLEFnI8B9p1NDJFppimD/7WOm9GobNQedv26s02VSCk0
         yJjbCpsOxVVB7YBsJUsFUeQYdr6+M+k1uac0V/k0t9UZsx3zmBdfkBeeefsOQFWgvsLL
         iXgpVmTVsl5b7mEblvAZJgxRQ5+qA+VR08oeVejF/MR+bpApzLeYadL0dmmcUMxLmQ2W
         uMKT1o2XhPORcnilpRgSkaEqVPcLSVhQBQv/1EnWSHe54ivVjtqCfhY0amFwNoxIyFgf
         J++bsZ0Gctvor1Ep76heKh46/R3PNUWj1r4m3cwj1fmn/qSPUnkV+iDWmCdL8Vx34PMe
         gX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BaTcA4Pw6YAbdti/IFIkJuLoqPKanlTk+2jSFeMI9DI=;
        b=j8K3bNymRnyfAdOnqHMexkeh6rREWDQWu4Ao6ulf9SabJ9OI+7oXnrXN+hTgDqi7nr
         Az98ufIW6SidJmzyNXn++WFDgA3YvTkujiCbDmMZV3U1cxdYUmdSe71n1iVTMH8IZYYn
         aTJw6vqazFKAZRW/TEHboaiSZemJR2mbRTC8lErkQxXnJcxqDCfOq1C9apJ+2M944hEB
         /dxcdrXMiZ40816tx+IzCN8YG7KjD7KDc5cTAkchqOCYmEsb0wrzxAyUg3L7xsNH+/S2
         h1Fa/d21eWEPVM+5Ndzv2TotJTdtftpjYwlPe6OnI8KsHde/6FTUmgiTrcyQzQAvh0Tq
         +0wg==
X-Gm-Message-State: AOAM532BOj2YdcOpQ4ObqqiZRNmVKFrSTC62mdTQjFax2eA9wB1W9PY/
        ZS38GYCe8mBLo7b/lZ0Hg1V5qsXUwD1akA==
X-Google-Smtp-Source: ABdhPJyX5PpVCP3BGHxAmk78v0Lsi5qG9VWX6N9dxlWQH1Ts3z3Q462N7UuIZ2y2m93BAWuKfGImxQ==
X-Received: by 2002:a7b:c193:: with SMTP id y19mr9207768wmi.86.1626958515164;
        Thu, 22 Jul 2021 05:55:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] pack-bitmap-write.c: add a missing stop_progress()
Date:   Thu, 22 Jul 2021 14:55:05 +0200
Message-Id: <patch-7.8-eb63b4ba6a-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
bitmap writing, 2013-12-21), we did not call stop_progress() if we
reached the early exit in this function. This will matter in a
subsequent commit where we BUG(...) out if this happens, and matters
now e.g. because we don't have a corresponding "region_end" for the
progress trace2 event.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pack-bitmap-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 88d9e696a5..6e110e41ea 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -550,6 +550,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
 			push_bitmapped_commit(indexed_commits[i]);
+		stop_progress(&writer.progress);
 		return;
 	}
 
-- 
2.32.0.957.gd9e39d72fe6

