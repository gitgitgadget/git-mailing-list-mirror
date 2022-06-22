Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8718CC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiFVO3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358319AbiFVO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A2C73
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r20so3256759wra.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yY80mo80QYxEl700sZJC+g5paQKllyzqYNBMmUnyICs=;
        b=MFuZ8+VDXdmyPSd2VD36EPrkBm8UI9KQUszSZOW1RIdN8I+MFYSmskYJ+R+IuqM1qa
         EzFIhigflrQ+L5urcZnGmu6LWHt02wYh6PaOe9eTWSGBMuH2nDtQQhD/v9HqC+Ge7lQW
         s3KHu+IF5rGNQZmAtWOQ6j1KJljcZwMFF6DsVo4ghYR3mX/RJinlGOf8RLpp3+5e4UDH
         cHuxwSaGVmsRnIS1cLtlcg0CIc8neHo9/ZWKkgSzIrLuRTVjZ+gXaCkOyjLrds6h7tCg
         6JAPcWAEegS6L2gVXVIBgHAMmCk5tsD6aakOx66M+IG7tfpPL9xpFzPKIL311R2U5SGv
         lFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yY80mo80QYxEl700sZJC+g5paQKllyzqYNBMmUnyICs=;
        b=pB8HediAIIhBrtGuyoyFbSvWfgOU+ypApXWBGO1aPra38pUY2jsQ61ElK6881Mzb7V
         YKfEWVNAgML3qmdMpnzDEf8/2diXLsfq2u1tiyePHMzooXe+4JHoMLls3BsYeOATbWx3
         pw5nU5osYaq72gqZgfwJGxQfVzyJ1kJ6pvp0STPlATbuh8jZpSXiNgBB9J/cUsC5ztiV
         ClHZmSGJt7k8CjC4/ot8CDGeVf09E1TQDGgrrtkIXo/HBbCS5DURyw/c9ZThPsAYj2t2
         Uz5sGDH3NDH0RJX9Bi6+MdIiYwx0FEXh1QftDXXrFhh6ZmUBrQmKDo3NhfNbdMXNWNkW
         WbDw==
X-Gm-Message-State: AJIora/co1pTRUJ4sMvVrc0yq1tqg8iOFXE2ttqQk7hXDIXukn93j4VL
        uN11wx1YH+/dqnuS8pqX6TAW44sf9TrZMg==
X-Google-Smtp-Source: AGRyM1uxOihJ4qFq8sbHBFNh6itI6T33Lb5xe7CTYI5vqTYdCLTrASaz+k8yErNlqJvqWgy+o2kOoQ==
X-Received: by 2002:a5d:4c8a:0:b0:21b:9f3a:c002 with SMTP id z10-20020a5d4c8a000000b0021b9f3ac002mr3696396wrs.182.1655908097917;
        Wed, 22 Jun 2022 07:28:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/12] submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
Date:   Wed, 22 Jun 2022 16:28:02 +0200
Message-Id: <patch-v3-07.12-ff557f3c81a-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
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
index 1876375a4a0..a298d8d0c12 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2788,7 +2788,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorb-git-dirs [<options>] [<path>...]"),
+		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -3387,7 +3387,7 @@ static struct cmd_struct commands[] = {
 	{"deinit", module_deinit},
 	{"summary", module_summary},
 	{"push-check", push_check},
-	{"absorb-git-dirs", absorb_git_dirs},
+	{"absorbgitdirs", absorb_git_dirs},
 	{"is-active", is_active},
 	{"check-name", check_name},
 	{"config", module_config},
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
2.36.1.1239.gfba91521d90

