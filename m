From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [FUN PATCH] Remove "git clone" parameters if they are the first in a git clone call
Date: Thu, 31 Jul 2008 01:02:09 +0200
Message-ID: <1217458929-84974-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOKhP-00043l-4t
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbYG3XCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 19:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbYG3XCN
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 19:02:13 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:24117 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbYG3XCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 19:02:12 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6209.online.nl (SMTP Server) with ESMTP id B848F1C00098;
	Thu, 31 Jul 2008 01:02:10 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6209.online.nl (SMTP Server) with ESMTP id 77F131C00097;
	Thu, 31 Jul 2008 01:02:10 +0200 (CEST)
X-ME-UUID: 20080730230210491.77F131C00097@mwinf6209.online.nl
X-Mailer: git-send-email 1.6.0.rc1.163.g8ec19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90871>

This removes accidental duplicate "git clone" parameters, for example
when typing:

  git clone git clone git://repo.or.cz/git.git

---

OK, so it happens often to me that I copy a line that already starts with "git
clone", and then type it myself again, paste, and hit enter. I thought it
might happen to others too, hence this patch.


 builtin-clone.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 4b1ab36..9e4c7c2 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -350,6 +350,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	junk_pid = getpid();
 
+	if (argc > 3 && !strcmp(argv[1], "git") && !strcmp(argv[2], "clone")) {
+		argv += 2;
+		argc -= 2;
+	}
+
 	argc = parse_options(argc, argv, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
-- 
1.6.0.rc1.163.g8ec19
