Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F67C64EC7
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 05:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBVFRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 00:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBVFRs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 00:17:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5961311F5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:17:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id bh1so7522448plb.11
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5UlHB7LPxWJ10EJ9pJiEAqGMgTqUlUGWQxUeQhgqKw=;
        b=O0360nlJI70Vb6qla76MBQQBwXFf0Lcwy2VWbl8uq10QnYeZNWXSNG2JCAlzPcwPr5
         JouS/Nr2o8QjjFuX+BuzSSNfmVSYnS+0Av4FvwOk+XHnMerHF+3npD5U2VK/oPkYjefo
         DpAhIOdtK8NZnZhVLPCxnH5sB7zpYMtNPbFbvxEYbJ/uAIZgub8U/a6JjJHqrzr6Exqf
         XZq0pqB5baLorBAVrXvIIs2P25FgmVERF8CWTR8iVcxf7Y/P4DJqzLRq4OCuY/EZ16Fw
         uiRgQM0tTLT31IjEyjpAoL/GQE/TG8CBGn5NNYUpvLF6Dz7Halsg1qaF/IENkoD80pjY
         tJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5UlHB7LPxWJ10EJ9pJiEAqGMgTqUlUGWQxUeQhgqKw=;
        b=1g4JSZpCAEVQXoApR5GBgLAimuCvxi0agz4O+MmrjmT6bz1OtvusnHvqvDeF92TbhC
         +VoIbruhnwY05kPSQscb498s/abcGr4zMXgynCPFr6GZPrlMrxJfzpO5hZo+NX2G9fjO
         cqSHAj0U2VLxwz6Aht8bVtpF3LDJek+l49FNl6Opj4EiNs9Z77o5pUFYGBBmVw6bXCPQ
         27eIhztWOBxlIWPdtqnW/mdBSFMGoyH9/ERWa1foEO7cOKq+uuX8cFBOdJ8NBlvPsNlo
         bgBNuXdJRlPQo8KLze2TfP/Hhv8uiDqM5lgDFQ/Hwk/RhBreDjKyBBO+pgMlG3D0zslO
         AtVg==
X-Gm-Message-State: AO0yUKVJTqiBvt5DyTKOtHxrfgsFaq+zILIFz2Hx2c1bhPWNZ3YcuDfQ
        F7AD3SSL9IWNUPiGsH+uvoW3s/RYz/Y=
X-Google-Smtp-Source: AK7set9r6cXZThql1BUWIhB6TKJcQR+xrJ+B5ymQNeOxDfIvReEzu7QM0qRp2VPerzRURBuBJfrjWA==
X-Received: by 2002:a17:902:cecc:b0:19a:7c7d:7180 with SMTP id d12-20020a170902cecc00b0019a7c7d7180mr10179618plg.34.1677043066101;
        Tue, 21 Feb 2023 21:17:46 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b0019abb539cddsm10720204plp.10.2023.02.21.21.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:17:45 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 2/3] rebase: stop accepting --rebase-merges=""
Date:   Tue, 21 Feb 2023 22:17:08 -0700
Message-Id: <20230222051709.464275-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222051709.464275-1-alexhenrie24@gmail.com>
References: <20230222051709.464275-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
empty string argument) has been an undocumented synonym of
--rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
confusion when a rebase.merges config option is introduced, where
rebase.merges="" will be equivalent to not passing --rebase-merges.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/rebase.c         | 6 ++----
 t/t3430-rebase-merges.sh | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..b68fc2fbb7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1140,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1437,9 +1437,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		imply_merge(&options, "--exec");
 
 	if (rebase_merges) {
-		if (!*rebase_merges)
-			; /* default mode; do nothing */
-		else if (!strcmp("rebase-cousins", rebase_merges))
+		if (!strcmp("rebase-cousins", rebase_merges))
 			options.rebase_cousins = 1;
 		else if (strcmp("no-rebase-cousins", rebase_merges))
 			die(_("Unknown mode: %s"), rebase_merges);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index e0d910c229..b8ba323dbc 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -293,6 +293,12 @@ test_expect_success 'do not rebase cousins unless asked for' '
 	EOF
 '
 
+test_expect_success '--rebase-merges="" is invalid syntax' '
+	echo "fatal: Unknown mode: " >expect &&
+	! git rebase --rebase-merges="" HEAD^ 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.39.2

