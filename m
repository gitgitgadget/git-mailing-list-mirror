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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB1AC43381
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AD7235FF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbhAGVha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbhAGVha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B7C0612FD
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w5so6994045wrm.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Per0sGB/F/TcHB64BoKVIyLbqwPA6indn6vys9rSI0=;
        b=OEJJaGBK82tXe2TKfDIcTiZ7ZoBQDlA/3fyFD36TPwM8C1fkKcsZMOE4vQE5KXbZOl
         /aZbFmtFqFVjkuS/Kp+RPvus63bD6+UyWy4gqqA1Q8agC3DuYAdT426fKmmxQW95GkgG
         v7ZdBraFXyLfYa3gsxjWQZGtKRojrIoGB72dCv4OlIOhE31LfUwV7Z4QAX1zcWz6zzUi
         4+snPYk8rFpUtKz7OHg8I8vnxTf3HRLUUPquyp7WfcuCmhlb1d/YAb+eRQsf42fkOH3q
         y79x0w66N/UflCAoUnJC/s4gDLtPb7hxpaSTzGgzh0fMuvDu0dekhs7AB6uM7b24aycN
         z4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Per0sGB/F/TcHB64BoKVIyLbqwPA6indn6vys9rSI0=;
        b=jbuTGFzpWD1FueNY4gWsr3Op2LzkmEIg3hfocqDuRKsILS1DDyVN8StfZ2mb+Ct3Zq
         SUm+iSut7l5nBiJhxGibOgm3t2s9loaHEqa7psLEm8g6AmbSzOG7SSRdVWlRQpuW75xk
         LOkjTbfHWb3Zv6Q/hgXdyAEYX3oqs2zhNmPJbRCOy/dO50/4GptrVYCncFXNuk4XndUK
         HbQDMZ3mfoUyDhecCFJ7YTCTFKA59ED5gFYmbwreRD8nIsNnWsEQsGOze80wlGWlVLkt
         C78Q+n4LtgQY0S62hLigx2WEORdlj7wYLiLbDSJDWYcVYeYDwnLHvM73MS2w0kj8QMEw
         WPYQ==
X-Gm-Message-State: AOAM530dRCrT6LYM/wgdDH2C14pThutOgF2eNngI4beoghsjJckhFyzP
        +y0bvFdoLXjspKeqlRHEefbdlXn/qtA=
X-Google-Smtp-Source: ABdhPJx9/CljpuVWd2/W7Jq3ZuF18HKOHj2Iq5wHgWpYw2LTFlkBo3l1jyrN/FB26ZQ5GB8TcODDjA==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr507304wrp.405.1610055372423;
        Thu, 07 Jan 2021 13:36:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm11058164wrl.63.2021.01.07.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:11 -0800 (PST)
Message-Id: <ccb30dfc3c4c9ad2fc7cd33dc72ecf768827ed9f.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:52 +0000
Subject: [PATCH v2 04/17] merge-ort: add outline for computing directory
 renames
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

