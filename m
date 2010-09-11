From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] compat/nedmalloc: don't  force NDEBUG on the rest of git
Date: Sat, 11 Sep 2010 11:59:18 +0200
Message-ID: <4C8B52F6.5040609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 11 12:00:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuMsd-000104-BU
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 12:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab0IKJ7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 05:59:54 -0400
Received: from india601.server4you.de ([85.25.151.105]:54691 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0IKJ7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 05:59:54 -0400
Received: from [10.0.1.100] (p57B7A75A.dip.t-dialin.net [87.183.167.90])
	by india601.server4you.de (Postfix) with ESMTPSA id CB5062F8090;
	Sat, 11 Sep 2010 11:59:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155989>

Define the nedmalloc feature configuration macros for nedmalloc.o, only.
This keeps assert(3) working for the rest of the git source; it was
turned off for nedmalloc users before by defining NDEBUG globally.

Also remove -DUSE_NED_ALLOCATOR as this macro isn't used anywhere.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c27e8bc..4d45e04 100644
--- a/Makefile
+++ b/Makefile
@@ -1465,7 +1465,7 @@ ifdef NO_REGEX
 endif
 
 ifdef USE_NED_ALLOCATOR
-       COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -DOVERRIDE_STRDUP -DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR -Icompat/nedmalloc
+       COMPAT_CFLAGS += -Icompat/nedmalloc
        COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 endif
 
@@ -1908,6 +1908,11 @@ ifdef NO_REGEX
 compat/regex/regex.o: EXTRA_CPPFLAGS = -DGAWK -DNO_MBSUPPORT
 endif
 
+ifdef USE_NED_ALLOCATOR
+compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
+	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
+endif
+
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
