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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F04C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D212310D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392150AbhASTzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391994AbhASTzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF229C0613CF
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v184so845913wma.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=md58dQnFiM7rZcqPW93M53qV0XBglYVk4a3l+cpgqL4=;
        b=QUGT1Z2oF7HgcYgAhphQ9KNPxmVS2RkGG2dGWpRNxGmlL0vw/ohlIgazMlJTlE7mDN
         2ej0Yvel0jv2lwlqbATgLc5iIwkkUJBYQW8aQnqchK2RMBAxyHmDBQtiLsMb3ikd2E1W
         3ffGYs2bBxaK8RbOkEx9Zw39gluty4n6405CQs57i2HwTLafBzPJPFJXj9M4HTyYgswW
         /JPjTD9NgOHiff75DPecTskxAMDYdRjoAM8TcZt4JrUY1UiEjIVlfIRqwfoEryzn0YTj
         xiMOs5tj4PSnXHslrGQV0+4m+yuqQ2lxTaXrCnuZHOyd+wB6KBBQBMRF7heTvUh7Gfg/
         Sncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=md58dQnFiM7rZcqPW93M53qV0XBglYVk4a3l+cpgqL4=;
        b=axAH1G95Ar6kE5lVE5KJc19iPVHNWGUPoxQsNYj5ikFvifswOGAtOYigFWdJ/fQvTm
         PuNfYcZngWdVyJdKjQWVacmBQW3KaHXj0MkJkrlCnDAz5+f8O+nxqmNh72i+nL94S60t
         lRN1vSkOkvXTJUYNJL0U3RyeMwdY9eoPIYGRaDB65orblZSRIEX2FZBChZFpJq4H9e3S
         58jpXdAyWZL8w6ngl7g/JpYZFH+4cj1Xk0+fq2RmQpOzbb4PMrj8Mn+TrsnJ2aoIJ262
         h7wiFp4sJeK9IfJp4Llkoi+tsYQpZ/4jVPJqwSHxk+VL6ontQ7BmVX1qfbFG35dWsKJo
         6uSg==
X-Gm-Message-State: AOAM5302wxqarw83nqymuj6PFE5iTrGuBoS4ROkjbNhfYRK4M8DxDlPO
        wOqIjo9n1Z7jHUVIsiUxZiYKjYiSvaM=
X-Google-Smtp-Source: ABdhPJwOA3k4Oat1x20rPauxcs3VC2jN0I8/LHVY8qQM9NifDp6EAkLgst8hIPNSQvndLAXPw3UopA==
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr1127630wmq.110.1611086038386;
        Tue, 19 Jan 2021 11:53:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g192sm6520327wmg.18.2021.01.19.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:53:57 -0800 (PST)
Message-Id: <0dd6e83d2b019d5663dd842405cee1b3bcfd1902.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:40 +0000
Subject: [PATCH v3 04/17] merge-ort: add outline for computing directory
 renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
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
index 999a7c91c52..b4c1fe28a5c 100644
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
+		get_provisional_directory_renames(opt, MERGE_SIDE1, &clean);
+		get_provisional_directory_renames(opt, MERGE_SIDE2, &clean);
+		handle_directory_level_conflicts(opt);
+	}
+
 	ALLOC_GROW(combined.queue,
 		   renames->pairs[1].nr + renames->pairs[2].nr,
 		   combined.alloc);
-- 
gitgitgadget

