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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A013C4332D
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BD8235FF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbhAGVhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8023C0612A2
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t30so7059130wrb.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uJLyoB/uoq2MmvnDWAoRFFOhn647HBz0bQTBAePKgmM=;
        b=J6SzizH8natltzYvVhrI1zqdwfYCTOOksIerHM5qbgauVPQiciPmtc3goESVIT7cg1
         dC7ovqf+DyNDAwtUrRijXayNlmnvkF1jL+JPVlbAHgYTV2NY5Q1pe7nxJhrvl5cpWI6V
         V3HXg009VHSb+58gDRfB+EwAMF9K2cZk4LqAhTACt5n1H0FbK0i1McKzivG/dZRNqnnt
         Y6+G1xk0UDYoHfnkelrjZpsxq1DJAR9eP1euTnSgzLUmve2VnClsELoEk+D359Zyb+ff
         0plp6543HcoB/bpH/g0pSnHglwM3Cp+rCGfEbh0TO8/QStodweD1fjjhmuyOrn/Gwl8i
         68fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uJLyoB/uoq2MmvnDWAoRFFOhn647HBz0bQTBAePKgmM=;
        b=PB+I7PU6sGogx8I5cIYCY4WXirsOvhJ9hy8O58IByK0uuN+8UbyX15gIIwgnpZ0sVQ
         +rFLCbhtnsV7OOyz4QfNNJLkDO9brOcOKKySTq/tco+nAUWbhXwr2quFDCcB94Ix0LR1
         s3WsmtkqoahP9ZMLvx2mm7z4lRN0jgnUYWSseLhGosw75xwqcgMrrMsGUH5GPPh60QDq
         cW7LdN/6/GTNQc4cv1o3SKC6f8Ve1btAuaOdS5enymVg9IOlX2JGrUnSOobZ8i5SL4Os
         w3W2heOFn2JF7Ydpr/nOxY/ffPNSmPsXZOi31h5Hv8jW4XkJPavX7G1afeVSi0Z4wQSo
         zl3g==
X-Gm-Message-State: AOAM532CnEQ/GYB6jQPdgMBAvpv0hwkY+AfGu83LLCOkouggRQG6V70h
        reHwyPNQCz9WIoCXKh3dZurGE6tscRc=
X-Google-Smtp-Source: ABdhPJz4NXWo8sj7bvVQJEOfsn/MftuKuIcdwd1XXVWsLRex29UpS8MTe6KIDnLhbqE6YKscHqPnig==
X-Received: by 2002:adf:828b:: with SMTP id 11mr541063wrc.180.1610055381398;
        Thu, 07 Jan 2021 13:36:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4sm11064736wrw.42.2021.01.07.13.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:20 -0800 (PST)
Message-Id: <734891cb3153f9e1982721257b766ed9c10b9676.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:36:01 +0000
Subject: [PATCH v2 13/17] merge-ort: implement handle_path_level_conflicts()
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

This is copied from merge-recursive.c, with minor tweaks due to:
  * using strmap API
  * merge-ort not using the non_unique_new_dir field, since it'll
    obviate its need entirely later with performance improvements
  * adding a new path_in_way() function that uses opt->priv->paths
    instead of doing an expensive tree_has_path() lookup to see if
    a tree has a given path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6823f812c28..43cfee29bd0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -864,6 +864,16 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	*new_dir = xstrndup(new_path, end_of_new - new_path);
 }
 
+static int path_in_way(struct strmap *paths, const char *path, unsigned side_mask)
+{
+	struct merged_info *mi = strmap_get(paths, path);
+	struct conflict_info *ci;
+	if (!mi)
+		return 0;
+	INITIALIZE_CI(ci, mi);
+	return mi->clean || (side_mask & (ci->filemask | ci->dirmask));
+}
+
 /*
  * See if there is a directory rename for path, and if there are any file
  * level conflicts on the given side for the renamed location.  If there is
@@ -876,7 +886,67 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 					 struct strmap_entry *rename_info,
 					 struct strmap *collisions)
 {
-	die("Not yet implemented");
+	char *new_path = NULL;
+	struct collision_info *c_info;
+	int clean = 1;
+	struct strbuf collision_paths = STRBUF_INIT;
+
+	/*
+	 * entry has the mapping of old directory name to new directory name
+	 * that we want to apply to path.
+	 */
+	new_path = apply_dir_rename(rename_info, path);
+	if (!new_path)
+		BUG("Failed to apply directory rename!");
+
+	/*
+	 * The caller needs to have ensured that it has pre-populated
+	 * collisions with all paths that map to new_path.  Do a quick check
+	 * to ensure that's the case.
+	 */
+	c_info = strmap_get(collisions, new_path);
+	if (c_info == NULL)
+		BUG("c_info is NULL");
+
+	/*
+	 * Check for one-sided add/add/.../add conflicts, i.e.
+	 * where implicit renames from the other side doing
+	 * directory rename(s) can affect this side of history
+	 * to put multiple paths into the same location.  Warn
+	 * and bail on directory renames for such paths.
+	 */
+	if (c_info->reported_already) {
+		clean = 0;
+	} else if (path_in_way(&opt->priv->paths, new_path, 1 << side_index)) {
+		c_info->reported_already = 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &c_info->source_files);
+		path_msg(opt, new_path, 0,
+			 _("CONFLICT (implicit dir rename): Existing file/dir "
+			   "at %s in the way of implicit directory rename(s) "
+			   "putting the following path(s) there: %s."),
+		       new_path, collision_paths.buf);
+		clean = 0;
+	} else if (c_info->source_files.nr > 1) {
+		c_info->reported_already = 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &c_info->source_files);
+		path_msg(opt, new_path, 0,
+			 _("CONFLICT (implicit dir rename): Cannot map more "
+			   "than one path to %s; implicit directory renames "
+			   "tried to put these paths there: %s"),
+		       new_path, collision_paths.buf);
+		clean = 0;
+	}
+
+	/* Free memory we no longer need */
+	strbuf_release(&collision_paths);
+	if (!clean && new_path) {
+		free(new_path);
+		return NULL;
+	}
+
+	return new_path;
 }
 
 static void increment_count(struct strmap *dir_rename_count,
-- 
gitgitgadget

