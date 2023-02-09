Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C663CC636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjBIACe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjBIAC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:02:26 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C91BAD5
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:02:26 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 144-20020a621896000000b0059e73803cdcso131280pfy.12
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYwZxXuZCKch3x+Vy3R4rbmwqBPB6ajawKXYoGOyBuA=;
        b=oMkO9Nws3ldwuNHj6uVGWLxlV49DJ8hRQa2bxXa7L39NHhDHOPsWXR5zKS4JWp53HL
         ywRqpshmZMk6PIp3jDu64gZQDvB9E7Fp+Okkziby9pnz7GCT0BAPXoXudD2apqP5zNMR
         YZhXcN1WWjbnLoLbJP9lQiXqIQEbENQl2U8Mfp047lAySY6mGJOXBH/xm/u4Fr2H5DfR
         Ow181OT6T8L8Wxz5A96ok1T85/xnAtIhLFzU38FS4JpN2CNgIlzJytSfEzW457xe7BW1
         LIyG9faWIgxseL405PJFLHuIxVdbWdyoQZLyLYaWARzC6ttVJ4Zv4cz2Ck+X7OdwOFNi
         ukrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYwZxXuZCKch3x+Vy3R4rbmwqBPB6ajawKXYoGOyBuA=;
        b=i+jSEEc0L4Uo6bwrPSWvHEc7mjhCMjbLaEbhjbZCk+tXS8GwHndl4pwTKrcq5ThyxE
         RKPNvgY8CHVFlFCX2TgskwgwgY/+9f0BZ/wdQ0iz7Yl+RUo96lONLqlsWteZkLeAYOoj
         4OfjCZ19f5lIxxFSlTDwKBCmErXFPHxBpm7HRHbae6kfMVjpbegPpwaR9SaGWuBvXPGD
         XplcZtaOSg+cJZHJW53rirIzdqpWNTw1vdENGEr+WWRvEfnSK1blDMBMIPCvXI18oYQ2
         3xzhVsEQU3dHml0zL6IphCLhkPQnnHcDlkvfldcGOwTyZ5Lr8pkf+LyAfGSJul9NAv33
         +maw==
X-Gm-Message-State: AO0yUKUxrWr++jI4lGJFqY9D3oBAOTRg7PwXlGm4s6n3w55NKiVYjeAh
        baFwmo2yBm5CqjnbxD2x5EFZ8pIBj5wkUgKBZrvy+EwivQMZnEGAVuDwvLOdGWJXyTBE9J3Hmit
        pQ1sNconV4E4bAxObD8O2dzviaTAHm74VJCUFhvgpDI46swImhLVqDajS5iDDHSFukw==
X-Google-Smtp-Source: AK7set9TnznOiGpLV7etb3ZLoXDBfQGBV+/ayKzdm1dyv9BSqK2O0wkHXv3V9nr9sXdH3iicg9HZJ7hCIHJNpMY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:8b84:b0:230:ee6f:28bc with SMTP
 id z4-20020a17090a8b8400b00230ee6f28bcmr8450pjn.1.1675900945027; Wed, 08 Feb
 2023 16:02:25 -0800 (PST)
Date:   Thu,  9 Feb 2023 00:02:11 +0000
In-Reply-To: <20230207181706.363453-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230209000212.1892457-6-calvinwan@google.com>
Subject: [PATCH v8 5/6] diff-lib: refactor out diff_change logic
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out logic that sets up the diff_change call into a helper
function for a future patch.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index dec040c366..7101cfda3f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -88,6 +88,31 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	return changed;
 }
 
+static int diff_change_helper(struct diff_options *options,
+	      unsigned newmode, unsigned dirty_submodule,
+	      int changed, struct index_state *istate,
+	      struct cache_entry *ce)
+{
+	unsigned int oldmode;
+	const struct object_id *old_oid, *new_oid;
+
+	if (!changed && !dirty_submodule) {
+		ce_mark_uptodate(ce);
+		mark_fsmonitor_valid(istate, ce);
+		if (!options->flags.find_copies_harder)
+			return 1;
+	}
+	oldmode = ce->ce_mode;
+	old_oid = &ce->oid;
+	new_oid = changed ? null_oid() : &ce->oid;
+	diff_change(options, oldmode, newmode,
+			old_oid, new_oid,
+			!is_null_oid(old_oid),
+			!is_null_oid(new_oid),
+			ce->name, 0, dirty_submodule);
+	return 0;
+}
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
@@ -105,11 +130,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
@@ -245,21 +269,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
+		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
+				       changed, istate, ce))
+			continue;
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-- 
2.39.1.519.gcb327c4b5f-goog

