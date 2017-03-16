Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A7720953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbdCPWg6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:36:58 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36005 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbdCPWgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:36:52 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so31571548pge.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2uYfNPIYJfp/ywvBBgB5VGksc/esePyG/ekF/ugfiYk=;
        b=P1UhnRJcfaiAzYRDHn3DeJMF7JW8jr4r/RIzMG+O0OjKaB3un2GAeQycPbjLLSfnLT
         DyjVbl7UHbo/yoi4G29OZOVQPtyHCJLA+Hq7pNmv5ua1nEdWD+DGbVXdsC4xWU0aq3qp
         SgGmx4RnZeB0kFSi3dKRgxm8dJSuyfoxkYXVC6rBlUat4wvLO2PImp80qw1UDZQrUhFO
         3fpPZROKsGiGhG2nycPtDrcoWb7k/gYS5OmobqGnZOYGBwcSFL4ZJFuUpS/FLG/E1KpO
         T9bZN5m0xRwrkNRozoek30SXS/QmDZLWzwaO+1m9XBPIXrY8r1iLX0v2FJb/ju71jjiB
         2cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2uYfNPIYJfp/ywvBBgB5VGksc/esePyG/ekF/ugfiYk=;
        b=lmRUKLFKbUTFeONqeVfuvDa4eCUrCF2Zow3HDvCR+hm8WZUOWbzMWV2LVnn1auXsV3
         YeSxyzlsKE2fxXNgF6UTbYiUCk9xwV6q6RV0drCeYD9m7myu8mowBkmLHfjUQ6YaYA+2
         vuh/9z+F9ipWp6Z1tmVJ5CLe9kh119c8fbFlnbPFh7B8ys7n8cBzC8e2+ocmLJ5TSBZb
         Gj6ed7pExVqbNh/3SoiIjiXWTA9M8a3tFgy6dZ0fWbif53UEOVrYQColScR7FTWScs94
         A/H9mVqMd6fREUzk2B2D1eutFkN540s9jewC+qAhDNNJruWa4G0KADdsuRGa0yBNffxA
         5I7A==
X-Gm-Message-State: AFeK/H23xpFyfX5BStUDZXdOBfmXKGO5Iw0qeSTyjhV2BQ+fihxH/UpA8/qImCxoAuXsHtiA
X-Received: by 10.99.65.67 with SMTP id o64mr12561404pga.119.1489703398728;
        Thu, 16 Mar 2017 15:29:58 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:29:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 00/10] decoupling url and submodule interest
Date:   Thu, 16 Mar 2017 15:29:42 -0700
Message-Id: <20170316222952.53801-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lots of changes in v4 to address comments by Junio, Ramsay, and Stefan.
  * Overhaul a lot of the commit messages (thanks Junio for helping wordsmith)
  * Change how submodule.active functions with `submodule init` and clone
    --recurse-submodules.  This allowed me to not have to add additional
    command line options resulting in what I think is less cluttered UI from
    the last version.  See patch 7 and 8 for more detail.
  * Fixed an incorrect parameter type in patch 6 (thanks Ramsay).

Brandon Williams (10):
  submodule--helper: add is-active subcommand
  submodule status: use submodule--helper is-active
  submodule sync: skip work for inactive submodules
  submodule sync: use submodule--helper is-active
  submodule--helper clone: check for configured submodules using helper
  submodule: decouple url and submodule interest
  submodule init: initialize active submodules
  clone: teach --recurse-submodules to optionally take a pathspec
  submodule--helper init: set submodule.<name>.active
  submodule add: respect submodule.active and submodule.<name>.active

 Documentation/config.txt        |  15 ++++-
 Documentation/git-clone.txt     |  14 +++--
 Documentation/git-submodule.txt |   4 +-
 builtin/clone.c                 |  47 +++++++++++---
 builtin/submodule--helper.c     |  69 ++++++++++++++++----
 git-submodule.sh                |  53 ++++++++++------
 submodule.c                     |  50 ++++++++++++---
 t/t7400-submodule-basic.sh      | 136 ++++++++++++++++++++++++++++++++++++++++
 t/t7413-submodule-is-active.sh  | 107 +++++++++++++++++++++++++++++++
 9 files changed, 440 insertions(+), 55 deletions(-)
 create mode 100755 t/t7413-submodule-is-active.sh

