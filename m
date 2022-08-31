Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46DAECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiHaXQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiHaXPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:15:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8590C286F3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so7457197wrq.10
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=m2wIJ+eMldhmzxDpylakTSu8nlttM2dDEYwKo5tiRdA=;
        b=a61+gZ42Sj2RGR1Qef7dgcrR906oS4bkmRERnxBPTe2wDy/T4E1naMoSQu2cl34U+H
         yHdnhMWzqFlhy9q/evHHyITsz+TVPYs0RaInymouGdN+4q9sKQ4EFu4agudTYuzh0dap
         aLV3cSBaia8HGMYPIHq6x8ODh1r13pyQ1OjcV/S3DX5+gTy3uRLSIvbzVc/BjpRFyfIF
         I3RkgVdSSfAzZjZJ0NczaEOodegad0dvGVjNb1zS1BwyUmWqGg7WYFZT1skgJ2YhMXcJ
         /wDl4KATOOCL3Lwq0SCi+W1fGhZZDkvUop54a+g97d3R5QVU4tuF1t40VuHf4hBR3g1i
         2gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m2wIJ+eMldhmzxDpylakTSu8nlttM2dDEYwKo5tiRdA=;
        b=QVtXVhUn3xjpYbnNO3jVk57ez0HR5xfgCpFt4OhXtpBBcUmtACSNYmizlle7XXvNSK
         4Gn8/EmJzv5BVDIYbj9W0BlIPMUlyJ+ZonQ9fEf+CES1c+Kn9nMeMeJSyix+QzFoRRq4
         WGefiIX6FjhJRjKCoGn+xeUtgeshkBcLuE6h45wSEJibgnPRESeX0bcYeJxtYEjbTQiF
         UoK72Toj6o2b2cmG3ESaCtpXi4T6Fku0gjrsw1XI69bSYMhViBXg1xk9jNidRYYDRKEG
         Yhx2X3IE4to0DJS7fVF7u58bkEgiHcaqL52/lq6DhtIgHMZa3PQ6MA3UbHnZEcOJWb6H
         L+nA==
X-Gm-Message-State: ACgBeo08/ffpGH99zLbpJu9vvdFA88odX10jkq885siHXPETDiKtJ4VO
        BmtowgvZQeBTVGtR3y2RlK3OB2FEQ7d0JA==
X-Google-Smtp-Source: AA6agR6NOmSCQmKIVazAqBrSFYAaxDkt9/CYlEgXEAiu771c/f4vCerF9Rl2xze+ybVJ7d/sqYOx3g==
X-Received: by 2002:a5d:5847:0:b0:220:9a9c:d819 with SMTP id i7-20020a5d5847000000b002209a9cd819mr12619606wrf.643.1661987701587;
        Wed, 31 Aug 2022 16:15:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:15:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 17/17] submodule--helper: fix a configure_added_submodule() leak
Date:   Thu,  1 Sep 2022 01:14:24 +0200
Message-Id: <patch-v7-17.17-3056bfcf607-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
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
index 1650bf0070b..37b6db5cbb4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3160,7 +3160,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	char *val = NULL;
+	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3205,7 +3205,7 @@ static void configure_added_submodule(struct add_data *add_data)
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
2.37.3.1420.g76f8a3d556c

