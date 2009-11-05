From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 18:31:41 +0100
Message-ID: <4AF30BFD.4070101@viscovery.net>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257439548-9258-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 18:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N66Bd-00049U-9M
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 18:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbZKERbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 12:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZKERbk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 12:31:40 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:53252 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531AbZKERbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 12:31:39 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N66BS-00052O-8p; Thu, 05 Nov 2009 18:31:42 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E62044E9; Thu,  5 Nov 2009 18:31:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1257439548-9258-1-git-send-email-ahaczewski@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132230>

Thanks.

I pushed this to

  git://repo.or.cz/git/mingw/j6t.git pthreads-for-windows

together with Nico's patch and another patch to enable pthreads on
MinGW unconditionally. Feedback welcome!

Andrzej K. Haczewski (1):
      MSVC: Windows-native implementation for subset of Pthreads API

Johannes Sixt (1):
      MinGW: enable pthreads

Nicolas Pitre (1):
      pack-objects: move thread autodetection closer to relevant code

This is my patch:

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] MinGW: enable pthreads

If the MinGW build was built as part of the msysgit build environment,
then threading was already enabled because the pthreads package from
GNU-Win32 is available in msysgit.

The previous patch added a minimal pthreads implementation for Windows.
Therefore, we can now enable code that uses pthreads unconditionally.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index db7ffb0..4b8603a 100644
--- a/Makefile
+++ b/Makefile
@@ -986,9 +986,11 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
+		compat/win32/pthread.o
 	EXTLIBS += -lws2_32
 	X = .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
@@ -998,10 +1000,8 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	EXTLIBS += /mingw/lib/libz.a
 	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 else
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
 endif
 endif
 endif
-- 
1.6.5.2.1198.ge698c
