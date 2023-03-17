Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C9DC74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 05:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCQFBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 01:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQFBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 01:01:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD79B06D5
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v16so3373156wrn.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679029276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVgrrDQ7TZ9L5crFTK76RMSQO1cZr2KVRQQQ/Vcs+qE=;
        b=hU8GknUWguX34IFnr6S/H3SudGMx4WDXbVOZAgmTvOBqQWqcJucDyEahT97IfLDHya
         q8wa1SxD+nz//udwrg1DgBTQfWJx3QvtxN989gX4ZPhGynVRRJyiV1P0A+pYmr+U0pjp
         ohpFH0S+wLM/WP7YI54L4qUZOJPbkhDtcFoA70MAe9JSVunStMTK97feQRlPIf9irwk7
         ny2FaA6j0fKY1DxaW86ok0ucrFtDYbUdgNBmyVBzI/N/RQTrgbPjuF0DofS4SIMrpb50
         ThPrfqoNDGgSPOzCShXGsaCFOijtoNGcm4GKL6QgyexQIgmmY2Eof/phQEySyCec+q2d
         SOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679029276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVgrrDQ7TZ9L5crFTK76RMSQO1cZr2KVRQQQ/Vcs+qE=;
        b=4+z1pEZaRfa59FSCLQ9dKL9wlz/TwRTwRvmT3QFXE4DcJTSLZEXiQhy+zStGq2x+0x
         rtaknq7OZhaAeZP5TN0B6vVKvvYeVHzHRRR57zY22PH46+PgxEqyIQzsgcZ1xmmUlGFR
         7YgwI5hiBj0YUFUBQYc0uXu25lXtZKxVwxh9ailuRzMPLFWt6JgSK8BlBgmjnFbxZYLO
         AUI0F4ry/Y3CidFaUIL4a+AWsF7QGyBW2yX5Q1Pwz3W04/O/Yj3mDQ9jL0M8gyjnGdys
         NOhIXXcstcNQU8ajtxVkxPXVzumVbVWTfCGDijNxLu04xVKxR+5jFR5W8xs9DkET5NDY
         OrXg==
X-Gm-Message-State: AO0yUKVo7WarMol0Zl9477bUCah+kOl1unhVUTfsGa2b6lp6ih0eXfeh
        W26xIyL9g0P1QXK2NtvkvSYquG0G6S6AVQ==
X-Google-Smtp-Source: AK7set9LdA6rVCiDgtggsI2/jQdJqHfmrHavS7JmMrZZ9f5/c+c9Fmuy/lw4habXtKKYarECeKXtKQ==
X-Received: by 2002:a5d:674c:0:b0:2ce:aace:5b27 with SMTP id l12-20020a5d674c000000b002ceaace5b27mr5706347wrw.11.1679029276555;
        Thu, 16 Mar 2023 22:01:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b002c559843748sm1027844wrq.10.2023.03.16.22.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:01:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/5] config.c: use "enum config_origin_type", not "int"
Date:   Fri, 17 Mar 2023 06:01:07 +0100
Message-Id: <RFC-patch-2.5-643096b69c2-20230317T042408Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the current_config_origin_type() function to use the
appropriate enum type for its "type" variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 00090a32fc3..a4105c456c3 100644
--- a/config.c
+++ b/config.c
@@ -3768,7 +3768,8 @@ int parse_config_key(const char *var,
 
 const char *current_config_origin_type(void)
 {
-	int type;
+	enum config_origin_type type;
+
 	if (current_config_kvi)
 		type = current_config_kvi->origin_type;
 	else if(cf)
-- 
2.40.0.rc1.1034.g5867a1b10c5

