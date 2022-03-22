Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8677EC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiCVRaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiCVRaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 13:30:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B178365E7
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so1308255wrg.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wP6hj1eM5IDvWMDV7fFtEtoYk1XgcQDJMMe99buLEZg=;
        b=KIt3NAMllWU2cTHGFAVcIVp0GVHcpgKnYb5EZtRuagEUr5lAeOreZPgYPAylpCItFY
         st+RPq3gPeCpQyk6IrmNiJxiV3gjALkscTo9oj1aY71dbEFpHfmStRPUiQU1vEBDkFuS
         TN0uVzmp3SngfPDi9R1r7f8ySOuPKTlfeQk6V8UgQOA3fsmQbu0t4SN+eW6WhwahiLNf
         xlvgXJrE9NkYJE/OzPikSMl3TegaWotARWGC58h6oTN8qOSryjQncyLPFZCvGF0lhxk1
         F08kQmkTtBc00Y8KQq/D3PQW0h3mE+S8ztu2sP4z4Lq+4WgP9iqZebtt3XAYCXDxLWsx
         xI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wP6hj1eM5IDvWMDV7fFtEtoYk1XgcQDJMMe99buLEZg=;
        b=yIxJBc0ja56kcny+0reuga3SzY+Df41XoiP7gZJCqtQU1S8OKIpU55D9iXvl4ZI2bu
         TXJLpCOVraHysekhfSWg2rxfYn0+Ok+2Q2I4VF1m1CQsn1MGSLjeQbBDr2zdvlPk9z6S
         JUWo79D3JzFtVkRBbG6R5QxFHDhjWo03KCnrkMT1r89iWOjJBO2GSSGb7SXjRLN4zDZ+
         m/HyEygBrM532Ropbgw7ukOL2Fy7iCUF2jMyWL1K1ZphWI1jNaxeXvSn2N4BzqI0jAwG
         QVMrOZoknc2xFUFmV2N+ncw2361Ad/EE9rWsCM0+xffNSJmRCVw66BfXMFfQckyZRxlX
         XVxA==
X-Gm-Message-State: AOAM532KoQwCXicYymtFwrOj7cv7Erh0GejcfY6q29y78T5OoI3Uarz8
        pw3gpV9/c90B7hBWQjkT4ObQFPChyNo=
X-Google-Smtp-Source: ABdhPJxT/h9rimP806LOOCgubgFeeXYpiCJtzlfFX+aaozP79W9Await8PPyld69QZnmbfB+YFZhWg==
X-Received: by 2002:a5d:5987:0:b0:204:1f21:6a29 with SMTP id n7-20020a5d5987000000b002041f216a29mr5596524wri.716.1647970122943;
        Tue, 22 Mar 2022 10:28:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d64e5000000b00203914f5313sm16184676wri.114.2022.03.22.10.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:28:42 -0700 (PDT)
Message-Id: <619b757d98465dbc4995bdc11a5282fbfcbd3daa.1647970119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:28:36 +0000
Subject: [PATCH 2/5] pack-objects: move revs out of get_object_list()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

We intend to parse the --filter option directly into revs.filter, but we
first need to move the 'revs' variable out of get_object_list() and pass
it as a pointer instead. This change only deals with the issues of
making that work.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 829ca359cf9..f29bef9d0b6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3714,9 +3714,8 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
-static void get_object_list(int ac, const char **av)
+static void get_object_list(struct rev_info *revs, int ac, const char **av)
 {
-	struct rev_info revs;
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
@@ -3724,10 +3723,10 @@ static void get_object_list(int ac, const char **av)
 	int flags = 0;
 	int save_warning;
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(the_repository, revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, &s_r_opt);
-	list_objects_filter_copy(&revs.filter, &filter_options);
+	setup_revisions(ac, av, revs, &s_r_opt);
+	list_objects_filter_copy(&revs->filter, &filter_options);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -3757,13 +3756,13 @@ static void get_object_list(int ac, const char **av)
 			}
 			die(_("not a rev '%s'"), line);
 		}
-		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
+		if (handle_revision_arg(line, revs, flags, REVARG_CANNOT_BE_FILENAME))
 			die(_("bad revision '%s'"), line);
 	}
 
 	warn_on_object_refname_ambiguity = save_warning;
 
-	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
+	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
 		return;
 
 	if (use_delta_islands)
@@ -3772,24 +3771,24 @@ static void get_object_list(int ac, const char **av)
 	if (write_bitmap_index)
 		mark_bitmap_preferred_tips();
 
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk(revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge, sparse);
+	mark_edges_uninteresting(revs, show_edge, sparse);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list(&revs,
+	traverse_commit_list(revs,
 			     show_commit, fn_show_object,
 			     NULL);
 
 	if (unpack_unreachable_expiration) {
-		revs.ignore_missing_links = 1;
-		if (add_unseen_recent_objects_to_traversal(&revs,
+		revs->ignore_missing_links = 1;
+		if (add_unseen_recent_objects_to_traversal(revs,
 				unpack_unreachable_expiration))
 			die(_("unable to add recent objects"));
-		if (prepare_revision_walk(&revs))
+		if (prepare_revision_walk(revs))
 			die(_("revision walk setup failed"));
-		traverse_commit_list(&revs, record_recent_commit,
+		traverse_commit_list(revs, record_recent_commit,
 				     record_recent_object, NULL);
 	}
 
@@ -3872,6 +3871,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int rev_list_index = 0;
 	int stdin_packs = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
+	struct rev_info revs;
+
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -3976,6 +3977,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 
+	repo_init_revisions(the_repository, &revs, NULL);
+
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
@@ -4154,7 +4157,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
 	} else {
-		get_object_list(rp.nr, rp.v);
+		get_object_list(&revs, rp.nr, rp.v);
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
-- 
gitgitgadget

