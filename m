Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5771EC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345879AbiFJCCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbiFJCBw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09189712C3
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k16so34649882wrg.7
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idPxVm3MrWX38t7tUL3/ybXujWginnzzFX6suHt0nOw=;
        b=e8lu9C6wEhKFPPQ3iiXQO8g+CUTWq+EQ3e7yOJKpOszDwrMxqhn0ZQyqqZJ2w2E/N+
         YU20XB1r2xnGrwZbXfid0Rov8vW2ScpJIzFh46hwUVBBeU86OB5sGD/dwr7eY+4jbb3s
         mwhK6JDGj6zfumxLX/OYWPGwk+Om2rN9ylRgMxw9CyWXbx1P5TQGPH+1VK1r/lqVX50m
         vVQnlm49XDRImqkFs/SQJ0BSKYVIUelYjpiIPaOhrahcLnTLaMuxCsW/oHCQosxLfouN
         BREuNzsyZu3tvwyDvK2erWjkAwmmHuKqzleO5YNKLhzrVXGaBO0t6U9R6v1IkcURWym9
         qpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idPxVm3MrWX38t7tUL3/ybXujWginnzzFX6suHt0nOw=;
        b=d5ZUrOccLLGPpNrFdpQvck3virislgxN1GoMsCPscIwCz5UHRVz6WEiNrpac3C0w5Y
         kEMEMeVy2r85OnpnhDveOn17SnMd8Ax85YlBwa9IjDk/zAcG6UNCovaaussvdO2JLRP6
         cAIkf2ZEc2XNjj76g1U2ul4wr/tQ0O7RgQcp1vx1RE0temN5oBx8J7VmDxblVLv2hrXo
         cQQ6/vECq1P2QB8FZwyV8lNpJMjQgIYKB32/NgFFCfmz5HT1jOqSZ9UzZdLqk7thhNFv
         m5oksJeZP49akP/NvBy11iVt3fyULwX0J7RhWVMwNj3ld6G6ZPilUt3lEP2sERnGGVfu
         I6Uw==
X-Gm-Message-State: AOAM531bQq2kLs3Iqgoeqr24k4jUwCEAic3ta1UhPihakquhcmadKzoU
        t2bEQcGQDP5eVzykzZxSVV1rFsSWaDPCYA==
X-Google-Smtp-Source: ABdhPJzJgbsdEgF2vO6aj5pSAXM+T8NjJY62n8t+ygEU5502phT08Tsi76QfxpcyUKXlYktHE4Vqpg==
X-Received: by 2002:a5d:67c8:0:b0:20f:fcae:57f8 with SMTP id n8-20020a5d67c8000000b0020ffcae57f8mr24375616wrw.262.1654826510314;
        Thu, 09 Jun 2022 19:01:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 06/20] submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
Date:   Fri, 10 Jun 2022 04:01:18 +0200
Message-Id: <RFC-patch-06.20-b1ca1183885-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "absorb-git-dirs" subcommand to "absorbgitdirs", which is
what the "git submodule" command itself has called it since the
subcommand was implemented in f6f85861400 (submodule: add
absorb-git-dir function, 2016-12-12).

Having these two be different will make it more tedious to dispatch to
"git submodule--helper" directly, so let's get rid of this needless
inconsistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 git-submodule.sh            | 2 +-
 submodule.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 70693205764..8df1541baf8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2784,7 +2784,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorb-git-dirs [<options>] [<path>...]"),
+		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -3383,7 +3383,7 @@ static struct cmd_struct commands[] = {
 	{"deinit", module_deinit},
 	{"summary", module_summary},
 	{"push-check", push_check},
-	{"absorb-git-dirs", absorb_git_dirs},
+	{"absorbgitdirs", absorb_git_dirs},
 	{"is-active", is_active},
 	{"check-name", check_name},
 	{"config", module_config},
diff --git a/git-submodule.sh b/git-submodule.sh
index 20fc1b620fa..70258eaf38e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -556,7 +556,7 @@ cmd_sync()
 
 cmd_absorbgitdirs()
 {
-	git submodule--helper absorb-git-dirs --prefix "$wt_prefix" "$@"
+	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
 }
 
 # This loop parses the command line arguments to find the
diff --git a/submodule.c b/submodule.c
index 7923e951e1c..9129cd564c8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2374,7 +2374,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		cp.no_stdin = 1;
 		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
 			     "submodule--helper",
-			     "absorb-git-dirs", NULL);
+			     "absorbgitdirs", NULL);
 		prepare_submodule_repo_env(&cp.env_array);
 		if (run_command(&cp))
 			die(_("could not recurse into submodule '%s'"), path);
-- 
2.36.1.1178.gb5b1747c546

