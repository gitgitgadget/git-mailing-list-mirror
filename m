Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DFBECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiHaXTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiHaXSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5709BFB0E7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b16so12509569wru.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ey7RZ3n/NNCC3mghYHrYzQHuAt1guOeZ82/2Y0XEeqo=;
        b=CfZn8DH/QPYjji3qP0WOOQNbsOVbDapHO2S4UYEcAfUoOfAaihvAiLX0+gRMfr6Y9M
         H2iejDZ+CG4BCcDsq/TSwhrFWbUvkarqI6vBmd86JKhmBGDk6u2+54INQP1nsxfj/5Io
         2npcw2D6hQIGU9+4hpalz7K5LNg5QMXVg9Kruy8c89zOc4pd3+KzuJBRLFwLXQWJmdK2
         ekjzlownrKb6BIk3coh8Se/xQevyCl6hzuGFwDB1fcWqVw5smkT475oHdtPjjaDz7RUq
         zIGNlgGRWzin/qG87xz+/LYLBWrwA9sIaq7o9QkHMKB9aqBihAhCwsrMTEbYwq6EiVug
         TylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ey7RZ3n/NNCC3mghYHrYzQHuAt1guOeZ82/2Y0XEeqo=;
        b=ROMkVxIiOYK83L7Rk1H9HwiNk86Kf5IEpc4vCdGn5+xAsxf3++AQuu7JoyBH+98sMp
         guE5rjKVIzT1Nb2Wmo3kXzZfSbhHneYnS89hrfk6DOIP9gsQWnwVEgFQPHUmxIQU9czL
         YWk7U1skHo1K2HuAnoCURkRIvUKDhlknozyUqHO6bAX/zLR0yZ9Zt4TGe1Q2CgY/59VR
         j6UtBaV+8lsbkhKNqo82iPY6EBtv/pMKHo9PUCtJuik+jQBtJJDQ2c6te9PG26jCy6NW
         rP3vRqFXeERykZj2aU/JIMaLinLV0ioNOnsJ/uyhILfC6fFuoiNdpNDlvbih+ExjzqHC
         44ng==
X-Gm-Message-State: ACgBeo1o9GEnY9b7vI85KDjKVolkNnMgqmCv1CCa88xObV9og3qWcAE3
        eKT5+YtKBPnhlLQJopouIwc0XCAdWXTAnA==
X-Google-Smtp-Source: AA6agR4G6U5mtiMG9yehNQPukeCtsk61qE87ygqej+D9+xwzhWhXI4pWuk8cUSO6SAgn2yF7vGbVJA==
X-Received: by 2002:adf:d1e4:0:b0:221:6c37:277e with SMTP id g4-20020adfd1e4000000b002216c37277emr13392841wrd.498.1661987923585;
        Wed, 31 Aug 2022 16:18:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 29/33] submodule--helper: libify "must_die_on_failure" code paths (for die)
Date:   Thu,  1 Sep 2022 01:18:11 +0200
Message-Id: <patch-v4-29.33-a283ae61e6e-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the libification of codepaths that previously relied on
"must_die_on_failure". In these cases we've always been early aborting
by calling die(), but as we know that these codepaths will properly
handle return codes of 128 to mean an early abort let's have them use
die_message() instead.

This still isn't a complete migration away from die() for these
codepaths, in particular this code in update_submodule() will still call die() in some cases:

	char *remote_name = get_default_remote_submodule(update_data->sm_path);
	const char *branch = remote_submodule_branch(update_data->sm_path);

But as that code is used by other callers than the "update" code let's
leave converting it for a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4252b6d864c..b99fb7a244e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2246,9 +2246,9 @@ static int run_update_procedure(const struct update_data *ud)
 		 */
 		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
 		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
-			die(_("Fetched in submodule path '%s', but it did not "
-			      "contain %s. Direct fetching of that commit failed."),
-			    ud->displaypath, oid_to_hex(&ud->oid));
+			return die_message(_("Fetched in submodule path '%s', but it did not "
+					     "contain %s. Direct fetching of that commit failed."),
+					   ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
 	return run_update_command(ud, subforce);
@@ -2292,13 +2292,14 @@ static const char *remote_submodule_branch(const char *path)
 	return branch;
 }
 
-static void ensure_core_worktree(const char *path)
+static int ensure_core_worktree(const char *path)
 {
 	const char *cw;
 	struct repository subrepo;
 
 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
-		die(_("could not get a repository handle for submodule '%s'"), path);
+		return die_message(_("could not get a repository handle for submodule '%s'"),
+				   path);
 
 	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
 		char *cfg_file, *abs_path;
@@ -2316,6 +2317,8 @@ static void ensure_core_worktree(const char *path)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+
+	return 0;
 }
 
 static const char *submodule_update_type_to_label(enum submodule_update_type type)
@@ -2392,7 +2395,9 @@ static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
-	ensure_core_worktree(update_data->sm_path);
+	ret = ensure_core_worktree(update_data->sm_path);
+	if (ret)
+		return ret;
 
 	update_data->displaypath = get_submodule_displaypath(
 		update_data->sm_path, update_data->prefix);
@@ -2408,8 +2413,8 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
-		die(_("Unable to find current revision in submodule path '%s'"),
-			update_data->displaypath);
+		return die_message(_("Unable to find current revision in submodule path '%s'"),
+				   update_data->displaypath);
 
 	if (update_data->remote) {
 		char *remote_name = get_default_remote_submodule(update_data->sm_path);
@@ -2419,13 +2424,13 @@ static int update_submodule(struct update_data *update_data)
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-				die(_("Unable to fetch in submodule path '%s'"),
-				    update_data->sm_path);
+				return die_message(_("Unable to fetch in submodule path '%s'"),
+						   update_data->sm_path);
 		}
 
 		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
-			die(_("Unable to find %s revision in submodule path '%s'"),
-			    remote_ref, update_data->sm_path);
+			return die_message(_("Unable to find %s revision in submodule path '%s'"),
+					   remote_ref, update_data->sm_path);
 
 		free(remote_ref);
 	}
-- 
2.37.3.1420.g76f8a3d556c

