From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
Date: Sat, 04 Dec 2010 18:54:28 +0000
Message-ID: <4CFA8E64.6070402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, kusmabite@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:38:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POysh-0000Ke-PJ
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0LDUiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:38:18 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:63277 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755811Ab0LDUiR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:38:17 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1POys3-0005WF-lz; Sat, 04 Dec 2010 20:38:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162903>


The msvc winsock2.h header file conditionally defines or declares
poll() related symbols which cause many macro redefinition errors,
a struct type redefinition error and syntax errors. These symbols
are defined in support of the WSAPoll() API, new in Windows Vista,
when the symbol _WIN32_WINNT is defined and _WIN32_WINNT >= 0x0600.

In order to avoid the compilation errors, we set _WIN32_WINNT to
0x0502 (which would target Windows Server 2003) prior to including
the winsock2.h header file.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/win32/sys/poll.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
index 7e74ebe..708a6c9 100644
--- a/compat/win32/sys/poll.c
+++ b/compat/win32/sys/poll.c
@@ -34,6 +34,9 @@
 
 #if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
 # define WIN32_NATIVE
+# if defined (_MSC_VER)
+#  define _WIN32_WINNT 0x0502
+# endif
 # include <winsock2.h>
 # include <windows.h>
 # include <io.h>
-- 
1.7.3
