From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] sha1_to_hex: properly terminate the SHA1
Date: Thu, 22 Dec 2005 18:55:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221854550.20025@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 18:56:23 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpUfr-0003Ym-TY
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 18:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVLVR4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 12:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVLVR4B
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 12:56:01 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11933 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030242AbVLVR4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 12:56:00 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 86A1313FCE6; Thu, 22 Dec 2005 18:55:59 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6C99D9E3A1; Thu, 22 Dec 2005 18:55:59 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 54B0C9E231; Thu, 22 Dec 2005 18:55:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3794713FCE6; Thu, 22 Dec 2005 18:55:59 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13959>


sha1_to_hex() returns a pointer to a static buffer. Some of its users
modify that buffer by appending a newline character. Other users rely
on the fact that you can call

	printf("%s", sha1_to_hex(sha1));

Just to be on the safe side, terminate the SHA1 in sha1_to_hex().

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 sha1_file.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

3a743c154546e4937b4afdc7848d9943ec2f4148
diff --git a/sha1_file.c b/sha1_file.c
index 6011473..d451a94 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -81,6 +81,8 @@ char * sha1_to_hex(const unsigned char *
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
 	}
+	*buf = '\0';
+
 	return buffer;
 }
 
-- 
1.0.0
