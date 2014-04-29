From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] MSVC: link dynamically to the CRT
Date: Tue, 29 Apr 2014 12:25:09 +0200
Organization: <)><
Message-ID: <20140429102509.GA16706@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 12:25:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf5E0-0005jS-Br
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 12:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbaD2KZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 06:25:13 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43315 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbaD2KZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 06:25:12 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id C580A1C009E
	for <git@vger.kernel.org>; Tue, 29 Apr 2014 12:25:10 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3TAPA1e016713
	for <git@vger.kernel.org>; Tue, 29 Apr 2014 12:25:10 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3TAP9R8016712
	for git@vger.kernel.org; Tue, 29 Apr 2014 12:25:09 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247561>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 17:20:21 +0100

Dynamic linking is generally preferred over static linking, and MSVCRT.dll
has been integral part of Windows for a long time.

This also fixes linker warnings for _malloc and _free in zlib.lib, which
seems to be compiled for MSVCRT.dll already.

The DLL version also exports some of the CRT initialization functions,
which are hidden in the static libcmt.lib (e.g. __wgetmainargs, required by
subsequent Unicode patches).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Another patch from msysgit.
Cheers,
  Stepan

 config.mak.uname | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index efaed94..eebc847 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -365,16 +365,16 @@ ifeq ($(uname_S),Windows)
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
-	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
+	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	PTHREAD_LIBS =
 	lib =
 ifndef DEBUG
-	BASIC_CFLAGS += -GL -Os -MT
+	BASIC_CFLAGS += -GL -Os -MD
 	BASIC_LDFLAGS += -LTCG
 	AR += -LTCG
 else
-	BASIC_CFLAGS += -Zi -MTd
+	BASIC_CFLAGS += -Zi -MDd
 endif
 	X = .exe
 endif
-- 
1.9.2.msysgit.0.158.g6070cee
