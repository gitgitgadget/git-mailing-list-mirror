Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824FC1FD4F
	for <e@80x24.org>; Sat, 26 May 2018 12:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031561AbeEZMIy (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 08:08:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38551 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031444AbeEZMIw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 08:08:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id 94-v6so13279607wrf.5
        for <git@vger.kernel.org>; Sat, 26 May 2018 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWKphkMYpvRuT0vSVIJZIp3jy6OpmarBDfvF7sDdZH4=;
        b=TsCAtNiLmWKCRZ8g1qzcgumr2U1LbQSe/X/omMtPTF7EZjqS08lTy/Ajj5teH2Uasm
         M6fomFefS01cLJDEezMA8O3dUJUJKWJiOX3x7/u67dyoB9BKGWeFUVXErF7gNqfcfhyY
         ZFXTyXleKkHHGjw2UpLzY6xNhXTPCiPHIQhNTKzFT8LWs9fi2Qf5Zx2QwsLCbBxv736J
         4ZQ6z3BYXXge6fYpz13t0i7MnRa3wObULycgS1GxS7sbinDdG/12Pud5qK1drwQq73Ud
         qXNiUghtel0e5Lk7NA9FBMaigelQe88aWzigchPiJOx1dKRI7TezNxytIlt0gy4gI/Um
         WHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWKphkMYpvRuT0vSVIJZIp3jy6OpmarBDfvF7sDdZH4=;
        b=BPJW+lkuRFFbwo/DfZVRN3s9556wgEYGmXJJtQi5Bzjdxq7YpZ9EMYxETqWVU3bksJ
         LT8Ip62fhl0mU9lCamtloLRLRYbTr0L/fQQKvcwJySvchQ8RGfreBCCYeYgFZyJ3kSLc
         3ptRR14vgPoxy+cvDOXqCgP/ubBLhvjjdZgLJ9wHVG6nSxR0F31ppL5LnDMF4ogSZHNA
         Utv/96j7UwV6MEAcTHAgIafk292SaxdwNL5KOrUndfBR2wc3F3j3KWYepY485JUx0AOq
         WZzhQymTcluyNPA963GCvEllQoRV1B1AaB+d3PbWJo4OFBXj1HZwc77YJFwi3lxf23t1
         4zSw==
X-Gm-Message-State: ALKqPwfgtX2FFArpRF1TDFMiIdWsDRda0xNp1tTmneKWJ5lHbBXaGbW6
        g8opZP0qU1GMyl4l7se2D8o=
X-Google-Smtp-Source: ADUXVKL+rkYCE+i8ZxLKQOqSh1uq3OnXjJZ7svoyqeFn5NTGrP1QQFLvJQLZJC/ONtY2edFHGMD8zQ==
X-Received: by 2002:a19:a401:: with SMTP id q1-v6mr3500668lfc.110.1527336531492;
        Sat, 26 May 2018 05:08:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r81-v6sm4789574lja.36.2018.05.26.05.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 05:08:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 1/4] diff: ignore --ita-[in]visible-in-index when diffing worktree-to-tree
Date:   Sat, 26 May 2018 14:08:43 +0200
Message-Id: <20180526120846.23663-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526120846.23663-1-pclouds@gmail.com>
References: <20180513175438.32152-1-pclouds@gmail.com>
 <20180526120846.23663-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is supposed to fix the diff of "diff-files" (not reporting
ita entries as new files) and "diff-index --cached <tree>" ( showing
ita entries as present in the index with empty content) but not
"diff-index <tree>".

When --ita-invisible-in-index is set on "git diff-index <tree>",
unpack_trees() will eventually call oneway_diff() on the ita entry
with the same code flow as "diff-index --cached <tree>". We want to
ignore the ita entry for "diff-index --cached <tree>" but not
"diff-index <tree>" since the latter will examine and produce a diff
based on worktree entry's (real) content, not ita index entry's
(empty) content.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff-lib.c            | 8 ++++++--
 t/t2203-add-intent.sh | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 104f954a25..a9f38eb5a3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -389,8 +389,12 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	struct rev_info *revs = o->unpack_data;
 	int match_missing, cached;
 
-	/* i-t-a entries do not actually exist in the index */
-	if (revs->diffopt.ita_invisible_in_index &&
+	/*
+	 * i-t-a entries do not actually exist in the index (if we're
+	 * looking at its content)
+	 */
+	if (o->index_only &&
+	    revs->diffopt.ita_invisible_in_index &&
 	    idx && ce_intent_to_add(idx)) {
 		idx = NULL;
 		if (!tree)
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 78236dc7d8..3ab07cb404 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -70,7 +70,7 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
 	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1 &&
-	test $(git diff --name-only --ita-invisible-in-index HEAD -- nitfol | wc -l) = 0 &&
+	test $(git diff --name-only --ita-invisible-in-index HEAD -- nitfol | wc -l) = 1 &&
 	test $(git diff --name-only --ita-invisible-in-index -- nitfol | wc -l) = 1
 '
 
-- 
2.17.0.705.g3525833791

