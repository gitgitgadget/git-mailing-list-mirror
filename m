Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCC1C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhL1PT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhL1PT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:19:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D3C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e5so11419976wmq.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DvBFXkem/m+8M7t/k4+MfXTZYbTcZx1hWM8Iz5NZE0Y=;
        b=FW0V+Y9ZKr1jjZnvpA4PNcc6YlKnbazhs/hl5ef2nfulqQrMdMGlCUwuScbOwAKykR
         K3Jvhu2opfqi93XhMW94e0JoBRxqHoyG7eSCkgfLdwG+w3oIW/nAg4SM9gk7K47piAur
         lnVsiPVZaHhgMEgwgBqhnn7CDM3U8wTJ/K57izfp0fon3y+MR+Rxgaj24Njw14rXh81C
         Z402Sfocn2hzLmsGQJx/nOblasyt7j18Oi5VwXexKTz5qoJ+NIYabeMQTjBg4louHGFF
         L0I2WvqeaFewDcnowF3Mp2QI6E2M5YhGfPIJrzA5hOiZ/gVXNqCd9h5pNwp9RoklvViJ
         JtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvBFXkem/m+8M7t/k4+MfXTZYbTcZx1hWM8Iz5NZE0Y=;
        b=a2t3TeVCduI+qGocnHvjP5/+FnKcGOJAo4WGicBXD00Yk344SRive5oCNv9YwTCLIv
         m7gLEYD3LmFmxt2Yk19do8a4xqmXoTPu2pDhRo3YjSgU10QmS5kd3JuBQcir3nRKmLMz
         SdCj3fsSaiMCdG+osHem9Pc1F8WlooJ88qp4qOxV3QDauLo1G06EV9cjPJoIVPlF2eax
         xOH/iXhTjbGi+y2/QMAoixqGgqSMNT4dlJi4tGv3Jj3f5j2mAjwgrIUVtLqKNQNMEP1r
         vjLCHf5FkOKHTqX8bmR42TsMbNCYsmB8DuAynKJujR5eOdDy6IDoLXtR6WvVU+pkQbo3
         +KEg==
X-Gm-Message-State: AOAM5335jbYLv7sSx0/lypZiMiXaflJ4WarfYbydlVE6flQAeT8kbiWi
        fAADfjytJ86AcsmoTy+6QtBHA24Z5o/ElXJO
X-Google-Smtp-Source: ABdhPJwc+62yLA1zGMuJyJDdigIvD/VJKRlNDvNf6EQ+V1yOVyBdKseQSNOMc1z7kHmfEhC+FOJLHA==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr18081975wmj.51.1640704764375;
        Tue, 28 Dec 2021 07:19:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p11sm20491022wru.99.2021.12.28.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:19:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 1/7] leak tests: fix a memory leak in "test-progress" helper
Date:   Tue, 28 Dec 2021 16:18:57 +0100
Message-Id: <patch-v8-1.7-aa08dab654d-20211228T150728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the test-progress helper, and mark the
corresponding "t0500-progress-display.sh" test as being leak-free
under SANITIZE=leak. This fixes a leak added in 2bb74b53a4 (Test the
progress display, 2019-09-16).

My 48f68715b14 (tr2: stop leaking "thread_name" memory, 2021-08-27)
had fixed another memory leak in this test (as it did some trace2
testing).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c    | 1 +
 t/t0500-progress-display.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe7894..9265e6ab7cf 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -69,6 +69,7 @@ int cmd__progress(int argc, const char **argv)
 			die("invalid input: '%s'\n", line.buf);
 	}
 	stop_progress(&progress);
+	strbuf_release(&line);
 
 	return 0;
 }
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 22058b503ac..f37cf2eb9c9 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -2,6 +2,7 @@
 
 test_description='progress display'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_cr () {
-- 
2.34.1.1257.g2af47340c7b

