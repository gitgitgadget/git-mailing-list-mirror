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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F2C433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896412080C
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbhAACgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbhAACgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:36:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B8C06179F
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m5so21235595wrx.9
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uvSz/zkpiSWnb/05VUXkSbjX8lrKZvPzFtwPt0EFQEE=;
        b=XfZX+37p2ikCz8Z81ZKabMNeZVsUJ6qKhu2egGXOBDPBEBf4cK1BvWrPwdlDCQC+uJ
         cM//Ej42yiyVhpoz4tEwJsLEKAhhUkHI/QV5qSEiMhBgyZrBd4KeBgRxoVbIgG23MCiM
         a6NPsHJkm1VZQpPsH9TdlD86B6ae6QgifsRn6NLjHHc7q8352IB6/PMkDl3v6DEvSj46
         K6PSLbp/8wIv2ZIPuU+N7MZfsYArbDGfakvo1iPWtrkEwjrLbDINMw+bp/NZufEw8Db+
         ovVxmrzwfSiSeEDzys4KCMbbPhSCIHSPzFGWaMZ76yw0OnHWmd9NbPjfIpdeBej7oWNl
         PPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uvSz/zkpiSWnb/05VUXkSbjX8lrKZvPzFtwPt0EFQEE=;
        b=PE4ehLGeiorNAnY8de7JU4rAZzugaYtWQGhgWt0lAeNnCQCGT+ci3VkSDI53gq3YpT
         HNvnHRxROWnjgWintoCD09hdBVXqk5WFYlI/h8luu4sRyI53h1gBqUZHFhxWXMQpYTUZ
         c/c/Yi1uwUiPH/psTIfs73t47tPykPzKI4wF6cXVtJqfTocY6Gc0wM3pcexpKq9fzw0v
         pegZCKmtLkrjOMBZs4N8YO65GThqp9OOxJqVK+RDsdCG2RewcQxqTa8RTmw9YosIHmya
         0fvei+7n/G+4Z5TX9WmDCUC+UOFhv8+3p+NxggntQdw2NeBUjQwYo54nHVsSx6b2lu0O
         uSpw==
X-Gm-Message-State: AOAM532GI/ipBqYTSjOieBMKBQvRnKZT7Azs4uYVAjb2OIt9FKivpcb+
        XfFpWBlXpP6xkQtnb/3oR27B4P4qyOk=
X-Google-Smtp-Source: ABdhPJxk6U7ONZfRQoOxikcBrW44TyCg/69iNlgc3yS4APDoAxizYXQQ9RJS+roF+8qKfsanExLJQA==
X-Received: by 2002:adf:e511:: with SMTP id j17mr65920222wrm.416.1609468491718;
        Thu, 31 Dec 2020 18:34:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm78658197wrn.0.2020.12.31.18.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:51 -0800 (PST)
Message-Id: <54f9be41a8a053985533247325013fe45c5c2635.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:40 +0000
Subject: [PATCH v2 02/10] merge-ort: handle directory/file conflicts that
 remain
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

When a directory/file conflict remains, we can leave the directory where
it is, but need to move the information about the file to a different
pathname.  After moving the file to a different pathname, we allow
subsequent process_entry() logic to handle any additional details that
might be relevant.

This depends on a new helper function, unique_path(), that dies with an
unimplemented error currently but will be implemented in a subsequent
commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index dd90987ae3d..d300a02810e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -343,6 +343,13 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
+static char *unique_path(struct strmap *existing_paths,
+			 const char *path,
+			 const char *branch)
+{
+	die("Not yet implemented.");
+}
+
 /*** Function Grouping: functions related to collect_merge_info() ***/
 
 static void setup_path_info(struct merge_options *opt,
@@ -962,6 +969,8 @@ static void process_entry(struct merge_options *opt,
 			  struct conflict_info *ci,
 			  struct directory_versions *dir_metadata)
 {
+	int df_file_index = 0;
+
 	VERIFY_CI(ci);
 	assert(ci->filemask >= 0 && ci->filemask <= 7);
 	/* ci->match_mask == 7 was handled in collect_merge_info_callback() */
@@ -998,13 +1007,86 @@ static void process_entry(struct merge_options *opt,
 			oidcpy(&ci->stages[i].oid, &null_oid);
 		}
 	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
-		die("Not yet implemented.");
+		/*
+		 * This started out as a D/F conflict, and the entries in
+		 * the competing directory were not removed by the merge as
+		 * evidenced by write_completed_directory() writing a value
+		 * to ci->merged.result.mode.
+		 */
+		struct conflict_info *new_ci;
+		const char *branch;
+		const char *old_path = path;
+		int i;
+
+		assert(ci->merged.result.mode == S_IFDIR);
+
+		/*
+		 * If filemask is 1, we can just ignore the file as having
+		 * been deleted on both sides.  We do not want to overwrite
+		 * ci->merged.result, since it stores the tree for all the
+		 * files under it.
+		 */
+		if (ci->filemask == 1) {
+			ci->filemask = 0;
+			return;
+		}
+
+		/*
+		 * This file still exists on at least one side, and we want
+		 * the directory to remain here, so we need to move this
+		 * path to some new location.
+		 */
+		new_ci = xcalloc(1, sizeof(*new_ci));
+		/* We don't really want new_ci->merged.result copied, but it'll
+		 * be overwritten below so it doesn't matter.  We also don't
+		 * want any directory mode/oid values copied, but we'll zero
+		 * those out immediately.  We do want the rest of ci copied.
+		 */
+		memcpy(new_ci, ci, sizeof(*ci));
+		new_ci->match_mask = (new_ci->match_mask & ~new_ci->dirmask);
+		new_ci->dirmask = 0;
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			if (new_ci->filemask & (1 << i))
+				continue;
+			/* zero out any entries related to directories */
+			new_ci->stages[i].mode = 0;
+			oidcpy(&new_ci->stages[i].oid, &null_oid);
+		}
+
+		/*
+		 * Find out which side this file came from; note that we
+		 * cannot just use ci->filemask, because renames could cause
+		 * the filemask to go back to 7.  So we use dirmask, then
+		 * pick the opposite side's index.
+		 */
+		df_file_index = (ci->dirmask & (1 << 1)) ? 2 : 1;
+		branch = (df_file_index == 1) ? opt->branch1 : opt->branch2;
+		path = unique_path(&opt->priv->paths, path, branch);
+		strmap_put(&opt->priv->paths, path, new_ci);
+
+		path_msg(opt, path, 0,
+			 _("CONFLICT (file/directory): directory in the way "
+			   "of %s from %s; moving it to %s instead."),
+			 old_path, branch, path);
+
+		/*
+		 * Zero out the filemask for the old ci.  At this point, ci
+		 * was just an entry for a directory, so we don't need to
+		 * do anything more with it.
+		 */
+		ci->filemask = 0;
+
+		/*
+		 * Now note that we're working on the new entry (path was
+		 * updated above.
+		 */
+		ci = new_ci;
 	}
 
 	/*
 	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
 	 *       which the code goes through even for the df_conflict cases
-	 *       above.  Well, it will once we don't die-not-implemented above.
+	 *       above.
 	 */
 	if (ci->match_mask) {
 		ci->merged.clean = 1;
-- 
gitgitgadget

