From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Git diff cr+lf inconsistency observations
Date: Thu, 3 Jul 2014 16:10:59 -0400
Organization: PD Inc
Message-ID: <16E893BEBBE04A2EB739D6239BB26027@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 22:11:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2nLW-0000Hs-QR
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 22:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbaGCULB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 16:11:01 -0400
Received: from mail.pdinc.us ([67.90.184.27]:35001 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbaGCULA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 16:11:00 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s63KAxXQ030375
	for <git@vger.kernel.org>; Thu, 3 Jul 2014 16:10:59 -0400
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac+W+ugFYDSaebq6SzqQ5FaRrdgKaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252878>

(I am on the list cc not needed)

jpyeron@black /projects/cipherShed
$ git --version && uname -a
git version 1.8.4.21.g992c386
CYGWIN_NT-5.2-WOW64 black 1.7.30(0.272/5/3) 2014-05-23 10:36 i686 Cygwin

jpyeron@black /projects/cipherShed
$ git diff src/Format/Format.vcproj
diff --git a/src/Format/Format.vcproj b/src/Format/Format.vcproj
index 41081b5..e78f153 100644
--- a/src/Format/Format.vcproj
+++ b/src/Format/Format.vcproj
@@ -505,6 +505,10 @@
                                >
                        </File>
                        <File
+                               RelativePath="..\Common\snprintf.h"^M
+                               >^M
+                       </File>^M
+                       <File^M
                                RelativePath="..\Common\Tcdefs.h"
                                >
                        </File>

jpyeron@black /projects/cipherShed
$ hexdump.exe -C src/Format/Format.vcproj | less

000029c0  09 09 3c 2f 46 69 6c 65  3e 0d 0a 09 09 09 3c 46  |..</File>.....<F|
000029d0  69 6c 65 0d 0a 09 09 09  09 52 65 6c 61 74 69 76  |ile......Relativ|
000029e0  65 50 61 74 68 3d 22 2e  2e 5c 43 6f 6d 6d 6f 6e  |ePath="..\Common|
000029f0  5c 53 65 63 75 72 69 74  79 54 6f 6b 65 6e 2e 68  |\SecurityToken.h|
00002a00  22 0d 0a 09 09 09 09 3e  0d 0a 09 09 09 3c 2f 46  |"......>.....</F|
00002a10  69 6c 65 3e 0d 0a 09 09  09 3c 46 69 6c 65 0d 0a  |ile>.....<File..|
----------------------^^-----------------------------^^---
Why does git diff output not show these as CTRL-M?

00002a20  09 09 09 09 52 65 6c 61  74 69 76 65 50 61 74 68  |....RelativePath|
00002a30  3d 22 2e 2e 5c 43 6f 6d  6d 6f 6e 5c 73 6e 70 72  |="..\Common\snpr|
00002a40  69 6e 74 66 2e 68 22 0d  0a 09 09 09 09 3e 0d 0a  |intf.h"......>..|
-------------------------------^^--------------------^^---
When it shows these,
00002a50  09 09 09 3c 2f 46 69 6c  65 3e 0d 0a 09 09 09 3c  |...</File>.....<|
-----------------------------------------^^---------------
these,
00002a60  46 69 6c 65 0d 0a 09 09  09 09 52 65 6c 61 74 69  |File......Relati|
----------------------^^----------------------------------
and these.
00002a70  76 65 50 61 74 68 3d 22  2e 2e 5c 43 6f 6d 6d 6f  |vePath="..\Commo|
00002a80  6e 5c 54 63 64 65 66 73  2e 68 22 0d 0a 09 09 09  |n\Tcdefs.h".....|
00002a90  09 3e 0d 0a 09 09 09 3c  2f 46 69 6c 65 3e 0d 0a  |.>.....</File>..|

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