---interdiff with 'origin/bw/submodule-is-active'

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9692eab30..30052cce4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,9 +14,8 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
-	  [--submodule-spec <pathspec>] [--jobs <n>] [--]
-	  <repository> [<directory>]
+	  [--recurse-submodules] [--[no-]shallow-submodules]
+	  [--jobs <n>] [--] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -216,22 +215,18 @@ objects from the source repository into a pack in the cloned repository.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
---recursive::
---recurse-submodules::
-	After the clone is created, initialize and clone all submodules
-	within, using their default settings. This is equivalent to
-	running `git submodule update --recursive --init` immediately
-	after the clone is finished. This option is ignored if the
-	cloned repository does not have a worktree/checkout (i.e.  if
-	any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
-
---submodule-spec::
-	After the clone is created, initialize and clone specified
-	submodules within, using their default settings. It is possible
-	to give multiple specifications by giving this argument multiple
-	times. This is equivalent to configuring `submodule.active`
-	and then running `git submodule update --init-active`
-	immediately after the clone is finished.
+--recurse-submodules[=<pathspec]::
+	After the clone is created, initialize and clone submodules
+	within based on the provided pathspec.  If no pathspec is
+	provided, all submodules are initialized and cloned.
+	Submodules are initialized and cloned using their default
+	settings.  The resulting clone has `submodule.active` set to
+	the provided pathspec, or "." (meaning all submodules) if no
+	pathspec is provided.  This is equivalent to running
+	`git submodule update --init --recursive` immediately after
+	the clone is finished. This option is ignored if the cloned
+	repository does not have a worktree/checkout (i.e. if any of
+	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 6b17cd707..74bc6200d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -129,7 +129,9 @@ init [--] [<path>...]::
 	repository will be assumed to be upstream.
 +
 Optional <path> arguments limit which submodules will be initialized.
-If no path is specified, all submodules are initialized.
+If no path is specified and submodule.active has been configured, submodules
+configured to be active will be initialized, otherwise all submodules are
+initialized.
 +
 When present, it will also copy the value of `submodule.$name.update`.
 This command does not alter existing information in .git/config.
@@ -198,10 +200,6 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
-You can configure a set of submodules using pathspec syntax in
-submodule.active you can use `--init-active` to initialize
-those before updating.
-
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -388,11 +386,6 @@ the submodule itself.
 	Initialize all submodules for which "git submodule init" has not been
 	called so far before updating.
 
---init-active::
-	This option is only valid for the update command.
-	Initialize all submodules configured in "`submodule.active`"
-	that have not been updated before.
-
 --name::
 	This option is only valid for the add command. It sets the submodule's
 	name to the given string instead of defaulting to its path. The name
diff --git a/builtin/clone.c b/builtin/clone.c
index c6731379b..3dc8faac5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -39,7 +39,7 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
-static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
+static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
@@ -56,14 +56,20 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
-static struct string_list submodule_spec;
+static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 
-static int submodule_spec_cb(const struct option *opt, const char *arg, int unset)
+static int recurse_submodules_cb(const struct option *opt,
+				 const char *arg, int unset)
 {
 	if (unset)
 		return -1;
 
-	string_list_append((struct string_list *)opt->value, arg);
+	if (arg)
+		string_list_append((struct string_list *)opt->value, arg);
+	else
+		string_list_append((struct string_list *)opt->value,
+				   (const char *)opt->defval);
+
 	return 0;
 }
 
@@ -84,10 +90,13 @@ static struct option builtin_clone_options[] = {
 		    N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
 		    N_("setup as shared repository")),
-	OPT_BOOL(0, "recursive", &option_recursive,
-		    N_("initialize submodules in the clone")),
-	OPT_BOOL(0, "recurse-submodules", &option_recursive,
-		    N_("initialize submodules in the clone")),
+	{ OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
+	  N_("pathspec"), N_("initialize submodules in the clone"),
+	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
+	  (intptr_t)"." },
+	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
+	  N_("pathspec"), N_("initialize submodules in the clone"),
+	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
 	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
@@ -122,9 +131,6 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
-	OPT_CALLBACK(0, "submodule-spec", &submodule_spec, N_("<pathspec>"),
-			N_("clone specific submodules. Pass multiple times for complex pathspecs"),
-			submodule_spec_cb),
 	OPT_END()
 };
 
@@ -746,21 +752,13 @@ static int checkout(int submodule_progress)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && (option_recursive || submodule_spec.nr > 0)) {
+	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", NULL);
-
-		if (submodule_spec.nr > 0)
-			argv_array_pushf(&args, "--init-active");
-		else
-			argv_array_pushf(&args, "--init");
+		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
 		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
 
-		if (option_recursive)
-			argv_array_pushf(&args, "--recursive");
-
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
@@ -908,17 +906,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (submodule_spec.nr > 0) {
-		struct string_list_item *item;
-		struct strbuf sb = STRBUF_INIT;
-		for_each_string_list_item(item, &submodule_spec) {
-			strbuf_addf(&sb, "submodule.active=%s",
-				    item->string);
-			string_list_append(&option_config,
-					   strbuf_detach(&sb, NULL));
-		}
-	}
-
 	if (!option_origin)
 		option_origin = "origin";
 
@@ -989,7 +976,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
 
-	if (option_recursive) {
+	if (option_recurse_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+
+		/* remove duplicates */
+		string_list_sort(&option_recurse_submodules);
+		string_list_remove_duplicates(&option_recurse_submodules, 0);
+
+		for_each_string_list_item(item, &option_recurse_submodules) {
+			strbuf_addf(&sb, "submodule.active=%s",
+				    item->string);
+			string_list_append(&option_config,
+					   strbuf_detach(&sb, NULL));
+		}
+
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b669ed031..a574596cb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -437,12 +437,9 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int active = 0;
 	int i;
 
 	struct option module_init_options[] = {
-		OPT_BOOL(0, "active", &active,
-			 N_("ensure all active submodules are properly initialized")),
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
 		OPT_END()
 	};
@@ -455,7 +452,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
-	if (active)
+	/*
+	 * If there are no path args and submodule.active is set then,
+	 * by default, only initialize 'active' modules.
+	 */
+	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 	else if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index eb13433d5..fc32286a4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1212,7 +1212,6 @@ _git_clone ()
 			--recurse-submodules
 			--no-single-branch
 			--shallow-submodules
-			--submodule-spec
 			"
 		return
 		;;
diff --git a/git-submodule.sh b/git-submodule.sh
index 2c510038d..6eca93416 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init[-active]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
@@ -285,10 +285,10 @@ or you are unsure what this means choose another name with the '--name' option."
 		# current configured pathspec, set the submodule's active flag
 		if ! git submodule--helper is-active "$sm_path"
 		then
-			git config --add submodule."$sm_name".active "true"
+			git config submodule."$sm_name".active "true"
 		fi
 	else
-		git config --add submodule."$sm_name".active "true"
+		git config submodule."$sm_name".active "true"
 	fi
 }
 
@@ -375,9 +375,6 @@ cmd_init()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		--active)
-			GIT_ACTIVE=1
-			;;
 		--)
 			shift
 			break
