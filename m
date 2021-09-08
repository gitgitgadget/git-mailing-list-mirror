Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC66C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578F561104
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352166AbhIHT0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351974AbhIHT0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:26:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF2C0612A7
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so2438319wmq.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EB3dcG1dPIWxxGn3w/65eB+x5GjyM07hpyUVTAxuSws=;
        b=arzbUpLO1uFyAHImHC0fbKecAujOwluVnXTfrgLzJs1PfKKWH97QL+O/XRx8B+vBlE
         WubPFjceP0hPhAzcpmZBtq3Uh7eB6v2ybHzK/Kk4xMka3Tk8d0nJrw9v7KE9GfPyv7RY
         CmwLgBmoZHRd0FiAPzQSn34uWxcbXL/pmWO2ibH+/jy8w/5eWMWCC7yZ12nqCIlZGTTD
         csUkYl/jlMMhdqp0aHdXUuRlY+IqWMYl84/jAhusc/sdKSszQAbwImBlcdXCwb62fQvq
         mh5YwmHEBRXfCmz6CGdbNQXlineSI6Por2E+QcpPv1rlNl5QdxG1iMEFEW1JkcTlyx4j
         m+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EB3dcG1dPIWxxGn3w/65eB+x5GjyM07hpyUVTAxuSws=;
        b=RxVDbACEJY0Cfb3ogsITs88PnhhMeKyBoc/8GsJdXDdDBLe0mhu1oUyu5oQmZy1NWN
         nVdI70TThFalu6DSMcNyVGdCG+HECSwlFsu8hFW6rXc3WsY5k/on6EfBNrX612Owo3VR
         faLmogzdMC/Md+zV8X2bGoslE15g0zxBB8CON13CIEOJIZ3oHWczS2N5/xw9t7bwilg5
         DJqqt9wel7qmwMRBFGox3te3hgkvReiO2hgZIpEEK0ygoOpLP0Sku9zhJi9Nj9Cw6Aov
         XtQ0NVVszY9ld0OAY2MJ0MpRyxU5JJn30lLp21RfPZvhUtU6LMVh6pwbBq7LUbArkOd1
         bOfw==
X-Gm-Message-State: AOAM530lOtpc6JT1Rb48C9YK0V9l97bJeHKU42bMEk8yH1nXBpjloT/g
        ca30s7AAtwSSYwv/4klWHdeFPm0O+6Q=
X-Google-Smtp-Source: ABdhPJwrH2GLufohxHy8G3DJYgdHK0V1+YxngSEzcKwrMH9dPPdu5ahP+9H3i4oHvnH9j/NVLxjQWg==
X-Received: by 2002:a7b:cbc4:: with SMTP id n4mr483149wmi.93.1631129095271;
        Wed, 08 Sep 2021 12:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm25734wrg.31.2021.09.08.12.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:54 -0700 (PDT)
Message-Id: <c67938299ee48655b198effe0a0cca73d82d4d00.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:43 +0000
Subject: [PATCH v3 13/15] scalar: implement the `delete` command
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
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Delete an enlistment by first unregistering the repository and then
deleting the enlistment directory (usually the directory containing the
worktree `src/` directory).

On Windows, if the current directory is inside the enlistment's
directory, change to the parent of the enlistment directory, to allow us
to delete the enlistment (directories used by processes e.g. as current
working directories cannot be deleted on Windows).

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 55 ++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  8 +++++
 contrib/scalar/t/t9099-scalar.sh |  9 ++++++
 3 files changed, 72 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 67fa5305225..00bedb0bf66 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -8,6 +8,7 @@
 #include "config.h"
 #include "run-command.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -334,6 +335,33 @@ static char *remote_default_branch(const char *url)
 	return NULL;
 }
 
+static int delete_enlistment(struct strbuf *enlistment)
+{
+#ifdef WIN32
+	struct strbuf parent = STRBUF_INIT;
+#endif
+
+	if (unregister_dir())
+		die(_("failed to unregister repository"));
+
+#ifdef WIN32
+	/*
+	 * Change the current directory to one outside of the enlistment so
+	 * that we may delete everything underneath it.
+	 */
+	strbuf_addbuf(&parent, enlistment);
+	strbuf_parent_directory(&parent);
+	if (chdir(parent.buf) < 0)
+		die_errno(_("could not switch to '%s'"), parent.buf);
+	strbuf_release(&parent);
+#endif
+
+	if (remove_dir_recursively(enlistment, 0))
+		die(_("failed to delete enlistment directory"));
+
+	return 0;
+}
+
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
@@ -694,6 +722,32 @@ static int cmd_unregister(int argc, const char **argv)
 	return unregister_dir();
 }
 
+static int cmd_delete(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar delete <enlistment>"),
+		NULL
+	};
+	struct strbuf enlistment = STRBUF_INIT;
+	int res = 0;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 1)
+		usage_with_options(usage, options);
+
+	setup_enlistment_directory(argc, argv, usage, options, &enlistment);
+
+	res = delete_enlistment(&enlistment);
+	strbuf_release(&enlistment);
+
+	return res;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -704,6 +758,7 @@ static struct {
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
+	{ "delete", cmd_delete },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 2fa96fcabc6..6fc57707718 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar delete <enlistment>
 
 DESCRIPTION
 -----------
@@ -127,6 +128,13 @@ reconfigure the enlistment.
 With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. Use this option after each Scalar upgrade.
 
+Delete
+~~~~~~
+
+delete <enlistment>::
+	This subcommand lets you delete an existing Scalar enlistment from your
+	local file system, unregistering the repository.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 5fe7fabd0e5..7e8771d0eff 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -76,4 +76,13 @@ test_expect_success 'scalar reconfigure' '
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
+test_expect_success 'scalar delete without enlistment shows a usage' '
+	test_expect_code 129 scalar delete
+'
+
+test_expect_success 'scalar delete with enlistment' '
+	scalar delete cloned &&
+	test_path_is_missing cloned
+'
+
 test_done
-- 
gitgitgadget

