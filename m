Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44ABB1FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 16:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeANQtV (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 11:49:21 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46296 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeANQtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 11:49:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id s9so5147992pgq.13
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=svPaua+XixnVWPRGFo8cU5To2ljRt2xGZXnjY+4jZVk=;
        b=ua5O5ZCpd2gjsh0uvTK84KMpngYeSmk6bTar2ZaoiA2jS5DyIanDYaZv1ZT207azZB
         HfYJQxE3+oFG8gVYs2GjyWYzqa13ROtaZZS4dRM+lCso8hiANws8s6ftdA+dqm5cB9CB
         gzdJ1E1a5t2PwCb2X7AxqEaSVa896siRHjSsrha0fV0CqmYsVH49HDlk2gs+qg6EV7Ym
         FIEWkhcluzlwQ185Q2wY9gDLMWa2lCZeuyuGyxnZ/PVuHYUmJ0noo+O7PdVfzzjbejJQ
         UMN5TXlX2DkvyQHaavv9Z9XsyGCQjFqTRJHX+Ru6Psa2J76lAFVkQYDAq0ldszXPL3JL
         i6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=svPaua+XixnVWPRGFo8cU5To2ljRt2xGZXnjY+4jZVk=;
        b=G7cZ8ScYDKj1zrV/0YkWRTlyiG3nX1o2erWxic+238IBH9QQwibt83Deg389S2DoAf
         txYHIERNpvjkuY5LosQsqA0Z1fH6rqjQdimfEzBVWwTATcdEWHfsES8Vi77m2giyNaIB
         r0izxtvl+GF30cp36AuZ5u6buuFq8tSkBoCZvmiFB0jwTZrW8ZNW47JWvw9njRYBLsd0
         2jRJ3Kjnclbc2JFk+cgygKJtW5jXtxWluzdsEewX6aMipmLwXogjh2qKXD6fMKG17r96
         J1cH9vy4Oe6Kc55oH1AlhBJO2sv+milMCBfBdCDwoiVx/3iliJgCzQlAX84510Qj7Ybp
         TPfA==
X-Gm-Message-State: AKGB3mLq3kSAHqIk9R7N6i1WouCe9M6zUQruwkQugsUhOEZjbSpH6kcw
        iGsXIy7FvgSseamOumGaDRbkkQQh
X-Google-Smtp-Source: ACJfBovMNaVZcuveEro8fo41Go9YxacXEXaZTKWO8CLVxYKT4eZbuvZwiBb2p+UQHi2sQVFjY4diWg==
X-Received: by 10.99.112.75 with SMTP id a11mr17980437pgn.47.1515948557400;
        Sun, 14 Jan 2018 08:49:17 -0800 (PST)
Received: from localhost.localdomain ([27.63.154.55])
        by smtp.gmail.com with ESMTPSA id d6sm4799787pfc.35.2018.01.14.08.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jan 2018 08:49:16 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [PATCH v3 1/2] submodule: port submodule subcommand 'sync' from shell to C
Date:   Mon, 15 Jan 2018 02:45:28 +0530
Message-Id: <20180114211529.6391-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180114211529.6391-1-pc44800@gmail.com>
References: <20180111201721.25930-1-pc44800@gmail.com>
 <20180114211529.6391-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Port the submodule subcommand 'sync' from shell to C using the same
mechanism as that used for porting submodule subcommand 'status'.
Hence, here the function cmd_sync() is ported from shell to C.
This is done by introducing four functions: module_sync(),
sync_submodule(), sync_submodule_cb() and print_default_remote().

The function print_default_remote() is introduced for getting
the default remote as stdout.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  57 +------------
 2 files changed, 194 insertions(+), 56 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a5c4a8a69..745d070ea 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -50,6 +50,20 @@ static char *get_default_remote(void)
 	return ret;
 }
 
+static int print_default_remote(int argc, const char **argv, const char *prefix)
+{
+	const char *remote;
+
+	if (argc != 1)
+		die(_("submodule--helper print-default-remote takes no arguments"));
+
+	remote = get_default_remote();
+	if (remote)
+		printf("%s\n", remote);
+
+	return 0;
+}
+
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -358,6 +372,25 @@ static void module_list_active(struct module_list *list)
 	*list = active_modules;
 }
 
