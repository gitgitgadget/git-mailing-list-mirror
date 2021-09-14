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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A0EC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E9E60F26
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhINOpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhINOos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:44:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5CC06114B
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b21-20020a1c8015000000b003049690d882so2286488wmd.5
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7umOn+lbKwQBhvrSkuyvzsamrsCLKijBkTg3WVv+4Q8=;
        b=pJZYE+CKDL8+se0SThg/8qE24UWZfrCkRAsP4j/5aCAZjsQeV/4Ay2iVvuuX6nWA1A
         veaGSeOKkZk4uzDJeZPK4hT5+CBTsPVe/YhM+DpuF35HbrLZonwmMQ8VEXjGVIt3lBmF
         dWMF+CdP//TPsI0ClHQ2dmJDLuNHUlpQzh7pIjaOQlK9MSdQqXPVEmVdb/DZIHp/ip/f
         Kc+gfYOKDVMoup3mi3uIdcAxe7+46NUtLSXhI8YEwOF9Goxl4t5poPBUdhXeUesSSY+x
         KW0IfM1+jUHTmoozFLWjOj1rBLrZrXOy8j2VD2+hx7EyHwhS4exTNJVIcnMWmVSqnrPq
         Jx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7umOn+lbKwQBhvrSkuyvzsamrsCLKijBkTg3WVv+4Q8=;
        b=Xo2PEwAt2gyqBpbCY01p1HVqwy3WJbpJdryCwBgPmNoye8xvlXqhbQAqObCKblf2Zo
         pgzSn8B8x9sOlrnJEVOLiDQc/EFdNeBum/EX369b2rwt689151tzXzEug4XYOoMfhzYS
         FQitd+uWuGHj1Aul2QQVphaXW3rqcH9HDwZJWREaaoeqvyZW2TQOffwuS4qKpIM2y9tt
         lL76C7Jlm6rMt/hXiBAy2Grb3lbuW/6/ZO1wRtcZkpYwMK3wTZBqppCyKjTQNNLDwRUi
         2pPOCKq14emPXQdqFMDUn0HCAtMmyA3JXT5agRRerNWGWk4GHhvRqx/kvwiUK7PZGWpa
         aY2w==
X-Gm-Message-State: AOAM530WdKJpxSQQPP/9dtN4B3WlRJam83DSZr+hQ8HE63j7erMKw3zb
        QhqfbTAD2N1IEeGH7I54W9pq4u93hzg=
X-Google-Smtp-Source: ABdhPJz/hzi5HOQSvgGcEvMvBJEIFUh+p7bjjZV7FlOWsBCBxUtjYHRUVPHMFK0S1E+GXrrwW0dTuQ==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr2684777wmg.88.1631630365580;
        Tue, 14 Sep 2021 07:39:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm1360158wmq.23.2021.09.14.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:25 -0700 (PDT)
Message-Id: <ada242c7c8c1f530231f97e76c97fff18e368ff5.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:12 +0000
Subject: [PATCH v4 11/15] scalar: allow reconfiguring an existing enlistment
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
index 8a11f390251..1fff7eb7c12 100644
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
index f139a14445d..f4e4686e8c8 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -13,6 +13,7 @@ scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
+scalar reconfigure <enlistment>
 
 DESCRIPTION
 -----------
@@ -116,6 +117,13 @@ opinionated default settings that make Git work more efficiently with
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

