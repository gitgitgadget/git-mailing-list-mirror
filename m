Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE2C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKBWBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKBWBu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:01:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E59FDC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:01:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v7so44173wmn.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkXnShDT+bgE/eNK3xMrOsSJBFOcZA1BKzgE6P8twfY=;
        b=f/dvavFbiXoyBJ9IgE3HarwT1X2lWCWykVNWraQkMkp9Y/jI9UL00nKqbtN47nGSA3
         jVt07VihXxWNGoTtVxo9U5gvgJn/Rj4cX9qGWWOowzddtlDadyTJa5vJ50V9r6WIYIB5
         0h5tmbXGkCWlswz1UOlVtakFM6NU/oHLpO2Xz9oyAg1dti5rX2I6XU9vJqm6OzOOrbFW
         FqKoT10ypvwFnfIG7P+br7LRAs05fUEL2mk7L4OdiDJvJ2u+5NMzAehcUU7MACAXg9SX
         E9kF7Y9D4SuVK86WPVY5Mu2ccJvos63wQFJGRhL1pdTkcSu/UX3GY0LcyYa+WxMytsgC
         yGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkXnShDT+bgE/eNK3xMrOsSJBFOcZA1BKzgE6P8twfY=;
        b=ZiiW37on/nhfECHoz2hC7zS2qEhYikRwA/j4ac9EuSuiNjrhzJkhH7xcEgMpMJO/52
         XQin7eFSU6dVyrVdLzQz0qqfVqnyQh7zK3z4wS2teoEoBeLq+N8IUXOhtvuZTA5hovkb
         OwI4Wf0ZofDalTwuQ4hSCD9Ca1kMtG5qtnKK6bREJoZrJGyLPrYoe0TV7G9lg9w5ae8n
         a+THrfi/XXd0EqhHrjyDulBkODhNBBKjFEYK8JN35AShJmkj/cw4YqbxjB7/xHPpNF5H
         laE4NQen8gSwhhxHUBB9F3X+8hkr1JLHuq+DMc2EEv634GjsPfuv+SyMdggXTLh335jz
         O3pQ==
X-Gm-Message-State: ACrzQf1ByH7iBocVwACNcMGmvk3OMcGSpQ+pqDEV1HaZveMlXXKt5wdP
        O+4Gfn+N4cdyPqAt1AIvO2pjy+m1/zM=
X-Google-Smtp-Source: AMsMyM7QPSWTwe9d7N/uTE0tMIIi5gEMTdkp902zvhxj9Wr+Wk8Pbl5yfOBmJ/S4jFgvZ523sCV2xw==
X-Received: by 2002:a7b:cd99:0:b0:3cf:7556:a52c with SMTP id y25-20020a7bcd99000000b003cf7556a52cmr10807816wmj.53.1667426507729;
        Wed, 02 Nov 2022 15:01:47 -0700 (PDT)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf894c05e4sm1613080wmq.22.2022.11.02.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:01:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, man dog <dogman888888@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] line-log: free diff queue when processing non-merge commits
Date:   Wed,  2 Nov 2022 23:01:40 +0100
Message-Id: <20221102220142.574890-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.1.564.g99c012faba
In-Reply-To: <20221102220142.574890-1-szeder.dev@gmail.com>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When processing a non-merge commit, the line-level log first asks the
tree-diff machinery whether any of the files in the given line ranges
were modified between the current commit and its parent, and if some
of them were, then it loads the contents of those files from both
commits to see whether their line ranges were modified and/or need to
be adjusted.  Alas, it doesn't free() the diff queue holding the
results of that query and the contents of those files once its done.
This can add up to a substantial amount of leaked memory, especially
when the file in question is big and is frequently modified: a user
reported "Out of memory, malloc failed" errors with a 2MB text file
that was modified ~2800 times [1] (I estimate the leak would use up
almost 11GB memory in that case).

Free that diff queue to plug this memory leak.  However, instead of
simply open-coding the necessary three lines, add them as a helper
function to the diff API, because it will be useful elsewhere as well.

[1] https://public-inbox.org/git/CAFOPqVXz2XwzX8vGU7wLuqb2ZuwTuOFAzBLRM_QPk+NJa=eC-g@mail.gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 diff.c     | 7 +++++++
 diffcore.h | 1 +
 line-log.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/diff.c b/diff.c
index 35e46dd968..ef94175163 100644
--- a/diff.c
+++ b/diff.c
@@ -5773,6 +5773,13 @@ void diff_free_filepair(struct diff_filepair *p)
 	free(p);
 }
 
+void diff_free_queue(struct diff_queue_struct *q)
+{
+	for (int i = 0; i < q->nr; i++)
+		diff_free_filepair(q->queue[i]);
+	free(q->queue);
+}
+
 const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 {
 	int abblen;
diff --git a/diffcore.h b/diffcore.h
index badc2261c2..9b588a1ee1 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -162,6 +162,7 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *,
 				 struct diff_filespec *,
 				 struct diff_filespec *);
 void diff_q(struct diff_queue_struct *, struct diff_filepair *);
+void diff_free_queue(struct diff_queue_struct *q);
 
 /* dir_rename_relevance: the reason we want rename information for a dir */
 enum dir_rename_relevance {
diff --git a/line-log.c b/line-log.c
index 51d93310a4..7a74daf2e8 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1195,6 +1195,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	if (parent)
 		add_line_range(rev, parent, parent_range);
 	free_line_log_data(parent_range);
+	diff_free_queue(&queue);
 	return changed;
 }
 
-- 
2.38.1.564.g99c012faba

