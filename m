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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7CC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA14761DD6
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhF2TGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbhF2TGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:06:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04BEC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a13so388466wrf.10
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h86g5wMKV21pRi//JQinRi4VBxZZdFTmHDlCszVeHG8=;
        b=dmYSVFLGfvQIDFSNJp5vxBjtb+WObISC0SLPyWK8API0THJ1PZDOzf7bX9PqcbtvVl
         YnWRDwGMBWBTD9CUQL/fGgP6z+DbmgvNQRZ4N20DjQIm3tgFNb095tdQOY9E+RfYL1Sk
         MgfnkMqsu29KHn4lmMKaMOjfw/Iz6u+L55DpUjbOZs4kMgT9TNbcyoNGkBxryNEp98+h
         wY+XeQ79F3KpEz7hCa9z+AdBgen3Vc+2m9SpofVLT2a2caCxK7JjPgb+fXvAJRBOSAyF
         hivhKz1y6NVECTo13s7T7ldDcViorDgG8BmKRynIfRPLagPSa3Ghj/gX9JX4jNoBRG6v
         QMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h86g5wMKV21pRi//JQinRi4VBxZZdFTmHDlCszVeHG8=;
        b=rkWgRO9LSm5F9JROlpIw/U/sV2oIay/0lArn7xCIfiZeKI3w0vjOO94ODQodROK/Mq
         pmaOvaFDYl0G5ZRfy33QS5+GrZh6kRh4nIN21g9V6B65dzLjG4zFdF8XkNiV5eACDQqO
         6WS2NNbslz6uIlxvu8O3GGJCHlbB3v9pbgSoieRpqM8J7WFI9QDqloQfOnGgK04HeKSM
         ulLxbiDOmMkWb/lCPgCfJOnR8oyA0TaPZ2KvzOSjeu5WRX4+1zN80eMezZ4xXLjryAVy
         vcTiHLTSxpC8Lcv1p2qnAqgIK6V0BvnuB0T5U1kERPFBti4O047RqFnLzYzXEcLWEid9
         sevg==
X-Gm-Message-State: AOAM532rGB20OUX9ldGSCARwq5bEjQEaziAm2I9QT4/f/HoLAHcyURKd
        Q9fCeIDEyDYIy7ikaeYxT5QTRIyZVl8OJQ==
X-Google-Smtp-Source: ABdhPJwh7Lwp00pRvcPYgbunSpTyo+g9E343xgFX+gEN9oZy1unS89kpwBZYbjiqxVNRdYCJb0R3og==
X-Received: by 2002:a05:6000:2a5:: with SMTP id l5mr36387099wry.338.1624993416276;
        Tue, 29 Jun 2021 12:03:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm17641188wmb.35.2021.06.29.12.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:03:35 -0700 (PDT)
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
Subject: [PATCH v2 1/3] Makefile: mark "check" target as .PHONY
Date:   Tue, 29 Jun 2021 21:03:31 +0200
Message-Id: <patch-1.3-27c94247f8-20210629T190137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.615.g90fb4d7369
In-Reply-To: <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com> <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in 44c9e8594e (Fix up header file dependencies and add
sparse checking rules, 2005-07-03), we never marked the phony "check"
target as such.

Perhaps we should just remove it, since as of a combination of
912f9980d2 (Makefile: help people who run 'make check' by mistake,
2008-11-11) 0bcd9ae85d (sparse: Fix errors due to missing
target-specific variables, 2011-04-21) we've been suggesting the user
run "make sparse" directly.

But under that mode it still does something, as well as directing the
user to run "make test" under non-sparse. So let's punt that and
narrowly fix the PHONY bug.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index c3565fc0f8..7f984bce50 100644
--- a/Makefile
+++ b/Makefile
@@ -2910,6 +2910,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
+.PHONY: check
 check: config-list.h command-list.h
 	@if sparse; \
 	then \
-- 
2.32.0.615.g90fb4d7369

