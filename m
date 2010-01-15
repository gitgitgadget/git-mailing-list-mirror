From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 06/14] mingw: use real pid
Date: Fri, 15 Jan 2010 22:30:25 +0100
Message-ID: <1263591033-4992-7-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3sd5QSwkOBywScaUIJQbMOWWOTMUIQT.KWUUagaOQbOWWOTMOZWcXa.KWU@listserv.bounces.google.com Fri Jan 15 22:31:46 2010
Return-path: <3sd5QSwkOBywScaUIJQbMOWWOTMUIQT.KWUUagaOQbOWWOTMOZWcXa.KWU@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlh-0005Wh-TQ
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 22:31:46 +0100
Received: by mail-gx0-f190.google.com with SMTP id 6sf2155544gxk.13
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 13:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=vPeVqamV+10WmyG6+U8Sqdi2nIKYbenvIvuFR20ZRR4=;
        b=TN10C8+6iHLoh8UBwIBRBPCQdJB717sBxRKZHgp1/mtEQU9Ci7o7d/qzedjoitaiia
         8z+ki84ttwqBgn0AykyrJ42v2Swx6XE47ffRYyvBnJgq2s1DCqqNR53HcUwcd5QW+/xb
         HeNBdbkjNGfqEOcGYnHH0czXPL9xWRCwKie9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=5c3E3SfY6G9HVJMlQ4GwOTVe7b7UU8DQbExXhnlGro/tytzEEADdycXcjzg1jOx7cF
         22Sbz3T61iJPvfbkcLBUR9OMIiGuoMwgJnIxJglX1XeZ0vLPKId2Ox7dj3qJ+mO9CEpK
         uuW4LVKA1EdrI1h2f+HP8NoUdqVZFdGMaMuOg=
Received: by 10.101.5.7 with SMTP id h7mr225632ani.14.1263591089186;
        Fri, 15 Jan 2010 13:31:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.39.202 with SMTP id h10ls608414ebe.2.p; Fri, 15 Jan 2010 
	13:31:27 -0800 (PST)
Received: by 10.213.1.20 with SMTP id 20mr431949ebd.15.1263591087125;
        Fri, 15 Jan 2010 13:31:27 -0800 (PST)
Received: by 10.213.1.20 with SMTP id 20mr431948ebd.15.1263591087102;
        Fri, 15 Jan 2010 13:31:27 -0800 (PST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215])
        by gmr-mx.google.com with ESMTP id 11si173538ewy.13.2010.01.15.13.31.26;
        Fri, 15 Jan 2010 13:31:26 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Received: by ewy7 with SMTP id 7so1359243ewy.10
        for <msysgit@googlegroups.com>; Fri, 15 Jan 2010 13:31:26 -0800 (PST)
Received: by 10.213.110.9 with SMTP id l9mr2945712ebp.14.1263591084560;
        Fri, 15 Jan 2010 13:31:24 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 13sm1809428ewy.9.2010.01.15.13.31.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:24 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/3afb780b53a24d2a
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137125>

The Windows port so far used process handles as PID. However,
this does not work consistently with getpid.

Change the code to use the real PID, and use OpenProcess to
get a process-handle.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    2 +-
 compat/mingw.h |   35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 54be905..ce4f829 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -729,7 +729,7 @@ static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
 		return -1;
 	}
 	CloseHandle(pi.hThread);
-	return (pid_t)pi.hProcess;
+	return (pid_t)pi.dwProcessId;
 }
 
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env)
diff --git a/compat/mingw.h b/compat/mingw.h
index 3005472..ff4a76b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -137,14 +137,41 @@ static inline int mingw_unlink(const char *pathname)
 #define WNOHANG 1
 static inline int waitpid(pid_t pid, int *status, unsigned options)
 {
-	if (pid > 0 && options & WNOHANG) {
-		if (WAIT_OBJECT_0 != WaitForSingleObject((HANDLE)pid, 0))
+	HANDLE h;
+
+	if (pid <= 0) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION, FALSE, pid);
+	if (!h) {
+		errno = ECHILD;
+		return -1;
+	}
+
+	if (options & WNOHANG) {
+		if (WaitForSingleObject(h, 0) != WAIT_OBJECT_0) {
+			CloseHandle(h);
 			return 0;
+		}
 		options &= ~WNOHANG;
 	}
 
-	if (options == 0)
-		return _cwait(status, pid, 0);
+	if (options == 0) {
+		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
+			CloseHandle(h);
+			return 0;
+		}
+
+		if (status)
+			GetExitCodeProcess(h, (LPDWORD)status);
+
+		CloseHandle(h);
+		return pid;
+	}
+	CloseHandle(h);
+
 	errno = EINVAL;
 	return -1;
 }
-- 
1.6.6.211.g26720
