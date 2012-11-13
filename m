From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 2/5] compat/terminal: factor out echo-disabling
Date: Tue, 13 Nov 2012 15:04:04 +0100
Message-ID: <1352815447-8824-3-git-send-email-kusmabite@gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org,
	msysgit@googlegroups.com
X-From: msysgit+bncBDR53PPJ7YHRB3VGRGCQKGQEVBH2BTQ@googlegroups.com Tue Nov 13 15:04:41 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB3VGRGCQKGQEVBH2BTQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB3VGRGCQKGQEVBH2BTQ@googlegroups.com>)
	id 1TYH6W-0004DE-Jk
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 15:04:40 +0100
Received: by mail-ea0-f186.google.com with SMTP id n10sf2500870eaa.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 06:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=5J6MgAyvQ10BbvG6tBee+XeryvhOxNqCq/g+fwSJDy0=;
        b=aleXbaAkPShg4D2ZvBnZvWDZVvVqQDqwWgkqm678Qm5w+uZV8Uf1ijth2eEc3cT1Qs
         lYEyduf/h1tt8hESRAORacX3zBhDEHN5gCuXW3WfG1+ckLqqKXNjVs5T63U/M2fJ+wJW
         NL0vHWSbX2E4RbaA+x+HS1no7TBZOvZepUEzBd75a323JCaQMZTkqJiYW8E/AJdXDGQO
         vSaiLeKSjtH1oKaMaguyv243g8SDFwUum5K+p9VLaPTXht2A0KwoCIvRzFfEibbpa1TX
         js9D55Hr1fF+LT8NuxKdUttd6AErFZNPGBh+AcIn5cdjg+s8OHGA6qhLYy7sQkPMq2xl
         T/Ug==
Received: by 10.205.137.11 with SMTP id im11mr2053966bkc.30.1352815471065;
        Tue, 13 Nov 2012 06:04:31 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.6.71 with SMTP id 7ls3272951bky.0.gmail; Tue, 13 Nov 2012
 06:04:30 -0800 (PST)
Received: by 10.204.10.80 with SMTP id o16mr591831bko.4.1352815470147;
        Tue, 13 Nov 2012 06:04:30 -0800 (PST)
Received: by 10.204.10.80 with SMTP id o16mr591830bko.4.1352815470132;
        Tue, 13 Nov 2012 06:04:30 -0800 (PST)
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com [209.85.215.46])
        by gmr-mx.google.com with ESMTPS id v13si828451bkw.0.2012.11.13.06.04.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:30 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.46 as permitted sender) client-ip=209.85.215.46;
Received: by mail-la0-f46.google.com with SMTP id h6so6160258lag.33
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 06:04:30 -0800 (PST)
Received: by 10.112.48.200 with SMTP id o8mr9282970lbn.96.1352815469947;
        Tue, 13 Nov 2012 06:04:29 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id gt17sm3831463lab.6.2012.11.13.06.04.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:29 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.1.g1cbcfae.dirty
In-Reply-To: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.46 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209606>

By moving the echo-disabling code to a separate function, we can
implement OS-specific versions of it for non-POSIX platforms.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/terminal.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index bbb038d..3217838 100644
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
 
+static int disable_echo()
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
1.8.0.7.gbeffeda

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
