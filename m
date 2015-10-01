From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 7/8] fetch_populated_submodules: use new parallel job processing
Date: Wed, 30 Sep 2015 18:54:15 -0700
Message-ID: <1443664456-1307-8-git-send-email-sbeller@google.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 03:55:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhT5g-0000WO-Lk
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 03:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbbJABzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 21:55:17 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36054 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbbJAByh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 21:54:37 -0400
Received: by pablk4 with SMTP id lk4so57021498pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5eNUZRdRcYowyz6/wZdhWCtccBEo9aPkbelEpVHLZyQ=;
        b=RxHEVOtLRuuFTZrRXwlo4XsgO4bUX3SbDGIcT5fWToyK6nEKpaKbZapCoBb9U5ERrx
         +c+SPgWRgf4yXSM1IPI1N9sacNsN/VBEKGE6kOjzHZAJmGSgf7Ti0QvLkzE4sewGFPX4
         mz235PCJpRM5bZIe5byNKHpOIHH0qtkqcl5YuaDzNbIC4nM8QjQZyC1cx+7f3iXI8BZp
         aDJunAL2p5k8VY6/aM4bKCyHB0Th9F+cld03LSa5sAf6zQmmwUZoH5/UoUvvBV2KyCih
         1YNjKeoTXGh5RUXKvUqWqtVgs+tM4q/IAqp8WXS4eiFHYSDHcLXV8p3A0uzoii2QyPUN
         ORMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5eNUZRdRcYowyz6/wZdhWCtccBEo9aPkbelEpVHLZyQ=;
        b=A+KbTBEe70OGL5kSMWJMPDjcDXxZTbeVm95XfrChJSE8L6vz9SMn/ZEtkff3V98q94
         NU6OI9OMYm5Fht0ZhrWdp2oLEfKIYe8tVF0sNrq05JRj+ASvaqJXBvLgAwy4ZrVP+JB1
         y9ysDSjJMh4VfsX1arkZCVFkUskTp8kN7NUSjNb15iI7AKFMAFkxZTyGEp3kydpbVVEc
         pXYp0YNUNSVljEeOosuCFPBmBCTRoGdFaO9NYU3NS/FD+4L87xuYvHACPbrT2Ag1GP0z
         h86vssayPSP8B7y2V9a/vpeHNGoIc8uT5GbmocRchrUj5cMPW4N6b35Fl2AazX+KKQ6t
         6dCQ==
X-Gm-Message-State: ALoCoQlPTv7Uqju++6MssbS5RSBp3eKI8n6ss/p8Zc/vnap4RE97/hNUCkvDDZlsG3xpksMKqY5j
X-Received: by 10.66.141.11 with SMTP id rk11mr1174396pab.38.1443664476870;
        Wed, 30 Sep 2015 18:54:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8d91:1679:adb7:b916])
        by smtp.gmail.com with ESMTPSA id z6sm3089645pbt.51.2015.09.30.18.54.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 18:54:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gf20166c.dirty
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278877>

In a later patch we enable parallel processing of submodules, this
only adds the possibility for it. So this change should not change
any user facing behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 128 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 94 insertions(+), 34 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1d64e57..ff5bc32 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -615,37 +616,91 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
+struct submodule_parallel_fetch {
+	int count;
+	struct argv_array args;
+	const char *work_tree;
+	const char *prefix;
+	int command_line_option;
+	int quiet;
+	int result;
+};
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
+
+static int get_next_submodule(void **task_cb, struct child_process *cp,
+			      struct strbuf *err, void *data);
+
+static int fetch_start_failure(struct child_process *cp,
+			       struct strbuf *err,
+			       void *cb, void *task_cb)
+{
+	struct submodule_parallel_fetch *spf = cb;
+
+	spf->result = 1;
+
+	return 0;
+}
+
+static int fetch_finish(int retvalue, struct child_process *cp,
+			struct strbuf *err, void *cb, void *task_cb)
+{
+	struct submodule_parallel_fetch *spf = cb;
+
+	if (retvalue)
+		spf->result = 1;
+
+	return 0;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet)
 {
-	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *work_tree = get_git_work_tree();
-	if (!work_tree)
+	int i;
+	int max_parallel_jobs = 1;
+	struct submodule_parallel_fetch spf = SPF_INIT;
+
+	spf.work_tree = get_git_work_tree();
+	spf.command_line_option = command_line_option;
+	spf.quiet = quiet;
+	spf.prefix = prefix;
+
+	if (!spf.work_tree)
 		goto out;
 
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	argv_array_push(&argv, "fetch");
+	argv_array_push(&spf.args, "fetch");
 	for (i = 0; i < options->argc; i++)
-		argv_array_push(&argv, options->argv[i]);
-	argv_array_push(&argv, "--recurse-submodules-default");
+		argv_array_push(&spf.args, options->argv[i]);
+	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	cp.env = local_repo_env;
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-
 	calculate_changed_submodule_paths();
+	run_processes_parallel(max_parallel_jobs,
+			       get_next_submodule,
+			       fetch_start_failure,
+			       fetch_finish,
+			       &spf);
+
+	argv_array_clear(&spf.args);
+out:
+	string_list_clear(&changed_submodule_paths, 1);
+	return spf.result;
+}
 
-	for (i = 0; i < active_nr; i++) {
+static int get_next_submodule(void **task_cb, struct child_process *cp,
+			      struct strbuf *err, void *data)
+{
+	int ret = 0;
+	struct submodule_parallel_fetch *spf = data;
+
+	for ( ; spf->count < active_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = active_cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 
@@ -657,7 +712,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -680,40 +735,45 @@ int fetch_populated_submodules(const struct argv_array *options,
 					default_argv = "on-demand";
 				}
 			}
-		} else if (command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
+		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
 			if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 				continue;
 			default_argv = "on-demand";
 		}
 
-		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
+		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
-		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
 		git_dir = read_gitfile(submodule_git_dir.buf);
 		if (!git_dir)
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
-			if (!quiet)
-				fprintf(stderr, "Fetching submodule %s%s\n", prefix, ce->name);
-			cp.dir = submodule_path.buf;
-			argv_array_push(&argv, default_argv);
-			argv_array_push(&argv, "--submodule-prefix");
-			argv_array_push(&argv, submodule_prefix.buf);
-			cp.argv = argv.argv;
-			if (run_command(&cp))
-				result = 1;
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
+			child_process_init(cp);
+			cp->dir = strbuf_detach(&submodule_path, NULL);
+			cp->env = local_repo_env;
+			cp->git_cmd = 1;
+			cp->no_stdin = 1;
+			cp->stdout_to_stderr = 1;
+			cp->err = -1;
+			if (!spf->quiet)
+				strbuf_addf(err, "Fetching submodule %s%s\n",
+					    spf->prefix, ce->name);
+			argv_array_init(&cp->args);
+			argv_array_pushv(&cp->args, spf->args.argv);
+			argv_array_push(&cp->args, default_argv);
+			argv_array_push(&cp->args, "--submodule-prefix");
+			argv_array_push(&cp->args, submodule_prefix.buf);
+			ret = 1;
 		}
 		strbuf_release(&submodule_path);
 		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
+		if (ret) {
+			spf->count++;
+			return 1;
+		}
 	}
-	argv_array_clear(&argv);
-out:
-	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return 0;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
-- 
2.5.0.275.gf20166c.dirty
