From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 3/5] Help.c add --guide option
Date: Sun,  3 Mar 2013 20:21:10 +0000
Message-ID: <1362342072-1412-4-git-send-email-philipoakley@iee.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 03 21:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCFPu-0001hv-0M
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 21:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530Ab3CCUVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 15:21:15 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:42779 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753421Ab3CCUU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 15:20:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0FAEauM1FZ8rke/2dsb2JhbABFhWe8Y30Xc4IgAQVWMwhJOR4GE4gXxn+PJINAA6cygwg
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="420373182"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 03 Mar 2013 20:20:57 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217355>

Logic, but no actions, included.

The --all commands option, if given, will display first.
The --guide option's list will then be displayed.

The common commands list is only displayed if neither option,
nor a command or guide name, is given.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index d10cbed..6089d72 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,10 +36,12 @@ enum help_format {
 static const char *html_path;
 
 static int show_all = 0;
+static int show_guides = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
 	OPT_COUNTUP('a', "all", &show_all, N_("print all available commands")),
+	OPT_COUNTUP('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -49,7 +51,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [--all] [--man|--web|--info] [command]"),
+	N_("git help [--all] [--guides] [--man|--web|--info] [command]"),
 	NULL
 };
 
@@ -429,9 +431,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_commands(colopts, &main_cmds, &other_cmds);
 		printf("%s\n", _(git_more_info_string));
+		if (!show_guides) return 0;
+	}
+	if (show_guides) {
 		return 0;
 	}
-
 	if (!argv[0]) {
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_common_cmds_help();
-- 
1.8.1.msysgit.1
