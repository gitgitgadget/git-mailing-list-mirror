From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v2] Replace hard-coded path with one from <paths.h>
Date: Thu, 8 Apr 2010 12:57:07 +0100
Message-ID: <20100408115706.GE2077@arachsys.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
 <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com>
 <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
 <20100408105850.GD2146@arachsys.com>
 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 13:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzqO3-00082D-O8
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 13:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597Ab0DHL7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 07:59:00 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:53119 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758468Ab0DHL7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 07:59:00 -0400
Received: from [212.183.140.38] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NzqNt-0007Ql-I9; Thu, 08 Apr 2010 12:58:57 +0100
Content-Disposition: inline
In-Reply-To: <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144353>

In exec_cmd.c, git hard-codes a default path of /usr/local/bin:/usr/bin:/bin.
Get an appropriate value for the system from <paths.h> if possible instead.
Do not attempt to #include <paths.h> under Windows.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 exec_cmd.c        |    2 +-
 git-compat-util.h |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index b2c07c7..bf22570 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -107,7 +107,7 @@ void setup_path(void)
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
 	else
-		strbuf_addstr(&new_path, "/usr/local/bin:/usr/bin:/bin");
+		strbuf_addstr(&new_path, _PATH_DEFPATH);
 
 	setenv("PATH", new_path.buf, 1);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 7e62b55..9443b9b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -70,6 +70,8 @@
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+#else
+#include <paths.h>
 #endif
 
 #include <unistd.h>
@@ -164,6 +166,10 @@ extern char *gitbasename(char *);
 #define PATH_SEP ':'
 #endif
 
+#ifndef _PATH_DEFPATH
+#define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
+#endif
+
 #ifndef STRIP_EXTENSION
 #define STRIP_EXTENSION ""
 #endif
-- 
1.7.0.3
