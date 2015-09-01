From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/3] submodule--helper: Have some refactoring only patches first
Date: Tue,  1 Sep 2015 11:24:26 -0700
Message-ID: <1441131869-29474-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: sbeller@google.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Sep 01 20:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqEj-0005t9-Q8
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbbIASYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:24:45 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34516 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbbIASYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:24:44 -0400
Received: by padhy1 with SMTP id hy1so3701732pad.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=g0s75MW0bEE4MdjikH4jJBjZ05HT9DmErSbRQRuUSr4=;
        b=oM9F7VCT0DrjFs9V+HA29Ez+EkwORGvdhL/fEVZou7qGeSsMCVCAh/VWjXucHH5xrO
         A8g0AkvcVsHi1tZ+yth/3qlyrTXSkQKd0Le5YybUXh30LaiOVcU2S2mDD+ASmjzQdTqw
         1/AlLnkbBtHQAXnZwfbsIpnryLU+b9Grre9zIA8FVBmX3vkIYP6MRoZZFh5mGA4ALlhd
         c9Rlar5u7PS9Fp7o0vQpx3ZuQTijVKqvIM8KB4jpQvks0s31E8sH+LrcWt3MxF/R0flS
         hla6uEWl647r1qS9MJA0+5s1HpmgG0O6Mu/rMXc+bP9wWQ6rSBrRkOiTEpwpEmNDs7PP
         i0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g0s75MW0bEE4MdjikH4jJBjZ05HT9DmErSbRQRuUSr4=;
        b=OLGIQmGSvlQAMbFaBeF6nGRAEv7CFq5MIIbEacJoRcWpHzV0S1/6zzNgLUvqoTc8+s
         oyJWoGaz3KgCLJygYzk+mF1QSFcPzTXmWnD9ac2QzUwsrRvPtQINEba4sOMN9IldUBVU
         pYF0/PhIDX6zcGvXQR8/JippZS3WOIyvOp+/uzStYJ7xy0hXZ5G+uaU3P970Y8hwyp61
         mFksRGmPoSMyzkRb991s7KavXwKrHHA+IlGdgHCPeWfBt+RzRu25P4c1GP+j070YW8B5
         AfAzSXwxl6TmMcbuqMP1oYxlzFUff/yiA64ZWb5vvKqajgzJtrQcNZICy98uBOINDTIu
         QJsg==
X-Gm-Message-State: ALoCoQmm+Js55nRNXfniejC5AWQatqXwKxppMUXYE4WtWuIq05+vCYyOnzFoOHGzyNKu55bbvyNZ
X-Received: by 10.68.94.3 with SMTP id cy3mr48135695pbb.113.1441131883432;
        Tue, 01 Sep 2015 11:24:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3828:a7a8:276e:e72a])
        by smtp.gmail.com with ESMTPSA id gx11sm18885652pbd.82.2015.09.01.11.24.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 11:24:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277007>

I added all suggestions from Eric and rewrote the main function
to not have hardcoded all the commands we're introducing.

diff to patch series 3 below.

Stefan Beller (3):
  submodule: implement `list` as a builtin helper
  submodule: implement `name` as a builtin helper
  submodule: implement `clone` as a builtin helper

 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 299 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 166 +++---------------------
 git.c                       |   1 +
 6 files changed, 319 insertions(+), 150 deletions(-)
 create mode 100644 builtin/submodule--helper.c


diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0669641..63f535a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -33,7 +33,7 @@ static int module_list_compute(int argc, const char **argv,
 		ps_matched = xcalloc(pathspec->nr, 1);
 
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
@@ -79,7 +79,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper module_list [--prefix=<path>] [<path>...]"),
+		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
 		NULL
 	};
 
@@ -110,21 +110,20 @@ static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
 
-	if (argc != 1)
+	if (argc != 2)
 		usage("git submodule--helper module_name <path>\n");
 
 	gitmodules_config();
