Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF941F437
	for <e@80x24.org>; Wed, 25 Jan 2017 05:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdAYF1s (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 00:27:48 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33216 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdAYF1r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 00:27:47 -0500
Received: by mail-ua0-f193.google.com with SMTP id d5so18337618uag.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 21:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FcdDyTvGqGYgyeoNddaBE5TdWLRKaJ6jLQ0WpbeMpqg=;
        b=Gkc+RfmUVlfIIG+zLOFyEFaU7kk10fVx2H/tO864NtW6360D/D8mfqdYa/6GUMHxCd
         TeYsb7x4DaE4StY9Q+Qx3MIjUzCVuU+sB0qgrQhB1FVJ8Uty1cLDA5u7N2a+kbXOgQXJ
         7kNlMDbwYwkrKnjXXlzZriLmfLxR+CmEc31XLBNT+GcxaU+G9oBxtEIIyAoCLKMak6on
         5JoY37uwCg7gwbIr8MwhSl2A3C1XifVj8gMdcuD5jKTMXTM8H6shqs8/RcmUvFBE9WGN
         pcOCdmixA3xOsrTVfVJOyJHif7ygYmcyM9ZjB9bEoer1cI1QeF9Le6XDUTCY9UCqDmZJ
         KC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FcdDyTvGqGYgyeoNddaBE5TdWLRKaJ6jLQ0WpbeMpqg=;
        b=WExJhBiY1cXiX8m8jw94HnMOFDfJrYOb32drJhu0DeN8Uzq9tKkHGgsZBVpyGLMqFZ
         psaDQJY7ULQ1aWoWp2R1g8wQDDoBSO91IpanHEOqpsoCOp+PvVrilafEQqfCTcu9EZl6
         Y3YHd5NrmokqoQAIamH9nxkYudk4PJ+Vd0rOt+fX4fOTik3D/yvaBItjAemWjv1DJWex
         LyYC0xNycHTNLhWw02xMAMj1HgrpaP0u7oZ2QACMKFCcBDByH0RUmmB6/vTq5a62vYxZ
         UKDNBDnK7Ng4IBZZVsU28yITdmdu3kWiL1gF3Z2tqLrtetRiLuRuumrFlrF6l2Go9Gn3
         3qlQ==
X-Gm-Message-State: AIkVDXKEUAvGhMLFJBgyzBZiGd+X8d1ixLJwEMuvZIqPwaR3tcMMp40Q2mEPjzQ5Cw+vrg==
X-Received: by 10.176.83.153 with SMTP id k25mr17699146uaa.141.1485322066657;
        Tue, 24 Jan 2017 21:27:46 -0800 (PST)
Received: from linuxerio.cabletica.com (ip203-162-64-186.ct.co.cr. [186.64.162.203])
        by smtp.gmail.com with ESMTPSA id d9sm8794212uag.4.2017.01.24.21.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2017 21:27:46 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     apelisse@gmail.com, kevin@sb.org, gitster@pobox.com, peff@peff.net,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1 1/3] blame: add --aggregate option
Date:   Tue, 24 Jan 2017 23:27:32 -0600
Message-Id: <20170125052734.17550-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.11.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid taking up so much space on normal output printing duplicate
information on consecutive lines that "belong" to the same revision,
this option allows to print a single line with the information about
the revision before the lines of content themselves.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/blame-options.txt |  4 ++
 Documentation/git-blame.txt     |  4 +-
 builtin/blame.c                 | 85 +++++++++++++++++++++++++++--------------
 3 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 2669b87c9..be2a327ff 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -49,6 +49,10 @@ include::line-range-format.txt[]
 	Show the result incrementally in a format designed for
 	machine consumption.
 
