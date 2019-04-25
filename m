Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365E01F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDYJqf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42041 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYJqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so6460323pln.9
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+syBewQw6W1x7/nChiv+kdXH/4gtx3oQj5MkdggUCVE=;
        b=Eh8LZvh8dbqwjojgJdTfG3VrUwKFYVhR1G5hRPhH/tDqZBUBRgfQVIQbttNvwGos48
         a2Ltyh+fHLserbzjaAPzFVSKPgijAvEUNzL7pLcTJK3iFQkNXx77s11mEf7q8a0IO/5R
         XxsGJGRShOcMZSa5lJu/5QPcyYNhByHzN3yMDbyaQs3dJiIeHp9Tl5KjcTiw01FecIlZ
         2pl+R97pe3K13ipEJFHq6EMVK9ZCCFFYtdQIOX4gB0HrnFdGrFmTl9gEIOuTvysqbh+k
         F0yk+c3LOMI874nFIrymyBf4yU2DQtgNCEJ8cNF+KuZJe/bbDtqeVM3GQxrs1jV7vtGP
         UzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+syBewQw6W1x7/nChiv+kdXH/4gtx3oQj5MkdggUCVE=;
        b=Y05Kr/XF7XwWM/sVI1JLPXXJMO9lDafM1KoNFdEwsm1MWkaMfj1yE5Yg7v/mndDwMA
         Iyhjen+F4j6Lv3oC/4Np/saFkRZA8hmto3Kbet0hr6TKEcLkvFriAZw2UfEZzOV5H7Xm
         doKPwC+v1AXWy/QKLgpY9uu60EFNZR3g0aDOUDBl1+F5LBFy16b8lodiM1YKWsZDrVYG
         FDDAV2cyLm7ek6kGjO9PCwkBFPbOTRyKTJiqEZzG53u5X0BOZosg1C6ezzsgYj946iHe
         NE26385Fw39HTYGjSOlgpieHznBF84k3gJrPe4cgIf3dXutE1uhDzP42dkbdihtzLS+0
         luQQ==
X-Gm-Message-State: APjAAAUAmBQj2rKEidYgdztej4Qo89NXECSoab7XcUDbGb0cLousub0h
        uYsXf/KhlDSi2WhApikq7MY=
X-Google-Smtp-Source: APXvYqxAlqHlmCAaRsQJNAzOmhh8ZCuCsiO4UN1OqxWuOTCE974z53ZDMhRyahF22kP08am1kWXoJg==
X-Received: by 2002:a17:902:525:: with SMTP id 34mr38570186plf.138.1556185593876;
        Thu, 25 Apr 2019 02:46:33 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id t64sm44953095pfa.86.2019.04.25.02.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 05/16] checkout: factor out worktree checkout code
Date:   Thu, 25 Apr 2019 16:45:49 +0700
Message-Id: <20190425094600.15673-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
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
2.21.0.854.ge34a79f761

