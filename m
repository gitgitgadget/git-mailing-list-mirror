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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10768C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41EC23A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbgLRFwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732318AbgLRFwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B4BC0611CC
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m5so796651wrx.9
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OhtQzFMI2wfrUKk4Dudo41Vcv3rpe9NHzEcS9zY8l0c=;
        b=NNHRBA/DpuafZL+Sndw45Mx8RgF5Kz2IO0Clsa4hOO4258H0KXFgjIuAQ6e4b2neDE
         Ncs807y0XYL6o1y6/7/5GEUgnhWETcpY9LCdDMSgsQOjxiPsKx0dkiB76PLKlncWjA9g
         wq1UsS2UyPcJhg+HVtUJAJ4IumiwS/5u+HyQTmCTDYNwRIqrnGfcwbQeZr2MHquflmrX
         SpSH38l3VjeF94WGAJavPi3zKaN5c8iKa3lFBtDy8mB2lQO8XRPV2UbAzF5wD9L2wo85
         j+Mf0Bz1+qI4dGpZwVvvFyGEJ95M/WrOKDOdN+ZHF9pxG7CIoWKfAXUmh9HiACF0mA8k
         3Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OhtQzFMI2wfrUKk4Dudo41Vcv3rpe9NHzEcS9zY8l0c=;
        b=VkHK7Gzpzso/+ThbPe5Yl3XwkxOMmCgr0oa9T/8qpHiLv+19qBxfL4s8nkrxLkmTmX
         wQSLoK8mNZgj9dHxrtne+KVNKn7+4zFZWa7gXgNERV8mvfRj7lB6aiZiH5CgzLKkj2p6
         N87nNBGMZsa9eoKqHsFL5AQ/0z0aWWjERt9UvsLULKRqSs6zsKthPXSuKvHmxHn5KS30
         YUhEc0slaAWOnYdptDjn4zMtLWZ28ZMogb+oxrSxwoa8W9SXZKidhnVa6NgfQAvpw70E
         jMklfPyZjGCkjlDqL2xCi0Jzp3+EC/mOXgE11ZZut99HPGj9WWDkgeDK4jCUFTMMcTJ6
         swcw==
X-Gm-Message-State: AOAM532Z3YCEc2JjgOLJQq6l38TUqxQPskZgWvbG5eR+cebTa1DlAM0A
        DULgzakIdAnbJlzZcHVekOZRQpnJ/ao=
X-Google-Smtp-Source: ABdhPJy+7rt8/mhgcrImcCAuxS3CVEHnHQvL7sjwD781NpnNJ3EQWQMrujevSYBZo68hUV6OUQranw==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr2268380wrt.324.1608270697878;
        Thu, 17 Dec 2020 21:51:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm106380wrz.18.2020.12.17.21.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:37 -0800 (PST)
Message-Id: <0a5778df2535c12b1ecb1484878e62d37e69d7cb.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:27 +0000
Subject: [PATCH 10/10] merge-ort: add handling for different types of files at
 same path
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

Add some handling that explicitly considers collisions of the following
types:
  * file/submodule
  * file/symlink
  * submodule/symlink
Leaving them as conflicts at the same path are hard for users to
resolve, so move one or both of them aside so that they each get their
own path.

