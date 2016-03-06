From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 15/15] branch: implement '--format' option
Date: Sun,  6 Mar 2016 17:35:02 +0530
Message-ID: <1457265902-7949-16-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:06:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRh-0002Gv-V4
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbcCFMFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:54 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36245 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbcCFMFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:41 -0500
Received: by mail-pa0-f54.google.com with SMTP id fi3so59818795pac.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9VWPRSPEP2KpqxOWqn8F9svEOSceQ6D3c1Yf+tpke7E=;
        b=A3C3E2Usyb2371/N0N9wFNQIEFy54ub8S9/x4IhHPp0SedJs3DV9W5jDqXij0MBUP2
         t1LQ5wB53MXe0/gGMPEfj/EdZ1HIJkiMiUN0PREIAYz4JxgGEyLNBFjyWLcapvfqOb+w
         5/xI8rc/XcpDZlcEbmsadF/TxExxgR3IUs9cdU33AoiqofqABHf7D2UiIjIOK4qphSHb
         mOqEKyNQdLrqNGpkc91AimtoWw15zzDTmwiRHW3S60tXw9GVIALBMaHgI+LUEbO9GJMA
         /HnQgbN40Y7WBPpdgIcwhiiFL7fIz76Se+Hk9u3FSzibzzNI1pFiFpJ/toIsDkCZR5vW
         uW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9VWPRSPEP2KpqxOWqn8F9svEOSceQ6D3c1Yf+tpke7E=;
        b=EjmAVXy0SEPXHLaY2paq8/KtfHjJl3UCDCevSm+3tSI39c/sBGACdKLYGZj3FUbMQf
         OaukUYb5G0NkmCdNOAqc5DXqQ8OEIhzA5uV4bhC9uAIfGYV6M/Lsk5FLI8wzVu+70Ij/
         8ff8tDYYb1g9cJdvQiUK2nuRtrveSkWae02XENxyji6GAaB2wrXXtNiT8loaTH8xH2OU
         x7r7worZ0OvNax/wHuRJo6TNgBFIG5+HLKzfmWktU5RZQTw0Yxp7ODQZJ82mNOxgsBEh
         U02N/JT6/6sMRzA1Z9JkSNJFdu6djyARKlLvQsjvJIv/HXQKL/FeW6vJ0LDDDQiyp2jf
         tjJQ==
X-Gm-Message-State: AD7BkJIL2wRZOGBmgurF95hSgy7LeX5mZc8jbhvEJr1BAZOt77MuWMMwhLAImf5/ZJuWKQ==
X-Received: by 10.66.158.232 with SMTP id wx8mr26221725pab.159.1457265940558;
        Sun, 06 Mar 2016 04:05:40 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:39 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288357>

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
2.7.2
