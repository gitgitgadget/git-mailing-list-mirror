From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 06/10] log: --function-name pickaxe
Date: Thu, 27 Mar 2014 14:50:52 -0400
Message-ID: <62ab0f9c34eabe020ae99c7c1f69d580d9bb36d8.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:52:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFPD-00058A-4q
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046AbaC0Svz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:55 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43576 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757213AbaC0Sva (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:30 -0400
X-AuditID: 1207440c-f79656d000003eba-78-53347331d844
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 96.32.16058.13374335; Thu, 27 Mar 2014 14:51:29 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TO013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:29 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsUixO6iqGtYbBJs0HTXymLuyiYmiy/nbrFZ
	dF3pZrI4s7Wf2eJHSw+zA6vH3/cfmDyazhxl9njWu4fR4/MmOY/bz7axBLBGcdmkpOZklqUW
	6dslcGU8vbGeqeCsWcXVy4sZGxiX6HQxcnJICJhIfL/yiBnCFpO4cG89WxcjF4eQwGVGid93
	rjNBOCuZJM5/+sMGUsUm4Cyx6dd+JhBbREBc4u3xmewgRcwCCxkl3u6ZDDZKWMBYYuPBSWAN
	LAKqEme+b2EBsXkFoiTWn1kMtc5A4tOzM2A2p4CDxOT5G4FsDqBt9hIfl9pChKMlXm9dDDZG
	CKj19daTLBMY+RcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECAlCnh2M
	39bJHGIU4GBU4uF1sDAJFmJNLCuuzD3EKMHBrCTCO7cAKMSbklhZlVqUH19UmpNafIhRmoNF
	SZxXdYm6n5BAemJJanZqakFqEUyWiYNTqoExidUn+05uRHJiypsGfScJxyqz5nvha1Wetla/
	rvbue3Zp1sG3Ogu2uiye/ffzHPUpZw4wePIm9sx9GFogO2OX987voUHzX3XfzWVqmf39isK/
	HWvTd7+UZ3G5qvJwaXdUT+nPu6yMbtf/VxlWTdGpVhfoXjfhBqumkc+v9El7Z5rX+3jk8ZxV
	YinOSDTUYi4qTgQAz2RODz4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245317>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

This is similar to the pickaxe grep option (-G), but applies the
provided regex only to diff hunk headers, thereby showing only those
commits which affect a "function" with a definition line matching the
pattern. These are "functions" in the same sense as with
--function-context, i.e., they may be classes, structs, etc. depending
on the programming-language-specific pattern specified by the "diff"
attribute in .gitattributes.

builtin/log.c:
	as with pickaxe, set always_show_header when using --function-name
diff.c:
	parse option; as with pickaxe, always set the RECURSIVE option
	for --function-name
diff.h:
	include "funcname" field in struct diff_options
diffcore-pickaxe.c:
	implementation of --function-name filtering (diffcore_funcname), like
	the existing diffcore_pickaxe_grep and diffcore_pickaxe_count
revision.c:
	as with pickaxe, set revs->diff to always generate diffs when
	using --function-name

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 builtin/log.c      |  2 +-
 diff.c             |  8 +++++--
 diff.h             |  1 +
 diffcore-pickaxe.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 revision.c         |  3 ++-
 5 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b97373d..78694de 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -158,7 +158,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
 
-	if (rev->diffopt.pickaxe || rev->diffopt.filter)
+	if (rev->diffopt.pickaxe || rev->diffopt.filter || rev->diffopt.funcname)
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
 		rev->always_show_header = 0;
diff --git a/diff.c b/diff.c
index f978ee7..2f6dbc1 100644
--- a/diff.c
+++ b/diff.c
@@ -3298,7 +3298,7 @@ void diff_setup_done(struct diff_options *options)
 	/*
 	 * Also pickaxe would not work very well if you do not say recursive
 	 */
-	if (options->pickaxe)
+	if (options->pickaxe || options->funcname)
 		DIFF_OPT_SET(options, RECURSIVE);
 	/*
 	 * When patches are generated, submodules diffed against the work tree
@@ -3821,6 +3821,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->orderfile = optarg;
 		return argcount;
 	}
+	else if ((argcount = parse_long_opt("function-name", av, &optarg))) {
+		options->funcname = optarg;
+		return argcount;
+	}
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
@@ -4768,7 +4772,7 @@ void diffcore_std(struct diff_options *options)
 		if (options->break_opt != -1)
 			diffcore_merge_broken();
 	}
-	if (options->pickaxe)
+	if (options->pickaxe || options->funcname)
 		diffcore_pickaxe(options);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
diff --git a/diff.h b/diff.h
index 9e96fc9..0fd5f1d 100644
--- a/diff.h
+++ b/diff.h
@@ -107,6 +107,7 @@ enum diff_words_type {
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
+	const char *funcname;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 103fe6c..259a8fa 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -67,6 +67,12 @@ struct diffgrep_cb {
 	int hit;
 };
 
+struct funcname_cb {
+	struct userdiff_funcname *pattern;
+	regex_t *regex;
+	int hit;
+};
+
 static void diffgrep_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffgrep_cb *data = priv;
@@ -88,6 +94,20 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 	line[len] = hold;
 }
 
+static void match_funcname(void *priv, char *line, unsigned long len)
+{
+	regmatch_t regmatch;
+	int hold;
+	struct funcname_cb *data = priv;
+	hold = line[len];
+	line[len] = '\0';
+
+	if (line[0] == '@' && line[1] == '@')
+		if (!regexec(data->regex, line, 1, &regmatch, 0))
+			data->hit = 1;
+	line[len] = hold;
+}
+
 static int diff_grep(mmfile_t *one, mmfile_t *two,
 		     struct diff_options *o,
 		     struct fn_options *fno)
@@ -117,6 +137,38 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	return ecbdata.hit;
 }
 
+static int diff_funcname_filter(mmfile_t *one, mmfile_t *two,
+				struct diff_options *o,
+				struct fn_options *fno)
+{
+	struct funcname_cb ecbdata;
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+
+	mmfile_t empty;
+	empty.ptr = "";
+	empty.size = 0;
+	if (!one)
+		one = &empty;
+	if (!two)
+		two = &empty;
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	ecbdata.regex = fno->regex;
+	ecbdata.hit = 0;
+	xecfg.ctxlen = o->context;
+
+	if (fno->funcname_pattern)
+		xdiff_set_find_func(&xecfg, fno->funcname_pattern->pattern,
+					    fno->funcname_pattern->cflags);
+	xecfg.interhunkctxlen = o->interhunkcontext;
+	if (!(one && two))
+		xecfg.flags = XDL_EMIT_FUNCCONTEXT;
+	xecfg.flags |= XDL_EMIT_FUNCNAMES;
+	xdi_diff_outf(one, two, match_funcname, &ecbdata, &xpp, &xecfg);
+	return ecbdata.hit;
+}
+
 static void diffcore_pickaxe_grep(struct diff_options *o)
 {
 	regex_t regex;
@@ -204,7 +256,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mmfile_t mf1, mf2;
 	int ret;
 
-	if (!o->pickaxe[0])
+	if (o->pickaxe && !o->pickaxe[0])
 		return 0;
 
 	/* ignore unmerged */
@@ -280,11 +332,24 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 	return;
 }
 
