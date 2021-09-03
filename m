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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B49C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776756069E
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350324AbhICR4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350227AbhICRz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723BC0613C1
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:54:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so9271042wrv.13
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ghDOfc+l5cb6zokCoPGjCg9YMZZQ5SOz8paZkCCKrlY=;
        b=Qr5hKUVAQbd7rryo6nbcJq3ImM5udbERcfPt3dnXnbPD+uuHjLAItUNPk/+yGNBOo8
         aprIZNPgcAWnH8qJfo9pCu9XmhsuwvUjcSqOM28gU/Jg6P2mVJAp+LILM8li+MDrxip9
         4iGjqTDYZjINIb331YRIXgsL/tGrtN2F4GExYAvebMMhpJsXQzcIqNjyL+a/3P7MlXil
         V2w4cOLTU+jq2ixUasUqYpZSJijHRcys9bKhvsGDhCmj2C4DvBPNpanfxYqrHVjut9Ti
         eu+so6NpTw6OIvJr5W0RH+gVRhLFZCRKolbsen9+A2+GoAnJOXIx42QBXnNptl4zWfzH
         gEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ghDOfc+l5cb6zokCoPGjCg9YMZZQ5SOz8paZkCCKrlY=;
        b=mVLNsHHtWWf6Hs3Es1VijrNU6CFyQUj2oxzdIkm36m4+vS/B3NybMU7GAJBD3Nxnsy
         8vEOpUqwGP71NwNSW/Q+esVawfmg6g0QW1TvszYe3DveQs04uAOI2wIFPL4flYKtiN0b
         ptpbkk12+dcvPFQdbXmwdnZt+mD/CB7TBT/+rgzZ+UopteYurCgzlcDZrEuIIOGvHYXH
         czKNjNMSmQ4OPGZwlBSOh4BetyJ172T0M5tKdsXBlRdVbrv+5xS+WCnWMwRpjlbPnp94
         Ftxc0/P5TMfzCkm5n74KQ8tY3MLwxtOmUwXrQ2KhdFHEeU8nKTMcn/WyyCbixTt3GzYI
         ZQMw==
X-Gm-Message-State: AOAM530ice6cAgiQ8qSclBA0WWTNMtNGNPUAvBRoo+mGI1xqwwRs3B4P
        BIUs+I3o+mnfepyffmOJOxdFt9kFQag=
X-Google-Smtp-Source: ABdhPJwHQ+d1objq8BKiQ+HziGwnQ4LaSGH99vARPnF45KgK3vhbQXg6V9qdUfmaFsh9ybis5leqEg==
X-Received: by 2002:adf:d1c3:: with SMTP id b3mr313794wrd.286.1630691694924;
        Fri, 03 Sep 2021 10:54:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm44291wmj.28.2021.09.03.10.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:54 -0700 (PDT)
Message-Id: <fb7c931ddb3a248542bc6a03d09189e937315d0c.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:39 +0000
Subject: [PATCH v2 07/15] scalar: implement 'scalar list'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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
 contrib/scalar/scalar.txt | 12 +++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d114c038b64..7f5436399da 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -257,6 +257,16 @@ static int unregister_dir(void)
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
@@ -343,6 +353,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index d9a79984492..f2528557a0c 100644
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
+	To see which repositories are currently registered by the service, run
+	`scalar list`. This subcommand does not need to be run inside a Scalar
+	enlistment.
+
 Register
 ~~~~~~~~
 
-- 
gitgitgadget

