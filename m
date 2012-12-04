From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 1/6] mingw: correct exit-code for SIGALRM's SIG_DFL
Date: Tue,  4 Dec 2012 09:10:37 +0100
Message-ID: <1354608642-5316-2-git-send-email-kusmabite@gmail.com>
References: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBJXA62CQKGQEARGBMQI@googlegroups.com Tue Dec 04 09:11:31 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBJXA62CQKGQEARGBMQI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f58.google.com ([209.85.161.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBJXA62CQKGQEARGBMQI@googlegroups.com>)
	id 1TfnbH-0004pW-5r
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 09:11:31 +0100
Received: by mail-fa0-f58.google.com with SMTP id v9sf1493554fav.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=WafjJB/r6YcnkZKbZvbLjJprJpeigN7+GhpGpVYRqjM=;
        b=bnS+cbYVzdNj5XJ/JeHKZcJPzXurWzZIF4sYfyBsQbyWw8Zmkg7mre83CRHY0sEsUF
         okDs45wh2mz5dzvP4R8QUIgY998Qt2Las2rYTQ8QOI+ej1bpO96/rlxMsIWYpV6Pu9IT
         RsJhrZrJcxs98Y7abhIgNtI7Z/+A+iraPTVG08VzulJmkQSzC7igxvWy/DyWa2Pjg7Su
         1fQvvemA2JmeEod9eK7umQqCYzYicNULN8z9/KeoK9NXtowcjgbaryBe+RHXws5ztxbu
         WbzbscFgznpDfbBlYV8o3GZWLRSO//ZXQvLvSxgg2gU0dkAgADQd7LLbx74orr7q51WS
         rJfA==
Received: by 10.180.93.227 with SMTP id cx3mr156993wib.1.1354608679479;
        Tue, 04 Dec 2012 00:11:19 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.13.235 with SMTP id fb11ls1160185wid.2.canary; Tue, 04 Dec
 2012 00:11:18 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1787870bkx.4.1354608678747;
        Tue, 04 Dec 2012 00:11:18 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1787869bkx.4.1354608678733;
        Tue, 04 Dec 2012 00:11:18 -0800 (PST)
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com [209.85.217.179])
        by gmr-mx.google.com with ESMTPS id 7si44492bkr.3.2012.12.04.00.11.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:18 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.179 as permitted sender) client-ip=209.85.217.179;
Received: by mail-lb0-f179.google.com with SMTP id gm13so2795941lbb.38
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 00:11:18 -0800 (PST)
Received: by 10.152.145.202 with SMTP id sw10mr12261745lab.22.1354608678369;
        Tue, 04 Dec 2012 00:11:18 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id ma15sm207468lab.4.2012.12.04.00.11.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:17 -0800 (PST)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
In-Reply-To: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.179 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211071>

Make sure SIG_DFL for SIGALRM exits with 128 + SIGALRM so other
processes can diagnose why it exits.

While we're at it, make sure we only write to stderr if it's a
terminal, and  change the output to match that of Linux.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index afc892d..78e8f54 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1538,8 +1538,11 @@ static sig_handler_t timer_fn = SIG_DFL;
 static unsigned __stdcall ticktack(void *dummy)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
-		if (timer_fn == SIG_DFL)
-			die("Alarm");
+		if (timer_fn == SIG_DFL) {
+			if (isatty(STDERR_FILENO))
+				fputs("Alarm clock\n", stderr);
+			exit(128 + SIGALRM);
+		}
 		if (timer_fn != SIG_IGN)
 			timer_fn(SIGALRM);
 		if (one_shot)
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
