From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 2/4] Makefile: keep MSVC and Cygwin configuration separate
Date: Sat, 07 Nov 2009 20:08:01 +0000
Message-ID: <4AF5D3A1.7080001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 21:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6rqL-0000ib-R7
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 21:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbZKGUYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 15:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbZKGUYl
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 15:24:41 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:60680 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052AbZKGUYk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 15:24:40 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N6rq0-0002zD-YM; Sat, 07 Nov 2009 20:24:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132376>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Changes from v1:
    - moved the "ifdef MSVC" section up to just after the block
      which sets up uname_S, uname_O, etc.
    - use simple assignment ':=' rather than recursive assignment
      in the uname override block

 Makefile |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8e1cfc5..306ca86 100644
--- a/Makefile
+++ b/Makefile
@@ -212,6 +212,12 @@ uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
+ifdef MSVC
+	# avoid the MingW and Cygwin configuration sections
+	uname_S := Windows
+	uname_O := Windows
+endif
+
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
@@ -893,7 +899,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
-ifdef MSVC
+ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -945,7 +951,7 @@ else
 	BASIC_CFLAGS += -Zi -MTd
 endif
 	X = .exe
-else
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -994,7 +1000,6 @@ else
 	NO_PTHREADS = YesPlease
 endif
 endif
-endif
 
 -include config.mak.autogen
 -include config.mak
-- 
1.6.5
