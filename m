From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] submodule--helper: module_list and update-clone have --groups option
Date: Tue, 24 Nov 2015 17:32:18 -0800
Message-ID: <1448415139-23675-5-git-send-email-sbeller@google.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:32:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Owm-0005sT-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbbKYBce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:32:34 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36595 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412AbbKYBc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:32:27 -0500
Received: by pacdm15 with SMTP id dm15so39565473pac.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xgm4glQr7bdJJcUdqEU7zDLL8YLIZ1rXVQmad06gT0=;
        b=MGo90mspupP+V0iA1c8gIpjfcg3xo2vw18wqMfgEHVd06kr4m9v3s+J0PBMG7uYt7i
         suex/k3tKoYUJ94+hQeVdPU6V6OOFWxnn8arkyfsdrFpVJj4aMRicXW6z4i+TOYgHrbX
         xhIzOMymEaP7Ku/v3H7yD+EPTyZ8jWuhUXUzHZNzCO4MnykmQ10HDM+AagxDVw4OpLPe
         e913eqFOLSOzqaLuKTHD0u0vLKy/oh7rx72A45wL3x0U+zFGx+PTivyrc0TcsjjI4vuI
         1F+A/y1nIfkmzI5rUBgg97Ft6Ho26gdUeQsnqzQV7n/Jp4aqdPyUxkkBUrJYj44+a6S8
         fb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xgm4glQr7bdJJcUdqEU7zDLL8YLIZ1rXVQmad06gT0=;
        b=NmipMuv5lLVI8J0Be4zMfUWZtXigRhVlBrPiXVXVe3h7zIGedMdJRzn7j81x+LLkRJ
         ONP7Ke5QEmxHbdD8tJCihEU3JzNEYqlwlVEbL10+4DC+ZvU2wQtZrATyVCsblC65W2EC
         yzmZec1fYgZPJ32+p8XDyKevmzgdpdHjxC6A+9SvvdbcOSqHg35rj//G46i4OEPUMh6D
         GLoFVn+dwxX7XUXllZXdmq83t6KJRSTSX/1VaGiYmZ8nptNSGO0WpM/zz0nbut++aG+g
         2VByZuaM1TsXJ+bVLWqSryu9p+eTAlOp20F+hJvcXTy1wRMATwpK7QDDLfy+rvtRG10W
         mIgg==
X-Gm-Message-State: ALoCoQkT5KXfcz/LjhNp+BdUcvoOx7EmwYa0EyebwDOso3j5d2JsFj7Awl9BbqInNM3i7govCOY6
X-Received: by 10.67.14.201 with SMTP id fi9mr47671273pad.41.1448415146329;
        Tue, 24 Nov 2015 17:32:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:38f7:d727:e789:685b])
        by smtp.gmail.com with ESMTPSA id q23sm16826625pfi.34.2015.11.24.17.32.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:32:25 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448415139-23675-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281673>

This will be useful in a later patch.
when passing in the --groups option, only the configured groups are
considered instead of all groups.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 68 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 254824a..6a208ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -67,16 +67,33 @@ static int module_list_compute(int argc, const char **argv,
 	return result;
 }
 
+static int load_submodule_groups(struct string_list **groups)
+{
+	const char *g = NULL;
+	if (git_config_get_string_const("submodule.groups", &g) < 0)
+		return -1;
+	if (!g)
+		return 1;
+	*groups = xmalloc(sizeof(**groups));
+	string_list_init(*groups, 1);
+	string_list_split(*groups, g, ',', -1);
+	string_list_sort(*groups);
+	return 0;
+}
+
 static int module_list(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	int i, groups = 0;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
+	struct string_list *submodule_groups;
 
 	struct option module_list_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
+		OPT_BOOL(0, "groups", &groups,
+			 N_("Only initialize configured submodule groups")),
 		OPT_END()
 	};
 
@@ -93,9 +110,33 @@ static int module_list(int argc, const char **argv, const char *prefix)
 		return 1;
 	}
 
+	if (groups) {
+		gitmodules_config();
+		if (load_submodule_groups(&submodule_groups))
+			die(_("No groups configured?"));
+	}
 	for (i = 0; i < list.nr; i++) {
 		const struct cache_entry *ce = list.entries[i];
 
+		if (groups) {
+			int found = 0;
+			struct string_list_item *item;
+			const struct submodule *sub = submodule_from_path(null_sha1, ce->name);
+			if (!sub)
+				die("BUG: Could not find submodule %s in cache, "
+				    "despite having found it earlier", ce->name);
+			else {
+				for_each_string_list_item(item, sub->groups) {
+					if (string_list_lookup(submodule_groups, item->string)) {
+						found = 1;
+						break;
+					}
+				}
+			if (!found)
+				continue;
+			}
+		}
+
 		if (ce_stage(ce))
 			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
 		else
@@ -262,6 +303,7 @@ static int git_submodule_config(const char *var, const char *value, void *cb)
 
 struct submodule_update_clone {
 	/* states */
+	struct string_list *submodule_groups;
 	int count;
 	int print_unmatched;
 	/* configuration */
@@ -275,7 +317,7 @@ struct submodule_update_clone {
 	struct string_list projectlines;
 	struct pathspec pathspec;
 };
-#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP}
+#define SUBMODULE_UPDATE_CLONE_INIT {NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP}
 
 static void fill_clone_command(struct child_process *cp, int quiet,
 			       const char *prefix, const char *path,
@@ -318,6 +360,7 @@ static int update_clone_get_next_task(void **pp_task_cb,
 		const char *update_module = NULL;
 		char *url = NULL;
 		int needs_cloning = 0;
+		int in_submodule_groups = 0;
 
 		if (ce_stage(ce)) {
 			if (pp->recursive_prefix)
@@ -372,6 +415,20 @@ static int update_clone_get_next_task(void **pp_task_cb,
 			continue;
 		}
 
+		if (pp->submodule_groups) {
+			struct string_list_item *item;
+			for_each_string_list_item(item, sub->groups) {
+				if (string_list_lookup(
+				    pp->submodule_groups, item->string)) {
+					in_submodule_groups = 1;
+					break;
+				}
+			}
+		}
+
+		if (pp->submodule_groups && !in_submodule_groups)
+			continue;
+
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "%s/.git", ce->name);
 		needs_cloning = !file_exists(sb.buf);
@@ -427,6 +484,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	int max_jobs = -1;
+	int submodule_groups = 0;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -449,6 +507,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			      "specified number of revisions")),
 		OPT_INTEGER('j', "jobs", &max_jobs,
 			    N_("parallel jobs")),
+		OPT_BOOL(0, "groups", &submodule_groups,
+			 N_("operate only on configured groups")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -467,6 +527,9 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		return 1;
 	}
 
+	if (submodule_groups)
+		load_submodule_groups(&pp.submodule_groups);
+
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
@@ -490,6 +553,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &pp.projectlines)
 		utf8_fprintf(stdout, "%s", item->string);
 
+	free(pp.submodule_groups);
 	return 0;
 }
 
-- 
2.6.1.261.g0d9c4c1
