Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB4DC43333
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E91B2253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbhADXvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbhADXvf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:35 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B0C0617A5
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:43 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 11so27691010oty.9
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhdC5dcT9zDMpbgcjdf8rubywHfnE+fEellrIf/R7UM=;
        b=IKX1yWnrGGoypxgrKV++tW6FhRaOxngWTbLq835sCigRKSElXWw6RdAOoxGVyUfnVa
         ZYxxYcoEwjbPhwrRU/FkB8q2G/sH9MtL9z77H2SKtrJUf4zHBNtqT3TZ7mmTIOw3Mugv
         LSLNsXobxppo4SHQ0KVgM4hJlyuYDcQx5iyY+qYOlXW1ouNPfIg/01VFEf7oMCKMqBBo
         Cqb1G/+mjMiQtQqfbVE+LXPf1/ElIZKvGl1J0Bw4egGhDnwBB/WROZx2lWVZxsv0DNpK
         TFsM9EwisYFqx/XzhAo+9PArtNjBNRTDutt/2KDO68FnerUpCkEX5SUfqTs7g2BH6OAu
         Nn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhdC5dcT9zDMpbgcjdf8rubywHfnE+fEellrIf/R7UM=;
        b=O0cqPOD3Amrpjy00atooI6juqAkOx+W5GNtp1gv/2VF52dqrwg08CFxr+cHbw34faT
         1di2kJeTYe1k8qfI9L1URe9oMbc3zki2F+iBYbQHzNraaIPBdf8Gas4NBgHwDmSjyBYu
         ruSHWGpfA42zCRKnrPsjSbtp/wYOTYtodpmeyFVCiwqTz4eHcw6A0YNlpifM3DGHR2PA
         /Hwv2HxZIVL4h4/lWhAw2HLYFhYNCkHpiu3LmHSpgcdAZfFP2Z8msFcacbEfYR4UgO1U
         bYEyLysZURtm1kXrL6NpZIi8aiwdMjRMYGnP2GJv4yuXoGIErBt0Te+bAWWuh8Ztenu3
         3wWg==
X-Gm-Message-State: AOAM532foYlJy96Pi34b2jlazmVXvnyBdkLraqSdKX8s1qkmyWTF6ot/
        UuaF+lPMjmUHXJqhSttxdFU90cnPjhs=
X-Google-Smtp-Source: ABdhPJyXOumsd6BayAOsH4DKkWNdSogvKUuMPnKyQg9DfyZKW3OizW6BM7Rc0GEmM5YVIeOar/PScg==
X-Received: by 2002:a9d:3a26:: with SMTP id j35mr29014114otc.64.1609804242793;
        Mon, 04 Jan 2021 15:50:42 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 13/17] merge-ort: implement handle_path_level_conflicts()
Date:   Mon,  4 Jan 2021 15:50:02 -0800
Message-Id: <20210104235006.2867404-14-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 84f4f4776b..d0fb8f4282 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1282,6 +1282,16 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
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
@@ -1294,7 +1304,67 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
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
2.29.1.106.g3ff750dc32.dirty

