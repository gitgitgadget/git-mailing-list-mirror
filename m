From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 02/86] diff: replace prefixcmp() with starts_with()
Date: Sun, 17 Nov 2013 23:05:54 +0100
Message-ID: <20131117220719.4386.53158.chriscool@tuxfamily.org>
References: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:05:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisUS-0002aL-M3
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab3KSVFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:05:34 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36255 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202Ab3KSVFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:05:32 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 0B20766;
	Tue, 19 Nov 2013 22:05:31 +0100 (CET)
X-git-sha1: f608173d159b1aeb0ebc45ad4012df7f1b94b3b1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238045>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c | 56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/diff.c b/diff.c
index a04a34d..4b42997 100644
--- a/diff.c
+++ b/diff.c
@@ -235,7 +235,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
+	if (starts_with(var, "diff.color.") || starts_with(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
 		if (slot < 0)
 			return 0;
@@ -264,7 +264,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!prefixcmp(var, "submodule."))
+	if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
 	return git_default_config(var, value, cb);
@@ -1215,7 +1215,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->plus);
 			return;
-		} else if (!prefixcmp(line, "\\ ")) {
+		} else if (starts_with(line, "\\ ")) {
 			/*
 			 * Eat the "no newline at eof" marker as if we
 			 * saw a "+" or "-" line with nothing on it,
@@ -2387,9 +2387,9 @@ static void builtin_diff(const char *name_a,
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
 		if (!diffopts)
 			;
-		else if (!prefixcmp(diffopts, "--unified="))
+		else if (starts_with(diffopts, "--unified="))
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
-		else if (!prefixcmp(diffopts, "-u"))
+		else if (starts_with(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
@@ -3388,7 +3388,7 @@ int parse_long_opt(const char *opt, const char **argv,
 	if (arg[0] != '-' || arg[1] != '-')
 		return 0;
 	arg += strlen("--");
-	if (prefixcmp(arg, opt))
+	if (!starts_with(arg, opt))
 		return 0;
 	arg += strlen(opt);
 	if (*arg == '=') { /* sticked form: --option=value */
@@ -3419,7 +3419,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 
 	switch (*arg) {
 	case '-':
-		if (!prefixcmp(arg, "-width")) {
+		if (starts_with(arg, "-width")) {
 			arg += strlen("-width");
 			if (*arg == '=')
 				width = strtoul(arg + 1, &end, 10);
@@ -3429,7 +3429,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 				width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
-		} else if (!prefixcmp(arg, "-name-width")) {
+		} else if (starts_with(arg, "-name-width")) {
 			arg += strlen("-name-width");
 			if (*arg == '=')
 				name_width = strtoul(arg + 1, &end, 10);
@@ -3439,7 +3439,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 				name_width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
-		} else if (!prefixcmp(arg, "-graph-width")) {
+		} else if (starts_with(arg, "-graph-width")) {
 			arg += strlen("-graph-width");
 			if (*arg == '=')
 				graph_width = strtoul(arg + 1, &end, 10);
@@ -3449,7 +3449,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 				graph_width = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
-		} else if (!prefixcmp(arg, "-count")) {
+		} else if (starts_with(arg, "-count")) {
 			arg += strlen("-count");
 			if (*arg == '=')
 				count = strtoul(arg + 1, &end, 10);
@@ -3611,15 +3611,15 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
 	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
 		return parse_dirstat_opt(options, "");
-	else if (!prefixcmp(arg, "-X"))
+	else if (starts_with(arg, "-X"))
 		return parse_dirstat_opt(options, arg + 2);
-	else if (!prefixcmp(arg, "--dirstat="))
+	else if (starts_with(arg, "--dirstat="))
 		return parse_dirstat_opt(options, arg + 10);
 	else if (!strcmp(arg, "--cumulative"))
 		return parse_dirstat_opt(options, "cumulative");
 	else if (!strcmp(arg, "--dirstat-by-file"))
 		return parse_dirstat_opt(options, "files");
-	else if (!prefixcmp(arg, "--dirstat-by-file=")) {
+	else if (starts_with(arg, "--dirstat-by-file=")) {
 		parse_dirstat_opt(options, "files");
 		return parse_dirstat_opt(options, arg + 18);
 	}
@@ -3636,17 +3636,17 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	else if (!prefixcmp(arg, "--stat"))
+	else if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
 
 	/* renames options */
-	else if (!prefixcmp(arg, "-B") || !prefixcmp(arg, "--break-rewrites=") ||
+	else if (starts_with(arg, "-B") || starts_with(arg, "--break-rewrites=") ||
 		 !strcmp(arg, "--break-rewrites")) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -B: %s", arg+2);
 	}
-	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--find-renames=") ||
+	else if (starts_with(arg, "-M") || starts_with(arg, "--find-renames=") ||
 		 !strcmp(arg, "--find-renames")) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -M: %s", arg+2);
@@ -3655,7 +3655,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
 		options->irreversible_delete = 1;
 	}
-	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--find-copies=") ||
+	else if (starts_with(arg, "-C") || starts_with(arg, "--find-copies=") ||
 		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
@@ -3671,7 +3671,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, RENAME_EMPTY);
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
-	else if (!prefixcmp(arg, "--relative=")) {
+	else if (starts_with(arg, "--relative=")) {
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 		options->prefix = arg + 11;
 	}
@@ -3724,7 +3724,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
-	else if (!prefixcmp(arg, "--color=")) {
+	else if (starts_with(arg, "--color=")) {
 		int value = git_config_colorbool(NULL, arg+8);
 		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
@@ -3736,7 +3736,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
-	else if (!prefixcmp(arg, "--color-words=")) {
+	else if (starts_with(arg, "--color-words=")) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 		options->word_regex = arg + 14;
@@ -3745,7 +3745,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
 	}
-	else if (!prefixcmp(arg, "--word-diff=")) {
+	else if (starts_with(arg, "--word-diff=")) {
 		const char *type = arg + 12;
 		if (!strcmp(type, "plain"))
 			options->word_diff = DIFF_WORDS_PLAIN;
@@ -3781,12 +3781,12 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--ignore-submodules")) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, "all");
-	} else if (!prefixcmp(arg, "--ignore-submodules=")) {
+	} else if (starts_with(arg, "--ignore-submodules=")) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, arg + 20);
 	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
-	else if (!prefixcmp(arg, "--submodule="))
+	else if (starts_with(arg, "--submodule="))
 		return parse_submodule_opt(options, arg + 12);
 
 	/* misc options */
@@ -3822,7 +3822,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
-	else if (!prefixcmp(arg, "--abbrev=")) {
+	else if (starts_with(arg, "--abbrev=")) {
 		options->abbrev = strtoul(arg + 9, NULL, 10);
 		if (options->abbrev < MINIMUM_ABBREV)
 			options->abbrev = MINIMUM_ABBREV;
@@ -3904,15 +3904,15 @@ static int diff_scoreopt_parse(const char *opt)
 	cmd = *opt++;
 	if (cmd == '-') {
 		/* convert the long-form arguments into short-form versions */
-		if (!prefixcmp(opt, "break-rewrites")) {
+		if (starts_with(opt, "break-rewrites")) {
 			opt += strlen("break-rewrites");
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'B';
-		} else if (!prefixcmp(opt, "find-copies")) {
+		} else if (starts_with(opt, "find-copies")) {
 			opt += strlen("find-copies");
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
-		} else if (!prefixcmp(opt, "find-renames")) {
+		} else if (starts_with(opt, "find-renames")) {
 			opt += strlen("find-renames");
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'M';
@@ -4322,7 +4322,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 	int new_len;
 
 	/* Ignore line numbers when computing the SHA1 of the patch */
-	if (!prefixcmp(line, "@@ -"))
+	if (starts_with(line, "@@ -"))
 		return;
 
 	new_len = remove_space(line, len);
-- 
1.8.4.1.561.g12affca
