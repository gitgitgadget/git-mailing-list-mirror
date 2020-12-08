Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD5C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C990239EF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgLHA2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgLHA2N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:13 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4441CC061285
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:01 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x16so17628827oic.3
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkhDG3b3RniLLbtnc8hYE3uxSx5Awo6T7b6avTc03t4=;
        b=o3Qdysh2k0A0S7MqPg/AersSDD2xDnwFwZDNulCpZF+5NtU/mw8m0tEkHbxSc1GUev
         zrNjHtrQNLVUUFEU780fEyA9Hv5DAx9paqpSPaZGqXfG6zk3NAHDQB/wHxA+4lfpvcB7
         mbY2IVfOk9XrRI9tLkgoWpxbuR+70mIpWrA5o/f+t2QZKK31OnzncKa+tOGKrY3RO7ej
         +Gd3O5Y15lWQ3ZmHUzZe8gd+JLMFi9OVBfIYVGhSe6apxSEzet6n2vlW9KYeQrtF0A8b
         bRVi+ny8mzR16TS8EXorsu0ql8NhnrjJBaQXJhAcsmmpq7PCRH8/dBfVwsnLzZ6udZDn
         T4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkhDG3b3RniLLbtnc8hYE3uxSx5Awo6T7b6avTc03t4=;
        b=lpBl9MdGBd+JAgDDiNjvUXG7Eayw0RuaeRqmfVPP6Jho+e3Kgx2AOrzfTl6H8PNoa/
         Kocp+qvkqvjbleMcfH7h+j3vWbI+YMd2GfTn7W7bcdvLnBEcT7sZW8wg0FIqxPmu9Cnw
         9AkhavUemT07MFIdPZ0qxQgpSTQVJfOY1r77SamNylA1zIJ4l/OcaUdr2t0aQcKvI9o+
         DF33RIclgwA0rkkfGDZMvc+4QqZct9Frhi3Nz3dVeiaXw5pgHj0ERIIDWVUFWhfXVlHX
         +kHx4gXYj+EBvfxiJh7n4NogtsbK6fcz9ExPE0Veb/xs0TvCmplxyoQ2K/KGI9WeIXsm
         IWNw==
X-Gm-Message-State: AOAM530oVCmbteSTxWP2St2U9E9BGWy/Tj2LLu6ctMBPeF7nJGMtQJSV
        6Zq+zcorXZui8N/usjHEQAW9RLT/yAqxhaaj
X-Google-Smtp-Source: ABdhPJwYDDkpIeA6QM2lpR8JHYLvDLHY9pobVo/FYMXBB/RqmfYiYEZ/Arpt3fANz+de9TlBaOxGLA==
X-Received: by 2002:aca:5594:: with SMTP id j142mr1017754oib.164.1607387220455;
        Mon, 07 Dec 2020 16:27:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r19sm3026701ota.14.2020.12.07.16.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:26:59 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/19] pull: move default warning
Date:   Mon,  7 Dec 2020 18:26:35 -0600
Message-Id: <20201208002648.1370414-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
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

This requires a temporary variable to check if we are in the
"default mode" (no --rebase or --no-rebase specified). But this is only
temporary; another patch in the series gets rid of that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 6aeca4aeae..3b84ebf100 100644
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
-		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-			"you need to specify if you want a merge, or a rebase.\n"
-			"You can squelch this message by running one of the following commands:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories.\n"
-			"If unsure, run \"git pull --no-rebase\".\n"
-			"Read \"git pull --help\" for more information."));
-	}
+	default_mode = 1;
 
 	return REBASE_FALSE;
 }
@@ -944,6 +933,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
+	int can_ff;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1039,6 +1029,23 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
+	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
+
+	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+			"you need to specify if you want a merge, or a rebase.\n"
+			"You can squelch this message by running one of the following commands:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories.\n"
+			"If unsure, run \"git pull --no-rebase\".\n"
+			"Read \"git pull --help\" for more information."));
+	}
+
 	if (opt_rebase) {
 		int ret = 0;
 
@@ -1052,7 +1059,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
-		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
 			ret = run_merge();
-- 
2.29.2

