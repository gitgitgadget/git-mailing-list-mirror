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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F304C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275ED610D1
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhINOqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhINOpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:45:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF68C06114D
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d21so12929005wra.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EB3dcG1dPIWxxGn3w/65eB+x5GjyM07hpyUVTAxuSws=;
        b=V5rTthy2E1lOsEc1dAPuwfK9DkHpTOSuN+2Rsc9HmPDDhJNbtKwz7dAWTq7ZS2xgwh
         SE8SffQ8SnBEgLRTY/2Cgs+hQB7tA28C6+76SLH6ZI2X91QSwOvBybtaPvsjwonNjn+S
         D86e0iSFP3YqBWfBkXpQutHi3GLgbHzTVeUMl+xW7FObNgEwwnpuAwESp9oazfwCZKse
         h1z32gqA1jdcO9WfD5xuMkRwpqpJwjgqJ8nofdwH65zUzoffQAkHXsxml9re7Fb+iIOX
         0wCM07x/gzQJHHdmqSm6eMLwTakFBjmMFtw5cg5MpKcIns6E6NILlDadIRKf4OuIh86M
         kZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EB3dcG1dPIWxxGn3w/65eB+x5GjyM07hpyUVTAxuSws=;
        b=BbNcLrVFUPSqTPjHfDN57OBXmN+xeDr8jX3BrftfiuYx28g/dq3LMuMqJRKNXkr8NS
         HUGnPh3xFvKTrk1k1bV5847SVhAe1BUSYWUV1RiXFGVhV4PasrclhZcpS5L2P8mXqpGG
         P2m3NUKOsvB1hbsU8tPl/YLcDzVAy0mn7TL3R8OwyZrHrT6hBRBUZvyiOIZllanvnoll
         3sUwqay19EReiOlzFuYfY41DYXviVCisr773IBaXAuR2sJSwFbMkIt0dBfuadv9fS5LK
         Zdm3AwwB8DXOH1LHVbWxizr4pE8M4T9/IWhEAADegLJ9XiXPbkoQrEss185ju6hF2N1w
         6EqA==
X-Gm-Message-State: AOAM530S/6mlHluE3nsE4I2JXE83Yb37PNfu1DkJazOvsaws8yk0WZNe
        fegbtyFqXnl2gyDm+MQJs2ELiI9g1Uw=
X-Google-Smtp-Source: ABdhPJw9IpVEyet7g+7YfY0Fv1aYKZ7b2pgYDU7fNr1LzUyowKJ/eQndybf9b2oLREvw1LsI6AFyWg==
X-Received: by 2002:adf:b741:: with SMTP id n1mr19428176wre.120.1631630366697;
        Tue, 14 Sep 2021 07:39:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm219199wmo.37.2021.09.14.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:26 -0700 (PDT)
Message-Id: <914c16c7fcd948374fb2c0582c435d0d6ac775a0.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:14 +0000
Subject: [PATCH v4 13/15] scalar: implement the `delete` command
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

