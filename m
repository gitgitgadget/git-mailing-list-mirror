Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C537C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiGMNQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiGMNQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE15295
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so9313042wrv.4
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7D66cr6aKKSAfQZwQnLaGa8pSypCW5Cp+N3a3YCk2M=;
        b=KLm3BiExE5ssnlCP9iAqcDp9qM591+zUB78Lr/FtH5uBnf8yi9GQNcm2i8F9L5B9fx
         76wMM7/9yfZB6HRUYUHJzH8Uo2XcemgO2b+q7EC71GTndfltQyylas/eLtkBy9rRP10s
         wYGe0D820BLtFb+JOxfeZayaGfjeSy+2/GKYySn99TQGq7iha4+AMf8b4x4KABfzwetC
         cVpUD+KtPia/oK1zygWkurnRcHVt/NK9nwTgZ3je3b2RFkOBVDVEriGe+dhTmcqz7CO5
         Ac+AROJ78+lz0QvYcQYpHv6B5fiTUl47L03VzK8itprj70TAOrLKV4IJbwkCLUPLiknT
         7G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7D66cr6aKKSAfQZwQnLaGa8pSypCW5Cp+N3a3YCk2M=;
        b=akCZYkthE2O3yVAmquSez2ciB24+lu/rOn1eZYsS1erCEfpC/OqsJK76zMWaJKlh8O
         Nh2EwO/7dDiPDI6+Br/GRQFhs1nmT5cQcat3aZ6Ni2uJ4QE3FxyZX8lIsQ8wZ9z5KwIl
         xLcYIzmiecGklavWEGFEMMCyuzpCyI0HxnulZl5/YDdPUZV6RjiAZfbhz0ODO9usemLW
         Z8cFekST3lVcY6LRJ/p9CVczS6HrCLuB1fP4D4dsJ0G3BHi8SeDCXi+RH+qup5Jhj6ZM
         6CP8zwn9JYJfLYryDsvdu01Rtpo+aYWmsrLmn2HORw+xAj9L9+HTVaBJjTM5UMwkiC/G
         obDA==
X-Gm-Message-State: AJIora/JYcZcXBliNeAXNaDXN9Zd2d3xOhye6X4Ok8Wx2l45abHl+9zc
        DnT7rQlvm+RfPyzvzU0gzoonq/n23ZPSyA==
X-Google-Smtp-Source: AGRyM1uZRaF+jFMW63P5djQM/9RbUiVvzGtupDwe8kjgxTSPR+hTqPGHfD2Mvu35eRElilP/jZYlwg==
X-Received: by 2002:a5d:44d1:0:b0:21d:7471:2094 with SMTP id z17-20020a5d44d1000000b0021d74712094mr3306689wrr.374.1657718186651;
        Wed, 13 Jul 2022 06:16:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/11] submodule--helper: replace memset() with { 0 }-initialization
Date:   Wed, 13 Jul 2022 15:16:07 +0200
Message-Id: <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
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
index fac52ade5e1..73717be957c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1744,7 +1744,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
@@ -1786,7 +1786,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -2563,7 +2562,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct update_data opt = UPDATE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
 
 	struct option module_update_options[] = {
@@ -2623,7 +2622,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
-- 
2.37.0.932.g7b7031e73bc

