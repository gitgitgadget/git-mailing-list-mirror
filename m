Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBEC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFE260F3A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbhH3Vfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbhH3Vfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8ADC0613D9
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i6so24447207wrv.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JdUylLTULQwmtRz5tN6lP1NdH/qH6Wi9B+3KLSyQ6QQ=;
        b=Hs3s3YXuF2hThtR0PF+Ii1Sa7a414JzyZpbEj7DAfSwNBKXP0Ej5xALrAYtAObuWJf
         UZjMe8bH57kborUj8xtUsPs3N5zdOIIeRxd5ifQsINtWRnfqp31PWoSfSjPtEGcvtd5+
         //Vf0ZWlAE0svfFk7xKsAlKEOc+Y31YsH/CdU9k5NbZTRnO5vLTxrqzkMmejBe2RYbPS
         6aL7TbSgXHBvhbBilH8wjwsryvZb7SBvtsb55nvWNuxrtMS3R4PjoktCJQhlGGf4rSZl
         Lt9ZJb3YQ8DDjjIYZUtAJVH/q0ghZezf/VnY7fSEDld7+9mcvHqNF2GTlHasjr4JOGHw
         nzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JdUylLTULQwmtRz5tN6lP1NdH/qH6Wi9B+3KLSyQ6QQ=;
        b=LNMcIjBPBNPU+1a9/Hx2j4TdMo6r66VywNrETq+TLgw3tb+VL6kxojqb7wGW/Xk+Of
         VwsgEUl9+vcWmlzzgnOfHAWitUyyunp6W5/iwH9WQD0i2Mrc9bfg0ziYlZZQZBDWJiki
         qQyvzzz3pvONycGBaTnHrH3OG+II+fBc7UtluE2WIkJmb145zCldG2Z6cJKqiws1vdVF
         w8scgw7rn3oirqJjUzNRhJibCIH78tx+Y7K1ZjCjS5lMf6b+Z7o/Gq6Cpc95GlIjDzk/
         zj8CRWK3MCP69ryQkx+6ABOMx5QIOGYUqCgQaPlqA6LAZ8H1LnxvxmAKrFJw1Cydz986
         Z0iA==
X-Gm-Message-State: AOAM53300uzlXOgEWX06N9czKEnGDcNbexhOGAFT2GYKQvkkHnpbXFqe
        cBB7vQmhgiGHxoTMjIztvAKEilGEoG0=
X-Google-Smtp-Source: ABdhPJykhQBuZ30N1Lop+QsoAT1cu90gNxVjsdU7aqaI8sbo8cGYWCuWnmSbX271o1sIrPEt/hbbRQ==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr27672861wrn.365.1630359295256;
        Mon, 30 Aug 2021 14:34:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm16699563wrs.39.2021.08.30.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:54 -0700 (PDT)
Message-Id: <c272ff4069d5906ad8922f621015578ff7a93813.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:42 +0000
Subject: [PATCH 07/15] scalar: implement 'scalar list'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The produced list simply consists of those repositories registered under
the multi-valued `scalar.repo` config setting in the user's Git config.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 11 +++++++++++
 contrib/scalar/scalar.txt | 12 +++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 14e688f44a9..91ceb97e552 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -258,6 +258,16 @@ static int unregister_dir(void)
 	return res;
 }
 
+static int cmd_list(int argc, const char **argv)
+{
+	if (argc != 1)
+		die(_("`scalar list` does not take arguments"));
+
+	if (run_git("config", "--global", "--get-all", "scalar.repo", NULL) < 0)
+		return -1;
+	return 0;
+}
+
 static int cmd_register(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -344,6 +354,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index cddaa969403..e1f629fddad 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,6 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
+scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 
@@ -28,11 +29,20 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand.
+depending on the subcommand. With the exception of `list`, all subcommands
+expect to be run in an enlistment.
 
 COMMANDS
 --------
 
+List
+~~~~
+
+list::
+    To see which repositories are currently registered by the service, run
+    `scalar list`. This subcommand does not need to be run inside a Scalar
+    enlistment.
+
 Register
 ~~~~~~~~
 
-- 
gitgitgadget

