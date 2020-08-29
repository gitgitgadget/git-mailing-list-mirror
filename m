Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9D3C433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA5620774
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 20:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m35QEMNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgH2UMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgH2UMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 16:12:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE09C061236
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 13:12:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e11so2528820ljn.6
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNArhxIi92RreaCel7G3aEvzcVbTAJs9r7IpAPqLAbk=;
        b=m35QEMNXdstGM3BY4PofDd10P1ECT9Atn+4WgOmwiRW52VcKdhzNw8sB0+DFT2cbAE
         BByLGgOSs70LKC8WbeEMd7r8lprH2APnPVC004TCL5Fh1NJ0pYGh6/DoYDjfY1gYpo1Y
         nn4w0oesv+qvuXzVe82qxo/Y8PxHwCJp8cm7Ua2AbfWs8tGyId8rvBPmYSNhfJjbLC10
         aHX+2Q8XbtoGeO1PTgXSyueFUeABGz3VWXhOOHgm3Io2G77LbutTUWqNqz+x6l39ckwQ
         4twomy+qbfbKIV8U+eNqipaqPcU5EbINWVdu6gs9+5gCyaQDLW+a9VYrHvyySDvJOibL
         fK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNArhxIi92RreaCel7G3aEvzcVbTAJs9r7IpAPqLAbk=;
        b=OYeuoXUqrb70EW0C3GmH1dxq2lm6EqqoSMjTJkWAF4t+D6UMSrdkz72s84aoN3UWfM
         3/dcfGnEEEXkAw9QzjFJeocC1jGGx3Tkc2a+qSnyNO6m3BSXN7ZP+LyiT57RUMVf354h
         ni9EFetX21XbliikG6dmR1SGps91stFxGk1pSmWbn/a7RJWxKm9cxB3XFass3c83dXWZ
         vsEbtWueosh0uQaPXj/Fryo1pr7fWFvCIQGd2hEJKiKP0miQmqIieuWcQO59gvZU8XgY
         00PKemgs4kY4en0qc+jj5R+6F0nZCFa3u4oYwi0j5X5yc4KLajEdZ+n8meZ3VStJ5TrV
         Uv0g==
X-Gm-Message-State: AOAM5300lNb9zbyWLfwEqMg/oyTNE7gEgraMKJS3Q+V6Mcq90P/Kv15S
        yl5IxrUr9aFdKqPwR1flCpGqBwMkI04=
X-Google-Smtp-Source: ABdhPJzVYSq9/gwCB8Y5E0BdsV3UOs3MFqinj1qYv3JiPN7IV2Z2sRTr8/owazaXrz3nHBvizd8oFQ==
X-Received: by 2002:a2e:8ecc:: with SMTP id e12mr1894125ljl.33.1598731936421;
        Sat, 29 Aug 2020 13:12:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u11sm657811ljh.17.2020.08.29.13.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 13:12:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2] revision: add separate field for "-m" of "diff-index -m"
Date:   Sat, 29 Aug 2020 23:11:40 +0300
Message-Id: <20200829201140.23425-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200829194634.23306-1-sorganov@gmail.com>
References: <20200829194634.23306-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Historically, in "diff-index -m", "-m" does not mean "do not ignore merges", but
"match missing". Despite this, diff-index abuses 'ignore_merges' field being set
by "-m", that in turn causes more troubles.

Add separate 'diff_index_match_missing' field for diff-index to use and set it
when we encounter "-m" option. This field won't then be cleared when primary
meaning of "-m" is reverted (e.g., by "--no-diff-merges"), nor it will be
affected by future option(s) that might drive 'ignore_merges' field.

Use this new field from diff-lib:do_oneway_diff() instead of abusing
'ignore_merges' field.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

v2: rebased from 'maint' onto 'master'

 diff-lib.c | 10 ++--------
 revision.c |  6 ++++++
 revision.h |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 50521e2093fc..f2aee78e7aa2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -405,14 +405,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	/* if the entry is not checked out, don't examine work tree */
 	cached = o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
-	/*
-	 * Backward compatibility wart - "diff-index -m" does
-	 * not mean "do not ignore merges", but "match_missing".
-	 *
-	 * But with the revision flag parsing, that's found in
-	 * "!revs->ignore_merges".
-	 */
-	match_missing = !revs->ignore_merges;
+
+	match_missing = revs->diff_index_match_missing;
 
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
diff --git a/revision.c b/revision.c
index 96630e31867d..64b16f7d1033 100644
--- a/revision.c
+++ b/revision.c
@@ -2345,6 +2345,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diffopt.flags.tree_in_recursive = 1;
 	} else if (!strcmp(arg, "-m")) {
 		revs->ignore_merges = 0;
+		/*
+		 * Backward compatibility wart - "diff-index -m" does
+		 * not mean "do not ignore merges", but "match_missing",
+		 * so set separate flag for it.
+		 */
+		revs->diff_index_match_missing = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		if (!strcmp(optarg, "off")) {
 			revs->ignore_merges = 1;
diff --git a/revision.h b/revision.h
index c1e5bcf139d7..5ae8254ffaed 100644
--- a/revision.h
+++ b/revision.h
@@ -188,6 +188,7 @@ struct rev_info {
 	unsigned int	diff:1,
 			full_diff:1,
 			show_root_diff:1,
+			diff_index_match_missing:1,
 			no_commit_id:1,
 			verbose_header:1,
 			combine_merges:1,
-- 
2.25.1

