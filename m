Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63170C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiHUOAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiHUN7j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319F237EF
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r16so10290008wrm.6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OHm+UzAhPsDcKvmhDYIanNczRcyHQqDYfJzKhhcubLg=;
        b=Gea1baNfjMTZ+oNuYTflsXHP2jKQbdudRaWx3tW4btvoFAB/iJpbVCVK5xkcT6kdHG
         oks9oGorn3mJfEIQXbOtErsYq09fDHYNeiL7LqwS6ETr8rwKjLjwft5C73uAVH6e5oFE
         YqiBhb9DGoba0jHj+F/S48vE75Vty9cZezEBscR2PAmSIu+DgbabbYMYZwKevXppQc85
         zebyN7XWR+Wch1rghpenqPKfM7mWrUc2qDjP5IyUqxn4GXyDStmiJnz5g1qmA3D5YuHW
         4vXu+Z8FNybeb1iv0ymJpEoHlbd2gc5+DtHeQMrS4H8UFgsHvxyFehtDXZ4+nIqGzGg/
         GIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OHm+UzAhPsDcKvmhDYIanNczRcyHQqDYfJzKhhcubLg=;
        b=7i8/Qq0lxFdYBSV8l2HaCDoe4rg7K/D8BRw6H98ZBbmAnpeKwIuH+0x5WGsYsvZsd0
         kI7yxY8Cwn07kigKY/xE2I8SG9U2Uz+aF3XMAfxVRzmZOw11D07cf5ysz0j//2/vdtq0
         rRGXIpnFMOPVEblWEe+2aMJd8zW7SelguqEiyz5OpNcd1SeL5A+RKiD7b0KIj8OCHDqa
         UVMxYMdRAon6lfLjtMuWx1hTG4x2C4ErhHzcb3MGhDOu5yLDnUpDTisbaS15HTDyLl5J
         av/2WhZv9KccSek2Ung0u8wVXP2OA5HL0YCozVfdWnIVP+Oh/rysadn82vK4N7RjAbOQ
         QF4Q==
X-Gm-Message-State: ACgBeo3VvHheWbPMOVZnOAj1bbq8coUSZSmBHmkT8DC6itZfsBdN/U62
        Aq6kPW2vZ22fYXuLtarhFuiT9AsmWy/cxUIB
X-Google-Smtp-Source: AA6agR7uq6ukWeMN7zuppwCfoMn48Ciceg038KkWQMO8hepfPDD5jA6KFonX1QnErX7az8GeoBxMqQ==
X-Received: by 2002:a5d:6da9:0:b0:225:59e4:1497 with SMTP id u9-20020a5d6da9000000b0022559e41497mr642794wrs.262.1661090335104;
        Sun, 21 Aug 2022 06:58:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 28/32] submodule--helper: libify "must_die_on_failure" code paths (for die)
Date:   Sun, 21 Aug 2022 15:57:37 +0200
Message-Id: <patch-v3-28.32-6d9bccb34c3-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the libification of codepaths that previously relied on
"must_die_on_failure". In these cases we've always been early aborting
by calling die(), but as we know that these codpaths will properly
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
index 851000ae30e..5f109d422ea 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2245,9 +2245,9 @@ static int run_update_procedure(struct update_data *ud)
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
@@ -2291,13 +2291,14 @@ static const char *remote_submodule_branch(const char *path)
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
@@ -2315,6 +2316,8 @@ static void ensure_core_worktree(const char *path)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+
+	return 0;
 }
 
 static const char *submodule_update_type_to_label(enum submodule_update_type type)
@@ -2390,7 +2393,9 @@ static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
-	ensure_core_worktree(update_data->sm_path);
+	ret = ensure_core_worktree(update_data->sm_path);
+	if (ret)
+		return ret;
 
 	update_data->displaypath = get_submodule_displaypath(
 		update_data->sm_path, update_data->prefix);
@@ -2406,8 +2411,8 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
-		die(_("Unable to find current revision in submodule path '%s'"),
-			update_data->displaypath);
+		return die_message(_("Unable to find current revision in submodule path '%s'"),
+				   update_data->displaypath);
 
 	if (update_data->remote) {
 		char *remote_name = get_default_remote_submodule(update_data->sm_path);
@@ -2417,13 +2422,13 @@ static int update_submodule(struct update_data *update_data)
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
2.37.2.1279.g64dec4e13cf

