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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A881AC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBD260EB7
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350322AbhICR4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350308AbhICRz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB3BC061760
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:54:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b10so9346594wru.0
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sXT7padYA8BJgSN9/mwIvE4EZ8jBX8O1zyjEaWNgsDM=;
        b=Hp3BkmenDvbxOmmp74tujSCXUuLkkyESKq0hx1PjbzcGm8YnZ4YbS9mBoeEz4jDrwB
         ZCqRQVPYZl/ypLAPOBRkFj7QMPAbyFtjObzYftWLcxPpm6p3Uf6bw0Y1gZirnJ07fBuX
         diVcqWXE3wR2hUm1m+wh6cEew+rJvIETRTLEzSrkQk4yXt9MF7ZHfjFjFhVlBaE8lgpB
         sFcNZBkUqS5t37ubsWTSiYkoCn49mcmA1ZogNUKO7pSQqdusf+1+g69J9QCah1X1B+KC
         qp3YZeOJt8XRkYY2j2MM5fgLUfPWl7iSnuKrr2x3vTaSqAszf+09+csjS6Qz+5Dl688E
         sOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sXT7padYA8BJgSN9/mwIvE4EZ8jBX8O1zyjEaWNgsDM=;
        b=howFDLQQ+c+Hh7WZvbsw8iiUtZ6AG0IEHQ9u1o91LwMwMo40qr8FzHdCUBTWz3EzsE
         QeV1iTrH40pGBDxKs753VVFqOddV+AwKY9qj+oRGkiSWjdoa19/Kb55Ptj4LhZp6wz4/
         ZKcCA27b67zvYGvWKvY1yK6YBcT1GWqzdXW8M6y5/jpolSz8HXfqarUfkSnzkpBD6IZr
         pkvE66rNH1wF0q0Qoprl0bQMiUABu3vlu73LHK+jKfzurO/wT82Y41FlkXmQZN3u/3ZB
         s08zaFQiE28BFof21mpLLwaNz6GOhj7/O7SdTLiiSCQZ/4wtYRGNN5jVTj+vcWYp2z1M
         Rhag==
X-Gm-Message-State: AOAM533EFAr6CWgztYxz63atmh4R+Km7L1qW2hgH+Zda2c+OcNnNQjNT
        s0SHDXztbi+8mybjex+2pPaxQl1ftDM=
X-Google-Smtp-Source: ABdhPJz3eTY3Kpbi2gtIMyfq1VlNcbv8mxWwNHl/pspyrCAVU4YB4w44y5P/Gjs1g0FJYjyRWbCU4A==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr327684wrw.134.1630691698040;
        Fri, 03 Sep 2021 10:54:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm45253wmi.24.2021.09.03.10.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:57 -0700 (PDT)
Message-Id: <79e9f5d203a85f9a4cf6321d10c5d04b0dbdf8f8.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:44 +0000
Subject: [PATCH v2 12/15] scalar: teach 'reconfigure' to optionally handle all
 registered enlistments
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
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After a Scalar upgrade, it can come in really handy if there is an easy
way to reconfigure all Scalar enlistments. This new option offers this
functionality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 61 ++++++++++++++++++++++++++++++--
 contrib/scalar/scalar.txt        | 10 ++++--
 contrib/scalar/t/t9099-scalar.sh |  3 ++
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index bfbf58f7a91..7e98a1d6b06 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -494,22 +494,77 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int get_scalar_repos(const char *key, const char *value, void *data)
+{
+	struct string_list *list = data;
+
+	if (!strcmp(key, "scalar.repo"))
+		string_list_append(list, value);
+
+	return 0;
+}
+
 static int cmd_reconfigure(int argc, const char **argv)
 {
+	int all = 0;
 	struct option options[] = {
+		OPT_BOOL('a', "all", &all,
+			 N_("reconfigure all registered enlistments")),
 		OPT_END(),
 	};
 	const char * const usage[] = {
-		N_("scalar reconfigure [<enlistment>]"),
+		N_("scalar reconfigure [--all | <enlistment>]"),
 		NULL
 	};
+	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
+	int i, res = 0;
+	struct repository r = { NULL };
+	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
-	setup_enlistment_directory(argc, argv, usage, options, NULL);
+	if (!all) {
+		setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+		return set_recommended_config(1);
+	}
+
+	if (argc > 0)
+		usage_msg_opt(_("--all or <enlistment>, but not both"),
+			      usage, options);
+
+	git_config(get_scalar_repos, &scalar_repos);
 
-	return set_recommended_config(1);
+	for (i = 0; i < scalar_repos.nr; i++) {
+		const char *dir = scalar_repos.items[i].string;
+
+		strbuf_reset(&commondir);
+		strbuf_reset(&gitdir);
+
+		if (chdir(dir) < 0) {
+			warning_errno(_("could not switch to '%s'"), dir);
+			res = -1;
+		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
+			warning_errno(_("git repository gone in '%s'"), dir);
+			res = -1;
+		} else {
+			git_config_clear();
+
+			the_repository = &r;
+			r.commondir = commondir.buf;
+			r.gitdir = gitdir.buf;
+
+			if (set_recommended_config(1) < 0)
+				res = -1;
+		}
+	}
+
+	string_list_clear(&scalar_repos, 1);
+	strbuf_release(&commondir);
+	strbuf_release(&gitdir);
+
+	return res;
 }
 
 static int cmd_run(int argc, const char **argv)
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index df6e961ca37..8637e207860 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -13,7 +13,7 @@ scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
-scalar reconfigure <enlistment>
+scalar reconfigure [ --all | <enlistment> ]
 
 DESCRIPTION
 -----------
@@ -32,8 +32,8 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand. With the exception of `clone` and `list`, all
-subcommands expect to be run in an enlistment.
+depending on the subcommand. With the exception of `clone`, `list` and
+`reconfigure --all`, all subcommands expect to be run in an enlistment.
 
 COMMANDS
 --------
@@ -125,6 +125,10 @@ After a Scalar upgrade, or when the configuration of a Scalar enlistment
 was somehow corrupted or changed by mistake, this subcommand allows to
 reconfigure the enlistment.
 
+With the `--all` option, all enlistments currently registered with Scalar
+will be reconfigured. This option is meant to to be run every time after
+Scalar is upgraded.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index e6d74a06ca0..5fe7fabd0e5 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -70,6 +70,9 @@ test_expect_success 'scalar reconfigure' '
 	scalar register one &&
 	git -C one/src config core.preloadIndex false &&
 	scalar reconfigure one &&
+	test true = "$(git -C one/src config core.preloadIndex)" &&
+	git -C one/src config core.preloadIndex false &&
+	scalar reconfigure -a &&
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
-- 
gitgitgadget