+static void diffcore_funcname(struct diff_options *o)
+{
+	struct fn_options fno;
+	regex_t regex;
+
+	fno.regex = &regex;
+	compile_regex(&regex, o->funcname, REG_EXTENDED | REG_NEWLINE);
+	pickaxe(&diff_queued_diff, o, diff_funcname_filter, &fno);
+	regfree(&regex);
+}
+
 void diffcore_pickaxe(struct diff_options *o)
 {
+	if (o->funcname)
+		diffcore_funcname(o);
 	/* Might want to warn when both S and G are on; I don't care... */
 	if (o->pickaxe_opts & DIFF_PICKAXE_KIND_G)
 		diffcore_pickaxe_grep(o);
-	else
+	else if (o-> pickaxe_opts & DIFF_PICKAXE_KIND_S)
 		diffcore_pickaxe_count(o);
 }
diff --git a/revision.c b/revision.c
index 8508550..d81d9b9 100644
--- a/revision.c
+++ b/revision.c
@@ -2211,8 +2211,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
 
-	/* Pickaxe, diff-filter and rename following need diffs */
+	/* Pickaxe, funcname, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
+	    revs->diffopt.funcname ||
 	    revs->diffopt.filter ||
 	    DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 		revs->diff = 1;
-- 
1.7.12.4 (Apple Git-37)
