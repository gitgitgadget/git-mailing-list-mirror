From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/4] Makefile: keep MSVC and Cygwin configuration separate
Date: Tue, 27 Oct 2009 19:13:29 +0000
Message-ID: <4AE74659.6020503@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rrR-0003wp-AS
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbZJ0Th1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbZJ0Th0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:37:26 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49902 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756716AbZJ0ThY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 15:37:24 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N2rrE-0002l5-Wb; Tue, 27 Oct 2009 19:37:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131374>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8e1cfc5..12c8249 100644
--- a/Makefile
+++ b/Makefile
@@ -658,6 +658,14 @@ EXTLIBS =
 # Platform specific tweaks
 #
 
+ifdef MSVC
+	# When building with msvc, on MinGW or Cygwin, we
+	# override the uname settings to make it easier to
+	# keep the configuration sections separate
+	uname_S = Windows
+	uname_O = Windows
+endif
+
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
@@ -893,7 +901,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
-ifdef MSVC
+ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -945,7 +953,7 @@ else
 	BASIC_CFLAGS += -Zi -MTd
 endif
 	X = .exe
-else
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -994,7 +1002,6 @@ else
 	NO_PTHREADS = YesPlease
 endif
 endif
-endif
 
 -include config.mak.autogen
 -include config.mak
-- 
1.6.5
