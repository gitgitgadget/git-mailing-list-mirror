Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916A6C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbiFOXf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350716AbiFOXfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:35:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D81B79C
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u8so17231221wrm.13
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qBjidiBbz4KE8io84npexzOnVy4jwiKJwPoV0MiFkOg=;
        b=JTT1/iGTbHzgAf7ajRnAC2QyJWduRQYrgliny7aNAniQ+rQC+y/OQH03nkCQD2y7kl
         EWZK5ZfBDnJvN40bsB0UDqhSTK9UqOsuITRQR0kVR2IT5sY79TCClDVqzQnlpzwUAfXZ
         qDGvNo+yYaFP0iWkfJGsEGE1JcxAnt8Yx/ou4Tl+e/v7/QvUZS5Ibo3NiwLpJdVX6kHk
         unYaIhx99j4NJdMEqhCAHJvyVpG3SGihpN+iBJmmNeCza3X0Vne8inezLVYGzNgeH/kC
         qWewGGyBzO3b5PFXI16pCP3xGGUQT7GVmcweFWjDssd2lwMucMwXrjKz+EWVo3+9VB0l
         wOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qBjidiBbz4KE8io84npexzOnVy4jwiKJwPoV0MiFkOg=;
        b=8RVSgQ0lSyvx3bb1PJZMuZbsKNm1dZsphmmh0rLk0fAQK4lfkiyNpng10A1y2lWNSC
         z3cik31U0VXiwtbWmBTIlZ+bzDiz87+BxNQu2gCHSy+O517aTUHoQgu0GOkmjfol4ZdT
         kBaKnnc5vtaLXG93VoUZnFM/WfCB1ysBMJs0GY9PTIlApYXX+qztwFJavQU2dMWHnlmp
         2NHWxY/kKZpTnpnogEqjZuyPCPLp2wr7JOrRguhXj1VZh5YN/Ln2bDwZxTM47zfwaAQx
         6XbZaySTm62Vky2WguOVyDVQMg3qf+PHY+llNo1O0yQPRmmPNNwG8N40ShwBfHy8fYhS
         nVmQ==
X-Gm-Message-State: AJIora8p7nfBxc5XCRJpBfs6fv6i1oy8LNtDSKXGXSAiM0OxqU0l08rv
        /Q8L4HV7J0b2AxLkLKJxC2kMawdM6zVxPA==
X-Google-Smtp-Source: AGRyM1t8O0mW7CbdTy0N/OHRCpf6EgQsPSppAAIBNZq3ow2xHl17CaW3LVC9K2+PLdRfaiCl4SUe/w==
X-Received: by 2002:a05:6000:178d:b0:20f:e84c:2f46 with SMTP id e13-20020a056000178d00b0020fe84c2f46mr2025887wrg.646.1655336150243;
        Wed, 15 Jun 2022 16:35:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r64-20020a1c4443000000b003942a244f39sm4998909wma.18.2022.06.15.16.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:49 -0700 (PDT)
Message-Id: <679ea7421f73ce41515aca549982233f88bcefef.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:35 +0000
Subject: [PATCH 01/11] mingw: avoid accessing uninitialized memory in
 `is_executable()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, we open files we suspect might be scripts, read the first
two bytes, and see whether they indicate a hash-bang line. We do not
initialize the byte _after_ those two bytes, therefore `strcmp()` is
inappropriate here.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 14f17830f51..2ba38850b4d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -154,7 +154,7 @@ int is_executable(const char *name)
 		n = read(fd, buf, 2);
 		if (n == 2)
 			/* look for a she-bang */
-			if (!strcmp(buf, "#!"))
+			if (!memcmp(buf, "#!", 2))
 				st.st_mode |= S_IXUSR;
 		close(fd);
 	}
-- 
gitgitgadget

