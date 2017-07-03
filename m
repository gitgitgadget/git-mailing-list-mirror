Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF23E201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 20:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbdGCUc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:32:57 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36728 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCUcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:32:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so24101627pgn.3
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zTO3zgqULWOlTX+3v+ebto3F42ESRdK6nw1TBuYFsc8=;
        b=cjI2HL9XshXBhE8Av1oK5/fbSPErjf3sw8lBAWFAH1OtKRkt70zmPKfcUR4J9ahDrB
         rWzTas1jR0UG5/YzcjAXzBslaD+pdE1vXCZoUfMM7l/9b4jsnkhyiNseipTC4DK9E+vj
         rc+rge2eLHh9Yluec+K0UfgUg8L/h36omIJUiwevAFMkVx/o1ePqSG4zIf1dI5PjIi28
         IcC7iIVI7TCNE8ofUvjxfqKElEajV3LjBAmksE13OSbDhsq4qT5d1QD445NjnjtrGOn+
         GQJf7gr/XAneqP+gVKE6h3ZPqb5wO1TV6vbqoP+hHkLXZlFmB1uCV7AV4kvKtniEsCWq
         D2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zTO3zgqULWOlTX+3v+ebto3F42ESRdK6nw1TBuYFsc8=;
        b=sRxg9JJWoeBGC/JN8gwea4uq+mlrg25Ostbk17jrqTzqcIpet1t/0vTxJjA80IGo34
         idIbqobtmLIeNJsFbQUaJZUIetnyIk1z4YwsAXY7gSnWPsGCkk4shjy0o27CNFKkUhHf
         BLvN9Gzs8ksyxzcKwTyTKm4T+VMWaKfRjZt323xZejgxCmPFUQQA+JKuZZCqZUFJj5JQ
         ZnrCLZeRXc491tB47fhTRxeQ2uKiy04rFqehYNjGFDAjQ9B+7URLweOTXtjou9xKsTmZ
         IkHlrYa3OGh+SXe/0xNOP3GXJ2vzsOlZexRFmG8+QyaUmGPvAVE8t4Q2y5+USsT4noci
         jNdQ==
X-Gm-Message-State: AIVw111yd9uitjfu9cT1ScrggpUMdo0peLY7yxXFaPaYRJ2D3NS+sakg
        ADzRXbyGwaPa7x8h
X-Received: by 10.101.70.193 with SMTP id n1mr12177490pgr.249.1499113973101;
        Mon, 03 Jul 2017 13:32:53 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id y192sm28558594pgd.38.2017.07.03.13.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 13:32:52 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 5/5 v4] submodule: port submodule subcommand 'sync' from shell to C
Date:   Tue,  4 Jul 2017 02:02:22 +0530
Message-Id: <20170703203222.14051-5-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170703203222.14051-1-pc44800@gmail.com>
References: <CAME+mvVRSovmXLDUzz8dNiruvLrXFv3iUifqXDm+HwQDu1mJpQ@mail.gmail.com>
 <20170703203222.14051-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Port the submodule subcommand 'sync' from shell to C using the same
mechanism as that used for porting submodule subcommand 'status'.
Hence, here the function cmd_sync() is ported from shell to C.
This is done by introducing three functions: module_sync(),
sync_submodule() and print_default_remote().

The function print_default_remote() is introduced for getting
the default remote as stdout.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 181 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  56 +-------------
 2 files changed, 181 insertions(+), 56 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d67a97062..f28391634 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -44,6 +44,20 @@ static char *get_default_remote(void)
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
+		puts(remote);
+
+	return 0;
+}
+
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -379,6 +393,25 @@ static void module_list_active(struct module_list *list)
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
@@ -478,16 +511,18 @@ static void init_submodule(const struct cache_entry *list_item, void *cb_data)
 			char *remote = get_default_remote();
 			struct strbuf remotesb = STRBUF_INIT;
 			strbuf_addf(&remotesb, "remote.%s.url", remote);
