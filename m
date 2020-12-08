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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27628C4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AB223A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgLHA2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgLHA2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:16 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25009C0611CA
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:06 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h18so10375478otq.12
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3f3M963Q1DaGohU8WNwVTKIRG8ZNG36/Yd3vo2HW6M0=;
        b=X5gb3DkchzBSG/Ub03LBjWWFv2u+HR+quchLLNJxejCIFeIK1sOqKJ0VWQq0a2pvRC
         gHGPj3WFYNyZ+WcOvDyi+Fue9LLfIceE3fT8bLBM0I/9581BX8jztmdpcmC8A26y1zRS
         vMPsZd7MmQvLA601dCbTU+eH1sS+NexMzQPXiuTSi3zXJCrk3CIi/ZNeG090pyaAnq3F
         jGjN4zxesU3rwLvEnZZJGw+5OtPc7UvpCUyRNlmbodNQCdVE1WefP451TuHfT+ssxOPl
         C8LjrRiT5pFqfftSxseL9yj69M6yFdim+O0toAuqJbRibTF+VM2BupVKyCpqKfhxJISj
         0tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3f3M963Q1DaGohU8WNwVTKIRG8ZNG36/Yd3vo2HW6M0=;
        b=M6q2W+lnm3hIz0t+sp90pb4N61FH8ljruGDUiWljKrsiIwbd9GRAHOr39llg6v8RVM
         FpI11BFdAXWXLZr6wZkg98bCjYYLpKoGibiL1W/NMw6+mshmU/mGd6V9TGjhR8p0+qIe
         Kgy3/LMSxpCKgAWAa4lxaC8Lb3d1M+P5M8Be7sfMBP9xk21gQnYCzU5i1dGcMXDdSuxx
         NS3s33J7PeNLlepHcdxNvtIvhCcKRXsdpcl60iKKR+WPUADrOo5LWgrkJ1B70D06bw2y
         bIxmPP6VQ4x/vbBp1VM1AaYjI7UHf31ovG1OupBuxYx3gFWMKW0fnHGeRqxBnEbU0yCF
         sZFA==
X-Gm-Message-State: AOAM530VxCvHOqSh9dymZE2TxdAoAzWcpeZsU7k6pWYpj8n0xx76IE9n
        TKRXxkO9MkhjtpG76SpdfSfOL0tYt+jurBau
X-Google-Smtp-Source: ABdhPJyNPtWQK2xY7YaVhc6hDvaP86PN5lQlDGjqy6BU95EK2UyyEbUKbN5gDGd8YbXeVUlvkYytmQ==
X-Received: by 2002:a9d:6207:: with SMTP id g7mr14465893otj.22.1607387225330;
        Mon, 07 Dec 2020 16:27:05 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q18sm2712256ood.35.2020.12.07.16.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:04 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/19] pull: introduce --merge option
Date:   Mon,  7 Dec 2020 18:26:38 -0600
Message-Id: <20201208002648.1370414-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously --no-rebase (which still works for backwards compatibility).

Now we can update the default warning, and the git-pull(1) man page to
use --merge instead of the non-intuitive --no-rebase.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   | 9 ++++++---
 builtin/pull.c               | 4 +++-
 t/t7601-merge-pull-config.sh | 4 ++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 2fb184ab5f..21b50aff77 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -61,7 +61,7 @@ However, a non-fast-forward case looks very different.
 ------------
 
 By default `git pull` will warn about these situations, however, most likely
-you would want to force a merge, which you can do with `git pull --no-rebase`.
+you would want to force a merge, which you can do with `git pull --merge`.
 
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
@@ -148,8 +148,11 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+Previously this was --no-rebase, but that usage has been deprecated.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index 4c91dd291b..3874434421 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -131,6 +131,8 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), REBASE_FALSE),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -1042,7 +1044,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"\n"
 			"You can replace \"git config\" with \"git config --global\" to set a default\n"
 			"preference for all repositories.\n"
-			"If unsure, run \"git pull --no-rebase\".\n"
+			"If unsure, run \"git pull --merge\".\n"
 			"Read \"git pull --help\" for more information."));
 	}
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6b4adab8b1..1de64e6cc5 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -69,9 +69,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c2 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.29.2

