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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B43C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E50230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgLETyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLETyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:40 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932ECC061A55
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:26 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l20so2270683oot.3
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRCv7dqEG6so68bCrDwg7EAcFS4AtjxzKQCNl/L3Wdk=;
        b=GmdETvTzriHHH2jfWZqH+TIcFva5kX4W7KenOXTjxR0UjxB5tqy5NXMPQ1Pe9dK578
         D3aGXMwS7f2fJ5mJk6hqlRqnIaBVY+hahpWAlEqQjMiwDVBT1sT6lrWh24Q6VNFWy1vv
         A+mX67gMa6zC1Pgl3ymaThs0niqb3v6ZmcruVDiECIsaMezVjAY3rk6lg7YVTfHDbtdI
         kM+BnPicuipQDHzzfYaWYvypfQfedEvDkuOjLxVyIshI1bdrnOJ8MTTBUXtNj9OVC1aj
         H4cfR2t/u8TYmyfpdERgUnJ32J+Xw7gkmqT8eM/88nROQ/sV8ejdaepl1jWBGo4AXYKN
         AKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRCv7dqEG6so68bCrDwg7EAcFS4AtjxzKQCNl/L3Wdk=;
        b=gzM7HLeqjK93fVM+6dKhOhe7Ro+L5Eysoo7+UWj9QHQLAoVNBNAwoB99pO5V4/afsT
         AqjzVnnJaxYBc/kLU780QHcEjOVS+xGNbCrWxT3kUf80Fj3SKKBaqQW8Y84TH3ypvp02
         qYGIIQlo8CP6YokfZwXnmTFVoDhcmlBoqxGSAZ/v7XKliRIvNguZY+tlWWg7CG+rqf5H
         X6AZarsxxz0FUGY4y4KrfpWKtjHgm3f56XRvtjQmoOhez6Qmc1v+YCalJpQ70g5IPmdL
         HtRF0tt0USP3JS+idTK2edjdlN7s4evGoKZfTv1CTKt+BkxIe6WLZqBaaMvZj3e7ZmQs
         l+Bg==
X-Gm-Message-State: AOAM533om9w8NXCRZ6aGyXyQCaJH5fG1s5EFjLd4bbv5HMLD+c+jUxew
        2yuRWOuLYHvPRyOtlQpU/rnmERTkPjvk5A==
X-Google-Smtp-Source: ABdhPJye4r2pgFZSvb8nwJF9G67LR2oa6z733/jmuRInqnC+ClfC7DdhNogWLciaWz9EjhmoCzYREQ==
X-Received: by 2002:a4a:9563:: with SMTP id n32mr7855161ooi.53.1607198005704;
        Sat, 05 Dec 2020 11:53:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d15sm1358576otk.62.2020.12.05.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:25 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/16] pull: move default warning
Date:   Sat,  5 Dec 2020 13:53:03 -0600
Message-Id: <20201205195313.1557473-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventually we want to be able to display the warning only when
fast-forward merges are not possible.

In order to do so we need to move the default warning up to the point
where we can check if we can fast-forward or not.

Additionally, config_get_rebase() was probably never its true home.

This requires a temporary variable to check if we are in the "default
mode" (no --rebase or --no-rebase specified). But this is only
temporary; another patch in the series gets rid of that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index feadded1b6..3fd9bd1bd2 100644
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
-		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
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
+		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
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

