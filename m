Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DCAC07E9C
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134DE613C8
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhGIRqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 13:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhGIRqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 13:46:00 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E7C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 10:43:15 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a189so2881503oii.2
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gFgIqu08F+LKAe1l4QYBQIbVPVD5Jp5uqGBA8fjr0o=;
        b=ndhow3xGXvhJcC2cJJnzhl94vwm39l++ZFz1u+2sdIi2TYYwJwmFXQw286AwiUSHRF
         qebegDYwp4Ka7Osj1cj4T+SXZoHzsKcKuWbyLJQtd3DNOBsImn2DjM/1+VL/PUEPAAfM
         5vqzDxK/WkMIAzC5uNw51EnAKWtwcLauoixkH//2RsOje+/oVia/18opO1R13avGT59l
         /qleKldmmqvTAprw6hRXTa1m48NDTzBTnmjv0PzqNT3tcIBMHnWoxvzYD7mqabUNTq8T
         Fs6vbeMNXtGYiHirtsGBlkoD+lePB48WD1Kr2GtMycSpHZRYUwX34aDA7VsdmUZN5uwY
         fHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gFgIqu08F+LKAe1l4QYBQIbVPVD5Jp5uqGBA8fjr0o=;
        b=YbXH+MbzypwKqJS2m7v3BY2H+HcI7SIMf0EbDXgT2ECMmXWynG2iUUr/axclIWOYmO
         HKgKvXYzlCqilZkPaww1Pi0s+W8xNL02LZvdTHg5Okt4ES89u+a9qM32QPftfwVDY7RH
         zzASDWFpiA8z7q5Bb+PlAp9h+sj2plzzTuuU9YL48R9YrlS2bC8FIZ+LcVlEWcdBuOhq
         aMJwfAqopcONz2jatbjjmDghHT+O5gEMj3dLMXbCLcBc+2LbO+SrhHGbBanzve7dWnCR
         YRwb5hNme1beH7MB3njMGM4STQOqNiKsW1/LAGrpUYYQB9zLse6OzdUIFkI9AENFQMdJ
         qKqQ==
X-Gm-Message-State: AOAM5316p4MjnBMgEM8i/aZdBzfohl5xZFd5bubvTc757SbbbNuSD+Gb
        QWD98ECnXbOdiu8qQa1J3rpcNMWAiZgLxQ==
X-Google-Smtp-Source: ABdhPJyYUiw/gPyoDW0+qRo9iKCrwsCyFNpnOmKDV6FwOhnJlkTPakjivvXvAjuTgu4ECPvRHwfJHA==
X-Received: by 2002:aca:fd81:: with SMTP id b123mr17728155oii.39.1625852594713;
        Fri, 09 Jul 2021 10:43:14 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id r18sm1097441ooe.23.2021.07.09.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:43:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Martin <git@mfriebe.de>, Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] switch: rename --create to --new
Date:   Fri,  9 Jul 2021 12:43:10 -0500
Message-Id: <20210709174310.94209-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-c is used by `git branch` to copy a branch, it would be nice to copy
the same options for consistency.

Fortunately there's a pretty good alternative to create a new branch:
--new.

-c and --create are still supported, but deprecated.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-switch.txt |  8 ++++++--
 builtin/checkout.c           |  2 ++
 t/t2060-switch.sh            | 13 +++++++++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd505..67f8add9a7 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -56,8 +56,8 @@ As a special case, you may use `A...B` as a shortcut for the merge
 base of `A` and `B` if there is exactly one merge base. You can leave
 out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
--c <new-branch>::
---create <new-branch>::
+-n <new-branch>::
+--new <new-branch>::
 	Create a new branch named `<new-branch>` starting at
 	`<start-point>` before switching to the branch. This is a
 	convenient shortcut for:
@@ -67,6 +67,10 @@ $ git branch <new-branch>
 $ git switch <new-branch>
 ------------
 
+-c <new-branch>::
+--create <new-branch>::
+Deprecated alias for --new.
+
 -C <new-branch>::
 --force-create <new-branch>::
 	Similar to `--create` except that if `<new-branch>` already
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f4cd7747d3..43364b5b00 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1833,6 +1833,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	struct checkout_opts opts;
 	struct option *options = NULL;
 	struct option switch_options[] = {
+		OPT_STRING('n', "new", &opts.new_branch, N_("branch"),
+			   N_("create and switch to a new branch")),
 		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
 			   N_("create and switch to a new branch")),
 		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 9bc6a3aa5c..e6023c70f7 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -41,17 +41,26 @@ test_expect_success 'switch and detach current branch' '
 
 test_expect_success 'switch and create branch' '
 	test_when_finished git switch main &&
-	git switch -c temp main^ &&
+	git switch -n temp main^ &&
 	test_cmp_rev main^ refs/heads/temp &&
 	echo refs/heads/temp >expected-branch &&
 	git symbolic-ref HEAD >actual-branch &&
 	test_cmp expected-branch actual-branch
 '
 
+test_expect_success 'switch and create branch (deprecated)' '
+	test_when_finished git switch main &&
+	git switch -c temp-d main^ &&
+	test_cmp_rev main^ refs/heads/temp-d &&
+	echo refs/heads/temp-d >expected-branch &&
+	git symbolic-ref HEAD >actual-branch &&
+	test_cmp expected-branch actual-branch
+'
+
 test_expect_success 'force create branch from HEAD' '
 	test_when_finished git switch main &&
 	git switch --detach main &&
-	test_must_fail git switch -c temp &&
+	test_must_fail git switch -n temp &&
 	git switch -C temp &&
 	test_cmp_rev main refs/heads/temp &&
 	echo refs/heads/temp >expected-branch &&
-- 
2.32.0.36.g70aac2b1aa

