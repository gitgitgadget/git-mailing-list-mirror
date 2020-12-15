Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E8BC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE68F22B40
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgLOS3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgLOS2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:28:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87DC06138C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a6so154824wmc.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2EJEhCVyrWEW/1Rsba7YQOxkLZkc7V5Ocg8faa9cQT0=;
        b=gWdNbwjh7nurrknTa9TtkPyrP42nDGF4+QzNZ5i4Wi1P60vUIelvmItW36zCSdNrdb
         Vag9+CfB/Xp28u2vj/PqB02wpDqcXsgX7AoiSsx7VZUNhJZuRXlfu50UAodFy+Bsb456
         S+9jVO5vbMPOGTCQvZMhbJ0G1ZYxSl6TbyNyW1ErAXbFpOOzU/9aFRcRTvs2jTrGhxYQ
         1sYxv3QoieNBfK6IHOxXIQPc0kbz7lWImexwVMFbkJ+2KGxmUlRtnk5aE9kxG4rhD+se
         fiBh8VHI671nzS38KIV9JmkeKRDIQGHtoVXL8cfdQIrfVOTOtTQibEte1tvk8jxNh8Wz
         6rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2EJEhCVyrWEW/1Rsba7YQOxkLZkc7V5Ocg8faa9cQT0=;
        b=EMDF8WFRejA5sdE2TGF0RwVYShc2ceHkvlc/tuZLgTDhIaaWkQplDMuWLX7FGpiY/1
         J8FjMZPleJ7d2NnmkLvZror2VuLGtv2H5lYIV8SiGY24eRly4766w1j1ONhZHiTPDxdl
         oi8oMSLCJfAhomagklo1SoZ+P42haRZnAHbGYEXZ+BF67OAn3cfEw93YM1rMONG38XiX
         lXxJUwVfFb8JEa4MU6VCYvgYzFz2JTz7Agor15Q4H5nB4Cc/x95zXwFbEJ5gSlQ2ElnE
         2JxWvhQ7QvI1hv8IeCwAkOVOjHl5B0T/o8kxZvTUUBXIiaVyLhdE9jAVlVZdm6597dwN
         7t9g==
X-Gm-Message-State: AOAM530/N1Vc1YnzuZtC/nvBvK7RV/D/+Yyj2l4jMuNdgI9LzkDhCCrO
        I4JdOAOdhqrdlsLPVz1dhaptf8B3Qfo=
X-Google-Smtp-Source: ABdhPJyu0flIWfoZbRvwVKqsJVTVuvQnFNrfkTbmTd/FV3FwHqnCf1qxCwqQaBjjwL7mpvKPDfzDuQ==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr196162wma.80.1608056890874;
        Tue, 15 Dec 2020 10:28:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm37212400wru.4.2020.12.15.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:10 -0800 (PST)
Message-Id: <620fc64032d26e374b2fb52a044564725e023f0f.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:27:58 +0000
Subject: [PATCH v3 03/11] merge-ort: implement detect_regular_renames()
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

Based heavily on merge-recursive's get_diffpairs() function, and also
includes the necessary paired call to diff_warn_rename_limit() so that
users will be warned if merge.renameLimit is not sufficiently large for
rename detection to run.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8552f5e2318..66f84d39b43 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -661,7 +661,33 @@ static void detect_regular_renames(struct merge_options *opt,
 				   struct tree *side,
 				   unsigned side_index)
 {
-	die("Not yet implemented.");
+	struct diff_options diff_opts;
+	struct rename_info *renames = &opt->priv->renames;
+
+	repo_diff_setup(opt->repo, &diff_opts);
+	diff_opts.flags.recursive = 1;
+	diff_opts.flags.rename_empty = 0;
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.rename_limit = opt->rename_limit;
+	if (opt->rename_limit <= 0)
+		diff_opts.rename_limit = 1000;
+	diff_opts.rename_score = opt->rename_score;
+	diff_opts.show_rename_progress = opt->show_rename_progress;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(&merge_base->object.oid, &side->object.oid, "",
+		      &diff_opts);
+	diffcore_std(&diff_opts);
+
+	if (diff_opts.needed_rename_limit > renames->needed_limit)
+		renames->needed_limit = diff_opts.needed_rename_limit;
+
+	renames->pairs[side_index] = diff_queued_diff;
+
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_queued_diff.queue = NULL;
+	diff_flush(&diff_opts);
 }
 
 /*
@@ -1406,6 +1432,10 @@ void merge_switch_to_result(struct merge_options *opt,
 			printf("%s", sb->buf);
 		}
 		string_list_clear(&olist, 0);
+
+		/* Also include needed rename limit adjustment now */
+		diff_warn_rename_limit("merge.renamelimit",
+				       opti->renames.needed_limit, 0);
 	}
 
 	merge_finalize(opt, result);
-- 
gitgitgadget

