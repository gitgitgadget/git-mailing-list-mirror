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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1EC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941432310B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbhAST7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392077AbhASTzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845CC061796
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u14so828412wmq.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yYjdeMwcEkwlwbV0E3MXEBcoSxWoEC30fUk9SMydLaA=;
        b=g+KsP0cw6mTdndGJg9sBZKVtloIvLn94EK7VP47gABEasp8uWuNe1T00GPfXreAxjU
         ovVai7oyLv0YHcmxQ59YkcGtzbq0S6kfzLiF7bFTq9nzWdAYVy+w4k9A1cqtkfPCuOdS
         QEEL23l1yDK2NY7Q0VCOc3X8n5h/sN+7n4/9oJqAFuiBEEgt0JpsSEOeLcCYcsmA5RH+
         sF3TuiLkAHEcYgg7vQHW0jMHJeMatv0zPzN1BY4wZLklC+DDHA8VPB+/+3wnfWvmjZdh
         5fbeOCmsQLlyEtPhjyj16+XEQd6UJ3weDWKnx2r91Wepeyzc4jCn3nWEI1t3e1C3O3Eu
         iqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yYjdeMwcEkwlwbV0E3MXEBcoSxWoEC30fUk9SMydLaA=;
        b=AmRad4nEKGXMUNiddj5wjjUUqoTb4fDhoAyVO4XnRIPsnfqbf0pfviP/XlkPVTNKem
         lfu/skt5Ntzr/iANAhUJLJhGo+ct+zVIeWUQ6vQ7JWHmKZWBNLZmG4yfLCLBSPM0CrD7
         ko9X2zT3xayFZ0JdR6ooY8JInCAqg8bAi+uO3rSqSdSj50/EkWDpfQ/i37uI15CYf+TC
         ZPio1MKR4/mnl9OOz0lxSTSJXC4mWY7LdjWH28nlnrGfDIIYjgwe4GuRR0be19EIlgvB
         wvZQvnNzA2z5bN17oQ+PGNGDafWNlYIeTcHYkRFJrjRRucrWVpA5YtO/RCEYG5E/77UG
         npJA==
X-Gm-Message-State: AOAM532SeTDpTgil43gwMwTlo+4szUIR6C1PbiNmocd6XPM+FhWxllE8
        X/vv1lyeW3abLxOGmwGczqOcWHgn4t0=
X-Google-Smtp-Source: ABdhPJx5PSn/7/UVJnSx8//NPkn81GqPgKkM0LcW0U0IKn/F59nzKQop12RhUU0lTYNEtASfGC2c4Q==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr1169135wmq.2.1611086045678;
        Tue, 19 Jan 2021 11:54:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm5777509wml.34.2021.01.19.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:05 -0800 (PST)
Message-Id: <ad08c6ece4d1a3bbe90f48201e3006203ddcc3e9.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:48 +0000
Subject: [PATCH v3 12/17] merge-ort: implement check_for_directory_rename()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This is copied from merge-recursive.c, with minor tweaks due to using strmap
API and the fact that it can use opt->priv->paths to get all pathnames that
exist instead of taking a tree object.

This depends on a new function, handle_path_level_conflicts(), which
just has a placeholder die-not-yet-implemented implementation for now; a
subsequent patch will implement it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index db922272edf..86d2214006e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -864,6 +864,21 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	*new_dir = xstrndup(new_path, end_of_new - new_path);
 }
 
+/*
+ * See if there is a directory rename for path, and if there are any file
+ * level conflicts on the given side for the renamed location.  If there is
+ * a rename and there are no conflicts, return the new name.  Otherwise,
+ * return NULL.
+ */
+static char *handle_path_level_conflicts(struct merge_options *opt,
+					 const char *path,
+					 unsigned side_index,
+					 struct strmap_entry *rename_info,
+					 struct strmap *collisions)
+{
+	die("Not yet implemented");
+}
+
 static void increment_count(struct strmap *dir_rename_count,
 			    char *old_dir,
 			    char *new_dir)
@@ -1078,7 +1093,57 @@ static char *check_for_directory_rename(struct merge_options *opt,
 					struct strmap *collisions,
 					int *clean_merge)
 {
-	die("Not yet implemented.");
+	char *new_path = NULL;
+	struct strmap_entry *rename_info;
+	struct strmap_entry *otherinfo = NULL;
+	const char *new_dir;
+
+	if (strmap_empty(dir_renames))
+		return new_path;
+	rename_info = check_dir_renamed(path, dir_renames);
+	if (!rename_info)
+		return new_path;
+	/* old_dir = rename_info->key; */
+	new_dir = rename_info->value;
+
+	/*
+	 * This next part is a little weird.  We do not want to do an
+	 * implicit rename into a directory we renamed on our side, because
+	 * that will result in a spurious rename/rename(1to2) conflict.  An
+	 * example:
+	 *   Base commit: dumbdir/afile, otherdir/bfile
+	 *   Side 1:      smrtdir/afile, otherdir/bfile
+	 *   Side 2:      dumbdir/afile, dumbdir/bfile
+	 * Here, while working on Side 1, we could notice that otherdir was
+	 * renamed/merged to dumbdir, and change the diff_filepair for
+	 * otherdir/bfile into a rename into dumbdir/bfile.  However, Side
+	 * 2 will notice the rename from dumbdir to smrtdir, and do the
+	 * transitive rename to move it from dumbdir/bfile to
+	 * smrtdir/bfile.  That gives us bfile in dumbdir vs being in
+	 * smrtdir, a rename/rename(1to2) conflict.  We really just want
+	 * the file to end up in smrtdir.  And the way to achieve that is
+	 * to not let Side1 do the rename to dumbdir, since we know that is
+	 * the source of one of our directory renames.
+	 *
+	 * That's why otherinfo and dir_rename_exclusions is here.
+	 *
+	 * As it turns out, this also prevents N-way transient rename
+	 * confusion; See testcases 9c and 9d of t6043.
+	 */
+	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
+	if (otherinfo) {
+		path_msg(opt, rename_info->key, 1,
+			 _("WARNING: Avoiding applying %s -> %s rename "
+			   "to %s, because %s itself was renamed."),
+			 rename_info->key, new_dir, path, new_dir);
+		return NULL;
+	}
+
+	new_path = handle_path_level_conflicts(opt, path, side_index,
+					       rename_info, collisions);
+	*clean_merge &= (new_path != NULL);
+
+	return new_path;
 }
 
 static void apply_directory_rename_modifications(struct merge_options *opt,
-- 
gitgitgadget

