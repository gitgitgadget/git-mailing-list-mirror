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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A86FC43332
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93B0652B3
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhCIGZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhCIGYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25FAC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so13929374wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BUOkwACFk1ATS5lxNPwdjLfxguOc0uEUsQow7Zl+Re4=;
        b=nZMLnj7E9lChSepsgY2L4yV+93JFE9b8ZJ6kVmykIL+E6+r8VfOLb0hI9os4PJQ1L/
         sf++oziV6Z310wy8UCQrnGS6zqzcWZ0n6EnTFU1d/Gd6hpcsLFHOLUGvewHzJY4eKzTa
         TidUyFeZ8CSMNtdRCsqZesmU/5OSm3qUBuFv5S4wWMYK0RrbKzy9MpjJgkkEgjGBWHlU
         J7r7TaYhmApj7ceh/IMdDbjOBDG7Fmeo/Dg5Ttp6xc+Ph/32jRSBWoBPgJmO2GEAkFYS
         3rIVOfUDYGXbvCXOLvACfiLO04D/LbNab28Czd3bXqgyaaiuydruEM93r613SbsuAzUV
         rSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BUOkwACFk1ATS5lxNPwdjLfxguOc0uEUsQow7Zl+Re4=;
        b=cJpCgFEZ5X5g0Cmxm9MCpOxYDzfIcCrCclR7uzhQSdlxa6NgjAkVnjRe11u/MU+OX3
         hTTbnXf5pyh0JWz7GnuPhtOhxn6XVAjiD0aYw0zEjlYu33lTgwdS2rCms6/R15TnxvQ9
         xA0XjxpLwsKw6lqii3a7kmK+fnJv3t9oSHQLs4sSLb/1LYVEIb8xXslDx+RcBw6watrI
         1t2p1GOKzkwjLo4icRuwzhEvOtOAnZ3Rro87VORWYxv8V/ovkzgCSrzItFDjdcfIIBIX
         lFOFuV7h6f5O4+41bYGSFxeVBvB/F7FkbCRI1ZLqCheRgKzbHp6J+GzEZ2avM/vS63F6
         tlOQ==
X-Gm-Message-State: AOAM530f/S/fkfiiPGZq8qJsbKr7sL8h+LL6jnghibYcYeboI+9LMpb7
        os0zgSLTmoLJewttvVbG5A9thS/ciys=
X-Google-Smtp-Source: ABdhPJyB9+AZJdmxCWoveb/RTmwTgXbB987h6w9tOOhCwB1xPBHJnMWVcWCxgQ79MMCHiGu7m7aaVw==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr15394240wrv.340.1615271093411;
        Mon, 08 Mar 2021 22:24:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm22733881wrt.70.2021.03.08.22.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:53 -0800 (PST)
Message-Id: <a9a95bb0391f23b15a6500fbf3282da0668e1d82.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:45 +0000
Subject: [PATCH v2 10/10] merge-recursive: add a bunch of FIXME comments
 documenting known bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The plan is to just delete merge-recursive, but not until everyone is
comfortable with merge-ort as a replacement.  Given that I haven't
switched all callers of merge-recursive over yet (e.g. git-am still uses
merge-recursive), maybe there's some value documenting known bugs in the
algorithm in case we end up keeping it or someone wants to dig it up in
the future.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index b052974f191c..99a197597db5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1075,6 +1075,11 @@ static int merge_3way(struct merge_options *opt,
 	read_mmblob(&src1, &a->oid);
 	read_mmblob(&src2, &b->oid);
 
+	/*
+	 * FIXME: Using a->path for normalization rules in ll_merge could be
+	 * wrong if we renamed from a->path to b->path.  We should use the
+	 * target path for where the file will be written.
+	 */
 	merge_status = ll_merge(result_buf, a->path, &orig, base,
 				&src1, name1, &src2, name2,
 				opt->repo->index, &ll_opts);
@@ -1154,6 +1159,8 @@ static void print_commit(struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
+	/* FIXME: Merge this with output_commit_title() */
+	assert(!merge_remote_util(commit));
 	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
@@ -1177,6 +1184,11 @@ static int merge_submodule(struct merge_options *opt,
 	int search = !opt->priv->call_depth;
 
 	/* store a in result in case we fail */
+	/* FIXME: This is the WRONG resolution for the recursive case when
+	 * we need to be careful to avoid accidentally matching either side.
+	 * Should probably use o instead there, much like we do for merging
+	 * binaries.
+	 */
 	oidcpy(result, a);
 
 	/* we can not handle deletion conflicts */
@@ -1301,6 +1313,13 @@ static int merge_mode_and_contents(struct merge_options *opt,
 
 	if ((S_IFMT & a->mode) != (S_IFMT & b->mode)) {
 		result->clean = 0;
+		/*
+		 * FIXME: This is a bad resolution for recursive case; for
+		 * the recursive case we want something that is unlikely to
+		 * accidentally match either side.  Also, while it makes
+		 * sense to prefer regular files over symlinks, it doesn't
+		 * make sense to prefer regular files over submodules.
+		 */
 		if (S_ISREG(a->mode)) {
 			result->blob.mode = a->mode;
 			oidcpy(&result->blob.oid, &a->oid);
@@ -1349,6 +1368,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 			free(result_buf.ptr);
 			if (ret)
 				return ret;
+			/* FIXME: bug, what if modes didn't match? */
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
 			result->clean = merge_submodule(opt, &result->blob.oid,
@@ -2664,6 +2684,14 @@ static int process_renames(struct merge_options *opt,
 	struct string_list b_by_dst = STRING_LIST_INIT_NODUP;
 	const struct rename *sre;
 
+	/*
+	 * FIXME: As string-list.h notes, it's O(n^2) to build a sorted
+	 * string_list one-by-one, but O(n log n) to build it unsorted and
+	 * then sort it.  Note that as we build the list, we do not need to
+	 * check if the existing destination path is already in the list,
+	 * because the structure of diffcore_rename guarantees we won't
+	 * have duplicates.
+	 */
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
 		string_list_insert(&a_by_dst, sre->pair->two->path)->util
@@ -3602,6 +3630,15 @@ static int merge_recursive_internal(struct merge_options *opt,
 			return err(opt, _("merge returned no commit"));
 	}
 
+	/*
+	 * FIXME: Since merge_recursive_internal() is only ever called by
+	 * places that ensure the index is loaded first
+	 * (e.g. builtin/merge.c, rebase/sequencer, etc.), in the common
+	 * case where the merge base was unique that means when we get here
+	 * we immediately discard the index and re-read it, which is a
+	 * complete waste of time.  We should only be discarding and
+	 * re-reading if we were forced to recurse.
+	 */
 	discard_index(opt->repo->index);
 	if (!opt->priv->call_depth)
 		repo_read_index(opt->repo);
-- 
gitgitgadget
