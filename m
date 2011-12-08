From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] mingw: give waitpid the correct signature
Date: Thu,  8 Dec 2011 20:39:57 +0100
Message-ID: <1323373197-20960-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 20:40:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYjph-0004WJ-Fg
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 20:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1LHTkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 14:40:37 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59896 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752127Ab1LHTkg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 14:40:36 -0500
Received: by lagp5 with SMTP id p5so841070lag.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JZmp8VYHQqecNuqQjiLemFT9KD4NQ9ZUwCFPppLnScg=;
        b=VeBXqwecQqMXVk4JKtvdTgXdAjCn95ob8vM47Z+lSFu+o4yUP1A2xmTRhXL9AzFoXu
         +Atvu6E0o0DX54tdoycI9BGO3kPGQ9hXK1pZDYPNLAdfnpCj0YOdxuTUjynWcDrYsOb6
         DYJbSTEKRxtG4jV90VfIUTyiq27vtkRsepSjE=
Received: by 10.152.112.10 with SMTP id im10mr2925233lab.2.1323373234974;
        Thu, 08 Dec 2011 11:40:34 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id op2sm5427158lab.6.2011.12.08.11.40.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 11:40:33 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186588>

POSIX says that last parameter to waitpid should be 'int',
so let's make it so.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Just a small clean-up I stumbled over...

 compat/mingw.c |    2 +-
 compat/mingw.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index efdc703..a0ac487 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1712,7 +1712,7 @@ char *getpass(const char *prompt)
 	return strbuf_detach(&buf, NULL);
 }
 
-pid_t waitpid(pid_t pid, int *status, unsigned options)
+pid_t waitpid(pid_t pid, int *status, int options)
 {
 	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,
 	    FALSE, pid);
diff --git a/compat/mingw.h b/compat/mingw.h
index fecf0d0..0ff1e04 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -120,7 +120,7 @@ static inline int mingw_mkdir(const char *path, int mode)
 #define mkdir mingw_mkdir
 
 #define WNOHANG 1
-pid_t waitpid(pid_t pid, int *status, unsigned options);
+pid_t waitpid(pid_t pid, int *status, int options);
 
 #define kill mingw_kill
 int mingw_kill(pid_t pid, int sig);
-- 
1.7.7.1.msysgit.0.272.g9e47e
