Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CBAC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhK3L7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbhK3L61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8DC06175A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:55:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v11so43817012wrw.10
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EnAo9DzhsdMVbWYI2vdFvzuNwGGFw58Qp+EsKM7jcZU=;
        b=hjGHRykTdHfGGHahrnoi7PKOpYOyXI4uiLBXDKFzM6K0wAyBzaL+zpP+cxcm9rqvaR
         Vs4kxRcqIG8B6YwgCxLGlvKm1GdtJo1lTN26q5u4/uHbzshwxFqPNVZEe5Ewd4phL5Cr
         TnLBA32J9gCl3OQd+kjQnNYBukZImdw3etKO9yHLx2ozhRKRgSVUa4fbuGtkQecwgSp1
         kqrqDhNq+ziZZ0gZgck5Bkcc3CuwvvcLkOBmlrrWOD7PK64mbdTAbBhmLzxuRT2JxarL
         +QRJGucgOwhzwAdNNvWGPGs46IgJuITU8n4BlADGXuXPvgj2Hn+W61Q54PsKxqQ7hXqe
         3oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EnAo9DzhsdMVbWYI2vdFvzuNwGGFw58Qp+EsKM7jcZU=;
        b=tTyZrrbPBsRA9LcIp9RppaMdj0EW1qOfjTTADjahs8/iMjCVYvixMdB4ynCyoCMegG
         GM9QVLp6oc9SLzBagFtoTIEM3BkGH5NIWapon5HdpTg6WsOJmHTk3XqDLQVvBsgen03O
         vMNa65GsugOQjsPefJvFjXU0MjXduysrDNXzNadmgJb29hZTT5FQb2dDtzAlDJ4XRDUL
         QJrMfqO9Ufizn/OQ/mA893jTq2ZiPxtp7fxatiy6Cs3m89fRkP6tBAfTYxawwFjlJeER
         MQrsOu2q5bcuxTpuIZaI6uNW5l3pKNZz9rPFek/j8CxeBJ6r5dxibfOy37slEVqav8e9
         /JGg==
X-Gm-Message-State: AOAM532jAgi+FVsKQe0LD5DKBjc7ze3C6PM2s21MgOs6YQmqZr+2m9RS
        j4JnzS8Dk+nY+oCf8KythflUeKQrNYo=
X-Google-Smtp-Source: ABdhPJxAKKN6LLuwyZLFzbnniHHwZM/fwZj2BKHQ11hYBJzjDdqdNhSAD2e/9zOMfdLxIhuwI/0o4g==
X-Received: by 2002:adf:d22a:: with SMTP id k10mr41159295wrh.80.1638273301526;
        Tue, 30 Nov 2021 03:55:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm22270484wri.50.2021.11.30.03.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:55:01 -0800 (PST)
Message-Id: <0cec6dbd2cbf35e2978bf98ca8bbc2f812621e62.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:47 +0000
Subject: [PATCH v9 15/17] scalar: teach 'reconfigure' to optionally handle all
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
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
 contrib/scalar/scalar.txt        |  9 +++--
 contrib/scalar/t/t9099-scalar.sh |  3 ++
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d7306b43cae..305b080663b 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -488,22 +488,77 @@ static int cmd_register(int argc, const char **argv)
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
index 89fd7901585..737cf563c1a 100644
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
@@ -125,6 +125,9 @@ After a Scalar upgrade, or when the configuration of a Scalar enlistment
 was somehow corrupted or changed by mistake, this subcommand allows to
 reconfigure the enlistment.
 
+With the `--all` option, all enlistments currently registered with Scalar
+will be reconfigured. Use this option after each Scalar upgrade.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index fb5e2efee0a..58af546fd84 100755
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