@@ -392,7 +389,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} ${GIT_ACTIVE:+--active} "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet}  "$@"
 }
 
 #
@@ -521,12 +518,7 @@ cmd_update()
 			progress="--progress"
 			;;
 		-i|--init)
-			test -z $init || test $init = by_args || die "$(gettext "Only one of --init or --init-active may be used.")"
-			init=by_args
-			;;
-		--init-active)
-			test -z $init || test $init = by_config || die "$(gettext "Only one of --init or --init-active may be used.")"
-			init=by_config
+			init=1
 			;;
 		--remote)
 			remote=1
@@ -595,17 +587,7 @@ cmd_update()
 
 	if test -n "$init"
 	then
-		if test "$init" = "by_config"
-		then
-			if test $# -gt 0
-			then
-				die "$(gettext "path arguments are incompatible with --init-active")"
-			fi
-			cmd_init "--active" || return
-		else
-			cmd_init "--" "$@" || return
-		fi
-
+		cmd_init "--" "$@" || return
 	fi
 
 	{
@@ -1119,6 +1101,13 @@ cmd_sync()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode" "$sha1"
+
+		# skip inactive submodules
+		if ! git submodule--helper is-active "$sm_path"
+		then
+			continue
+		fi
+
 		name=$(git submodule--helper name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
@@ -1141,27 +1130,24 @@ cmd_sync()
 			;;
 		esac
 
-		if git submodule--helper is-active "$sm_path"
+		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
+		say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
+		git config submodule."$name".url "$super_config_url"
+
+		if test -e "$sm_path"/.git
 		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-			git config submodule."$name".url "$super_config_url"
+		(
+			sanitize_submodule_env
+			cd "$sm_path"
+			remote=$(get_default_remote)
+			git config remote."$remote".url "$sub_origin_url"
 
-			if test -e "$sm_path"/.git
+			if test -n "$recursive"
 			then
-			(
-				sanitize_submodule_env
-				cd "$sm_path"
-				remote=$(get_default_remote)
-				git config remote."$remote".url "$sub_origin_url"
-
-				if test -n "$recursive"
-				then
-					prefix="$prefix$sm_path/"
-					eval cmd_sync
-				fi
-			)
+				prefix="$prefix$sm_path/"
+				eval cmd_sync
 			fi
+		)
 		fi
 	done
 }
diff --git a/submodule.c b/submodule.c
index 2b33bd70f..ad2779ee7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -212,12 +212,19 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
 }
 
 /*
+ * NEEDSWORK: With the addition of different configuration options to determine
+ * if a submodule is of interests, the validity of this function's name comes
+ * into question.  Once the dust has settled and more concrete terminology is
+ * decided upon, come up with a more proper name for this function.  One
+ * potential candidate could be 'is_submodule_active()'.
+ *
  * Determine if a submodule has been initialized at a given 'path'
  */
 int is_submodule_initialized(const char *path)
 {
 	int ret = 0;
-	char *key;
+	char *key = NULL;
+	char *value = NULL;
 	const struct string_list *sl;
 	const struct submodule *module = submodule_from_path(null_sha1, path);
 
@@ -233,8 +240,8 @@ int is_submodule_initialized(const char *path)
 	}
 	free(key);
 
