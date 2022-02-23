Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E4C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiBWRzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbiBWRzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF572736
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o4so4154942wrf.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sclOhVe4EV0U75UTToLOlsrVExWmGOlFRPY6iEbDWEo=;
        b=P7/Ldv6SIGiLL/RkC2BsSyBD8I53ombjUL2gk3i6bdVFABaXCRcprclDkvYCVW2rTM
         bQjOiOe0AJTwDYzPrp7FCSEXyjbd2ur1G+DJsI21N2XjIIaRgCnUKFoWS8uWAVp7c0Od
         K2Qu7b7Nbx6hUItPjhwDUX8mflvwrPLhGc8iL5QHaOPBB9BMxoBXT2W9XO74dMx7ijhv
         M19ZYJM+s5FXcGLB3oOP6GFJiNqoQNhvLtTVzt9eFHZE+XZdOprnZd9AJL6GMOgJYLa7
         pZ65WX/IYgQ4hyv5lbXU6z5myupO/NKGTdO3JxgmeHz6IfdVpji5Xx28OnJZXwMl1QRh
         esaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sclOhVe4EV0U75UTToLOlsrVExWmGOlFRPY6iEbDWEo=;
        b=jqcmSkSeizWtFI0Vuq2I5jmrTrsum5DvuAXYorMtgRpbTB2EjnW5cm3XXL28vbV+0V
         iIVf54DxZhFg7uCcGthdFpomYmdcEOKWiNn5TvYnNegO9I+8/ALb8NFxXUActRylovUM
         PGN0u/HNYFIoiixmbDj94p4R13OWVe8XAzhzCq71M/Zj/03YSSmaqS6SetGD9C1Za2X5
         qzre9eQqFHhOvn2nbnbsdZa+1n1LspPdM6wgqXLZJV8wnreCbf0p1bvS+SQJKz4P1Hur
         lw+aT97Vq8FTe5KS5v3vfhxuCwz4EFmREZYGsP7qYp1KUuET5E4+X5cLrrheoevgik6o
         5DSA==
X-Gm-Message-State: AOAM532gRlLaKmnH7afzs8qNJv2r5HyGF/ud9iq/ZJ+7u2CIk0cI+P3k
        pW7fbO3JUrLufM0DkGkTlHG9ouxKAQ0=
X-Google-Smtp-Source: ABdhPJx+8dniDZ1+YE/x2pCysORcPY3ilVJTygA7paGBkVKg1pLPVfK678pR7FA2Xr+GQJsZwhS8Nw==
X-Received: by 2002:a5d:6da7:0:b0:1ea:78a4:8e00 with SMTP id u7-20020a5d6da7000000b001ea78a48e00mr555265wrs.129.1645638915315;
        Wed, 23 Feb 2022 09:55:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm211506wrn.67.2022.02.23.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:14 -0800 (PST)
Message-Id: <3a88c99d9bc765bf4728fe0f0df1eed86adace0e.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:02 +0000
Subject: [PATCH 02/11] revision: put object filter into struct rev_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Placing a 'struct list_objects_filter_options' pointer within 'struct
rev_info' will assist making some bookkeeping around object filters in
the future.

For now, let's use this new member to remove a static global instance of
the struct from builtin/rev-list.c.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rev-list.c | 30 ++++++++++++++++--------------
 revision.h         |  4 ++++
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 777558e9b06..6f2b91d304e 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -62,7 +62,6 @@ static const char rev_list_usage[] =
 static struct progress *progress;
 static unsigned progress_counter;
 
-static struct list_objects_filter_options filter_options;
 static struct oidset omitted_objects;
 static int arg_print_omitted; /* print objects omitted by filter */
 
@@ -400,7 +399,6 @@ static inline int parse_missing_action_value(const char *value)
 }
 
 static int try_bitmap_count(struct rev_info *revs,
-			    struct list_objects_filter_options *filter,
 			    int filter_provided_objects)
 {
 	uint32_t commit_count = 0,
@@ -436,7 +434,8 @@ static int try_bitmap_count(struct rev_info *revs,
 	 */
 	max_count = revs->max_count;
 
-	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
+					 filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -453,7 +452,6 @@ static int try_bitmap_count(struct rev_info *revs,
 }
 
 static int try_bitmap_traversal(struct rev_info *revs,
-				struct list_objects_filter_options *filter,
 				int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
@@ -465,7 +463,8 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (revs->max_count >= 0)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
+					 filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -475,7 +474,6 @@ static int try_bitmap_traversal(struct rev_info *revs,
 }
 
 static int try_bitmap_disk_usage(struct rev_info *revs,
-				 struct list_objects_filter_options *filter,
 				 int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
@@ -483,7 +481,7 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	if (!show_disk_usage)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, revs->filter, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -597,13 +595,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			parse_list_objects_filter(&filter_options, arg);
-			if (filter_options.choice && !revs.blob_objects)
+			if (!revs.filter)
+				CALLOC_ARRAY(revs.filter, 1);
+			parse_list_objects_filter(revs.filter, arg);
+			if (revs.filter->choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			list_objects_filter_set_no_filter(&filter_options);
+			if (!revs.filter)
+				CALLOC_ARRAY(revs.filter, 1);
+			list_objects_filter_set_no_filter(revs.filter);
 			continue;
 		}
 		if (!strcmp(arg, "--filter-provided-objects")) {
@@ -688,11 +690,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		progress = start_delayed_progress(show_progress, 0);
 
 	if (use_bitmap_index) {
-		if (!try_bitmap_count(&revs, &filter_options, filter_provided_objects))
+		if (!try_bitmap_count(&revs, filter_provided_objects))
 			return 0;
-		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_objects))
+		if (!try_bitmap_disk_usage(&revs, filter_provided_objects))
 			return 0;
-		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_objects))
+		if (!try_bitmap_traversal(&revs, filter_provided_objects))
 			return 0;
 	}
 
@@ -733,7 +735,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
 
 	traverse_commit_list_filtered(
-		&filter_options, &revs, show_commit, show_object, &info,
+		revs.filter, &revs, show_commit, show_object, &info,
 		(arg_print_omitted ? &omitted_objects : NULL));
 
 	if (arg_print_omitted) {
diff --git a/revision.h b/revision.h
index 3c58c18c63a..1ddb73ab82e 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,7 @@ struct rev_cmdline_info {
 
 struct oidset;
 struct topo_walk_info;
+struct list_objects_filter_options;
 
 struct rev_info {
 	/* Starting list */
@@ -94,6 +95,9 @@ struct rev_info {
 	/* The end-points specified by the end user */
 	struct rev_cmdline_info cmdline;
 
+	/* Object filter options. NULL for no filtering. */
+	struct list_objects_filter_options *filter;
+
 	/* excluding from --branches, --refs, etc. expansion */
 	struct string_list *ref_excludes;
 
-- 
gitgitgadget

