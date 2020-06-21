Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE6C433DF
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B3D22258
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db0daccj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgFUFVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFUFVc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 01:21:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC4C061795
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so12743870wmt.4
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XYqn3ROVlaa8vv295mSYlkez95L/pkr1Oxnpw10OSeE=;
        b=db0daccjDn0+EVyqw7/jHVLbbbu1Urf15tjEKwgijx6JnQYxtNBnjqAMvQ6o88xBcC
         dQkWxhjZfJDfgoXG0oobp5EG9TYn8ZaG94Av1CnWIaldrpWATZMCfyHRk19l2PVKLm6D
         lSZP/9rC3OC6gqhPkXayz3LD04j0YrUUjUNNe5PMbIpSQEEtEI6IqtJmOPOY9Vusynf6
         5e4Jt36pRRXJ8N6gKRwlPjmk80baFj6CiV1bkzdrTWAAmaOzDxq9NyJqelWT9C/tXKSh
         Up/OnDOLgZRz4cqIbI9h9eui/Q9zVy91VgEcrREsf1SR26sSQAvN/0QzRSdaXDj1xpS9
         oWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XYqn3ROVlaa8vv295mSYlkez95L/pkr1Oxnpw10OSeE=;
        b=PV2SOCrmwL/q3aDsS17s5+L2kFnM0wesfcaKDDWngR45QPvlW9IYZfRCrP8FXPhLTP
         TaKuuqDa5CRZy8+Yp6Yr1RyS71ML8Ac+JiqUL7myOyVBZB3+2nofbL488qiTFgGsfAdm
         seMDPbweW3PfphQ7e1JquwwuWFgr7/Wy6HiZtpM1sbDuqSpmXLq+87oNSMzEM7100PSe
         4VjYtyq/QPGZ0yvDlo+ywpG8ezEE4x5l3OW4qQxO48a89vcF+QKQIYieGnvMJDNVHGrA
         AgndLr3Edj1VEEshJacAl+H8zj5QwSAAm0/JFle8HdQ7t8ORiOkvZTYjvL8kx8uEh5wO
         JCCg==
X-Gm-Message-State: AOAM5309pfQbWojSmvUYdJgzK9PcaeA3K9C3JLuo1d3B2OFpAlwixAag
        6HaNcBRU1lUGse4SQocv5V1nj/0f
X-Google-Smtp-Source: ABdhPJycOmJ125/xWIdcq7J76t+6fa+sWZ40+qEjVnrPQrqtJYoEIKgACVLAANxRJImR2v4cKBwI9Q==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr12300349wmd.53.1592716890341;
        Sat, 20 Jun 2020 22:21:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm12921231wrw.19.2020.06.20.22.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 22:21:29 -0700 (PDT)
Message-Id: <e266bc39d99006715482c5186912717651987f3e.1592716887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
References: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
        <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Jun 2020 05:21:25 +0000
Subject: [PATCH v3 1/3] wt-status: show sparse checkout status as well
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Some of the early feedback of folks trying out sparse-checkouts at
$dayjob is that sparse checkouts can sometimes be disorienting; users
can forget that they had a sparse-checkout and then wonder where files
went.  Add some output to 'git status' in the form of a simple line that
states:

    You are in a sparse checkout with 35% of files present.

where, obviously, the exact figure changes depending on what percentage
of files from the index do not have the SKIP_WORKTREE bit set.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 wt-status.c | 41 +++++++++++++++++++++++++++++++++++++++++
 wt-status.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 98dfa6f73f9..c560cbe860a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1484,6 +1484,18 @@ static void show_bisect_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
+static void show_sparse_checkout_in_use(struct wt_status *s,
+					const char *color)
+{
+	if (s->state.sparse_checkout_percentage == SPARSE_CHECKOUT_DISABLED)
+		return;
+
+	status_printf_ln(s, color,
+			 _("You are in a sparse checkout with %d%% of tracked files present."),
+			 s->state.sparse_checkout_percentage);
+	wt_longstatus_print_trailer(s);
+}
+
 /*
  * Extract branch information from rebase/bisect
  */
@@ -1623,6 +1635,31 @@ int wt_status_check_bisect(const struct worktree *wt,
 	return 0;
 }
 
+static void wt_status_check_sparse_checkout(struct repository *r,
+					    struct wt_status_state *state)
+{
+	int skip_worktree = 0;
+	int i;
+
+	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+		/*
+		 * Don't compute percentage of checked out files if we
+		 * aren't in a sparse checkout or would get division by 0.
+		 */
+		state->sparse_checkout_percentage = SPARSE_CHECKOUT_DISABLED;
+		return;
+	}
+
+	for (i = 0; i < r->index->cache_nr; i++) {
+		struct cache_entry *ce = r->index->cache[i];
+		if (ce_skip_worktree(ce))
+			skip_worktree++;
+	}
+
+	state->sparse_checkout_percentage =
+		100 - (100 * skip_worktree)/r->index->cache_nr;
+}
+
 void wt_status_get_state(struct repository *r,
 			 struct wt_status_state *state,
 			 int get_detached_from)
@@ -1658,6 +1695,7 @@ void wt_status_get_state(struct repository *r,
 	}
 	if (get_detached_from)
 		wt_status_get_detached_from(r, state);
+	wt_status_check_sparse_checkout(r, state);
 }
 
 static void wt_longstatus_print_state(struct wt_status *s)
@@ -1681,6 +1719,9 @@ static void wt_longstatus_print_state(struct wt_status *s)
 		show_revert_in_progress(s, state_color);
 	if (state->bisect_in_progress)
 		show_bisect_in_progress(s, state_color);
+
+	if (state->sparse_checkout_percentage != SPARSE_CHECKOUT_DISABLED)
+		show_sparse_checkout_in_use(s, state_color);
 }
 
 static void wt_longstatus_print(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 73ab5d4da1c..f1fa0ec1a75 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -79,6 +79,7 @@ enum wt_status_format {
 
 #define HEAD_DETACHED_AT _("HEAD detached at ")
 #define HEAD_DETACHED_FROM _("HEAD detached from ")
+#define SPARSE_CHECKOUT_DISABLED -1
 
 struct wt_status_state {
 	int merge_in_progress;
@@ -90,6 +91,7 @@ struct wt_status_state {
 	int bisect_in_progress;
 	int revert_in_progress;
 	int detached_at;
+	int sparse_checkout_percentage; /* SPARSE_CHECKOUT_DISABLED if not sparse */
 	char *branch;
 	char *onto;
 	char *detached_from;
-- 
gitgitgadget

