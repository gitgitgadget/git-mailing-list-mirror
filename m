From: Holger Eitzenberger <holger@my-eitzenberger.de>
Subject: [PATCH 1/1] git_mkstemp() fix
Date: Mon, 08 Aug 2005 22:33:08 +0200
Message-ID: <42F7C184.1000902@my-eitzenberger.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000304090709030105030800"
X-From: git-owner@vger.kernel.org Mon Aug 08 22:34:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2EJ7-0005HT-4O
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 22:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVHHUdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 16:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVHHUdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 16:33:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:44494 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932127AbVHHUdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 16:33:08 -0400
Received: from p54A39098.dip0.t-ipconnect.de [84.163.144.152] (helo=[192.168.11.11])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML21M-1E2EIz0sLV-0000Yy; Mon, 08 Aug 2005 22:33:05 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050715)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304090709030105030800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

attached is a bugfix for the newly introduced git_mkstemp() function.

/holger

--------------000304090709030105030800
Content-Type: text/x-patch;
 name="git_mkstemp_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git_mkstemp_fix.patch"

git_mkstemp() bugfix

---
commit 8cccfa75e0095afd2dd4ec354f2786068c9e7a2f
tree 354e00b03039e0c42284442c9764dcd3bf8f608f
parent d59a6043a8a7aed97c684fb4f14fe5221df1fcaf
author Holger Eitzenberger <holger@my-eitzenberger.de> Mon, 08 Aug 2005 23:29:28 +0200
committer Holger Eitzenberger <holger@jonathan.my-eitzenberger.de> Mon, 08 Aug 2005 23:29:28 +0200

 path.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
--- a/path.c
+++ b/path.c
@@ -68,8 +68,13 @@ int git_mkstemp(char *path, size_t len, 
 	if ((env = getenv("TMPDIR")) == NULL) {
 		strcpy(pch, "/tmp/");
 		len -= 5;
-	} else
-		len -= snprintf(pch, len, "%s/", env);
+		pch += 5;
+	} else {
+		size_t n = snprintf(pch, len, "%s/", env);
+
+		len -= n;
+		pch += n;
+	}
 
 	safe_strncpy(pch, template, len);
 

--------------000304090709030105030800--
