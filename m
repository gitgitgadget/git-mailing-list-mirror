Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0ACC28B57
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245AA61268
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbhIUCWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhIUBvz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6BBC0386C8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t7so728898wrw.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naZ0LHBIRKwmSuHqHqHXtxUtYulOiw0Z/A0mhATm+hE=;
        b=ZuitZG0XpiZAPc841Qg+5t5VyKLmq13DhSnzoKJiJWY0ZETJC/g77z5dyEfITyFiMm
         HFnRBR6i7nZECHaS+ZkqTmRDyZJNh2NngkUOfnINAqhxXNSoUX32wJnmRC8fGoWIs/h3
         i2OCV7gfOptOKwi5xuxO89yWHhk7ua6WBpLT2aPT0l0Nut2gp0mCCoOja4boLqRBYgtI
         +jwgmFPUWb8LDCOLYhqjHNA5oYldJtxfckwA3K9yXzj2mVAPd5RUil5avhTLaiv1DOTH
         nzmxidoxfR45/yridjrGVgzczdXcr7Uwj/bfy9d8lIS/Z7UX4iH7OYq47mHoxYxX+f7z
         Ll/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naZ0LHBIRKwmSuHqHqHXtxUtYulOiw0Z/A0mhATm+hE=;
        b=fFVGKeHlp/4GaIX2JMTO8W1PU3H1i1NGB5kDRhhZjOMjCZtuQyP8k92PuGwTGWqLMl
         qKiyBPztJKNX3XLhgs6+SBtJny38Qp8VnWIW9CQYu6OmF+VNbARUVZ4WVrunZ3d+lJfV
         B8sfe9XBV5vV/tja80cZEvkDKQtA7hMcbMlGJg7f6oZjeSqqPXEN9ZoHZRg/uUZHj5sx
         HUwVgEJWyzSs5g17ThqScs7HR9E5iKkvICM8M0LDQ/ditfNhCp5NiSDkw3vHRS4mQOT5
         02o4fiTRuc0x12Jpq9usoS4PgICIUZV5gI7M7kjVorGqJDnyBeh5xehiVpJCkpCmOqtJ
         m5Gg==
X-Gm-Message-State: AOAM530ia6E3kFbqnTDVDdi1h5Rr/Etf9P9yatmyo1HKPBLJtTq11YPq
        U6ie9Ye1ym8sCV+WIxotWzl1U0VEf6lHCQ==
X-Google-Smtp-Source: ABdhPJwaqJlwnmzTKW3l/5Ij9NLcPBTELQA76TA7SeDNEkCWYHiQlNKinFYsgUkbOKZNEFkY/axxkw==
X-Received: by 2002:a5d:54cf:: with SMTP id x15mr32120281wrv.27.1632179382936;
        Mon, 20 Sep 2021 16:09:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm10409154wru.30.2021.09.20.16.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:09:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] pack-bitmap-write.c: add a missing stop_progress()
Date:   Tue, 21 Sep 2021 01:09:28 +0200
Message-Id: <patch-v2-7.8-a3f133ca7ad-20210920T225701Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
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
index 88d9e696a54..6e110e41ea4 100644
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
2.33.0.1098.gf02a64c1a2d

