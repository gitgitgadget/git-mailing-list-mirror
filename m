Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287E1C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 03:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C6760F9C
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 03:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhG1DWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 23:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhG1DWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 23:22:35 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C1C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 20:22:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id f91so851916qva.9
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZlRO4h8QdBrOYfweNUlz87fUIob0gmfwfVAme7lVcg=;
        b=WlJ57eY8ancbyPQTpvMYiKi3AftK3E0EI+zQrZOq56U/6xGc1Xi1AiaAkH6iHlgr99
         vxbcOsXgAiyGAun7QFpzQ/iX5PPQ2kQwgFwod1froAeqIl1YNnbXwO5ThCh8kSyiJV1Y
         M10EsrhVMeaNfMRnH5lvth60L4wmzfmhVuge1AgrO7EKAvIbbKHAVwBe1am23aDXzgUG
         xkPJd+KqkwieEUsj1Q2Oq5x54akY2bHbIDdk32RRH077hC7L8+xgEHF3PpmAwkoXTXxL
         Gn8+ymwoZs2LHq2LpJ4GyBJrHH1HoQS/fTYVahnVMQCY+uXO4wIqCAcha9wfMb6JO3Hu
         3S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZlRO4h8QdBrOYfweNUlz87fUIob0gmfwfVAme7lVcg=;
        b=S3OPTvnHwKaOuSLEksRaoLQdiRO8lboULCDKQxKxN6K0SP4YHw/9teSzHUDfj7k9Eh
         MDc6wlKO0x0+zrbmPw2WR/FuYmI8Qg2GgL7p0fj/O9C7klQI48p6e6nPHg7mbB680lqo
         xh7+6YPNGVy6658ODiGd5gkHPFspCQYhTh7JwEqZax2kcmrD/DW5Tjle0iLVH2yPstTv
         ZaKQ87YvALbCRDYEstyymT9QApuBcMqhq+DjWeVzOSZIZ+RN2esTtEOMuxnCYvkluEDb
         18WQ1cOcCKSnFpEk2f9cJJ8Gn0MFHmANLqnAvS46tgHZk9/ZX/e38r8NcKHovMrozElz
         fYEw==
X-Gm-Message-State: AOAM531lxZmcOpPsAlkwzRngcBpy47O2oYLn9JW2z6oIfnmJWYrgTOty
        5jQJKgvrxm5ewawjACkSEgU/R4xRZMx+GA==
X-Google-Smtp-Source: ABdhPJzgj76p4XHE8BpHRCyBaSGzmDQ22uP7A9IlVMuWOeMSJQJks6Uzw1V/aZ92lehTwLMo/1cbrg==
X-Received: by 2002:a0c:f68c:: with SMTP id p12mr3081620qvn.32.1627442553578;
        Tue, 27 Jul 2021 20:22:33 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id 75sm2714420qkl.31.2021.07.27.20.22.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jul 2021 20:22:33 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V2] git-apply: add --quiet flag
Date:   Tue, 27 Jul 2021 20:22:30 -0700
Message-Id: <20210728032230.24611-1-jerry@skydio.com>
X-Mailer: git-send-email 2.32.0.4.g29b9734da9
In-Reply-To: <20210427194106.14500-1-jerry@skydio.com>
References: <20210427194106.14500-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace OPT_VERBOSE with OPT_VERBOSITY.

This adds a --quiet flag to "git apply" so
the user can turn down the verbosity.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V1->V2: rebase on master and rerun tests

 Documentation/git-apply.txt | 7 ++++++-
 apply.c                     | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index aa1ae56a25..a32ad64718 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--ignore-space-change | --ignore-whitespace]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose] [--unsafe-paths] [<patch>...]
+	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -228,6 +228,11 @@ behavior:
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
 
+-q::
+--quiet::
+	Suppress stderr output. Messages about patch status and progress
+	will not be printed.
+
 --recount::
 	Do not trust the line counts in the hunk headers, but infer them
 	by inspecting the patch (e.g. after editing the patch without
diff --git a/apply.c b/apply.c
index fb321c707b..d530c3eb47 100644
--- a/apply.c
+++ b/apply.c
@@ -5051,7 +5051,7 @@ int apply_parse_options(int argc, const char **argv,
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
+		OPT__VERBOSITY(&state->apply_verbosity),
 		OPT_BIT(0, "inaccurate-eof", options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			APPLY_OPT_INACCURATE_EOF),
-- 
2.32.0.1314.g6ed4fcc4cc

