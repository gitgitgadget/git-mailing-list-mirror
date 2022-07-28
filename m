Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD70C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiG1QSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiG1QRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303C71719
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h8so2859490wrw.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cI1KWeFEtXSZeSbUwCiCwQl5ld8d5HHZp+QsLdw60b4=;
        b=bpvRMTTNXHYsB4H/IUzj4nK5FYb42bX5h7RN7bC5Q56oJtU7YtnAL8O7/iPO9yQYnC
         qKSOGTRAV6c0qud9nk/SQZCadNG4U+3WGi95DJ5yyfRV0TFEud2g95WdImqF70WJoD0M
         WHF+3Q9p+mPOD39rhdN/UDd1TG/guUFJH59VGCIgguH0niF/IE3Wjc/YFkV0foEOz0nN
         WTWBPlt/0dX9kjpGyRtbXoaJBwRwwn5U6kGzkFXKq0a+jPbexU5R6edc1qxyf2O+k10/
         EDu+u0nlxQ25ZarNIP4Rjj1tqvQqm1nxj7G69mylfNQ71M/v3tC3e/YdRsdgnfJou9/y
         HIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cI1KWeFEtXSZeSbUwCiCwQl5ld8d5HHZp+QsLdw60b4=;
        b=Y8Oslm3jR4OH7H3M60eZz37VnkyqR6wcIVCxyi0cVg8dEPytWl+7X2aiXX4b1mcJ6u
         srWI8G62heLsmQK2YePjVNhsw0qh54fPBRW9m2oPNM8DJTnM7u2whgL+w2C20sDEk36j
         VMym9ufy4ndQaRt1EVEzovSnC0oWofQHK+UvCzlg3K03V/LT/nTZShIgruVIWd8+DHKq
         2y0N2JupXVC2I5D0suKzI7QTdq3r+e/i/m4Ftclzo1Q0lFuM4KKkhU6Snn8HTZ8KGE2K
         2ydGsgWbh1Lugnq9tdZIS2pl0ZysixuLYIt3eanDvGPQWy/JcyrtyaKfB5acRF5eVUdx
         ejBQ==
X-Gm-Message-State: AJIora+NVW4QuYdh6775evd3o4/xM/EuNJBceJvDAAxbmotKNDExQ9BM
        rzWvv2LhHW9ysn6sCUg+kAewu5EGTR+1eg==
X-Google-Smtp-Source: AGRyM1sWD8QIpCQl9XdC/Dy6of3jP0sbWnVxAaG+lLnhqEOTfAd/tLnzPbmyeEWlYb7LZZO5xChPAQ==
X-Received: by 2002:a5d:5a82:0:b0:21e:2899:60bd with SMTP id bp2-20020a5d5a82000000b0021e289960bdmr17506982wrb.80.1659025054462;
        Thu, 28 Jul 2022 09:17:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/20] submodule--helper: replace memset() with { 0 }-initialization
Date:   Thu, 28 Jul 2022 18:16:56 +0200
Message-Id: <patch-11.20-dc5ac924496-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
2.37.1.1167.g38fda70d8c4