-	sub = submodule_from_path(null_sha1, argv[0]);
+	sub = submodule_from_path(null_sha1, argv[1]);
 
 	if (!sub)
 		die(N_("No submodule mapping found in .gitmodules for path '%s'"),
-		    argv[0]);
+		    argv[1]);
 
 	printf("%s\n", sub->name);
 
 	return 0;
 }
-
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, const char *reference, int quiet)
 {
@@ -166,7 +165,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
-	struct option module_update_options[] = {
+	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &alternative_path,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
@@ -189,38 +188,41 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	static const char * const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update [--prefix=<path>] [--quiet] [--remote] [-N|--no-fetch]"
-		   "[-f|--force] [--rebase|--merge] [--reference <repository>]"
-		   "[--depth <depth>] [--recursive] [--] [<path>...]"),
+	const char * const git_submodule_helper_usage[] = {
+		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
+		   "[--reference <repository>] [--name <name>] [--url <url>]"
+		   "[--depth <depth>] [--] [<path>...]"),
 		NULL
 	};
 
-	argc = parse_options(argc, argv, prefix, module_update_options,
+	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);
 
 	if (!file_exists(sm_gitdir)) {
-		safe_create_leading_directories_const(sm_gitdir);
+		if (safe_create_leading_directories_const(sm_gitdir) < 0)
+			die(_("could not create directory '%s'"), sm_gitdir);
 		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
-			die(N_("Clone of '%s' into submodule path '%s' failed"),
+			die(N_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
-		safe_create_leading_directories_const(path);
-		unlink(sm_gitdir);
+		if (safe_create_leading_directories_const(path) < 0)
+			die(_("could not create directory '%s'"), path);
+		if (unlink(sm_gitdir) < 0)
+			die_errno(_("failed to delete '%s'"), sm_gitdir);
 	}
 
 	/* Write a .git file in the submodule to redirect to the superproject. */
-	if (alternative_path && !strcmp(alternative_path, "")) {
+	if (alternative_path && *alternative_path)) {
 		p = relative_path(path, alternative_path, &sb);
 		strbuf_reset(&sb);
 	} else
 		p = path;
 
 	if (safe_create_leading_directories_const(p) < 0)
-		die("Could not create directory '%s'", p);
+		die(_("could not create directory '%s'"), p);
 
 	strbuf_addf(&sb, "%s/.git", p);
 
@@ -228,31 +230,32 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		die(_("could not create leading directories of '%s'"), sb.buf);
 	submodule_dot_git = fopen(sb.buf, "w");
 	if (!submodule_dot_git)
-		die ("Cannot open file '%s': %s", sb.buf, strerror(errno));
+		die (_("cannot open file '%s': %s"), sb.buf, strerror(errno));
 
 	fprintf(submodule_dot_git, "gitdir: %s\n",
 		relative_path(sm_gitdir, path, &rel_path));
 	if (fclose(submodule_dot_git))
-		die("Could not close file %s", sb.buf);
+		die(_("could not close file %s"), sb.buf);
 	strbuf_reset(&sb);
 
-	/* Redirect the worktree of the submodule in the superprojects config */
+	/* Redirect the worktree of the submodule in the superproject's config */
+	if (strbuf_getcwd(&sb))
+		die_errno(_("unable to get current working directory"));
+
 	if (!is_absolute_path(sm_gitdir)) {
-		char *s = (char*)sm_gitdir;
 		if (strbuf_getcwd(&sb))
-			die_errno("unable to get current working directory");
+			die_errno(_("unable to get current working directory"));
 		strbuf_addf(&sb, "/%s", sm_gitdir);
+		free(sm_gitdir);
 		sm_gitdir = strbuf_detach(&sb, NULL);
-		free(s);
 	}
 
-	if (strbuf_getcwd(&sb))
-		die_errno("unable to get current working directory");
+
 	strbuf_addf(&sb, "/%s", path);
 
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
-		die("Could not get submodule directory for '%s'", path);
+		die(_("could not get submodule directory for '%s'"), path);
 	git_config_set_in_file(p, "core.worktree",
 			       relative_path(sb.buf, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
@@ -260,23 +263,37 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct cmd_struct {
+	const char *cmd;
+	int (*fct)(int, const char **, const char *);
+};
+
+static struct cmd_struct commands[] = {
+	{"list", module_list},
+	{"name", module_name},
+	{"clone", module_clone},
+};
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
+	int i;
 	if (argc < 2)
-		die(N_("fatal: submodule--helper subcommand must be called with "
-		       "a subcommand, which are module-list, module-name, "
-		       "module-clone\n"));
+		goto out;
 
-	if (!strcmp(argv[1], "module-list"))
-		return module_list(argc - 1, argv + 1, prefix);
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		if (!strcmp(argv[1], commands[i].cmd))
+			return commands[i].fct(argc - 1, argv + 1, prefix);
 
-	if (!strcmp(argv[1], "module-name"))
-		return module_name(argc - 2, argv + 2, prefix);
+out:
+	if (argc > 1)
+		fprintf(stderr, _("fatal: '%s' is not a valid submodule--helper "
+				  "subcommand, which are:\n"), argv[1]);
+	else
+		fprintf(stderr, _("fatal: submodule--helper subcommand must be "
+				  "called with a subcommand, which are:\n"));
 
-	if (!strcmp(argv[1], "module-clone"))
-		return module_clone(argc - 1, argv + 1, prefix);
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		fprintf(stderr, "\t%s\n", commands[i].cmd);
 
-	die(N_("fatal: '%s' is not a valid submodule--helper subcommand, "
-	       "which are module-list, module-name, module-clone\n"),
-	    argv[1]);
+	exit(129);
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index d1523ea..7cfdc2c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -338,7 +338,7 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		git submodule--helper module-clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -398,7 +398,7 @@ cmd_foreach()
 	# command in the subshell (and a recursive call to this function)
 	exec 3<&0
 
-	git submodule--helper module-list --prefix "$wt_prefix"|
+	git submodule--helper list --prefix "$wt_prefix"|
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -406,7 +406,7 @@ cmd_foreach()
 		then
 			displaypath=$(relative_path "$sm_path")
 			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
-			name=$(git submodule--helper module-name "$sm_path")
+			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
 				clear_local_git_env
@@ -458,11 +458,11 @@ cmd_init()
 		shift
 	done
 
-	git submodule--helper module-list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(git submodule--helper module-name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -540,11 +540,11 @@ cmd_deinit()
 		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
 	fi
 
-	git submodule--helper module-list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(git submodule--helper module-name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 
 		displaypath=$(relative_path "$sm_path")
 
@@ -656,7 +656,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	git submodule--helper module-list --prefix "$wt_prefix" "$@" | {
+	git submodule--helper list --prefix "$wt_prefix" "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
@@ -666,7 +666,7 @@ cmd_update()
 			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
 			continue
 		fi
-		name=$(git submodule--helper module-name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
@@ -700,7 +700,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			git submodule--helper module-clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
+			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
@@ -930,7 +930,7 @@ cmd_summary() {
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
-				name=$(git submodule--helper module-name "$sm_path")
+				name=$(git submodule--helper name "$sm_path")
 				ignore_config=$(get_submodule_config "$name" ignore none)
 				test $status != A && test $ignore_config = all && continue
 			fi
@@ -1088,11 +1088,11 @@ cmd_status()
 		shift
 	done
 
-	git submodule--helper module-list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(git submodule--helper module-name "$sm_path") || exit
+		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath=$(relative_path "$prefix$sm_path")
 		if test "$stage" = U
@@ -1165,11 +1165,11 @@ cmd_sync()
 		esac
 	done
 	cd_to_toplevel
-	git submodule--helper module-list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(git submodule--helper module-name "$sm_path")
+		name=$(git submodule--helper name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
 		# Possibly a url relative to parent


-- 
2.5.0.256.g89f8063.dirty
