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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C61C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F55E61396
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhGVMOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhGVMOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC93C0613C1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so2908526wmq.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kb4BD9biQ2CFmv0xDa6kME+4jiF1xCEPXWBGnXU3WPQ=;
        b=QlzY31kLgSBK8UkHXNQ/tXt4nJ7/fYCaPTlnunkbQKGNECA69DTKdouXWL8zFl/DY/
         6kzvIQ5C9tsTXasYa3d22X1iOI4rOLfTvkzS/JlYK0s3HUxX2efZsU8xNwP6WlMgVBW1
         Z2HgROoTbBvaZ2MABc3WXd54YP/6xGygo3IC2jat9ZbQIUEBvkHyh/YkkyTfWggVeV9h
         kmaaFUU6YlWgRUMeG087tZ+UDXkGSWn2Pm+BQ8zROfjtN8b/qBFHSE02vUYoa7SbYaQO
         tGO7UCAiEP1kOz4tMPXUSAHmN5zoaI2XV4gC7nIERmbvlLvywgUkj39C66yR3mqpxGtW
         uNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kb4BD9biQ2CFmv0xDa6kME+4jiF1xCEPXWBGnXU3WPQ=;
        b=WvwQ3XOmK5QdKfB/kGoh/8Zrdt37MNnoOgSf7IQPreKVRgQ8D3H/2EMKnfq/3aRGXX
         ELslakG++cOUgQVzd2U6g3Qj2z77LTlUG3cn0G5vcx+LlVAs2djOTFQD3f1ozE7dAEy9
         ICUMf4P/fZMc8ixColpa2mimdsGVby4iauVan+iaUJrAezBhuayqYh2ThGYLFvj1S02v
         8DoWXRCT8hkTAB1S6MmFj5/FHH0EzP8oFOcsW3hhMhRPSQgj8P4uI8HOs504bT5D53st
         1dp9kR1wpOjrS4GH2gALqvbzFiGoqPKfVyeDB140hql50CtuEU7Qk9oXXJHXTeFcWaPY
         o2zA==
X-Gm-Message-State: AOAM530fp8PUCsLMrRC6dF9sGWPGZM08sxXwr19OITR9Hni21jDE1mTd
        IEiBmGs/seMSwWQRFGTS39FOwoquOAVkig==
X-Google-Smtp-Source: ABdhPJwxz9lZd7oTgFm9F45duNv5UgpPSg4lMoVBnExRk/nb6GwiTRUx1kG37P6PAdhzw16haG2F9Q==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr42333803wmk.146.1626958514432;
        Thu, 22 Jul 2021 05:55:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] progress.c: add temporary variable from progress struct
Date:   Thu, 22 Jul 2021 14:55:04 +0200
Message-Id: <patch-6.8-b99bb60dca-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a temporary "progress" variable for the dereferenced p_progress
pointer to a "struct progress *". Before 98a13647408 (trace2: log
progress time and throughput, 2020-05-12) we didn't dereference
"p_progress" in this function, now that we do it's easier to read the
code if we work with a "progress" struct pointer like everywhere else,
instead of a pointer to a pointer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 1fade5808d..1ab7d19deb 100644
--- a/progress.c
+++ b/progress.c
@@ -331,15 +331,16 @@ void stop_progress(struct progress **p_progress)
 	finish_if_sparse(*p_progress);
 
 	if (*p_progress) {
+		struct progress *progress = *p_progress;
 		trace2_data_intmax("progress", the_repository, "total_objects",
 				   (*p_progress)->total);
 
 		if ((*p_progress)->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
-- 
2.32.0.957.gd9e39d72fe6

