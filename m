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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66815C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3AD61175
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhGUBCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhGUBB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:01:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7EAC061768
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m2so403206wrq.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2xRQIKYaSNZjQO64KokUzEw19VQR81HQ8kMdXsa/6cY=;
        b=SscHMNtFYuAtL/uT11vT09335wCYMzIZfeLC+Q/0PKwDCqi7f84iNJgrHPJt1A2NB/
         S0KubTi3vGTb8twLcqwZu0HgLifbNNZGAAv1pDzz8CDybn8uoQIaBGSnVgeWeCAb/78d
         6hOU7gGa8nWmDgePa7r5JlDJcNkMewoN87FIXx4VSFb6bA/a+TLzZ+gtFIEsysmwSNWd
         zq2pzHP1UcSYAYEASck1uLmpkECi4ubbIxSFfaltY/4KNUOWHbiNiQ2Run9GPGq0/K7l
         8eKcpMglq52asrDA1buzh7NVLI+CSGMNbJ2/+N3JZsYpxARStob+9et4/j03fQLJI/sv
         aPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2xRQIKYaSNZjQO64KokUzEw19VQR81HQ8kMdXsa/6cY=;
        b=ftqOjBlBc2ndsyxygq2bl9YSTJH55igrgi/SgORyuWyv5Lxx7JSSk6zi/N3KeuTb4A
         X2ryklgDNGdfKRl49o0IE3ODrZfrNSvkE7eFRqB2O6x8kOtSEvaQJtaAUK4mq7VpqOEq
         ZsEHA4VEq3x3kV9NUuvBkDTalqeoxBWzKjV0G0v2g+kCpafu2CbxK+/5sRFH9cCMiYBp
         S1hMMSCFawB3zmODnh3aasVYQutK+2PxURvYNCI1pZSlcqYi5DMfbq5D4hGYFdhoVPFV
         hNhdsrK803S9HAwTY0ItftFIVFvfYkJUOGSVvqs33VGfcDjsMP/F9yBmBWhZVtHlCjwP
         JsvQ==
X-Gm-Message-State: AOAM533iJ1WFmHGPkY448eGI6QxdxesF4bL7o+uLg49G+yq84CirBPHO
        9FG1D6XI/ynkh+OIHt8jAUc6c3UPqQA=
X-Google-Smtp-Source: ABdhPJxMLDuVQxYx5dLuON9jVyhr+7AOogCL1X0L8NA95QGWmYTSh9HmA5NR46QlaOeZu8nPcXFf2A==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr39392171wro.183.1626831749295;
        Tue, 20 Jul 2021 18:42:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm20813753wmk.37.2021.07.20.18.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
Message-Id: <9b116f3d284840052945292f73c47bacdb2f86d6.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:21 +0000
Subject: [PATCH v2 5/8] pull: make --rebase and --no-rebase override
 pull.ff=only
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
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Fix the last few precedence tests failing in t7601 by now implementing
the logic to have --[no-]rebase override a pull.ff=only config setting.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c               | 16 +++++++++++++++-
 t/t7601-merge-pull-config.sh |  4 ++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 92150f976cd..da1d4b19666 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -966,8 +966,22 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
+	if (!opt_ff) {
 		opt_ff = xstrdup_or_null(config_get_ff());
+		/*
+		 * A subtle point: opt_ff was set on the line above via
+		 * reading from config.  opt_rebase, in contrast, is set
+		 * before this point via command line options.  The setting
+		 * of opt_rebase via reading from config (using
+		 * config_get_rebase()) does not happen until later.  We
+		 * are relying on the next if-condition happening before
+		 * the config_get_rebase() call so that an explicit
+		 * "--rebase" can override a config setting of
+		 * pull.ff=only.
+		 */
+		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
+			opt_ff = "--ff";
+	}
 
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase(&rebase_unspecified);
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index d1f621725ad..0c0dfecd2a3 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -260,11 +260,11 @@ test_expect_success '--ff-only takes precedence over pull.rebase=false' '
 	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
 '
 
-test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
+test_expect_success '--no-rebase takes precedence over pull.ff=only' '
 	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
 '
 
-test_expect_failure '--rebase takes precedence over pull.ff=only' '
+test_expect_success '--rebase takes precedence over pull.ff=only' '
 	test_does_rebase -c pull.ff=only pull --rebase
 '
 
-- 
gitgitgadget

