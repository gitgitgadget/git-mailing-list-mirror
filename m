From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting
 options
Date: Thu, 13 Sep 2012 14:21:44 -0700
Message-ID: <7vvcfh62l3.fsf@alter.siamese.dyndns.org>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org> <50509171.9060604@drmicha.warpmail.net> <7vbohbdufz.fsf@alter.siamese.dyndns.org> <50518B13.5010702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGrE-0000pE-MR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab2IMVVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:21:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab2IMVVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:21:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6C01868F;
	Thu, 13 Sep 2012 17:21:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sSD8BtSmRAZXpbpu74ffEieZrPo=; b=yDg9tG
	NHROoXqdsJh661d3PuSWL4/MTdVwWlLa97A4A7lpCT1jTVvW9sB6DBWCxdbD8Pc1
	7roDDTeFE0GjvctFihkQFBQ43XmigxCSvdMAjc6lhDdgWAd2AcaDhdFVjK0BRfXY
	BOW8fda3MII5nSmJ13ZXTAFTrnkM48NG14t2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pMj9lFL6rm1ih9GlKeqWL0u1BZG8EOau
	hF1mcZRW+1IuOjU6zLV1cg1W0c4p+pi8mi4hdmcwn9/TRoAVKZIrT8iPaetqe9qA
	E4VXy+cVb5DUZPx00QvFZcwfQFB8aiolchWsLML5AFE35f1PLGhmJEpndLG75tvi
	E0Q71UEePRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2CD2868E;
	Thu, 13 Sep 2012 17:21:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8DA8868C; Thu, 13 Sep 2012
 17:21:45 -0400 (EDT)
In-Reply-To: <50518B13.5010702@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 13 Sep 2012 09:28:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05709020-FDE9-11E1-A032-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205429>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Thanks for "this" ;)

Here is a replacement to "this", that adds the "--debug" option to
"git grep" and an equivalent "--debug-grep" to "git log" family.

-- >8 --
Subject: [PATCH] grep: teach --debug option to dump the parse tree

Our "grep" allows complex boolean expressions to be formed to match
each individual line with operators like --and, '(', ')' and --not.
Introduce the "--debug" option to show the parse tree to help people
who want to debug and enhance it.

Also "log" learns "--debug-grep" option to do the same.  The command
line parser to the log family is a lot more limited than the general
"git grep" parser, but it has special handling for header matching
(e.g. "--author"), and a parse tree is valuable when working on it.

Note that "--all-match" is *not* any individual node in the parse
tree.  It is an instruction to the evaluator to check all the nodes
in the top-level backbone have matched and reject a document as
non-matching otherwise.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c |  3 ++
 grep.c         | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 grep.h         |  1 +
 revision.c     |  2 ++
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 09ca4c9..1c6b95a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -817,6 +817,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   N_("indicate hit with exit status without output")),
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			N_("show only matches from files that match all patterns")),
+		{ OPTION_SET_INT, 0, "debug", &opt.debug, NULL,
+		  N_("show parse tree for grep expression"),
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1 },
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
diff --git a/grep.c b/grep.c
index 04e3ec6..f896d68 100644
--- a/grep.c
+++ b/grep.c
@@ -332,6 +332,87 @@ static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
 	return compile_pattern_or(list);
 }
 
