Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC6AC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5972F20810
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMagjSpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFPXdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFPXdh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 19:33:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA2C06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:33:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so353229wru.12
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zwjIwj9WPhgsGQcvQ0LZqsWtYblPSmGeaGNkKgHjv9E=;
        b=YMagjSpvdTJah6UqAsOuwWFBq2edas29H9esa9HzOkhYzKFZ/hA0RJ5UOIr/H30X/b
         /in1GORai4rlSazfD+VkeGjAc5Us7LfGE3nENSGuLFYjz5wSScMO/2ZLEaVeE3ZJEQ/o
         YoGgERtzGG1r0CwSUA2KFK8Nfnr50q0B/ESKIFJ77c5p5Yox5yYk0gpJfeSDczfNEAun
         9ZoFB8rjSCpuAT3Sf/fqi15uQLcH6FJxgAWk2PXCX8PQKSQJxTe6Dob3nF8L8ZAaXBnI
         rA+T+4t2tZPsqwWuIYOyTVXw3lo9/HllLeAU4wOX7T7f0XeDDKYxsh0zBNFvWHOD461C
         loPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zwjIwj9WPhgsGQcvQ0LZqsWtYblPSmGeaGNkKgHjv9E=;
        b=BMf1sovFaua69OkXhPrdBIeKzyTNjdtP0DQ2CbgJgpH7/ljHZBVMA6apxAHwImRCfL
         c+BuRkyRUdifj+L2Sk95mjCk3eRcb/eWFauue1bZeOPdefhidnP+ePJpwFEbys1N8soz
         NwzqfxQ9zDWjEyr4N8rKdIFw4DQRYmx5XuHyOCUtV2rnJO3mtK20ugz+GHN35vwbfeU3
         xpe/nj7Pl7wJVq4w6ri9jOg8wXWCoSxo6YmHQKNZ7A79j27tACQzvkVFylDrAnb/mAen
         oEGJAMrc8GDABG1EhpRGTankwSa3DJDaqObsJaUoPDawPM2IspxTS2YPWQOWS5TOHXJg
         Dq0g==
X-Gm-Message-State: AOAM532oXXUmDeESNy4qqnQvzQhinUKjtWv8oySN2pLWPzSGYefL+VoP
        f5pCKzz+CUggWtUxuE0hoP4e0wQm
X-Google-Smtp-Source: ABdhPJxPc/SxtTrkiwlACJuLvPplGBcVPZLwIRo+6zFT5C6rXKkuC48M42VQ7iNr5WMLP/S2syWfhQ==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr5287316wru.211.1592350415912;
        Tue, 16 Jun 2020 16:33:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x14sm2145394wrt.60.2020.06.16.16.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 16:33:35 -0700 (PDT)
Message-Id: <462cee857ef30c413eda0abe655b123f32b3877e.1592350413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 23:33:32 +0000
Subject: [PATCH 1/2] [RFC] wt-status: show sparse checkout status as well
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Elijah Newren <newren@gmail.com>,
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
 wt-status.c | 35 +++++++++++++++++++++++++++++++++++
 wt-status.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 98dfa6f73f9..687d2ab1ba1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1484,6 +1484,16 @@ static void show_bisect_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
+static void show_sparse_checkout_in_use(struct wt_status *s,
+					const char *color)
+{
+	if (s->state.sparse_checkout_percentage != -1)
+		status_printf_ln(s, color,
+				 _("You are in a sparse checkout with %d%% of tracked files present."),
+				 s->state.sparse_checkout_percentage);
+	wt_longstatus_print_trailer(s);
+}
+
 /*
  * Extract branch information from rebase/bisect
  */
@@ -1623,6 +1633,27 @@ int wt_status_check_bisect(const struct worktree *wt,
 	return 0;
 }
 
+static void wt_status_check_sparse_checkout(struct repository *r,
+					    struct wt_status_state *state)
+{
+	int skip_worktree = 0;
+	int i;
+
+	if (!core_apply_sparse_checkout) {
+		state->sparse_checkout_percentage = -1;
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
@@ -1658,6 +1689,7 @@ void wt_status_get_state(struct repository *r,
 	}
 	if (get_detached_from)
 		wt_status_get_detached_from(r, state);
+	wt_status_check_sparse_checkout(r, state);
 }
 
 static void wt_longstatus_print_state(struct wt_status *s)
@@ -1681,6 +1713,9 @@ static void wt_longstatus_print_state(struct wt_status *s)
 		show_revert_in_progress(s, state_color);
 	if (state->bisect_in_progress)
 		show_bisect_in_progress(s, state_color);
+
+	if (state->sparse_checkout_percentage != -1)
+		show_sparse_checkout_in_use(s, state_color);
 }
 
 static void wt_longstatus_print(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 73ab5d4da1c..4550004003a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -90,6 +90,7 @@ struct wt_status_state {
 	int bisect_in_progress;
 	int revert_in_progress;
 	int detached_at;
+	int sparse_checkout_percentage; /* -1 == not in sparse checkout */
 	char *branch;
 	char *onto;
 	char *detached_from;
-- 
gitgitgadget

