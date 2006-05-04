From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-push: --all and --tags _are_ explicit refspecs
Date: Thu, 4 May 2006 23:18:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605042317560.11836@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu May 04 23:18:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FblDI-0004SB-RO
	for gcvg-git@gmane.org; Thu, 04 May 2006 23:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWEDVSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 17:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWEDVSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 17:18:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65460 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751354AbWEDVSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 17:18:16 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id CDA631CB7;
	Thu,  4 May 2006 23:18:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id C1AA71CAD;
	Thu,  4 May 2006 23:18:14 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id A5C7B1C5D;
	Thu,  4 May 2006 23:18:14 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19577>


... so do not get refspecs from remotes/* or the config if one of them
was specified.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-push.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

42859edd0156479786e5bc4184e462a0307a67eb
diff --git a/builtin-push.c b/builtin-push.c
index 06d06ff..e530022 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -72,7 +72,7 @@ static int get_remotes_uri(const char *r
 {
 	int n = 0;
 	FILE *f = fopen(git_path("remotes/%s", repo), "r");
-	int has_explicit_refspec = refspec_nr;
+	int has_explicit_refspec = refspec_nr || all || tags;
 
 	if (!f)
 		return -1;
@@ -144,7 +144,7 @@ static int get_config_remotes_uri(const 
 	config_repo = repo;
 	config_current_uri = 0;
 	config_uri = uri;
-	config_get_refspecs = !refspec_nr;
+	config_get_refspecs = !(refspec_nr || all || tags);
 
 	git_config(get_remote_config);
 	return config_current_uri;
-- 
1.3.2.gec86-dirty
