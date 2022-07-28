Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BFC19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiG1QbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiG1Qaq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA57C51A02
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i10-20020a1c3b0a000000b003a2fa488efdso611118wma.4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=F0AE1Nr1A1Q4KOqDig4+oZGp4SBwgDu4v/4lq5j1fbI=;
        b=loVNygnn7rxncsWo3Du40G7tMcWt1TebAHd9dtY0OOecZf692iy4IKT5FpXUkTCgO/
         RIy+P/WrVAP1Mq8rGkBPiFG1V/QbQqBzbxl9ToGQQH2PuPt8ecUlfs4yZsm9pO9RjoCY
         KZv5+PLh13p4OIJ45tR08/jfxhw27rETI/r0Bv2rS2TFVvsoHOrykvoki7mhu1jAP9vs
         Z+bTpLVmMO01lcy3fejpa/+KLx+HY4IYiNaX9DRBZSWJqQNEC6uFXdNmYuqgHsRWoBAH
         nx1AlRcOUTd9uMVyGJ3BF4XWLoH2F6Qtwoyo12Cnb25E5mWeSGDc7f3yR467ssu0g8H6
         1QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=F0AE1Nr1A1Q4KOqDig4+oZGp4SBwgDu4v/4lq5j1fbI=;
        b=RxhK9d3z4/8SQP+OGHfJ8Iin3DkJvd3iAd6hQmeivPAJCMirBQUUnhC76KADdXuo6A
         GF8HHUJOmJgyHy1GDCif2Rurn9MG1dVYfiSAF5ID6p4hz2SouU4BC+ogY2q1/Ct3mjwH
         8lJEoz5uEfx96AQ/FfFFua/LocH9zSx/9Vtmfr23FnEzKlaQYMhE7Mci6z1kZa2izGuk
         BejMprQ1aNszRSLGLDs7BBg+axF6Dobw9Fh714rTjGbDEc528ATWOPZF9G+cVhqNUNWj
         uzAV/VxBLOmyvFbRz0a6P+28sIH1Lqpsy8NvWnVuJKH6rdTOFg3EZj8i0kf1kqMY+HW6
         KsYw==
X-Gm-Message-State: AJIora9LoxiCrLyTM2nj6ubZApfZv383GqfTtSK5YuibEDVP5GTSOitB
        HRQxjEdsuwvjUIZavXnZhKH8zZOCIQ1a7w==
X-Google-Smtp-Source: AGRyM1t2Jxt9X4BqjDsmk/tvTNmaNx703cAtTt0viodi8v0UedjxdMDLrwwYaO87hYgU6HY/FGmjTA==
X-Received: by 2002:a05:600c:3ac8:b0:3a3:63ad:d53b with SMTP id d8-20020a05600c3ac800b003a363add53bmr159101wms.104.1659025835983;
        Thu, 28 Jul 2022 09:30:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/17] submodule--helper: fix a configure_added_submodule() leak
Date:   Thu, 28 Jul 2022 18:30:11 +0200
Message-Id: <patch-v4-17.17-95f8b68bd41-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix config API a memory leak added in a452128a36c (submodule--helper:
introduce add-config subcommand, 2021-08-06) by using the *_tmp()
variant of git_config_get_string().

In this case we're only checking whether
the (repo|git)_config_get_string() call is telling us that the
"submodule.active" key exists.

As with the preceding commit we'll find many other such patterns in
the codebase if we go fishing. E.g. "git gc" leaks in the code added
in 61f7a383d3b (maintenance: use 'incremental' strategy by default,
2020-10-15). Similar code in "git gc" added in
b08ff1fee00 (maintenance: add --schedule option and config,
2020-09-11) doesn't leak, but we could avoid the malloc() & free() in
that case.

A coccinelle rule to find those would find and fix some leaks, and
cases where we're doing needless malloc() + free()'s but only care
about the key existence, or are copying
the (repo|git)_config_get_string() return value right away.

But as with the preceding commit let's punt on all of that for now,
and just narrowly fix this specific case in submodule--helper.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c    | 4 ++--
 t/t7413-submodule-is-active.sh | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2a171d25992..a3e00c9929d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3136,7 +3136,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	char *val = NULL;
+	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3181,7 +3181,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val)) {
+	if (!git_config_get_string_tmp("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 9ead083371a..a3c824c3e4b 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -6,6 +6,7 @@ This test verifies that `test-tool submodule is-active` correctly identifies
 submodules which are "active" and interesting to the user.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.37.1.1197.g7ed548b7807

