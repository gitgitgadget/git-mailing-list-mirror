Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BED320248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDKNNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDKNNH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so3386483pll.11
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=puKKZ3NVzlWE8qNx9VGU3ycK91CvRxFjAp76zmgDJhw=;
        b=GJ6W/AJhirfrIjLk0pCG2kVZUt8p35u9ywfPuBM0CLEEhCyvcqcDqCtTmnHWUi0M1N
         fZ7iZPUffvdfrmr0sWOdDQ4V2LxiZU1HULXukU5t8AhBXuTufz3PhMTb3pa2e6OVytgt
         RV8GoEOU/pEv8E81PsuvZUT/TLA8p8PG8FzPjpE4YG57PQkshLaHZtJ6FE25yhbxsFB6
         dseaB930e4KtGVlKA0hKSUkqGYn/BWH5VBkC2Ry7XCSCEJnHTxG1paAXvXVnEmN82W7v
         n2IUGlPdsnUK9Kn0cP3vTQlYxJb716q3tXhjbbUKm0T31bXDt0fwWCEw5Cy59t5lzPK9
         9CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=puKKZ3NVzlWE8qNx9VGU3ycK91CvRxFjAp76zmgDJhw=;
        b=AOkhJfalV7NRie9UJPSoYDbkzJtNTYjbixIrLGmavGzl5YAiAH6/s1RMDEnjRUcBcK
         cm2bMO947oxbavvQbvZKVBoYj6Llu6wEMCKG9TwmXfWOhn/rebsyScv+5lPwxbesGIeg
         K71uxnmZ+jX4I3coquy0ajWe9vy50oh1IuH8Q79aW1OEjUjnKC2CKkNG3B2AKR2Qt78M
         UCbIERD5g+5Sw25QBs8AmOaRzxAd+yvbvwK+2wHcC34GKM+6SsUi1ZzKUwj57HuBFMJE
         BRNx68vIglnTfQD/DJZAH4UvfGsdAonNmh85HGlAwU3cB4bhCIRKP9AXytkAF8bUo+1Y
         zYoA==
X-Gm-Message-State: APjAAAVd6SevCVeB7BC9vVnJNjfMBfJ3PQixdIsAKdXCg8vq+pvrcouX
        TjkyAWJ+Jk3LVNf0mUBKRgg=
X-Google-Smtp-Source: APXvYqzsBiTYkwuWW9FgMVWhJFaGJtJR+Fl5CiaKx6/x5q220DPCvM7NHdNEjzxEwnbnFQjzUv+bFA==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr50457065plc.89.1554988385976;
        Thu, 11 Apr 2019 06:13:05 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id r76sm42460028pfa.39.2019.04.11.06.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 05/16] checkout: factor out worktree checkout code
Date:   Thu, 11 Apr 2019 20:12:07 +0700
Message-Id: <20190411131218.19195-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 108 +++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9c5abe170e..1753c8c5ed 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -330,17 +330,73 @@ static void mark_ce_for_checkout_no_overlay(struct cache_entry *ce,
 	}
 }
 
+static int checkout_worktree(const struct checkout_opts *opts)
+{
+	struct checkout state = CHECKOUT_INIT;
+	int nr_checkouts = 0, nr_unmerged = 0;
+	int errs = 0;
+	int pos;
+
+	state.force = 1;
+	state.refresh_cache = 1;
+	state.istate = &the_index;
+
+	enable_delayed_checkout(&state);
+	for (pos = 0; pos < active_nr; pos++) {
+		struct cache_entry *ce = active_cache[pos];
+		if (ce->ce_flags & CE_MATCHED) {
+			if (!ce_stage(ce)) {
+				errs |= checkout_entry(ce, &state,
+						       NULL, &nr_checkouts);
+				continue;
+			}
+			if (opts->writeout_stage)
+				errs |= checkout_stage(opts->writeout_stage,
+						       ce, pos,
+						       &state,
+						       &nr_checkouts, opts->overlay_mode);
+			else if (opts->merge)
+				errs |= checkout_merged(pos, &state,
+							&nr_unmerged);
+			pos = skip_same_name(ce, pos) - 1;
+		}
+	}
+	remove_marked_cache_entries(&the_index, 1);
+	remove_scheduled_dirs();
+	errs |= finish_delayed_checkout(&state, &nr_checkouts);
+
+	if (opts->count_checkout_paths) {
+		if (nr_unmerged)
+			fprintf_ln(stderr, Q_("Recreated %d merge conflict",
+					      "Recreated %d merge conflicts",
+					      nr_unmerged),
+				   nr_unmerged);
+		if (opts->source_tree)
+			fprintf_ln(stderr, Q_("Updated %d path from %s",
+					      "Updated %d paths from %s",
+					      nr_checkouts),
+				   nr_checkouts,
+				   find_unique_abbrev(&opts->source_tree->object.oid,
+						      DEFAULT_ABBREV));
+		else if (!nr_unmerged || nr_checkouts)
+			fprintf_ln(stderr, Q_("Updated %d path from the index",
+					      "Updated %d paths from the index",
+					      nr_checkouts),
+				   nr_checkouts);
+	}
+
+	return errs;
+}
+
 static int checkout_paths(const struct checkout_opts *opts,
 			  const char *revision)
 {
 	int pos;
-	struct checkout state = CHECKOUT_INIT;
 	static char *ps_matched;
 	struct object_id rev;
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
-	int nr_checkouts = 0, nr_unmerged = 0;
 
 	trace2_cmd_mode(opts->patch_mode ? "patch" : "path");
 
@@ -426,53 +482,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return 1;
 
 	/* Now we are committed to check them out */
-	state.force = 1;
-	state.refresh_cache = 1;
-	state.istate = &the_index;
-
-	enable_delayed_checkout(&state);
-	for (pos = 0; pos < active_nr; pos++) {
-		struct cache_entry *ce = active_cache[pos];
-		if (ce->ce_flags & CE_MATCHED) {
-			if (!ce_stage(ce)) {
-				errs |= checkout_entry(ce, &state,
-						       NULL, &nr_checkouts);
-				continue;
-			}
-			if (opts->writeout_stage)
-				errs |= checkout_stage(opts->writeout_stage,
-						       ce, pos,
-						       &state,
-						       &nr_checkouts, opts->overlay_mode);
-			else if (opts->merge)
-				errs |= checkout_merged(pos, &state,
-							&nr_unmerged);
-			pos = skip_same_name(ce, pos) - 1;
-		}
-	}
-	remove_marked_cache_entries(&the_index, 1);
-	remove_scheduled_dirs();
-	errs |= finish_delayed_checkout(&state, &nr_checkouts);
-
-	if (opts->count_checkout_paths) {
-		if (nr_unmerged)
-			fprintf_ln(stderr, Q_("Recreated %d merge conflict",
-					      "Recreated %d merge conflicts",
-					      nr_unmerged),
-				   nr_unmerged);
-		if (opts->source_tree)
-			fprintf_ln(stderr, Q_("Updated %d path from %s",
-					      "Updated %d paths from %s",
-					      nr_checkouts),
-				   nr_checkouts,
-				   find_unique_abbrev(&opts->source_tree->object.oid,
-						      DEFAULT_ABBREV));
-		else if (!nr_unmerged || nr_checkouts)
-			fprintf_ln(stderr, Q_("Updated %d path from the index",
-					      "Updated %d paths from the index",
-					      nr_checkouts),
-				   nr_checkouts);
-	}
+	errs |= checkout_worktree(opts);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
-- 
2.21.0.682.g30d2204636

