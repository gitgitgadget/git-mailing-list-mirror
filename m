Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A3C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889D560FC0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhH3Vfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbhH3Vft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A49C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso424147wmg.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JZNsOzjEReLwYD84tOxt2XeAkNwMokOMqH9+CKulAlU=;
        b=GC0Npah0uvJK3I0btDdit4m1B81SU8tA/Fl2am0FkBnVIrsyOGsQ5ZP/QK0zF2m5On
         +m6E76sCiRiFKHFpd6lukl+d8YcOio8rXZD6ZU2E0ZEHZD1JEje5K+tbOOvUZU4dKX26
         YkUa+FusV5BouNLVp0q6GMvKMBYyf53vtLOo4OEJmpq78YldfXkk1OJPQu2qXTXvq7y4
         FlsBShuquLA6sX8sSLRw9NbbuK8q9K5qn0twPSmJh+jPoLwFXnUhcw6zlRT8cMToC0y+
         TsMQHpcYR2iCKjI+30D46iS7upkWpxDxUuO+Hv73X2wN1ua87/cBpDfGyBKPuzZFv561
         cbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JZNsOzjEReLwYD84tOxt2XeAkNwMokOMqH9+CKulAlU=;
        b=ek/VM4wGirTbOW9hWRBkc8FPHBZJhN2u+7eJ4vLAlz84oNF4W0QE0jG5tiaAEyNwRo
         LMmCGyJ7uIWD3TQ0pGvIzZ/6FNTFmil1LMUZ9y3H9XGUEkNt6S6GB0dKi2OlzSGzZCZy
         jWKCXwpnVud1tW5EiHPfEmc17U1AOllK7yrWAhhZr0Hr7xaB3nvggqKNLaPhODxlTg0o
         rx5w7zZZM9m22lW2pgBfRPe3+lNaKFcIT5Gjz7VDH7a1pBnBH9qBMk/M2sNfVIJGytdm
         wNmXBUsfj6Zhp7nlG1RV0QWO9N5jYDyIlkSKbh+jjFMl7hDx9rWXz4Hbro2qaK4NsJ2R
         AtTA==
X-Gm-Message-State: AOAM533Fsun77miKezxmDZwvWJ4xtun9OY2EPp9oysU6+OI2UPm0HQ7E
        k91L/EKxxkYoT3T9zr1Da55eqo+dzkg=
X-Google-Smtp-Source: ABdhPJz2Lxmg5hUpRZA0sO5tV1nSsssP6ue0/O3x9gQL2ffAQlclsXhOl3eDW9zSsaDiUXBxyb297w==
X-Received: by 2002:a1c:1b49:: with SMTP id b70mr973991wmb.17.1630359294168;
        Mon, 30 Aug 2021 14:34:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b62sm587293wmb.17.2021.08.30.14.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:53 -0700 (PDT)
Message-Id: <2a6ac170e6b3e55108354281ce1f1482af727570.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:40 +0000
Subject: [PATCH 05/15] scalar: 'unregister' stops background maintenance
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

Just like `scalar register` starts the scheduled background maintenance,
`scalar unregister` stops it. Note that we use `git maintenance start`
in `scalar register`, but we do not use `git maintenance stop` in
`scalar unregister`: this would stop maintenance for _all_ repositories,
not just for the one we want to unregister.

The `unregister` command also removes the corresponding entry from the
`[scalar]` section in the global Git config.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 50 ++++++++++++++++++++++++++++++++-------
 contrib/scalar/scalar.txt |  8 +++++++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7660327c27b..ef91a1af38b 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -205,12 +205,12 @@ static int set_recommended_config(void)
 	return 0;
 }
 
-static int start_maintenance(void)
+static int toggle_maintenance(int enable)
 {
-	return run_git("maintenance", "start", NULL);
+	return run_git("maintenance", enable ? "start" : "unregister", NULL);
 }
 
-static int add_enlistment(void)
+static int add_or_remove_enlistment(int add)
 {
 	int res;
 
@@ -221,24 +221,39 @@ static int add_enlistment(void)
 		      "scalar.repo", the_repository->worktree, NULL);
 
 	/*
-	 * If the setting is already there, then do nothing.
+	 * If we want to add and the setting is already there, then do nothing.
+	 * If we want to remove and the setting is not there, then do nothing.
 	 */
-	if (!res)
+	if ((add && !res) || (!add && res))
 		return 0;
 
-	return run_git("config", "--global", "--add",
+	return run_git("config", "--global", add ? "--add" : "--unset",
+		       add ? "--no-fixed-value" : "--fixed-value",
 		       "scalar.repo", the_repository->worktree, NULL);
 }
 
 static int register_dir(void)
 {
-	int res = add_enlistment();
+	int res = add_or_remove_enlistment(1);
 
 	if (!res)
 		res = set_recommended_config();
 
 	if (!res)
-		res = start_maintenance();
+		res = toggle_maintenance(1);
+
+	return res;
+}
+
+static int unregister_dir(void)
+{
+	int res = 0;
+
+	if (toggle_maintenance(0) < 0)
+		res = -1;
+
+	if (add_or_remove_enlistment(0) < 0)
+		res = -1;
 
 	return res;
 }
@@ -261,11 +276,30 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int cmd_unregister(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar unregister [<enlistment>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+	return unregister_dir();
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
 	{ "register", cmd_register },
+	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 41429db7990..cddaa969403 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 scalar register [<enlistment>]
+scalar unregister [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -41,6 +42,13 @@ register [<enlistment>]::
     then the enlistment associated with the current working directory is
     registered.
 
+Unregister
+~~~~~~~~~~
+
+unregister [<enlistment>]::
+    Remove the specified repository from the list of repositories
+    registered with Scalar and stop the scheduled background maintenance.
+
 SEE ALSO
 --------
 linkgit:git-maintenance[1].
-- 
gitgitgadget

