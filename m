From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 1/3] MSVC: Compile fix by not including sys/resources.h
Date: Fri, 21 Oct 2011 21:36:41 +0200
Message-ID: <4EA1C9C9.9010904@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 21:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHKu5-0002lJ-0O
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 21:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab1JUTgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 15:36:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59579 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab1JUTgs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 15:36:48 -0400
Received: by eye27 with SMTP id 27so4173602eye.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 12:36:47 -0700 (PDT)
Received: by 10.14.11.31 with SMTP id 31mr2037906eew.77.1319225807016;
        Fri, 21 Oct 2011 12:36:47 -0700 (PDT)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id o4sm37551075eeb.0.2011.10.21.12.36.45
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 12:36:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184080>

Fix compilation when compiling with MSVC because sys/resource.h
is not available. This patch causes a number of other headerfiles
that are not available to be excluded as well.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
  git-compat-util.h |   13 ++++++-------
  1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5ef8ff7..53186da 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -116,7 +116,12 @@
  #else
  #include <poll.h>
  #endif
-#ifndef __MINGW32__
+#if defined(__MINGW32__)
+/* pull in Windows compatibility stuff */
+#include "compat/mingw.h"
+#elif defined(_MSC_VER)
+#include "compat/msvc.h"
+#else
  #include <sys/wait.h>
  #include <sys/resource.h>
  #include <sys/socket.h>
@@ -145,12 +150,6 @@
  #include <grp.h>
  #define _ALL_SOURCE 1
  #endif
-#else  /* __MINGW32__ */
-/* pull in Windows compatibility stuff */
-#include "compat/mingw.h"
-#endif /* __MINGW32__ */
-#ifdef _MSC_VER
-#include "compat/msvc.h"
  #endif

  #ifndef NO_LIBGEN_H
--
1.7.6.msysgit.0
