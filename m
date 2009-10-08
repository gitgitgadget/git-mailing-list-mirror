From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix MSVC build on cygwin
Date: Thu, 08 Oct 2009 16:21:44 +0100
Message-ID: <4ACE0388.6070706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mstormo@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvwXx-0006tk-V2
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964AbZJHRKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758929AbZJHRKU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:10:20 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:40269 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758828AbZJHRKT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 13:10:19 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1MvwUi-00079C-ii; Thu, 08 Oct 2009 17:09:37 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129705>


In the MSVC section of the Makefile, BASIC_CFLAGS is set to a
value which contains the string "-DWIN32-D_CONSOLE". This results
in a (single) malformed -Define being passed to the compiler.
At least on my cygwin installation, the msvc compiler seems to
ignore this parameter, without issuing an error or warning, and
results in the WIN32 and _CONSOLE macros being undefined. This
breaks the build.

In order to fix the build, we simply insert a space between the
two -Define parameters, "-DWIN32" and "-D_CONSOLE", as originally
intended.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi *,

The original version of this patch used line-continuation to
wrap the over-long lines in the MSVC section. (the lines that
set up BASIC_CFLAGS, COMPAT_CFLAGS and BASIC_LDFLAGS.)
However, that somewhat obscured the important change in this
patch (and some people don't find line-continuation easier to
read anyway ;-).

ATB,
Ramsay Jones

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 12defd4..ae9bb03 100644
--- a/Makefile
+++ b/Makefile
@@ -914,7 +914,7 @@ ifdef MSVC
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
-	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32-D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
+	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
-- 
1.6.4
