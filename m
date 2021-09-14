Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DD3C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487CD60F26
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhINDk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhINDkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:40:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8334DC061766
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so909533wmc.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bVvyumh6MBpoMN2SqO/NM5b8LWzac+sdurFlpS+N5Go=;
        b=H2ceaPtPELV6x9zC4I6Rf56IOPqWZZFX7IIeKzE/xpdtr9Qst15BNcCupwfTP+6rC4
         fmAjYh8swC/qERnGzlm8T3t8Z34sTc6D853HUkTYrvVhSgBT9jjoHYtzd9IblIThxXwr
         3sh8Fd6/qjlHrqoTraRT5caECjoAT9rZ8AMwsMclVL/yBsXYNhqSPAry8p1EyDmHlMkR
         1neM8Tw1usmhONFQorEojz5NsjfeH0mCYHS8UAMSsNjuuOrG9F0E3aUIzzJhDQmiFui8
         NW9LGqzhNmhAHQRCaaHPgzqicilkPYGGhkfz8pBF+8G5+otuktoPA9trJmII5uyZZ7tF
         I7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bVvyumh6MBpoMN2SqO/NM5b8LWzac+sdurFlpS+N5Go=;
        b=OcF+lpazAmqPIZSIJ1/J7BWWzNHoqewoBSt0GKI7MnfIk0LUQaifuLF6kg0UtfaPjw
         DatbxjOLM4sMgkUlJgqOZc7fragtiqhg79heH3MmNtePvco3Lg5u5+EavuK1MRzSf9aK
         iihkP1GjwvUGQrwEflmU9tuMaO8SKfZ3HbbwGUH1E9dqnb4vpDSVgXWvFBlV2C/1N0gQ
         l5rwgg6TlbP7Hb7BCesunJGexPIqlfFXRkDw2zkY/nzMhqW6JZBBHjPrAZHwFFnpedYD
         Y41AWW4MU8jVlcQHV3A45PLi5zPL7HHMbK4q3C4HMSxvSHj7JwZ8Sop709DP31Gl/8gX
         bKcw==
X-Gm-Message-State: AOAM531RpmzqG54rhBADg5k72ymJFj9hVIEsThOEwOPpimK3x4a0t1NR
        N6myxFd7+ebMx8Hgvf2gMgBt41J/tZw=
X-Google-Smtp-Source: ABdhPJyRAEnV858apXS6c6+xoRZQxJ1fFpwhUCnrpDL6MQlSDMJY1023H7ajj3/P1jtVyS/21dFqpQ==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr6442707wmk.116.1631590730166;
        Mon, 13 Sep 2021 20:38:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm5706418wmf.11.2021.09.13.20.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:38:49 -0700 (PDT)
Message-Id: <55a40fc8fd59df6180c8a87d93fcc9a232ff8d0a.1631590725.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 03:38:45 +0000
Subject: [PATCH v3 6/6] core.fsyncobjectfiles: enable batch mode for testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 3e23eafff80..27d5e11267e 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
-enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
+enum FSYNC_OBJECT_FILES_MODE fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
-- 
gitgitgadget
