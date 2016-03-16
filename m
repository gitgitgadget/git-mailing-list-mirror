From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule clone: pass along `local` option
Date: Tue, 15 Mar 2016 18:12:16 -0700
Message-ID: <1458090737-14030-3-git-send-email-sbeller@google.com>
References: <1458090737-14030-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, pclouds@gmail.com,
	larsxschneider@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 16 02:12:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag00o-0007we-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 02:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934117AbcCPBMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 21:12:31 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35941 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934086AbcCPBM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 21:12:28 -0400
Received: by mail-pf0-f169.google.com with SMTP id u190so51498965pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NBDptGEI/ArBJDfRiP/bDKO1sW9DJ0p85XPtpdMJsfU=;
        b=fcDG8n55ZevGRmjwwuD3D64tRrgv5h4uGNpQZwTER2kTGeN5MowX5RJ3cwE1D4uhMt
         AzlItFctnUiMgp+kg5shFtPn8aNiBMvkLC5IMxHMYUx91azLUvhk+l3Bo1dCXMkkQ0ie
         06c8J1+OTXAF4JTFQFQ0YiOFMMpEoZfUV2qzAf2OOb4ScwuTA+czN2BqYEraIhPs5KNH
         JpBT0XXJ0O5BPHiZd0rgTHzshtVd0bEIGViLu1Uon9xVNYqobvFBhwPo6qBOUSaPhIJA
         VuP9ruaMhr7jeqMUtSkkE6/kOQ8sJNgjIqHJlRY3RlbPZ5q6BA67I5vTB4IQ46Kc6eSm
         CwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NBDptGEI/ArBJDfRiP/bDKO1sW9DJ0p85XPtpdMJsfU=;
        b=i8/Qp4G3Fe6BXxyIDsBs2t4fIU6uTDfPB+teVaaweeL2Qz4cNHhjJ1dumm7hBKkp3C
         muVgGJcviPyUoU+ewqh8tXoYPsAzqaViCKLR73qqyJ3AtNqv8JN5c1V/DeL7Adix1SY/
         J9uus5ZLbPkSqt4cyd3GiOy5BW4Xz7sLxJ2DeqxufkhKwCT7/dkibbqY0ER7R7LdM++k
         +aBvyAPvUKaz+o8iYVU+9x043gCnhr5+1ggKuj0AsLk7IG0iuSLgwuUbX8WfH8tQKTeR
         0Nv8HYN1/eOLgOuyqHZSWyT+MuH01Wev1kslz/aOONkrT3eEP+OMyV+8ORoIbOttYqMr
         QAJg==
X-Gm-Message-State: AD7BkJKX/6P3i4W75Sl/g7EORn1ARTNrBWte6NvtYCXGLZRzEaEaQJkC75Dd3crKqjLe6GrG
X-Received: by 10.98.14.68 with SMTP id w65mr1641888pfi.144.1458090747872;
        Tue, 15 Mar 2016 18:12:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f8a9:c435:807a:de5e])
        by smtp.gmail.com with ESMTPSA id vy6sm605575pac.38.2016.03.15.18.12.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 18:12:27 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.42.g8e9204f.dirty
In-Reply-To: <1458090737-14030-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288939>

When cloning a local repository, the user may choose to use an optimization
such that the transfer uses a Git agnostic protocol. Propagate the users
choice to submodules or if they don't choose, propagate nothing.
A test will be added in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
        Alternative commit message:
        When writing tests (as they appear in a later patch), I was forced to make
        a decision: Either use the file:// protocol and pretend like I never run
        into problems using the local option when writing tests, or support the
        local option as a first class citizen and give it some test coverage in
        combination with the shallow clones. I choose the later as for the
        file:// protocol I would have needed to muck around with path names.
        c.f. $gmane/282779

 builtin/clone.c             | 14 ++++++++++++++
 builtin/submodule--helper.c | 22 +++++++++++++++++++---
 git-submodule.sh            |  7 +++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ecdf308..0980386 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -734,6 +734,20 @@ static int checkout(void)
 		    || (option_shallow_submodules == -1 && option_depth))
 			argv_array_push(&args, "--depth=1");
 
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
2.7.0.rc0.42.g8e9204f.dirty
