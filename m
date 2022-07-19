Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409F5C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiGSUr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGSUr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB4C5288C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so74146wmj.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBorDuxoCTcAkWgtExKJjzM/wxX1DcCqdB8Tb1SfZ0s=;
        b=dJ3vJZngXC8n/PQBETYAlNfRomPpS+XBHTwwLWbhJQILbSm4/UxNdllGoaRshUkvMM
         oQj2AL7wFaOOqxku2C6gvKfqCCEjMNKfmbLER2pkrLub868YFZnlBsJAh0rDrkZwYQAx
         R3fEN7VBBQCBPOz8vwRA1NeGhHdQmadod5Pkj5WnQ1W7MpdyAn1BfZ854yKn2o3HL1SH
         S7nbtXucyD6jN2cHvVXvOzaZziOub0v3I0HhDHYZV+6L3QOcbIouKH8SGxdH+SV5rwrP
         uS9DQcNE4sm4nEKoYUvFpadv9uv6RKS73e+Xc7lNmW2WuIVZRkuehxj9RgZsWKQAI8A6
         rDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBorDuxoCTcAkWgtExKJjzM/wxX1DcCqdB8Tb1SfZ0s=;
        b=UKIgbCUArrLsIcgIG43haJCxZcP7vQyr+NS+N7xLkD/g7C1Ggv8zQWFo2uq3hHjag5
         6aVFhOEHBzKWo2tN0xSVozxN5YMhqy8DBM5bmFyM5o+tmpy674gcjgR0yJPwPHc9Yo9l
         5SCPIQ9sbtO8Em1tLgn+58Z99/5xw0Z2KUNkPhv3kTvpZIHQNuyOce7eM4Lu88Yzu53M
         dpVeuQWno1WXdQaD3t2ypIRrh3CGBCxqlwWIgsQi8e6qbEnDxVoAclX+qP4DJeSkrJ3o
         p+qqsgE7Soxcl4UydhZdEpn624FSx97m8WFdVqkOMtec2J23Bh5SnIhmNRHCuu8Tc98O
         73DQ==
X-Gm-Message-State: AJIora+JZPkH/0gLLiKD6XIzYX1oseibRz0WpQDgZO+fjP8VdeiLyRAy
        wTSiXkLPvzsPevP64CeDQYFiXTJgYh5Kkg==
X-Google-Smtp-Source: AGRyM1tRYY0iOSvv/jhhkpVL6Wae8L87p2L6JmrPrmqhvatpaSvdwmro3fVuheXpVF8fKD3uPHNxrQ==
X-Received: by 2002:a05:600c:892:b0:3a2:fb4c:2381 with SMTP id l18-20020a05600c089200b003a2fb4c2381mr913363wmp.89.1658263645143;
        Tue, 19 Jul 2022 13:47:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/24] submodule--helper: replace memset() with { 0 }-initialization
Date:   Tue, 19 Jul 2022 22:46:52 +0200
Message-Id: <patch-v2-01.24-fcdf4a2e2d9-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
2.37.1.1062.g385eac7fccf

