From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv5 3/6] Gitweb: add autoconfigure support for minifiers
Date: Thu, 01 Apr 2010 01:36:25 -0400
Message-ID: <4BB430D9.1090900@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 01 07:37:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxD5a-0003Az-Al
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 07:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab0DAFgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 01:36:53 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:50871 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753003Ab0DAFgv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 01:36:51 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o315aPgq026117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Apr 2010 01:36:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-UUID: dd35d17a-5e7c-4431-8934-094c18d28454
X-Miltered: at mailchk-m04 with ID 4BB430D9.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Thu, 01 Apr 2010 01:36:28 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143712>

This will allow users to set a JavaScript/CSS minifier when/if they run
the autoconfigure script while building git. This is much more
convenient than editing Makefile and gitweb/Makefile manually.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

	No changes since the previous version.

 Makefile        |    4 ----
 configure.ac    |   20 ++++++++++++++++++++
 gitweb/Makefile |   14 ++------------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 450e4df..ef1a232 100644
--- a/Makefile
+++ b/Makefile
@@ -282,10 +282,6 @@ lib = lib
 # DESTDIR=
 pathsep = :
 
-# JavaScript/CSS minifier invocation that can function as filter
-JSMIN =
-CSSMIN =
-
 export prefix bindir sharedir sysconfdir
 
 CC = gcc
diff --git a/configure.ac b/configure.ac
index 914ae57..bf36c72 100644
--- a/configure.ac
+++ b/configure.ac
@@ -179,6 +179,26 @@ fi],
    AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads.])
 ])
 
+# Define option to enable JavaScript minification
+AC_ARG_ENABLE([jsmin],
+ [AS_HELP_STRING([--enable-jsmin=ARG],
+   [ARG is the value to pass to make to enable JavaScript minification.])],
+ [
+   JSMIN=$enableval;
+   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
+   GIT_CONF_APPEND_LINE(JSMIN=$enableval);
+ ])
+
+# Define option to enable CSS minification
+AC_ARG_ENABLE([cssmin],
+ [AS_HELP_STRING([--enable-cssmin=ARG],
+   [ARG is the value to pass to make to enable CSS minification.])],
+ [
+   CSSMIN=$enableval;
+   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
+   GIT_CONF_APPEND_LINE(CSSMIN=$enableval);
+ ])
+
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 AC_MSG_NOTICE([CHECKS for site configuration])
diff --git a/gitweb/Makefile b/gitweb/Makefile
index fffe700..ffee4bd 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -14,10 +14,6 @@ prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 RM ?= rm -f
 
-# JavaScript/CSS minifier invocation that can function as filter
-JSMIN ?=
-CSSMIN ?=
-
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
@@ -30,18 +26,10 @@ GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
-ifdef CSSMIN
-GITWEB_CSS = gitweb.min.css
-else
 GITWEB_CSS = gitweb.css
-endif
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
-ifdef JSMIN
-GITWEB_JS = gitweb.min.js
-else
 GITWEB_JS = gitweb.js
-endif
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -95,9 +83,11 @@ all:: gitweb.cgi
 FILES = gitweb.cgi
 ifdef JSMIN
 FILES += gitweb.min.js
+GITWEB_JS = gitweb.min.js
 endif
 ifdef CSSMIN
 FILES += gitweb.min.css
+GITWEB_CSS = gitweb.min.css
 endif
 gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
 
-- 
1.7.0.3.436.g45b2d
