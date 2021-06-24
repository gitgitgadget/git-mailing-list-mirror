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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF3C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0FA613C1
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhFXT07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhFXT0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22281C06175F
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5339180wmc.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxVD99MFd4a2ZrTnJ33pMzTC0n+kUlaMrdWyrKP1V40=;
        b=OtZIQcSOn8/5fCS7fRR/vWlQEs3ZlDKvwgFnmrh+7s423aURDTX8zz4L0OkB/vjjWZ
         /ObuvynNa6px4lEJsW3TCgWTtGwi3YmbzDZNN/abrv+D13fdPQ9nBrjIuNDKsGAiDNkk
         ZGckQYlGDg7FB0aw3C4pUjchsU7cgfTykHHwV5EVJM/ZBZQ4glF6kLv75Ivq+Gq+SPNh
         NDKBB4J0K4E/6rU9tgNxwXXYxLqKXO8+hpUzMe4QQWr3wnFmAW0ERakeQwaFLAR1vxfZ
         UAH1j7WP8OWkia3JxV0r1Oc0cgwmJ2M6cHtMZqyIjr17OHEZLzDCzHQJdGThLyYuMzSN
         RyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxVD99MFd4a2ZrTnJ33pMzTC0n+kUlaMrdWyrKP1V40=;
        b=MotoH/DqJm8FjrmkmLLbJF6kZzpRGzNVh2zb4EsSYNi7voVKWGBJ89szKg2Egb0BHU
         wyHc/aH4DHAC9U5QRSHx7V6QaAIs+w5pHV4lN7OFUG7KzuLorvX7JeEpZQdMH/EnsfH+
         Op1G9Ws3gJs0iGnCA17FTJ6Z+2DQUFRQArB/eK4RsiVZov58bZbRYHMK5+QyMtAeUzuS
         QqS6hDO4dgWmMeX8JrnpbRE9/0AcQ09JuutGcPmJY7KSJe9g8dwUj+K7WgiKeXWX4GX/
         UtYdUGRKPNk7WnNlPIEYMf9M+H9wJICBBMuiqTb2394iokJ2tjUqLE2qLdj4zQTzYXWl
         EFWQ==
X-Gm-Message-State: AOAM531M4U6a3HYEediOBeew6JgFyWOPOdPxlbIotggHPm3Wzf56dZX9
        ZmyGMY4CIbr7L0r14tfNkp61+2YfQtPnmQ==
X-Google-Smtp-Source: ABdhPJxphSK7bC8v2xo9dobyWUDwBVGKMTuFH24s8Wym4WFVRXU+xPYgVyqym8OHlI7ZNSljdLV0ug==
X-Received: by 2002:a05:600c:35c4:: with SMTP id r4mr4108950wmq.14.1624562655579;
        Thu, 24 Jun 2021 12:24:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/21] object-file.c: split up ternary in parse_loose_header()
Date:   Thu, 24 Jun 2021 21:23:51 +0200
Message-Id: <patch-13.21-ba632be1520-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This minor formatting change serves to make a subsequent patch easier
to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index ef3a1517fed..e51cf2ca33e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1381,7 +1381,10 @@ int parse_loose_header(const char *hdr,
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type;
+	if (*hdr)
+		return -1;
+
+	return type;
 }
 
 static int loose_object_info(struct repository *r,
-- 
2.32.0.606.g2e440ee2c94

