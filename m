Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D38EC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiHBPqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiHBPqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54DF17E0C
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j1so10034546wrw.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YN8/zi/AIprQvY9R0DohmeZAZe8BOXfMROBY86izIT0=;
        b=l9ee6zizO3joL8WUHQl1PipWDm2p/a5ZPTYHDJMVoSogOnV86QHWF/qRd/d3YT1APF
         R/JiBjk7MtUNaMHXIoYjnerabDx1ZA92eehNS7Z1a2Gvy8VUAVVQZAD4MaBi0TJsYre2
         HYlGeN60eddhFfxgntFzwrdnfLseFW0/hQ5O2MWz4Mz1pF30jgR3XRAWeKX1zEiPEBfJ
         mPwhqq0jQkoTMmx2H6UAQgmaNP3VJg632y7X9bTilrhE7zet3suuyf5LZmbI0ykcJH6J
         sh+cgBqkEn7nJPFB+cXAkP3OoUlymRT2tJxdgL4iFGd12okRijwD7R0RsIHJwNugf6dt
         ochw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YN8/zi/AIprQvY9R0DohmeZAZe8BOXfMROBY86izIT0=;
        b=ZjhTPrA+2OybWYw1nmL8OQts56JM0Z3ihRsK7h+IJDI5M4LBM1r9yIeKcyJpFfxkMV
         d0I7cBfpDM5fLwZue51yBSO12tX16dLmqPx6WC4b9rT+AjUmiPAovVEzKxtVjiESE4h+
         2Hzoybk0nqgSGIdDsPMZ+DBptWS9QV50FBlyJxF5b4gm6fsHfOCny9AcLo6S8PsGEuab
         WRyjst/YtsUPSSBnJUqYWq+0xYzQjbpwM5WB//5GBZazmwDVHBbEgC+piynw8/F3RtWM
         rTfS1uHX3VgfykFhK5AhTW6rGHl1Kb45Ze2MsqzAPHUjNK5Jg030AVsMxOPtkkSwXN7e
         jt1Q==
X-Gm-Message-State: ACgBeo05J2vS2T3i1uI/QnPfYEs9u+Nv7MeppRFyenpqJwtuNP9ezIbW
        XlZZeoOvXcYJJxCL/ditTpJaucP7F66t6g==
X-Google-Smtp-Source: AA6agR4uNfPaIaOJTpu4AXlpzUQL5TTQUDSxyS6lbwnPj2EQnswhxetyebNore3xmzeKziMGkCgS0A==
X-Received: by 2002:adf:df0d:0:b0:220:5eeb:c0b with SMTP id y13-20020adfdf0d000000b002205eeb0c0bmr8412037wrl.55.1659455187985;
        Tue, 02 Aug 2022 08:46:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/28] submodule--helper: replace memset() with { 0 }-initialization
Date:   Tue,  2 Aug 2022 17:45:55 +0200
Message-Id: <patch-v2-11.28-72dcf19e1c4-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index 15bf89910f4..60165a848a2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1664,7 +1664,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
 			   N_("path"),
@@ -1704,7 +1704,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -2488,7 +2487,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct update_data opt = UPDATE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2546,7 +2545,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
-- 
2.37.1.1233.ge8b09efaedc

