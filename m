Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E541CC433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588519AbiAXWdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582686AbiAXWPj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:15:39 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F77C04A2C8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:06 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id f18-20020a63dc52000000b0034d062c66a0so9552619pgj.17
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vrmeo+0N5xTuGfudtJmBXuN2U1rFP8aHWOkCNhhsJTE=;
        b=GuuQibZFi4L7ekFQNlUpTaFX2ftnu/7ftQqGeV1/SlXs30ji2OI3loxppKEov3FBCL
         l6ZNruHxXZuCRBjddbTE/FC/R1bPGncoZGc+ZJR/6wPGV3xp3KJwDyZYVi4xrA7ohjJ/
         MYHzJzhDnkpvpmJ+1Rihr9e0wCu3BC4kgM50AhhvSnVaFuErkbagFNoNl0AR27ImPMq5
         XP2l5xN2diufu6zkMhWVlMmE+qiZohHv6Ynk+Le58F6jNYfmeXk6pijUaYDnAGCm/dkQ
         mUNw/7gBG3l6vuCHqvi7hCyvx9/dy5G9PQy2bdBAWUqzKr5PQ3tavRix9dCv643BpyDI
         jHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vrmeo+0N5xTuGfudtJmBXuN2U1rFP8aHWOkCNhhsJTE=;
        b=WWkdMUHp8woo9JIqJB4ab+qbfMVwlhCwnWq7FU02cxeoaC3BvEWj0KW/eJGjtcVTb1
         cJV8Dt4+kRWcXeoG82PmG46fjscpnOvqXkms8eX6KjSBzRI2zrExLkThlXtYbyzXtS4V
         11B8bHhjl/ZHHMcWE+hgzbtZ5sMcWDBfY1KIrZKyYGjF1o8N04Vmm3ermJHis4t1vAi6
         eVIQ5+9td5KdBiC+GkJteDvHhocWFc1YaH2aradQWRm9JCWMeLFQyLFn+JRw4OnqAKyE
         rvozldkp93HnT+HnIPPHlOVT4TjJROwHbSLZmgJ6hY+6CGhytduX7++liSWo0tLj2vWu
         Ojnw==
X-Gm-Message-State: AOAM532FenK2r7j0kVF8f/6+ZH2gGGV0OcVzKxHjX7vCnfGvSWorfktO
        CG84XT+ntSus7B2R/nylCq9FTr8OXDTkqOhV8HWBpVph2jXsF3cWDoc+0Hf8U4dJLSv0l0CA0I6
        MDJIwtyogFJbg3n+DWoI/mzOH0tky/SEXrfIC5TsZoOHjyQCca5aD+uFIE1XDSzA=
X-Google-Smtp-Source: ABdhPJx3GzBubzbj7CwpNc69bnt85eCYI4NK6mbzMYP6KEOxnulKsR1TEZUKYXjo06owcGYLrXSEMC0rWIZpxg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:6901:b0:149:4e89:2d45 with SMTP
 id j1-20020a170902690100b001494e892d45mr15410217plk.22.1643057105739; Mon, 24
 Jan 2022 12:45:05 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:44:39 -0800
In-Reply-To: <20220124204442.39353-1-chooglen@google.com>
Message-Id: <20220124204442.39353-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-1-chooglen@google.com> <20220124204442.39353-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 3/6] branch: add a dry_run parameter to create_branch()
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
index 59768a3f67..d1e3ad6ebf 100644
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
index 8d511aa6b7..fb4323dfca 100644
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

