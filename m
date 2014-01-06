From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/17] safe_create_leading_directories(): add explicit "slash" pointer
Date: Mon,  6 Jan 2014 14:45:21 +0100
Message-ID: <1389015935-21936-4-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:53:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AcN-0001Cc-Km
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbaAFNxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:53:20 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43546 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbaAFNxS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:53:18 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 08:53:18 EST
X-AuditID: 1207440c-b7f566d000004272-4c-52cab3a75d0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.06.17010.7A3BAC25; Mon,  6 Jan 2014 08:46:15 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP4021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:14 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLt886kgg3/fLCy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzFl3dwlIwk7vi089PLA2M/RxdjJwcEgImEkcbN7BC2GISF+6tZ+ti5OIQErjMKLGx
	uYcdwjnGJLHkch8TSBWbgK7Eop5mMFtEQE1iYtshFpAiZoHFjBJd074xgiSEBSIldu+9BGRz
	cLAIqEocXhgIEuYVcJHYceQ/E0hYQkBBYvV1IZAwp4CrxLRph9lAbCGgkjWHHrFMYORdwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkpHh2MH5bJ3OIUYCDUYmH1+PZ
	ySAh1sSy4srcQ4ySHExKorycq08FCfEl5adUZiQWZ8QXleakFh9ilOBgVhLh5VoAlONNSays
	Si3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfBu2ATUKFiUmp5akZaZU4KQZuLg
	BBFcIBt4gDbMACnkLS5IzC3OTIcoOsWoKCXOOwUkIQCSyCjNgxsAi/5XjOJA/wjzbgGp4gEm
	DrjuV0CDmYAGh8aBDS5JREhJNTC2eU48ls620963MGb57SjxaVtTCz8ZqM2cvjxk8VZGUaaL
	LyeLGiq+9r3lINk778WhBSoy3fu9E45VxEwWe7NmwfWaUzPLZ58S2aSfd6Z3/3Hlpdffr2Y/
	EZDIWDRR+e7kEJ+G8L6U+dfCVsYtmcHNuvOORKifVHt1woqtM6ec7J74YNvmbWmz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240006>

Keep track of the position of the slash character independently of
"pos", thereby making the purpose of each variable clearer and
working towards other upcoming changes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index cc9957e..197766d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -111,19 +111,21 @@ int safe_create_leading_directories(char *path)
 
 	while (pos) {
 		struct stat st;
+		char *slash = strchr(pos, '/');
 
-		pos = strchr(pos, '/');
-		if (!pos)
+		if (!slash)
 			break;
-		while (*++pos == '/')
-			;
+		while (*(slash + 1) == '/')
+			slash++;
+		pos = slash + 1;
 		if (!*pos)
 			break;
-		*--pos = '\0';
+
+		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
 			if (!S_ISDIR(st.st_mode)) {
-				*pos = '/';
+				*slash = '/';
 				return -3;
 			}
 		} else if (mkdir(path, 0777)) {
@@ -131,14 +133,14 @@ int safe_create_leading_directories(char *path)
 			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
 				; /* somebody created it since we checked */
 			} else {
-				*pos = '/';
+				*slash = '/';
 				return -1;
 			}
 		} else if (adjust_shared_perm(path)) {
-			*pos = '/';
+			*slash = '/';
 			return -2;
 		}
-		*pos++ = '/';
+		*slash = '/';
 	}
 	return 0;
 }
-- 
1.8.5.2
