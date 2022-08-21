Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DEC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiHUN7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHUN6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8811C39
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay12so4373296wmb.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gy3cziut9rZ/LQaoyK7gX74eQB971/zs39WOQEPEnJ4=;
        b=hvG+8ZAOe1aBNBDz7sLOo5eBImxvmncB7YjbDlvvWTy8ys4PCLUT2pKNE/oKpmRWsC
         YYDOHbmn1OYhzsNtMja7Eh/U12w/fRZd+OSEFjWBLLud/KgIFoDGdY8oZVDOZWIsF+TM
         TBa8Y/8gGZpd7NtsuteD14D5XLbeglA/WMEUS9qEOxG5VtJcAb3BSMsSYTLdjA/laKuJ
         QZb7LaY2TezCxqh72YzAso2mlOYKYVZ8o/t/1EvoZZ6v33kH2jdQSYE59BAa5qjXq3t7
         2FjX0uguHANrJc7jKzp5p3p32ncdugbkRh0Rcl88nq/11TiWdh3zGkXZk6dMjKvO+myn
         1POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gy3cziut9rZ/LQaoyK7gX74eQB971/zs39WOQEPEnJ4=;
        b=NT1IhPPV6wzi6bYPatObHm0XxozFjTUJF5IpbJ12wCV56ZnQFK7wyy6IEarNFx935v
         SJs9xf1BsOzilpAxvZbQUqeC/m73S+atKxZK9cXrUqHZMz+1tKS76vE3nwtdR3Wkk43+
         PxDDz3IV0MTRiz5N46RWdB2YA3GBt4WbD8iTVHw+2gb/QgXlZCa068mV58sJk97M5IeP
         nt2W34eXR+7HfQ8PNvFjlZX4aIBFjxAT/EXrVYRCVtAmpBFe5fAm9uUBUJUTE0cMxyfV
         pTIQx0qfF323wIPcw3yF3K4+R4EGBLf+MWdKvUFbICQXK5EGgyniTeQMfOQE9WB8iyp+
         33QQ==
X-Gm-Message-State: ACgBeo2koKVvFdivC7F98bINQBOTh69h7a5yQbzk48ZI4Mcbcu9Wefxw
        V+UE/on1O79DtI/rU6cDpdtlnA2W7Ekage0/
X-Google-Smtp-Source: AA6agR516ETeH/yDmq+nat0pz8Do+wRJ0lSFzg7+Gmw9RVyvmk1ozsz4LPkZNl0l8Et8AbXq6StToQ==
X-Received: by 2002:a05:600c:2909:b0:3a6:2ef5:772e with SMTP id i9-20020a05600c290900b003a62ef5772emr7771072wmd.16.1661090316886;
        Sun, 21 Aug 2022 06:58:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/32] submodule--helper: replace memset() with { 0 }-initialization
Date:   Sun, 21 Aug 2022 15:57:20 +0200
Message-Id: <patch-v3-11.32-356f07db436-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
2.37.2.1279.g64dec4e13cf

