Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C361FC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiBXUjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiBXUjM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A33179A1C
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso511017wms.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tUGBrtR8fCTyhqvvqnKVppxM2ptCHhFGGvYSmMm2j4c=;
        b=IWXRA1uYcbfFJl0zQwa2q1cjS79f66zFS/e1axO6H7kCj33Mkvp2MYhTPqISYg9osP
         SBFPEeweOM1T996+7rDh88CApFwKgl0f10F7I9e/eStxKVOFbhclm0erfV7wQ+Ks7SMc
         tcHPP6UN3I3m0TNgnENUzGn2q/FchScxIA56zIhysViX9y5kUbuTiIh5J3yaOgFUdI1D
         CR+n1eDmn2Fx+y7Xam2uSjpbluSzTv54n1l5S7M5JKNBb2PH6/lOingYJ1S/xX8u/hoI
         sLlMi0N0oLNUkLwRdvjUp37J+5ywovmQvPKqJJwiesho8Va6+kgIf3yvCUWeCmsXt7v7
         9QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tUGBrtR8fCTyhqvvqnKVppxM2ptCHhFGGvYSmMm2j4c=;
        b=Pkz7H58eTbh/qd7o5A4R6SuoPocKfqMg6ZOHV01KGSZXsAR24KUtlrvINGhUM2u1e9
         ehJYksJTsT+DGIy3392dBP/5rHjHULehyme3f6wxru2sgVh8xSS5zWCr2zqjUs4//ftF
         k0q67u8axx+5qt28zWVmDVt6fVx/1fMJhP1Rlfgn8ejc6XHo9nZQd6WO2xaqbQi5iBeg
         3gFIi9cVBpqHmLQwKss1GsXpaiItuuynJwxbE1tZR8cCbiUBhnKs4+z+J548pJ6JoDqK
         CAXV3apmsQ2wGnOfPUiBwBQp3D+gyRpFhznoNcPunkzMx+PIpB4oNJKpYXtokmTWFWFw
         F6bQ==
X-Gm-Message-State: AOAM531UcxTWpdltO06t4UjDrxaDx8/tdzhiyTVsIhciNj46xfNXBAh0
        4ivsEISTKFV+rGoezotzDqqYPqvtjQw=
X-Google-Smtp-Source: ABdhPJwhxK+HPtykjEt5uZGmw1MgCkM+7wx/snRf8ou8oTYwZblCoYQkxWi8+ZCRMSbWuk1WpIBxmQ==
X-Received: by 2002:a05:600c:1d15:b0:381:1979:a7dd with SMTP id l21-20020a05600c1d1500b003811979a7ddmr3078800wms.137.1645735119796;
        Thu, 24 Feb 2022 12:38:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj8-20020a0560001e0800b001e6993398e3sm319704wrb.80.2022.02.24.12.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:39 -0800 (PST)
Message-Id: <6e47ffed25795260c2b8614d4589fb58d892c8df.1645735117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:31 +0000
Subject: [PATCH 2/7] commit-graph: fix ordering bug in generation numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When computing the generation numbers for a commit-graph, we compute
the corrected commit dates and then check if their offsets from the
actual dates is too large to fit in the 32-bit Generation Data chunk.
However, there is a problem with this approach: if we have parsed the
generation data from the previous commit-graph, then we continue the
loop because the corrected commit date is already computed.

It is incorrect to add an increment to num_generation_data_overflows
here, because we might start double-counting commits that are computed
because of the depth-first search walk from a commit with an earlier
OID.

Instead, iterate over the full commit list at the end, checking the
offsets to see how many grow beyond the maximum value.

Update a test in t5318 to use a larger time value, which will help
demonstrate this bug in more cases. It still won't hit all potential
cases until the next change, which reenables reading generation numbers.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c          | 10 +++++++---
 t/t5318-commit-graph.sh |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 265c010122e..a19bd96c2ee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1556,12 +1556,16 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (current->date && current->date > max_corrected_commit_date)
 					max_corrected_commit_date = current->date - 1;
 				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
-
-				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
-					ctx->num_generation_data_overflows++;
 			}
 		}
 	}
+
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
+			ctx->num_generation_data_overflows++;
+	}
 	stop_progress(&ctx->progress);
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2b05026cf6d..f9bffe38013 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -467,10 +467,10 @@ test_expect_success 'warn on improper hash version' '
 	)
 '
 
-test_expect_success 'lower layers have overflow chunk' '
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow chunk' '
 	cd "$TRASH_DIRECTORY/full" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
-	FUTURE_DATE="@2147483646 +0000" &&
+	FUTURE_DATE="@4147483646 +0000" &&
 	rm -f .git/objects/info/commit-graph &&
 	test_commit --date "$FUTURE_DATE" future-1 &&
 	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
-- 
gitgitgadget

