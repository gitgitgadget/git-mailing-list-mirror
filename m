From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 6/7] fetch_populated_submodules: use new parallel job processing
Date: Tue, 15 Dec 2015 16:04:11 -0800
Message-ID: <1450224252-16833-7-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8za8-0005zR-NI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbbLPAEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:31 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35079 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933794AbbLPAE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:28 -0500
Received: by mail-pf0-f182.google.com with SMTP id v86so2030298pfa.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMBzcblsf53KvQDHyQqgJtW1txKvoKucNzyz7YEaUnE=;
        b=ED1Bn8iuRicqrYwX1B+reW4schhX+FZmU1GNOhJvuEgC5EprgNZGpUqFUetuzlYewm
         P71bPhjfmpk81bkLBKSFg1i1JSA4NUuUDYU14VX+VPkCCOkwUsu8OjgKZ58aVKI+0Wl+
         ZBOMXYIZ3b8y3Wnuo/NGOJ4Q1blvfLvs2wpSxdie5c5yO8LciYsaSEqJTg+ABaTl06iV
         6sITQSuBC2zOwqF5QCerXRoi0N/PPmLutBKmH4PWPZN/mRdmUrMwFDka8wzwgMmothTF
         s2QNxTMMNutl2s9OnRPu6S6l3ee/MsAZ+IcPcf0kASNvUpudNuzA/ICAT7x0jht3cTbL
         NZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMBzcblsf53KvQDHyQqgJtW1txKvoKucNzyz7YEaUnE=;
        b=mgnxKhMg6uP7jOPTXkyxTCSppFMFWC/wGHHWGM0Koa0kC8LEGGG2XOkBCG3zd/ik53
         OxF086s8gmYEVGYYshaLyOHffQXI7GM9jZ83v6J84dwgZeGsCquCdjUn/rlxOJttDGhb
         f2Hv0VKuU+r7ZNwq79TVwoIMpnoIpC1IwVyBm6EGbJFPkqDLZ9Ep/m3cxbY1Ix/8gBeY
         X0yvw1Ui/HNPSIpzuWa6sJYjkPEyBxmONSnRAwk+jl1yVMg4cEaUoRVTekt0ebzCe/bL
         k2U9GvFB4G61U6cvFBdg7lT05hpXsqFwMmRHPB9eY/FoKSbbft14yfW9M1YnkbsUVmnH
         uzFA==
X-Gm-Message-State: ALoCoQkziAOClrxo4jjYWw+IpxNhuM+QQM4mH48HMRzK2C9wSHzxKyXu7ZT5vQKEfjSfnx/ryjWiqPfGxV70mJtBuwIC/UMBtA==
X-Received: by 10.98.87.9 with SMTP id l9mr1036536pfb.118.1450224267852;
        Tue, 15 Dec 2015 16:04:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id o22sm398019pfi.2.2015.12.15.16.04.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:27 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282518>

In a later patch we enable parallel processing of submodules, this
only adds the possibility for it. So this change should not change
any user facing behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 142 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 44 deletions(-)

diff --git a/submodule.c b/submodule.c
index 8386477..6a2d786 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -610,37 +611,28 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
-int fetch_populated_submodules(const struct argv_array *options,
-			       const char *prefix, int command_line_option,
-			       int quiet)
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
+static int get_next_submodule(struct child_process *cp,
+			      struct strbuf *err, void *data, void **task_cb)
 {
-	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *work_tree = get_git_work_tree();
-	if (!work_tree)
-		goto out;
-
-	if (read_cache() < 0)
-		die("index file corrupt");
-
-	argv_array_push(&argv, "fetch");
-	for (i = 0; i < options->argc; i++)
-		argv_array_push(&argv, options->argv[i]);
-	argv_array_push(&argv, "--recurse-submodules-default");
-	/* default value, "--submodule-prefix" and its value are added later */
-
-	cp.env = local_repo_env;
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-
-	calculate_changed_submodule_paths();
+	int ret = 0;
+	struct submodule_parallel_fetch *spf = data;
 
-	for (i = 0; i < active_nr; i++) {
+	for ( ; spf->count < active_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = active_cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 
@@ -652,7 +644,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -675,40 +667,102 @@ int fetch_populated_submodules(const struct argv_array *options,
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
+	return 0;
+}
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
+int fetch_populated_submodules(const struct argv_array *options,
+			       const char *prefix, int command_line_option,
+			       int quiet)
+{
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
+		goto out;
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	argv_array_push(&spf.args, "fetch");
+	for (i = 0; i < options->argc; i++)
+		argv_array_push(&spf.args, options->argv[i]);
+	argv_array_push(&spf.args, "--recurse-submodules-default");
+	/* default value, "--submodule-prefix" and its value are added later */
+
+	calculate_changed_submodule_paths();
+	run_processes_parallel(max_parallel_jobs,
+			       get_next_submodule,
+			       fetch_start_failure,
+			       fetch_finish,
+			       &spf);
+
+	argv_array_clear(&spf.args);
 out:
 	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return spf.result;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
-- 
2.6.4.443.ge094245.dirty
