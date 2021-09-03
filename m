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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C483FC433FE
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A9F60EB7
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350316AbhICR4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350303AbhICRz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D727AC061757
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:54:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so123132wmi.0
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FcACGb+Bu+/ID3zc9FkbAUB4/whZz3/kpBWWOSkdmG0=;
        b=osPAlfq3yIG6ANHMH/h2/yeKdNeSSMANKqVsKQB2KH2i+jWUVqvMvsdofuzIcURt8J
         lHTmR5w0CGDNVKUXvhcnzf4KO6mHp0a2db8PNkI7vkjToKM0vWlk3t2y7EQ0VgmXqbph
         tu79Pl8LcGKqXBPg2ljEODtOa0IlZYJlrwVgBN5wXcYyTPViQQR6GJCEr12Z1easDtJE
         YzFBN4VHv4VIk8lMXx0WGBGHMO85/I8eTku3hVGaPkbw9Tgjg7uyBNVdAf7PYMtgplgt
         Udoob5zeIZhn0XnWZxkAXxhOIx48HSBR5gO/m9lU7VKR/lshQDaBEOZkocEYuOShikkT
         O4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FcACGb+Bu+/ID3zc9FkbAUB4/whZz3/kpBWWOSkdmG0=;
        b=nJF6vY4+CfUn23MhCbhnikudFuyy2RW+dtZ9LtoGV9bhzXVFrKq3Ps/DbMaaferimf
         W3iq4Is4kyXG4QS3xzLdrkfCLyr5bVoRxc+VVkG2pE3fYppSpTgE5NXB7/DJaSlaWYak
         oj6FgKbPvc0Gw1nqcTOy94EfYSRsuCzStLt3UMH3OXDBJu64PWeuOTDAbhc9VrWYg3u2
         KJ/YkAgs93tuETzf35Kp/MxElMJ9Ztx4LKKfOaMzh77o3KfSnxpKPXBirI+ufTFBBE/y
         KXjBiG6uqGg1akhfchtMeDV3NwzRE/Xq/5fJiBfhGsUpQHW2Ha6J+VJufGBiyJmdsBot
         t0Ww==
X-Gm-Message-State: AOAM531gUR6q+kkibfsP4NsyjKWVITb+HSmKfGnCDOuZN4HHB4Po4Jhd
        tygZUpEGtl9GrPabQCeg3TI17A+ptMY=
X-Google-Smtp-Source: ABdhPJw9KhhkLgJIADsJ/rjJgh8YcQLSZnjz+DdWoIhGZjlXGVDPkO13EVbwDkjj6WAoMOgPxoX9BA==
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr53162wms.184.1630691697396;
        Fri, 03 Sep 2021 10:54:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm31076wmc.46.2021.09.03.10.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:57 -0700 (PDT)
Message-Id: <9a834c23d08972e6b30742414415a798138ca32d.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:43 +0000
Subject: [PATCH v2 11/15] scalar: allow reconfiguring an existing enlistment
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

This comes in handy during Scalar upgrades, or when config settings were
messed up by mistake.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 79 +++++++++++++++++++++-----------
 contrib/scalar/scalar.txt        |  8 ++++
 contrib/scalar/t/t9099-scalar.sh |  8 ++++
 3 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 0452dfce915..bfbf58f7a91 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -115,18 +115,20 @@ static int run_git(const char *arg, ...)
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
@@ -140,28 +142,29 @@ static int set_recommended_config(void)
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
-		{ "merge.renames", "false" },
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
+		{ "merge.renames", "false", 1 },
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
@@ -172,7 +175,8 @@ static int set_recommended_config(void)
 	char *value;
 
 	for (i = 0; config[i].key; i++) {
-		if (git_config_get_string(config[i].key, &value)) {
+		if ((reconfigure && config[i].overwrite_on_reconfigure) ||
+		    git_config_get_string(config[i].key, &value)) {
 			trace2_data_string("scalar", the_repository, config[i].key, "created");
 			if (git_config_set_gently(config[i].key,
 						  config[i].value) < 0)
@@ -237,7 +241,7 @@ static int register_dir(void)
 	int res = add_or_remove_enlistment(1);
 
 	if (!res)
-		res = set_recommended_config();
+		res = set_recommended_config(0);
 
 	if (!res)
 		res = toggle_maintenance(1);
@@ -425,7 +429,7 @@ static int cmd_clone(int argc, const char **argv)
 	    (res = run_git("sparse-checkout", "init", "--cone", NULL)))
 		goto cleanup;
 
-	if (set_recommended_config())
+	if (set_recommended_config(0))
 		return error(_("could not configure '%s'"), dir);
 
 	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
@@ -490,6 +494,24 @@ static int cmd_register(int argc, const char **argv)
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
@@ -626,6 +648,7 @@ static struct {
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
+	{ "reconfigure", cmd_reconfigure },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index ff8792e5a64..df6e961ca37 100644
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
index 9a35ab4fde6..e6d74a06ca0 100755
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

