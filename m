Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552FDC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406CE60F26
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhINOpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhINOoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:44:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45967C0613B1
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y132so9480269wmc.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oKygtjLAStTyInzHGfikqfjJckUMFyUKn7JkaG2HLdo=;
        b=JXs/kxnkULbwvMyQh2CreHsU/uSKh+WbUQFEbg8B7jBOFlEfA9UrpX6ace4zcWz8J8
         3g5Pq6DaWQHrOfym8PLWnhuWRjwe7FReU+B4Hy6hN1ATu5Z8T44UfHoiOVNKcBkWo11X
         2HxNoOPFynmFmazjZVbp/yHjBTz1XbV3yA5bXJ7c+wcCubyCJRa9RBChJPyGL5ywSoeC
         hrhIpDEIoCn1ytGFkFdTezc2eVvhXlEYsGCiYcyezH8TgLQDRmKyjL5J4K5YFgFTWsWk
         gPWx63m0LeIKqU3DirG/lZt3ts+dXyMN7nV4wP2e2bVILLzA8iSLL6oSdLqtEwuKb6nY
         kNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oKygtjLAStTyInzHGfikqfjJckUMFyUKn7JkaG2HLdo=;
        b=n+nbFiWxra3QNJPfZFksry07dWB46hnYt7AoH+OwvSaZxfHaCMUcXxa6LX/KpmMJye
         3/LumHiLPf39xl8ilT/eThTeEIoM3HyD5Q+TWhRiPXh26/bo3ISQoBTUvMcgv1Do7faw
         uD4SAObjvLY1zXMUe5tgOtqOweVzpqMVIyV9nR1wLyikCfOCzsVUVihJXKFPOasDxfll
         vEmmLsO80gIorORPkr8u5eshvFGniND/rJoo2qRaGiHFMz7FzAnhvblUILkWo2H53lXu
         fbTM3uMiQ3N+hVjp2YFIeXTAuWEoVq6rbdafrt64mn13mR0FOv3v9X1X0m2BVHBNBXPX
         ZtVg==
X-Gm-Message-State: AOAM530c6+FTuxZGXzRFWTvhUqHgFwGbGqhilob+PHj3h2enw0UmiqOC
        hsEfolkMDbU6LP6tlUU+yJir2l4dlDo=
X-Google-Smtp-Source: ABdhPJwOkSz9Qfrahmo9kY4dsy67PgUL1WJbHGqyVK6SoW43G8m20txy6Spylg6L2aoHfQ0BHtz1RQ==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr2598574wmf.58.1631630362944;
        Tue, 14 Sep 2021 07:39:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm1284930wmc.24.2021.09.14.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:22 -0700 (PDT)
Message-Id: <90ef9b826b297e54a2bc56b99a9073387b0c6b1c.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:08 +0000
Subject: [PATCH v4 07/15] scalar: implement 'scalar list'
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

