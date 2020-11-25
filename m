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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B0C64E75
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325662075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl2phbFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKYD3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:48 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535CC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:48 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id i13so163890oou.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0pc6VuEbfwATsQhF7UER4sXqH17WZgWHxeF74B6unY=;
        b=Zl2phbFX523RQM4LRIS2Ba0xV6WH17taSjVF1aUDCWSzxyCsSvCGak2nzMQcvcC5cH
         E1/ZdOP9KYnawMbvHvixjW+E8HQm6A+G2Z6LpNeAOwnTyxP9HMUGVB/CMsF0NHVcHjqu
         fjeaZuGxixlwsFOPOLfAeTIkl16LPCEx8NmgQUyM1tk77OfrJ0Sj4kPQ3O95Ezk0MPEd
         uaHk21OWrjYPrK4taKZQe7vNLxsm4sfLDzAtJTBD41GLmLVu5BebW7pv3l4DYjnes6Uk
         NkiunX8WRROwyXdtGh+M4ARKEq62OfZmQB6C9rDSgXA7uh7opid/T1nvDaseI2LwTGsG
         CPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0pc6VuEbfwATsQhF7UER4sXqH17WZgWHxeF74B6unY=;
        b=gkHRpXBG5rHSduvf5SEPcIjSlN/NGVzVcaB8p/1iJNfhS9bqw90YKvPZDbgHcdy751
         wpI5n7ymAEBlgI5/5J6vllLW8KWDieIbOpnLdd5cyex2y+G6B2pbO9BdB5OFVWbFNGkk
         0SPfFgOyEWpe/BI0DmE8WO6jgSCQfsL2gY2aYs4WiI/kKb5LMkPYTJaCZXk9lBpJ7NOg
         eSfLyE0uIBZeaeq7q/2DynsKVnVuik+w25MEx50wGAJs2Z9G9LaB5hSsxGHf4fAzL7Y0
         iKN/EOF3Ao87eRy+DeP+hhxHrEDnKMlqVQVUP5vonxb0S5Fll0qPjLs3/JL5MgXvvStg
         nYHA==
X-Gm-Message-State: AOAM5324+rPiPJN/87XCm2QhkL3sU6hNd+j2ej+jbEnLTvMQWOQGpKcM
        jVYXXmvHZ3SRwVjanDXN3BA0sYTIGbPV8g==
X-Google-Smtp-Source: ABdhPJztQ1v+R2mM0ZCNTzcLsvvTi8Ms7oRGfWqYWbLOFRebObsGfeaSudgON+E5xozB14/Qiu3Paw==
X-Received: by 2002:a4a:45c3:: with SMTP id y186mr1290192ooa.13.1606274987307;
        Tue, 24 Nov 2020 19:29:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o7sm573521otk.44.2020.11.24.19.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:46 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 04/10] pull: move default warning
Date:   Tue, 24 Nov 2020 21:29:32 -0600
Message-Id: <20201125032938.786393-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
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

