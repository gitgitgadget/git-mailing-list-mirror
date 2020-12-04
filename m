Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCA4C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B1C22583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgLDGRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGRx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:53 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5277C08E860
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:44 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l200so5012704oig.9
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBT0EzIpt85yh3IsT1vov9e0v0rvq4h5XCzypgwxYFU=;
        b=aBJBlnU6ma0FizDe5mc7C6P+r5kp68yn3LVGa189H1RH3YP7NcivyzwHpB7CypTaS6
         5+P+gap/aPt8qR/8lHNoMIGSUdP0tbNk46b+xQaXh1pGVuEN6Aw7J2rHYwt3cL5TAfvT
         de2sZJ2WaKuPhFfKIEwgzLX2UpBc/o4MvyqyCjTaeXyjSpc1/6p+fFlg87zCYyvnlzmX
         H9qJoEXxfqzBmio4E9swy+bwYcA6vflcALGk3eDyHLp2GX2NNpcY2pa3y2So5H7McbFq
         woF1oEBGMQXBEUOQhscrVN2B2PirSLr+GDvlmJeMfUVApas+KWeyrrkjCzZv3PaG1vCO
         YHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBT0EzIpt85yh3IsT1vov9e0v0rvq4h5XCzypgwxYFU=;
        b=FUWGE/M41hBWcFx8SnBmeCB9XaBUhROOZdeHZzRpsqe6mgOfti7oW/ZmvcBdfGEWcw
         VcMwSJ2xErOQD/m0WpWtIR5mG9ovd5h25xihbtZd5tUn1eq2p867STtTGQ8zalcgiAHz
         bO9I/J1xfeKvkoyODmzYP6wtUmlZTT3i3Dc6m07W4ViocEoeCPz5A3sbZIoITAVeHMma
         y9pQLwewNwmMfLbWf+5kBzERnbT1vLFysZrVgkicuLRctZtlb93ZEC71CSjLUvVQwvB7
         ubi4pzUBxyVTehJrKEVsPS3qxc5KyqxEoVuBX7C95Ch17KWqjejvBvd/w0dYNALn0TpE
         VpNQ==
X-Gm-Message-State: AOAM5323jTbxJT/pQ3tODTEgfRqsHnJ/7Ou1KhXLxhToc+dtPH+tS5en
        m1fwXAvlbFSrulA3HqoN9HEBb3j4hsasfA==
X-Google-Smtp-Source: ABdhPJzS+OrdOTjYo9o8xDwx/mQRlNPltzDEpPFGoYdhzCvqxg+SXqKRyJFpVqCKbJQEHWHc5MB2BA==
X-Received: by 2002:aca:cf0a:: with SMTP id f10mr2035053oig.11.1607062603977;
        Thu, 03 Dec 2020 22:16:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k1sm426414ood.4.2020.12.03.22.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:43 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/14] pull: add proper error with --ff-only
Date:   Fri,  4 Dec 2020 00:16:19 -0600
Message-Id: <20201204061623.1170745-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current error is not user-friendly:

  fatal: not possible to fast-forward, aborting.

We want something that actually explains what is going on:

  The pull was not fast-forward, please either merge or rebase.
  If unsure, run "git pull --merge".

The user can get rid of the warning by doing either --merge or
--rebase.

Except: doing "git pull --merge" is not actually enough; we would return
to the previous behavior: "fatal: not possible to fast-forward, aborting."

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c  | 34 ++++++++++++++++-----------
 t/t5520-pull.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 6ea95c9fc9..f54ff36b57 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1015,20 +1015,26 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
-		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-			"discouraged; you need to specify if you want a merge, or a rebase.\n"
-			"You can squelch this message by running one of the following commands:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories.\n"
-			"If unsure, run \"git pull --merge\".\n"
-			"Read \"git pull --help\" for more information."
-			));
+	if (!can_ff && default_mode) {
+		if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
+			die(_("The pull was not fast-forward, please either merge or rebase.\n"
+				"If unsure, run \"git pull --merge\"."));
+		}
+		if (opt_verbosity >= 0 && !opt_ff) {
+			advise(_("Pulling without specifying how to reconcile divergent branches is\n"
+				"discouraged; you need to specify if you want a merge, or a rebase.\n"
+				"You can squelch this message by running one of the following commands:\n"
+				"\n"
+				"  git config pull.rebase false  # merge (the default strategy)\n"
+				"  git config pull.rebase true   # rebase\n"
+				"  git config pull.ff only       # fast-forward only\n"
+				"\n"
+				"You can replace \"git config\" with \"git config --global\" to set a default\n"
+				"preference for all repositories.\n"
+				"If unsure, run \"git pull --merge\".\n"
+				"Read \"git pull --help\" for more information."
+				));
+		}
 	}
 
 	if (opt_rebase) {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..fdd1f79b06 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -819,4 +819,66 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+test_expect_success 'git pull fast-forward (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.ff only &&
+	git checkout -b other master &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull
+'
+
+test_expect_success 'git pull non-fast-forward (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.ff only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
+test_expect_failure 'git pull non-fast-forward with merge (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.ff only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --no-rebase
+'
+
+test_expect_success 'git pull non-fast-forward with rebase (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.ff only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --rebase
+'
+
+test_expect_success 'git pull non-fast-forward error message' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.ff only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull 2> error &&
+	cat error &&
+	grep -q "The pull was not fast-forward" error
+'
+
 test_done
-- 
2.29.2

