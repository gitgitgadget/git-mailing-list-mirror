From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 1/5] Light refactoring of date infrastructure
Date: Wed, 20 Apr 2011 02:45:03 +0000
Message-ID: <650ac72c-fa55-491e-a2e8-427b04d8bee3-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 04:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNbJ-0004lY-9q
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 04:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab1DTC5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 22:57:03 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62713 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab1DTC5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 22:57:01 -0400
Received: by ewy4 with SMTP id 4so83395ewy.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=Z7lVG3p3Iaaqpavnk+SGISbqw2HM6wZeltELMM0Uwng=;
        b=XnJ/LK3nETE7jMksKrPWdRS4Z8w9UeNy8yJdTYpwwzu2bGS+JLsmJgHLMzwwrt+RKY
         NO3rY7UvYf/rntMNExGxVHVQ+AlKqUAU8aar9MOM3bjdwxqDAisLCz6QhmF+kl3SDXS8
         H4LYwvehBBeaeVJt0cMjDONPOIdh3/Z8xNDgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=xIUbPAHN6WF+qK3EL8o4JrmVV8Y5yC8DXm/HpuwYni4yRaLDY5AZAufJ3C/vMgPocI
         TBzI8R97rbAjxLsbdO4hsIjM4dObGI1pedCChgq2UlMR9x8AynXZGW0Fs+najvZajrW+
         dPK8MrHeoJJjpumqtTPlR8QaPYv7ZFCqfQ4cQ=
Received: by 10.14.4.32 with SMTP id 32mr2326311eei.141.1303268220307;
        Tue, 19 Apr 2011 19:57:00 -0700 (PDT)
Received: from gmail.com (server105708.santrex.net [188.165.236.117])
        by mx.google.com with ESMTPS id x54sm332297eeh.12.2011.04.19.19.56.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 19:56:59 -0700 (PDT)
In-Reply-To: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171832>

Date: Fri, 11 Feb 2011 18:34:29 +0000
date_mode_explicit -> date_mode_from_command_line
    It's more understandable by itself now.

DATE_NORMAL -> DATE_DEFAULT
    The user input to select this value is `default'.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 archive.c              |    2 +-
 builtin/blame.c        |    3 +--
 builtin/commit.c       |    2 +-
 builtin/for-each-ref.c |    2 +-
 builtin/shortlog.c     |    2 +-
 cache.h                |    2 +-
 date.c                 |    2 +-
 log-tree.c             |    6 +++---
 revision.c             |    4 ++--
 revision.h             |    2 +-
 submodule.c            |    2 +-
 11 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/archive.c b/archive.c
index 42f2d2f..dd871ca 100644
--- a/archive.c
+++ b/archive.c
@@ -32,7 +32,7 @@ static void format_subst(const struct commit *commit,
 	char *to_free = NULL;
 	struct strbuf fmt = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	ctx.date_mode = DATE_NORMAL;
+	ctx.date_mode = DATE_DEFAULT;
 	ctx.abbrev = DEFAULT_ABBREV;
 
 	if (src == buf->buf)
diff --git a/builtin/blame.c b/builtin/blame.c
index 4639788..dd597f4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2377,9 +2377,8 @@ parse_done:
 		blame_date_width = sizeof("2006-10-19");
 		break;
 	case DATE_RELATIVE:
-		/* "normal" is used as the fallback for "relative" */
 	case DATE_LOCAL:
-	case DATE_NORMAL:
+	case DATE_DEFAULT:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 67757e9..194db99 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -933,7 +933,7 @@ static const char *find_author_by_nickname(const char *name)
 	commit = get_revision(&revs);
 	if (commit) {
 		struct pretty_print_context ctx = {0};
-		ctx.date_mode = DATE_NORMAL;
+		ctx.date_mode = DATE_DEFAULT;
 		strbuf_release(&buf);
 		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
 		return strbuf_detach(&buf, NULL);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89e75c6..60d6b32 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -367,7 +367,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	char *zone;
 	unsigned long timestamp;
 	long tz;
-	enum date_mode date_mode = DATE_NORMAL;
+	enum date_mode date_mode = DATE_DEFAULT;
 	const char *formatp;
 
 	/*
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f5efc67..5815f55 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -165,7 +165,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.abbrev = log->abbrev;
 		ctx.subject = "";
 		ctx.after_subject = "";
-		ctx.date_mode = DATE_NORMAL;
+		ctx.date_mode = DATE_DEFAULT;
 		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
diff --git a/cache.h b/cache.h
index 5b896d9..bf639f7 100644
--- a/cache.h
+++ b/cache.h
@@ -829,7 +829,7 @@ extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
 enum date_mode {
-	DATE_NORMAL = 0,
+	DATE_DEFAULT = 0,
 	DATE_RELATIVE,
 	DATE_SHORT,
 	DATE_LOCAL,
diff --git a/date.c b/date.c
index 00f9eb5..096468f 100644
--- a/date.c
+++ b/date.c
@@ -669,7 +669,7 @@ enum date_mode parse_date_format(const char *format)
 	else if (!strcmp(format, "local"))
 		return DATE_LOCAL;
 	else if (!strcmp(format, "default"))
-		return DATE_NORMAL;
+		return DATE_DEFAULT;
 	else if (!strcmp(format, "raw"))
 		return DATE_RAW;
 	else
diff --git a/log-tree.c b/log-tree.c
index 2a1e3a9..b059446 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -272,7 +272,7 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 	if (commit) {
 		int max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
 		struct pretty_print_context ctx = {0};
-		ctx.date_mode = DATE_NORMAL;
+		ctx.date_mode = DATE_DEFAULT;
 
 		format_commit_message(commit, "%f", buf, &ctx);
 		if (max_len < buf->len)
@@ -465,9 +465,9 @@ void show_log(struct rev_info *opt)
 			 */
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format == CMIT_FMT_ONELINE,
-				    opt->date_mode_explicit ?
+				    opt->date_mode_from_command_line ?
 					opt->date_mode :
-					DATE_NORMAL);
+					DATE_DEFAULT);
 			if (opt->commit_format == CMIT_FMT_ONELINE)
 				return;
 		}
diff --git a/revision.c b/revision.c
index 541f09e..462c311 100644
--- a/revision.c
+++ b/revision.c
@@ -1434,10 +1434,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--relative-date")) {
 		revs->date_mode = DATE_RELATIVE;
-		revs->date_mode_explicit = 1;
+		revs->date_mode_from_command_line = 1;
 	} else if ((argcount = parse_long_opt("date", argv, &optarg))) {
 		revs->date_mode = parse_date_format(optarg);
-		revs->date_mode_explicit = 1;
+		revs->date_mode_from_command_line = 1;
 		return argcount;
 	} else if (!strcmp(arg, "--log-size")) {
 		revs->show_log_size = 1;
diff --git a/revision.h b/revision.h
index 9fd8f30..e5ca939 100644
--- a/revision.h
+++ b/revision.h
@@ -92,7 +92,7 @@ struct rev_info {
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
-			date_mode_explicit:1;
+			date_mode_from_command_line:1;
 	unsigned int	disable_stdin:1;
 
 	enum date_mode date_mode;
diff --git a/submodule.c b/submodule.c
index 5294cef..0a45da9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -605,7 +605,7 @@ static void print_commit(struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	ctx.date_mode = DATE_NORMAL;
+	ctx.date_mode = DATE_DEFAULT;
 	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
-- 
1.7.4.18.g68fe8
