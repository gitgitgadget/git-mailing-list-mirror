Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB996C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D105460EDF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhKBMaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKBMaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185CC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so17721759wrc.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yP5oZ1uEs/zhtyoEzsg1Zu6WWMEFmtkM+3Xn2nQk3Uo=;
        b=Bt2P83R0oeYGDs0L3iIbkSouR5PiKDLJWpwULSOA/swJZ9yWjbfr3W6RmE7eO2CUd3
         +4+EOE7AmlLJF6vFqQ7/sRspv1U7BfpWqBRld0GMlj5fp6n1DUdJAfan/iNm62Prf/d4
         3ty6MV507Mi49ncSzvMWbYAPS5imymauNzleiR38EwiZJM6yu9WJ4HFTIwCcaZPNnP66
         pjFoqRGejaEvWOfTD4gZuquEyWFUSRt9CKbhmF0pScHMcutcCTUcdAWxtbs1ngpkYSaZ
         c34sDmKIA17zIIm32nsXg9ivz7nZZ7HKVGY71N0UpgE/YITUAN4/rkbVceOfmzmPJBYn
         IbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP5oZ1uEs/zhtyoEzsg1Zu6WWMEFmtkM+3Xn2nQk3Uo=;
        b=bAvr/T8Oc3idQNl7lLS5QStWotLJuqRk+yxqa2CMou82hOlVKMx4rY8lD6TjkfHyBK
         zPizZ3UF4nLPxanOGqT1qyPN13Sxqbz0RhNU3pTf8okrDVRI0FkqAo3rYVsCf2OogoW7
         jKfhN32LkkfIuEAGe5ayajhAhIJunKvVvXXgMz7VokHKOofPhE6ySFfQmHk31vERsXY/
         LIxuxC3lSYPxKJ02JpY/rq2AADvrRhd7/ymxwTngIKgfJof6AD2dmagjH+RHdMsgta3I
         ZXV33FifKDmyqXNe3fMZrYVH90TYajnHPrtCcOC8nkAnWZlR6k8xhhCfDPXKgDfVyALv
         9s0g==
X-Gm-Message-State: AOAM5336kn25ZRF9f3L1lMv5MPaF6M+4L/FhrAkS8968NYg2RGoAWtA0
        Uk+vR7fwxjesQB0MdyIuebsIJ9+C0o+9eQ==
X-Google-Smtp-Source: ABdhPJxNA7r+1g141XN7gtspNFU9A4QKYrO/CH75lKjIy3/Aqer1bkwARP+Stnabg4Id+zckBXWzLg==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr46250517wrg.282.1635856054813;
        Tue, 02 Nov 2021 05:27:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 2/8] progress.c test helper: add missing braces
Date:   Tue,  2 Nov 2021 13:27:24 +0100
Message-Id: <patch-v6-2.8-2fa92e7db83-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
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

