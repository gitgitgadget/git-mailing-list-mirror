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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCCDC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33E0613D3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhGPFZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhGPFZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:25:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2969C061764
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a13so10560025wrf.10
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=su06NTFGL/a6GAwdlcN//jEahy3rYPk4j+HogleNbSU=;
        b=bHPbox5QTnXTaNELOqPzpO7wwgmnljariZ29ihadA0ir51ZE6umC6nzyhbOX1bHyJH
         fkvLGL5QN+sBScW3O89v97o1HcY1D/N2IoJP2zbc9gKG2ZPzATaD+WtvkE6vHqJuLcsb
         fvn44AQVtBBNAs3GfdOTgUB7+jkR9VB38w0tcMFfyl03cNmY4VUqbBgqxUlwkIdtxOId
         Hbkd8XSMqgYw8NA1EczJcUY3c5gN8AJ9G7wyWcSBlTc9k6M7rigZ5hpI1JticPpvOI9Q
         XdY7sd+N+ElASx5RuR99deFSPUSzfGu+j9+fEcT/5BF1EYdToh/t4skNaiJJ9KEpoBmh
         qhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=su06NTFGL/a6GAwdlcN//jEahy3rYPk4j+HogleNbSU=;
        b=G/A3Vgv/U4KryW7zyxAdJQsADiyzw6NBH9s7O6Iz4njI4JxpjoeSid01D9C/B15ALT
         0k2K7mqMPf/YmvoxN4WuinlT1FyEo+xhGj2/KczWBnovv2gGUfIfXn3imVTi6jNXgbfo
         7PYJevgiNO+4FNoAqqCIPS2t/ZEhrWh3w+8vleQAqoEMsGZvHBkU4hyGtO9Jdk0ZTMfr
         p4OP4irVYUeDTKQeprWM70KIep/jfoJY6akyVnYGijUxfBqspDBBkz4uIRvqgdonHlx6
         18oF9nLQrJaQlMQpRttwKD9jTv7fOkFakQxKLS88o6FMLj9zDqc6ZdLK4jSnxDMp3cFu
         VGhA==
X-Gm-Message-State: AOAM533HtA+ughuxMxYCr8N8Pmlw6WmbChqVJ6f1mTU8Mx37B9noCSV4
        rKnozeYFqHwc30YKje5vbeStsvxmHdI=
X-Google-Smtp-Source: ABdhPJzTxL0P51jzLlPspB40aD7gzozjJdfC3+eyF+V/3DVAQsFsKxp3YYRFerBYpsfVDDrCg1qWWg==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr10016340wrv.234.1626412961202;
        Thu, 15 Jul 2021 22:22:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o28sm9500462wra.71.2021.07.15.22.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:22:40 -0700 (PDT)
Message-Id: <c2b45fef1d75046f8cf3c7ab04e044df33795770.1626412958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
        <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 05:22:33 +0000
Subject: [PATCH v3 3/7] merge-ort: add data structures for allowable trivial
 directory resolves
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted a few commits ago, we can resolve individual files early if all
three sides of the merge have a file at the path and two of the three
sides match.  We would really like to do the same thing with
directories, because being able to do a trivial directory resolve means
we don't have to recurse into the directory, potentially saving us a
huge amount of time in both collect_merge_info() and process_entries().
Unfortunately, resolving directories early would mean missing any
renames whose source or destination is underneath that directory.

If we somehow knew there weren't any renames under the directory in
question, then we could resolve it early.  Sadly, it is impossible to
determine whether there are renames under the directory in question
without recursing into it, and this has traditionally kept us from ever
implementing such an optimization.

