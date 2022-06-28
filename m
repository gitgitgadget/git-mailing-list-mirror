Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEE5C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbiF1KGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344724AbiF1KGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF582ED4F
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k129so5621050wme.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJ5k3GFPBFeVvI1cBFq2qpGOZiU2oEwih/6AYGTKNyY=;
        b=FsudzEALXNpKRlqnB5L4yQfSklUS5fMKud5XJTGfhAT94sV4YmzqWEjBhwL6bPR8+n
         fj7jeyvM2dt98xV4E7Rd7qY+fpdtlkQiICOCu9l5tAJIDm01BvTm9z9PnNKbHP4drXkR
         5ikmvpQZHsnEU8AYGpPGeWb6jCdQs1twePFtQm6dCa5Y7FSE3ofFJgIuayzuoKnxFl9Z
         7Y9aVwYhdVbKLQSomC0T7s20xMBmSb3IuGT1FgzabebSxJ7k442bx2jOFRpBsUnyru9M
         L7tgqxytjk4aRz7Dwyw+EC63A3q9hqXFu3grOM0QETnpbRGD2YLyaJxAKayXHpQUdFLD
         2GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJ5k3GFPBFeVvI1cBFq2qpGOZiU2oEwih/6AYGTKNyY=;
        b=lt7HXZoLA48EmQI47Cd2mKswJWk+89/7NqEUhrVdMgiLjpzX0JfUP2CaWWGe+BxpgR
         8PeavPgvhoFzpvrEjardhttlKGIUDa0als+G37YktBstjccF0jFdb4VG71Ga4WjWvMjC
         +Vif3dVIXSE0rZYr9PbhU+Z4h7Mupyypb6aoeU81+9waPAuof7t75BHJ048kUae4+jwP
         pGxerKDb2iNLqsv+io6LXPp78ALTBTljzG72agANePd/8rgrM+9mQfFDmrlr34Q3qHkg
         YzTBvoVZbVdB0qp3YShbRYXxYi0+YG17Mt+5ZdbUSyhYd8WAuPfji6vdDhUFbA50hO95
         WQ/A==
X-Gm-Message-State: AJIora/jROzfrKUO8dqit79wQ0DW4lr/lg30WFaFEH2F9iqLw1ttr68F
        OfyxnxvXNBtRDZ6pcIx4sK3AQRUj4Q3R2w==
X-Google-Smtp-Source: AGRyM1v4dGviNSr4cpOHuq383WJeSL60Jqzx+Dqb8Ay5ZI0YIEb5zTIP1nLOLvZthMUtjqZgxAMObQ==
X-Received: by 2002:a05:600c:4081:b0:3a0:47c4:8dd0 with SMTP id k1-20020a05600c408100b003a047c48dd0mr13851166wmh.178.1656410775428;
        Tue, 28 Jun 2022 03:06:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/12] submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
Date:   Tue, 28 Jun 2022 12:05:29 +0200
Message-Id: <patch-v4-07.12-9c8a102acc0-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
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
eventually dispatch "git submodule--helper" directly, as we'd need to
retain this name mapping. So let's get rid of this needless
inconsistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 git-submodule.sh            | 2 +-
 submodule.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0fab3a52e88..10223a00927 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2788,7 +2788,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorb-git-dirs [<options>] [<path>...]"),
+		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -3390,7 +3390,7 @@ static struct cmd_struct commands[] = {
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
 	{"push-check", push_check, 0},
-	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
+	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 0df6b0fc974..1c1dc320922 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -552,7 +552,7 @@ cmd_sync()
 
 cmd_absorbgitdirs()
 {
-	git submodule--helper absorb-git-dirs --prefix "$wt_prefix" "$@"
+	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
 }
 
 # This loop parses the command line arguments to find the
diff --git a/submodule.c b/submodule.c
index 4e299f578f9..2af16c647d5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2374,7 +2374,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		cp.no_stdin = 1;
 		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
 			     "submodule--helper",
-			     "absorb-git-dirs", NULL);
+			     "absorbgitdirs", NULL);
 		prepare_submodule_repo_env(&cp.env);
 		if (run_command(&cp))
 			die(_("could not recurse into submodule '%s'"), path);
-- 
2.37.0.880.gf07d56b18ba

