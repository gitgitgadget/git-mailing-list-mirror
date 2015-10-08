From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/10] branch: implement '--format' option
Date: Thu,  8 Oct 2015 14:48:05 +0530
Message-ID: <1444295885-1657-11-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7Ld-0007x5-IR
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbbJHJSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:42 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36183 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258AbbJHJSj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:39 -0400
Received: by pacik9 with SMTP id ik9so5817162pac.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PUsBV2eqoPtvvRVPOaTlDCFHklYK7+fa5SeXadmnpUs=;
        b=vXxsc2R5rubjDPyuvmUAbwhV86YdO7VabhJgX3BOcGlj+6HhF+HjXdOCo9yZ0Ae055
         ydfhdLJGjnAHkj2qxhDz4H1U+XN+bQpMdr5osXKCelu8Msl1Sp4inLo8qi9zfBr3qM0z
         9vL1ANMnlys5PEsUAoURjYwdlbnpfKQswE3W5Kvcot372tOr9zqYDZcVuVWqmvOWhAb5
         je41wwY/b6aW8yLrp0oJS+SXysK8VJafQUyFfLseFP+m+FhVZjRHPLZCQfyk+0Z+zFb7
         3EUU0lllH33tQcgODmYpgqk6ox5N4hiAEE+Q8oXdjwpeoq0S3Ol/WtT3I8RGH1hfUlXX
         Rq2A==
X-Received: by 10.69.17.1 with SMTP id ga1mr6799721pbd.163.1444295918512;
        Thu, 08 Oct 2015 02:18:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:38 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279230>

Implement the '--format' option provided by 'ref-filter'.
This lets the user list tags as per desired format similar
to the implementation in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-branch.txt |  7 ++++++-
 builtin/branch.c             | 14 +++++++++-----
 t/t3203-branch-output.sh     | 11 +++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 03c7af1..5227206 100644
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
@@ -244,6 +244,11 @@ start-point is either a local or remote-tracking branch.
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
index 4d8b570..2356e72 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -27,6 +27,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
+	N_("git branch [<options>] [-r | -a] [--format]"),
 	NULL
 };
 
@@ -331,14 +332,14 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
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
@@ -355,7 +356,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	format = build_format(filter, maxwidth, remote_prefix);
+	if (!format)
+		format = to_free = build_format(filter, maxwidth, remote_prefix);
 	verify_ref_format(format);
 
 	/*
@@ -383,7 +385,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	}
 
 	ref_array_clear(&array);
-	free(format);
+	free(to_free);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -484,6 +486,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -524,6 +527,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
 
@@ -582,7 +586,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
-		print_ref_list(&filter, sorting);
+		print_ref_list(&filter, sorting, format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index f1ae5ff..a475ff1 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -163,4 +163,15 @@ test_expect_success 'git branch --points-at option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --format option' '
+	cat >expect <<-\EOF &&
+	Refname is (HEAD detached from fromtag)
+	Refname is refs/heads/branch-one
+	Refname is refs/heads/branch-two
+	Refname is refs/heads/master
+	EOF
+	git branch --format="Refname is %(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.0
