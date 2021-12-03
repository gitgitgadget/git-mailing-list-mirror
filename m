Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49450C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381167AbhLCNiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381067AbhLCNiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1706C06175C
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so5707848wrw.10
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AdTnGWdf70EJL03j4oz0mW5N6Ss1tIPbDoMbKCDSoeQ=;
        b=MogfFNzXhsw8yRSl4NN17wBhPX1yCdF3eZRMu5eztXTiaULHsehdQH/pmLXuTfiELk
         SKfJfSBA2ZcjAhg98m6sUwxJpCHW0DqQ6rbhauLYtl8BY2zJsI7gy28lI5xS+daqtnPl
         joQ3L3HGeL0D3QlfXbQpbaLmXrc02RsBgAWaSMIl2sqD1Y2aCLzjOxGlqzwphzYeGzDB
         v/LsmsBKAoDLzF5gY5bekFg8H98K1fWXARN8C6mFXwX6xdcxCmACmwT0K2XJ++mM0X7O
         DO3vCeEL6ONL725RzfBnFsFP/+YNuDLOuq+UfcJkXui88qgN766KIa7PHCiPtikB3PNF
         edag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AdTnGWdf70EJL03j4oz0mW5N6Ss1tIPbDoMbKCDSoeQ=;
        b=LyTpiEmXSj18zPco62KZwCXA3if1oD17vVwdod6Vo2C+l3RLR7nMjPDyyutPChIqDY
         2q/nhHEX3VyLO8oV764BSGqcRSK6Dg8PnUStdMjWjxTgT5fivIqtlldV1T2j8nKiOYgv
         hExkLTWEXnmQh39yQZ+cLH4jnEJPTUVoejvnYGwxYX7qguGiUMNbyV1EVNymeIBJvMaB
         KbvupbG5gJku1s3qDbJxsfYK5kHaKwyi6kRF84kEj6lkcF9mUQ8fdZTHNFsvo3Ialj0n
         eMaGgmIGJ9APK7pPJhF8VPAmCs1sKDKKtSHpUMeY3jNktqXWjMWP0NpLCVt4V0eVCwj+
         DRMQ==
X-Gm-Message-State: AOAM532K7u7bYD6raj2TAardMzxW7ftEglewKK3l/yWKrjkb9+2jsLPv
        a3TDbMU8LFufrySQwz8whkgKzUmyLkQ=
X-Google-Smtp-Source: ABdhPJz8T72sWyIaJobQ1oINBxXqluSLXE0y04lOcX/FDIKuHQ3UQIbbzM8SyFSDMHB9TGYbZW/c7g==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr21759251wrs.435.1638538478996;
        Fri, 03 Dec 2021 05:34:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm5920992wmq.31.2021.12.03.05.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:38 -0800 (PST)
Message-Id: <3f8b0abd7d67da77f7b8013814269549bd3ed878.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:22 +0000
Subject: [PATCH v10 08/15] scalar: implement 'scalar list'
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
index ec783e72ef3..65da885c5ac 100644
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

