From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 04/15] mingw: use real pid
Date: Fri, 22 Oct 2010 02:05:33 +0200
Message-ID: <1287705944-5668-4-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCNq4PmBBoEWWuMJQ@googlegroups.com Fri Oct 22 02:07:02 2010
Return-path: <msysgit+bncCOPdven-DxCNq4PmBBoEWWuMJQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCNq4PmBBoEWWuMJQ@googlegroups.com>)
	id 1P959x-0004SJ-Hi
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:01 +0200
Received: by mail-ww0-f58.google.com with SMTP id 28sf109548wwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ntsbEOrBoEvRz0bZBy8CXUo5147W4ajnWeZqM3r12Xs=;
        b=1OSmamR5Rm9QecxUs3bIqJPpF4RA/Wbc7NFXlAtRt64vNdGPYmTK496msupzjUNLX8
         d+Hyz6WNMIoHOuym0auM3CW9hBOENQGi3krPUKaJWQwWhbCGxvAcgM1EcjXRJydhXje/
         m9h/X80+E+y8cWT3YospoFgsqNsmcuqRsYKC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=fI//CYcA8TKZCrPJUPXtNMNsSxk1U/bVgGslNKwHaq2YKiVhmScuWHXogZYSCWvRJg
         LSNP/XAynmy8mZ8IcqTXH1WmtJ0qdoeDbVBIaSuGXO7dENUpjgvka4++4iWtq7n0z2By
         p1fMM5m7c3D6lCjXnOWyRPs7Zl1XQ0wbt4rAc=
Received: by 10.216.237.231 with SMTP id y81mr289402weq.8.1287705997518;
        Thu, 21 Oct 2010 17:06:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.3.29 with SMTP id 29ls268387eeg.0.p; Thu, 21 Oct 2010
 17:06:36 -0700 (PDT)
Received: by 10.14.119.79 with SMTP id m55mr170818eeh.12.1287705996580;
        Thu, 21 Oct 2010 17:06:36 -0700 (PDT)
Received: by 10.14.119.79 with SMTP id m55mr170817eeh.12.1287705996562;
        Thu, 21 Oct 2010 17:06:36 -0700 (PDT)
Received: from mail-ey0-f178.google.com (mail-ey0-f178.google.com [209.85.215.178])
        by gmr-mx.google.com with ESMTP id r57si1426903eeh.1.2010.10.21.17.06.35;
        Thu, 21 Oct 2010 17:06:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.178 as permitted sender) client-ip=209.85.215.178;
Received: by eyh5 with SMTP id 5so119252eyh.37
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:35 -0700 (PDT)
Received: by 10.14.126.69 with SMTP id a45mr1486504eei.15.1287705995372;
        Thu, 21 Oct 2010 17:06:35 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm2461514eeh.15.2010.10.21.17.06.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.178 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159595>

The Windows port have so far been using process handles in place
of PID. However, this is not work consistent with what getpid
returns.

PIDs are system-global identifiers, but process handles are local
to a process. Using PIDs instead of process handles allows, for
instance, a user to kill a hung process with the Task Manager,
something that would have been impossible with process handles.

Change the code to use the real PID, and use OpenProcess to get a
process-handle. Store the PID and the process handle in a table
protected by a critical section, so we can safely close the
process handle later.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   10 ++-----
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 701a555..e2e3c54 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -702,6 +702,13 @@ static int env_compare(const void *a, const void *b)
 	return strcasecmp(*ea, *eb);
 }
 
+struct {
+	pid_t pid;
+	HANDLE proc;
+} *pinfo;
+static int num_pinfo;
+CRITICAL_SECTION pinfo_cs;
+
 static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
@@ -794,7 +801,23 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 		return -1;
 	}
 	CloseHandle(pi.hThread);
-	return (pid_t)pi.hProcess;
+
+	/*
+	 * The process ID is the human-readable identifier of the process
+	 * that we want to present in log and error messages. The handle
+	 * is not useful for this purpose. But we cannot close it, either,
+	 * because it is not possible to turn a process ID into a process
+	 * handle after the process terminated.
+	 * Keep the handle in a list for waitpid.
+	 */
+	EnterCriticalSection(&pinfo_cs);
+	num_pinfo++;
+	pinfo = xrealloc(pinfo, sizeof(*pinfo) * num_pinfo);
+	pinfo[num_pinfo - 1].pid = pi.dwProcessId;
+	pinfo[num_pinfo - 1].proc = pi.hProcess;
+	LeaveCriticalSection(&pinfo_cs);
+
+	return (pid_t)pi.dwProcessId;
 }
 
 static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
@@ -1518,6 +1541,51 @@ char *getpass(const char *prompt)
 	return strbuf_detach(&buf, NULL);
 }
 
+pid_t waitpid(pid_t pid, int *status, unsigned options)
+{
+	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,
+	    FALSE, pid);
+	if (!h) {
+		errno = ECHILD;
+		return -1;
+	}
+
+	if (options == 0) {
+		int i;
+		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
+			CloseHandle(h);
+			return 0;
+		}
+
+		if (status)
+			GetExitCodeProcess(h, (LPDWORD)status);
+
+		EnterCriticalSection(&pinfo_cs);
+
+		for (i = 0; i < num_pinfo; ++i)
+			if (pinfo[i].pid == pid)
+				break;
+
+		if (i < num_pinfo) {
+			CloseHandle(pinfo[i].proc);
+			memmove(pinfo + i, pinfo + i + 1,
+			    sizeof(*pinfo) * (num_pinfo - i - 1));
+			num_pinfo--;
+			pinfo = xrealloc(pinfo,
+			    sizeof(*pinfo) * num_pinfo);
+		}
+
+		LeaveCriticalSection(&pinfo_cs);
+
+		CloseHandle(h);
+		return pid;
+	}
+	CloseHandle(h);
+
+	errno = EINVAL;
+	return -1;
+}
+
 #ifndef NO_MINGW_REPLACE_READDIR
 /* MinGW readdir implementation to avoid extra lstats for Git */
 struct mingw_DIR
diff --git a/compat/mingw.h b/compat/mingw.h
index a5bde82..7c4eeea 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -140,13 +140,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
-static inline pid_t waitpid(pid_t pid, int *status, unsigned options)
-{
-	if (options == 0)
-		return _cwait(status, pid, 0);
-	errno = EINVAL;
-	return -1;
-}
+pid_t waitpid(pid_t pid, int *status, unsigned options);
 
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
@@ -321,11 +315,13 @@ void free_environ(char **env);
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
+	extern CRITICAL_SECTION pinfo_cs; \
 	_fmode = _O_BINARY; \
 	_setmode(_fileno(stdin), _O_BINARY); \
 	_setmode(_fileno(stdout), _O_BINARY); \
 	_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
+	InitializeCriticalSection(&pinfo_cs); \
 	return mingw_main(argc, argv); \
 } \
 static int mingw_main(c,v)
-- 
1.7.3.1.199.g72340
