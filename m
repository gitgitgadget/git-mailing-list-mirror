Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE1C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A0A207D3
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2cFr0HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFEJKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgFEJKs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 05:10:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A807C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 02:10:48 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k35so6882652qva.18
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sv3+mZK5K9MzSBFJq3ibkL4yGsHSI/oJ3iSRZetod7k=;
        b=R2cFr0HBFPsBtqXp6m78RTrLr83LXFQ3Sf+a3M4tKC3cmKD35+htWdNS5REf/eiJW4
         2WpV1GcUyGe3wzb2hMrtNy1SD7XbKsvXvjyTHZxHdHxfCKQLUmRy+ThUWyd0rajUNU/X
         A91I0RYQEMoyYDkXycT4q6sKuonpi7oQQyqbjmc+ZVftm5gPLUfjbs7dFnzEez9tcWLq
         mOgi0GNbL/bmqAGc9P73vOC7+TSS4wmb8GR59nRaj9bdAcmNAQ7DyRERQ2SMhf5W3UBx
         dSwZYzOtdW6IrzdGCPAcWosgOz0hgJE51I0PAZWeVVdUzs1nKTQYawfTFa7cEd/hP5oH
         p+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sv3+mZK5K9MzSBFJq3ibkL4yGsHSI/oJ3iSRZetod7k=;
        b=qI6LlhfuEz8eyCzXAQoCy+Nm3wDzJf6asn0u2OYQYj/e2Bi1SUG6ZKoSa7f428/emL
         R3gsUEOyoOuLh4AN1yd7YKswc1di1sikeFOwSteFgpRoHmr8vX1ARvV5E8Og+C2E1JMX
         y6vkeEtqpp1RII3xRwgkyfMMSRUC8GfRxuZk3XNXSxcvXLyBfXeK6YcEHCISLbUkFFJQ
         1RBezj9XP+SoQgK8fvgiGABYcRXRnpG5kp8oLvQe3AIylLOLV4diG8OS4nHl9YnosbvE
         Q5Fspj4PHruYIwG4RT+9nZtGkFxIwzsm6Dt90GM+3mH7RQ4pLtFbPLcOYeh1C14S10Gz
         pzYg==
X-Gm-Message-State: AOAM531F/dDOJ7Qba4A8SFxT2H2eT6jPTZ10+LHI17wEvwAjC3hbVWC6
        ObEBBdoApFPT6F1UFxTuklpTscsXXVKePuAPzgf6Mb0xiI7m3VHBpQRDiukQGz5KHevfyCi3X3M
        gTm5EmgvxgjMnnwFVIkmoyDXMMcyPnnbLX4XqvQwLGRQ9iNc32V58qY4Mvv5T
X-Google-Smtp-Source: ABdhPJw8+EybdIgP0A296sh+zLopIxDrr2J6vGv2efrhTZ2vrsMBtPlHGXXvfE1KEjepzeFXTCMI7T6h5myd
X-Received: by 2002:a0c:e952:: with SMTP id n18mr8719573qvo.147.1591348247247;
 Fri, 05 Jun 2020 02:10:47 -0700 (PDT)
Date:   Fri,  5 Jun 2020 02:10:03 -0700
In-Reply-To: <20200605091004.208668-1-delphij@google.com>
Message-Id: <20200605091004.208668-4-delphij@google.com>
Mime-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com> <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com> <20200529000432.146618-1-delphij@google.com>
 <20200529010119.GE114915@google.com> <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
 <20200605091004.208668-1-delphij@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v6 3/4] sparse-checkout: upgrade repository to version 1 when
 enabling extension
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'extensions' configuration variable gets special meaning in the new
repository version, so when enabling the extension we should upgrade the
repository to version 1.

Signed-off-by: Xin Li <delphij@google.com>
---
 builtin/sparse-checkout.c  | 2 ++
 t/t2404-worktree-config.sh | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 95d0882417..95669815d4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -249,6 +249,8 @@ static int set_config(enum sparse_checkout_mode mode)
 {
 	const char *config_path;
 
+	if (upgrade_repository_format(1) < 0)
+		die(_("unable to upgrade repository format to enable worktreeConfig"));
 	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
 		error(_("failed to set extensions.worktreeConfig setting"));
 		return 1;
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 286121d8de..9536d10919 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -23,8 +23,10 @@ test_expect_success 'config --worktree without extension' '
 '
 
 test_expect_success 'enable worktreeConfig extension' '
+	git config core.repositoryformatversion 1 &&
 	git config extensions.worktreeConfig true &&
-	test_cmp_config true extensions.worktreeConfig
+	test_cmp_config true extensions.worktreeConfig &&
+	test_cmp_config 1 core.repositoryformatversion
 '
 
 test_expect_success 'config is shared as before' '
-- 
2.27.0.278.ge193c7cf3a9-goog