+	/* submodule.active is set */
 	sl = git_config_get_value_multi("submodule.active");
-
 	if (sl) {
 		struct pathspec ps;
 		struct argv_array args = ARGV_ARRAY_INIT;
@@ -244,21 +251,20 @@ int is_submodule_initialized(const char *path)
 			argv_array_push(&args, item->string);
 		}
 
-		parse_pathspec(&ps, 0, 0, 0, args.argv);
+		parse_pathspec(&ps, 0, 0, NULL, args.argv);
 		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
 
 		argv_array_clear(&args);
 		clear_pathspec(&ps);
-	} else {
-		char *value = NULL;
-		key = xstrfmt("submodule.%s.url", module->name);
-
-		ret = !git_config_get_string(key, &value);
-
-		free(value);
-		free(key);
+		return ret;
 	}
 
+	/* fallback to checking if the URL is set */
+	key = xstrfmt("submodule.%s.url", module->name);
+	ret = !git_config_get_string(key, &value);
+
+	free(value);
+	free(key);
 	return ret;
 }
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c2e198a92..cf77a3a35 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1158,19 +1158,18 @@ test_expect_success 'submodule update --init with a specification' '
 	test_cmp expect actual
 '
 
-test_expect_success 'submodule update --init-active' '
+test_expect_success 'submodule update --init with submodule.active set' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	pwd=$(pwd) &&
 	git clone file://"$pwd"/multisuper multisuper_clone &&
 	git -C multisuper_clone config submodule.active "." &&
 	git -C multisuper_clone config --add submodule.active ":(exclude)sub0" &&
-	git -C multisuper_clone submodule update --init-active &&
+	git -C multisuper_clone submodule update --init &&
 	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
-	test_must_fail git -C multisuper_clone submodule update --init-active sub0 &&
 	test_cmp expect actual
 '
 
-test_expect_success 'submodule init --active and update' '
+test_expect_success 'submodule update and setting submodule.<name>.active' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	pwd=$(pwd) &&
 	git clone file://"$pwd"/multisuper multisuper_clone &&
@@ -1189,7 +1188,7 @@ test_expect_success 'submodule init --active and update' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone --submodule-spec works' '
+test_expect_success 'clone --recurse-submodules with a pathspec works' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	cat >expected <<-\EOF &&
 	 sub0 (test2)
@@ -1198,12 +1197,12 @@ test_expect_success 'clone --submodule-spec works' '
 	-sub3
 	EOF
 
-	git clone --recurse-submodules --submodule-spec="sub0" multisuper multisuper_clone &&
+	git clone --recurse-submodules="sub0" multisuper multisuper_clone &&
 	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
 	test_cmp actual expected
 '
 
-test_expect_success 'clone with multiple --submodule-spec options' '
+test_expect_success 'clone with multiple --recurse-submodules options' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	cat >expect <<-\EOF &&
 	-sub0
@@ -1212,10 +1211,9 @@ test_expect_success 'clone with multiple --submodule-spec options' '
 	 sub3 (test2)
 	EOF
 
-	git clone --recurse-submodules \
-		  --submodule-spec="." \
-		  --submodule-spec ":(exclude)sub0" \
-		  --submodule-spec ":(exclude)sub2" \
+	git clone --recurse-submodules="." \
+		  --recurse-submodules=":(exclude)sub0" \
+		  --recurse-submodules=":(exclude)sub2" \
 		  multisuper multisuper_clone &&
 	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
 	test_cmp expect actual
