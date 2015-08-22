From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 11/12] tag.c: implement '--format' option
Date: Sat, 22 Aug 2015 09:09:47 +0530
Message-ID: <1440214788-1309-12-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzfW-0002XB-Qz
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbbHVDkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:40:25 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35284 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbbHVDkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:40:13 -0400
Received: by pacdd16 with SMTP id dd16so56494607pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=93IsR1IgfZiEkVWcSHLsymZEmiFp4S6o1KEpNW+JGCU=;
        b=Oq9NTIYu9FnYr6HU4HQd+lT92W35ipIpuPNqzZs6TRCpJUfa27ksm34rJrIuFCLfkS
         VXaGMJ1S3S92z+Zz8cgqojyFKN6aG5ODiOdd9CN1AgS0gsjuChC3zL5aAdPPh90S96FA
         dhvik7OlbserE5UX8OR4cyw5Qzwsn4IOWrqtsimFj38k9mnL5kJ81VbtUrLAyG5ZaOJO
         efoL+zBp/bOYEPSEsNEfRGu+NRc8lDvcSxBtrQ4Y8NM6pEUFVkrPY1wXkSJYBud7bFeO
         RAyWzc3/Y09NeBtJNl6+Cxb8KLk5HdcRWD8COimxt0aixmgVq19ycWn2/BWz1ueaZ9RW
         3OKw==
X-Received: by 10.68.196.202 with SMTP id io10mr23373053pbc.141.1440214812689;
        Fri, 21 Aug 2015 20:40:12 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.40.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:40:12 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276375>

Implement the '--format' option provided by 'ref-filter'.
This lets the user list tags as per desired format similar
to the implementation in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt |  8 +++++++-
 builtin/tag.c             | 19 +++++++++++--------
 t/t7004-tag.sh            | 12 ++++++++++++
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3ac4a96..0c7f4e6 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>] [<pattern>...]
+	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
+	[--format=<format>] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -158,6 +159,11 @@ This option is only applicable when listing tags without annotation lines.
 	The object that the new tag will refer to, usually a commit.
 	Defaults to HEAD.
 
+<format>::
+	A string that interpolates `%(fieldname)` from the object
+	pointed at by a ref being shown.  The format is the same as
+	that of linkgit:git-for-each-ref[1].  When unspecified,
+	defaults to `%(refname:short)`.
 
 CONFIGURATION
 -------------
diff --git a/builtin/tag.c b/builtin/tag.c
index 501fc52..4b8d6df 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,17 +23,16 @@ static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
-		"\n\t\t[<pattern>...]"),
+		"\n\t\t[--format=<format>] [<pattern>...]"),
 	N_("git tag -v <tagname>..."),
 	NULL
 };
 
 static unsigned int colopts;
 
-static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
+static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	struct ref_array array;
-	char *format;
 	int i;
 
 	memset(&array, 0, sizeof(array));
@@ -41,10 +40,12 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
 	if (filter->lines == -1)
 		filter->lines = 0;
 
-	if (filter->lines)
-		format = "%(align:16,left)%(refname:short)%(end)";
-	else
-		format = "%(refname:short)";
+	if (!format) {
+		if (filter->lines)
+			format = "%(align:16,left)%(refname:short)%(end)";
+		else
+			format = "%(refname:short)";
+	}
 
 	verify_ref_format(format);
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
@@ -327,6 +328,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -359,6 +361,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -399,7 +402,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			run_column_filter(colopts, &copts);
 		}
 		filter.name_patterns = argv;
-		ret = list_tags(&filter, sorting);
+		ret = list_tags(&filter, sorting, format);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 84153ef..8987fb1 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1519,4 +1519,16 @@ EOF"
 	test_cmp expect actual
 '
 
+test_expect_success '--format should list tags as per format given' '
+	cat >expect <<-\EOF &&
+	refname : refs/tags/foo1.10
+	refname : refs/tags/foo1.3
+	refname : refs/tags/foo1.6
+	refname : refs/tags/foo1.6-rc1
+	refname : refs/tags/foo1.6-rc2
+	EOF
+	git tag -l --format="refname : %(refname)" "foo*" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
