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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D170AC4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26D065109
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhCPQSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhCPQR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7BDC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso1780684wma.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPM5okOEyHNvWKGhu2yCkFeGzGVb7nwFgDrmg+xjHVM=;
        b=kgEvBfs8M/4bZAPVt6vcxrxGS++digd56ieIpjDv1l31qsL5LXXxawvbUqlE567k6y
         OpWe8RGKCgJBPoGC+xLfoo8uNl8FE2yHB9Q+tw4rQSJ5SyGBRAvzQM2U94KxxVo+l3u6
         eNqRasugVuSiY5smBpeAkIbUkgfBqSeu2UDgvHIVlwqk3I2dCKTktiBDJ5EKhoiP1gZ+
         fQfHm24XbpMrttA1tum7ZqUkZc1tsnBvBXQRZc+xZ0Ree7nkIiqKHLtQdoSJtWBcS2YZ
         8wyekro2dw2dPleayA6lD9gbJaAEJ1TSRrwRoM5vUHXlMvGjlIFzfFUohNCtU7UL6s9p
         fUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPM5okOEyHNvWKGhu2yCkFeGzGVb7nwFgDrmg+xjHVM=;
        b=Zc5a6xQT1jCu1giWdTHDnUvcZySCfn9b6eUWu8jn9b/Eynjc7ZOt1uF/GylITEHEgI
         XOudL5/tUbcMcY2l4fapZsAny/RtT8W/yxdFOFc/tdbZJj3t8hmSWB90A5IaPIP2d+FG
         9Y5b2etEpwuRuwhGeykkiV1CaQYus9XFp2UV8fFfaWqog88QiuZZyPhxKKydn7YgRp8Q
         Xc3STaapjI7UErZQWpa+loXEfmIKvlnYOjaNpd4PfwoN6+HLasAjIc5LSwucKKXzkbY4
         Zc0x/hArQTaH3a5qBFz9zSDO8GFQNAC/TqlAfPxql+4fatgxJ6ber3fO90r2BCEvISCS
         judA==
X-Gm-Message-State: AOAM5315Gbz2xGwibTK2DJQ9d88xAL0tjVYk+Q+3JBqb5rguc7bv2okr
        P3k41hTe6DBViYeMWQpI7ltHy7qBm6GUgw==
X-Google-Smtp-Source: ABdhPJydE1Ow+KKs6zMTydJ8ljZLzCwpZuVfzS6S9yXI+/p/oyPzCLFP/o3Co6YyD8pP1P0ktLq/Iw==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr381278wmg.182.1615911475292;
        Tue, 16 Mar 2021 09:17:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/22] fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
Date:   Tue, 16 Mar 2021 17:17:18 +0100
Message-Id: <20210316161738.30254-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fsck.h b/fsck.h
index 2274843ba0..40f3cb3f64 100644
--- a/fsck.h
+++ b/fsck.h
@@ -43,8 +43,22 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_DEFAULT { \
+	.walk = NULL, \
+	.error_func = fsck_error_function, \
+	.strict = 0, \
+	.msg_type = NULL, \
+	.skiplist = OIDSET_INIT, \
+	.object_names = NULL, \
+}
+#define FSCK_OPTIONS_STRICT { \
+	.walk = NULL, \
+	.error_func = fsck_error_function, \
+	.strict = 1, \
+	.msg_type = NULL, \
+	.skiplist = OIDSET_INIT, \
+	.object_names = NULL, \
+}
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.0.260.g719c683c1d

