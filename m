From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/7] Win32: simplify internal mingw_spawn* APIs
Date: Wed, 11 Jun 2014 11:37:41 +0200
Message-ID: <1402479466-8500-3-git-send-email-kasal@ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com Wed Jun 11 11:38:11 2014
Return-path: <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>)
	id 1Wueys-0004Jo-Cs
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:06 +0200
Received: by mail-wg0-f60.google.com with SMTP id n12sf939527wgh.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=0WOq1OiiBxBoU3ttebgIqZ1dDoPhG+d9PWlFsLur6vI=;
        b=elAmDTzpeG/YYFknRU9voCnoGjwwAUa59iuWqxgLPhsdfIlJH2VsX5ReLufC536hzC
         lvRakbhF208IMYbLq1s0b+qWhDb7RoAJ9buU4SdWy5Gnwmwg4rgLVMATE5NichXEm0XT
         QZEMaOzu17yj46NaXQ5rboJjbvbED8sxnbM25pB0cs9qFkOuQpcZd03XO5D+GuThjutx
         ChLh+CzWZw7eKJTMyL1IrkNQwh//HtlqVDJZzfsMFLxxLNaBmT1+gTLpaqT5lweWlHA1
         tz/A61rIZdvV5WedrQ9Z1ZLkvGMATQF0B5LbnikMle4AkVAp9gLTS556dqbhmJ87BsQ1
         3g2Q==
X-Received: by 10.152.43.67 with SMTP id u3mr8642lal.7.1402479486122;
        Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.2.37 with SMTP id 5ls416726lar.73.gmail; Wed, 11 Jun 2014
 02:38:04 -0700 (PDT)
X-Received: by 10.112.200.164 with SMTP id jt4mr170848lbc.14.1402479484781;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id s3si1183447wic.3.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8FA2F1C00A6; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251356>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 25 Nov 2011 21:33:17 +0100

The only public spawn function that needs to tweak the environment is
mingw_spawnvpe (called from start_command). Nevertheless, all internal
spawn* functions take an env parameter and needlessly pass the global
char **environ around. Remove the env parameter where it's not needed.

This removes the internal mingw_execve abstraction, which is no longer
needed.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 7da73fa..1c0b153 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -941,10 +941,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 	return (pid_t)pi.dwProcessId;
 }
 
-static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
-			   int prepend_cmd)
+static pid_t mingw_spawnv(const char *cmd, const char **argv, int prepend_cmd)
 {
-	return mingw_spawnve_fd(cmd, argv, env, NULL, prepend_cmd, 0, 1, 2);
+	return mingw_spawnve_fd(cmd, argv, environ, NULL, prepend_cmd, 0, 1, 2);
 }
 
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
@@ -986,7 +985,7 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
 	return pid;
 }
 
-static int try_shell_exec(const char *cmd, char *const *argv, char **env)
+static int try_shell_exec(const char *cmd, char *const *argv)
 {
 	const char *interpr = parse_interpreter(cmd);
 	char **path;
@@ -1004,7 +1003,7 @@ static int try_shell_exec(const char *cmd, char *const *argv, char **env)
 		argv2 = xmalloc(sizeof(*argv) * (argc+1));
 		argv2[0] = (char *)cmd;	/* full path to the script file */
 		memcpy(&argv2[1], &argv[1], sizeof(*argv) * argc);
-		pid = mingw_spawnve(prog, argv2, env, 1);
+		pid = mingw_spawnv(prog, argv2, 1);
 		if (pid >= 0) {
 			int status;
 			if (waitpid(pid, &status, 0) < 0)
@@ -1019,13 +1018,13 @@ static int try_shell_exec(const char *cmd, char *const *argv, char **env)
 	return pid;
 }
 
-static int mingw_execve(const char *cmd, char *const *argv, char *const *env)
+int mingw_execv(const char *cmd, char *const *argv)
 {
 	/* check if git_command is a shell script */
-	if (!try_shell_exec(cmd, argv, (char **)env)) {
+	if (!try_shell_exec(cmd, argv)) {
 		int pid, status;
 
-		pid = mingw_spawnve(cmd, (const char **)argv, (char **)env, 0);
+		pid = mingw_spawnv(cmd, (const char **)argv, 0);
 		if (pid < 0)
 			return -1;
 		if (waitpid(pid, &status, 0) < 0)
@@ -1041,7 +1040,7 @@ int mingw_execvp(const char *cmd, char *const *argv)
 	char *prog = path_lookup(cmd, path, 0);
 
 	if (prog) {
-		mingw_execve(prog, argv, environ);
+		mingw_execv(prog, argv);
 		free(prog);
 	} else
 		errno = ENOENT;
@@ -1050,12 +1049,6 @@ int mingw_execvp(const char *cmd, char *const *argv)
 	return -1;
 }
 
-int mingw_execv(const char *cmd, char *const *argv)
-{
-	mingw_execve(cmd, argv, environ);
-	return -1;
-}
-
 int mingw_kill(pid_t pid, int sig)
 {
 	if (pid > 0 && sig == SIGTERM) {
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
