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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01F8C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EAE23444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbhAGUCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbhAGUCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499BDC0612FA
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 91so6832105wrj.7
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Per0sGB/F/TcHB64BoKVIyLbqwPA6indn6vys9rSI0=;
        b=sENvxkAB0BOdVB+t2BnGOAVxStMQLTkt6MP5GMRSBpNSVrgN0mJJEIpxGuBHQbKE7U
         WaCwbiUIIxdNd3HojiLiiRSj60XhSb6O0m5YxwE8fmJah3sEz7677RIPF8pS+oNSF0mB
         eWOaDD+nndVCIBr9uOE1Yt0izy4ZRi/6kIBXb1aovkRs22x6ObGqp878bbBk4E22J5Gn
         iR8OB7g8/ku3HH67GyyOdBEZB9mmV83bCW+nktR3R/TSvUKeeRNCJYVeNQuA61M5vhgU
         iOgDmL/eurnHe/cKe3jTcNjGL58knv4nLIrMU7zSZwWRIeG2EvA6G+3Qt/LEn10AtaM8
         +ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Per0sGB/F/TcHB64BoKVIyLbqwPA6indn6vys9rSI0=;
        b=HmZEOHt0+jt6foH/Ew6ZenaGCBDB2E5FeGt6qiXTIETjaTPHHXhvDHSAeNyJ4/ZBaJ
         2MeUdRAMLTUVYuyacO9k1bke6pEZg44X3kGahCE8GNwGZIwUy+wMDm9/bWGKDmXdNJpe
         MPJzldemIAjoJOQ4BzVMCJNPTelyMmpcBu054u4N5GuybrytRD64G1NiXMILlHP/H/LH
         rY4pyBtrJEK/H0K9bgAcd2QzTpy+jekshuC7lxch8eXj5HOZ0vICGaBU8sByyV3AkYPB
         EycBMvhXCJlBWQgaT0QE1Dw0yIdkPjVjz/pvo5eD0CXFmdp+Zurl9TWPO2zrWEoTpXVe
         9x8g==
X-Gm-Message-State: AOAM530PHsKLIZiK87N63X5HoMa9QzC+edGU/UQt7W61qtGITE8ldNG4
        0zJKvhVKi4/UkJITZAH3OsQDLvLTQus=
X-Google-Smtp-Source: ABdhPJzjk2Ym/bsmsW1sqq7MCmYHaiVW0ofT26kIPcj0PV4dr6PsZiD0KPohRW2Z4Mq222JmlCGSNg==
X-Received: by 2002:adf:fccb:: with SMTP id f11mr273362wrs.3.1610049692903;
        Thu, 07 Jan 2021 12:01:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm8892913wmd.43.2021.01.07.12.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:32 -0800 (PST)
Message-Id: <ccb30dfc3c4c9ad2fc7cd33dc72ecf768827ed9f.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:13 +0000
Subject: [PATCH 04/18] merge-ort: add outline for computing directory renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Port some directory rename handling changes from merge-recursive.c's
detect_and_process_renames() to the same-named function of merge-ort.c.
This does not yet add any use or handling of directory renames, just the
outline for where we start to compute them.  Thus, a future patch will
add port additional changes to merge-ort's detect_and_process_renames().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 999a7c91c52..378ac495d09 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,6 +721,18 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
+static void get_provisional_directory_renames(struct merge_options *opt,
+					      unsigned side,
+					      int *clean)
+{
+	die("Not yet implemented!");
+}
+
+static void handle_directory_level_conflicts(struct merge_options *opt)
+{
+	die("Not yet implemented!");
+}
+
 /*** Function Grouping: functions related to regular rename detection ***/
 
 static int process_renames(struct merge_options *opt,
@@ -1086,13 +1098,24 @@ static int detect_and_process_renames(struct merge_options *opt,
 {
 	struct diff_queue_struct combined;
 	struct rename_info *renames = &opt->priv->renames;
-	int s, clean = 1;
+	int need_dir_renames, s, clean = 1;
 
 	memset(&combined, 0, sizeof(combined));
 
 	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
 	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
 
+	need_dir_renames =
+	  !opt->priv->call_depth &&
+	  (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE ||
+	   opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);
+
+	if (need_dir_renames) {
+		for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++)
+			get_provisional_directory_renames(opt, s, &clean);
+		handle_directory_level_conflicts(opt);
+	}
+
 	ALLOC_GROW(combined.queue,
 		   renames->pairs[1].nr + renames->pairs[2].nr,
 		   combined.alloc);
-- 
gitgitgadget

