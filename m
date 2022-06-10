Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2946C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbiFJCDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbiFJCCb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F017CE5CE
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q15so26596898wrc.11
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efHOzyjZ950i3UiKV6jUtbv/GdRv7QNPcTNCpJRrfmU=;
        b=kaDy9a+7gBQJ4ktO6oM/tEE820GHiog2/g7uHdk6pjo7LfAraIVbdQKU05dzD3syTy
         WG/Nt+KopkdSw4UZKENss3HyDxllL6jG+s0GbQhi/kaE1HoE3b2wwONFfDVkKQFbq7t0
         9BUf1Hw9kciKCIEVFBZsV88jRr8AnaAJuPkzXTfH/5DkSD657M2gp4R2d1wXOSR5Jtd2
         FcYxpFr7yGzWfFk7uazvri6qsdtLkQt7OKwpIGPkEvUlLewdirSIGH/969MRYAnE+4gv
         CTswtL+ymNZ3zN+kpAlI2dCOcG4Tej/mezcYcIVTPXNPUYUmfttFnBd4DdvTehFhvrrj
         BR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efHOzyjZ950i3UiKV6jUtbv/GdRv7QNPcTNCpJRrfmU=;
        b=5tBhZ96KB6T7tlFgvoHOkwKyOgvkfqGFa80NvWr9h2XrLQrZA9EvHx40f/5+CWAkte
         E9D2iyP2dLahaqVeV1lmvr2tPHelHN8HQCiga/yvnBJpSQJAne0dfCpeB+zRvk+qmsPN
         63wdXH58J2p+sH0J3527fCDtLKSNSm1JrvNL66WI4JlBm29TOFns2kbJHpaX5ET1s1hF
         GqmzWuKnvDsFvr+fLnaC5kbLIOqsO4bOF7nyshSnzPTeylSCihEVSnO4ilX/aKrdAOxV
         yoiDvi3giIKQcaPEzjMgdMd8qCLJzYv07xOmwpMu3M09lxI/uy0/haVvVbSTvlc2EWWM
         kpVA==
X-Gm-Message-State: AOAM533HVcajnDHHd/WSlhwfuALTdzb5BsZLSlSF6slacz2D5c5xC11/
        v36SoJgLSnWiFTUZUOYsMT5n7ZCfa2CPpw==
X-Google-Smtp-Source: ABdhPJz2sDRorYXZeCrNo3Jsag2EBzQl1H9lRXHHBcL8CW0JGnw/EynZpZF8ZNYLQn+z+gHyeW7KEQ==
X-Received: by 2002:a5d:47a1:0:b0:218:423c:8448 with SMTP id 1-20020a5d47a1000000b00218423c8448mr23327480wrb.199.1654826518804;
        Thu, 09 Jun 2022 19:01:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 13/20] submodule--helper: understand --checkout, --merge and --rebase synonyms
Date:   Fri, 10 Jun 2022 04:01:25 +0200
Message-Id: <RFC-patch-13.20-20db979a094-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Understand --checkout, --merge and --rebase synonyms for
--update={checkout,merge,rebase}, as well as the short options that
'git submodule' itself understands.

This removes a difference between the CLI API of "git submodule" and
"git submodule--helper", making it easier to make the latter an alias
for the former. See 48308681b07 (git submodule update: have a
dedicated helper for cloning, 2016-02-29) for the initial addition of
--update.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 17 +++++++++++++++++
 git-submodule.sh            | 14 +++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1f5c6b84c6..64d7c5d7ba4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2583,6 +2583,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
+	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2604,6 +2605,15 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
+		OPT_SET_INT(0, "checkout", &update_type,
+			N_("use the 'checkout' update strategy (default)"),
+			SM_UPDATE_CHECKOUT),
+		OPT_SET_INT('m', "merge", &update_type,
+			N_("use the 'merge' update strategy"),
+			SM_UPDATE_MERGE),
+		OPT_SET_INT('r', "rebase", &update_type,
+			N_("use the 'rebase' update strategy"),
+			SM_UPDATE_MERGE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
@@ -2653,6 +2663,13 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
+	if (update_type == SM_UPDATE_CHECKOUT)
+		opt.update_default = "checkout";
+	else if (update_type == SM_UPDATE_MERGE)
+		opt.update_default = "merge";
+	else if (update_type == SM_UPDATE_REBASE)
+		opt.update_default = "rebase";
+
 	if (opt.update_default)
 		if (parse_submodule_update_strategy(opt.update_default,
 						    &opt.update_strategy) < 0)
diff --git a/git-submodule.sh b/git-submodule.sh
index 43fe3bcb00b..d8abdd8e8ad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -38,7 +38,9 @@ init=
 require_init=
 remote=
 nofetch=
-update=
+rebase=
+merge=
+checkout=
 depth=
 progress=
 dissociate=
@@ -83,7 +85,7 @@ cmd_update()
 			force=$1
 			;;
 		-r|--rebase)
-			update="rebase"
+			rebase=1
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -97,13 +99,13 @@ cmd_update()
 			dissociate=1
 			;;
 		-m|--merge)
-			update="merge"
+			merge=1
 			;;
 		--recursive)
 			recursive=1
 			;;
 		--checkout)
-			update="checkout"
+			checkout=1
 			;;
 		--recommend-shallow)
 			recommend_shallow="--recommend-shallow"
@@ -164,7 +166,9 @@ cmd_update()
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${update:+--update "$update"} \
+		${rebase:+--rebase} \
+		${merge:+--merge} \
+		${checkout:+--checkout} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
 		${depth:+"$depth"} \
-- 
2.36.1.1178.gb5b1747c546

