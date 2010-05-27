From: Jonathan Callen <abcd@gentoo.org>
Subject: [PATCH 2/3] Support building without inttypes.h
Date: Thu, 27 May 2010 04:19:43 -0400
Message-ID: <1274948384-167-3-git-send-email-abcd@gentoo.org>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Cc: mduft@gentoo.org, jrnieder@gmail.com,
	Jonathan Callen <abcd@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 10:20:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHYK5-00049K-Ug
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 10:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab0E0IUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 04:20:01 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45285 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757336Ab0E0IT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 04:19:58 -0400
Received: from localhost.localdomain (pool-72-86-43-250.clppva.fios.verizon.net [72.86.43.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 626111B403B;
	Thu, 27 May 2010 08:19:57 +0000 (UTC)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147834>

Some systems, such as Interix, do not have a inttypes.h header.
Attempt to use stdint.h instead.

Signed-off-by: Jonathan Callen <abcd@gentoo.org>
---
 Makefile          |    6 ++++++
 git-compat-util.h |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 4b36534..1722bf0 100644
--- a/Makefile
+++ b/Makefile
@@ -70,6 +70,8 @@ all::
 #
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
+# Define NO_INTTYPES_H if you don't have inttypes.h.
+#
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
@@ -1333,6 +1335,10 @@ ifdef NO_POLL
 	BASIC_CFLAGS += -DNO_POLL
 endif
 
+ifdef NO_INTTYPES_H
+	BASIC_CFLAGS += -DNO_INTTYPES_H
+endif
+
 ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index c5188e5..6f2aaca 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -108,7 +108,11 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+#ifdef NO_INTTYPES_H
+#include <stdint.h>
+#else
 #include <inttypes.h>
+#endif
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
-- 
1.7.1
