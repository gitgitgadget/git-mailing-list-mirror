Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D5CCA47D
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358386AbiFVO3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358326AbiFVO2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD672AE26
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m1so15917220wrb.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2EjWq3Agq6Z0VJw+CdSIfM074UWApXcjn2e51VgSCA=;
        b=aRi4CFYsB1EwXJ+j6toZ5wS4FuY5R4HsQYkcc+y+012DIUhevUTwFK6z6vRc8jBlk7
         7QBIsuIUY1Bg82/4bMAjuYqR6IbFxWfXkCqNTOe/6T6Xj8GWgNkJ5pB37WSwHBU/1eWl
         a25F+apuZ5pg1ZvOvmbJwicrwcl1BCz6qEvuyZ4f48mlp+3ns/TFdAgcvM8kORLNmMx/
         /cxc9zYPMuutXOCrtSG4VdqwEeU7qeBMkKlz3ETr/5yJK4EYoiZ6pLcM7rZQwC7djMdl
         PyHVIYobFtBRDllsqfyb9DY++M74diQ3DYHRMlrztzvfGtfwAJDM5gXUlZ/jjS+Gii++
         HvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2EjWq3Agq6Z0VJw+CdSIfM074UWApXcjn2e51VgSCA=;
        b=OB3VRp952KVqTJxyfAGk0lpUgjwQ3zlzY8OJG3WZM4OSx6hYE3TXzkssjQ1tRC6duj
         ZVdoTsF9YK0kJK8fjFQyUctcu7xVqwhNE8LNwIt6Wew2qTExQdDPNySUrVq3JvUYzq1U
         tVg0h9lK5AN7APuWrPREGke3eLDOybOpzE8M32vTwV9EERL0rrcRqt0s/82XN6PJdgwB
         6vu1TveUYmy3dZ1OspwBNKDEHgvM4a2Cb8IUqrYdGhGmR52JKplucyOiauZjH0G7Icxo
         WsQQE7qxzeKi/Nueor3vU3LbGligobaVzrzAMhNojY8AlIAlAtvj/F0lryOQOfG0kJEY
         6dIQ==
X-Gm-Message-State: AJIora/fWLUskkBjgq/h/tl/F302HWd47/q6q/YRk/Iyyol3bvK5GuiR
        cmrszr3mxSOh0z2sTP9vZLc/0RTWIGu8rg==
X-Google-Smtp-Source: AGRyM1vzeLjKrL5z1KlnXl4FW91Kgf7PhgtKxA68AjhdercfPYpeJDhzggz0Wfi+AW97HMcYZElKnA==
X-Received: by 2002:a05:6000:1845:b0:21a:2c51:157c with SMTP id c5-20020a056000184500b0021a2c51157cmr3603348wri.390.1655908100085;
        Wed, 22 Jun 2022 07:28:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/12] submodule--helper: understand --checkout, --merge and --rebase synonyms
Date:   Wed, 22 Jun 2022 16:28:04 +0200
Message-Id: <patch-v3-09.12-e251fc115e1-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
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
index 6af09d78d4b..928b7a948b2 100644
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
2.36.1.1239.gfba91521d90