@@ -1239,11 +1237,10 @@ test_expect_success 'clone and subsequent updates correctly auto-initialize subm
 	 sub5 (test2)
 	EOF
 
-	git clone --recurse-submodules \
-		  --submodule-spec="." \
-		  --submodule-spec ":(exclude)sub0" \
-		  --submodule-spec ":(exclude)sub2" \
-		  --submodule-spec ":(exclude)sub4" \
+	git clone --recurse-submodules="." \
+		  --recurse-submodules=":(exclude)sub0" \
+		  --recurse-submodules=":(exclude)sub2" \
+		  --recurse-submodules=":(exclude)sub4" \
 		  multisuper multisuper_clone &&
 
 	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
@@ -1254,9 +1251,20 @@ test_expect_success 'clone and subsequent updates correctly auto-initialize subm
 	git -C multisuper commit -m "add more submodules" &&
 	# obtain the new superproject
 	git -C multisuper_clone pull &&
-	git -C multisuper_clone submodule update --init-active &&
+	git -C multisuper_clone submodule update --init &&
 	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
 	test_cmp expect2 actual
 '
 
+test_expect_success 'init properly sets the config' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules="." \
+		  --recurse-submodules=":(exclude)sub0" \
+		  multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule init -- sub0 sub1 &&
+	git -C multisuper_clone config --get submodule.sub0.active &&
+	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
+'
+
 test_done
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 865931978..9c785b07e 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -35,58 +35,58 @@ test_expect_success 'is-active works with urls' '
 '
 
 test_expect_success 'is-active works with submodule.<name>.active config' '
+	test_when_finished "git -C super config --unset submodule.sub1.active" &&
+	test_when_finished "git -C super config submodule.sub1.URL ../sub" &&
+
 	git -C super config --bool submodule.sub1.active "false" &&
 	test_must_fail git -C super submodule--helper is-active sub1 &&
 
 	git -C super config --bool submodule.sub1.active "true" &&
 	git -C super config --unset submodule.sub1.URL &&
-	git -C super submodule--helper is-active sub1 &&
-
-	git -C super config submodule.sub1.URL ../sub &&
-	git -C super config --unset submodule.sub1.active
+	git -C super submodule--helper is-active sub1
 '
 
 test_expect_success 'is-active works with basic submodule.active config' '
+	test_when_finished "git -C super config submodule.sub1.URL ../sub" &&
+	test_when_finished "git -C super config --unset-all submodule.active" &&
+
 	git -C super config --add submodule.active "." &&
 	git -C super config --unset submodule.sub1.URL &&
 
 	git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2 &&
-
-	git -C super config submodule.sub1.URL ../sub &&
-	git -C super config --unset-all submodule.active
+	git -C super submodule--helper is-active sub2
 '
 
 test_expect_success 'is-active correctly works with paths that are not submodules' '
-	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+	test_when_finished "git -C super config --unset-all submodule.active" &&
 
-	git -C super config --add submodule.active "." &&
 	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
 
-	git -C super config --unset-all submodule.active
+	git -C super config --add submodule.active "." &&
+	test_must_fail git -C super submodule--helper is-active not-a-submodule
 '
 
 test_expect_success 'is-active works with exclusions in submodule.active config' '
+	test_when_finished "git -C super config --unset-all submodule.active" &&
+
 	git -C super config --add submodule.active "." &&
 	git -C super config --add submodule.active ":(exclude)sub1" &&
 
 	test_must_fail git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2 &&
-
-	git -C super config --unset-all submodule.active
+	git -C super submodule--helper is-active sub2
 '
 
 test_expect_success 'is-active with submodule.active and submodule.<name>.active' '
+	test_when_finished "git -C super config --unset-all submodule.active" &&
+	test_when_finished "git -C super config --unset submodule.sub1.active" &&
+	test_when_finished "git -C super config --unset submodule.sub2.active" &&
+
 	git -C super config --add submodule.active "sub1" &&
 	git -C super config --bool submodule.sub1.active "false" &&
 	git -C super config --bool submodule.sub2.active "true" &&
 
 	test_must_fail git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2 &&
-
-	git -C super config --unset-all submodule.active &&
-	git -C super config --unset submodule.sub1.active &&
-	git -C super config --unset submodule.sub2.active
+	git -C super submodule--helper is-active sub2
 '
 
 test_expect_success 'is-active, submodule.active and submodule add' '

-- 
2.12.0.367.g23dc2f6d3c-goog

