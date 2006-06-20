From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] repo-config: Fix late-night bug
Date: Tue, 20 Jun 2006 09:45:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606200945140.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 09:46:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsavt-0002w5-VS
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 09:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWFTHpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 03:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWFTHpz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 03:45:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56192 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932166AbWFTHpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 03:45:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 743E91EBB;
	Tue, 20 Jun 2006 09:45:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 685EE1D6C;
	Tue, 20 Jun 2006 09:45:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4D3C612AE;
	Tue, 20 Jun 2006 09:45:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22176>


This bug was hidden by the "future-proofing" of the test. Sigh.

When neither GIT_CONFIG nor GIT_CONFIG_LOCAL is set, do not use NULL,
but $GIT_DIR/config. Instead of using $GIT_DIR/config when only
GIT_CONFIG_LOCAL is set. Sorry.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	This time, "only" repo-config was affected, _not_ all users of
	the config file.

 repo-config.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/repo-config.c b/repo-config.c
index 03f108f..ab8f1af 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -74,8 +74,6 @@ static int get_value(const char* key_, c
 		const char *home = getenv("HOME");
 		local = getenv("GIT_CONFIG_LOCAL");
 		if (!local)
-			local = repo_config;
-		else
 			local = repo_config = strdup(git_path("config"));
 		if (home)
 			global = strdup(mkpath("%s/.gitconfig", home));
-- 
1.4.0.g59268-dirty