Note that in the case of recursive handling (i.e. call_depth > 0), we
can just use the merge base of the two merge bases as the merge result
much like we do with modify/delete conflicts, binary files, conflicting
submodule values, and so on.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 203fa987e43..afe721182e2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1521,10 +1521,109 @@ static void process_entry(struct merge_options *opt,
 	} else if (ci->filemask >= 6 &&
 		   (S_IFMT & ci->stages[1].mode) !=
 		   (S_IFMT & ci->stages[2].mode)) {
-		/*
-		 * Two different items from (file/submodule/symlink)
-		 */
-		die("Not yet implemented.");
+		/* Two different items from (file/submodule/symlink) */
+		if (opt->priv->call_depth) {
+			/* Just use the version from the merge base */
+			ci->merged.clean = 0;
+			oidcpy(&ci->merged.result.oid, &ci->stages[0].oid);
+			ci->merged.result.mode = ci->stages[0].mode;
+			ci->merged.is_null = (ci->merged.result.mode == 0);
+		} else {
+			/* Handle by renaming one or both to separate paths. */
+			unsigned o_mode = ci->stages[0].mode;
+			unsigned a_mode = ci->stages[1].mode;
+			unsigned b_mode = ci->stages[2].mode;
+			struct conflict_info *new_ci;
+			const char *a_path = NULL, *b_path = NULL;
+			int rename_a = 0, rename_b = 0;
+
+			new_ci = xmalloc(sizeof(*new_ci));
+
+			if (S_ISREG(a_mode))
+				rename_a = 1;
+			else if (S_ISREG(b_mode))
+				rename_b = 1;
+			else {
+				rename_a = 1;
+				rename_b = 1;
+			}
+
+			path_msg(opt, path, 0,
+				 _("CONFLICT (distinct types): %s had different "
+				   "types on each side; renamed %s of them so "
+				   "each can be recorded somewhere."),
+				 path,
+				 (rename_a && rename_b) ? _("both") : _("one"));
+
+			ci->merged.clean = 0;
+			memcpy(new_ci, ci, sizeof(*new_ci));
+
+			/* Put b into new_ci, removing a from stages */
+			new_ci->merged.result.mode = ci->stages[2].mode;
+			oidcpy(&new_ci->merged.result.oid, &ci->stages[2].oid);
+			new_ci->stages[1].mode = 0;
+			oidcpy(&new_ci->stages[1].oid, &null_oid);
+			new_ci->filemask = 5;
+			if ((S_IFMT & b_mode) != (S_IFMT & o_mode)) {
+				new_ci->stages[0].mode = 0;
+				oidcpy(&new_ci->stages[0].oid, &null_oid);
+				new_ci->filemask = 4;
+			}
+
+			/* Leave only a in ci, fixing stages. */
+			ci->merged.result.mode = ci->stages[1].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+			ci->stages[2].mode = 0;
+			oidcpy(&ci->stages[2].oid, &null_oid);
+			ci->filemask = 3;
+			if ((S_IFMT & a_mode) != (S_IFMT & o_mode)) {
+				ci->stages[0].mode = 0;
+				oidcpy(&ci->stages[0].oid, &null_oid);
+				ci->filemask = 2;
+			}
+
+			/* Insert entries into opt->priv_paths */
+			assert(rename_a || rename_b);
+			if (rename_a) {
+				a_path = unique_path(&opt->priv->paths,
+						     path, opt->branch1);
+				strmap_put(&opt->priv->paths, a_path, ci);
+			}
+
+			if (rename_b)
+				b_path = unique_path(&opt->priv->paths,
+						     path, opt->branch2);
+			else
+				b_path = path;
+			strmap_put(&opt->priv->paths, b_path, new_ci);
+
+			if (rename_a && rename_b) {
+				strmap_remove(&opt->priv->paths, path, 0);
+				/*
+				 * We removed path from opt->priv->paths.  path
+				 * will also eventually need to be freed, but
+				 * it may still be used by e.g.  ci->pathnames.
+				 * So, store it in another string-list for now.
+				 */
+				string_list_append(&opt->priv->paths_to_free,
+						   path);
+			}
+
+			/*
+			 * Do special handling for b_path since process_entry()
+			 * won't be called on it specially.
+			 */
+			strmap_put(&opt->priv->conflicted, b_path, new_ci);
+			record_entry_for_tree(dir_metadata, b_path,
+					      &new_ci->merged);
+
+			/*
+			 * Remaining code for processing this entry should
+			 * think in terms of processing a_path.
+			 */
+			if (a_path)
+				path = a_path;
+		}
 	} else if (ci->filemask >= 6) {
 		/* Need a two-way or three-way content merge */
 		struct version_info merged_file;
-- 
gitgitgadget
