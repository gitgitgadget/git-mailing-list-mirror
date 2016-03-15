From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 16/16] branch: implement '--format' option
Date: Tue, 15 Mar 2016 22:17:16 +0530
Message-ID: <1458060436-1215-17-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8k-0001AN-Tw
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965339AbcCOQsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:48:07 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36578 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965319AbcCOQsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:48:02 -0400
Received: by mail-pf0-f171.google.com with SMTP id u190so35755585pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1K7ntdpaeOVSm311Ukxme85mH2M5d+ONqDetf0ypAYU=;
        b=pBLw57MCan3R2x7HJVn1YV5BBwgA6UMGVgYjDWAnxq7wm1fEZfrEcST26dXqReSbyg
         Kjm0E1jgBvTLoKuCgLtdd2ZiqfQSqAkhPIO2xmDVLBXXMAWQUTX44Z2BeRKVUEnWWQI1
         HkmQ217dKgOkMbySMJGoDg49vZFBGK5nHHOzKgepPWQZWUo0e7sqBdCC+1wkeqt3EkzW
         DjINpXbCZ+1Aam4bPrbzAT9igbY/M0wuoLPv2aVTPWpd3spIhqh9CXaXPygct3PrBk1P
         mYPJENs6i3DkKSM2AURU+6y+cLslGmOMbThX5WDk6iClbnX+3AG8C52V7PpJe4a4Crmv
         NXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1K7ntdpaeOVSm311Ukxme85mH2M5d+ONqDetf0ypAYU=;
        b=WLB0DFpanF8Dz0MHhkcOf/DZciWhJReVt6uOhhA5BwUbpD0T3vSPA3/oMaOc2W6nX5
         L2VI5FjZcEQOCglDGpIFvhGxl6vhJfwNlpMyjQqqVlxpQLws+Xh072Ny3wozkk7Jufiv
         I2Xf1NRZObi+VkipGjGMsx7wyF36HWUtnTvzPXq7vjO2ZpxAFsvV6VbuYP478JPh0vRD
         E+STAjqJGDvAhNK/OoSxU79aHyviTYD1EPDjmxKBJxrit+WJzWv91eJMKa98snLYOWfw
         1irV/7q+sDeVpqf71ZzEkbw911+jkJQhaXGGo1LSHEe1e2XtC2r9MsWA+Q7aPP9ZLhZH
         9wUA==
X-Gm-Message-State: AD7BkJLH0Ql2YEVLJ2jj8jddyOaLsMbQo5LkNzo/KNx8sVDqUq5IkTgehAS0TP4Si7rkQg==
X-Received: by 10.66.145.194 with SMTP id sw2mr47410255pab.69.1458060481627;
        Tue, 15 Mar 2016 09:48:01 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:48:01 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288878>

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
 t/t3203-branch-output.sh     | 12 ++++++++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

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
index 29cd206..fb05b39 100644
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
@@ -483,6 +485,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -523,6 +526,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
 
@@ -583,7 +587,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
-		print_ref_list(&filter, sorting);
+		print_ref_list(&filter, sorting, format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 4261403..c33a3f3 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -184,4 +184,16 @@ test_expect_success 'ambiguous branch/tag not marked' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --format option' '
+	cat >expect <<-\EOF &&
+	Refname is (HEAD detached from fromtag)
+	Refname is refs/heads/ambiguous
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
2.7.3
