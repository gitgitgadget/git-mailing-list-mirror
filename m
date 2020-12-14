Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00800C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8C7225AC
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440187AbgLNQW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440248AbgLNQW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:22:26 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E6C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so15796923wmb.5
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SI+l5g9wGTUq3i9Ft6Oc+PNP4QnKTKBpBnZ3lsTnHgU=;
        b=sbN8yoZJaZT+ZWdWqqKjojNQAmUMz/quicad2l9zKLzFGHu6QEzID+y4o7VpBr5OIJ
         4gLhTUOhwnYWGzKvqrH8NYbWIqneQaau+d+Z0w3z3Dd3CwJRZh7FhUASKHhcBuUmNzkH
         My84IygZ1LkL5bDTxPEcac9pPKFbGnsCz6lZCfAPxQ5Y3x1RbrVzKBSKBxGOgqwPVtm3
         cNzTtOFn+PymuNtjeAdelmyTRsU5pIOQE5PLJ+3XIEqtFMaDoevJrhlxSpBBzDVS++hZ
         1BwhXAr+N4yPpCvdb41wPL/X3J2NssLGY9gqF2/zb/oHAzkx6405w+Eak7Oq0Ernuak8
         qogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SI+l5g9wGTUq3i9Ft6Oc+PNP4QnKTKBpBnZ3lsTnHgU=;
        b=InZc0bNcdBuxnkstt9eZsANt0RLm0wv5Hx0Dbc7MMSeT7MLMxREfr655IqSjGObQcc
         puV7ZO6Kh1UO4h+cv/iBm+R1syph2gqF/dyMHnZickav5yRpCou8zcQKUSzTpVcyFnPm
         NJfmCHulfgwvxSlQjI9PfEfu0MQHqtzEpmITlxibSsAOIQ84E5/gIZ1mFP+1gDAjgMHP
         1Byua/3JDS3e7naC7t2/Z5u899cUV+t4Mnvmvggrkl4EZL5xw3O3hLId3zDNDNOKrHN1
         SB4S8j/I5TzJt3UN272LNmwDyb7r4ttSnmFi9i+T4fklUoO5uCHYd5xrjw6OisiqBYIs
         +zXQ==
X-Gm-Message-State: AOAM532NZCtD9VHNj5RLVDyyEenAYJAcDCPUCisbB5jP18vrjWG5rp/s
        3ViDHR7dat/rt+Q88TEL0S3XctE6tCk=
X-Google-Smtp-Source: ABdhPJyZ+zIAkd4CrZpFOJLdoM4rgpIYBEJZkc5DNg5e+P2dUFfNCtJRRzU4ypxOMZ4KlSE9r3rgzg==
X-Received: by 2002:a1c:3987:: with SMTP id g129mr28072044wma.86.1607962904290;
        Mon, 14 Dec 2020 08:21:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w21sm14424181wmi.45.2020.12.14.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:43 -0800 (PST)
Message-Id: <d846decf40be829590b88bb61fb19ae6f64c3162.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:31 +0000
Subject: [PATCH v2 02/11] merge-ort: add initial outline for basic rename
 detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1c1a7fa4bf1..8552f5e2318 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -644,20 +644,72 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to regular rename detection ***/
 
+static int process_renames(struct merge_options *opt,
+			   struct diff_queue_struct *renames)
+{
+	die("Not yet implemented.");
+}
+
+static int compare_pairs(const void *a_, const void *b_)
+{
+	die("Not yet implemented.");
+}
+
+/* Call diffcore_rename() to compute which files have changed on given side */
+static void detect_regular_renames(struct merge_options *opt,
+				   struct tree *merge_base,
+				   struct tree *side,
+				   unsigned side_index)
+{
+	die("Not yet implemented.");
+}
+
+/*
+ * Get information of all renames which occurred in 'side_pairs', discarding
+ * non-renames.
+ */
+static int collect_renames(struct merge_options *opt,
+			   struct diff_queue_struct *result,
+			   unsigned side_index)
+{
+	die("Not yet implemented.");
+}
+
 static int detect_and_process_renames(struct merge_options *opt,
 				      struct tree *merge_base,
 				      struct tree *side1,
 				      struct tree *side2)
 {
-	int clean = 1;
+	struct diff_queue_struct combined;
+	struct rename_info *renames = &opt->priv->renames;
+	int s, clean = 1;
+
+	memset(&combined, 0, sizeof(combined));
+
+	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
+	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
+
+	ALLOC_GROW(combined.queue,
+		   renames->pairs[1].nr + renames->pairs[2].nr,
+		   combined.alloc);
+	clean &= collect_renames(opt, &combined, MERGE_SIDE1);
+	clean &= collect_renames(opt, &combined, MERGE_SIDE2);
+	QSORT(combined.queue, combined.nr, compare_pairs);
+
+	clean &= process_renames(opt, &combined);
+
+	/* Free memory for renames->pairs[] and combined */
+	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
+		free(renames->pairs[s].queue);
+		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
+	}
+	if (combined.nr) {
+		int i;
+		for (i = 0; i < combined.nr; i++)
+			diff_free_filepair(combined.queue[i]);
+		free(combined.queue);
+	}
 
-	/*
-	 * Rename detection works by detecting file similarity.  Here we use
-	 * a really easy-to-implement scheme: files are similar IFF they have
-	 * the same filename.  Therefore, by this scheme, there are no renames.
-	 *
-	 * TODO: Actually implement a real rename detection scheme.
-	 */
 	return clean;
 }
 
-- 
gitgitgadget

