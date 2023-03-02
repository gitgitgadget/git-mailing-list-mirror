Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D474C7EE30
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCBWDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCBWDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:03:32 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C045ADCC
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:03:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u8-20020a17090ae00800b00237e4f46c8bso108395pjy.7
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+ESOsaWLLSTKe9690Yw7UnD2ULze1EdKUa4KMNoPRg=;
        b=m20VBXnZBWux03ONvmIWOtcg9PDYjX457i/4vnnIR7LxJk3K+0JyiFfnQVRj+RaNlw
         iSUtL90C0WHAcK/w4mgR+lyOkmNay8PrNbbHjhuzf9o6vHNGCdsf3rLhujll+vdn2Jgm
         6C7Of+87I7YFCVmv1rBpZM7E41+14Aq/aFQtntf43MaxIkVPGKh1eSD7h6C3TAyhzgYc
         BvjEnVZbh7+NoHfM/j1U40ipdYRpmGpKsuLDk4tNBWs/mW8fwOWgc7bss252eGY5g8En
         m3lwXLH4Rxx8ui/K+9usiC1A0Nn1KsF/hCfS6vpz8EoRhwXsdDc7SlR6SxNWhSxR/pPx
         soFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+ESOsaWLLSTKe9690Yw7UnD2ULze1EdKUa4KMNoPRg=;
        b=HpZuek3H4WuP+vCmc1FcTSqbce6De5fHT3SZ/fXpW3TvSEQTkMANA8tSfpjobuX4x7
         fyqYed8eVKUcPsTc326JorA2DUKeeXqoXNTR/AUCORjtbmnPgsCz9LDjKdfxpgmRRBwG
         V5/jUJxMiufEbBSkFLVh73gbwLTuCkSghd2B7I9xXyO2jGwBT0INsujtpXVsayM4uQzj
         ZKf5PE1oODTJP1h6MnX5crrZavmWlNBk1l91/XBPH6H+dPjpWKwF5lhvkQNhS+xIZ+hY
         sYnW2vuPV2aSJzcHv9BBsFEsRw9RfHTmqDtEFs/e1SlbD8TIJ/sXBSYNJ/aYTBT4TVof
         CHjg==
X-Gm-Message-State: AO0yUKUV1cvv/+BzTBhMBws6rpBoa8GzyUOApTT0GSV7DvVhea4FcOPx
        ClzhSCJHt878uwehOecqFLdQnfdBR+dEGCjZfWVwANI0li1y3PquLjLWjcNV5aDrQbbcl3BTkdT
        fMqi/gojjyyg+eyLHYmXVVob/4zHWcVKOfVxLXy3WjrhZ721rywKbjpn1vyRDiURb/w==
X-Google-Smtp-Source: AK7set/ktoPJtAo1LIajyg9KFL+LdZr43oBgWtQAYK2fSz5P4+q6+oKH7+xLq06LQ37UJYrUDFu7+q04qYs5zgQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:6fce:0:b0:4fb:b3d4:864d with SMTP id
 k197-20020a636fce000000b004fbb3d4864dmr3847272pgc.4.1677794586269; Thu, 02
 Mar 2023 14:03:06 -0800 (PST)
Date:   Thu,  2 Mar 2023 22:02:50 +0000
In-Reply-To: <20230302215237.1473444-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302220251.1474923-5-calvinwan@google.com>
Subject: [PATCH v9 5/6] diff-lib: refactor out diff_change logic
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In run_diff_files, there is logic that records the diff and updates
relevant bits at the end of each entry iteration. Refactor out that
logic into a helper function so a future patch can call it.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index dec040c366..744ae98a69 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -88,6 +88,34 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	return changed;
 }
 
+/**
+ * Records diff_change if there is a change in the entry from run_diff_files.
+ * If there is no change, then the cache entry is marked CE_UPTODATE and
+ * CE_FSMONITOR_VALID. If there is no change and the find_copies_harder flag
+ * is not set, then the function returns early.
+ */
+static void record_file_diff(struct diff_options *options, unsigned newmode,
+			     unsigned dirty_submodule, int changed,
+			     struct index_state *istate,
+			     struct cache_entry *ce)
+{
+	unsigned int oldmode;
+	const struct object_id *old_oid, *new_oid;
+
+	if (!changed && !dirty_submodule) {
+		ce_mark_uptodate(ce);
+		mark_fsmonitor_valid(istate, ce);
+		if (!options->flags.find_copies_harder)
+			return;
+	}
+	oldmode = ce->ce_mode;
+	old_oid = &ce->oid;
+	new_oid = changed ? null_oid() : &ce->oid;
+	diff_change(options, oldmode, newmode, old_oid, new_oid,
+		    !is_null_oid(old_oid), !is_null_oid(new_oid),
+		    ce->name, 0, dirty_submodule);
+}
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
@@ -105,11 +133,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
@@ -245,21 +272,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			newmode = ce_mode_from_stat(ce, st.st_mode);
 		}
 
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
+		record_file_diff(&revs->diffopt, newmode, dirty_submodule,
+				 changed, istate, ce);
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

