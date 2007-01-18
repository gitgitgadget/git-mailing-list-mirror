From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Use fixed-size integers for the on-disk pack structure.
Date: Wed, 17 Jan 2007 23:24:21 -0800
Message-ID: <7vejpsol0a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 18 08:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7RdP-00067u-LG
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 08:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbXARHYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 02:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXARHYX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 02:24:23 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33819 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbXARHYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 02:24:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070118072422.OHKD3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jan 2007 02:24:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id CXPU1W00W1kojtg0000000; Thu, 18 Jan 2007 02:23:28 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37062>

From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Date: Wed, 17 Jan 2007 09:07:23 +0100

Plain integer types without a fixed size can vary between platforms.  Even
though all common platforms use 32-bit ints, there is no guarantee that
this won't change at some point.  Furthermore, specifying an integer type
with explicit size makes the definition of structures more obvious.

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * For wider review -- this _might_ have issues with "not quite
   POSIX" systems (such as AIX exporting something undesirable
   under _ALL_SOURCE for example).

 git-compat-util.h |    1 +
 pack.h            |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8d244d0..bf3ceb8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -46,6 +46,7 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+#include <stdint.h>
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
 #define _ALL_SOURCE 1
diff --git a/pack.h b/pack.h
index 790ff4a..821706f 100644
--- a/pack.h
+++ b/pack.h
@@ -10,9 +10,9 @@
 #define PACK_VERSION 2
 #define pack_version_ok(v) ((v) == htonl(2) || (v) == htonl(3))
 struct pack_header {
-	unsigned int hdr_signature;
-	unsigned int hdr_version;
-	unsigned int hdr_entries;
+	uint32_t hdr_signature;
+	uint32_t hdr_version;
+	uint32_t hdr_entries;
 };
 
 /*
-- 
1.5.0.rc1.g05cf8