+--aggregate::
+	Aggregate information about revisions. This option makes no
+	difference on incremental or porcelain format.
+
 --encoding=<encoding>::
 	Specifies the encoding used to output author names
 	and commit summaries. Setting it to `none` makes blame
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index fdc3aea30..385eaf7be 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
-	    [--] <file>
+	    [--progress] [--abbrev=<n>] [--aggregate] 
+	    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/builtin/blame.c b/builtin/blame.c
index 126b8c9e5..09b3b0c8a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1884,6 +1884,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 01000
+#define OUTPUT_AGGREGATE      02000
 
 static void emit_porcelain_details(struct origin *suspect, int repeat)
 {
@@ -1931,43 +1932,41 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
-static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
-{
-	int cnt;
-	const char *cp;
-	struct origin *suspect = ent->suspect;
-	struct commit_info ci;
-	char hex[GIT_SHA1_HEXSZ + 1];
-	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
-
-	get_commit_info(suspect->commit, &ci, 1);
-	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
-
-	cp = nth_line(sb, ent->lno);
-	for (cnt = 0; cnt < ent->num_lines; cnt++) {
-		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
-
-		if (suspect->commit->object.flags & UNINTERESTING) {
+/**
+ * Print information about the revision.
+ * This information can be used in either aggregated output
+ * or prepending each line of the content of the file being blamed
+ * 
+ * if line_number == 0, it's an aggregate line
+ */
+static void print_revision_info(char* revision_hex, int revision_length, struct blame_entry* ent,
+		struct commit_info ci, int opt, int show_raw_time, int line_number)
+{
+	if (!line_number)
+		printf("\t");
+	int length = revision_length;
+	if (!line_number || !(opt & OUTPUT_AGGREGATE)) {
+		if (ent->suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
-				memset(hex, ' ', length);
+				memset(revision_hex, ' ', length);
 			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
 				length--;
 				putchar('^');
 			}
 		}
 
-		printf("%.*s", length, hex);
+		printf("%.*s", length, revision_hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
 				name = ci.author_mail.buf;
 			else
 				name = ci.author.buf;
-			printf("\t(%10s\t%10s\t%d)", name,
+			printf("\t(%10s\t%10s", name,
 			       format_time(ci.author_time, ci.author_tz.buf,
-					   show_raw_time),
-			       ent->lno + 1 + cnt);
+					   show_raw_time));
+			if (line_number)
+				printf("\t%d)", line_number);
 		} else {
 			if (opt & OUTPUT_SHOW_SCORE)
 				printf(" %*d %02d",
@@ -1975,10 +1974,10 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 				       ent->suspect->refcnt);
 			if (opt & OUTPUT_SHOW_NAME)
 				printf(" %-*.*s", longest_file, longest_file,
-				       suspect->path);
-			if (opt & OUTPUT_SHOW_NUMBER)
+				       ent->suspect->path);
+			if ((opt & OUTPUT_SHOW_NUMBER) && line_number)
 				printf(" %*d", max_orig_digits,
-				       ent->s_lno + 1 + cnt);
+				       line_number);
 
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
@@ -1994,9 +1993,38 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 						   ci.author_tz.buf,
 						   show_raw_time));
 			}
-			printf(" %*d) ",
-			       max_digits, ent->lno + 1 + cnt);
+			if (line_number)
+				printf(" %*d) ",
+					   max_digits, line_number);
 		}
+	}
+	if (line_number && (opt & OUTPUT_AGGREGATE))
+		printf(opt & OUTPUT_ANNOTATE_COMPAT ? "%*d)" : " %*d) ",
+			   max_digits, line_number);
+	if (!line_number)
+		printf(")\n");
+}
+
+static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
+{
+	int cnt;
+	const char *cp;
+	struct origin *suspect = ent->suspect;
+	struct commit_info ci;
+	char hex[GIT_SHA1_HEXSZ + 1];
+	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	int revision_length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
+
+	get_commit_info(suspect->commit, &ci, 1);
+	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
+
+	if (opt & OUTPUT_AGGREGATE)
+		print_revision_info(hex, revision_length, ent, ci, opt, show_raw_time, 0);
+
+	cp = nth_line(sb, ent->lno);
+	char ch;
+	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+		print_revision_info(hex, revision_length, ent, ci, opt, show_raw_time, ent->lno + 1 + cnt);
 		do {
 			ch = *cp++;
 			putchar(ch);
@@ -2609,6 +2637,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
+		OPT_BIT(0, "aggregate", &output_option, N_("Aggregate output"), OUTPUT_AGGREGATE),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
-- 
2.11.0.rc1

