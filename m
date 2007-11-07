From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH DIFF-CLEANUP 2/2] Reorder diff_opt_parse options more logically per topics.
Date: Wed,  7 Nov 2007 11:20:32 +0100
Message-ID: <1194430832-6224-8-git-send-email-madcoder@debian.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
 <1194430832-6224-2-git-send-email-madcoder@debian.org>
 <1194430832-6224-3-git-send-email-madcoder@debian.org>
 <1194430832-6224-4-git-send-email-madcoder@debian.org>
 <1194430832-6224-5-git-send-email-madcoder@debian.org>
 <1194430832-6224-6-git-send-email-madcoder@debian.org>
 <1194430832-6224-7-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi2Y-0001LP-86
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbXKGKUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbXKGKUq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:46 -0500
Received: from pan.madism.org ([88.191.52.104]:35309 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805AbXKGKUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:36 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C330528E28;
	Wed,  7 Nov 2007 11:20:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3C3F21CAA3; Wed,  7 Nov 2007 11:20:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
In-Reply-To: <1194430832-6224-7-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63799>

This is a line reordering patch _only_.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
    the 10 added lines are five times a blank line and a header for the each
    of the 5 options groups.

    This patch is very useful as it will help checking that I didn't missed
    any option while converting to parseopt, it's not coquetry.

 diff.c |  116 ++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/diff.c b/diff.c
index 97c9a59..7a89959 100644
--- a/diff.c
+++ b/diff.c
@@ -2198,6 +2198,8 @@ static int diff_scoreopt_parse(const char *opt);
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
+
+	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
 		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
@@ -2210,6 +2212,18 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
+	else if (!strcmp(arg, "--check"))
+		options->output_format |= DIFF_FORMAT_CHECKDIFF;
+	else if (!strcmp(arg, "--summary"))
+		options->output_format |= DIFF_FORMAT_SUMMARY;
+	else if (!strcmp(arg, "--patch-with-stat"))
+		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT;
+	else if (!strcmp(arg, "--name-only"))
+		options->output_format |= DIFF_FORMAT_NAME;
+	else if (!strcmp(arg, "--name-status"))
+		options->output_format |= DIFF_FORMAT_NAME_STATUS;
+	else if (!strcmp(arg, "-s"))
+		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (!prefixcmp(arg, "--stat")) {
 		char *end;
 		int width = options->stat_width;
@@ -2237,42 +2251,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->stat_name_width = name_width;
 		options->stat_width = width;
 	}
-	else if (!strcmp(arg, "--check"))
-		options->output_format |= DIFF_FORMAT_CHECKDIFF;
-	else if (!strcmp(arg, "--summary"))
-		options->output_format |= DIFF_FORMAT_SUMMARY;
-	else if (!strcmp(arg, "--patch-with-stat"))
-		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT;
-	else if (!strcmp(arg, "-z"))
-		options->line_termination = 0;
-	else if (!prefixcmp(arg, "-l"))
-		options->rename_limit = strtoul(arg+2, NULL, 10);
-	else if (!strcmp(arg, "--full-index"))
-		DIFF_OPT_SET(options, FULL_INDEX);
-	else if (!strcmp(arg, "--binary")) {
-		options->output_format |= DIFF_FORMAT_PATCH;
-		DIFF_OPT_SET(options, BINARY);
-	}
-	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
-		DIFF_OPT_SET(options, TEXT);
-	else if (!strcmp(arg, "--name-only"))
-		options->output_format |= DIFF_FORMAT_NAME;
-	else if (!strcmp(arg, "--name-status"))
-		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-R"))
-		DIFF_OPT_SET(options, REVERSE_DIFF);
-	else if (!prefixcmp(arg, "-S"))
-		options->pickaxe = arg + 2;
-	else if (!strcmp(arg, "-s"))
-		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	else if (!prefixcmp(arg, "-O"))
-		options->orderfile = arg + 2;
-	else if (!prefixcmp(arg, "--diff-filter="))
-		options->filter = arg + 14;
-	else if (!strcmp(arg, "--pickaxe-all"))
-		options->pickaxe_opts = DIFF_PICKAXE_ALL;
-	else if (!strcmp(arg, "--pickaxe-regex"))
-		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
+
+	/* renames options */
 	else if (!prefixcmp(arg, "-B")) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return -1;
@@ -2289,33 +2269,38 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 			return -1;
 		options->detect_rename = DIFF_DETECT_COPY;
 	}
+	else if (!strcmp(arg, "--no-renames"))
+		options->detect_rename = 0;
+
+	/* xdiff options */
+	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
+		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
+		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--ignore-space-at-eol"))
+		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+
+	/* flags options */
+	else if (!strcmp(arg, "--binary")) {
+		options->output_format |= DIFF_FORMAT_PATCH;
+		DIFF_OPT_SET(options, BINARY);
+	}
+	else if (!strcmp(arg, "--full-index"))
+		DIFF_OPT_SET(options, FULL_INDEX);
+	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
+		DIFF_OPT_SET(options, TEXT);
+	else if (!strcmp(arg, "-R"))
+		DIFF_OPT_SET(options, REVERSE_DIFF);
 	else if (!strcmp(arg, "--find-copies-harder"))
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
-	else if (!strcmp(arg, "--abbrev"))
-		options->abbrev = DEFAULT_ABBREV;
-	else if (!prefixcmp(arg, "--abbrev=")) {
-		options->abbrev = strtoul(arg + 9, NULL, 10);
-		if (options->abbrev < MINIMUM_ABBREV)
-			options->abbrev = MINIMUM_ABBREV;
-		else if (40 < options->abbrev)
-			options->abbrev = 40;
-	}
 	else if (!strcmp(arg, "--color"))
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--no-color"))
 		DIFF_OPT_CLR(options, COLOR_DIFF);
-	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
-	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
-	else if (!strcmp(arg, "--ignore-space-at-eol"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--color-words"))
 		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
-	else if (!strcmp(arg, "--no-renames"))
-		options->detect_rename = 0;
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
@@ -2324,6 +2309,31 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
 		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
+
+	/* misc options */
+	else if (!strcmp(arg, "-z"))
+		options->line_termination = 0;
+	else if (!prefixcmp(arg, "-l"))
+		options->rename_limit = strtoul(arg+2, NULL, 10);
+	else if (!prefixcmp(arg, "-S"))
+		options->pickaxe = arg + 2;
+	else if (!strcmp(arg, "--pickaxe-all"))
+		options->pickaxe_opts = DIFF_PICKAXE_ALL;
+	else if (!strcmp(arg, "--pickaxe-regex"))
+		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
+	else if (!prefixcmp(arg, "-O"))
+		options->orderfile = arg + 2;
+	else if (!prefixcmp(arg, "--diff-filter="))
+		options->filter = arg + 14;
+	else if (!strcmp(arg, "--abbrev"))
+		options->abbrev = DEFAULT_ABBREV;
+	else if (!prefixcmp(arg, "--abbrev=")) {
+		options->abbrev = strtoul(arg + 9, NULL, 10);
+		if (options->abbrev < MINIMUM_ABBREV)
+			options->abbrev = MINIMUM_ABBREV;
+		else if (40 < options->abbrev)
+			options->abbrev = 40;
+	}
 	else
 		return 0;
 	return 1;
-- 
1.5.3.5.1598.gdef4e
