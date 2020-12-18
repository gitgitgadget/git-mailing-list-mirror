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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98397C2BBD5
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622ED2313B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgLRFwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbgLRFwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02138C061285
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 3so1214263wmg.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQj1KnZFNkvgzNoX7zgcyb8j09rgmx4sS6HQzs7Ndu0=;
        b=IZvZq1IbKmXg2/V+pM176Xg/zsluwt0hLuPn/+KOSAx8rISLiBOA5AOj0U9OMF3+Xv
         D3/UZsoXr8RAfAto2oxUF1P3rfMAvrX0pKOZlQGTbWAR+8YO1ttUolD8QkqLfAisE29u
         apxRhjoeqVGWyZSCXN9P0uulpuCGdfovxCmBnCQ2Xc1V1cEgiRtY0jYT2ad7K/DaO8uI
         vrxSrQ+PpPRF24hbkXPWf1qqSNgnOC52RtSmPmaDz9XiqcZBJr/jC6V1w0N5xQRJs67m
         8pAsgNID3+b9Iwb6L7OIukrUjc7snkoVm6ycR+M3k7VcuTefs2vYTWgAm2OjnPp1bH9E
         b/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uQj1KnZFNkvgzNoX7zgcyb8j09rgmx4sS6HQzs7Ndu0=;
        b=Ms22QN1WowJGh/a0fOmQsmHB7Rf+xp1sZYqA6Z7qUVP/F68WEWOeOkC3qKh3vBWMRy
         znANt8VSWI430cjnDtLF4YSjl1gIC04rLFTW8OZwMscbFrCjgj+eGAz1bufROhg0HNK9
         Ct5sEWv0NkD/mo6RouOLKnqDPzCHfMeEMjmPrdPynqSGPvXHcZriId9G43aN9CspD+wT
         N9l3zuCJCt3F4gvjzKRxZWyrAIs4tkKpTfiMeFORnHZ33UoZ22gQ7vuGptdKehSzW19P
         eqRsx9sMnXXoBuvm0cOA/0Ku8antg3JsWsXDBqYJlwbMf5zf9NjfnanhfxPucyoMvoRA
         KHMQ==
X-Gm-Message-State: AOAM5305s4SNPqDDJgFXUBJIJBOlx0TsZArOZOJ4FWK/eczrI4r5ZuHo
        FbX5DPDtI6cEUlgfqThhJ7vlgeSoh7Y=
X-Google-Smtp-Source: ABdhPJzOObgwFLGMlzCgS1I6UK/Nv2lIVPDY79puC/iG2N9Kr63PWAoi6aBJCLksJXqExbu6rmrFCw==
X-Received: by 2002:a1c:2d47:: with SMTP id t68mr2573840wmt.148.1608270692433;
        Thu, 17 Dec 2020 21:51:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm7124152wru.50.2020.12.17.21.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:31 -0800 (PST)
Message-Id: <4c641ec19d578a4014b4d3b568d18606a164ae9a.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:21 +0000
Subject: [PATCH 04/10] merge-ort: handle book-keeping around two- and
 three-way content merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

