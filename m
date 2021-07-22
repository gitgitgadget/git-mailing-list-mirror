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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643AC63797
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C3D61279
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhGVEYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 00:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhGVEYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 00:24:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B297C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id x14-20020a7bc20e0000b0290249f2904453so1822784wmi.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m2UkihbsxNjwb3jT/6ahzcYdeiRDdofSrnT99tt9PpQ=;
        b=unHPGz/qbJ1pgu28ITx3vQJx0pIalO7DXuwcvvhueZk/1T0nNxgESHyDLwSqgBkeg7
         vugdymWienPmsd6EdT9JdegYPUz3B25o1FuyLafYt3BXBrzQSmyQ1MPytvDvLTdinPVr
         GBDCEJGnYGvhyVFZPyMjlYqCidm9Ur1jk7e6Ex2WoW74W5W/V2ShyYKVNaQMWBwN8A40
         8dip8+vt9mXDzYZc0s5zSEBt/EOGhxBnrxWWUp57Fuk0aAyimFiXFRD0Ca3M+YU6Iqk3
         xzkf0pkAD+RGvRPQy2apnlN6rNZCA4Yp87PFFqLA/Iqnb8HytMotsEnQk7HL4lpl+C+A
         F17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m2UkihbsxNjwb3jT/6ahzcYdeiRDdofSrnT99tt9PpQ=;
        b=mMk1SY+/sYFCVLtv5M7FfBjFf41FVOThrf3Xx+pxl9RelNXVSYfPCo6Ue6a79hjA7O
         w6kjAHgXee5WQ1K+svZw6DU5uSMgT67aSNNzEHnwMEuPXWQOv0wL4YnEFRFnvZeIpVGS
         FVB99a7OcOGlEftPu2ZKXAhVv7ZmBlTD75OJC8wGepIPT1IQ2uAQUZFOEXB+DtLHdJbY
         hTf6dUJzFBPFSCsxX7v8x8vHdf+M3sfbjTrZ6Rn2u+RL0kMTcewKb3ii1DBvuR5IjTyy
         EOT1JrZX3dvx5tR93DUUwL9C/zINvV/PtwvnZMc+JDgb71xh2Bo1+e/cMMTE37RuwiBT
         6Bhw==
X-Gm-Message-State: AOAM532Ir204NvOgCMWLAb/EcBzCZvXRQNRbCXN2naKyyfSZ4CI69fZH
        ccYWJsdu5gntSVm/7reDICO9onSi3cY=
X-Google-Smtp-Source: ABdhPJyPHBI1BO4o0Rn8LIe+BJPLRPBys6IX5cYLkwf/ZS9BUuaj9qxUp+t2hVVzLRpvkEVTFq8WFw==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr40480760wmi.21.1626930294154;
        Wed, 21 Jul 2021 22:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm29301236wre.84.2021.07.21.22.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 22:04:53 -0700 (PDT)
Message-Id: <0682b2250f400e9a3eb1f40f48d32c2cb8c56b0a.1626930290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
        <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 05:04:46 +0000
Subject: [PATCH v3 4/8] pull: since --ff-only overrides, handle it first
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are both merge and rebase branches in the logic, and previously
both had to handle fast-forwarding.  Merge handled that implicitly
(because git merge handles it directly), while in rebase it was
explicit.  Given that the --ff-only flag is meant to override any
--rebase or --no-rebase, make the code reflect that by handling
--ff-only before the merge-vs-rebase logic.

It turns out that this also fixes a bug for submodules.  Previously,
when --ff-only was given, the code would run `merge --ff-only` on the
main module, and then run `submodule update --recursive --rebase` on the
submodules.  With this change, we still run `merge --ff-only` on the
main module, but now run `submodule update --recursive --checkout` on
the submodules.  I believe this better reflects the intent of --ff-only
to have it apply to both the main module and the submodules.

(Sidenote: It is somewhat interesting that all merges pass `--checkout`
to submodule update, even when `--no-ff` is specified, meaning that it
will only do fast-forward merges for submodules.  This was discussed in
commit a6d7eb2c7a ("pull: optionally rebase submodules (remote submodule
changes only)", 2017-06-23).  The same limitations apply now as then, so
we are not trying to fix this at this time.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d9796604825..1f452020375 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1046,15 +1046,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!can_ff) {
-		if (opt_ff) {
-			if (!strcmp(opt_ff, "--ff-only"))
-				die_ff_impossible();
-		} else {
-			if (rebase_unspecified && opt_verbosity >= 0)
-				show_advice_pull_non_ff();
-		}
+	/* ff-only takes precedence over rebase */
+	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
+		if (!can_ff)
+			die_ff_impossible();
+		opt_rebase = REBASE_FALSE;
 	}
+	/* If no action specified and we can't fast forward, then warn. */
+	if (!opt_ff && rebase_unspecified && !can_ff)
+		show_advice_pull_non_ff();
 
 	if (opt_rebase) {
 		int ret = 0;
-- 
gitgitgadget

