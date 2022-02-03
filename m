Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A92C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355092AbiBCVk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354612AbiBCVk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40343C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g18so7240529wrb.6
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4mjH1r0wOD0MH5Sja+kmSJz5V8v4vi8pZD+G+KLSxg=;
        b=aJrxfW3vst6asCvkoWfLcsTTqdsmKGY/SBXRoh4Uro6IvwWuKxzNxssdi6dwDXqQol
         7aPr6v2ITZE2zLn6jv5qBFiDN13w1h8z9TNIwdPu5hqN1g7i9Ou5HHn0t8VPXL3hxB+D
         uM1OfJoDVGs3wv7o8T7T5x5Vid3s8AWrhg2K4rMMrySB5qaolwxPJnCVTrDudqVifojx
         p7tg7fRXub5FlQWRIhJVu0NsPqO9bbYxrYgnOpCb/zJK/PnvW/BsoUSKjBoh4ctz8Dt6
         9IFuO0HxsvjqjEIRWY9texyS6oC43TAjzd6YKFtsWbIJcUkkNBv5s+wpcz3oX0yAz5u3
         oXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4mjH1r0wOD0MH5Sja+kmSJz5V8v4vi8pZD+G+KLSxg=;
        b=MB4vIOtCb433ivrt2WuOStd+1gQML9RhGlrT3tiMPQ0nbpoDurHZyuhjwzDlNklVih
         6nmiBJ/qqiugGgAIKAEIYRoEMsTI7CfaURtHiRh1y7MYoDBurCUq5tQdW1+Nh7zyQs61
         z+ObBsWPZxoEm4SSNZWWxlZ0fYFMQ9obyzti8rJa7RLnRqQBvybGbqC5xNigLGaA2UO1
         lYP2vyzmDnTXBNEFTD7uOdgpum7acZqKDF3e9eMTyfpnf6bMqJNUDrqEw9oHiiN9YjoH
         AIM+8uLQUWXQrv9uDYJN+ZPVWETJkGcOlrldwhT7PaUyUx3YmW0HQF2kWoQiF2SDRixG
         1cHg==
X-Gm-Message-State: AOAM532xgQIW3C3mmiYdMzyupRWfGUUr1L0Eq0mxNv+XStegF0rUDp0u
        F5QdpgEEA2jRWHBtzYT5CUylqL/RPuJQBg==
X-Google-Smtp-Source: ABdhPJxLrjXOwNiiJoDSPhsr5nswhjPdG/1ZchTbUzB0x47EBlyWjHHus8KpL4qdT1aFgdy7HFlQhg==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr29972999wri.705.1643924426535;
        Thu, 03 Feb 2022 13:40:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 2/9] progress.c test helper: add missing braces
Date:   Thu,  3 Feb 2022 22:40:12 +0100
Message-Id: <patch-v9-2.9-6951c059aa9-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
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
2.35.1.939.g42bf83caa3d

