From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Windows: Do not redefine _WIN32_WINNT
Date: Wed, 11 Sep 2013 18:06:31 +0200
Message-ID: <52309507.1090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 18:14:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJn3w-0002TM-NH
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab3IKQOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:14:36 -0400
Received: from plane.gmane.org ([80.91.229.3]:45560 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755795Ab3IKQKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:10:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VJmzT-0004YW-GQ
	for git@vger.kernel.org; Wed, 11 Sep 2013 18:10:03 +0200
Received: from p5ddb36d8.dip0.t-ipconnect.de ([93.219.54.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 18:10:03 +0200
Received: from sschuberth by p5ddb36d8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 18:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb36d8.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234574>

With MinGW runtime version 4.0 this interferes with the previous definition
from sdkddkver.h.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/nedmalloc/malloc.c.h | 2 ++
 git-compat-util.h           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 1401a67..930d03b 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -495,7 +495,9 @@ MAX_RELEASE_CHECK_RATE   default: 4095 unless not HAVE_MMAP
 #endif  /* WIN32 */
 #ifdef WIN32
 #define WIN32_LEAN_AND_MEAN
+#ifndef _WIN32_WINNT
 #define _WIN32_WINNT 0x403
+#endif
 #include <windows.h>
 #define HAVE_MMAP 1
 #define HAVE_MORECORE 0
diff --git a/git-compat-util.h b/git-compat-util.h
index 664305c..f5c756d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -93,7 +93,9 @@
 #undef __NO_INLINE__
 
 #ifdef WIN32 /* Both MinGW and MSVC */
+#ifndef _WIN32_WINNT
 #define _WIN32_WINNT 0x0502
+#endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
-- 
1.8.3.mingw.1.2.g56240b5.dirty
