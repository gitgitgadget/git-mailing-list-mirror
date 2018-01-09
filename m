Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA0C1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755784AbeAISBU (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:01:20 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41976 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeAISBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:01:19 -0500
Received: by mail-pg0-f65.google.com with SMTP id m17so6136103pgd.8
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yD7/UlunQsv74kwdsqe0ISf5moC1uiBH59tHbhXrQHU=;
        b=erDbpIhySX14iwlOsEzuqeJXfxN4izuw36trsgornfkBepDPyX5HQv9qBjwF5Ru19e
         pmNzbVak57vU9cxRGUhpy48odDCAZjhhBujuizNSC0fq2qu9B+yvdTsoWEdoAFSg3PbK
         1tK8Xf1SS5OkuTh7Lk4LvRD9y9FsXcW91UV1ovcyHOOLEcPXjhsMYouZzdx2U28dVV9L
         G5nAp0BZAQKODda8BlK6yfLEAVJ/T74012hplz4Yo1KDyYPfNBDs0Eh9wlW3XywIRM2q
         ELC8c1VzUgIUE8p3s9aVlb5OgOSk2/C9PD1gKAlss0Ti4MlctfD7Fw0GTWbKj+MFUueQ
         bEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yD7/UlunQsv74kwdsqe0ISf5moC1uiBH59tHbhXrQHU=;
        b=el0WL2A0jTqSfWqhhOTJUKp/sbLcxkYKyGsPhkF2xgiuCOOCWmp4jS/vbOBfPThHi0
         mEsSIafFbvO2q+OWk7vjcvC+yAPVzCkkmSM+pI3teR7+cRtYqzbY9UtQVjByTzAA/UiP
         l8db53jd9d39t369hEohRuQvwb7Lns5hTCW1QmQw3HNS/n9thKEucHQY5mfFdY1wfMtC
         IVh7FiXEWsSbCbjdBz/p2f6Spqhltd2CZVh0vY8jx6zLdOt4eIRjLcl/I9B5TxCTWCVF
         LFdpBFRM9v5iUjKqWrBU0mHDr+++WxMsDQB7jlSlnYYuf4HPaCAgOnpCzO3gQtNaQ0d3
         1CuA==
X-Gm-Message-State: AKGB3mLZUboz5NTZzldTImaSr81TMlIahPT96tOsKqkZsDUngejkz8J7
        lROCcWRnZnAOt26hcLjFYUJdWs8t
X-Google-Smtp-Source: ACJfBotycN4SCKQZiGGUYut0J6k4uzJa0wq8fxe4ee1RujWjuT+uJ7s8bBqCNdFuwE7kQIFClFceiA==
X-Received: by 10.99.0.17 with SMTP id 17mr12923254pga.149.1515520878222;
        Tue, 09 Jan 2018 10:01:18 -0800 (PST)
Received: from localhost.localdomain ([223.176.44.24])
        by smtp.gmail.com with ESMTPSA id z85sm2582446pfk.110.2018.01.09.10.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 10:01:17 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 1/2] submodule: port submodule subcommand 'sync' from shell to C
Date:   Tue,  9 Jan 2018 23:27:02 +0530
Message-Id: <20180109175703.4793-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180109175703.4793-1-pc44800@gmail.com>
References: <20180109175703.4793-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 192 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  57 +------------
 2 files changed, 193 insertions(+), 56 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a5c4a8a69..dd7737acd 100644
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
@@ -718,6 +751,163 @@ static int module_name(int argc, const char **argv, const char *prefix)
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
+		if (starts_with_dot_dot_slash(sub->url) || starts_with_dot_slash(sub->url)) {
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
+		sub_origin_url = "";
+		super_config_url = "";
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
+	strbuf_release(&sb);
+	free(remote_key);
+	free(super_config_url);
+	free(displaypath);
+	free(sub_config_path);
+	free(sub_origin_url);
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
@@ -1498,6 +1688,8 @@ static struct cmd_struct commands[] = {
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
2.14.2

