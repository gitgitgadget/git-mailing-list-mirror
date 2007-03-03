From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/6] Fix an "implicit function definition" warning.
Date: Sat, 03 Mar 2007 18:28:52 +0000
Message-ID: <45E9BE64.5030904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNYzJ-0007UJ-Eq
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbXCCS3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbXCCS3b
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:29:31 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2803 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030360AbXCCS3W (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 13:29:22 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HNYyp-000C1Q-5I; Sat, 03 Mar 2007 18:29:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41310>


The function at issue being initgroups() from the <grp.h> header
file. On Cygwin, setting _XOPEN_SOURCE suppresses the definition
of initgroups(), which causes the warning while compiling daemon.c.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
  git-compat-util.h |    6 ++++++
  1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index c1bcb00..e54604e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -47,9 +47,15 @@
  #include <netdb.h>
  #include <pwd.h>
  #include <inttypes.h>
+#if defined(__CYGWIN__)
+#undef _XOPEN_SOURCE
+#include <grp.h>
+#define _XOPEN_SOURCE 600
+#else
  #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
  #include <grp.h>
  #define _ALL_SOURCE 1
+#endif

  #ifndef NO_ICONV
  #include <iconv.h>
-- 
1.5.0
