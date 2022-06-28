Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB99C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344775AbiF1KGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344750AbiF1KG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550FD2ED78
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r20so16938536wra.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLeJQnYqv82yoLR9KK54RSC0KTbCHFAyeRz/NxYaLis=;
        b=Et+MT18qDu6hUSXChgmBo1F6/XW2hu7n1kJMCxZrWlch4VjGqL9eCCCysOZ5X0g5wQ
         GAii2xk3JhyUbyWQ/yptIaN/32mm2B4Z4V13jSWngOOH/Ep+LFs6/22s/3kJ2I3BTVSO
         mbgJ+BlOL1eO6epzne0aJ208hiqUoWKSFZx8f/juya6xVLxbPrercWKa62wXR/6E33sT
         0dyezHN0uY1JHZA6NY4QtU9NCL6VvfzsB2vyumzG90NeofcK+VBUj2b6MCQXLpmmS8Gd
         QtmbSuJ/onUWAVik2jGwoaqe6oa8tfx2Dj8rd5YfJeUkjLem8B65sr/Tmtr/SunHzLRO
         Tqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLeJQnYqv82yoLR9KK54RSC0KTbCHFAyeRz/NxYaLis=;
        b=4HE+7G/YDyNpXe9rrUgjQQK9n+wBUyPVQQ6i7H/GF3XhHN2cUUUgBaCb/2aKvKFCxB
         rmYdu9Glr+1VHaYbiclYpcGk/4YdwQhkld4+7wQyMH7Lf4TJYuut1l8DUP6w5rxxGm49
         QZrbjjuFQM6iskGO/DRJcmr3Og/F+e8TyzAmv5P5HAw5/CLAbc/6/wH5hCnE5Ed/sE3r
         aRlr8G3vUQ83sn4JtzGMqxGG6HEHe88jZsHVwMl4Jr2VK+fTHoqHkFW/8/9ujfOxaH0S
         2llUs3aazJV381uB6TG5sBtV1RFa3LJwNqdvoTEIOPrGhiQNTjr6fbyELNxGK/qIwR/B
         S3KQ==
X-Gm-Message-State: AJIora8qcOYmsCj6kZmNvofiaynhYYStQSvfxEYsODVR7fA2aDpIDz6M
        OmLGTtLaI7fWJ4FaTcCNj8LKpS1Jrgme6g==
X-Google-Smtp-Source: AGRyM1tC5LzsYPUotndROx/FQDRcqdDTz+TcF2SvwT+Cro1T21Mj5QyWI7kaKVj9LYCUa4Q2St5RDg==
X-Received: by 2002:adf:ffcf:0:b0:21a:3cc0:d624 with SMTP id x15-20020adfffcf000000b0021a3cc0d624mr16942514wrs.164.1656410777524;
        Tue, 28 Jun 2022 03:06:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/12] submodule--helper: understand --checkout, --merge and --rebase synonyms
Date:   Tue, 28 Jun 2022 12:05:31 +0200
Message-Id: <patch-v4-09.12-e8ddb95dcbf-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 30 ++++++++++++++++++++++++++++++
 git-submodule.sh            | 14 +++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d145d53addd..e35ae0322ee 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2405,6 +2405,23 @@ static void ensure_core_worktree(const char *path)
 	}
 }
 
+static const char *submodule_update_type_to_label(enum submodule_update_type type)
+{
+	switch (type) {
+	case SM_UPDATE_CHECKOUT:
+		return "checkout";
+	case SM_UPDATE_MERGE:
+		return "merge";
+	case SM_UPDATE_REBASE:
+		return "rebase";
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_NONE:
+	case SM_UPDATE_COMMAND:
+		break;
+	}
+	BUG("unreachable with type %d", type);
+}
+
 static void update_data_to_args(struct update_data *update_data, struct strvec *args)
 {
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
@@ -2583,6 +2600,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
+	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2604,6 +2622,15 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
+			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
@@ -2653,6 +2680,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
+	if (update_type != SM_UPDATE_UNSPECIFIED)
+		opt.update_default = submodule_update_type_to_label(update_type);
+
 	if (opt.update_default)
 		if (parse_submodule_update_strategy(opt.update_default,
 						    &opt.update_strategy) < 0)
diff --git a/git-submodule.sh b/git-submodule.sh
index 1c1dc320922..7fc7119fb21 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -40,7 +40,9 @@ require_init=
 files=
 remote=
 nofetch=
-update=
+rebase=
+merge=
+checkout=
 custom_name=
 depth=
 progress=
@@ -260,7 +262,7 @@ cmd_update()
 			force=$1
 			;;
 		-r|--rebase)
-			update="rebase"
+			rebase=1
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -274,13 +276,13 @@ cmd_update()
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
@@ -341,7 +343,9 @@ cmd_update()
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
2.37.0.880.gf07d56b18ba

