Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB9DC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B6720724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxbTQddC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403975AbgFXOrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403955AbgFXOqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EBC0613ED
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so2581760wmi.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3rXUslYCSXhn8OXvH5V2fRYdXYmO54T6GIJcsiBJWmQ=;
        b=NxbTQddCXIXTE9ohCYb+5ny2H5bKau2+xWNLp2BZSIt6ilfeRto4nuXdgJdT3NIy2e
         F3UOMkGhhCJJbpD56Lf2eYzdUGTzNt6vU2jWjNeYyXtmUfU4a4/8Ig1j87RGm7Gs4rlK
         lNuyjXnz3axrwTuS8/NlU8HOF2tj2/2kDYH26JGpsI6evgcBidYV/pdTFd2uXRQpmksV
         Gr1J1nik/e9vqmc+gFLG7vgt6MFFLHSGmSWKu/JuipNwJy3bDz6wMlp51Z1gtz/qAsHL
         QwDaAeLBXGsue6SwQNOxE4UgXdWGbF/JNLTRLsiA8+Ku/DDPFb3hvBu27a+7MHpu1wll
         pw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3rXUslYCSXhn8OXvH5V2fRYdXYmO54T6GIJcsiBJWmQ=;
        b=QyfULckm1tPEklUVXWiFSCydLwtNX34SxusyuIkYnFcqqK7aTUpYaCZM/6malPWW4V
         UxURzNy46W8b9s+UCBs7IjbbbPYmArZSAp9YDMphHFP7CpZQcN3xQPfAYu4KQCOCIBqz
         LFlljgXvQW/RH2j4sPV2vwHSz4SNyY4DMvL0yEIePO5vw4g/4WYQ5LQy6SamrGK107/d
         JCTHTTWttWsiiqdPzpTn/0XrXe+aneqenzpRS2DLk32BN8ybdJQy9fd2BkBg987mKcIu
         ObQkzS3LmzZ8TvwJzdv5RyeHgUDDRTb2qBmfATT1m5FRxaGufhoffaDRXhwMF9dCNQ+l
         wMwg==
X-Gm-Message-State: AOAM531/vxH9hf6F5h8wnZQEztZLaIT1tL8CjnXH8+UwqfxFgJH76W5u
        xvfuzkwemg68oaxPTZ1qeBzwuS1l9J4=
X-Google-Smtp-Source: ABdhPJz7jWj7dFihBdwYbknB6cuZWGDEcU2ZS2Q6t31HD9I5Uydqg4mv3jTRhHf07E6nJ7xdz2IjwQ==
X-Received: by 2002:a1c:1d04:: with SMTP id d4mr31705985wmd.156.1593010003182;
        Wed, 24 Jun 2020 07:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm27615176wrs.95.2020.06.24.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:42 -0700 (PDT)
Message-Id: <7747eaa57de9324b7f7a46f86d1179ce751f76c9.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Don Goodman-Wilson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:33 +0000
Subject: [PATCH v4 6/9] init: allow setting the default for the initial branch
 name via the config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Don Goodman-Wilson <don@goodman-wilson.com>

We just introduced the command-line option
`--initial-branch=<branch-name>` to allow initializing a new repository
with a different initial branch than the hard-coded one.

To allow users to override the initial branch name more permanently
(i.e. without having to specify the name manually for each and every
`git init` invocation), let's introduce the `init.defaultBranch` config
setting.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
---
 Documentation/config/init.txt |  4 ++++
 builtin/init-db.c             |  2 +-
 refs.c                        | 30 ++++++++++++++++++++++++++++++
 refs.h                        |  9 +++++++++
 t/t0001-init.sh               | 13 +++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index 46fa8c6a08..6ae4a38416 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -1,3 +1,7 @@
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+
+init.defaultBranch::
+	Allows overriding the default branch name when initializing
+	a new repository.
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 8fdfc334ac..cee64823cb 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -269,7 +269,7 @@ static int create_default_files(const char *template_path,
 		char *ref;
 
 		if (!initial_branch)
-			initial_branch = "master";
+			initial_branch = git_default_branch_name();
 
 		ref = xstrfmt("refs/heads/%s", initial_branch);
 		if (check_refname_format(ref, 0) < 0)
diff --git a/refs.c b/refs.c
index 224ff66c7b..b98dea5217 100644
--- a/refs.c
+++ b/refs.c
@@ -560,6 +560,36 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
 		argv_array_pushf(prefixes, *p, len, prefix);
 }
 
+char *repo_default_branch_name(struct repository *r)
+{
+	const char *config_key = "init.defaultbranch";
+	const char *config_display_key = "init.defaultBranch";
+	char *ret = NULL, *full_ref;
+
+	if (repo_config_get_string(r, config_key, &ret) < 0)
+		die(_("could not retrieve `%s`"), config_display_key);
+
+	if (!ret)
+		ret = xstrdup("master");
+
+	full_ref = xstrfmt("refs/heads/%s", ret);
+	if (check_refname_format(full_ref, 0))
+		die(_("invalid branch name: %s = %s"), config_display_key, ret);
+	free(full_ref);
+
+	return ret;
+}
+
+const char *git_default_branch_name(void)
+{
+	static char *ret;
+
+	if (!ret)
+		ret = repo_default_branch_name(the_repository);
+
+	return ret;
+}
+
 /*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
diff --git a/refs.h b/refs.h
index e010f8aec2..f212f8945e 100644
--- a/refs.h
+++ b/refs.h
@@ -154,6 +154,15 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
+/*
+ * Retrieves the default branch name for newly-initialized repositories.
+ *
+ * The return value of `repo_default_branch_name()` is an allocated string. The
+ * return value of `git_default_branch_name()` is a singleton.
+ */
+const char *git_default_branch_name(void);
+char *repo_default_branch_name(struct repository *r);
+
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 386c06b5dd..6d2467995e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -477,4 +477,17 @@ test_expect_success '--initial-branch' '
 	grep hello actual
 '
 
+test_expect_success 'overridden default initial branch name (config)' '
+	test_config_global init.defaultBranch nmb &&
+	git init initial-branch-config &&
+	git -C initial-branch-config symbolic-ref HEAD >actual &&
+	grep nmb actual
+'
+
+test_expect_success 'invalid default branch name' '
+	test_config_global init.defaultBranch "with space" &&
+	test_must_fail git init initial-branch-invalid 2>err &&
+	test_i18ngrep "invalid branch name" err
+'
+
 test_done
-- 
gitgitgadget

