Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE7EC5517A
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBFC20656
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrGF7JYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgKHVlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgKHVlY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:24 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D19C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:24 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so1132991ljj.6
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APfTNBqeu4NGszmHhOTAYqEdziEeMIGvS7s1xDEERjc=;
        b=YrGF7JYxewEGYpWs/hhxFORoupOLN3PO+2T/LJqTSnmgn7/V4OPY+5ELrl3Xy+Paex
         Ra1YgjMRuxUQc0a7BnyeOrGVD0kpRyFcXQ3d9PSCcdNylRScMVdetQZvXQJlKunxbTJn
         y2WK0Lb3mrmSn6NYK0mBScJD5R0ea8QwBsEJIfWE6MEtaBVZzw7tYFVGVJ9vMA99O6Bn
         qfKudeW9xS5N1U3CJHT8VBZf3VKwQKFuLyuwy5h2OIN5Bj5kYBdcreD9+v3ujw0SY4HT
         HnB62JpLIsPS2dizH9n23LOLSr5dzex55WW5VkSshaLp1HrUduI6IOlkf9V3i7aKEgIU
         xG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APfTNBqeu4NGszmHhOTAYqEdziEeMIGvS7s1xDEERjc=;
        b=K+BKZmJxyYeMtcxEjxdmGWHFzUd+GUx5GotPuqAU7uv+vwps5DhCYhQs56PW8UoOjk
         1g1lAH5LF5BZ0kkwOcxFkjiysmUINDNEltHAdtZT0nhXTB7fW7sER9bel0ylBXsq6n+T
         1fRYfzCuVYBD7D4cY/GAtiC2h6+3JtLMhyUuX8QvB+lu8Z46WPRWjbcLCOx8QHBa0liA
         tvnbi1NZbSlbeVZiKrmFIw4hZyOmGkfUnDXKkq9AHoHZDKY5LAfEDwGMWgB2ptretEwz
         thJ4oQLTHLzwoMQYynGe9tuoUoMmkxCnwPyU8Dfex6VnG63SvHcmiU1UcVzdiOza5s3Z
         UkWg==
X-Gm-Message-State: AOAM533tuBJFLxqYnXwpv3V7+SYfqeVZp/69mUlEcSqj5qwU68+85PWZ
        PPZPoaLdTFlcCr5yLZAzonI=
X-Google-Smtp-Source: ABdhPJzYemhdr/BrPhexM7uVALi/G1cGABUkJHjaK08C3J2dREj9IzR40CiAerPJzlHvVfREob0NoQ==
X-Received: by 2002:a2e:3206:: with SMTP id y6mr4468970ljy.176.1604871682708;
        Sun, 08 Nov 2020 13:41:22 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:22 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 03/27] revision: factor out initialization of diff-merge related settings
Date:   Mon,  9 Nov 2020 00:38:14 +0300
Message-Id: <20201108213838.4880-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move initialization code related to diffing merges into new
init_diff_merge_revs() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 739295bb9ff4..bc568fb79778 100644
--- a/revision.c
+++ b/revision.c
@@ -1805,6 +1805,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
+static void init_diff_merge_revs(struct rev_info *revs);
+
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix)
@@ -1813,7 +1815,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = -1;
+	init_diff_merge_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
@@ -2153,6 +2155,10 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static void init_diff_merge_revs(struct rev_info *revs) {
+	revs->ignore_merges = -1;
+}
+
 static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
 	int argcount;
 	const char *optarg;
-- 
2.25.1

