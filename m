Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C75C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381125AbhLCNiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381112AbhLCNiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:13 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287DBC061758
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o29so2376695wms.2
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zl2vUbDhqmmWJ8RnUA4Mik2HNxETj5S1M012xd3a9wU=;
        b=PCZ8mMTjKY4jPSpwYaRUgkuwb8oUEjj366Qe/QIAwriM9djyPaDbBB6skDJqWjvF4H
         Mn1NPzYA50waiA/LGDlFXrpwrJV3/z6ETH26LN9pv9l1+DGQEMB8zIL0rjee3gCx7s5z
         IFr2z4hM+X4yJzTOk2aBJVq8TTNz9Z5oZ3kA22UDsd86mCw6HoYnJhqt02rg/DDfPabb
         lUHESebtqvqFVr2xneCNNKCPz6seRM+yMhDgqpKTKwASfVZ6wKNiwPhvPOTyOucANOwo
         LsMzRkUtWIUJrdC13oqkcWO3xM+2au3HCO8vGOPf9dm7JomdjRSXlzL9IrgxOB/vMGu8
         pbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zl2vUbDhqmmWJ8RnUA4Mik2HNxETj5S1M012xd3a9wU=;
        b=nIt7F/ONNQfEfXn0k5gdORG8TQJibsLaueZFjkPno4+J669o6rTX8ZTG5FLoogy5Tx
         9xBuF87wtNOmaNQGdXwrosFiB+oKMYFawiyULsMHD5bXQA7O9pe5dXC08Vzf9P5kjqmk
         dHr1tjVlqFZKockPXB2C5LvMkHy5FQBIfHKD7+IylcyDho/Q8NvLRSNsPodmJszCKIkg
         egk8RLIwfjmLOzU019tL1/KUsdkoQmXOPAFUvpzMURXGIrZp7nBRrwBXxCztNAprBfiT
         eDt+e9dt7HGgOQTzlwlYsKFbSqMuRydwe9FC08NKcj3/t4it4Zo7ZLQsaJU213IfBTbr
         pIjw==
X-Gm-Message-State: AOAM530mK5ufpiIiC00e1xLdKkT5wM04xsLuFF54EXOehXOXEKo1ylSO
        fem0hg2nOOv+pgaxcYtswtpYkZRZrhM=
X-Google-Smtp-Source: ABdhPJyd4ejDy3zWCWKQ9k595a9UZINNBqvoaKJrwYs1XDYvBEd2bc74cMv/Owf7BYABgQLwrOD8Jw==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr14610552wma.30.1638538482394;
        Fri, 03 Dec 2021 05:34:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm2545981wrp.61.2021.12.03.05.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:42 -0800 (PST)
Message-Id: <2a3fb40bd9a4a3aa18a8265a50d4c52a06705a9f.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:26 +0000
Subject: [PATCH v10 12/15] scalar: allow reconfiguring an existing enlistment
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

This comes in handy during Scalar upgrades, or when config settings were
messed up by mistake.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 79 +++++++++++++++++++++-----------
 contrib/scalar/scalar.txt        |  8 ++++
 contrib/scalar/t/t9099-scalar.sh |  8 ++++
 3 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index fa900e4373f..d7306b43cae 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -108,18 +108,20 @@ static int run_git(const char *arg, ...)
 	return res;
 }
 
