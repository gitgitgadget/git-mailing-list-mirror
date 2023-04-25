Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC197C7618E
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 00:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjDYAA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjDYAA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 20:00:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59E4C0F
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:23 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fe08015c1so61606997b3.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682380822; x=1684972822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsThtRo8Npw9G2MVcW7iAfU1F6ESU4OeGi0Hrpu+5yQ=;
        b=n8rwQ7rlcOtI5gBF7VWZoIvNJRntD4os4rAAn7UpoZfZtGKY0DIG+TIb402LOFWxQz
         ahRuCsrvDEnCvZSPG1ZJzJ8s2/CzAuizPTe9TljxSckjNjd0eDB39xpFs7evoKzEV0RA
         Gl2Uc/d5R+iZvByvMghK8s16QIFLiRe1cTqJ6Cm3YszkmMvSmQuhbxOoj6tscBRex6Bt
         IZNFWqy1gWaWAFKRe2xtnyMhwDB46FTOgxjV6kIu+FwUprkPKwDPGMh/u9L9wwGCYeFE
         qiYYZhaqvLQYpDNIDcxthJ5iEm1/UzvrGSiVL9rwKbkC0umIYKPyhjrU9CDHgFUkBAL8
         2zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682380822; x=1684972822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsThtRo8Npw9G2MVcW7iAfU1F6ESU4OeGi0Hrpu+5yQ=;
        b=ORzHun4EFkM9TJX/IUn3c4zHi+uewbxS+By3SlSOAw0F2xFTjuw2KT0zjU91XAMLpj
         lYl646tpjUF8/XxXqU7RZYYWC4qeKppX8ER8MA4BOcReR3ZlhDzuj3ObgYk5J1U7Pwbp
         Gv6tr+JkCGx+UZfcYj76p1/bdBCJOOl3rd+Ef8pYCjRohXplcMvkUC9aAydmOhDb/KXg
         4Op8GD9foYf82X/LzLxl/D5xpPLRtV0Ar5pm0p/sV2swUpNyvhmrMD/AlEZi08otuNht
         eNGYxXzurNMGitKF9hbrFu04N9Bfeg1YZNktSz50BcU4AS0ZcMZXgsWOIszt4yo2gQTR
         45/w==
X-Gm-Message-State: AAQBX9crqsRnzQrZ/0iSF99P0OmfpK84cBEEvugceR1BfPMyBh/rpxU0
        Im/PStU/QCjvrw4MOZkQ/PmqW6bj5/qm9dKGm5qURg==
X-Google-Smtp-Source: AKy350aVrVbsBNtXKvBg0QwpwWwwkxG45szJNxAqoqDBTAICRrxJTHSLK5+U90S+5fZtyZRiHX7d3A==
X-Received: by 2002:a81:7c57:0:b0:54f:b4b2:a45b with SMTP id x84-20020a817c57000000b0054fb4b2a45bmr8887210ywc.0.1682380821878;
        Mon, 24 Apr 2023 17:00:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m11-20020a81710b000000b0054601ee157fsm3254194ywc.114.2023.04.24.17.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 17:00:21 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:00:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] revision: support tracking uninteresting commits
Message-ID: <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The boundary-based bitmap walk will want to know which commits were
marked UNINTERESTING in the walk used to discover the boundary.

Track which commits are marked as such during list limitation as well as
the topo walk step, though the latter is not used.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 revision.c | 10 +++++++++-
 revision.h |  5 +++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 106ca1ce6c..7177244e7a 100644
--- a/revision.c
+++ b/revision.c
@@ -1446,6 +1446,9 @@ static int limit_list(struct rev_info *revs)
 		if (process_parents(revs, commit, &original_list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
+			if (revs->collect_uninteresting)
+				add_object_array(obj, NULL,
+						 &revs->uninteresting_commits);
 			mark_parents_uninteresting(revs, commit);
 			slop = still_interesting(original_list, date, slop, &interesting_cache);
 			if (slop)
@@ -3072,6 +3075,7 @@ void release_revisions(struct rev_info *revs)
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 	release_revisions_topo_walk_info(revs->topo_walk_info);
+	object_array_clear(&revs->uninteresting_commits);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3522,8 +3526,12 @@ static void explore_walk_step(struct rev_info *revs)
 	if (process_parents(revs, c, NULL, NULL) < 0)
 		return;
 
-	if (c->object.flags & UNINTERESTING)
+	if (c->object.flags & UNINTERESTING) {
+		if (revs->collect_uninteresting)
+			add_object_array(&c->object, NULL,
+					 &revs->uninteresting_commits);
 		mark_parents_uninteresting(revs, c);
+	}
 
 	for (p = c->parents; p; p = p->next)
 		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
diff --git a/revision.h b/revision.h
index e8f6de9684..1385b29c76 100644
--- a/revision.h
+++ b/revision.h
@@ -124,6 +124,9 @@ struct rev_info {
 	/* Parents of shown commits */
 	struct object_array boundary_commits;
 
+	/* UNINTERESTING commits between the tips and boundary */
+	struct object_array uninteresting_commits;
+
 	/* The end-points specified by the end user */
 	struct rev_cmdline_info cmdline;
 
@@ -183,6 +186,7 @@ struct rev_info {
 			unpacked:1,
 			no_kept_objects:1,
 			boundary:2,
+			collect_uninteresting:1,
 			count:1,
 			left_right:1,
 			left_only:1,
@@ -404,6 +408,7 @@ struct rev_info {
 	.expand_tabs_in_log = -1, \
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
+	.uninteresting_commits = OBJECT_ARRAY_INIT, \
 }
 
 /**
-- 
2.40.0.380.gda896aa358.dirty

