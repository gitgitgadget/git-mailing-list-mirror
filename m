Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3FC43214
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE40A60FA0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhHCPfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbhHCPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2354C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c16so25756194wrp.13
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4yrDo3FEcFUFpHnn04Gn/u+Bdr1H0IobTSGYGJFpato=;
        b=VsFOEquySf2NQ+M8VPCDteStS0bUVSlQNUmZYc3HtzROH84plmS0KLIA1xE2h7cDk+
         eiWSnoaiVtfjgtUO5I2ELVHq4U6/98RCfxyhFidVNF3qV4kBCI3i8g/0+ySP1v+KiFio
         iDoSgLE3vmEtrwZV0SMe3XbA/R2bhvMkcrtnSgnEKBtbh3LTCwgyrz6OJ3SvDUYLYSzr
         7GmcFW61E7yR2gdaglY1GvvDh409QB5WBJvIbK8+dTyQG8moZ2dVEgYvwbIwJit7Gkp5
         EXoKo3WivPPPAfgZAAMGlfDFjY4wHwbFzEATpxyMhtgf0Tv9o3gwdDwDMdcHeX5dw8dk
         3fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4yrDo3FEcFUFpHnn04Gn/u+Bdr1H0IobTSGYGJFpato=;
        b=JMsm9EQTsJIicHrucOsCYX8j+OlDRF7AKWU7QOKlwbs7qW7605GJAy8o9IMsr1qLOj
         BYIwNOqR9OisW2Yvvr97A6HuX+TKDO/04Y90vQfDiiQqinuQwejdsF0iXVhh+ejm19Yo
         lNRcRNIDLuydCnAfgsbvsGBaL84A7JsVJcRUsLSLQxqIKHLNvtisno6EMxQT1dT4as3q
         d8hQt6UE5vlU7p4ySMxftYoRMRmxj5oP0Pckd1ch3gPcE9jSAumh5mZgOXadiJ9mfbZ+
         B80eueTGfUMiVkxYmFPhnexEpFQ53xxJjOsplOoklLb30jSKLLM9zVSG5ycg0fq5RGxs
         jVTA==
X-Gm-Message-State: AOAM530eOfllO43i7ERQH9zHMRQw5Ft5vSDM5r2AJViz2z1YBXNYOQZR
        21CKSiJIikfTl+mmRJYYnGFf9NVEIkg=
X-Google-Smtp-Source: ABdhPJzmCRwRLznf4m5UzsJBt6JbSKdAL2nc7EFdcw85ESWXRjmvkYQVXBKrblpzOW9TQzOGLNegUQ==
X-Received: by 2002:adf:eccc:: with SMTP id s12mr23358046wro.331.1628004925402;
        Tue, 03 Aug 2021 08:35:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm14341708wrp.12.2021.08.03.08.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:25 -0700 (PDT)
Message-Id: <c1d056f0794ddcb0400901228b370b3bb5dfc0da.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:13 +0000
Subject: [PATCH 03/10] Documentation: edit awkward references to `git
 merge-recursive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A few places in the documentation referred to the "`recursive` strategy"
using the phrase "`git merge-recursive`", suggesting that it was forking
subprocesses to call a toplevel builtin.  Perhaps that was relevant to
when rebase was a shell script, but it seems like a rather indirect way
to refer to the `recursive` strategy.  Simplify the references.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt       | 4 ++--
 Documentation/merge-options.txt    | 4 ++--
 Documentation/merge-strategies.txt | 9 +++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a67227846a..7044afba362 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -355,8 +355,8 @@ See also INCOMPATIBLE OPTIONS below.
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy.
-	If there is no `-s` option 'git merge-recursive' is used
-	instead.  This implies --merge.
+	If there is no `-s` option the `recursive` strategy is the
+	default. This implies --merge.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396f..f819bd8dd68 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,8 @@ With --squash, --commit is not allowed, and will fail.
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git merge-recursive' when merging a single
-	head, 'git merge-octopus' otherwise).
+	is used instead (`recursive` when merging a single head,
+	`octopus` otherwise).
 
 -X <option>::
 --strategy-option=<option>::
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2912de706bf..5d707e952aa 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -51,10 +51,11 @@ patience;;
 	See also linkgit:git-diff[1] `--patience`.
 
 diff-algorithm=[patience|minimal|histogram|myers];;
-	Tells 'merge-recursive' to use a different diff algorithm, which
-	can help avoid mismerges that occur due to unimportant matching
-	lines (such as braces from distinct functions).  See also
-	linkgit:git-diff[1] `--diff-algorithm`.
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.  Defaults to the
+	`diff.algorithm` config setting.
 
 ignore-space-change;;
 ignore-all-space;;
-- 
gitgitgadget

