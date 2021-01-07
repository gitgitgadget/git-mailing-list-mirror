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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA86C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592CB233EA
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbhAGUCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbhAGUCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942A0C0612A2
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:44 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a6so6119038wmc.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x+DF9E4DRBiUqWwG/Jbo7vmizhmBZ9RLlQ3C2U2KsZ8=;
        b=B2wpXdsItMJkalfd8XfJWwcVWq1IiMNwh4S8taP6mShe1+wCq/B19vNBgNn3+ZNVLd
         7m4EKvX45R3sRchfs8Bh2oxnJ4lGSpdB84/UOSfX7BWI3kzv7+nxK388F9zkcCWYfZvr
         Xq3x9+VCbnpfrtTITCX+p6ifcAYDlqQ6LyNhrfXnInZx4u0wOlwQPe35wZaz2BxM+/8N
         sOT7yQS2s0qXTKAx/4CKJbX1XnBz8B3SFSFWue+0rZkw/Q7Lvy6F4HXI8jHICaMdIVMp
         epJSOOHfD9oAPIACFuR1QAvXutj4SnFAtPqnOu10ovX69gS0YRoAH7Tv/T2v7EkTDcN1
         I5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x+DF9E4DRBiUqWwG/Jbo7vmizhmBZ9RLlQ3C2U2KsZ8=;
        b=USnx/biW19bj9A4Uy/6G09IFwbnPErjkDFvrFxdLKRYPmGBf10jLeqFMK64JN7F0Cc
         4wREbRfCoWbflYfB2kmFtydGrsPoImRrHrT7FK8GOz9loZ1YdneTlPiVkqclmnXayxZq
         JnA7rSsF7mE7EDa3wOoLSv6uKUpmTKuLw4Z3DoCKanCCJUUzSd8/lcsVTlClHMXdXZIl
         8xwmiMYWI2TOn7uLnN+lR/taUu7lRS966CIEg5qujn1liFXAI+1LrC/AU628BCfyDHlq
         xfS2SIcxaUMYabBMjizd9qFg7kFGs/kVUb67modktob8dAtpLaXO9lTH00L0S3Gm3n/F
         X3oA==
X-Gm-Message-State: AOAM530KlWL4wkL7mgrYc8BOKxycVeFVBweRfTHd31KkR9DXH/J6eNf7
        9UTwQQmK0Al38EnXTzjlZzMp6eU6dSY=
X-Google-Smtp-Source: ABdhPJwaWny1UaJYiGKGQlk2J/bFHi1nO6/XG1w6PkUxcnvLWJ3nUl50oLQ8DRA3e0xSSqPmREMJOQ==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr141167wmf.181.1610049703036;
        Thu, 07 Jan 2021 12:01:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16sm9814164wrj.26.2021.01.07.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:42 -0800 (PST)
Message-Id: <d74417e86c54ea03f5a7802a7e4fd2bc3a22f935.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:24 +0000
Subject: [PATCH 15/18] merge-ort: implement
 apply_directory_rename_modifications()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This function roughly follows the same outline as the function of the
