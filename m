Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F0C64E7A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD6A204EC
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1Aj6yZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbgKXNau (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbgKXNas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 08:30:48 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D1C0617A6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:48 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id a130so15660734oif.7
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0pc6VuEbfwATsQhF7UER4sXqH17WZgWHxeF74B6unY=;
        b=J1Aj6yZqGUxsqPm+CGM1JgD7IJ7FgLvdXBf9V4qnSmUDPflqCEa5Vcac4Sz/aFBHeM
         YFy2sh1CodlEi9sFYbgFNS5404b2JOMktU5qXpafGsgNiUNwDs8J+qV4TsQEellf+DEc
         HR+3UMIPQjMzXFSdEm13MSqgQzYmm4uLLaY03WWSAMYslsZXL47R+YLmX0uYLNbtmdQO
         J7dUJ4LogNEmiyxJNtBIS++zzwrms4htPc8Bf0HXZmQR6opZEZXIvINUwe6n5jO9z8qr
         ZwfCpsVmjjQcF3wpzBe1q++FHdBhldRbNzIAdtzJBR2GW1iMgL5yguaK8U4e9dY1dubx
         Hb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0pc6VuEbfwATsQhF7UER4sXqH17WZgWHxeF74B6unY=;
        b=NnG5SjI7JMbfyDz4NamBngkHuil2iZCGXVPLgd9Ges1iepgP0wbnT9SqGCzu9k5MLL
         Fp/MZbuC/T3DfwR7cOufzCKVqAooaylPX7oVE6kl9mi585FlWNqKQb6jATAuMKTGQIRT
         7vubnDy+tfaWOpdQqwEYQ1Jje/GrmOEe+8+IWPJQGjaRMwvg5j9ekfwGNgwMQBUdd7X4
         JQmXov3sJ7v12ZUagpTKynDDCuBTKxL9eoC0bh108O2AWyoj3dJ47r4Uvg+IAxDB5FkA
         Ox07fAOXew2LsUhtn+lT0YQIoLt3gyk05dCQS38qE2rZQZKSXIUt1nOCAQVw+lx55NDa
         5k7w==
X-Gm-Message-State: AOAM5333XJ1w1/HhLxX1GGJKe8jOcGe/XDqIKtvRjW2U88HDVtNnGh4k
        wWjbAfoqmrMpyOFsxdnPhscNDBMnm2aIkw==
X-Google-Smtp-Source: ABdhPJyXV951F9lyFwa7U3dvzBS5ZFpGsFKr3am/emd/+LQ3GidY9kdtRs7yl3Z2tLgEmMA03T9ywg==
X-Received: by 2002:aca:da02:: with SMTP id r2mr2728730oig.157.1606224647072;
        Tue, 24 Nov 2020 05:30:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t10sm9362015oot.35.2020.11.24.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:30:46 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] pull: move default warning
Date:   Tue, 24 Nov 2020 07:30:35 -0600
Message-Id: <20201124133037.89949-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124133037.89949-1-felipe.contreras@gmail.com>
References: <20201124133037.89949-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Up to the point where can check if we can fast-forward or not.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 121b9fb0e1..9a0f7937c2 100644
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
@@ -344,20 +346,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	if (opt_verbosity >= 0 && !opt_ff) {
-		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
-			"discouraged. You can squelch this message by running one of the following\n"
-			"commands sometime before your next pull:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-			"or --ff-only on the command line to override the configured default per\n"
-			"invocation.\n"));
-	}
+	default_mode = 1;
 
 	return REBASE_FALSE;
 }
@@ -926,6 +915,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
+	int can_ff;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1021,6 +1011,23 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
+	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
+
+	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
+			"discouraged. You can squelch this message by running one of the following\n"
+			"commands sometime before your next pull:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+			"or --ff-only on the command line to override the configured default per\n"
+			"invocation.\n"));
+	}
+
 	if (opt_rebase) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
@@ -1028,7 +1035,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
-		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
 			ret = run_merge();
-- 
2.29.2

