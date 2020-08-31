Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E32EC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381EB20866
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 12:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9qtxSxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaMyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaMyI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 08:54:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2599CC061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 05:54:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so5472483ljk.8
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYjuehw4UGZd5FnOTEvhaTWSB2JJSNMUGp3AoC0j1L0=;
        b=K9qtxSxRcg9kZe6XeInpL3sH7WANjX5c2JUcZqnb1q4OPM22TPfsYk4vMiTw+Z1Slf
         n2YioQYNGKiyr+b2U0Y5dpKGYDS2E9j4jjQULRl4Q5hWxpZ0phNozBpSNTCXs5ji57Nd
         2HU4SVSByws3U430i/Z/8fTvhbzsq+8xZ6Di7GhIxsmCn0JsWe4YYfDp2yjVc6169dg8
         8HORNFLKBlrK1hVuaRNylmsntoxkLVj028VSb+AhBq14g0pGRAjoT1hBKGmdQBy7E1+t
         WITCZ9KzPaVUK98DjDoSaD6Q2lzZyRZyI/G6Ta+Zy/4czBaBFIx949x7nw2IRc4mPhPg
         1a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYjuehw4UGZd5FnOTEvhaTWSB2JJSNMUGp3AoC0j1L0=;
        b=TyKEkVdGw6R45rqlUAbc6EbDAvLALw6CcozP8GvH31eYtx5jXVEl49pIcGYYJ1ZeJV
         Df/kZs6QUjaQlTB88tJbDbXShqo0xmXrMqDCN9MIfplilmLaBEW5EDwg+B/BXx92+Fsi
         X6LtCx16M7um6WIv9JrR/Xa0gLJudq8iWp/jjwV5Hu0UASNlbOVGvpEXC44wszB96O7p
         lOHs1a4Cqevk14KUGAAahZWJWJf1KnB+SMI7qFyd5TYmyPiFtQzJlzMa/zyd2gXC2f8Y
         qn0yQ20wcgEayKVEG2zasEHOxJhNbb8jNWZZ+UOuiHZPlWVLe3SGIJy/0LQzl6apax1S
         me3A==
X-Gm-Message-State: AOAM530/FimLqpIMODqzjM3rtc17sRBxRxSbmzT7IalIIZ+cnNv85x+u
        W/leCazLkBlrecyi2XRMcc8=
X-Google-Smtp-Source: ABdhPJzF9asW5Z2Yu0lmY96zBTAFYRqwgLWoYPwWp7TJJ01xCjeiZEeSR6p5AqwIAImMzWmc0wMaJw==
X-Received: by 2002:a2e:a483:: with SMTP id h3mr647261lji.76.1598878445467;
        Mon, 31 Aug 2020 05:54:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h22sm336685ljl.101.2020.08.31.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:54:04 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3] revision: add separate field for "-m" of "diff-index -m"
Date:   Mon, 31 Aug 2020 15:53:50 +0300
Message-Id: <20200831125350.26472-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200829194634.23306-1-sorganov@gmail.com>
References: <20200829194634.23306-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add separate 'diff_index_match_missing' field for diff-index to use and set it
when we encounter "-m" option. This field won't then be cleared when another
meaning of "-m" is reverted (e.g., by "--no-diff-merges"), nor it will be
affected by future option(s) that might drive 'ignore_merges' field.

Use this new field from diff-lib:do_oneway_diff() instead of reusing
'ignore_merges' field.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

v3: improve commit message

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

