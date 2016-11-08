Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47052022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933373AbcKHUM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:57 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36560 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933371AbcKHUM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:56 -0500
Received: by mail-pf0-f193.google.com with SMTP id n85so20693557pfi.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B2ZUNBZBehODXRJHZG8eL/YLktMGaZWa5qt8Weety3I=;
        b=uVb1uXqMUgAjhWJXICxNk6IAZfRTUWa7BQDVyld3B5GRhFu638sz1GpR4ErMEc7yxz
         6xozs5Jhppem52By6XFFKrmdI1nYUuYq4qzzZVuXJsC1tYE5EY1UJWcmTFJHiQjjvU9d
         mdg7oC/mgMYvscaqt0cXXEufyhoxjVyInStw/milhYhF3gh8Ad4jUUXq3yrtBL5Xit4K
         tfW36lLx8degSHdEKzjdd8UtIXaPtVCart1vuxpTuZbyeAgdy/SGz3Aai/7ADWHkw0o+
         OH3cPQ5eynNSCjN/LuCRIWikSixi5w6Bm7flNpa1jr9xZMlI9LEwv+Ia745X9YOiVuCP
         edww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B2ZUNBZBehODXRJHZG8eL/YLktMGaZWa5qt8Weety3I=;
        b=gc8W798UoG3zq1JyztlHYFXro+zD5ZrKnavYEQBi+G9EDV2WJJgePdnh/JUzTOV69w
         +YDhndRNyQUoDpitW68BjZ41G3QnLlJYK3303qGWYLHhRjzVwBj11cVTk3lh7ludDIU3
         //G9i6Bxqh/THhJRNhTVWxT3v+4APNSIWaUjLsA/gznsIeqn28ry8jX1rtNvOMdSBN+U
         57Bzen5kf8UWwOGoJ3iUhA8RCCbrJHXb4jJc+GShdlhwDjAujHKVCPR6nj5AtR5//A3/
         B6nuo7Bfh0RKxo6B9RdvsfinCoBrVsLa4W+9o89Krn39xB6796IS0NakYqqYlyI+1/26
         bGlA==
X-Gm-Message-State: ABUngvddtOwnl7Ow5MJuJ2tHrl8JLKrCHlf+OsiKprPCEqTbE6fKLac/sJcwLqxUWD5POA==
X-Received: by 10.98.163.199 with SMTP id q68mr26126624pfl.87.1478635970212;
        Tue, 08 Nov 2016 12:12:50 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:49 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 17/17] branch: implement '--format' option
Date:   Wed,  9 Nov 2016 01:42:11 +0530
Message-Id: <20161108201211.25213-18-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

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
index 1fe7344..e5b6f31 100644
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
index a19e05d..acadb99 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,6 +28,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
+	N_("git branch [<options>] [-r | -a] [--format]"),
 	NULL
 };
 
@@ -343,14 +344,14 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
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
@@ -367,7 +368,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	format = build_format(filter, maxwidth, remote_prefix);
+	if (!format)
+		format = to_free = build_format(filter, maxwidth, remote_prefix);
 	verify_ref_format(format);
 
 	/*
@@ -395,7 +397,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	}
 
 	ref_array_clear(&array);
-	free(format);
+	free(to_free);
 }
 
 static void reject_rebase_or_bisect_branch(const char *target)
@@ -515,6 +517,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -555,6 +558,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
 
@@ -615,7 +619,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
2.10.2

