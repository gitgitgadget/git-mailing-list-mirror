Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C8C433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C485207C8
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhAACfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAACff (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:35:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423EC0613C1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a6so8365131wmc.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQj1KnZFNkvgzNoX7zgcyb8j09rgmx4sS6HQzs7Ndu0=;
        b=eWjl6lvw3jyVIICS4S9JqqsecKmC7ITV9RJB3GopnKeivBvJZXXqMb3u/290bpkG5u
         snhQAwuz24XgqGbueh00dV5a0fpy9yNiS6twYMDBlOzNKu4ZJAPPgWGvSDEDflEHyXqg
         jdESZ8hg6N5Ejq1XRKqZ92la26N6wR6iVPeWyE9m/kfBbIrtUlyOi+lMRme3xs308EF0
         gHjO5H1aS32F0+0YPWUcbQVE+3j49LQ3W32oGSSJRoTvru/IZ9LUH4c8d8aN7l9zTcTU
         sq8jFwsxuqCQeRYg7FeaHjLlz7SfenTbaLb3FqLHK/WVFzmgr+/S7/o8BsCxQKKP1KRS
         x5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uQj1KnZFNkvgzNoX7zgcyb8j09rgmx4sS6HQzs7Ndu0=;
        b=N+aQJGUXRiPQgAlJuKOmk5fF7yHoMRiQWrVG7fIqoG9Xfr/w3ocoYLNBVA8OQIlapT
         /5T74swwBZNcJrZUgAwhniO56aQJIGikoVtbYJV029emtMvguvppvK7w9aQUcJAZTZx6
         rkdpD1SwVRE8zz1IGXyVN3k4Fmrfuk8Qx6gl/mQq0q3UE7QnMgOmk3rdPZD5hbCf28rF
         dB/nSygG22wOpRwHVMGXsXq+iEuAcom1ytKGsP8xb9kfy2lmyk0Xh/CMLepk/RilH6+e
         UTt4JOwy+ZRlYXSNoiNwUKDsLy1GpHQIK74bzo0Mnvafnil8eB31+J/8VyySj0MIi76i
         XYbg==
X-Gm-Message-State: AOAM531VdAU9wGQzWl/a3vwUJM468Lwcji+LYOp2D3BDw9tor3I+URxw
        9wRkj1GRcMCzh1FwppcGJaK7ghfvj+k=
X-Google-Smtp-Source: ABdhPJzYan8IU92nwEe2lr5P5D9A30gqeIpJVqa1gkWVpMdrwRudCAwPUtFrLEV/V3+dlKIODV6i7Q==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr13947531wmf.58.1609468493192;
        Thu, 31 Dec 2020 18:34:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm15271105wma.26.2020.12.31.18.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:52 -0800 (PST)
Message-Id: <d0fab13c78aee3a7232f58625500acb8b16a3e34.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:42 +0000
Subject: [PATCH v2 04/10] merge-ort: handle book-keeping around two- and
 three-way content merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In addition to the content merge (which will go in a subsequent commit),
we need to worry about conflict messages, placing results in higher
order stages in case of a df_conflict, and making sure the results are
placed in ci->merged.result so that they will show up in the working
tree.  Take care of all that external book-keeping, moving the
simplistic just-take-HEAD code into the barebones handle_content_merge()
function for now.  Subsequent commits will flesh out
handle_content_merge().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 52 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1adc27a11bc..47e230fe341 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -640,7 +640,15 @@ static int handle_content_merge(struct merge_options *opt,
 				const int extra_marker_size,
 				struct version_info *result)
 {
-	die("Not yet implemented");
+	int clean = 0;
+	/*
+	 * TODO: Needs a two-way or three-way content merge, but we're
+	 * just being lazy and copying the version from HEAD and
+	 * leaving it as conflicted.
+	 */
+	result->mode = a->mode;
+	oidcpy(&result->oid, &a->oid);
+	return clean;
 }
 
 /*** Function Grouping: functions related to detect_and_process_renames(), ***
@@ -1138,16 +1146,38 @@ static void process_entry(struct merge_options *opt,
 		 */
 		die("Not yet implemented.");
 	} else if (ci->filemask >= 6) {
-		/*
-		 * TODO: Needs a two-way or three-way content merge, but we're
-		 * just being lazy and copying the version from HEAD and
-		 * leaving it as conflicted.
-		 */
-		ci->merged.clean = 0;
-		ci->merged.result.mode = ci->stages[1].mode;
-		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
-		/* When we fix above, we'll call handle_content_merge() */
-		(void)handle_content_merge;
+		/* Need a two-way or three-way content merge */
+		struct version_info merged_file;
+		unsigned clean_merge;
+		struct version_info *o = &ci->stages[0];
+		struct version_info *a = &ci->stages[1];
+		struct version_info *b = &ci->stages[2];
+
+		clean_merge = handle_content_merge(opt, path, o, a, b,
+						   ci->pathnames,
+						   opt->priv->call_depth * 2,
+						   &merged_file);
+		ci->merged.clean = clean_merge &&
+				   !ci->df_conflict && !ci->path_conflict;
+		ci->merged.result.mode = merged_file.mode;
+		ci->merged.is_null = (merged_file.mode == 0);
+		oidcpy(&ci->merged.result.oid, &merged_file.oid);
+		if (clean_merge && ci->df_conflict) {
+			assert(df_file_index == 1 || df_file_index == 2);
+			ci->filemask = 1 << df_file_index;
+			ci->stages[df_file_index].mode = merged_file.mode;
+			oidcpy(&ci->stages[df_file_index].oid, &merged_file.oid);
+		}
+		if (!clean_merge) {
+			const char *reason = _("content");
+			if (ci->filemask == 6)
+				reason = _("add/add");
+			if (S_ISGITLINK(merged_file.mode))
+				reason = _("submodule");
+			path_msg(opt, path, 0,
+				 _("CONFLICT (%s): Merge conflict in %s"),
+				 reason, path);
+		}
 	} else if (ci->filemask == 3 || ci->filemask == 5) {
 		/* Modify/delete */
 		const char *modify_branch, *delete_branch;
-- 
gitgitgadget

