From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 2/6] mingw: make fgetc raise SIGINT if apropriate
Date: Tue,  4 Dec 2012 09:10:38 +0100
Message-ID: <1354608642-5316-3-git-send-email-kusmabite@gmail.com>
References: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBKPA62CQKGQEBL4PGAQ@googlegroups.com Tue Dec 04 09:11:37 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBKPA62CQKGQEBL4PGAQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBKPA62CQKGQEBL4PGAQ@googlegroups.com>)
	id 1TfnbK-0004tJ-7F
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 09:11:34 +0100
Received: by mail-ea0-f186.google.com with SMTP id c1sf1487801eaa.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 00:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=thed5bEE+C079DKyeHgRsx5jPequjo/jpJrwu3zX/fQ=;
        b=YK25W06XV7OyG5ua3eA91xxzi2JtY0toLykiVa0cdchuT1P5AjcT/uhTRssOo+O/8G
         q0ktKyYj5GVkZv2H49s+TnrqgzyGm2/DMeWhTtS1kBrLxl7RUpi7KCZL9QLTqjIzPfWi
         Xf3KGubxM1yz3zMOOEAqq+I5f1loICH4oOjsJCnpVoDrqW24fZMeYAbjdLPGj5Y8elEk
         UvNZEjgdLdCkkcM9lIr2BfOx1Gg14E1hmyx1I0gKp1pHHeFWmNk9DBn44rQksddM9FiM
         LXfy6uFEd4OUp4V5LDF0LinkD1yZzXYV7baF6pilFDJ/b9I+B1Rhp4NumzatcDvHrYt6
         xaog==
Received: by 10.180.99.69 with SMTP id eo5mr341184wib.3.1354608682543;
        Tue, 04 Dec 2012 00:11:22 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.79.68 with SMTP id h4ls124314wix.14.gmail; Tue, 04 Dec
 2012 00:11:21 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1787877bkx.4.1354608681693;
        Tue, 04 Dec 2012 00:11:21 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1787876bkx.4.1354608681673;
        Tue, 04 Dec 2012 00:11:21 -0800 (PST)
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com [209.85.215.42])
        by gmr-mx.google.com with ESMTPS id l1si44357bka.2.2012.12.04.00.11.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:21 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.42 as permitted sender) client-ip=209.85.215.42;
Received: by mail-la0-f42.google.com with SMTP id s15so2586425lag.15
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 00:11:21 -0800 (PST)
Received: by 10.152.103.18 with SMTP id fs18mr12130687lab.32.1354608681324;
        Tue, 04 Dec 2012 00:11:21 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id bf3sm285705lbb.16.2012.12.04.00.11.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:20 -0800 (PST)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
In-Reply-To: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.42 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211072>

Set a control-handler to prevent the process from terminating, and
simulate SIGINT so it can be handled by a signal-handler as usual.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 compat/mingw.h |  6 +++++
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 78e8f54..33ddfdf 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -319,6 +319,31 @@ ssize_t mingw_write(int fd, const void *buf, size_t count)
 	return write(fd, buf, min(count, 31 * 1024 * 1024));
 }
 
+static BOOL WINAPI ctrl_ignore(DWORD type)
+{
+	return TRUE;
+}
+
+#undef fgetc
+int mingw_fgetc(FILE *stream)
+{
+	int ch;
+	if (!isatty(_fileno(stream)))
+		return fgetc(stream);
+
+	SetConsoleCtrlHandler(ctrl_ignore, TRUE);
+	while (1) {
+		ch = fgetc(stream);
+		if (ch != EOF || GetLastError() != ERROR_OPERATION_ABORTED)
+			break;
+
+		/* Ctrl+C was pressed, simulate SIGINT and retry */
+		mingw_raise(SIGINT);
+	}
+	SetConsoleCtrlHandler(ctrl_ignore, FALSE);
+	return ch;
+}
+
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
@@ -1524,7 +1549,7 @@ static HANDLE timer_event;
 static HANDLE timer_thread;
 static int timer_interval;
 static int one_shot;
-static sig_handler_t timer_fn = SIG_DFL;
+static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
 
 /* The timer works like this:
  * The thread, ticktack(), is a trivial routine that most of the time
@@ -1538,13 +1563,7 @@ static sig_handler_t timer_fn = SIG_DFL;
 static unsigned __stdcall ticktack(void *dummy)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
-		if (timer_fn == SIG_DFL) {
-			if (isatty(STDERR_FILENO))
-				fputs("Alarm clock\n", stderr);
-			exit(128 + SIGALRM);
-		}
-		if (timer_fn != SIG_IGN)
-			timer_fn(SIGALRM);
+		mingw_raise(SIGALRM);
 		if (one_shot)
 			break;
 	}
@@ -1635,12 +1654,49 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 {
 	sig_handler_t old = timer_fn;
-	if (sig != SIGALRM)
+
+	switch (sig) {
+	case SIGALRM:
+		timer_fn = handler;
+		break;
+
+	case SIGINT:
+		sigint_fn = handler;
+		break;
+
+	default:
 		return signal(sig, handler);
-	timer_fn = handler;
+	}
+
 	return old;
 }
 
+#undef raise
+int mingw_raise(int sig)
+{
+	switch (sig) {
+	case SIGALRM:
+		if (timer_fn == SIG_DFL) {
+			if (isatty(STDERR_FILENO))
+				fputs("Alarm clock\n", stderr);
+			exit(128 + SIGALRM);
+		} else if (timer_fn != SIG_IGN)
+			timer_fn(SIGALRM);
+		return 0;
+
+	case SIGINT:
+		if (sigint_fn == SIG_DFL)
+			exit(128 + SIGINT);
+		else if (sigint_fn != SIG_IGN)
+			sigint_fn(SIGINT);
+		return 0;
+
+	default:
+		return raise(sig);
+	}
+}
+
+
 static const char *make_backslash_path(const char *path)
 {
 	static char buf[PATH_MAX + 1];
diff --git a/compat/mingw.h b/compat/mingw.h
index 61a6521..6b9e69a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -179,6 +179,9 @@ int mingw_open (const char *filename, int oflags, ...);
 ssize_t mingw_write(int fd, const void *buf, size_t count);
 #define write mingw_write
 
+int mingw_fgetc(FILE *stream);
+#define fgetc mingw_fgetc
+
 FILE *mingw_fopen (const char *filename, const char *otype);
 #define fopen mingw_fopen
 
@@ -287,6 +290,9 @@ static inline unsigned int git_ntohl(unsigned int x)
 sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
+int mingw_raise(int sig);
+#define raise mingw_raise
+
 /*
  * ANSI emulation wrappers
  */
-- 
1.8.0.4.g3c6fb4f.dirty

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
