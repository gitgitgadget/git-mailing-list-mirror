Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE14C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhKSXG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhKSXGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2917CC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t30so20574854wra.10
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JfgQPeGK48E/0q8Fkiq5e3N8uuCWy/bAHbpQUBIoNJs=;
        b=Szu2XeM8DNmMMesTLRZPy/19Num6z1rfxroH0RptBwxRPFKb5nwYS0sJqIa7v04H+8
         1EccGydvvUmhlu8slNEU6uDXtJhyy90wo2r2TSgJy2Y2F8li49LddzIY9kmuRoC9uXkB
         EzuJ83dQW7RKb94g90l9uOz5fBtF+kOrkjuDVJUVdCGiO8pqEC5GFWexOLif/t5foqHq
         VEHQnEAGlPmgwclngyU52cFW9+gIO3/B7DOweIb7j8SbP8Ezx2ppLdfSxC9NDeDsWLno
         YKKi7CzXf4aKUIixUvwBFUSNSl3l8m1KI7RWl2jRjiAm/qHA9BMO5dhle4gxq8BvrxyI
         UgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JfgQPeGK48E/0q8Fkiq5e3N8uuCWy/bAHbpQUBIoNJs=;
        b=IoAYLSfAF6WlmM+OBhg+Sfgh4InwECqUd/zRVMtcYUFAHORtnvzqA1Nox22t3b5u5X
         DBGtlZ3YY/5D02GwqAVeDoeHwmJjvixjgBMvqih06lg529PxBPLrhnKXqU5o58vf5iyJ
         OdTVHCrAwEa+xw0Aapa5OpheCfZGFj0QBcE0+8U9TL4zhKcOOqW7XGefcegzwP4y5nJo
         UQYF4eW1BwJ0X3YcogSrPyHotGh3hj+EYS1LXs6z7M6LIhzzUVlt+KtbnHgxmNksElWJ
         z84ShtauefI2/+PqpCxMOv/xczFJ751KtL3wGoaLP6HLuy49VyUD4b5OFPAlYPaSoG18
         nCKg==
X-Gm-Message-State: AOAM5309cfIwFAeuCp4GxFLjnzlDJ3a1qdF9o3rKugHrrRX223Z1TxP+
        61dz1io3KGq20A/QEVkCyGZl6ZqPlr0=
X-Google-Smtp-Source: ABdhPJyypHjzolFMU3S4LNPWxiPNrzSSJ77xhHzqvfGEPQLKmQ3ABpm1GBaSeh75YGAJPeWDpoT2jw==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr12271844wrp.267.1637363030475;
        Fri, 19 Nov 2021 15:03:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm1210624wrs.59.2021.11.19.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:50 -0800 (PST)
Message-Id: <385abdb8d8e4743a16d6a1dc38737322354560d5.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:34 +0000
Subject: [PATCH v8 07/17] scalar: 'register' sets recommended config and
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
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
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
 contrib/scalar/scalar.c   | 249 ++++++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt |  18 ++-
 2 files changed, 266 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7cff29e0fcd..03d5f84c764 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -5,11 +5,260 @@
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
+		strbuf_addstr(&path, "/src");
+		if (is_nonbare_repository_dir(&path)) {
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
+		if (is_nonbare_repository_dir(&path)) {
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
+		{ "fetch.showForcedUpdates", "false" },
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

