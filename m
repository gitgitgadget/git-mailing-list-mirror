From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/3] submodule--helper: Have some refactoring only patches first
Date: Wed,  2 Sep 2015 14:42:23 -0700
Message-ID: <1441230146-26921-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: sbeller@google.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Sep 02 23:42:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXFno-0001Tq-VR
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 23:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbbIBVml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 17:42:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34915 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027AbbIBVmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 17:42:40 -0400
Received: by pacfv12 with SMTP id fv12so24013462pac.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=m8jz9JZMCilWdc/xkBxZwgBW9HTgW4FjxXpgGYC0ypk=;
        b=e7pEjqMr03Pf7F2vr7wyr/K6cd1L/Y1Z4nNrBWWEZMmzvzQUZEP0XKs95RP1OawcdA
         0VyXgoGkrr6tBJYeBiSYovLqUlaeubc+zsTtiepY9MfnBxWZ7+VfV+ZjqxQdGJ55wiM3
         SduoW19D8afWgdO2bjI39PgY4CmL6t3HGltEXvL21/mY5hI5BFV1GJ9xoistVfj+3ciQ
         /EVuUu6KuzRd5P0KIeMbNTC/fNiMEzTh1fC8PQAN1DtI1ohXMHx6KFId4qaYe/vjHwZa
         CuZlzJZBeO/S1OW87iGD6ii/J/J7hyzmjwmGnuqYzzu5rRsFq5Pte0gf1zM7Yb5hkI0Y
         pWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m8jz9JZMCilWdc/xkBxZwgBW9HTgW4FjxXpgGYC0ypk=;
        b=iXtR6V1vzBRvI1wA/sII/rQNuOzQ1UgOybOR9QgYH1H3nUMBPCZiABbCarTvbxmWvC
         6TjDXSFdmm+1SL+TpLhzYRdvYTs5vD8y0SFd1ht+WOK9/pR1d381ywyPF2IVrQNttwq7
         3d8HzqbCsP/EWy40Aq13NzGYG5ZHVe/69OpxBpOysZjiQfoJN0QEHa8e43vSuJydRSpX
         ezmrwFSPnLD53NdDdQeH0gne6QmzZovv1AkpY6Uy2x+TB6N02sSWwdZakQvi+mxBcKvC
         Jj8sBlUlire5AgmTSnv1Bco1nkrUJdCUG3C6UF2CgI7SXpVGit3WFtZwApw87E6ipVNr
         yudg==
X-Gm-Message-State: ALoCoQkRJGp6ed1RPrM60KtLBJtjZOWq+/m5osrIteFyghRepKBPskHUYNdD7vWnj++X61D/25uG
X-Received: by 10.68.162.99 with SMTP id xz3mr60594023pbb.134.1441230159156;
        Wed, 02 Sep 2015 14:42:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8100:e957:594c:edb9])
        by smtp.gmail.com with ESMTPSA id h4sm22754115pdd.91.2015.09.02.14.42.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 14:42:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277128>

I finished the refactoring and picked up suggestions from Eric and Junio.

