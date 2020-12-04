Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5315C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62037225AC
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgLDGRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGRr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:47 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72196C061A56
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:37 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f12so4186254oto.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc+SnzFY8q3WTBBmCreJK/5eg9jHtbWwXpaiLtv50BE=;
        b=cL7OeLtTv5m8ImiwU4nZjwUvshtwJlCm+1cWSiHs9ItN06AQuFGUVdJ6rH6bGBkGTZ
         1Y73mc9/MnYuq7+VB5cq5Bht9cqNLl8rBukZfkRWQ/qRHrbnsmtRq/GXkpndL/A0TgIl
         dcC2k+1pKsD6spkm9LhNB9XZ9zgz9QPJ+Nh1Sr4T5Ec8MEM85GV0pYmvyOqWr1DGewg7
         Hr+wWEo/M8UqqHpVPccGyDojwXzpLL9qik26c/KuMRp3zNtbkNzHa1PBdS9iMIe9GHgJ
         1d2sS6bkVegQkRZkWeRqK9E7Cc/xxFdxDBg80X81/Sn+QSnCIEYtj8hu6k5ilvz4ZCcx
         w6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc+SnzFY8q3WTBBmCreJK/5eg9jHtbWwXpaiLtv50BE=;
        b=aaXIsK4HzqsnRuCy1OhqBL5brM8XFaauOzX6FhZ6iHTWuNvy94E17ZX2n+jHnCqGVK
         Ul5Od856SAByU7Ae8i0itQkcOSXkZN4iwZgKPd4KkZazDV96p/+TCoTi7Yr0uR7YM3Oq
         eSGA4zkk1NPlpXos1dVK0z6EHVzbnB1cfhOnPjcrKs2iEmdQ93li94+uTUu3hyfAKsUD
         mAX/LPMdmO1/rV+6LOO0Nm1C19qj+HEiZKzwWyNDdBWELfxJjh6BZbQjaxKW4SZMTMrE
         +E+O5u0fiLLuv8vtJ7zceqcMbL8GVBh0gkEtFB8OQRrSPzPrpAim+6TUG6s9nNOcEja/
         jrzg==
X-Gm-Message-State: AOAM532/FAiNWbpQp+K1mq2SuGgmA2Bp10pmlSfATbQtN0tUPWKA4Hox
        47B2u/KbyUHYH3d6uEXJ64PE+UG4H5qPxg==
X-Google-Smtp-Source: ABdhPJyEL0JM6prBAzX2oXviz2l4QYGpl3hTS6GcKpX5E8GQLhRg6hRgt+bIeMIpCg77p8QIeBjzGA==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr2419296otk.262.1607062596614;
        Thu, 03 Dec 2020 22:16:36 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s28sm441490otd.2.2020.12.03.22.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:36 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/14] pull: move default warning
Date:   Fri,  4 Dec 2020 00:16:15 -0600
Message-Id: <20201204061623.1170745-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Up to the point where can check if we can fast-forward or not.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 8daba7539c..f82e214fc8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,6 +27,8 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
+static int default_mode;
+
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -344,21 +346,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	if (opt_verbosity >= 0 && !opt_ff) {
-		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-			"discouraged; you need to specify if you want a merge, or a rebase.\n"
-			"You can squelch this message by running one of the following commands:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories.\n"
-			"If unsure, run \"git pull --no-rebase\".\n"
-			"Read \"git pull --help\" for more information."
-			));
-	}
+	default_mode = 1;
 
 	return REBASE_FALSE;
 }
@@ -927,6 +915,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
+	int can_ff;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1022,6 +1011,24 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
+	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
+
+	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
+			"discouraged; you need to specify if you want a merge, or a rebase.\n"
+			"You can squelch this message by running one of the following commands:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories.\n"
+			"If unsure, run \"git pull --no-rebase\".\n"
+			"Read \"git pull --help\" for more information."
+			));
+	}
+
 	if (opt_rebase) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
@@ -1029,7 +1036,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
-		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
 			ret = run_merge();
-- 
2.29.2

