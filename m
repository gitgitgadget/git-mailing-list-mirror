From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 3/4] pretty: allow tweaking tabwidth in --expand-tabs
Date: Mon,  4 Apr 2016 17:58:36 -0700
Message-ID: <1459817917-32078-4-git-send-email-gitster@pobox.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 02:58:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFKY-0002QT-En
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 02:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbcDEA6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 20:58:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736AbcDEA6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 20:58:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84D005308D;
	Mon,  4 Apr 2016 20:58:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7C/a
	cIWmhXwRJZBShryj2VncbBA=; b=o3UHUkTFtEcaoPz5dbycwBuGsd6BFjsqAR48
	buSGvrGwBJywRFvcIcp2XCR3N4AWKsKon32kZMdjEUYnGudcBKQYjWrw+yKWI7H1
	aQuMkFAwZ24flyl7x3cBaBRo1ICn4XKRjkFeM7eAeSZiOHibk2jTvui2toY88Oxe
	5ebY2Og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	QhC1Qy6ebSbiG/tlNP5P0L2w3Lc8ZRFfffEKir/L+hCQT68306MqNeM89+MLyVP3
	ClaCDbFLU0+l7ivb8yg5+4tzgTnKoHGqKxtLUr5ZRh2fIeIXDEaugGCd2zcpUV85
	VtvxAJBjkT1rW4k6Lq0BQC48svEwBldY1tsMaj0T3bU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AE5E5308C;
	Mon,  4 Apr 2016 20:58:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BDB885308B;
	Mon,  4 Apr 2016 20:58:43 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-251-g9997610
In-Reply-To: <1459817917-32078-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8B58EBAC-FAC9-11E5-99C9-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290744>

When the local convention of the project is to use tab width that is
not 8, it may make sense to allow "git log --expand-tabs=<n>" to
tweak the output to match it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-options.txt |  9 ++++++---
 commit.h                         |  2 +-
 pretty.c                         | 15 ++++++++-------
 revision.c                       |  9 +++++++--
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index edbb02f..93ad1cd 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -42,16 +42,19 @@ people using 80-column terminals.
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
 
+--expand-tabs=<n>::
 --expand-tabs::
 --no-expand-tabs::
 	Perform a tab expansion (replace each tab with enough spaces
-	to fill to the next display column that is multiple of 8)
+	to fill to the next display column that is multiple of '<n>')
 	in the log message before showing it in the output.
+	`--expand-tabs` is a short-hand for `--expand-tabs=8`, and
+	`--no-expand-tabs` is a short-hand for `--expand-tabs=0`,
+	which disables tab expansion.
 +
 By default, tabs are expanded in pretty formats that indent the log
 message by 4 spaces (i.e.  'medium', which is the default, 'full',
-and 'fuller').  `--no-expand-tabs` option can be used to disable
-this.
+and 'fuller').
 
 ifndef::git-rev-list[]
 --notes[=<ref>]::
diff --git a/commit.h b/commit.h
index a7ef682..b06db4d 100644
--- a/commit.h
+++ b/commit.h
@@ -147,7 +147,7 @@ struct pretty_print_context {
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
-	unsigned expand_tabs_in_log:1;
+	int expand_tabs_in_log;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
diff --git a/pretty.c b/pretty.c
index b7938e0..87c4497 100644
--- a/pretty.c
+++ b/pretty.c
@@ -89,11 +89,11 @@ static void setup_commit_formats(void)
 {
 	struct cmt_fmt_map builtin_formats[] = {
 		{ "raw",	CMIT_FMT_RAW,		0,	0 },
-		{ "medium",	CMIT_FMT_MEDIUM,	0,	1 },
+		{ "medium",	CMIT_FMT_MEDIUM,	0,	8 },
 		{ "short",	CMIT_FMT_SHORT,		0,	0 },
 		{ "email",	CMIT_FMT_EMAIL,		0,	0 },
-		{ "fuller",	CMIT_FMT_FULLER,	0,	1 },
-		{ "full",	CMIT_FMT_FULL,		0,	1 },
+		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
+		{ "full",	CMIT_FMT_FULL,		0,	8 },
 		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
 	};
 	commit_formats_len = ARRAY_SIZE(builtin_formats);
@@ -1645,7 +1645,7 @@ static int pp_utf8_width(const char *start, const char *end)
 	return width;
 }
 
-static void strbuf_add_tabexpand(struct strbuf *sb,
+static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
 				 const char *line, int linelen)
 {
 	const char *tab;
@@ -1666,7 +1666,7 @@ static void strbuf_add_tabexpand(struct strbuf *sb,
 		strbuf_add(sb, line, tab - line);
 
 		/* .. and the de-tabified tab */
-		strbuf_addchars(sb, ' ', 8 - (width % 8));
+		strbuf_addchars(sb, ' ', tabwidth - (width % tabwidth));
 
 		/* Skip over the printed part .. */
 		linelen -= tab + 1 - line;
@@ -1692,7 +1692,7 @@ static void pp_handle_indent(struct pretty_print_context *pp,
 {
 	strbuf_addchars(sb, ' ', indent);
 	if (pp->expand_tabs_in_log)
-		strbuf_add_tabexpand(sb, line, linelen);
+		strbuf_add_tabexpand(sb, pp->expand_tabs_in_log, line, linelen);
 	else
 		strbuf_add(sb, line, linelen);
 }
@@ -1723,7 +1723,8 @@ void pp_remainder(struct pretty_print_context *pp,
 		if (indent)
 			pp_handle_indent(pp, sb, indent, line, linelen);
 		else if (pp->expand_tabs_in_log)
-			strbuf_add_tabexpand(sb, line, linelen);
+			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
+					     line, linelen);
 		else
 			strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
diff --git a/revision.c b/revision.c
index da53b6c..47e9ee7 100644
--- a/revision.c
+++ b/revision.c
@@ -1415,7 +1415,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->expand_tabs_in_log = -1;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
-	revs->expand_tabs_in_log_default = 1;
+	revs->expand_tabs_in_log_default = 8;
 
 	init_grep_defaults();
 	grep_init(&revs->grep_filter, prefix);
@@ -1918,9 +1918,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--expand-tabs")) {
-		revs->expand_tabs_in_log = 1;
+		revs->expand_tabs_in_log = 8;
 	} else if (!strcmp(arg, "--no-expand-tabs")) {
 		revs->expand_tabs_in_log = 0;
+	} else if (skip_prefix(arg, "--expand-tabs=", &arg)) {
+		int val;
+		if (strtol_i(arg, 10, &val) < 0 || val < 0)
+			die("'%s': not a non-negative integer", arg);
+		revs->expand_tabs_in_log = val;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-- 
2.8.1-251-g9997610
