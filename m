From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] Restore use of 'help.format' configuration property in 'git help'
Date: Fri, 22 Jun 2012 13:48:46 +0100
Message-ID: <1340369326-1840-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 15:25:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si3rW-0005KA-W9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 15:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762091Ab2FVNZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 09:25:16 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:35140 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762083Ab2FVNZP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 09:25:15 -0400
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.2])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120622125159.TCAL15330.mtaout03-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>;
          Fri, 22 Jun 2012 13:51:59 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-1.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Si3IA-0004O3-Tp; Fri, 22 Jun 2012 13:48:50 +0100
Received: from localhost (unknown [IPv6:2a01:348:2be:0:4aa:7c5f:55b:2b3b])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pat)
	by fox.patthoyts.tk (Postfix) with ESMTPSA id E103120906;
	Fri, 22 Jun 2012 13:48:49 +0100 (BST)
X-Mailer: git-send-email 1.7.11.msysgit.0
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=ZXwdYfFnHEQA:10 a=CtgcEeagiGAA:10 a=wPDyFdB5xvgA:10 a=xqWC_Br6kY4A:10 a=FP58Ms26AAAA:8 a=oYBw7ae_xKl_xDocfOcA:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200436>

Commit 1cc8af0 "help: use HTML as the default help format on Windows"
lost the ability to make use of the help.format config value by forcing
the use of a compiled in default if no command-line argument was provided.
This commit restores the use of the help.format value if one is
available, overriding the compiled default.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 builtin/help.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 536d4fd..8f9cd60 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -449,10 +449,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
 
-	if (parsed_help_format == HELP_FORMAT_NONE)
-		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
-	else
+	if (parsed_help_format != HELP_FORMAT_NONE)
 		help_format = parsed_help_format;
+	if (help_format == HELP_FORMAT_NONE)
+		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
 
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
-- 
1.7.11.msysgit.0