+static char *get_up_path(const char *path)
+{
+	int i;
+	struct strbuf sb = STRBUF_INIT;
+
+	for (i = count_slashes(path); i; i--)
+		strbuf_addstr(&sb, "../");
+
+	/*
+	 * Check if 'path' ends with slash or not
+	 * for having the same output for dir/sub_dir
+	 * and dir/sub_dir/
+	 */
+	if (!is_dir_sep(path[strlen(path) - 1]))
+		strbuf_addstr(&sb, "../");
+
+	return strbuf_detach(&sb, NULL);
+}
+
 static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -718,6 +751,164 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct sync_cb {
+	const char *prefix;
+	unsigned int flags;
+};
+
+#define SYNC_CB_INIT { NULL, 0 }
+
+static void sync_submodule(const char *path, const char *prefix,
+			   unsigned int flags)
+{
+	const struct submodule *sub;
+	char *remote_key = NULL;
+	char *sub_origin_url, *super_config_url, *displaypath;
+	struct strbuf sb = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char *sub_config_path = NULL;
+
+	if (!is_submodule_active(the_repository, path))
+		return;
+
+	sub = submodule_from_path(&null_oid, path);
+
+	if (sub && sub->url) {
+		if (starts_with_dot_dot_slash(sub->url) ||
+		    starts_with_dot_slash(sub->url)) {
+			char *remote_url, *up_path;
+			char *remote = get_default_remote();
+			strbuf_addf(&sb, "remote.%s.url", remote);
+
+			if (git_config_get_string(sb.buf, &remote_url))
+				remote_url = xgetcwd();
+
+			up_path = get_up_path(path);
+			sub_origin_url = relative_url(remote_url, sub->url, up_path);
+			super_config_url = relative_url(remote_url, sub->url, NULL);
+
+			free(remote);
+			free(up_path);
+			free(remote_url);
+		} else {
+			sub_origin_url = xstrdup(sub->url);
+			super_config_url = xstrdup(sub->url);
+		}
+	} else {
+		sub_origin_url = xstrdup("");
+		super_config_url = xstrdup("");
+	}
+
+	displaypath = get_submodule_displaypath(path, prefix);
+
+	if (!(flags & OPT_QUIET))
+		printf(_("Synchronizing submodule url for '%s'\n"),
+			 displaypath);
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.url", sub->name);
+	if (git_config_set_gently(sb.buf, super_config_url))
+		die(_("failed to register url for submodule path '%s'"),
+		      displaypath);
+
+	if (!is_submodule_populated_gently(path, NULL))
+		goto cleanup;
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = path;
+	argv_array_pushl(&cp.args, "submodule--helper",
+			 "print-default-remote", NULL);
+
+	strbuf_reset(&sb);
+	if (capture_command(&cp, &sb, 0))
+		die(_("failed to get the default remote for submodule '%s'"),
+		      path);
+
+	strbuf_strip_suffix(&sb, "\n");
+	remote_key = xstrfmt("remote.%s.url", sb.buf);
+
+	strbuf_reset(&sb);
+	submodule_to_gitdir(&sb, path);
+	strbuf_addstr(&sb, "/config");
+
+	if (git_config_set_in_file_gently(sb.buf, remote_key, sub_origin_url))
+		die(_("failed to update remote for submodule '%s'"),
+		      path);
+
+	if (flags & OPT_RECURSIVE) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = path;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_push(&cpr.args, "--super-prefix");
+		argv_array_pushf(&cpr.args, "%s/", displaypath);
+		argv_array_pushl(&cpr.args, "submodule--helper", "sync",
+				 "--recursive", NULL);
+
+		if (flags & OPT_QUIET)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("failed to recurse into submodule '%s'"),
+			      path);
+	}
+
+cleanup:
+	free(super_config_url);
+	free(sub_origin_url);
+	strbuf_release(&sb);
+	free(remote_key);
+	free(displaypath);
+	free(sub_config_path);
+}
+
+static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data)
+{
+	struct sync_cb *info = cb_data;
+	sync_submodule(list_item->name, info->prefix, info->flags);
+
+}
+
+static int module_sync(int argc, const char **argv, const char *prefix)
+{
+	struct sync_cb info = SYNC_CB_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int recursive = 0;
+
+	struct option module_sync_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output of synchronizing submodule url")),
+		OPT_BOOL(0, "recursive", &recursive,
+			N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_sync_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	info.prefix = prefix;
+	if (quiet)
+		info.flags |= OPT_QUIET;
+	if (recursive)
+		info.flags |= OPT_RECURSIVE;
+
+	for_each_listed_submodule(&list, sync_submodule_cb, &info);
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1498,6 +1689,8 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
+	{"print-default-remote", print_default_remote, 0},
+	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 156255a9e..0825cae14 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1036,63 +1036,8 @@ cmd_sync()
 			;;
 		esac
 	done
-	cd_to_toplevel
-	{
-		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
 
-		# skip inactive submodules
-		if ! git submodule--helper is-active "$sm_path"
-		then
-			continue
-		fi
-
-		name=$(git submodule--helper name "$sm_path")
-		url=$(git config -f .gitmodules --get submodule."$name".url)
-
-		# Possibly a url relative to parent
-		case "$url" in
-		./*|../*)
-			# rewrite foo/bar as ../.. to find path from
-			# submodule work tree to superproject work tree
-			up_path="$(printf '%s\n' "$sm_path" | sed "s/[^/][^/]*/../g")" &&
-			# guarantee a trailing /
-			up_path=${up_path%/}/ &&
-			# path from submodule work tree to submodule origin repo
-			sub_origin_url=$(git submodule--helper resolve-relative-url "$url" "$up_path") &&
-			# path from superproject work tree to submodule origin repo
-			super_config_url=$(git submodule--helper resolve-relative-url "$url") || exit
-			;;
-		*)
-			sub_origin_url="$url"
-			super_config_url="$url"
-			;;
-		esac
-
-		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-		say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-		git config submodule."$name".url "$super_config_url"
-
-		if test -e "$sm_path"/.git
-		then
-		(
-			sanitize_submodule_env
-			cd "$sm_path"
-			remote=$(get_default_remote)
-			git config remote."$remote".url "$sub_origin_url"
-
-			if test -n "$recursive"
-			then
-				prefix="$prefix$sm_path/"
-				eval cmd_sync
-			fi
-		)
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 }
 
 cmd_absorbgitdirs()
-- 
2.15.1

