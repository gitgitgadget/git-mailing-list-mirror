Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404AC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 23:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIVXaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIVXaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 19:30:14 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB7760D2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:13 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id br14-20020a056a00440e00b00548434985cdso6119242pfb.8
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=cvGJ78t20SlNOSoW2PM8yWDPH5XYZkLP89KZL2LSdjw=;
        b=hcawF/fNS3TInN7NjJpCPBHf/3WCBak/zya1QDo5z2gU4tVA39B+52kinQLy0lD28h
         GCSRSKz1bhWGLyLQBYrLkRLIgPAY82bZ6jKvkDUJHtNgubfOqry67cUqcLHdq3RmiJXL
         sjvS5WiULH830ANR39oyycrLTuEgNUjbR8feSaWr6MG9tlXluZ02irH1TDwLnqQzi2BH
         L+KdrIqeddlJzwg9iu7YjVEApJNPfjgywJXTso7Ux0JCGsimSmVJIExjAtsXIPB5qM6X
         ibNCb05vPB1Ti5pP8ENkt+2jTqkSacfcwMbrCgGi42KvYWLcEE83wZpzbvAg4IKqHK4K
         wHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=cvGJ78t20SlNOSoW2PM8yWDPH5XYZkLP89KZL2LSdjw=;
        b=fpZG1/0O6Y/mk3L2e+jtcZZOVtrel2Gu7Y/08bqLM+hl1OS1X+fqDvyAtXVSz/cNAp
         Pauht4Ku5BX1WpDlUkkZWYW4OavmTTLy81ZjhpLuGkE2rNqqC2NPBosMr6mrB1IzBwDB
         vGRgAnQ628Y6KVo0VZuX29ggxgB87nzIlYDhbWdtBEAAzTwMpJ35wfM8Ne/zuvSpMOke
         MDenZi9TsdhKRR1xhqXueZ1WC6XDNrTENvabLfEvllEZ5ev2rW5sXlAPzTxR+IOJ4ogW
         hp63N06QpE9sCPi9zLVRG8kRtSNT/9WEmVDwexpscJcn4zAxZW+ba2iIMa/iuWVZjDLa
         78ZA==
X-Gm-Message-State: ACrzQf0YXUicyokPg/5Y3cejJQ8WBxJkmvxLVYRRKMmQQOJMRcxVWpJB
        DWuO58O+KsEDoOS4CltXXa6vhvrVln/0Phx0gv1N7FKiMKmztiLzhrj28UkXNoN6lgJ3SRt0Luo
        u1oiIluZoHJ3S7T5DvqjLe5GzOOYqY3W+0lQL41Q0zwnTP+WJymcpiwwnezKiX0+GBw==
X-Google-Smtp-Source: AMsMyM7QJ4fBpGGRa4lWiQ5C5iyWpMOV0LhOpIQc6g7CeHsEdrLB2RHUwBi6seYOPRi3WAgu6ELJPyDi7SZtq5A=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:a383:b0:176:dd41:4f56 with SMTP
 id x3-20020a170902a38300b00176dd414f56mr5705917pla.104.1663889413299; Thu, 22
 Sep 2022 16:30:13 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:29:46 +0000
In-Reply-To: <20220922232947.631309-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922232947.631309-4-calvinwan@google.com>
Subject: [PATCH 3/4] diff-lib: refactor functions
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Flatten out the if statements in match_stat_with_submodule so the
logic is more readable and easier for future patches to add to.

Move code that updates relevant variables from the end of
run_diff_files to finish_run_diff_files. A future patch will utilize
said function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 71 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 7eb66a417a..2e148b79e6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,21 +73,50 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     unsigned *dirty_submodule)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
-	if (S_ISGITLINK(ce->ce_mode)) {
-		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.ignore_submodules)
-			changed = 0;
-		else if (!diffopt->flags.ignore_dirty_submodules &&
-			 (!changed || diffopt->flags.dirty_submodules))
-			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.ignore_untracked_in_submodules);
-		diffopt->flags = orig_flags;
+	struct diff_flags orig_flags = diffopt->flags;
+	if (!S_ISGITLINK(ce->ce_mode))
+		goto cleanup;
+	if (!diffopt->flags.override_submodule_config)
+		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
+	if (diffopt->flags.ignore_submodules) {
+		changed = 0;
+		goto cleanup;
 	}
+	if (!diffopt->flags.ignore_dirty_submodules &&
+		(!changed || diffopt->flags.dirty_submodules))
+			*dirty_submodule = is_submodule_modified(ce->name,
+							diffopt->flags.ignore_untracked_in_submodules);
+cleanup:
+	diffopt->flags = orig_flags;
 	return changed;
 }
 
+static void finish_run_diff_files(struct rev_info *revs,
+						  struct cache_entry *ce,
+						  struct index_state *istate,
+						  int changed, int dirty_submodule,
+						  unsigned int newmode)
+{
+	unsigned int oldmode;
+	const struct object_id *old_oid, *new_oid;
+
+	if (!changed && !dirty_submodule) {
+			ce_mark_uptodate(ce);
+			if (!S_ISGITLINK(ce->ce_mode))
+				mark_fsmonitor_valid(istate, ce);
+			if (!revs->diffopt.flags.find_copies_harder)
+				return;
+		}
+		oldmode = ce->ce_mode;
+		old_oid = &ce->oid;
+		new_oid = changed ? null_oid() : &ce->oid;
+		diff_change(&revs->diffopt, oldmode, newmode,
+			    old_oid, new_oid,
+			    !is_null_oid(old_oid),
+			    !is_null_oid(new_oid),
+			    ce->name, 0, dirty_submodule);
+}
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
@@ -105,11 +134,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		diff_unmerged_stage = 2;
 	entries = istate->cache_nr;
 	for (i = 0; i < entries; i++) {
-		unsigned int oldmode, newmode;
+		unsigned int newmode;
 		struct cache_entry *ce = istate->cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
-		const struct object_id *old_oid, *new_oid;
 
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
@@ -244,22 +272,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 							    ce_option, &dirty_submodule);
 			newmode = ce_mode_from_stat(ce, st.st_mode);
 		}
-
-		if (!changed && !dirty_submodule) {
-			ce_mark_uptodate(ce);
-			mark_fsmonitor_valid(istate, ce);
-			if (!revs->diffopt.flags.find_copies_harder)
-				continue;
-		}
-		oldmode = ce->ce_mode;
-		old_oid = &ce->oid;
-		new_oid = changed ? null_oid() : &ce->oid;
-		diff_change(&revs->diffopt, oldmode, newmode,
-			    old_oid, new_oid,
-			    !is_null_oid(old_oid),
-			    !is_null_oid(new_oid),
-			    ce->name, 0, dirty_submodule);
-
+		finish_run_diff_files(revs, ce, istate, changed, dirty_submodule, newmode);
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-- 
2.37.3.998.g577e59143f-goog