-			free(remote);
 
 			if (git_config_get_string(remotesb.buf, &remoteurl)) {
 				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
 				remoteurl = xgetcwd();
 			}
 			relurl = relative_url(remoteurl, url, NULL);
+
+			free(remote);
 			strbuf_release(&remotesb);
 			free(remoteurl);
 			free(url);
+
 			url = relurl;
 		}
 
@@ -732,6 +767,148 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct sync_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+};
+#define SYNC_CB_INIT { NULL, 0, 0 }
+
+static void sync_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct sync_cb *info = cb_data;
+	const struct submodule *sub;
+	char *sub_key, *remote_key;
+	char *sub_origin_url, *super_config_url, *displaypath;
+	struct strbuf sb = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	if (!is_submodule_initialized(list_item->name))
+		return;
+
+	sub = submodule_from_path(null_sha1, list_item->name);
+
+	if (!sub || !sub->url)
+		die(_("no url found for submodule path '%s' in .gitmodules"),
+		      list_item->name);
+
+	if (starts_with_dot_dot_slash(sub->url) || starts_with_dot_slash(sub->url)) {
+		char *remote_url, *up_path;
+		char *remote = get_default_remote();
+		char *remote_key = xstrfmt("remote.%s.url", remote);
+		free(remote);
+
+		if (git_config_get_string(remote_key, &remote_url))
+			remote_url = xgetcwd();
+		up_path = get_up_path(list_item->name);
+		sub_origin_url = relative_url(remote_url, sub->url, up_path);
+		super_config_url = relative_url(remote_url, sub->url, NULL);
+		free(remote_key);
+		free(up_path);
+		free(remote_url);
+	} else {
+		sub_origin_url = xstrdup(sub->url);
+		super_config_url = xstrdup(sub->url);
+	}
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (!info->quiet)
+		printf(_("Synchronizing submodule url for '%s'\n"),
+			 displaypath);
+
+	sub_key = xstrfmt("submodule.%s.url", sub->name);
+	if (git_config_set_gently(sub_key, super_config_url))
+		die(_("failed to register url for submodule path '%s'"),
+		      displaypath);
+
+	if (!is_submodule_populated_gently(list_item->name, NULL))
+		goto cleanup;
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = list_item->name;
+	argv_array_pushl(&cp.args, "submodule--helper",
+			 "print-default-remote", NULL);
+	if (capture_command(&cp, &sb, 0))
+		die(_("failed to get the default remote for submodule '%s'"),
+		      list_item->name);
+
+	strbuf_strip_suffix(&sb, "\n");
+	remote_key = xstrfmt("remote.%s.url", sb.buf);
+	strbuf_release(&sb);
+
+	child_process_init(&cp);
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = list_item->name;
+	argv_array_pushl(&cp.args, "config", remote_key, sub_origin_url, NULL);
+	if (run_command(&cp))
+		die(_("failed to update remote for submodule '%s'"),
+		      list_item->name);
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
+				 "submodule--helper", "sync", "--recursive",
+				 NULL);
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("failed to recurse into submodule '%s'"),
+			      list_item->name);
+	}
+
+cleanup:
+	free(sub_key);
+	free(super_config_url);
+	free(displaypath);
+	free(sub_origin_url);
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
+	info.quiet = !!quiet;
+	info.recursive = !!recursive;
+
+	gitmodules_config();
+	for_each_submodule_list(list, sync_submodule, &info);
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1460,6 +1637,8 @@ static struct cmd_struct commands[] = {
 	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
+	{"print-default-remote", print_default_remote, 0},
+	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 51b057d82..6bfc5e17d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1037,63 +1037,9 @@ cmd_sync()
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
-
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
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 
-			if test -n "$recursive"
-			then
-				prefix="$prefix$sm_path/"
-				eval cmd_sync
-			fi
-		)
-		fi
-	done
 }
 
 cmd_absorbgitdirs()
-- 
2.13.0

