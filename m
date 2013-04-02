From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 2/5] Help.c use OPT_BOOL and refactor logic
Date: Tue,  2 Apr 2013 23:39:49 +0100
Message-ID: <1364942392-576-3-git-send-email-philipoakley@iee.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9sX-00037Z-1L
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933476Ab3DBWjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 18:39:51 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:25698 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933458Ab3DBWjm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 18:39:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmwJAPtcW1FOl3a6/2dsb2JhbABDgweCbb1WBAGBBBd0giABBVYjEAhJOR4GE4gYsWuQE41VJ4EdB4NAA6BehxiBL4FdO4Eu
X-IronPort-AV: E=Sophos;i="4.87,396,1363132800"; 
   d="scan'208";a="419706606"
Received: from host-78-151-118-186.as13285.net (HELO localhost) ([78.151.118.186])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 02 Apr 2013 23:39:39 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219899>

Rename deprecated OPT_BOOLEAN option to OPT_BOOL in preparation for
'git help --guides'. The former OPT_BOOLEAN would now be OPT_COUNTUP,
but that capability is not required.

Separate out the show_all 'return(0)' and git_more_info_string logic
ready for inclusion of show_guides.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index d1d7181..8969d3b 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -39,7 +39,7 @@ static int show_all = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
-	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")),
+	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -428,7 +428,13 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		git_config(git_help_config, NULL);
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_commands(colopts, &main_cmds, &other_cmds);
+	}
+
+	if (show_all) {
 		printf("%s\n", _(git_more_info_string));
+		/*
+		* We're done. Ignore any remaining args
+		*/
 		return 0;
 	}
 
-- 
1.8.1.msysgit.1
