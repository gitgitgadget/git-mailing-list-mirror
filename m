Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1831BC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbhK3L7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbhK3L61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753EC06175B
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:55:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d24so43900676wra.0
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dywTmLrB9oe3ZROlnvpiXOATJJ0fOgNh7eK+EgeoRDQ=;
        b=gNH4s/aFflipzkURIck0arilxXGasYl/eXUssU7KHBvbIC1bWxpssmhLklRzV7gtYi
         zQgncZjqqalRfzGlXGz1+PsQkcjiwHe+3rmkru0HckmVWktfpM/C5d6FpnEQuwNxSbOL
         WJvP5njTN8/nDHGcPxwQJeh3YUDRQ1hdIBvPoBguM1fWLbt7IdJDBvXm8kvW+yRGs5pY
         gTW+7yTvlLUg9gWlFVuRyn8M6Gh4McgUo3Rl1snfHMbTS3PNjVbsZGRh4544UQeSkmKH
         rCb36B5V6I3Oa73THZY70Oy5UcaS9/Tu4Sqo+5MxWvhPrUG+Nt+mYn/Kt0EozVcsCDLK
         gBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dywTmLrB9oe3ZROlnvpiXOATJJ0fOgNh7eK+EgeoRDQ=;
        b=1/LBAJJbbvHncSyeXSffDo37DlT5XHA+fW4WJoFrbkYVfbfMnM0iT22ciIQ6JDwQF6
         vRCWPhZftUZ4koQNE8WP/Aw958RBw1vaTkKyWTktj3zZaG6I/jnHpJO06VRF+ulA0pSl
         mSgATo71nSJ2RKMhjeeqFOaTOkCjmBh/Undr+DuQiicLmvUTcU7hhreotaA+gzYrGl4g
         ZqvjsFFThYeTLR5Xe3/lM6YPbFEOogX4sx/l7lWJ4C/xqPYAqoI3H7kA/Vxb/xVLT4By
         u2TYS2QgArpP2793c4nLdQMhAZy7gw+RtPVuO/TQQ4rXa+x20RHsDWyH595hOm5jGeNP
         VctQ==
X-Gm-Message-State: AOAM533m6Q2QzAjgMR4m62ksd10kGKpc7rFAKRbLh45wd7i8KAZxb3SQ
        c3oWt/woQ4D3OaQ1EvPjZPi26qWiSZA=
X-Google-Smtp-Source: ABdhPJy5CPiJ1TrAKfDQj7cQ+fmottDaYXxkqrb22JJFKVo/ot6RyEnDzmSMuHxCNxMxsx+rFdAt/A==
X-Received: by 2002:adf:f542:: with SMTP id j2mr39556381wrp.616.1638273302140;
        Tue, 30 Nov 2021 03:55:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm2286729wmf.2.2021.11.30.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:55:01 -0800 (PST)
Message-Id: <835f1c797922d8c9020460b9383a8f909878990a.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:48 +0000
Subject: [PATCH v9 16/17] scalar: implement the `delete` command
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
 contrib/scalar/scalar.c          | 63 ++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  8 ++++
 contrib/scalar/t/t9099-scalar.sh |  9 +++++
 3 files changed, 80 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 305b080663b..d4303c7c4a2 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -8,6 +8,8 @@
 #include "config.h"
 #include "run-command.h"
 #include "refs.h"
+#include "dir.h"
+#include "packfile.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -328,6 +330,33 @@ static char *remote_default_branch(const char *url)
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
@@ -688,6 +717,39 @@ static int cmd_unregister(int argc, const char **argv)
 	return unregister_dir();
 }
 
+static int cmd_delete(int argc, const char **argv)
+{
+	char *cwd = xgetcwd();
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
+	if (dir_inside_of(cwd, enlistment.buf) >= 0)
+		res = error(_("refusing to delete current working directory"));
+	else {
+		close_object_store(the_repository->objects);
+		res = delete_enlistment(&enlistment);
+	}
+	strbuf_release(&enlistment);
+	free(cwd);
+
+	return res;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -698,6 +760,7 @@ static struct {
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
+	{ "delete", cmd_delete },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 737cf563c1a..f416d637289 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar delete <enlistment>
 
 DESCRIPTION
 -----------
@@ -128,6 +129,13 @@ reconfigure the enlistment.
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
index 58af546fd84..2e1502ad45e 100755
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

