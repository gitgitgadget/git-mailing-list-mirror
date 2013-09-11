From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 11 Sep 2013 18:06:08 +0200
Message-ID: <523094F0.9000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 18:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJn4Q-0003Au-2I
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab3IKQPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:15:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:46257 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491Ab3IKQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:15:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VJn4K-0002yM-5n
	for git@vger.kernel.org; Wed, 11 Sep 2013 18:15:04 +0200
Received: from p5ddb36d8.dip0.t-ipconnect.de ([93.219.54.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 18:15:04 +0200
Received: from sschuberth by p5ddb36d8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 18:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb36d8.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234575>

This is necessary so that read_mailmap() can obtain a pointer to the
function.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-compat-util.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index be1c494..664305c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,13 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
+#define __NO_INLINE__ /* do not inline strcasecmp() */
+#include <string.h>
+#ifdef HAVE_STRINGS_H
+#include <strings.h> /* for strcasecmp() */
+#endif
+#undef __NO_INLINE__
+
 #ifdef WIN32 /* Both MinGW and MSVC */
 #define _WIN32_WINNT 0x0502
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
@@ -99,10 +106,6 @@
 #include <stddef.h>
 #include <stdlib.h>
 #include <stdarg.h>
-#include <string.h>
-#ifdef HAVE_STRINGS_H
-#include <strings.h> /* for strcasecmp() */
-#endif
 #include <errno.h>
 #include <limits.h>
 #ifdef NEEDS_SYS_PARAM_H
-- 
1.8.3.mingw.1.2.g56240b5.dirty