same name from merge-recursive.c, but the code diverges in multiple
ways due to some special considerations:
  * merge-ort's version needs to update opt->priv->paths with any new
    paths (and opt->priv->paths points to struct conflict_infos which
    track quite a bit of metadata for each path); merge-recursive's
    version would directly update the index
  * merge-ort requires that opt->priv->paths has any leading directories
    of any relevant files also be included in the set of paths.  And
    due to pointer equality requirements on merged_info.directory_name,
    we have to be careful how we compute and insert these.
  * due to the above requirements on opt->priv->paths, merge-ort's
    version starts with a long comment to explain all the special
    considerations that need to be handled
  * merge-ort can use the full data stored in opt->priv->paths to avoid
    making expensive get_tree_entry() calls to regather the necessary
    data.
  * due to messages being deferred automatically in merge-ort, this is
    the best place to handle conflict messages whereas in
    merge-recursive.c they are deferred manually so that processing of
    entries does all the printing

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 19850ffc0ab..ea6a08e23e2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1224,7 +1224,173 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 						 struct diff_filepair *pair,
 						 char *new_path)
 {
-	die("Not yet implemented.");
+	/*
+	 * The basic idea is to get the conflict_info from opt->priv->paths
+	 * at old path, and insert it into new_path; basically just this:
+	 *     ci = strmap_get(&opt->priv->paths, old_path);
+	 *     strmap_remove(&opt->priv->paths, old_path, 0);
+	 *     strmap_put(&opt->priv->paths, new_path, ci);
+	 * However, there are some factors complicating this:
+	 *     - opt->priv->paths may already have an entry at new_path
+	 *     - Each ci tracks its containing directory, so we need to
+	 *       update that
+	 *     - If another ci has the same containing directory, then
+	 *       the two char*'s MUST point to the same location.  See the
+	 *       comment in struct merged_info.  strcmp equality is not
+	 *       enough; we need pointer equality.
+	 *     - opt->priv->paths must hold the parent directories of any
+	 *       entries that are added.  So, if this directory rename
+	 *       causes entirely new directories, we must recursively add
+	 *       parent directories.
+	 *     - For each parent directory added to opt->priv->paths, we
+	 *       also need to get its parent directory stored in its
+	 *       conflict_info->merged.directory_name with all the same
+	 *       requirements about pointer equality.
+	 */
+	struct string_list dirs_to_insert = STRING_LIST_INIT_NODUP;
+	struct conflict_info *ci, *new_ci;
+	struct strmap_entry *entry;
+	const char *branch_with_new_path, *branch_with_dir_rename;
+	const char *old_path = pair->two->path;
+	const char *parent_name;
+	const char *cur_path;
+	int i, len;
+
+	entry = strmap_get_entry(&opt->priv->paths, old_path);
+	old_path = entry->key;
+	ci = entry->value;
+	VERIFY_CI(ci);
+
+	/* Find parent directories missing from opt->priv->paths */
+	cur_path = new_path;
+	while (1) {
+		/* Find the parent directory of cur_path */
+		char *last_slash = strrchr(cur_path, '/');
+		if (last_slash) {
+			parent_name = xstrndup(cur_path, last_slash - cur_path);
+		} else {
+			parent_name = opt->priv->toplevel_dir;
+			break;
+		}
+
+		/* Look it up in opt->priv->paths */
+		entry = strmap_get_entry(&opt->priv->paths, parent_name);
+		if (entry) {
+			free((char*)parent_name);
+			parent_name = entry->key; /* reuse known pointer */
+			break;
+		}
+
+		/* Record this is one of the directories we need to insert */
+		string_list_append(&dirs_to_insert, parent_name);
+		cur_path = parent_name;
+	}
+
+	/* Traverse dirs_to_insert and insert them into opt->priv->paths */
+	for (i = dirs_to_insert.nr-1; i >= 0; --i) {
+		struct conflict_info *dir_ci;
+		char *cur_dir = dirs_to_insert.items[i].string;
+
+		dir_ci = xcalloc(1, sizeof(*dir_ci));
+
+		dir_ci->merged.directory_name = parent_name;
+		len = strlen(parent_name);
+		/* len+1 because of trailing '/' character */
+		dir_ci->merged.basename_offset = (len > 0 ? len+1 : len);
+		dir_ci->dirmask = ci->filemask;
+		strmap_put(&opt->priv->paths, cur_dir, dir_ci);
+
+		parent_name = cur_dir;
+	}
+
+	/*
+	 * We are removing old_path from opt->priv->paths.  old_path also will
+	 * eventually need to be freed, but it may still be used by e.g.
+	 * ci->pathnames.  So, store it in another string-list for now.
+	 */
+	string_list_append(&opt->priv->paths_to_free, old_path);
+
+	assert(ci->filemask == 2 || ci->filemask == 4);
+	assert(ci->dirmask == 0);
+	strmap_remove(&opt->priv->paths, old_path, 0);
+
+	branch_with_new_path   = (ci->filemask == 2) ? opt->branch1 : opt->branch2;
+	branch_with_dir_rename = (ci->filemask == 2) ? opt->branch2 : opt->branch1;
+
+	/* Now, finally update ci and stick it into opt->priv->paths */
+	ci->merged.directory_name = parent_name;
+	len = strlen(parent_name);
+	ci->merged.basename_offset = (len > 0 ? len+1 : len);
+	new_ci = strmap_get(&opt->priv->paths, new_path);
+	if (!new_ci) {
+		/* Place ci back into opt->priv->paths, but at new_path */
+		strmap_put(&opt->priv->paths, new_path, ci);
+	} else {
+		int index;
+
+		/* A few sanity checks */
+		VERIFY_CI(new_ci);
+		assert(ci->filemask == 2 || ci->filemask == 4);
+		assert((new_ci->filemask & ci->filemask) == 0);
+		assert(!new_ci->merged.clean);
+
+		/* Copy stuff from ci into new_ci */
+		new_ci->filemask |= ci->filemask;
+		if (new_ci->dirmask)
+			new_ci->df_conflict = 1;
+		index = (ci->filemask >> 1);
+		new_ci->pathnames[index] = ci->pathnames[index];
+		new_ci->stages[index].mode = ci->stages[index].mode;
+		oidcpy(&new_ci->stages[index].oid, &ci->stages[index].oid);
+
+		free(ci);
+		ci = new_ci;
+	}
+
+	if (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE) {
+		/* Notify user of updated path */
+		if (pair->status == 'A')
+			path_msg(opt, new_path, 1,
+				 _("Path updated: %s added in %s inside a "
+				   "directory that was renamed in %s; moving "
+				   "it to %s."),
+				 old_path, branch_with_new_path,
+				 branch_with_dir_rename, new_path);
+		else
+			path_msg(opt, new_path, 1,
+				 _("Path updated: %s renamed to %s in %s, "
+				   "inside a directory that was renamed in %s; "
+				   "moving it to %s."),
+				 pair->one->path, old_path, branch_with_new_path,
+				 branch_with_dir_rename, new_path);
+	} else {
+		/*
+		 * opt->detect_directory_renames has the value
+		 * MERGE_DIRECTORY_RENAMES_CONFLICT, so mark these as conflicts.
+		 */
+		ci->path_conflict = 1;
+		if (pair->status == 'A')
+			path_msg(opt, new_path, 0,
+				 _("CONFLICT (file location): %s added in %s "
+				   "inside a directory that was renamed in %s, "
+				   "suggesting it should perhaps be moved to "
+				   "%s."),
+				 old_path, branch_with_new_path,
+				 branch_with_dir_rename, new_path);
+		else
+			path_msg(opt, new_path, 0,
+				 _("CONFLICT (file location): %s renamed to %s "
+				   "in %s, inside a directory that was renamed "
+				   "in %s, suggesting it should perhaps be "
+				   "moved to %s."),
+				 pair->one->path, old_path, branch_with_new_path,
+				 branch_with_dir_rename, new_path);
+	}
+
+	/*
+	 * Finally, record the new location.
+	 */
+	pair->two->path = new_path;
 }
 
 /*** Function Grouping: functions related to regular rename detection ***/
-- 
gitgitgadget

