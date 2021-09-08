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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7573C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB94610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350965AbhIHT0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350001AbhIHTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:25:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C67C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b6so4831779wrh.10
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b5y4dR7pqaUrtB65kZ7JF9/dDKoxFFqiSg9M6Oebu7I=;
        b=hlhnjLfq/N1YRb3DaruNH90arENR+P/siwW1hh1YS3WMOMoWdiJmuFuk9TPq7xv0/Y
         v4eEy+v7/5bdhqCNSTY0D0sMvHUQSK6/cygf+4s2lLSwO4hVWNBu5XRXkgY4PSUBY6/H
         P8rs93fcCtMc2sgkcUQcjnKd8RzH5QmsT5SfLOhWdz69vynV9kvs/CFnWjgjviMI70wV
         QFBhk2MOlrZlQikTOr4EZNDwC0t1Vv9ZsQAQeMFGiLe4lc9oKQ9uDea7mukGB/6MMNC5
         CuGlkt2iKAZUnIPfrZf5uBLQWLPI4rl+J96AcvMsR7U+CMK639V1gYFqTDBz7ENY2z2V
         J31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b5y4dR7pqaUrtB65kZ7JF9/dDKoxFFqiSg9M6Oebu7I=;
        b=ee2nZML2gTMJzs7iYntC0ltCCVf3Pl4eCleqREcC5Jhp0o1kAoB7KnMfqUZMS+tjR2
         roArTKIM3P0f+lByslLu33RR6N23pl5CB4lsfSUG0DE97xXe9uJGrzxVc4pV6OSHo/Us
         fnKtSNQhUOYLdI/Tqd0jxhTMZg4tEE5TUg695boLaEWJI0BA74gOBbBIotq2Ir5keewr
         ovJXv7P3k/iIROfBE/8E3y1VJf8GOKJaXK3DbZSYrxZfXzn0BrffJkLI9Yw5rtCYYJE6
         P00Px4RTc8nE3nRGcCAJU/UbpKd4Bxn+NxOi3gD6cDIPTRCVWgwsEAlpUFZPAJ3gONrU
         U7vQ==
X-Gm-Message-State: AOAM531Lkj6eEFAh46bNKXLNpihgeGcpfmEv4p94z/8Fp9pN/SQjZ73g
        yTjY78Whp8147F1BGtwqZeBoSN4yIyc=
X-Google-Smtp-Source: ABdhPJw142aMGo7mWdEwXJ1Wt99zQstwy4KgfrU+NETr2XaAZY146DxiXXb6S7alLWRWiuRi4BIV3w==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr5873846wre.63.1631129089505;
        Wed, 08 Sep 2021 12:24:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i27sm2844393wmb.40.2021.09.08.12.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:49 -0700 (PDT)
Message-Id: <ee3e26a0c4e8fd9ecad1ff71f86423c2685adec4.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:34 +0000
Subject: [PATCH v3 04/15] scalar: 'register' sets recommended config and
 starts maintenance
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

Let's start implementing the `register` command. With this commit,
recommended settings are configured upon `scalar register`, and Git's
background maintenance is started.

The recommended config settings may very well change in the future. For
example, once the built-in FSMonitor is available, we will want to
enable it upon `scalar register`. For that reason, we explicitly support
running `scalar register` in an already-registered enlistment.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 255 ++++++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt |  18 ++-
 2 files changed, 272 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7cff29e0fcd..0e627bb100e 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -5,11 +5,266 @@
 #include "cache.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "config.h"
