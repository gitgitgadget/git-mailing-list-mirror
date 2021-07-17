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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B9C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57426115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhGQPoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhGQPou (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CCC061764
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k4so15595159wrc.8
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oz+gR5ZaJqyzXvto4nobi5lD/J9jrUp0NPZJ8hG60bE=;
        b=j8hBqoO41ljM/h2DIrSVqBv/Ori/716a7KTa1Ct5CkXGEU+FKWnqmQxEuoeVLk1QJe
         L1m7nKlXpAUbRNObZ3ylm5Q0ckcFlXfN0EJ47rkjU++k/dbJ1/PYuzKre4eVoCGpodOu
         VB1S7ullSvOpFm29vX/i0m0sM2CAihOadXIT+xIrcROehnuXCLYpPf2QDyliGshoSrrk
         sfCy1qgHbypEEYILhDsA/cR92zsVr5biU4kv101EEon81S4DHvJ48S2cHFwVB8ObaE1D
         tTHo7InV9zRQ2FnmvSrNu5Xe8CWIcK0+xXU9TIg3e/96VqcY731ABPvhs6q1S6Q/FFMC
         Q0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Oz+gR5ZaJqyzXvto4nobi5lD/J9jrUp0NPZJ8hG60bE=;
        b=UnJdfRww5ktFtSX6x5XWiHR4dbeSqjrNGEDnbKs9LSMfo5QBjj3YCgDMrfU3oBiweC
         dZ2wqvvOqRJtlKzqvOsvkUgPfFrDyNQ2J8ImmVzqKrAzSqb+XOMgd3cpWGphote+1gFS
         exOUC5NCsFVJm7BPnC3kVPuZMoiQ32Gzuxs17mJlB9ZP8VQ8FVpUA4Tf5WO8UWylEy+v
         fWyftflkd5dOUmJwrnCYsTQ4fZuZ//9K5A7gowe8fACLVLuO6XKEHgM/LIwOdAB1iwfd
         RD9nDXiUIRSqRiAq0HDqvfOvrAuVkSr90jZlaWxWpvlPmi8HG7xQYrCiqhSXwPvRwTvt
         pERQ==
X-Gm-Message-State: AOAM532GirVES2Jh2+lAJFP540LPJXpQkgBfCDFnRN1sPMWUVJyej6nS
        KQxlpfizZa1UrXhAaTOSv4yyVVunTcI=
X-Google-Smtp-Source: ABdhPJzBc7MoVtjlB5MqSXURJqP9se5ixcI5Truyv/157bYNRQZSfeAkCvcja9D+G+pxb4RaDmedOA==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr18894684wrp.127.1626536512041;
        Sat, 17 Jul 2021 08:41:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm13475662wrw.62.2021.07.17.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:51 -0700 (PDT)
Message-Id: <de4b460b09d3a3b6848f9f9eaa5520b31a3b453a.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:42 +0000
Subject: [PATCH 4/9] pull: since --ff-only overrides, handle it first
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

No functional changes, just making it easier to verify that the codeflow
matches our precedence rules.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d9796604825..5c9cbea37c9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1046,15 +1046,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
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
+		else
+			return run_merge();
 	}
+	/* If no action specified and we can't fast forward, then warn. */
+	if (!opt_ff && rebase_unspecified && !can_ff)
+		show_advice_pull_non_ff();
 
 	if (opt_rebase) {
 		int ret = 0;
-- 
gitgitgadget

