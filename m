Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2423C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 00:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhLPAch (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhLPAcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 19:32:33 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DCAC061401
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:32 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w5-20020a17090a380500b001b112521410so1161264pjb.8
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VEFj5F+EgESg4k/2x0zAwxT5jP+e+xKO7PrEjgzOGrQ=;
        b=OgsvQNMA4kh4d51cjTBeDYg9wC+IVRz67shQ2U0tzIuOH3U34SCq6Iuwa7NNgKmODG
         V9GG0rbC6cmDRhE2A8+Ysk7A5dvdw0qFTVkNkUV5fM8dmAVyLxPc+P3wntVHjBk1U9SR
         zF8G57cUgyr8noT5FkBw9oTwSsfMd7KewMiCcUXyTGs1AEw1LFD4GDHohwA04AnZt0zL
         Kt2yEiwKyKvcIsV8fkvz+Iy30nLL/Yb//xycg44j6NA3z0m7Y+mM7osr0blU9A9l/4PC
         bUmDDFm7wl4oPpTbuabZ/AFkimqJvBgYosDh9x2QVDLY0n49XkheC+iWil/1Gpzw/QJM
         zjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VEFj5F+EgESg4k/2x0zAwxT5jP+e+xKO7PrEjgzOGrQ=;
        b=CL91zUgIXu7RfnmCiRhaNqeRHts9R3P6KgvO2YFTME+24HMvO3ANicaxtQJLL7EXfk
         l3aY89f9IRJHqUySjZdnNCij/KyPJ88p/16vUaaaUD4mlK4K7JPL0bF/bpGBRwS6Xjdn
         oi1ZyO/iGjMb20BzboIBOXrlwXn0P3+JyGzd28RviEYQjLB9ul33EcdHDaxAI526kgA0
         8eQJp7Ef8RXXflFIxYWmivIRdG0YdN1byYHEUc2ZLxJkFOGRl2TtlG9oJs46f3HHRmN+
         o3S7pGTsET9zJWKq+/dV1CAjvDcd7siXCdw3TiTxflkmVS2GytgN6NJ8g+t4KA3TczZL
         WhqA==
X-Gm-Message-State: AOAM530f1PSgp6oZYe3gU8xGcuocAJH6He0loXoyTNRRU1QxhwchNpHo
        5mKgrJLphgklQEfeWId680LV6QL2k9KYhdPrkejGw349BuDtxe8N9eTi18jfl3yO/0EXcR5LBxW
        jDU9fUaafZ5a/zh5oZdmltHH9s86uBJsEV8qgcVCTDN7XPQYXg3KXwo8UBHpfUG0=
X-Google-Smtp-Source: ABdhPJzwFdAZJcpu6TJ0z6VJm9aqfLjVdjUUxJv2I9PGSUpbe2BiJALK6kJ/gv+Va+TuyD093JlPLKTSNNFYHA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:e904:0:b0:4a4:b4e3:a712 with SMTP id
 j4-20020a62e904000000b004a4b4e3a712mr11442224pfh.25.1639614751821; Wed, 15
 Dec 2021 16:32:31 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:32:11 -0800
In-Reply-To: <20211216003213.99135-1-chooglen@google.com>
Message-Id: <20211216003213.99135-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-1-chooglen@google.com> <20211216003213.99135-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 3/5] branch: add a dry_run parameter to create_branch()
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
 branch.h           | 9 +++++----
 builtin/branch.c   | 2 +-
 builtin/checkout.c | 3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index f8944d3117..bcaac0ac5e 100644
--- a/branch.c
+++ b/branch.c
@@ -415,7 +415,7 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 
 void create_branch(struct repository *r, const char *name,
 		   const char *start_name, int force, int clobber_head_ok,
-		   int reflog, int quiet, enum branch_track track)
+		   int reflog, int quiet, enum branch_track track, int dry_run)
 {
 	struct object_id oid;
 	char *real_ref;
@@ -435,6 +435,8 @@ void create_branch(struct repository *r, const char *name,
 	}
 
 	dwim_branch_start(r, start_name, track, &real_ref, &oid);
+	if (dry_run)
+		goto cleanup;
 
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
@@ -457,6 +459,7 @@ void create_branch(struct repository *r, const char *name,
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
+cleanup:
 	strbuf_release(&ref);
 	free(real_ref);
 }
diff --git a/branch.h b/branch.h
index cf3a4d3ff3..8009266343 100644
--- a/branch.h
+++ b/branch.h
@@ -62,11 +62,12 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
  *
+ *   - dry_run causes the branch to be validated but not created.
+ *
  */
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok,
-		   int reflog, int quiet, enum branch_track track);
+void create_branch(struct repository *r, const char *name,
+		   const char *start_name, int force, int clobber_head_ok,
+		   int reflog, int quiet, enum branch_track track, int dry_run);
 
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index 16a7e80df5..9b300cf42f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -859,7 +859,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
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