+#include "run-command.h"
+
+/*
+ * Remove the deepest subdirectory in the provided path string. Path must not
+ * include a trailing path separator. Returns 1 if parent directory found,
+ * otherwise 0.
+ */
+static int strbuf_parent_directory(struct strbuf *buf)
+{
+	size_t len = buf->len;
+	size_t offset = offset_1st_component(buf->buf);
+	char *path_sep = find_last_dir_sep(buf->buf + offset);
+	strbuf_setlen(buf, path_sep ? path_sep - buf->buf : offset);
+
+	return buf->len < len;
+}
+
+static void setup_enlistment_directory(int argc, const char **argv,
+				       const char * const *usagestr,
+				       const struct option *options,
+				       struct strbuf *enlistment_root)
+{
+	struct strbuf path = STRBUF_INIT;
+	char *root;
+	int enlistment_found = 0;
+
+	if (startup_info->have_repository)
+		BUG("gitdir already set up?!?");
+
+	if (argc > 1)
+		usage_with_options(usagestr, options);
+
+	/* find the worktree, determine its corresponding root */
+	if (argc == 1)
+		strbuf_add_absolute_path(&path, argv[0]);
+	else if (strbuf_getcwd(&path) < 0)
+		die(_("need a working directory"));
+
+	strbuf_trim_trailing_dir_sep(&path);
+	do {
+		const size_t len = path.len;
+
+		/* check if currently in enlistment root with src/ workdir */
+		strbuf_addstr(&path, "/src/.git");
+		if (is_git_directory(path.buf)) {
+			strbuf_strip_suffix(&path, "/.git");
+
+			if (enlistment_root)
+				strbuf_add(enlistment_root, path.buf, len);
+
+			enlistment_found = 1;
+			break;
+		}
+
+		/* reset to original path */
+		strbuf_setlen(&path, len);
+
+		/* check if currently in workdir */
+		strbuf_addstr(&path, "/.git");
+		if (is_git_directory(path.buf)) {
+			strbuf_setlen(&path, len);
+
+			if (enlistment_root) {
+				/*
+				 * If the worktree's directory's name is `src`, the enlistment is the
+				 * parent directory, otherwise it is identical to the worktree.
+				 */
+				root = strip_path_suffix(path.buf, "src");
+				strbuf_addstr(enlistment_root, root ? root : path.buf);
+				free(root);
+			}
+
+			enlistment_found = 1;
+			break;
+		}
+
+		strbuf_setlen(&path, len);
+	} while (strbuf_parent_directory(&path));
+
+	if (!enlistment_found)
+		die(_("could not find enlistment root"));
+
+	if (chdir(path.buf) < 0)
+		die_errno(_("could not switch to '%s'"), path.buf);
+
+	strbuf_release(&path);
+	setup_git_directory();
+}
+
+static int run_git(const char *arg, ...)
+{
+	struct strvec argv = STRVEC_INIT;
+	va_list args;
+	const char *p;
+	int res;
+
+	va_start(args, arg);
+	strvec_push(&argv, arg);
+	while ((p = va_arg(args, const char *)))
+		strvec_push(&argv, p);
+	va_end(args);
+
+	res = run_command_v_opt(argv.v, RUN_GIT_CMD);
+
+	strvec_clear(&argv);
+	return res;
+}
+
+static int set_recommended_config(void)
+{
+	struct {
+		const char *key;
+		const char *value;
+	} config[] = {
+		{ "am.keepCR", "true" },
+		{ "core.FSCache", "true" },
+		{ "core.multiPackIndex", "true" },
+		{ "core.preloadIndex", "true" },
+#ifndef WIN32
+		{ "core.untrackedCache", "true" },
+#else
+		/*
+		 * Unfortunately, Scalar's Functional Tests demonstrated
+		 * that the untracked cache feature is unreliable on Windows
+		 * (which is a bummer because that platform would benefit the
+		 * most from it). For some reason, freshly created files seem
+		 * not to update the directory's `lastModified` time
+		 * immediately, but the untracked cache would need to rely on
+		 * that.
+		 *
+		 * Therefore, with a sad heart, we disable this very useful
+		 * feature on Windows.
+		 */
+		{ "core.untrackedCache", "false" },
+#endif
+		{ "core.logAllRefUpdates", "true" },
+		{ "credential.https://dev.azure.com.useHttpPath", "true" },
+		{ "credential.validate", "false" }, /* GCM4W-only */
+		{ "gc.auto", "0" },
+		{ "gui.GCWarning", "false" },
+		{ "index.threads", "true" },
+		{ "index.version", "4" },
+		{ "merge.stat", "false" },
+		{ "merge.renames", "false" },
+		{ "pack.useBitmaps", "false" },
+		{ "pack.useSparse", "true" },
+		{ "receive.autoGC", "false" },
+		{ "reset.quiet", "true" },
+		{ "feature.manyFiles", "false" },
+		{ "feature.experimental", "false" },
+		{ "fetch.unpackLimit", "1" },
+		{ "fetch.writeCommitGraph", "false" },
+#ifdef WIN32
+		{ "http.sslBackend", "schannel" },
+#endif
+		{ "status.aheadBehind", "false" },
+		{ "commitGraph.generationVersion", "1" },
+		{ "core.autoCRLF", "false" },
+		{ "core.safeCRLF", "false" },
+		{ NULL, NULL },
+	};
+	int i;
+	char *value;
+
+	for (i = 0; config[i].key; i++) {
+		if (git_config_get_string(config[i].key, &value)) {
+			trace2_data_string("scalar", the_repository, config[i].key, "created");
+			if (git_config_set_gently(config[i].key,
+						  config[i].value) < 0)
+				return error(_("could not configure %s=%s"),
+					     config[i].key, config[i].value);
+		} else {
+			trace2_data_string("scalar", the_repository, config[i].key, "exists");
+			free(value);
+		}
+	}
+
+	/*
+	 * The `log.excludeDecoration` setting is special because it allows
+	 * for multiple values.
+	 */
+	if (git_config_get_string("log.excludeDecoration", &value)) {
+		trace2_data_string("scalar", the_repository,
+				   "log.excludeDecoration", "created");
+		if (git_config_set_multivar_gently("log.excludeDecoration",
+						   "refs/prefetch/*",
+						   CONFIG_REGEX_NONE, 0))
+			return error(_("could not configure "
+				       "log.excludeDecoration"));
+	} else {
+		trace2_data_string("scalar", the_repository,
+				   "log.excludeDecoration", "exists");
+		free(value);
+	}
+
+	return 0;
+}
+
+static int start_maintenance(void)
+{
+	return run_git("maintenance", "start", NULL);
+}
+
+static int add_enlistment(void)
+{
+	int res;
+
+	if (!the_repository->worktree)
+		die(_("Scalar enlistments require a worktree"));
+
+	res = run_git("config", "--global", "--get", "--fixed-value",
+		      "scalar.repo", the_repository->worktree, NULL);
+
+	/*
+	 * If the setting is already there, then do nothing.
+	 */
+	if (!res)
+		return 0;
+
+	return run_git("config", "--global", "--add",
+		       "scalar.repo", the_repository->worktree, NULL);
+}
+
+static int register_dir(void)
+{
+	int res = add_enlistment();
+
+	if (!res)
+		res = set_recommended_config();
+
+	if (!res)
+		res = start_maintenance();
+
+	return res;
+}
+
+static int cmd_register(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar register [<enlistment>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+	return register_dir();
+}
 
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "register", cmd_register },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 5f7131861a5..568987064b2 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,7 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
-scalar <command> [<options>]
+scalar register [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,22 @@ will be identical to the worktree.
 The `scalar` command implements various subcommands, and different options
 depending on the subcommand.
 
+COMMANDS
+--------
+
+Register
+~~~~~~~~
+
+register [<enlistment>]::
+	Adds the enlistment's repository to the list of registered repositories
+	and starts background maintenance. If `<enlistment>` is not provided,
+	then the enlistment associated with the current working directory is
+	registered.
++
+Note: when this subcommand is called in a worktree that is called `src/`, its
+parent directory is considered to be the Scalar enlistment. If the worktree is
+_not_ called `src/`, it itself will be considered to be the Scalar enlistment.
+
 SEE ALSO
 --------
 linkgit:git-maintenance[1].
-- 
gitgitgadget

