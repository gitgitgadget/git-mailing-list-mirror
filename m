From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Avoid misleading success message on error
Date: Wed, 21 Dec 2005 17:53:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512211752340.16125@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Dec 21 17:55:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep7Da-0000JW-08
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 17:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVLUQxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 11:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVLUQxb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 11:53:31 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43754 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751141AbVLUQxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 11:53:31 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3AF4913FAC1; Wed, 21 Dec 2005 17:53:30 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1F0129E223; Wed, 21 Dec 2005 17:53:30 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 09E159E20A; Wed, 21 Dec 2005 17:53:30 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C878E13FAC1; Wed, 21 Dec 2005 17:53:29 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13880>


When a push fails (for example when the remote head does not fast forward 
to the desired ref) it is not correct to print "Everything up-to-date".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

67819bb187daa5a976bc3d721d5c9f920f52e4ba
diff --git a/send-pack.c b/send-pack.c
index a41bbe5..5bc2f01 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -272,7 +272,7 @@ static int send_pack(int in, int out, in
 	packet_flush(out);
 	if (new_refs)
 		pack_objects(out, remote_refs);
-	else
+	else if (ret == 0)
 		fprintf(stderr, "Everything up-to-date\n");
 	close(out);
 	return ret;
-- 
0.99.9.GIT
