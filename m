From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 06/15] mingw: add kill emulation
Date: Fri, 22 Oct 2010 02:05:35 +0200
Message-ID: <1287705944-5668-6-git-send-email-kusmabite@gmail.com>
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
X-From: msysgit+bncCOPdven-DxCSq4PmBBoEK6_V5A@googlegroups.com Fri Oct 22 02:07:12 2010
Return-path: <msysgit+bncCOPdven-DxCSq4PmBBoEK6_V5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCSq4PmBBoEK6_V5A@googlegroups.com>)
	id 1P95A2-0004SK-49
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:06 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf128526wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ib0hoq9tABZJUxdSP6XAazRk45lkbqD5mchhGyi5F3E=;
        b=xIne20paWUFdkN5DJWCSs1Yi2J1gm4QzANggqDCy7fFy90itV5ZhcUPSsUfiWM9Uw0
         1z8cqbbS9zeCLW/tphrFtGB96ykixWCn+4ASWCjoUxqRnMRemSVaGe2B+lTD5hsb69MD
         FoQfwotKcpQNNFwE3Hm9khG7EfQjQJMels1rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=iXtqgvFaogeaPZo3SDn5ur21xLWJvb0rkOwfPfxzYFG3w5T4zsCINvEnmvqdvCPhZC
         2qY7N8D2Hccq6FqST52GvwjP73ek5CGCYRD/mWr6pwuYd9CgqKHUMvsbtvgVVBNHEEjL
         m+0nLBq5iacBMk5w2NQTWc+icvLPcAsVLifu0=
Received: by 10.216.86.12 with SMTP id v12mr230047wee.6.1287706002171;
        Thu, 21 Oct 2010 17:06:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.25.20 with SMTP id y20ls269176eey.1.p; Thu, 21 Oct 2010
 17:06:41 -0700 (PDT)
Received: by 10.14.119.79 with SMTP id m55mr170824eeh.12.1287706001484;
        Thu, 21 Oct 2010 17:06:41 -0700 (PDT)
Received: by 10.14.119.79 with SMTP id m55mr170823eeh.12.1287706001465;
        Thu, 21 Oct 2010 17:06:41 -0700 (PDT)
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com [209.85.215.177])
        by gmr-mx.google.com with ESMTP id z6si1423334eeh.6.2010.10.21.17.06.40;
        Thu, 21 Oct 2010 17:06:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.177 as permitted sender) client-ip=209.85.215.177;
Received: by mail-ey0-f177.google.com with SMTP id 9so114742eyd.36
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:40 -0700 (PDT)
Received: by 10.213.23.6 with SMTP id p6mr5659856ebb.6.1287706000099;
        Thu, 21 Oct 2010 17:06:40 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm2465176eeh.3.2010.10.21.17.06.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.177 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159598>

This is a quite limited kill-emulation; it can only handle
SIGTERM on positive pids. However, it's enough for git-daemon.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |   19 +++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2e7c644..21d1c2c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -932,6 +932,25 @@ void mingw_execv(const char *cmd, char *const *argv)
 	mingw_execve(cmd, argv, environ);
 }
 
+int mingw_kill(pid_t pid, int sig)
+{
+	if (pid > 0 && sig == SIGTERM) {
+		HANDLE h = OpenProcess(PROCESS_TERMINATE, FALSE, pid);
+
+		if (TerminateProcess(h, -1)) {
+			CloseHandle(h);
+			return 0;
+		}
+
+		errno = err_win_to_posix(GetLastError());
+		CloseHandle(h);
+		return -1;
+	}
+
+	errno = EINVAL;
+	return -1;
+}
+
 static char **copy_environ(void)
 {
 	char **env;
diff --git a/compat/mingw.h b/compat/mingw.h
index 379d7bf..51fca2f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -143,6 +143,9 @@ static inline int mingw_unlink(const char *pathname)
 #define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
+#define kill mingw_kill
+int mingw_kill(pid_t pid, int sig);
+
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
 static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
-- 
1.7.3.1.199.g72340
