From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 17/17] branch: implement '--format' option
Date: Mon, 25 Apr 2016 20:47:58 +0530
Message-ID: <1461597478-31855-17-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:19:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHy-00065I-0K
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbcDYPS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:56 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35674 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbcDYPSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:52 -0400
Received: by mail-pf0-f180.google.com with SMTP id n1so69626901pfn.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EiNT5cttZfw7HUv+oLnmVOZx/vNXCu7HdYssev3Q8JE=;
        b=RezFNschY2fEtBSy6y1qrQWXk3aNEpghomx3wkFMlPMXz6YF9f0IBZofr7o9yDnZft
         TCtkPKFR1A8mz71koOrL20ii3ch9iuZCUId3Bl0uek+JeGd48gFedJVFRhQB8ODMnhmw
         H8+g+GOnop9OaFsHMzHjhkZVNeJZSfyurgLwyCJiSneoGj8TgK67KGfnxkoEcMgP8+Ly
         igpDVBOWOC6b0f4VwNt71aCyOzU5ZO+iIVQfrrmn8wurrk40AZzxih4t9gkl0MOxNANz
         b08IBhJr3b4LzGeHJINfkTe+7OUmZlAhnk4xOPT/6LMu9SgQ1wVDiplnppn0LvPA+vaJ
         BksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EiNT5cttZfw7HUv+oLnmVOZx/vNXCu7HdYssev3Q8JE=;
        b=X3E8OyqJhx3x6q0vDcHbGzSRqfwBIFXFB6vlmKB2y3j4UEsziomxy2ZF//w71mWn7+
         /g866fLRCPqigbWga+soBs8K/QqdjZay6l7TaoNV3dF0UZGPsTOo7CiR+5mSz3Y0IrkD
         u3nzeCcXR6hlW/NueSoUSfS8Yr9eykyTfgvk8FIkttLRYZf6EHLo4P6GL2O80Xi9aDjR
         SOCFWnSXbkxrYU2nASgLwQDvL1kRox9RjIq/T+OagGeMOA3lB/d/Toi+T4K+DS7xMnOD
         7rkQuo77t9Ct5s3ugugQqfA1jyYveW+dRbglkOaH77qLSIbqg8mg7pUMy+WNMZ+g/sR/
         M3pQ==
X-Gm-Message-State: AOPr4FUoBICRdA3m1JXWzZJZEuomi/6Mvsukos0+q887IMp0/LVSrII8S8GEF/DSkLbf9Q==
X-Received: by 10.98.49.71 with SMTP id x68mr49274658pfx.105.1461597532108;
        Mon, 25 Apr 2016 08:18:52 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:51 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292503>

Implement the '--format' option provided by 'ref-filter'. This lets the
user list branches as per desired format similar to the implementation
in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-branch.txt |  7 ++++++-
 builtin/branch.c             | 14 +++++++++-----
 t/t3203-branch-output.sh     | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4a7037f..8af132f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
-	[--points-at <object>] [<pattern>...]
+	[--points-at <object>] [--format=<format>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
@@ -246,6 +246,11 @@ start-point is either a local or remote-tracking branch.
 --points-at <object>::
 	Only list branches of the given object.
 
+--format <format>::
+	A string that interpolates `%(fieldname)` from the object
+	pointed at by a ref being shown.  The format is the same as
+	that of linkgit:git-for-each-ref[1].
+
 Examples
 --------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 07068d2..6847ac3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,6 +28,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
+	N_("git branch [<options>] [-r | -a] [--format]"),
 	NULL
 };
 
@@ -340,14 +341,14 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	return strbuf_detach(&fmt, NULL);
 }
 
-static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
+static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	int i;
 	struct ref_array array;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
 	struct strbuf out = STRBUF_INIT;
-	char *format;
+	char *to_free = NULL;
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -364,7 +365,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	format = build_format(filter, maxwidth, remote_prefix);
+	if (!format)
+		format = to_free = build_format(filter, maxwidth, remote_prefix);
 	verify_ref_format(format);
 
 	/*
@@ -392,7 +394,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	}
 
 	ref_array_clear(&array);
-	free(format);
+	free(to_free);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -491,6 +493,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -531,6 +534,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
 
@@ -591,7 +595,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
-		print_ref_list(&filter, sorting);
+		print_ref_list(&filter, sorting, format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 980c732..d8edaf2 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -196,4 +196,18 @@ test_expect_success 'local-branch symrefs shortened properly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --format option' '
+	cat >expect <<-\EOF &&
+	Refname is (HEAD detached from fromtag)
+	Refname is refs/heads/ambiguous
+	Refname is refs/heads/branch-one
+	Refname is refs/heads/branch-two
+	Refname is refs/heads/master
+	Refname is refs/heads/ref-to-branch
+	Refname is refs/heads/ref-to-remote
+	EOF
+	git branch --format="Refname is %(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0
