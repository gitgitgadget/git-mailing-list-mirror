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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB6C3526D
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E917F23B88
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgLRVLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRVLX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:23 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F57C0611C5
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:39 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 9so4332583oiq.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+F6cRJBos+Vo3d9Mk4QTpObXryw6TFb/P50PLf2xic=;
        b=Zmi0RFoAOtIWLKbrd+B0VsD+UQ490LuXjYtLgaBWjZ9B8INTFsHhiRu3Aq2avW75tq
         DxGVv32kTsIrxSiUl57GrjorDA0UIGY09xb1XeIvbGeWLUsQOzC/bfWKluetTBR6TJVq
         OUUuQKd8vSHr+JgomOmjRvxYTY1gNFcaVuc34LmmXHF9D2uq7ehKDPN3g+h9rsoTx9nz
         K14+eUMOdxR37D3olXzfFvuIaz5fhmvtaGhDQ4+F1Zuw44gcGg6Sfwps+TzeohDzn2MU
         HOolSblUjfhNrPlJF1locfQbhQ/biXKxYfUo7yCwihecnacNIG02hKM4khmbq6++qUov
         lqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+F6cRJBos+Vo3d9Mk4QTpObXryw6TFb/P50PLf2xic=;
        b=iJRsqFNbK/Huvif0nKN0JtcJNOf5V/NZf6K0yjbv2hV3JNfRoOxI05lHwxHeijrWgJ
         g6cbw3Yovmo7/oWIJ1xo9tC4i+5iFL/1qeQc560GRQRP+svqU8iXztRrTR9NeGZ/zH0p
         ocUWhvYjl37CHyigumjY3C90T/6NipMEoFGxfNhsfWmwW4pxHoslLGZIEgNVsdCFksct
         kSJ4pXEpWy5UEl22EsfmEBvUe10DW32I8AWGaVOrT0QWW9jA9neBVJ3EVBlnyNX/Skk+
         ozjkeh3IeBfYmRg5F4xxTPY1PXD3QdStlaHKwFIZPg319yZxbh/Y8mm3X7/mr/Y0nRzY
         x1wA==
X-Gm-Message-State: AOAM5304E0sMu4bOK4sQHafVhgiD4Qp+gfhS8OVEMsosDYTDK8b5KXsN
        a6ZbTAyX9nELt8yPWLLnE68XAx8xZptQbg==
X-Google-Smtp-Source: ABdhPJym00gt1aWAVNBLZxrA2/D1Q5QZt9asGWqoV/sk7cZJrZ5LvyQV2Dzq4EsbGdR1ZGT04tvg0g==
X-Received: by 2002:aca:af8f:: with SMTP id y137mr4202254oie.55.1608325838154;
        Fri, 18 Dec 2020 13:10:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f10sm2145361oti.11.2020.12.18.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/13] pull: introduce --merge option
Date:   Fri, 18 Dec 2020 15:10:19 -0600
Message-Id: <20201218211026.1937168-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
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
 Documentation/git-pull.txt   | 11 +++++++----
 builtin/pull.c               |  6 ++++--
 t/t7601-merge-pull-config.sh |  8 ++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 142df1c4a1..195496e63d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -71,8 +71,8 @@ not possible to fast-forward, so a decision must be made how to
 synchronize the local, and remote brances.
 
 In these situations `git pull` will warn you about your possible
-options, which are either merge (`--no-rebase`), or rebase (`--rebase`).
-However, by default it will continue doing a merge.
+options, which are either `--merge`, or `--rebase`. However, by default
+it will continue doing a merge.
 
 A merge will create a new commit with two parent commits (`G` and `C`)
 and a log message describing the changes, which you can edit.
@@ -159,8 +159,11 @@ It rewrites history, which does not bode well when you
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
index 48e25a5061..1336b59b21 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -129,6 +129,8 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), REBASE_FALSE),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -930,7 +932,7 @@ static void show_advice_pull_non_ff(void)
 	advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
 		 "you need to specify if you want a merge, or a rebase.\n"
 		 "\n"
-		 "  git pull --no-rebase # the default (merge)\n"
+		 "  git pull --merge # the default\n"
 		 "  git pull --rebase\n"
 		 "\n"
 		 "You can squelch this message by running one of the following commands:\n"
@@ -939,7 +941,7 @@ static void show_advice_pull_non_ff(void)
 		 "  git config --global pull.rebase true   # rebase\n"
 		 "  git config --global pull.ff only       # fast-forward only\n"
 		 "\n"
-		 "If unsure, run \"git pull --no-rebase\".\n"
+		 "If unsure, run \"git pull --merge\".\n"
 		 "Read \"git pull --help\" for more information."));
 }
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933..6d03e0b9fe 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -60,9 +60,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c0 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
@@ -119,9 +119,9 @@ test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)'
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
+test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
 	git reset --hard c2 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.30.0.rc0

