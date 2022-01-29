Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB024C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 00:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiA2AFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 19:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351857AbiA2AFE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 19:05:04 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D25C06173B
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:04 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s5-20020a635245000000b0034ea48b7094so4189428pgl.12
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XJbP19Pr81E3mrWX5COP2ScynLKLGVx4M2EBM0Mh6Mc=;
        b=JO80+DS8nnQuCS21DOzvy6NFR8Whft5ptd6F/OOG2pxaTnPDAtWwEe7oELLBL/tzkt
         qxszT2AWugih12M5XJhZmYMExYIRocwQe6+TB1DrB2nG1eAW9swGWiJCcZKheIeMu79r
         IbNfuW/ft5it/LcPnv78vXJNzQMlz0AD4VkEoczAWFKl+q+Gwhjf7YydiuuBwnNw4gy4
         Qa9wxU6pgkLTbPQYhPiyhlIHqO9gLgwBSNmMt/3Az/cdpJNFRHVSb00GPL5oMWKZw+Yh
         i6RC0Jzyw461zHcAyOLd5In0Q/sjHoLav27iYEqJmSxq84XWvbtORJLO5hkHwfWlewut
         E0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XJbP19Pr81E3mrWX5COP2ScynLKLGVx4M2EBM0Mh6Mc=;
        b=v/tmKzddSEZstAqWXb3PyX6pcArpGRFq2v168kIlLYElgzTX9FgoLXtgON3I90+Thx
         kfqTXyLY8aIOofxXHthIrFvN0KI1Dr+Ep8gopJ7sRH1Lc9S6/RthHZe67NlRZhOSLWAx
         U4AR2ZaqXjrxlwFMZvE6qT8u389iRSKGUWdIi5LlmFlmOmMffyf7RsveJDZxxaNv0a/6
         LBuOJgqmQwXJfEaS09PPLDRnjmF9+Br21PGluptZVqiX6H0VLz6bfAIc+81Oty7N/+8/
         TgnoH+GvzYR1zwFobPALJSf1qo1qAWuYxQMsZfhrzkymWTM7FNijY+8ISzvnIClF4yBW
         uz4w==
X-Gm-Message-State: AOAM530ILPtzBAk+ML9d/WqnCwhOvPaaeomJlAh0p2vXRhh/lT/gH6yl
        byJ8ki4CWuBMjS4IHC6S6cM9Bj41qhG9AneumLtHzfqMTvzWGwSVzVVnd5vQXMN23ts5vTdglE8
        EYdmadzHPTSezug2bkbsZ988mLbmxPJhzcLz6ZJppdcMO9PpwNrcIU88e73c8a3E=
X-Google-Smtp-Source: ABdhPJygwtwRg1EaJCVhDIFdW1Kv0hHLwd0DzMYflgAnmssc92dyJOO1HSfnJ3MY9hdVhW4Y9Ze4gFZxGKGhhQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ab5b:: with SMTP id
 ij27mr10799446plb.148.1643414703608; Fri, 28 Jan 2022 16:05:03 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:04:43 -0800
In-Reply-To: <20220129000446.99261-1-chooglen@google.com>
Message-Id: <20220129000446.99261-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com> <20220129000446.99261-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v8 3/6] branch: add a dry_run parameter to create_branch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a dry_run parameter to create_branch() such that dry_run = 1 will
validate a new branch without trying to create it. This will be used in
`git branch --recurse-submodules` to ensure that the new branch can be
created in all submodules.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c           | 5 ++++-
 branch.h           | 5 ++++-
 builtin/branch.c   | 2 +-
 builtin/checkout.c | 3 ++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index df24021f27..02d46a69b8 100644
--- a/branch.c
+++ b/branch.c
@@ -423,7 +423,7 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 void create_branch(struct repository *r,
 		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok, int reflog,
-		   int quiet, enum branch_track track)
+		   int quiet, enum branch_track track, int dry_run)
 {
 	struct object_id oid;
 	char *real_ref;
@@ -445,6 +445,8 @@ void create_branch(struct repository *r,
 	}
 
 	dwim_branch_start(r, start_name, track, &real_ref, &oid);
+	if (dry_run)
+		goto cleanup;
 
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
@@ -467,6 +469,7 @@ void create_branch(struct repository *r,
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
+cleanup:
 	strbuf_release(&ref);
 	free(real_ref);
 }
diff --git a/branch.h b/branch.h
index cf3a4d3ff3..509cfcc34e 100644
--- a/branch.h
+++ b/branch.h
@@ -62,11 +62,14 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
  *
+ *   - dry_run causes the branch to be validated but not created.
+ *
  */
 void create_branch(struct repository *r,
 		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok,
-		   int reflog, int quiet, enum branch_track track);
+		   int reflog, int quiet, enum branch_track track,
+		   int dry_run);
 
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index 62b1a70b05..c6fffb99ab 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -858,7 +858,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		create_branch(the_repository,
 			      argv[0], (argc == 2) ? argv[1] : head,
-			      force, 0, reflog, quiet, track);
+			      force, 0, reflog, quiet, track, 0);
 
 	} else
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1809ac12df..8600860629 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -893,7 +893,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
 				      opts->quiet,
-				      opts->track);
+				      opts->track,
+				      0);
 		new_branch_info->name = opts->new_branch;
 		setup_branch_path(new_branch_info);
 	}
-- 
2.33.GIT

