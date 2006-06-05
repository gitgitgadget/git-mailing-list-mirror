From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Mon, 5 Jun 2006 19:46:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jun 05 19:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnJ9a-0001Mk-GH
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 19:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWFERqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 13:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWFERqL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 13:46:11 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48617 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751244AbWFERqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 13:46:10 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id E73502375;
	Mon,  5 Jun 2006 19:46:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DBB252371;
	Mon,  5 Jun 2006 19:46:09 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C10022338;
	Mon,  5 Jun 2006 19:46:09 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21325>


When calling git_setup_directory_gently, and GIT_DIR was set, it just
ignored the variable nongit_ok.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index fe7f884..74301c2 100644
--- a/setup.c
+++ b/setup.c
@@ -184,6 +184,10 @@ const char *setup_git_directory_gently(i
 		}
 		return NULL;
 	bad_dir_environ:
+		if (nongit_ok) {
+			*nongit_ok = 1;
+			return NULL;
+		}
 		path[len] = 0;
 		die("Not a git repository: '%s'", path);
 	}
-- 
1.3.3.gdb440-dirty
