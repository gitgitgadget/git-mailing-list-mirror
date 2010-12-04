From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 02/14] msvc: git-daemon.exe: Fix linker "unresolved externals"
 error
Date: Sat, 04 Dec 2010 18:55:51 +0000
Message-ID: <4CFA8EB7.9070000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:55:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POz92-0006kZ-PR
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab0LDUzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:55:44 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:42893 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0LDUzn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:55:43 -0500
X-Greylist: delayed 1036 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Dec 2010 15:55:43 EST
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1POysE-0001E1-h9; Sat, 04 Dec 2010 20:38:26 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162908>


The msvc linker complains about external symbols referenced by
the new poll() emulation code. In particular, it complains about
the DispatchMessage(), PeekMessage(), TranslateMessage() and
MsgWaitForMultipleObjects() functions.

In order to satisfy the external references, we link against the
user32.lib library.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1d42413..bda9fa6 100644
--- a/Makefile
+++ b/Makefile
@@ -1087,7 +1087,7 @@ ifeq ($(uname_S),Windows)
 	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o compat/win32/sys/poll.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
-	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
+	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	PTHREAD_LIBS =
 	lib =
 ifndef DEBUG
-- 
1.7.3