-static int set_recommended_config(void)
+static int set_recommended_config(int reconfigure)
 {
 	struct {
 		const char *key;
 		const char *value;
+		int overwrite_on_reconfigure;
 	} config[] = {
-		{ "am.keepCR", "true" },
-		{ "core.FSCache", "true" },
-		{ "core.multiPackIndex", "true" },
-		{ "core.preloadIndex", "true" },
+		/* Required */
+		{ "am.keepCR", "true", 1 },
+		{ "core.FSCache", "true", 1 },
+		{ "core.multiPackIndex", "true", 1 },
+		{ "core.preloadIndex", "true", 1 },
 #ifndef WIN32
-		{ "core.untrackedCache", "true" },
+		{ "core.untrackedCache", "true", 1 },
 #else
 		/*
 		 * Unfortunately, Scalar's Functional Tests demonstrated
@@ -133,28 +135,29 @@ static int set_recommended_config(void)
 		 * Therefore, with a sad heart, we disable this very useful
 		 * feature on Windows.
 		 */
-		{ "core.untrackedCache", "false" },
+		{ "core.untrackedCache", "false", 1 },
 #endif
-		{ "core.logAllRefUpdates", "true" },
-		{ "credential.https://dev.azure.com.useHttpPath", "true" },
-		{ "credential.validate", "false" }, /* GCM4W-only */
-		{ "gc.auto", "0" },
-		{ "gui.GCWarning", "false" },
-		{ "index.threads", "true" },
-		{ "index.version", "4" },
-		{ "merge.stat", "false" },
-		{ "merge.renames", "true" },
-		{ "pack.useBitmaps", "false" },
-		{ "pack.useSparse", "true" },
-		{ "receive.autoGC", "false" },
-		{ "reset.quiet", "true" },
-		{ "feature.manyFiles", "false" },
-		{ "feature.experimental", "false" },
-		{ "fetch.unpackLimit", "1" },
-		{ "fetch.writeCommitGraph", "false" },
+		{ "core.logAllRefUpdates", "true", 1 },
+		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
+		{ "credential.validate", "false", 1 }, /* GCM4W-only */
+		{ "gc.auto", "0", 1 },
+		{ "gui.GCWarning", "false", 1 },
+		{ "index.threads", "true", 1 },
+		{ "index.version", "4", 1 },
+		{ "merge.stat", "false", 1 },
+		{ "merge.renames", "true", 1 },
+		{ "pack.useBitmaps", "false", 1 },
+		{ "pack.useSparse", "true", 1 },
+		{ "receive.autoGC", "false", 1 },
+		{ "reset.quiet", "true", 1 },
+		{ "feature.manyFiles", "false", 1 },
+		{ "feature.experimental", "false", 1 },
+		{ "fetch.unpackLimit", "1", 1 },
+		{ "fetch.writeCommitGraph", "false", 1 },
 #ifdef WIN32
-		{ "http.sslBackend", "schannel" },
+		{ "http.sslBackend", "schannel", 1 },
 #endif
+		/* Optional */
 		{ "status.aheadBehind", "false" },
 		{ "commitGraph.generationVersion", "1" },
 		{ "core.autoCRLF", "false" },
@@ -166,7 +169,8 @@ static int set_recommended_config(void)
 	char *value;
 
 	for (i = 0; config[i].key; i++) {
-		if (git_config_get_string(config[i].key, &value)) {
+		if ((reconfigure && config[i].overwrite_on_reconfigure) ||
+		    git_config_get_string(config[i].key, &value)) {
 			trace2_data_string("scalar", the_repository, config[i].key, "created");
 			if (git_config_set_gently(config[i].key,
 						  config[i].value) < 0)
@@ -231,7 +235,7 @@ static int register_dir(void)
 	int res = add_or_remove_enlistment(1);
 
 	if (!res)
-		res = set_recommended_config();
+		res = set_recommended_config(0);
 
 	if (!res)
 		res = toggle_maintenance(1);
@@ -419,7 +423,7 @@ static int cmd_clone(int argc, const char **argv)
 	    (res = run_git("sparse-checkout", "init", "--cone", NULL)))
 		goto cleanup;
 
-	if (set_recommended_config())
+	if (set_recommended_config(0))
 		return error(_("could not configure '%s'"), dir);
 
 	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
@@ -484,6 +488,24 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int cmd_reconfigure(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar reconfigure [<enlistment>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+	return set_recommended_config(1);
+}
+
 static int cmd_run(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -620,6 +642,7 @@ static struct {
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
+	{ "reconfigure", cmd_reconfigure },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 39143b08324..89fd7901585 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -13,6 +13,7 @@ scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
+scalar reconfigure <enlistment>
 
 DESCRIPTION
 -----------
@@ -117,6 +118,13 @@ opinionated default settings that make Git work more efficiently with
 large repositories. As this task is run as part of `scalar clone`
 automatically, explicit invocations of this task are rarely needed.
 
+Reconfigure
+~~~~~~~~~~~
+
+After a Scalar upgrade, or when the configuration of a Scalar enlistment
+was somehow corrupted or changed by mistake, this subcommand allows to
+reconfigure the enlistment.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index f60e086d6f9..fb5e2efee0a 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -65,4 +65,12 @@ test_expect_success 'scalar clone' '
 	)
 '
 
+test_expect_success 'scalar reconfigure' '
+	git init one/src &&
+	scalar register one &&
+	git -C one/src config core.preloadIndex false &&
+	scalar reconfigure one &&
+	test true = "$(git -C one/src config core.preloadIndex)"
+'
+
 test_done
-- 
gitgitgadget