+static void indent(int in)
+{
+	while (in-- > 0)
+		fputc(' ', stderr);
+}
+
+static void dump_grep_pat(struct grep_pat *p)
+{
+	switch (p->token) {
+	case GREP_AND: fprintf(stderr, "*and*"); break;
+	case GREP_OPEN_PAREN: fprintf(stderr, "*(*"); break;
+	case GREP_CLOSE_PAREN: fprintf(stderr, "*)*"); break;
+	case GREP_NOT: fprintf(stderr, "*not*"); break;
+	case GREP_OR: fprintf(stderr, "*or*"); break;
+
+	case GREP_PATTERN: fprintf(stderr, "pattern"); break;
+	case GREP_PATTERN_HEAD: fprintf(stderr, "pattern_head"); break;
+	case GREP_PATTERN_BODY: fprintf(stderr, "pattern_body"); break;
+	}
+
+	switch (p->token) {
+	default: break;
+	case GREP_PATTERN_HEAD:
+		fprintf(stderr, "<head %d>", p->field); break;
+	case GREP_PATTERN_BODY:
+		fprintf(stderr, "<body>"); break;
+	}
+	switch (p->token) {
+	default: break;
+	case GREP_PATTERN_HEAD:
+	case GREP_PATTERN_BODY:
+	case GREP_PATTERN:
+		fprintf(stderr, "%.*s", (int)p->patternlen, p->pattern);
+		break;
+	}
+	fputc('\n', stderr);
+}
+
+static void dump_grep_expression_1(struct grep_expr *x, int in)
+{
+	indent(in);
+	switch (x->node) {
+	case GREP_NODE_TRUE:
+		fprintf(stderr, "true\n");
+		break;
+	case GREP_NODE_ATOM:
+		dump_grep_pat(x->u.atom);
+		break;
+	case GREP_NODE_NOT:
+		fprintf(stderr, "(not\n");
+		dump_grep_expression_1(x->u.unary, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	case GREP_NODE_AND:
+		fprintf(stderr, "(and\n");
+		dump_grep_expression_1(x->u.binary.left, in+1);
+		dump_grep_expression_1(x->u.binary.right, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	case GREP_NODE_OR:
+		fprintf(stderr, "(or\n");
+		dump_grep_expression_1(x->u.binary.left, in+1);
+		dump_grep_expression_1(x->u.binary.right, in+1);
+		indent(in);
+		fprintf(stderr, ")\n");
+		break;
+	}
+}
+
+void dump_grep_expression(struct grep_opt *opt)
+{
+	struct grep_expr *x = opt->pattern_expression;
+
+	if (opt->all_match)
+		fprintf(stderr, "[all-match]\n");
+	dump_grep_expression_1(x, 0);
+	fflush(NULL);
+}
+
 static struct grep_expr *grep_true_expr(void)
 {
 	struct grep_expr *z = xcalloc(1, sizeof(*z));
@@ -395,7 +476,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	return header_expr;
 }
 
-void compile_grep_patterns(struct grep_opt *opt)
+static void compile_grep_patterns_real(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 	struct grep_expr *header_expr = prep_header_patterns(opt);
@@ -415,7 +496,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 
 	if (opt->all_match || header_expr)
 		opt->extended = 1;
-	else if (!opt->extended)
+	else if (!opt->extended && !opt->debug)
 		return;
 
 	p = opt->pattern_list;
@@ -432,9 +513,17 @@ void compile_grep_patterns(struct grep_opt *opt)
 	else
 		opt->pattern_expression = grep_or_expr(opt->pattern_expression,
 						       header_expr);
+
 	opt->all_match = 1;
 }
 
+void compile_grep_patterns(struct grep_opt *opt)
+{
+	compile_grep_patterns_real(opt);
+	if (opt->debug)
+		dump_grep_expression(opt);
+}
+
 static void free_pattern_expr(struct grep_expr *x)
 {
 	switch (x->node) {
diff --git a/grep.h b/grep.h
index 75afb7b..00d71f7 100644
--- a/grep.h
+++ b/grep.h
@@ -98,6 +98,7 @@ struct grep_opt {
 	int word_regexp;
 	int fixed;
 	int all_match;
+	int debug;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
diff --git a/revision.c b/revision.c
index dc3fecf..9ef9a4c 100644
--- a/revision.c
+++ b/revision.c
@@ -1598,6 +1598,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
 		return argcount;
+	} else if (!strcmp(arg, "--debug-grep")) {
+		revs->grep_filter.debug = 1;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
-- 
1.7.12.469.g5235eb6
