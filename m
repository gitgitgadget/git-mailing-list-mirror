From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule clone: pass along `local` option
Date: Tue, 12 Apr 2016 16:48:47 -0700
Message-ID: <1460504929-19208-2-git-send-email-sbeller@google.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:49:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq83P-00039d-OK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbcDLXsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:48:55 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34100 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951AbcDLXsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:48:54 -0400
Received: by mail-pa0-f46.google.com with SMTP id ot11so22291622pab.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v7mRRLtqfDu27EyJsDtf+XEUokrOayDxTQkzkswsuTk=;
        b=KJ5KxB64rYGGbg/jFU8JKjOYEgIdjvwLIk6fkqf2xdyA3Vnr18Wg5oqtFVdimZHw9o
         cyJkbT/7LJVou4PVbzm1OUF4uhei3DIKcKrmsVdJxaaQJAETpnQMn335iRQrhlEyRsTE
         A0hhW3vOpN0p5cytEYwFaYaAMr+e472jiwTwzo43oJVuodY07O0fSil3+7Y0TS7PHNUR
         MWqtsTKWAr6Ae//yqCBdFu+k5bfL0BETKqVNgStq3Ocd88xSNtnjbyAweT4VWMYqplJz
         vaROiY15rL1piHSgGwIPaSNZogI+2NnuZDPFheyAYj/edrToiDMVuK83ECxrfr+sR+bM
         eZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v7mRRLtqfDu27EyJsDtf+XEUokrOayDxTQkzkswsuTk=;
        b=EhZX+AXkJEQ7enqNlxUIcvsc7aH4/rC9z/8w0JRg5i4t7rOfcVeZZcc4cz/fiYrVPE
         n5VvvGkJPLsBRgJFfJlAtZjg038oEkCTYTrefpBhq8vAgG33XqCvuOYWqg1XLGPixX9p
         UufI2+2ZwMwKd9EYCatx30fkDykq14MJz8dfsZkpdzx/0VIrcE5LtmKuKqaMmcoVjuNW
         JsyYcwaZmpdJCWocVj5prj9fAw3dkQPRu0u2NdZz/ju4w+fJRSeJweNVRHdlqZ2ScLdh
         ZuFTbgQhCnbW0zpYxMQHw/45Tzx9q64oIbONM4vL+iYHLrc8vUO5Mo1iRxUD692T5tVZ
         OSAQ==
X-Gm-Message-State: AOPr4FVPZFJbVlEI21PVYv/+x6QrBFDi5XG7Y1G14N9+YD579xG+qO32RVM1X7BTEJXp0eoJ
X-Received: by 10.66.90.163 with SMTP id bx3mr8503347pab.59.1460504933476;
        Tue, 12 Apr 2016 16:48:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:705c:1d3d:8d56:4629])
        by smtp.gmail.com with ESMTPSA id c4sm46273684pat.19.2016.04.12.16.48.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 16:48:53 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1460504929-19208-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291330>

When cloning a local repository, the user may choose to use an optimization
such that the transfer uses a Git agnostic protocol. Propagate the users
choice to submodules or if they don't choose, propagate nothing.
A test will be added in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clone.c             | 14 ++++++++++++++
 builtin/submodule--helper.c | 22 +++++++++++++++++++---
 git-submodule.sh            |  7 +++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b004fb4..7453244 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -727,6 +727,20 @@ static int checkout(void)
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
+		switch (option_local) {
+		case 1:
+			argv_array_push(&args, "--local");
+			break;
+		case 0:
+			argv_array_push(&args, "--no-local");
+			break;
+		case -1:
+			/* pass nothing */
+			break;
+		default:
+			die("BUG: option_local out of range");
+		}
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a484945..822ec69 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -125,7 +125,8 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
-			   const char *depth, const char *reference, int quiet)
+			   const char *depth, const char *reference, int quiet,
+			   int local)
 {
 	struct child_process cp;
 	child_process_init(&cp);
@@ -140,6 +141,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_pushl(&cp.args, "--reference", reference, NULL);
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
+	if (local == 1)
+		argv_array_push(&cp.args, "--local");
+	else if (!local)
+		argv_array_push(&cp.args, "--no-local");
 
 	argv_array_push(&cp.args, url);
 	argv_array_push(&cp.args, path);
@@ -156,6 +161,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *path = NULL, *name = NULL, *url = NULL;
 	const char *reference = NULL, *depth = NULL;
 	int quiet = 0;
+	int local = -1;
 	FILE *submodule_dot_git;
 	char *sm_gitdir, *cwd, *p;
 	struct strbuf rel_path = STRBUF_INIT;
@@ -180,6 +186,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
+		OPT_BOOL(0, "local", &local,
+			 N_("to clone from a local repository")),
 		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
 		OPT_END()
 	};
@@ -200,7 +208,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
-		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
+		if (clone_submodule(path, sm_gitdir, url, depth, reference,
+				    quiet, local))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -266,6 +275,7 @@ struct submodule_update_clone {
 
 	/* configuration parameters which are passed on to the children */
 	int quiet;
+	int local;
 	const char *reference;
 	const char *depth;
 	const char *recursive_prefix;
@@ -278,7 +288,7 @@ struct submodule_update_clone {
 	unsigned quickstop : 1;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0}
 
 /**
@@ -367,6 +377,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	child->err = -1;
 	argv_array_push(&child->args, "submodule--helper");
 	argv_array_push(&child->args, "clone");
+	if (suc->local == 1)
+		argv_array_push(&child->args, "--local");
+	else if (!suc->local)
+		argv_array_push(&child->args, "--no-local");
 	if (suc->quiet)
 		argv_array_push(&child->args, "--quiet");
 	if (suc->prefix)
@@ -451,6 +465,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_BOOL(0, "local", &suc.local,
+			 N_("to clone from a local repository")),
 		OPT_INTEGER('j', "jobs", &max_jobs,
 			    N_("parallel jobs")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
diff --git a/git-submodule.sh b/git-submodule.sh
index 86018ee..4d5e8c7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -653,6 +653,12 @@ cmd_update()
 		--jobs=*)
 			jobs=$1
 			;;
+		--local)
+			option_local="--local"
+			;;
+		--no-local)
+			option_local="--no-local"
+			;;
 		--)
 			shift
 			break
@@ -680,6 +686,7 @@ cmd_update()
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
 		${jobs:+$jobs} \
+		${option_local:+$option_local} \
 		"$@" || echo "#unmatched"
 	} | {
 	err=
-- 
2.5.0.264.gc776916.dirty
