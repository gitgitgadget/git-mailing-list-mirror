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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B5C43217
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89622235FF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbhAGVhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5CC0612A1
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 190so6306453wmz.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NHnapn2YaP8WvGrSYN719MNz1Vbq/U0fN5T5UuDmtNM=;
        b=LlhtWRdpTgb/2UbUiI02iNX39O62K/GjcvXYmSxZBm+NAbXQDronE1i/fY271r8+26
         ypaDfB1jdhabqeoQX1rv6N4J8J5OS3iiukCte3e9xdnUA6eBQHe463NknZ0no8c/8+25
         lKVYjKgSKdv2yrlo1c4akTDsv2iX4OhX4RS2DDILu/8ro6sPEo7fc/798LjHg76EVTTx
         TIZ7taYDfVxXBU7A1bAkfyHNKu6hHqBX59mNR9H2bmLXdQKahuASE72KgfuWGZtjFK/b
         +WxAEfVY0qBoPlOYXj/BfDiW1NNwCbVmUBu3ulefyk9DLeQz7VNu6m2cCnJZp45rbDN1
         MUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NHnapn2YaP8WvGrSYN719MNz1Vbq/U0fN5T5UuDmtNM=;
        b=fWUBR8WVLM3nqSh3H/UU4EJ5QXx4foarBUx3Yt8XaSLYgAymVL4hfhzNs4c4MWCP+K
         nh+TMNrNQyAeOdIv2riehftMMxT0guCEZVhqX7OY3RfGHn5xuW3M5nhN+RnSlIy/nbnd
         bPLBhkFW48SnNLw3ZqWMTSCrWqQ8l5e8Z4oFlchydaw/DzBzpHtKmex9bqymjGCAYFdO
         ue5jFeNowUY/Wi25ECEG3fiYFYcnw0c9NE1YhHef7mfnovyvGukx6jvkmsrctn8B2CjC
         CIjTrf1ioYNj9spxyawlc0nvwSRaIX2JnaGgN/TtstPbRuEL9pwjmpLRQwecpsq8PfWN
         KW1A==
X-Gm-Message-State: AOAM530kMELgSGhWgjawezCuPf6eRg6ZBJAMAovqblmcw30er7rBW4q3
        +gJ43HYASZYuk7uAFbOEO8jnPrAbdRQ=
X-Google-Smtp-Source: ABdhPJzeqrcJDLKYFIbr6a9umyRMqnXFkb9j8qlZyrinobaEOBFQN/87hWmh3Wdr2oB6Qz5AbYZ0DQ==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr400839wmk.70.1610055380417;
        Thu, 07 Jan 2021 13:36:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm9714861wmb.37.2021.01.07.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:19 -0800 (PST)
Message-Id: <cbfdf4d9ba04aeec6b83699e6294b2d9dc352574.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:36:00 +0000
Subject: [PATCH v2 12/17] merge-ort: implement check_for_directory_rename()
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
index 8ee9c685c7b..6823f812c28 100644
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
@@ -1079,7 +1094,57 @@ static char *check_for_directory_rename(struct merge_options *opt,
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

