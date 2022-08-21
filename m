Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5E6C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiHUOC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHUOB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A689237C3
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s23so4370544wmj.4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FzH7f+fXHc8SNOOvFTSvJBtpuSNQnqm/+c5isPMwE6w=;
        b=nxM+Hyp2mZWFnHK/5J1v3bcvEfoo3KQvDjzsrg9DXYVwgoxNf9hCv+6UGasem19J1t
         1umTDiqwWIWHIJCs1fSTpg8u+aCYiiYDfxMbVcfVFqTOve4i+9tO+cntzb/7m/ocJ9Y+
         bn9uVMa1cu3prmGMhbYXFXO4GJO/Ko3mcph6qAHUt1QOxw5+oWYvX/NRSApdqrYe9CHo
         /0dqqatpxsbjqthvRM0BzjbIUbW0hUi/I9SjpHnWFD2lqqHKsakX5ddyQ8WHiB65zLM4
         fv1oyyGxA0+UtwX/wEPyILPp613wj2mYZ3Y6Y4J6NwzdrYEgKvp/VsjgWR+FJ23SnoMl
         7LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FzH7f+fXHc8SNOOvFTSvJBtpuSNQnqm/+c5isPMwE6w=;
        b=BNgPAcFKQ0+ZQsK09xx4+Yqm/Lv9fq0n1cgaH36UkF6LlkMwsBa4kdXfmo3vbFMtKV
         A8xtFyTDSdmUjTax4TRzfwcusMTD75kIjsmnJbQEzvrMEUvDyHTLCIijIBUwyQxlNg2a
         gWquBEKDRPQRc80c+uv5/hQwpZGyk+mBT5ZmC3KNOe+nL3rIcMOr4PCu7XtL998sQo7Y
         pwfk/1t3UmzE/hhBm8JewxwDUO1SUR3Vk9KF8YLiSMc7BGQnBwa/Y3fp8Z/JDVvq/jkP
         KZ7rgTqir4CKpz7D4xnm7iHeGSwd3DdDFDXHzWje/YvHCE3lTghdU/EPfZgwBV+Lzj8C
         d+EQ==
X-Gm-Message-State: ACgBeo1W4HxQ+hTDzmEeubHBGxnZUviQhj/a2aW6yHzvuGc4jCEcUNTE
        hmauaPEnv1NAXQRLmW6Ki6H/B8hWCwi33zQv
X-Google-Smtp-Source: AA6agR4KqXVRun6DB7tHmg8W46IFIbrNVlLc3crOaNJCoN0EY+191+TNB+djmKXtI8yp2vIr+JM2uA==
X-Received: by 2002:a05:600c:4e49:b0:3a5:be82:55dd with SMTP id e9-20020a05600c4e4900b003a5be8255ddmr12749263wmq.93.1661090481794;
        Sun, 21 Aug 2022 07:01:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 17/17] submodule--helper: fix a configure_added_submodule() leak
Date:   Sun, 21 Aug 2022 15:59:41 +0200
Message-Id: <patch-v6-17.17-ec0b02d8ee2-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
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
index 070e435b13e..3061943e70d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3168,7 +3168,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	char *val = NULL;
+	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3213,7 +3213,7 @@ static void configure_added_submodule(struct add_data *add_data)
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
2.37.2.1279.g64dec4e13cf

