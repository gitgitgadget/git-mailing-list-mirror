From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] builtin-commit.c: do not remove COMMIT_EDITMSG
Date: Fri, 16 Jan 2009 20:40:05 +0100
Message-ID: <1232134805-19597-1-git-send-email-s-beyer@gmx.net>
Cc: krh@redhat.com, gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 20:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNuZc-00086A-OJ
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 20:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbZAPTkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 14:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbZAPTkN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 14:40:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:33370 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754424AbZAPTkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 14:40:11 -0500
Received: (qmail invoked by alias); 16 Jan 2009 19:40:08 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp018) with SMTP; 16 Jan 2009 20:40:08 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19zoq46V/1zHsdisPmqGeSFEXoHCogT94yky8HwjG
	eapkwAd3TxCRb6
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNuY1-00058F-3z; Fri, 16 Jan 2009 20:40:05 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105990>

git-commit tries to remove the file ./COMMIT_EDITMSG instead of
$GIT_DIR/COMMIT_EDITMSG after commit preparation (e.g. running
hooks, launching editor).
This behavior exists since f5bbc3225c4b07 "Port git commit to C".

Some test cases (e.g. t/t7502-commit.sh) rely on the existence of
$GIT_DIR/COMMIT_EDITMSG after committing and, I guess, many people
are used to it.  So it is best not to remove it.

This patch just removes the removal of COMMIT_EDITMSG.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 builtin-commit.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e88b78f..977ea09 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -624,7 +624,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 	if (!commitable && !in_merge && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix, 0);
-		unlink(commit_editmsg);
 		return 0;
 	}
 
-- 
1.6.1.160.gecdb
