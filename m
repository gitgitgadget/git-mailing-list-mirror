Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2B7C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiHBP4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiHBPzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:55:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE73E76A
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:55:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so18432784wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AFq5E0FWiVKF0SpC2Az9JyI2621pyfitFki5o9LpTVc=;
        b=jEsNLB5k0crGZCIloUPOippXBG0fZEWDJ+3MTJ66K8jBD5cIMuQXg++2UXj0scNK6/
         Ze6YdFyUsPUKK/ATNUB6Z2T/X4FzkdHT2h4Eks9ZKv6h7gm4eXIaeYIpxJ8txN3zaKnR
         ewl4e9efx7QjdnobyZfapTL1hgRvRpXyk8STFSHPGdluu0kxsfmi/mdXCrZn0p7v1Wmp
         o53K+ey2DTArGG2+CHpEHTPQWp+QJIGvS8+cJetcJ1k1WdRd769gV6R7aFM3dr3Bl5tO
         vzRloYSAWHcYTZM/xs3isX6YYgY2xVKz1//kZkddmlYnEv90Zgx0ZNQLf0pjfvO3/yR0
         O7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AFq5E0FWiVKF0SpC2Az9JyI2621pyfitFki5o9LpTVc=;
        b=e4eYgQP8yFJ1NxVJD2r2gxjrlYS35o/iCM27G0UTZhB6mLjQEynVZqpqWkXnm55x8i
         omJS6tP0sx/5eiuJUKi+sIv0VWy6ZxqtA2TcrP0hzdYNigPwAmlZvh1/UiPEMaWtQoEc
         uAsgpEu83hG2+FLXEmqT4PtQj9TJeZYZHYsPDliuPJACXPggDokkhOL5OIpNXumd2gWX
         110zcVanmE16Uvu/xXq3bZvaGGzMRMdIziKyuscyQtiFCHnFdro2hKVhl+S6bge1L/Ke
         pgks0oOfeRW9qCmv9VJXlr5w/tGMPy76te94J0dttAefQkSqzP4A3oFPPlc8bJJ+FogH
         2PUQ==
X-Gm-Message-State: ACgBeo3AjKx2Bd/48izRFIMYYFAB4LO3ftS5xXIyom9lsWX7jrDLsD74
        GdaWjw/Mpsj9mORX1ynGkRX56nmRV6xuMg==
X-Google-Smtp-Source: AA6agR5toOhUTCep/SB4K5J4R7vypl0blsVC10pMi0G+WO6CB9XBpLMcOFuqgpRlF7Dft9N26ZsXCw==
X-Received: by 2002:adf:f94b:0:b0:21e:46fe:bcdb with SMTP id q11-20020adff94b000000b0021e46febcdbmr13155213wrr.143.1659455702125;
        Tue, 02 Aug 2022 08:55:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:55:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 17/17] submodule--helper: fix a configure_added_submodule() leak
Date:   Tue,  2 Aug 2022 17:54:41 +0200
Message-Id: <patch-v5-17.17-17c77ceba01-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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
index cc8f42ae6df..60757e871e6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3158,7 +3158,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	char *val = NULL;
+	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3203,7 +3203,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val)) {
+	if (!git_config_get_string_tmp("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index ede6f02dbd5..4dc7d089423 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -9,6 +9,7 @@ This is a unit test of the submodule.c is_submodule_active() function,
 which is also indirectly tested elsewhere.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.37.1.1233.ge8b09efaedc

