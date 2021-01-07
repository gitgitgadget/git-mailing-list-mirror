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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D695C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FD320578
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbhAGJw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbhAGJwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:52:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44122C0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k10so4626443wmi.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+M4spw2HtQW0G3xDt3pKtcVHGoEglbn/YYd9BHjj6pg=;
        b=KfL8L/5jWlj/eJ6YrV4moRKoqcSdW8AR1N501XKw8aevGQY4JsWGZgenODxp/Qkb1P
         aFOGe870jClWHobsGNkQ/SJgvhxzq83/8M+/BndNQfmLLXZITb34/c0RoS2HZ8hUVRxz
         gAZv4LX5tnWl6SwJZEOlBX9A/ai1sShpyLF9dCYiDyMbKzvMsvDBLz20VtFnjaIpX2hX
         ZGKAJLfmVKLdDo0jjqOq+ok4qIteA7TQsN4H1NPgSrCKsO6CM4Q6E3sGMyvY+vMDczWc
         WydedG0Zir9+uGpVJlh0z8K8kOmpvdd8AoqhJW/PH63YwXusV90w8DB3PedAzl1PPEcM
         1VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+M4spw2HtQW0G3xDt3pKtcVHGoEglbn/YYd9BHjj6pg=;
        b=Fl8EOVOJqBUdOUlBfHXivEXQYIChol6jiZ1txNpBqsy6mxNHDDVOuCwV+pHCxsvLq5
         mFuzYOWBYndLmBszKs2GBoPuBlREIdveCLF6FoJtKZc+mlQ/cVUDbj8Pj8iTJx7QORxq
         TK9j2DQX07JyK9z2EW0L0PUzusb5ut727scItrV0R84IsgMLbWgcJmSg0h691qgZgIQF
         pjip2/lKbEHEpgiinWD5gBUaJIgX8EWUEovNgZU3dATyVHU1fFWyi++mgLhSMrwUSVAX
         nx125pB0LaPK6OoY/k2I/FyQ5gqRimeyQSri7fOcTgdPRM37vZvdc5G73ZmHlVTjJAON
         Rm+g==
X-Gm-Message-State: AOAM533QBTo+F09RAhLo8D+QNoVNOKwoJ8dpiJ03j5KyE4PStywAcA3l
        e2cfbg/dW5BTqtLbn0D/er4/VYXHxpZlnA==
X-Google-Smtp-Source: ABdhPJy2BmyPajmFxa3EmBGNKj/wAgVxBaofKf2eDmZQvgEOuLmVcSIEwLYCsamEpz/FZ7Cr1FDS9g==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr7185236wmc.33.1610013132817;
        Thu, 07 Jan 2021 01:52:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] branch: change "--local" to "--list" in comment
Date:   Thu,  7 Jan 2021 10:51:47 +0100
Message-Id: <20210107095153.4753-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has never been a "git branch --local", this is just a typo for
"--list". Fixes a comment added in 23e714df91c (branch: roll
show_detached HEAD into regular ref_list, 2015-09-23).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9b68591addf..045866a51ae 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -726,7 +726,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		print_current_branch_name();
 		return 0;
 	} else if (list) {
-		/*  git branch --local also shows HEAD when it is detached */
+		/*  git branch --list also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
-- 
2.29.2.222.g5d2a92d10f8

