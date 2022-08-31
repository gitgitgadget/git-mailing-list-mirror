Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E8ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiHaXS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiHaXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666AE589D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id s23so8112296wmj.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BSlG/LEFH0VpL8tqc/G7wXLU2ucjGRtRJqQI76gtGSY=;
        b=PGuDeZNySLSnY+91hX2Pasp5YKYbDanM275Q5I+hCKlZ88Z9oX/Sz09MWK7zGLdzqH
         y5T1/WgiRrp+DyHD/Ln2HGMcYjXj2FRLHZWCWFi/5HULYv+JfNb5QY8Pgjr4+2yKjXIL
         rXT6KNIO53Tb/RLOiZRK7oV2ZG7Ca2FniQyvaihBTIgpdqiI27Rmgfr3GgGuh5eWntRm
         MheDpF58emjKfhxFU+yjf27SMmSsxBNZBMqEdt1TRM2pExiby1UZ8TjpPEk0CVO72a55
         BXl9G3T2yq+PPMvWqhrBHr0F+GyffPCfAZ9fsDsoNswD+LVORP6JJMMc909ik4kKx8yh
         aaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BSlG/LEFH0VpL8tqc/G7wXLU2ucjGRtRJqQI76gtGSY=;
        b=IZnSSqEvnIIP0nDbrDDcbOHdM7o9HzVy/sj5gFsxrgD08oRsJyZwaXc9APh3iXDec9
         v7GczWdj2AChT0S80ovKyI5k9y086wKVkqHfKzTMCDAu4wkV1BUO9O6OQtZtBk1jS08A
         5ENy3XR4fnlF1DREsqJONcUhvg4dlp1xHBnxEKe9shJ8l7Zt8/jG3DFMHDgIV+WWRohU
         0GWMhWWz6UwhgxbUWC3nBA0vVi2/onf5jXOc7lEFQ9pZdT663MwwoXAWGfK4kJAByNid
         qLt2npNpRAzRZDPUpvJRy3ObrXWIXkmhNgOp0cnjkKCgHVeFgrUUQgbdMoOhluT6PiMV
         1pbA==
X-Gm-Message-State: ACgBeo0CV5a7zIx+KhgOy/pxXeSUX9WNvGXT8WMyQdiX3YTbgZboCFH6
        1TYERfnpuAtyKuIRtBeyj/bWMdV/Bw3F3A==
X-Google-Smtp-Source: AA6agR7v9MPuMb473FjV9deh01wxbUvHuoAK8ilyvUnrDHzI5REsk6H0USu1wnc6HUMYkA2x6vrRMw==
X-Received: by 2002:a05:600c:2256:b0:3a5:c27d:bfb2 with SMTP id a22-20020a05600c225600b003a5c27dbfb2mr3236256wmm.102.1661987909245;
        Wed, 31 Aug 2022 16:18:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/33] submodule--helper: replace memset() with { 0 }-initialization
Date:   Thu,  1 Sep 2022 01:17:53 +0200
Message-Id: <patch-v4-11.33-008c6f4ac59-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the less verbose { 0 }-initialization syntax rather than memset()
in builtin/submodule--helper.c, this doesn't make a difference in
terms of behavior, but as we're about to modify adjacent code makes
this more consistent, and lets us avoid worrying about when the
memset() happens v.s. a "goto cleanup".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a492ea3cfed..7eb9fb2f00f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1667,7 +1667,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
 			   N_("path"),
@@ -1707,7 +1707,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -2491,7 +2490,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct update_data opt = UPDATE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2549,7 +2548,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
-- 
2.37.3.1420.g76f8a3d556c