In commit f89b4f2bee ("merge-ort: skip rename detection entirely if
possible", 2021-03-11), we added an additional reason that rename
detection could be skipped entirely -- namely, if no *relevant* sources
were present.  Without completing collect_merge_info_callback(), we do
not yet know if there are no relevant sources.  However, we do know that
if the current directory on one side matches the merge base, then every
source file within that directory will not be RELEVANT_CONTENT, and a
few simple checks can often let us rule out RELEVANT_LOCATION as well.
This suggests we can just defer recursing into such directories until
the end of collect_merge_info.

Since the deferred directories are known to not add any relevant sources
due to the above properties, then if there are no relevant sources after
we've traversed all paths other than the deferred ones, then we know
there are not any relevant sources.  Under those conditions, rename
detection is unnecessary, and that means we can resolve the deferred
directories without recursing into them.

Note that the logic for skipping rename detection was also modified
further in commit 76e253793c ("merge-ort, diffcore-rename: employ cached
renames when possible", 2021-01-30); in particular rename detection can
be skipped if we already have cached renames for each relevant source.
We can take advantage of this information as well with our deferral of
recursing into directories where one side matches the merge base.

Add some data structures that we will use to do these deferrals, with
some lengthy comments explaining their purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 843fa693145..d9263ec5aca 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -62,6 +62,53 @@ struct traversal_callback_data {
 	struct name_entry names[3];
 };
 
+struct deferred_traversal_data {
+	/*
+	 * possible_trivial_merges: directories to be explored only when needed
+	 *
+	 * possible_trivial_merges is a map of directory names to
+	 * dir_rename_mask.  When we detect that a directory is unchanged on
+	 * one side, we can sometimes resolve the directory without recursing
+	 * into it.  Renames are the only things that can prevent such an
+	 * optimization.  However, for rename sources:
+	 *   - If no parent directory needed directory rename detection, then
+	 *     no path under such a directory can be a relevant_source.
+	 * and for rename destinations:
+	 *   - If no cached rename has a target path under the directory AND
+	 *   - If there are no unpaired relevant_sources elsewhere in the
+	 *     repository
+	 * then we don't need any path under this directory for a rename
+	 * destination.  The only way to know the last item above is to defer
+	 * handling such directories until the end of collect_merge_info(),
+	 * in handle_deferred_entries().
+	 *
+	 * For each we store dir_rename_mask, since that's the only bit of
+	 * information we need, other than the path, to resume the recursive
+	 * traversal.
+	 */
+	struct strintmap possible_trivial_merges;
+
+	/*
+	 * trivial_merges_okay: if trivial directory merges are okay
+	 *
+	 * See possible_trivial_merges above.  The "no unpaired
+	 * relevant_sources elsewhere in the repository" is a single boolean
+	 * per merge side, which we store here.  Note that while 0 means no,
+	 * 1 only means "maybe" rather than "yes"; we optimistically set it
+	 * to 1 initially and only clear when we determine it is unsafe to
+	 * do trivial directory merges.
+	 */
+	unsigned trivial_merges_okay;
+
+	/*
+	 * target_dirs: ancestor directories of rename targets
+	 *
+	 * target_dirs contains all directory names that are an ancestor of
+	 * any rename destination.
+	 */
+	struct strset target_dirs;
+};
+
 struct rename_info {
 	/*
 	 * All variables that are arrays of size 3 correspond to data tracked
@@ -119,6 +166,8 @@ struct rename_info {
 	 */
 	struct strintmap relevant_sources[3];
 
+	struct deferred_traversal_data deferred[3];
+
 	/*
 	 * dir_rename_mask:
 	 *   0: optimization removing unmodified potential rename source okay
@@ -501,6 +550,11 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 				strmap_clear(&renames->dir_rename_count[i], 1);
 		}
 	}
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
+		strintmap_func(&renames->deferred[i].possible_trivial_merges);
+		strset_func(&renames->deferred[i].target_dirs);
+		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
+	}
 	renames->cached_pairs_valid_side = 0;
 	renames->dir_rename_mask = 0;
 
@@ -4052,6 +4106,13 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 		strset_init_with_options(&renames->cached_target_names[i],
 					 NULL, 0);
 	}
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
+		strintmap_init_with_options(&renames->deferred[i].possible_trivial_merges,
+					    0, NULL, 0);
+		strset_init_with_options(&renames->deferred[i].target_dirs,
+					 NULL, 1);
+		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
+	}
 
 	/*
 	 * Although we initialize opt->priv->paths with strdup_strings=0,
-- 
gitgitgadget

