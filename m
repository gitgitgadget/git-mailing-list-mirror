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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87433C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382692310B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbhAST7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392086AbhASTzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3AAC061798
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v184so846243wma.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BHbeRbrue7+N3V7H9FmoaCX8vFmbG0wcwDK4/486DF4=;
        b=Mcceieorw1UQA3TKX9aM41d0MVajzvQ3UUwBzGxJa39vmwCz52MBiljiE9hRyNl/od
         ba+6oUvmAga9g8XX3PdKojeAHDi/nZKaDCvx5em6W2SZaCTqvJoyEVBD2Kvzrd0lPw5V
         dG4jG3U9k/OOIUTWjBrKrrVB/lQbaWd3XpckfwYcd2iwOHfe8BtUCQDAglu1pU7GI26M
         lcmdrN7v5+gETfl8q9yO5kLmg89TCXg9HZjQ8cr5emK8KQgTCpM3AfWsDqckHD44Nj2c
         KbvBRkJd7Xdo1FTDHNCr3//WhAFdweMuUSTGO46FB0Pj1SMcr1/Rm/02sP6/HykRR3yR
         QFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BHbeRbrue7+N3V7H9FmoaCX8vFmbG0wcwDK4/486DF4=;
        b=TJEfTP77mwzidMuKds2jQL3uwewJCaSnCg+1e5OLAn7Tq65W6vvz+Xz+8UqrMWKv5R
         siJE90MM4Vx+nKDSw5cHx66fhWogAnB5gWu3L2dJITzOCq+UCRGvZf715NThL5AY4UEI
         xGtU+zg3NoeM5BsNwSxD1ocWJz57NN/b0MAJDFBjpYuK48wveeDbymltn6aa2VirpHaX
         anc7oQQt5c7BPFAULX/O9s3LT6iG9/qppq/VY98zCZeTQfoUsb2UjuYip+Pz/Anc6zDl
         beTs+lAAJDeB2Iq7t3d59FP4fnhP9yZ4nzaGrEInHdpXIZJbop0s3Bucn0I0r70m1PyD
         6gzQ==
X-Gm-Message-State: AOAM530GdMrjE7X9HiSmp6qpIVn1hE2ONmcErmmLEVR6ODZ8CjAcUJ7B
        bxSNgK31E1jodaD6/8UBEdZFdYoIfM0=
X-Google-Smtp-Source: ABdhPJwOcFp2rtwF6Ia5ObMtewxqDpmTblcX2HjS0nuEXg4QToqNAc79gIEsnJ0eQywtkkDX0ghxMw==
X-Received: by 2002:a1c:2945:: with SMTP id p66mr1126945wmp.110.1611086046503;
        Tue, 19 Jan 2021 11:54:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm5573515wmg.43.2021.01.19.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:06 -0800 (PST)
Message-Id: <1bece72e37ae269c81336a7e8406db1131684383.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:49 +0000
Subject: [PATCH v3 13/17] merge-ort: implement handle_path_level_conflicts()
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
index 86d2214006e..ad8ecb7e448 100644
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

