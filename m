Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D128C4332F
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhKSXHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhKSXHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:07:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E3EC0613D7
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so11659815wme.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5J6efhqLKwPw37BZdtrl+rmUFh3AZSA48OGeWE6mV7E=;
        b=hbTZmqF0qfhYkv4WmCS3iv7ASIpip02etnv4PW4I00OrI/E6bg/go4i7Xesjbks4bQ
         B0rxkYfZUvSRVXs3CXVtSfrqAsVXzBl/mbv9H8/yp/jwwWjaqdih5Knv9L/qcscF/2yi
         resp/DwLWXY3Ce5s+iS5wpTaLxS2zrZApwMdiTU9N05RqLeIuT1TDh2HEcPexDmglM9m
         mnwkkPzmPe4xkXuE72zNFR8WEVAQrxsWkK7LxIaOdRxJJmJopiu75GES+303BR+7SSUp
         iLpFOVQP3gBMHn/fMY8co0X3jO7GvL+PuDb2qRG2/YjezyYyzOdm3ZcfEd06YP9Bq/zv
         mDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5J6efhqLKwPw37BZdtrl+rmUFh3AZSA48OGeWE6mV7E=;
        b=GNPbjNBF7mwo/wq0U4d114MVejSj1qKcLLErMb2yvQT9mXYGeG3yWfexOh0xTg225S
         33tBXgh0SSWnYcnDITxEhHaMtbIIC3MZUdtjnnyINZLJg7/yqC7WcIke62FnvSm2Pnhh
         DYSFvlktxfeYTcWpW3fSOkZFv9+Gavgq54PDCeoEhZeB9csr0kzvtLcn3OsIobOPpfDc
         FiItC5RKzGZ6/5p3uXzOBowLFyF9vHHgGCssZ37GtjyQVXHhb0qkuuK/Bap9YwZ6moz8
         5ybiNABCiTapn78msMA/B/HDbnrDYOFjNcKZC1HZSLO5zAF0pcjPTdhl/jA1sO7boEin
         aURQ==
X-Gm-Message-State: AOAM533QRdN1JnyvrucdwETJGJHFhdPPi0eqFdRt4FK1neH5h3RorftT
        QMCvZJQQE7CsffXdZKJn/i8upF2IFaE=
X-Google-Smtp-Source: ABdhPJziz0edIywbq3C5dbHnIQfsTeL8R3kUWH9A7yMx9hZopTiqa+es3/j0WtImNP0/flBxzwPgog==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr4623887wmg.20.1637363034679;
        Fri, 19 Nov 2021 15:03:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az4sm13688554wmb.20.2021.11.19.15.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:54 -0800 (PST)
Message-Id: <771d826bbb1fb6c8ff11b3e6bdd890833289a71e.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:40 +0000
Subject: [PATCH v8 13/17] scalar: implement the `run` command
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

Note: this subcommand is provided primarily for backwards-compatibility,
for existing Scalar uses. It is mostly just a shim for `git
maintenance`, mapping task names from the way Scalar called them to the
way Git calls them.

The reason why those names differ? The background maintenance was first
implemented in Scalar, and when it was contributed as a patch series
implementing the `git maintenance` command, reviewers suggested better
names, those suggestions were accepted before the patches were
integrated into core Git.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 64 +++++++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt | 19 ++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 516a75be3c4..ca524576011 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -484,6 +484,69 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int cmd_run(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct {
+		const char *arg, *task;
+	} tasks[] = {
+		{ "config", NULL },
+		{ "commit-graph", "commit-graph" },
+		{ "fetch", "prefetch" },
+		{ "loose-objects", "loose-objects" },
+		{ "pack-files", "incremental-repack" },
+		{ NULL, NULL }
+	};
+	struct strbuf buf = STRBUF_INIT;
+	const char *usagestr[] = { NULL, NULL };
+	int i;
+
+	strbuf_addstr(&buf, N_("scalar run <task> [<enlistment>]\nTasks:\n"));
+	for (i = 0; tasks[i].arg; i++)
+		strbuf_addf(&buf, "\t%s\n", tasks[i].arg);
+	usagestr[0] = buf.buf;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usagestr, 0);
+
+	if (!argc)
+		usage_with_options(usagestr, options);
+
+	if (!strcmp("all", argv[0])) {
+		i = -1;
+	} else {
+		for (i = 0; tasks[i].arg && strcmp(tasks[i].arg, argv[0]); i++)
+			; /* keep looking for the task */
+
+		if (i > 0 && !tasks[i].arg) {
+			error(_("no such task: '%s'"), argv[0]);
+			usage_with_options(usagestr, options);
+		}
+	}
+
+	argc--;
+	argv++;
+	setup_enlistment_directory(argc, argv, usagestr, options, NULL);
+	strbuf_release(&buf);
+
+	if (i == 0)
+		return register_dir();
+
+	if (i > 0)
+		return run_git("maintenance", "run",
+			       "--task", tasks[i].task, NULL);
+
+	if (register_dir())
+		return -1;
+	for (i = 1; tasks[i].arg; i++)
+		if (run_git("maintenance", "run",
+			    "--task", tasks[i].task, NULL))
+			return -1;
+	return 0;
+}
+
 static int remove_deleted_enlistment(struct strbuf *path)
 {
 	int res = 0;
@@ -556,6 +619,7 @@ static struct {
 	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
+	{ "run", cmd_run },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 56f744a4aa9..39143b08324 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -12,6 +12,7 @@ scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<e
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
+scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -98,6 +99,24 @@ unregister [<enlistment>]::
 	Remove the specified repository from the list of repositories
 	registered with Scalar and stop the scheduled background maintenance.
 
+Run
+~~~
+
+scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]::
+	Run the given maintenance task (or all tasks, if `all` was specified).
+	Except for `all` and `config`, this subcommand simply hands off to
+	linkgit:git-maintenance[1] (mapping `fetch` to `prefetch` and
+	`pack-files` to `incremental-repack`).
++
+These tasks are run automatically as part of the scheduled maintenance,
+as soon as the repository is registered with Scalar. It should therefore
+not be necessary to run this subcommand manually.
++
+The `config` task is specific to Scalar and configures all those
+opinionated default settings that make Git work more efficiently with
+large repositories. As this task is run as part of `scalar clone`
+automatically, explicit invocations of this task are rarely needed.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
-- 
gitgitgadget

