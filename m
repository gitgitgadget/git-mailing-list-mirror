Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656A9C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhKSXHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhKSXG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D40C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n29so20578812wra.11
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=97iVUlZN97wuaA47a0t2uiGKid4HTvg3w7rjoSoQOX8=;
        b=X3+MapMnC0I8aXBynZG3+p5DQVs5xp6AlbtehBByJT7RkVLgkWk23idQuZVIpfwYpz
         5VLBD4TmkDi5n8AdqrKqEFfJn3snhuenv1AYtri60QKv8LbasooLN0tiGyraBUf4PvUD
         kGaZ6WAtvqmDnoLnAIXpe1cCLoDuhVKWBXR9+dnLIT5fCrgaQ68OQhMnqIBiWSGbCUra
         QvbWYB42KwTpzwcjY14f2lUmtkub7RAJTD0vvH5WGmadoo26cmlsjUhWMwuVP3SbeeRQ
         CW8wWdlURuXzurF+7hMySFC3z5vbsXWisUMPopWnj6SROISJv93V9AmhiuP2ph3Hkxr1
         eQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=97iVUlZN97wuaA47a0t2uiGKid4HTvg3w7rjoSoQOX8=;
        b=LCd4jJqdOmrwn/PDxMYmE3/+3jlKleuwd4SkGstq1ebs7UOOqgtD1Rih5pCW0f2K7y
         RwOTzCIRxbqIehYgmfvZXpyBtGUQmM3rCNKEIahFy0aeA+bwf0l4nlYoAIoJBkf+K5JL
         uiB3T0xMNDiRUTfnSceVHfm8d1Cv+aH4ex3mhRoNlliOBO1HDXwAHZWMFpuRfqtn6RrN
         BFOjszNlinCA3d7RjPSfZ9W15dwJusueXyeRaee220kcEwL2g1kzEqk7RtNTtlgomtQ5
         aALV1iRyhDCDNjFctWKt2hWudjMqE4707HkrsP6Zgc88iaJHj2e8mCyI9aAby0cd33XL
         L3wg==
X-Gm-Message-State: AOAM531sgcWbzBqhUL9VTv3mv7cuRluHWGa7PUhPf3H/EveSEcOkwZqV
        zNqFwjPE+A4l1agVXyvn/zGWW2nDPi4=
X-Google-Smtp-Source: ABdhPJyAAQA/NeIrWnAnCHDYNVG+fwoI7/A+0//WeATIczaGo67mmLoFtWFMTWN0S4JywvRzWfbUbw==
X-Received: by 2002:adf:cd89:: with SMTP id q9mr11907182wrj.205.1637363032539;
        Fri, 19 Nov 2021 15:03:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k27sm16509088wms.41.2021.11.19.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:52 -0800 (PST)
Message-Id: <fd2680bc945ca37467eeebc93a05dfaef6964ce9.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:37 +0000
Subject: [PATCH v8 10/17] scalar: implement 'scalar list'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
 contrib/scalar/scalar.txt | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 097d3bd478b..4feacd8d62b 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -251,6 +251,16 @@ static int unregister_dir(void)
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
@@ -337,6 +347,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index d9a79984492..f93e3d00efd 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,6 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
+scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 
@@ -28,11 +29,19 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
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
+	List enlistments that are currently registered by Scalar. This
+	subcommand does not need to be run inside an enlistment.
+
 Register
 ~~~~~~~~
 
-- 
gitgitgadget

