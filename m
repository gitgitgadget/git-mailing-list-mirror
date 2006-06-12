From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Fix git-format-patch -s
Date: Mon, 12 Jun 2006 13:31:38 -0600
Message-ID: <m1k67m5fxh.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 21:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fps8Z-0002SW-W9
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbWFLTbp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbWFLTbp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:31:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16029 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752246AbWFLTbo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:31:44 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5CJVcJ4006896;
	Mon, 12 Jun 2006 13:31:38 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5CJVc5c006895;
	Mon, 12 Jun 2006 13:31:38 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21735>


When git-format-patch was converted to a builtin an appropriate call
to setup_ident was missed and thus git-format-patch -s fails because
it doesn't look up anything in the password file.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 builtin-log.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 29a8851..322024c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -217,8 +217,11 @@ int cmd_format_patch(int argc, const cha
 		}
 		else if (!strcmp(argv[i], "--signoff") ||
 			 !strcmp(argv[i], "-s")) {
-			const char *committer = git_committer_info(1);
-			const char *endpos = strchr(committer, '>');
+			const char *committer;
+			const char *endpos;
+			setup_ident();
+			committer = git_committer_info(1);
+			endpos = strchr(committer, '>');
 			if (!endpos)
 				die("bogos committer info %s\n", committer);
 			add_signoff = xmalloc(endpos - committer + 2);
-- 
1.4.0.g25f48-dirty
