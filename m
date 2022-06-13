Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9786CCA47B
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiFMWjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiFMWjb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F2BFD26
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso5305650wms.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llp78DBjDQiK10l3Zdlt/SAMPxlgp87p1ulStNFV0jU=;
        b=WoUVre9iBe5gYQrLNyScYUC0rN5MeXX1QZOCbq59MlbQOo12g7avBOdOuJZQaGV1Md
         0Cm4elJst0V6lS05zSyWKq7VPocVPP8//7VDtdP/VAjX0B8i0pExtSai/0rYu7xHCNTv
         o8Hun1AfwLeYamskW7DKhGvLl7TmPHpPGoZHP9s/08Nx4K8h4LU9uvzIufL/LxYL65i3
         94/hRwLsAW0JeozvCF9KZgs6B5hZsPaWjQ5VprWJPBR6VH9kBvxkH8jGf3d/W1CV4ax2
         pazimD7V9sIkqPYZ9WEZU9veKXHF2viYXfTrPJlAmlASkayTTvHfvFTywIzF/YVEbCUE
         1SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llp78DBjDQiK10l3Zdlt/SAMPxlgp87p1ulStNFV0jU=;
        b=7fThEDByVWGsUkpPLS0qp1LZ8j5A+J/K51pnbeW9hDt8MKs++Z5vm/BewK/0xDf3DC
         5y1y20eq5TK2E93DsgafVtN9WXfUK8hSQT5kXlP/rs/CHjU6SiNtCrrVeg6XhwqGilhh
         cYaRu6Qbb4CnKwPDcHhrVQ4KF+yXkALuTYYabw2UoB1UKTtiEgkQrFc2pU3waZl58ZSg
         SB82/pnfW5w1xlXbCFCpQdSrm0aYX3cHABoqi4UGcRPNvLrP1VLSedkNKxSIm0DX8vpR
         pdWITNvtTSLBc7FLbkQuMl0pbPoIIvP10kpula4qzka6334BV0DkRT82XmMWNiWu7Ztr
         2LkA==
X-Gm-Message-State: AOAM532qKeKEtEv3xJa/U9tSNtXkGmGmspaD8kcS1TWZ3tk4qGIhVGPR
        pI/AjmgSr/OlmSjVznEUrmFcmiItKBzueQ==
X-Google-Smtp-Source: ABdhPJy2dueEIZAx2UB0zVDvJEOKLnlNqp0QMzJxqJmms35BJJqHNvVB6wJvoLh++zuJD5Kd9oV4Ew==
X-Received: by 2002:a05:600c:22d9:b0:39c:4b1b:5f99 with SMTP id 25-20020a05600c22d900b0039c4b1b5f99mr891663wmg.151.1655159955494;
        Mon, 13 Jun 2022 15:39:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/12] submodule--helper: report "submodule" as our name in "-h" output
Date:   Tue, 14 Jun 2022 00:38:59 +0200
Message-Id: <patch-v2-08.12-99ac52d810f-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the rest of the usage output for "git submodule--helper" so
that it will pretend to be named "git submodule", which it already did
e.g. in the case of "status", "deinit" and "update".

This will allow us to eventually dispatch further into "git
submodule--helper" from git-submodule.sh, while emitting the correct
usage output.

This does make the usage output of "git submodule--helper" itself
"incorrect", but since nothing user-facing invokes it directly it
makes sense to continue to elide that difference entirely. A user
isn't served by us exposing this internal implementation detail.

This fixes a bug that's been there ever since "git submodule
absorbgitdirs" was added in f6f85861400 (submodule: add absorb-git-dir
function, 2016-12-12). Before this we'd emit e.g. this on invalid
usage:

	$ git submodule absorbgitdirs --blah
	error: unknown option `blah'
	usage: git submodule--helper absorbgitdirs [<options>] [<path>...]

Now we'll emit the same, except that the usage line is now referring
to the correct command run by the user:

	usage: git submodule absorbgitdirs [<options>] [<path>...]
	[.. same usage output ...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 574d6e0a79b..c2f55779cb1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -286,7 +286,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		N_("git submodule list [--prefix=<path>] [<path>...]"),
 		NULL
 	};
 
@@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
 
@@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper init [<options>] [<path>]"),
+		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
 
@@ -786,7 +786,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	const struct submodule *sub;
 
 	if (argc != 2)
-		usage(_("git submodule--helper name <path>"));
+		usage(_("git submodule name <path>"));
 
 	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
 
@@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]"),
+		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
 	};
 
@@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
+		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
 
@@ -1789,7 +1789,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
+		N_("git submodule clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
 		   "[--single-branch] [--filter <filter-spec>] "
 		   "--url <url> --path <path>"),
@@ -2787,7 +2787,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
+		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -2851,9 +2851,9 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper config <name> [<value>]"),
-		N_("git submodule--helper config --unset <name>"),
-		"git submodule--helper config --check-writeable",
+		N_("git submodule config <name> [<value>]"),
+		N_("git submodule config --unset <name>"),
+		"git submodule config --check-writeable",
 		NULL
 	};
 
@@ -2892,7 +2892,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
 
@@ -2931,8 +2931,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
-		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
 		NULL
 	};
 
@@ -2973,7 +2973,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
+		N_("git submodule create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
 		NULL
 	};
 
@@ -3276,7 +3276,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const usage[] = {
-		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"),
+		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
 
-- 
2.36.1.1239.gfba91521d90