Stefan Beller (3):
  submodule: Reimplement `module_list` shell function in C
  submodule: Reimplement `module_name` shell function in C
  submodule: Reimplement `module_clone` shell function in C

 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 282 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 166 +++-----------------------
 git.c                       |   1 +
 6 files changed, 302 insertions(+), 150 deletions(-)
 create mode 100644 builtin/submodule--helper.c

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 63f535a..4e30d8e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -38,17 +38,16 @@ static int module_list_compute(int argc, const char **argv,
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
+		if (!S_ISGITLINK(ce->ce_mode) ||
+		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
 				    max_prefix_len, ps_matched,
 				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
 			continue;
 
-		if (S_ISGITLINK(ce->ce_mode)) {
-			ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
-			ce_entries[ce_used++] = ce;
-		}
-
-		while (i + 1 < active_nr && !strcmp(ce->name, active_cache[i + 1]->name))
+		ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
+		ce_entries[ce_used++] = ce;
+		while (i + 1 < active_nr &&
+		       !strcmp(ce->name, active_cache[i + 1]->name))
 			/*
 			 * Skip entries with the same name in different stages
 			 * to make sure an entry is returned only once.
@@ -69,10 +68,9 @@ static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct pathspec pathspec;
-	const char *alternative_path;
 
 	struct option module_list_options[] = {
-		OPT_STRING(0, "prefix", &alternative_path,
+		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
 		OPT_END()
@@ -86,9 +84,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, alternative_path
-					    ? alternative_path
-					    : prefix, &pathspec) < 0) {
+	if (module_list_compute(argc, argv, prefix, &pathspec) < 0) {
 		printf("#unmatched\n");
 		return 1;
 	}
@@ -111,13 +107,13 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	const struct submodule *sub;
 
 	if (argc != 2)
-		usage("git submodule--helper module_name <path>\n");
+		usage(_("git submodule--helper name <path>"));
 
 	gitmodules_config();
 	sub = submodule_from_path(null_sha1, argv[1]);
 
 	if (!sub)
-		die(N_("No submodule mapping found in .gitmodules for path '%s'"),
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		    argv[1]);
 
 	printf("%s\n", sub->name);
@@ -158,15 +154,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *path = NULL, *name = NULL, *url = NULL;
 	const char *reference = NULL, *depth = NULL;
-	const char *alternative_path = NULL, *p;
 	int quiet = 0;
 	FILE *submodule_dot_git;
-	char *sm_gitdir;
+	char *sm_gitdir, *cwd, *p;
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
 	struct option module_clone_options[] = {
-		OPT_STRING(0, "prefix", &alternative_path,
+		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
 		OPT_STRING(0, "path", &path,
@@ -188,7 +183,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	const char * const git_submodule_helper_usage[] = {
+	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--url <url>]"
 		   "[--depth <depth>] [--] [<path>...]"),
@@ -205,67 +200,64 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
 		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
-			die(N_("clone of '%s' into submodule path '%s' failed"),
+			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
 		if (safe_create_leading_directories_const(path) < 0)
 			die(_("could not create directory '%s'"), path);
-		if (unlink(sm_gitdir) < 0)
+		strbuf_addf(&sb, "%s/index", sm_gitdir);
+		if (unlink(sb.buf) < 0)
 			die_errno(_("failed to delete '%s'"), sm_gitdir);
+		strbuf_reset(&sb);
 	}
 
 	/* Write a .git file in the submodule to redirect to the superproject. */
-	if (alternative_path && *alternative_path)) {
-		p = relative_path(path, alternative_path, &sb);
-		strbuf_reset(&sb);
-	} else
-		p = path;
+	if (safe_create_leading_directories_const(path) < 0)
+		die(_("could not create directory '%s'"), path);
 
-	if (safe_create_leading_directories_const(p) < 0)
-		die(_("could not create directory '%s'"), p);
-
-	strbuf_addf(&sb, "%s/.git", p);
+	if (path && *path)
+		strbuf_addf(&sb, "%s/.git", path);
+	else
+		strbuf_addf(&sb, ".git");
 
 	if (safe_create_leading_directories_const(sb.buf) < 0)
 		die(_("could not create leading directories of '%s'"), sb.buf);
 	submodule_dot_git = fopen(sb.buf, "w");
 	if (!submodule_dot_git)
-		die (_("cannot open file '%s': %s"), sb.buf, strerror(errno));
+		die_errno(_("cannot open file '%s'"), sb.buf);
 
 	fprintf(submodule_dot_git, "gitdir: %s\n",
 		relative_path(sm_gitdir, path, &rel_path));
 	if (fclose(submodule_dot_git))
 		die(_("could not close file %s"), sb.buf);
 	strbuf_reset(&sb);
+	strbuf_reset(&rel_path);
 
+	cwd = xgetcwd();
 	/* Redirect the worktree of the submodule in the superproject's config */
-	if (strbuf_getcwd(&sb))
-		die_errno(_("unable to get current working directory"));
-
 	if (!is_absolute_path(sm_gitdir)) {
-		if (strbuf_getcwd(&sb))
-			die_errno(_("unable to get current working directory"));
-		strbuf_addf(&sb, "/%s", sm_gitdir);
+		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
 		free(sm_gitdir);
 		sm_gitdir = strbuf_detach(&sb, NULL);
 	}
 
-
-	strbuf_addf(&sb, "/%s", path);
-
+	strbuf_addf(&sb, "%s/%s", cwd, path);
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
 	git_config_set_in_file(p, "core.worktree",
 			       relative_path(sb.buf, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
+	strbuf_release(&rel_path);
 	free(sm_gitdir);
+	free(cwd);
+	free(p);
 	return 0;
 }
 
 struct cmd_struct {
 	const char *cmd;
-	int (*fct)(int, const char **, const char *);
+	int (*fn)(int, const char **, const char *);
 };
 
 static struct cmd_struct commands[] = {
@@ -278,22 +270,13 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	if (argc < 2)
-		goto out;
+		die(_("fatal: submodule--helper subcommand must be "
+		      "called with a subcommand"));
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++)
 		if (!strcmp(argv[1], commands[i].cmd))
-			return commands[i].fct(argc - 1, argv + 1, prefix);
-
-out:
-	if (argc > 1)
-		fprintf(stderr, _("fatal: '%s' is not a valid submodule--helper "
-				  "subcommand, which are:\n"), argv[1]);
-	else
-		fprintf(stderr, _("fatal: submodule--helper subcommand must be "
-				  "called with a subcommand, which are:\n"));
-
-	for (i = 0; i < ARRAY_SIZE(commands); i++)
-		fprintf(stderr, "\t%s\n", commands[i].cmd);
+			return commands[i].fn(argc - 1, argv + 1, prefix);
 
-	exit(129);
+	die(_("fatal: '%s' is not a valid submodule--helper "
+	      "subcommand"), argv[1]);
 }

-- 
2.5.0.256.g89f8063.dirty
