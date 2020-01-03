Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A7AC3F68F
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243F5222C3
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 21:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEaNhUEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgACVmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 16:42:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36429 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgACVmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 16:42:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so43703919wru.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kQLH2/02WcXkN8kJEKo7lFLuqjQprn+pf+0hX4Q7TYM=;
        b=kEaNhUEaqwz/dFFCtA8P19A38mPUFvsPf6bG2l0N9+ePKG5aFCO6Y9/i+BMF323JCo
         F5VrWWfhyW5NYoetqOSZZG83NuAZaFtIJCbZp5NSGEYugpOqEXFzlMusq8aqyuI6G/Hg
         WizVKR1MXiuhvi4a/06S/1/sO5DApkfUjjE9E+2C33f5NunJ27sN8niy0Ni0odra3gjK
         UWwi7PNG0Rr1JDzcw0vO4XVqz3rrlNqwR1aDEluKQVs8TxSzU++oHe1yXl5+uXbk8MNr
         46VxG5xBN5BcukbeP1zMYAV+Yz7rlVc8byD0xJ7rNACFPZnys9dn82gzXciKaklQ93ZL
         yW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kQLH2/02WcXkN8kJEKo7lFLuqjQprn+pf+0hX4Q7TYM=;
        b=WuZhPSTVXBYSAj3KTm9Ey9Lei2KT5774Ho2FFjDeyNCFpsZYGtVmGnuLJ/Z+mIkNtV
         lnfATWZbfZ7ukVcN71BGFFTJCd3F+fTD8gYoH7hnprTKsuDeIpRSgw2J6aALlz8+eBhe
         B1xWtyeJi5ke+77T4CvlUrBVFX31tgQgJlL9gQ0FWKP40ntdc9sO09vVfeGXA/KQfYTa
         Z0tG6khhHFh4afxI/nuq6/qu0/JkX0gA3isujxJzCrAt8VCUd/hY7B6Z2PJVOROBS8Ob
         wgiqJR/kw2u34MpCupj3zMNGwyiGqluOz3V8RomxHrC187jTFniA+qAFy7dm+kT12eHZ
         E/jA==
X-Gm-Message-State: APjAAAVuUjQcVHqBo272O0ZYD+8YswmhdiScLHkwGLYYNhNHvSzN6Lck
        q9ZdR1x9nq6kz3m7DymhiEJ0Ceql
X-Google-Smtp-Source: APXvYqxozw3wR7uMhQDLlOgH8a4SBUKM1dDtktDuy41jOV0Ghqte8NZBKt1iG+d/lsHwelO1jzv9SQ==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr89599585wrt.366.1578087731655;
        Fri, 03 Jan 2020 13:42:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17sm59545786wrx.15.2020.01.03.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 13:42:11 -0800 (PST)
Message-Id: <de0f381284cfe90c1bd8521abb8d29e3529c981a.1578087730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
References: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jan 2020 21:42:09 +0000
Subject: [PATCH 1/1] unpack-trees: exit check_updates() early if updates are
 not wanted
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

check_updates() has a lot of code that repeatedly checks whether
o->update or o->dry_run are set.  (Note that o->dry_run is a
near-synonym for !o->update, but not quite as per commit 2c9078d05bf2
("unpack-trees: add the dry_run flag to unpack_trees_options",
2011-05-25).)  In fact, this function almost turns into a no-op whenever
the condition
   !o->update || o->dry_run
is met.  Simplify the code by checking this condition at the beginning
of the function, and when it is true, do the few things that are
relevant and return early.

There are a few things that make the conversion not quite obvious:
  * The fact that check_updates() does not actually turn into a no-op
    when updates are not wanted may be slightly surprising.  However,
    commit 33ecf7eb61 (Discard "deleted" cache entries after using them
    to update the working tree, 2008-02-07) put the discarding of
    unused cache entries in check_updates() so we still need to keep
    the call to remove_marked_cache_entries().  It's possible this
    call belongs in another function, but it is certainly needed as
    tests will fail if it is removed.
  * The original called remove_scheduled_dirs() unconditionally.
    Technically, commit 7847892716 (unlink_entry(): introduce
    schedule_dir_for_removal(), 2009-02-09) should have made that call
    conditional, but it didn't matter in practice because
    remove_scheduled_dirs() becomes a no-op when all the calls to
    unlink_entry() are skipped.  As such, we do not need to call it.
  * When (o->dry_run && o->update), the original would have two calls
    to git_attr_set_direction() surrounding a bunch of skipped updates.
    These two calls to git_attr_set_direction() cancel each other out
    and thus can be omitted when o->dry_run is true just as they
    already are when !o->update.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2399b6818b..4c68dbdb43 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -372,15 +372,20 @@ static int check_updates(struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 	state.istate = index;
 
+	if (!o->update || o->dry_run) {
+		remove_marked_cache_entries(index, 0);
+		trace_performance_leave("check_updates");
+		return 0;
+	}
+
 	if (o->clone)
 		setup_collided_checkout_detection(&state, index);
 
 	progress = get_progress(o);
 
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT);
+	git_attr_set_direction(GIT_ATTR_CHECKOUT);
 
-	if (should_update_submodules() && o->update && !o->dry_run)
+	if (should_update_submodules())
 		load_gitmodules_file(index, NULL);
 
 	for (i = 0; i < index->cache_nr; i++) {
@@ -388,18 +393,18 @@ static int check_updates(struct unpack_trees_options *o)
 
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
-			if (o->update && !o->dry_run)
-				unlink_entry(ce);
+			unlink_entry(ce);
 		}
 	}
+
 	remove_marked_cache_entries(index, 0);
 	remove_scheduled_dirs();
 
-	if (should_update_submodules() && o->update && !o->dry_run)
+	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
-	if (has_promisor_remote() && o->update && !o->dry_run) {
+	if (has_promisor_remote()) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -431,15 +436,12 @@ static int check_updates(struct unpack_trees_options *o)
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
-			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, &state, NULL, NULL);
-			}
+			errs |= checkout_entry(ce, &state, NULL, NULL);
 		}
 	}
 	stop_progress(&progress);
 	errs |= finish_delayed_checkout(&state, NULL);
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKIN);
+	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
 	if (o->clone)
 		report_collided_checkout(index);
-- 
gitgitgadget
