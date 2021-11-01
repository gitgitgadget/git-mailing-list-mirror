Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6F0C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D1460F46
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhKATMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhKATLz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:11:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB0C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so29574016wrg.5
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yP5oZ1uEs/zhtyoEzsg1Zu6WWMEFmtkM+3Xn2nQk3Uo=;
        b=FaWz42RUJcSYI0Gon1J28YeUzHQT8gY8OwIEuYX6w8VU/YRa5sQ3NxKBjjcw5jedoh
         6/G9AyxkUARVdxY2hu4rxwalgBjYdDJDWWnovI3eDAZF0ZgU1OS/zr+7qsZX2TWNwJc3
         ble42dkCLX5KqXy0g+n3mDzLn7dpdMsnJZBGfE91Tw82R74t4g5ON7l4dUkO+vfXxnKx
         YoNiuJiJDjOHlowP433SC7mnyXJdDIIWNmMWXE4CgCgnNVi2Hd7GxD7thyo8gZwW8p9D
         BQuI1nNs/iDOySYQ2R8q0P4qm5S9lKIMlTH90mVt2+ogieWwyjxA25JxoCxlIxpgOSjm
         jEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP5oZ1uEs/zhtyoEzsg1Zu6WWMEFmtkM+3Xn2nQk3Uo=;
        b=cInzWkEN7fPtsDdratyE6aXLMX8jWegYRau140wQpmAX9dhFg7hmv7SngSqxXK9DVT
         RNwHlPLUmY6CsFe99wW4i+X6LNCdNKDw0E6UL3wePK3F+YsUPr8n2N+X+M3lvMNgDz0f
         y7pB0KVpHRAMV+nAr1CKAavCoWDqLYaAAO8HUvnAwLD9A1qqKFH/qK+NQN8tpfNgcJZJ
         3GPahl5hi6pfT28qGxLkFMBvAClRwv3oZA0obqg+0nkse8xGNEM5qMoGUp8VN4l+2Hpy
         LjE7H43OiZAPl05UG824aSEr5KkQFM3bXu14/lVy6W4JUkKPZRWImacjC5ZseT8EO0a3
         EEbw==
X-Gm-Message-State: AOAM533poa1tUEjvjb+/2Jv4Sbnl1sOajJz6q0ktZXsv34xtm0bfivY4
        hSxVq6AvFIW+6TdzB5ulq+HKXU8UoC/fVMAC
X-Google-Smtp-Source: ABdhPJzzdedvqoJLm26BiuRAxROi0OxDx6g9mSWL+E2aEmw8s8/MdeSo3VRKd3G+YzC8syVPmToQLA==
X-Received: by 2002:a05:6000:2a4:: with SMTP id l4mr13822878wry.238.1635793759671;
        Mon, 01 Nov 2021 12:09:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/8] progress.c test helper: add missing braces
Date:   Mon,  1 Nov 2021 20:09:08 +0100
Message-Id: <patch-v5-2.8-0ae86e40e16-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we have braces on one arm of an if/else all of them should have it,
per the CodingGuidelines's "When there are multiple arms to a
conditional[...]" advice. This formatting change makes a subsequent
commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 9265e6ab7cf..50fd3be3dad 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -63,10 +63,11 @@ int cmd__progress(int argc, const char **argv)
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
-		} else if (!strcmp(line.buf, "update"))
+		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
-		else
+		} else {
 			die("invalid input: '%s'\n", line.buf);
+		}
 	}
 	stop_progress(&progress);
 	strbuf_release(&line);
-- 
2.33.1.1570.g069344fdd45

