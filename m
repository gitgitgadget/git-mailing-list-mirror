From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 3/6] compat/terminal: factor out echo-disabling
Date: Tue,  4 Dec 2012 09:10:39 +0100
Message-ID: <1354608642-5316-4-git-send-email-kusmabite@gmail.com>
References: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBLPA62CQKGQE4RRRU6A@googlegroups.com Tue Dec 04 09:11:40 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBLPA62CQKGQE4RRRU6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f58.google.com ([209.85.214.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBLPA62CQKGQE4RRRU6A@googlegroups.com>)
	id 1TfnbN-0004tZ-Dx
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 09:11:37 +0100
Received: by mail-bk0-f58.google.com with SMTP id jg9sf1488929bkc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 00:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Tuo0S/QRakwiGjBKTU7MDg04SYs/G6XfEgyFPL4ASoE=;
        b=CwYPL4VSaqSQdA4RU2nakkxLsY+b2VO0pZJdkqRD+MbFGZ2kKVelRMbzOJfHxT0sCX
         9fLDEeXZNqTqbT03DitOnUdSJJQ6vhrZmi95omdErwa6rQeLh4+vnU7jKeeYXzDPE1AJ
         ArOBX1uoghNUqUCHnVYtoDAXzV6/sHjmjwF6CTfcsk3aBNt8WB3m5wH6LQhgAEU3IKWn
         a4zzkRk84SPaKBMO+3QycIrY/pbY7U1TMe2V++qlzVqVS+gi2sScUtrC0ycXJOBvR/0g
         lZsOXtMmMglb4uRQVjMiln5RhtTE0g8/fx+cXe+ihZ8bUC+qMuzY2pJvKoi7mqGFFZ9S
         qBmg==
Received: by 10.180.24.3 with SMTP id q3mr338641wif.4.1354608685735;
        Tue, 04 Dec 2012 00:11:25 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.92.163 with SMTP id cn3ls1217340wib.13.canary; Tue, 04 Dec
 2012 00:11:24 -0800 (PST)
Received: by 10.204.150.142 with SMTP id y14mr1788798bkv.2.1354608684879;
        Tue, 04 Dec 2012 00:11:24 -0800 (PST)
Received: by 10.204.150.142 with SMTP id y14mr1788797bkv.2.1354608684862;
        Tue, 04 Dec 2012 00:11:24 -0800 (PST)
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com [209.85.217.182])
        by gmr-mx.google.com with ESMTPS id l1si44531bka.2.2012.12.04.00.11.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:24 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.182 as permitted sender) client-ip=209.85.217.182;
Received: by mail-lb0-f182.google.com with SMTP id go10so2862378lbb.41
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 00:11:24 -0800 (PST)
Received: by 10.152.109.145 with SMTP id hs17mr12360593lab.5.1354608684531;
        Tue, 04 Dec 2012 00:11:24 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id jk8sm205860lab.7.2012.12.04.00.11.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:23 -0800 (PST)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
In-Reply-To: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.182 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211073>

By moving the echo-disabling code to a separate function, we can
implement OS-specific versions of it for non-POSIX platforms.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/terminal.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index bbb038d..a6212ca 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -14,6 +14,7 @@ static void restore_term(void)
 		return;
 
 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
+	close(term_fd);
 	term_fd = -1;
 }
 
@@ -24,6 +25,27 @@ static void restore_term_on_signal(int sig)
 	raise(sig);
 }
 
+static int disable_echo(void)
+{
+	struct termios t;
+
+	term_fd = open("/dev/tty", O_RDWR);
+	if (tcgetattr(term_fd, &t) < 0)
+		goto error;
+
+	old_term = t;
+	sigchain_push_common(restore_term_on_signal);
+
+	t.c_lflag &= ~ECHO;
+	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
+		return 0;
+
+error:
+	close(term_fd);
+	term_fd = -1;
+	return -1;
+}
+
 char *git_terminal_prompt(const char *prompt, int echo)
 {
 	static struct strbuf buf = STRBUF_INIT;
@@ -34,24 +56,9 @@ char *git_terminal_prompt(const char *prompt, int echo)
 	if (!fh)
 		return NULL;
 
-	if (!echo) {
-		struct termios t;
-
-		if (tcgetattr(fileno(fh), &t) < 0) {
-			fclose(fh);
-			return NULL;
-		}
-
-		old_term = t;
-		term_fd = fileno(fh);
-		sigchain_push_common(restore_term_on_signal);
-
-		t.c_lflag &= ~ECHO;
-		if (tcsetattr(fileno(fh), TCSAFLUSH, &t) < 0) {
-			term_fd = -1;
-			fclose(fh);
-			return NULL;
-		}
+	if (!echo && disable_echo()) {
+		fclose(fh);
+		return NULL;
 	}
 
 	fputs(prompt, fh);
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
