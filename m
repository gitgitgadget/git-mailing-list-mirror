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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56473C433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253C120776
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikDjjKWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgH2Tq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgH2Tq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 15:46:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7662EC061236
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 12:46:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so2457408ljg.13
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwHndxgmScpIbYfvZMVrqPS+uwQSWUMDyaNvQeSgSbA=;
        b=ikDjjKWv38gUGYzpQQm+3N+o8QyBW4undeZEw3r61KQCT+zYqex01J3xHlV0G546fW
         H1gJklj8L7rY62Vhmv9DcCN4YEc6SkrFXkBZLX4qWhodCxRnmUxT9N9RTi1PjvW61X4L
         BBs8JveWtLJ0IX1HrM2Bjc3JBof1+v80gRTi6cShfWLnDhg7oEmJmgJxt/21F4T/YSNF
         1DQREC+JJ/wxlmmlXNSbglbelZAkumHi3uAGFXz90YChZffciidJR1xMCMCMRGWpJEc0
         RVAt15FfCf7SgaWt5m44jXwJEODJfnEw++s4UnQukL1br5kbHBGzSlUkQmQ1M51It30o
         9yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwHndxgmScpIbYfvZMVrqPS+uwQSWUMDyaNvQeSgSbA=;
        b=bMsHmlGNirC6hR3BHo8y/bvUOUWy5wv0OitDzNgtZL+31T1+z1Yl8g3CAREjVUsywz
         jHX5uOO8+oV1IHeMRFB+Vj7dxkM/acT9jc1bKZwpl3+P6AK/PaNZ0X4UOoANzksYsfeY
         vnT9kTAoREfMQOcG3rJ4ahodtrJZIhDwdZhb5c2tpZdcoAkN0nzev/fmVeGBiJf+fTTH
         O4cTx4Gow+7ztrlysbDw7p7osjUh7Jm87VydFKGibpvgrzaWafMS05Id/h0176fNqJiV
         4kkkc4nCQFCN/ZGuBnU72E+clfjeGau0ySI9YQKdlKwqYmGtDbl1neCW2FtAXCcby27x
         82Fw==
X-Gm-Message-State: AOAM53128VURCls4Hz6esXKPksRJo9/sc496fQZ17zaS2EnErD05V7Lt
        71wbtwHjGSJ4Kv/yAEFhpZ16QQsbOqA=
X-Google-Smtp-Source: ABdhPJyVakfy7s5XXRF5lpvwYsXKeBJ4pf2jhj3/Y7X8x+SC0tGr42Y1PIKkVyr1A4gbLK7ADM29hw==
X-Received: by 2002:a2e:3802:: with SMTP id f2mr1872676lja.212.1598730413080;
        Sat, 29 Aug 2020 12:46:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l25sm816125lfp.48.2020.08.29.12.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 12:46:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] revision: add separate field for "-m" of "diff-index -m"
Date:   Sat, 29 Aug 2020 22:46:34 +0300
Message-Id: <20200829194634.23306-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
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
 diff-lib.c | 10 ++--------
 revision.c |  6 ++++++
 revision.h |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 25fd2dee19c4..8c40111b5f35 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -404,14 +404,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
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
index 6aa7f4f56755..95f9cfddb02c 100644
--- a/revision.c
+++ b/revision.c
@@ -2325,6 +2325,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diffopt.flags.tree_in_recursive = 1;
 	} else if (!strcmp(arg, "-m")) {
 		revs->ignore_merges = 0;
+		/*
+		 * Backward compatibility wart - "diff-index -m" does
+		 * not mean "do not ignore merges", but "match_missing",
+		 * so set separate flag for it.
+		 */
+		revs->diff_index_match_missing = 1;
 	} else if (!strcmp(arg, "-c")) {
 		revs->diff = 1;
 		revs->dense_combined_merges = 0;
diff --git a/revision.h b/revision.h
index f412ae85ebaf..979dddbdaf7c 100644
--- a/revision.h
+++ b/revision.h
@@ -188,6 +188,7 @@ struct rev_info {
 	unsigned int	diff:1,
 			full_diff:1,
 			show_root_diff:1,
+			diff_index_match_missing:1,
 			no_commit_id:1,
 			verbose_header:1,
 			ignore_merges:1,
-- 
2.25.1

