From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Sun, 31 May 2009 18:15:24 +0200
Message-ID: <1243786525-4493-11-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
 <1243786525-4493-4-git-send-email-prohaska@zib.de>
 <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de>
 <1243786525-4493-7-git-send-email-prohaska@zib.de>
 <1243786525-4493-8-git-send-email-prohaska@zib.de>
 <1243786525-4493-9-git-send-email-prohaska@zib.de>
 <1243786525-4493-10-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnho-0001VR-Al
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378AbZEaQQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbZEaQQK
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:10 -0400
Received: from mailer.zib.de ([130.73.108.11]:58617 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756203AbZEaQQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFWXS006803;
	Sun, 31 May 2009 18:15:37 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVH021220;
	Sun, 31 May 2009 18:15:32 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-10-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120408>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/nedmalloc/malloc.c.h  |    4 +++-
 compat/nedmalloc/nedmalloc.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 1d9bbe0..678beb8 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1270,7 +1270,9 @@ int mspace_mallopt(int, int);
 /*------------------------------ internal #includes ---------------------- */
 
 #ifdef WIN32
+#ifndef __GNUC__
 #pragma warning( disable : 4146 ) /* no "unsigned" warnings */
+#endif
 #endif /* WIN32 */
 
 #include <stdio.h>       /* for printing in malloc_stats */
@@ -2541,7 +2543,7 @@ struct malloc_params {
 static struct malloc_params mparams;
 
 /* Ensure mparams initialized */
-#define ensure_initialization() (mparams.magic != 0 || init_mparams())
+#define ensure_initialization() if (mparams.magic == 0) init_mparams()
 
 #if !ONLY_MSPACES
 
diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index a381a7d..60a4093 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -34,7 +34,7 @@ DEALINGS IN THE SOFTWARE.
 /*#define FULLSANITYCHECKS*/
 
 #include "nedmalloc.h"
-#if defined(WIN32) && !defined(__MINGW32__)
+#if defined(WIN32)
  #include <malloc.h>
 #endif
 #define MSPACES 1
-- 
1.6.3.1.54.g99dd
