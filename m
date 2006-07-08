From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5] autoconf: Checks for typedefs, structures, and compiler characteristics.
Date: Sat,  8 Jul 2006 23:07:10 +0200
Message-ID: <1152392837823-git-send-email-jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com> <1152392835436-git-send-email-jnareb@gmail.com> <11523928361444-git-send-email-jnareb@gmail.com> <1152392836910-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 23:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzK1g-0003ja-Ai
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWGHVHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWGHVHa
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:07:30 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:61121 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030387AbWGHVH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:07:27 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k68L6nDR021751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jul 2006 23:06:50 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k68L7HB3015585;
	Sat, 8 Jul 2006 23:07:17 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k68L7HJQ015584;
	Sat, 8 Jul 2006 23:07:17 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1152392836910-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23505>

./configure script checks now for existence of the following types,
structures, and structure members:
 * dirent.d_ino  in <dirent.h> (NO_D_INO_IN_DIRENT)
 * dirent.d_type in <dirent.h> (NO_D_TYPE_IN_DIRENT)
 * 'struct sockaddr_storage' in <netinet/in.h> (NO_SOCKADDR_STORAGE)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
If on some systems other headers than written above are needed for specified
types definitions, then it should be added to those tests. 

 configure.ac |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index e68d416..cb81258 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,13 +48,24 @@ ## Checks for header files.
 
 
 ## Checks for typedefs, structures, and compiler characteristics.
+AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
+
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
-#
+AC_CHECK_MEMBER(struct dirent.d_ino,[],
+GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=YesPlease),
+[#include <dirent.h>])
+
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
-#
+AC_CHECK_MEMBER(struct dirent.d_type,[],
+GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=YesPlease),
+[#include <dirent.h>])
+
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
+AC_CHECK_TYPE(struct sockaddr_storage,[],
+GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease),
+[#include <netinet/in.h>])
 
 
 ## Checks for library functions.
-- 
1.4.0
