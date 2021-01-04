Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD701C433E9
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813AE22519
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbhADXvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbhADXvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:09 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821BC0617A4
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:42 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s2so34143169oij.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GieFQOSS2/WeB9FLiTOdNLbGs/riDswR5m//gi3jabY=;
        b=WIvOcZIbsxaGf4T65njEq1do+YISVu7wNEIL2c0vMFfzUSGJp0/H28LfQTIgNOLh8w
         d/R+d5+4XHSoivGliS9Mt8v2Pxzm40rpdYuW5I+YEB1bXt+LijZUnuGhYdkMSWJEs7W/
         u/fJPNj7uOhnc3FknarLjJzyQwZxtFL5L7ieFpyXYgxZvf0ekztdTs4/3YpA+AHosf/x
         T34ghcI0ov+q5y2/XdMBFq1sE8GEmniBIgx/VlEFr3h+S1ASxl7DfzB4KWMJ704eewns
         jYIkN58DJyiIYV7kYFwc+gWip9v2u60u2NcVP/4pthOT4oeFuTK8OIDJdbNOwPd3zZwJ
         RLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GieFQOSS2/WeB9FLiTOdNLbGs/riDswR5m//gi3jabY=;
        b=MwKgr07Dufc5YxmWyVduOiM0xTlSAebH/wPyso+MT6aE6rrj9aSNVT709mtFWXfZKK
         CLE7y5bQBa33rop3VtQsVijnUzSM6p7Chspjhi2xtHV5Hmj5pzRbhJqxcfsW/ResVhTG
         cpud9k5OLHh8UT8B7NXAKbljD1rEIlYoWFphyHY8WfsSwatNBuZI9O/+XQXEUAa6xj29
         2X/zl3T3ps0pgS1zlC/kAb0PbwqZS7F1/XBYhhEUNcybRqXskj2MpUKlG19HLoemPl9U
         Gx0C8D2l4npVraUGj5vvehSEzlFVNuvKJJRuUwR0gDT9mDxrZuhSAyy0bYfhpxynMhSG
         17JQ==
X-Gm-Message-State: AOAM530zC+Jw5EFaBdGTT4C+xIMbJyhTrMkTJq8FeYBtiUxZQZ25pnft
        dNY7v+gjw1rDLQAdPYhlRSK5ruhz0LM=
X-Google-Smtp-Source: ABdhPJywZtRCVc0dYX8qRn+0kpjTzfhWN6/3pWWgTVWFpoIoeE2f+NqmsWa7M7yd1anoB8dXe5UC6Q==
X-Received: by 2002:aca:4257:: with SMTP id p84mr967572oia.176.1609804241699;
        Mon, 04 Jan 2021 15:50:41 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:41 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 12/17] merge-ort: implement check_for_directory_rename()
Date:   Mon,  4 Jan 2021 15:50:01 -0800
Message-Id: <20210104235006.2867404-13-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index f7f2470c96..84f4f4776b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1282,6 +1282,21 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
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
@@ -1497,7 +1512,57 @@ static char *check_for_directory_rename(struct merge_options *opt,
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
2.29.1.106.g3ff750dc32.dirty

