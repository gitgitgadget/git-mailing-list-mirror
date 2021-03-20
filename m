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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F39C433EA
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB1961991
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCTAEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhCTAEF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10164C061761
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g20so6269068wmk.3
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BUOkwACFk1ATS5lxNPwdjLfxguOc0uEUsQow7Zl+Re4=;
        b=N0M/CmxsSKhzxvCEHbj3l18KZw+JbuymNG80MzTlYQathgpixYDywDNMG2B7nsG/Fo
         Gm2LOe3i+/hVSf0MPKBscbHk9o77g61t7IYu7wcuo4SJnncaI13oS58vOivFY4c4ux7O
         DKvEGueR2H8ckb8ghYBC3NRIdfofXhQ7Q0tJcd0UUeAD+FoGMvTqoPJ9pYzkBjuZHrWz
         GHt1e0udR8din5WZTYkkRzXb/vIZuggno09x0hkFFz/1pTgMJt/4E320ITggl6X/6vop
         T/PK6uXnJMExaTKTDvgxicLKLOp9bAL17eKZh0Gj7gjf0cDKSJd05ynJUkG3GUTAAIRF
         4Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BUOkwACFk1ATS5lxNPwdjLfxguOc0uEUsQow7Zl+Re4=;
        b=Si69SGXAg6Yr3NtL/ng2ahqKObI978x7PSzEj0GYbNpSgvhxjdBb3GFsufmXK6DGa8
         3695spE2hCfTE0CDkWzWF5UghUuHg4LbiM8qsaioiPwNieAo+R5x5eiID/+DHItkHuO3
         AFLd6eynKTDqmkNUo7UeHtoEtFDOIUcUMraPu6zzVnS3T2lb7CZU8PbwlAzB0GrosuqV
         kfwzZ00kkbobTYTKHXjFu0fg1oZSyWFBEX+OVVf+b6gJYaq4urSC9WsxszjPqw1czBO9
         vmf63nHYvJT1DqmSqi6UqEx4/dBZdYFNwxegNQPmLQjfB8ZlOCnLFwfnDBekcS/9k9gi
         KMTg==
X-Gm-Message-State: AOAM532I3pSHgk5iEsmdEjf7JGh3Z5veh+gtZQx2TBv/BQfiWswU2Wv1
        IUs/VgcamFKX7oGvXdnj7U8zvZp9LHQ=
X-Google-Smtp-Source: ABdhPJx1C5bsZiXajBJq8dFNW0KMSq1OgCCivmXk+OsCkIibZMsA1gUfiyczOodfYAhHPK5ia5axaA==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr5730776wmd.36.1616198643852;
        Fri, 19 Mar 2021 17:04:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm11054789wru.6.2021.03.19.17.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:03 -0700 (PDT)
Message-Id: <a37979454069eef830ff19e70a0e998522d30448.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:53 +0000
Subject: [PATCH v3 10/13] merge-recursive: add a bunch of FIXME comments
 documenting known bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
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

