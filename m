Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C4C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhLQEZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLQEZY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:25:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F91C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id b73so797661wmd.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjFK4y9hba7xuxsFQbxPmxEttud0rOTE7F2qMAfVwfg=;
        b=TS4Y0Wr/gPJb8YgEJN82zDoHEUnho7WyAkq4vM5pY/nTBmNGyCtabKfRbouYcQx5Xl
         9POv+U1D6eriSYRvYvbSoefB2sh4lGJ81HnLR6lilLCHypPMFunJC16IWrRGZ80RInjR
         B3jjYJa85xXfwmBEIXjywf0qf2+KmOfGU1q9KW5cu0fkrrIn8GRqZ+dmV6mflJXBqcaj
         exYCSKHwJYAmYLocwHkg7Rx61WPKcmG7pPDNXUui2FXGLPGGwbIFDUxnYenPIfZP/bIj
         hJnh2sTEazu4mAiS68Zroq1djj3WwmP4nR5w2M/lAH19NsYqOot1bl3jFzVYpIvrKSV5
         d2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjFK4y9hba7xuxsFQbxPmxEttud0rOTE7F2qMAfVwfg=;
        b=aQfj/rvjJs0uhAVlHORyF+LmWk/Y0zHDn8OoVeOEAvn0ulZzHZDbD80rVCxeezKZF5
         7Y8ocNKFI9hJ8mRZw2CkY21rzbmEydVdxd4O5x7rP4TEaQ1UyQRcUsp/vm99JenyIu0z
         N+7RaahgmBh5lFo9w+RL1T9kMEEjkUtmpInh/DTzq5c7eJ/VyaXG6a31VtHAW9Rl3eLe
         VNm4CpmFM1WF+zjRn4IX5XbHcxppzKNt+y1yzlUC4aFPBzgtSGgYU4lQtsgjIyDy5V0r
         uxPhsMrrD+9Ffb81/J3X+UBKkpf/jb1AgVXCULd9FRPJdVV2Jj+5BLnOREZ4X8iBWx9p
         ruXA==
X-Gm-Message-State: AOAM531mug6Eg1MZqmdMw3r38WYb7QVCB6J4dNYfzihxTm5pTtvxPjb2
        NVnrwbVBCFWD/A+IoKZiy2e1FoedHPLk9g==
X-Google-Smtp-Source: ABdhPJysINca21HpRG42I+GAr8o26EcVyc568Yph/dGHE2GAG02esjcHe0pSKK5UhcShT1s5EAq1Lg==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr891165wmj.15.1639715122624;
        Thu, 16 Dec 2021 20:25:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o64sm6325634wme.28.2021.12.16.20.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:25:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 1/7] leak tests: fix a memory leaks in "test-progress" helper
Date:   Fri, 17 Dec 2021 05:24:56 +0100
Message-Id: <patch-v7-1.7-5367293ee84-20211217T041945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
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
2.34.1.1119.g7a3fc8778ee

