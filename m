From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 0/3] submodule--helper: Have some refactoring only patches first
Date: Tue,  8 Sep 2015 11:57:42 -0700
Message-ID: <1441738665-29493-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 20:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZO5d-0003bQ-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbIHS5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:57:52 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33609 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbIHS5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:57:51 -0400
Received: by pacex6 with SMTP id ex6so131492947pac.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gIhiXWFibs2OGvxEYx6X2qUMeomoS1cueoKbIiBamjY=;
        b=Y6mE7wn71/LG+SWDGqxR4QzCqPdI3WSxPHLdS+HAeC29/WFZ2O2L6SlVEXVrmcK2LY
         jiIQIKE89ID5zstF+7mx/idaCGLMTlL7WJiS5IVRJ7eE/2sp5855vlRrcTXBUsMqgc0q
         NNGd5FhDBHCRWVOQ92gslNcvR4eMTb1S/9x8C7D1aX0VXY/2HxxgAv6Le2Nijc4xAvwj
         TXOGpFnPMc3rPeZ6uEwsnzpAT2NFTwVwc2oP3UqLEdU+8ick+qKTxQs2wqBkyvgUgGQj
         MI7rJyxD3UDRejRbszAKyN+o0bYBZ6SQfv3c3NoX1OIx/v2iiXdHkSkL7LUNMFoITVs8
         rUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gIhiXWFibs2OGvxEYx6X2qUMeomoS1cueoKbIiBamjY=;
        b=N9x61AF5iQOZEjLJvevuotYOgxQlGAItcMJMUj0+sXsma9a00LCjb79zyp4HkOSLUQ
         2fO5uPP9PugSMiXZht0FDwfNUcRrC1UlUEXPgOs5XsNLoyLidO0Xb2QmA5xiDzOKZudp
         MGBmu0pgpYXLeGhGTxHh1KJ1T0HATS6G+wXuRm8iKS0NMyC6ofVOjs4XL0q9wGYyxWaU
         zGe3JLnaie0FMJ3WWLWNpQtXoh9LW54jKBld+YG/A00dTwOAIYJNdXb1dL4m9n7K6nhp
         UgwSnUwb2wVZfwOxSkKsQKUgDEdwGf/UKkREHPZVZ2/Qo1e+C271eCK5rXFhEbRtXjhw
         DHMw==
X-Gm-Message-State: ALoCoQkCVCAuTyT8RDREjdgQfK2pW1moQ9rmisyQzMKXQjG80KGpT5XBs98/gaTBUed46wa7PALR
X-Received: by 10.66.165.5 with SMTP id yu5mr3871927pab.109.1441738670901;
        Tue, 08 Sep 2015 11:57:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:b8c0:c175:ec61:d891])
        by smtp.gmail.com with ESMTPSA id u1sm4265753pbz.56.2015.09.08.11.57.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Sep 2015 11:57:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277522>

Added suggestions from Eric and Junio. Interdiff to v5 below.

Stefan Beller (3):
  submodule: Reimplement `module_list` shell function in C
  submodule: Reimplement `module_name` shell function in C
  submodule: Reimplement `module_clone` shell function in C

 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 282 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 164 +++-----------------------
 git.c                       |   1 +
 6 files changed, 301 insertions(+), 149 deletions(-)
 create mode 100644 builtin/submodule--helper.c

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4e30d8e..f4c3eff 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -10,12 +10,16 @@
 #include "string-list.h"
 #include "run-command.h"
 
-static const struct cache_entry **ce_entries;
-static int ce_alloc, ce_used;
+struct module_list {
+	const struct cache_entry **entries;
+	int alloc, nr;
+};
+#define MODULE_LIST_INIT { NULL, 0, 0 }
 
 static int module_list_compute(int argc, const char **argv,
-				const char *prefix,
-				struct pathspec *pathspec)
+			       const char *prefix,
+			       struct pathspec *pathspec,
+			       struct module_list *list)
 {
 	int i, result = 0;
 	char *max_prefix, *ps_matched = NULL;
@@ -40,12 +44,11 @@ static int module_list_compute(int argc, const char **argv,
 
 		if (!S_ISGITLINK(ce->ce_mode) ||
 		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
-				    max_prefix_len, ps_matched,
-				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
+				    max_prefix_len, ps_matched, 1))
 			continue;
 
-		ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
-		ce_entries[ce_used++] = ce;
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = ce;
 		while (i + 1 < active_nr &&
 		       !strcmp(ce->name, active_cache[i + 1]->name))
 			/*
@@ -68,6 +71,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_list_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -84,13 +88,13 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec) < 0) {
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
 		printf("#unmatched\n");
 		return 1;
 	}
 
-	for (i = 0; i < ce_used; i++) {
-		const struct cache_entry *ce = ce_entries[i];
+	for (i = 0; i < list.nr; i++) {
+		const struct cache_entry *ce = list.entries[i];
 
 		if (ce_stage(ce))
 			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
@@ -142,10 +146,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 
 	cp.git_cmd = 1;
 	cp.env = local_repo_env;
-
 	cp.no_stdin = 1;
-	cp.no_stdout = 1;
-	cp.no_stderr = 1;
 
 	return run_command(&cp);
 }
@@ -206,8 +207,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		if (safe_create_leading_directories_const(path) < 0)
 			die(_("could not create directory '%s'"), path);
 		strbuf_addf(&sb, "%s/index", sm_gitdir);
-		if (unlink(sb.buf) < 0)
-			die_errno(_("failed to delete '%s'"), sm_gitdir);
+		unlink_or_warn(sb.buf);
 		strbuf_reset(&sb);
 	}
 
@@ -218,7 +218,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (path && *path)
 		strbuf_addf(&sb, "%s/.git", path);
 	else
-		strbuf_addf(&sb, ".git");
+		strbuf_addstr(&sb, ".git");
 
 	if (safe_create_leading_directories_const(sb.buf) < 0)
 		die(_("could not create leading directories of '%s'"), sb.buf);
diff --git a/git-submodule.sh b/git-submodule.sh
index 7cfdc2c..8b0eb9a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -227,7 +227,7 @@ cmd_add()
 			shift
 			;;
 		--depth=*)
-			depth="$1"
+			depth=$1
 			;;
 		--)
 			shift

-- 
2.5.0.256.g89f8063.dirty
