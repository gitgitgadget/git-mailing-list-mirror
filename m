Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D79DC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D498822519
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbhADXvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhADXvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:15 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35180C061796
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:34 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j12so27703338ota.7
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NY/QvUSxgLx3VRAo5824Vs664wHz4pGpKBxjHUNrye4=;
        b=iECkFFnE/dO7Y2RgFY9Vw9Icgf4g+qOvWEkoa+X6eeUY2PbQePx0kxXF605j6IZdkK
         aqumTsb0QzeTv0C/IMbP0Yw0+QQBr0GGCwiWqueZfRCE+cYF/FZtblIzQfzhZaYHbYaN
         UL0n6IXveef+unE+7/3nyviFR3ylnPwRYz2pweAZM7MbTLh7TN0+yAi2HQf2lT/iaXU3
         byfRXHamEhME3+wmghUxNgVndHVHW/DkEbw1Iowp4fNreYrMPEJz5iSWqZkrRNcL1gIx
         APugOcVsLMcuL4+BzeJVJoZz1rvAr0l0LKlGrxqbpI1c3KCu+nJGJY2rvWOYJoxLGE8M
         yWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NY/QvUSxgLx3VRAo5824Vs664wHz4pGpKBxjHUNrye4=;
        b=iwOhO7XHNeqI/sJeYb3wDmRrUYeo4q08dm9kxY52ElkBXlwksGCmLrGg66NFBTLEdr
         BUIrYw8W7hvSCyyrRg5NatcXhJK41JF11x07x7P+0wAsad/+8CZdX/7opN0qaAxQghaq
         lbjO5GQvxInTbLaax5GOdAD9GHevNZU6aVo7Bff18hwMlPUlWd02TgAA/AfV3DS0ayPL
         cXI2l67ndzeg1dZSFX9QVrAw8mQWkKpQ1b50K5RoDgA++1Lsh5nxxLSw1eg+GapJl1ab
         TBSlN3Ws+mvetszgoI9xMfax6FfgT+KpKWZ9f+QqOTmCng5cAj4XEdgzhikICnOg5OjT
         0ddg==
X-Gm-Message-State: AOAM531uTvnXZXurotJ68/OBawd3q3u2HgXyBIg8stbXlVOifJYL7lnA
        QcxGoXGAgX2j7PRZHo+JIBr1+ZtPGkM=
X-Google-Smtp-Source: ABdhPJza6IHyswiTMA83ZWwjWX5hxt5zohP8IaJSgD2NPJhvEpaz09SDDTrmW47/Yb/cjkS1CXaZdA==
X-Received: by 2002:a9d:4e84:: with SMTP id v4mr55344353otk.45.1609804233497;
        Mon, 04 Jan 2021 15:50:33 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:33 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 04/17] merge-ort: add outline for computing directory renames
Date:   Mon,  4 Jan 2021 15:49:53 -0800
Message-Id: <20210104235006.2867404-5-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index f67ecdd171..0bd0ab1e8b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1139,6 +1139,18 @@ static int handle_content_merge(struct merge_options *opt,
 
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
@@ -1504,13 +1516,24 @@ static int detect_and_process_renames(struct merge_options *opt,
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
2.29.1.106.g3ff750dc32.dirty

