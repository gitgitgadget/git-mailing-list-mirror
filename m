Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3EEC07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B50613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhGEMfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhGEMfT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:19 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A1C061764
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:43 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso6383570otq.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxlnXlmf6ztfJzYZzdLZDHPR1dy55OG9f/FuBrGPtdI=;
        b=g3+K7AfhMPAElFD+1h1y78usK5J9MzLOutcYB2Tx8KA0DwBCl6JfTwxH3e0mOonZFg
         +yxtzci+F7Jf95q8r4POMmkCrJVKo1Y78IBEqVqEG20pT1CSlg2R2AMVJeH89LfW2wi8
         amJwo+4fMHOl4bIcuxFzdR/c3dot2MJqGymk7q/vcukmq2DuccEZyDHU3hiz5Glz4Omt
         VwZUaA2c/HYgr7QxtPgji3178NiXNsy4I4IYqrdFpB2Otylu892qfNmR4AOzhJqdJCjU
         qiISyxniZ4ngvhS24dImwTOoOyM2YnW3fzzHrql/xQ66pcas8QAOJnDsIVNQwpq2FlkO
         yRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxlnXlmf6ztfJzYZzdLZDHPR1dy55OG9f/FuBrGPtdI=;
        b=cifc0Cic8R9gn6Y/Ni4cOivoIrOOkGMQv0tV57RYNa4Ry0noQ3vB/GGBSP58CbneMj
         L0Qy2txfXiWq2f4m0xuMHYqHE3agLySWH11YLlUO0vmmcYcfJQvaO4HvfCjwOkQPPzON
         WgKJIH7WbfCIgEs+gL53aE0fDfpkk2FyODxm481OexNx52CjU8p8dQ7TMo71SY5jPIMj
         4eUGwUckI7cF+AXYD8N/UBeGSosKIo9KZVRpo7b3zInOF/lq44+BlhspYuVIc5cyleTz
         mM0HErdhvG1tvGuJNz1toz9A2cpVJjtidBEp/BTbigbBv1F1tjH8s89ia/aJ+QTAjrqV
         fdRg==
X-Gm-Message-State: AOAM531bWal1PIP07mOuTxNyn6y0zHv/HtJw9Djof+MAdNUat9baU/3K
        bYccMatM3O+fyDct3sXQuZ3QQXu66+uQoA==
X-Google-Smtp-Source: ABdhPJxewuasYOFz4vp0IvTrBfgbg9GMF2X3QS0hXDpdwko1lH04tR8Hh11olpj0vcpNR+t9CGT/ZQ==
X-Received: by 2002:a9d:4c97:: with SMTP id m23mr10348706otf.354.1625488362265;
        Mon, 05 Jul 2021 05:32:42 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id f19sm2186451oou.22.2021.07.05.05.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 18/35] update: add per-branch mode configuration
Date:   Mon,  5 Jul 2021 07:31:52 -0500
Message-Id: <20210705123209.1808663-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  5 +++++
 Documentation/config/update.txt |  3 ++-
 builtin/update.c                | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..ba355f23e0 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -96,6 +96,11 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+branch.<name>.updateMode::
+	When `git update` is run, this determines the mode of operation,
+	possible values are 'fast-forward', 'merge', and 'rebase'.
+	See `update.mode` for doing this in a non branch-specific manner.
+
 branch.<name>.description::
 	Branch description, can be edited with
 	`git branch --edit-description`. Branch description is
diff --git a/Documentation/config/update.txt b/Documentation/config/update.txt
index 42a7fe1614..e6db45b6c3 100644
--- a/Documentation/config/update.txt
+++ b/Documentation/config/update.txt
@@ -1,4 +1,5 @@
 update.mode::
 	When `git update` is run, this determines the mode of operation,
 	possible values are 'fast-forward', 'merge', and 'rebase'. The default
-	is 'fast-forward'.
+	is 'fast-forward'. See "branch.<name>.updateMode" for setting this on a
+	per-branch basis.
diff --git a/builtin/update.c b/builtin/update.c
index 4a1b82a41d..50905f5806 100644
--- a/builtin/update.c
+++ b/builtin/update.c
@@ -7,6 +7,7 @@
 #include "run-command.h"
 #include "config.h"
 #include "dir.h"
+#include "remote.h"
 
 enum update_mode_type {
 	UPDATE_MODE_INVALID = -1,
@@ -58,6 +59,22 @@ static int git_update_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static void get_branch_config(void)
+{
+	struct branch *cur_branch = branch_get("HEAD");
+	char *key;
+	const char *value;
+
+	if (!cur_branch)
+		return;
+
+	key = xstrfmt("branch.%s.updatemode", cur_branch->name);
+	if (!git_config_get_value(key, &value))
+		mode = update_mode_parse_value(value);
+
+	free(key);
+}
+
 static int run_fetch(void)
 {
 	struct strvec args = STRVEC_INIT;
@@ -112,6 +129,7 @@ int cmd_update(int argc, const char **argv, const char *prefix)
 		setenv("GIT_REFLOG_ACTION", "update", 0);
 
 	git_config(git_update_config, NULL);
+	get_branch_config();
 
 	argc = parse_options(argc, argv, prefix, update_options, update_usage, 0);
 
-- 
2.32.0.36.g70aac2b1aa

