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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F03C4332F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478E0610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351028AbhIHT0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351329AbhIHT0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:26:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC1C06129E
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so4888008wrb.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ySiVVFtUbc/3RO5iQimxg9/Yh69Yg4UMoTm1ZkYtGEc=;
        b=As99HXk74tvTjzabM9mrdkYNMuyMW9sjJjUqhS8ykT+rFh1EmNfCnWhHy3bJTQfRv+
         zmjPBKfywq/G1GHfEteMY1Vy1xmBhDO9y1FolIGBUExkNaw8LUutVZUc+9Vv+QR0wiNx
         /GCXE63Fhp4a6vx/+412lOsJ5lCcronm8aa33aw/ms2oHWOHDJDn6ValDLUfusPiafWt
         NwUWlz/co2Txe/MVpS9IiJujn6L7wXeorUXSDNZH3lgdhNftgyvwDdBDHwN/bPHpVfxJ
         Ux/p2KwUm8R5+i3Njo6rXF4jFoU+J88IuwWeI40aIQ76PUEpku7eEg1YxYs4U4RaEwyW
         0acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ySiVVFtUbc/3RO5iQimxg9/Yh69Yg4UMoTm1ZkYtGEc=;
        b=nmPts6iDzGsrBA4ybL1eyqQjsIKLQMyc5Y7WoPWGB08RqJQTeiEvg9R3cLVvvLGcpG
         Ve3lbbbosAHNZ7RGcS6moeeYSXb0e3yFhO6wAZqj1llMy+7PNNDBfuW4ZMDS49loOYiL
         1M0LfzgdpaNGq2PRj52oynCJV24kJkNKzf2E9Yu6Ny7MbuwYSwlncuXc+BIqFbXbH0G2
         wIX5DO4l5ffFVU0PSm3ZUWbgOfE/hSa+YtBFk3APXE0+1nkM4PoGW3FL1bWTozGBNWs+
         Q6388kOmTv1nUwCCExOMiDQ4JhVd7uqLdZy8ScGaXvpObVPTVzllJumMSEti8BhWJLHy
         Altg==
X-Gm-Message-State: AOAM530AgeLqNAukdZSmuVAQV+YErh3r4EbU84jT/uKZXnfqOCFCCwXR
        YuB17R6jdKxvc9HyNEMDMtWM3N+IXIM=
X-Google-Smtp-Source: ABdhPJzHkAK6DTBuexZn4mks2MrWeXVIF1jH6E31OlMNWLwyjLvwa3smVfl8KqOGU3wKB7OX/P/HjQ==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr5910933wrh.356.1631129093341;
        Wed, 08 Sep 2021 12:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm2967824wmf.33.2021.09.08.12.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:53 -0700 (PDT)
Message-Id: <76de416a64352fc565893d344b41fe7440c59142.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:40 +0000
Subject: [PATCH v3 10/15] scalar: implement the `run` command
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
index 7dd1f28948f..8a11f390251 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -490,6 +490,69 @@ static int cmd_register(int argc, const char **argv)
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
@@ -562,6 +625,7 @@ static struct {
 	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
+	{ "run", cmd_run },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 46999cf7c84..f139a14445d 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -12,6 +12,7 @@ scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<e
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
+scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -97,6 +98,24 @@ unregister [<enlistment>]::
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

