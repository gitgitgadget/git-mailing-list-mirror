From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] Replace hard-coded path with one from <paths.h>
Date: Tue, 6 Apr 2010 17:36:43 +0100
Message-ID: <20100406163643.GG15306@arachsys.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
 <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 18:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzBli-0004T0-W9
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 18:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742Ab0DFQgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 12:36:46 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:60915 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0DFQgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 12:36:44 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NzBlb-0003ab-On; Tue, 06 Apr 2010 17:36:43 +0100
Content-Disposition: inline
In-Reply-To: <20100406163525.GF15306@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144157>

In exec_cmd.c, git hard-codes a default path of /usr/local/bin:/usr/bin:/bin.
Get an appropriate value for the system from <paths.h> if possible instead.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 exec_cmd.c        |    2 +-
 git-compat-util.h |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

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
index 7e62b55..7592be7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -92,6 +92,7 @@
 #include <assert.h>
 #include <regex.h>
 #include <utime.h>
+#include <paths.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
 #include <sys/poll.h>
@@ -164,6 +165,10 @@ extern char *gitbasename(char *);
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
