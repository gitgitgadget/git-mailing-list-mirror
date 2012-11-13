From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 3/5] compat/terminal: separate input and output handles
Date: Tue, 13 Nov 2012 15:04:05 +0100
Message-ID: <1352815447-8824-4-git-send-email-kusmabite@gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org,
	msysgit@googlegroups.com
X-From: msysgit+bncBDR53PPJ7YHRB4NGRGCQKGQENX4KAXA@googlegroups.com Tue Nov 13 15:04:43 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB4NGRGCQKGQENX4KAXA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB4NGRGCQKGQENX4KAXA@googlegroups.com>)
	id 1TYH6Z-0004Gt-9L
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 15:04:43 +0100
Received: by mail-wg0-f58.google.com with SMTP id dt12sf2509567wgb.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=1kPUPu6QppIY1ktzpTpQU7LRTZZ0Z99APiVOr7sezDs=;
        b=yRQPOP4+HNHhivy1O9Zrop+ukxt2Sa94R2t30QZcby7ATPqneEEjGaaWUpDWg/hrZV
         sVx1nMJreHNww0DnZwR6s8EtSaU8zsEjpNYFs1Ddt7EeZHs+qIHddhe1lH6wMGKGrt8L
         DIHt8Oz9Pa2ZxLN+1lsNK0r7L4O674MDtDv3RNd2YZkHRqxSK4NKu0QUFuOFeLKLYWX+
         rq/Q984YTyAUhb2Su9PRejFTko/oULphS/3PEFVctWrfg6GCF1fmAAi94yByCcvzl8IR
         G5EAkn2RSvr0yzNQy7jLKXWcsIO/396tPYHndUKXpR1GSc+OFMLLZdUm5MWrrxwd2etG
         gh0A==
Received: by 10.204.9.5 with SMTP id j5mr2095262bkj.9.1352815473633;
        Tue, 13 Nov 2012 06:04:33 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.131.72 with SMTP id w8ls7889023bks.3.gmail; Tue, 13 Nov
 2012 06:04:32 -0800 (PST)
Received: by 10.204.129.9 with SMTP id m9mr1737636bks.1.1352815472861;
        Tue, 13 Nov 2012 06:04:32 -0800 (PST)
Received: by 10.204.129.9 with SMTP id m9mr1737634bks.1.1352815472842;
        Tue, 13 Nov 2012 06:04:32 -0800 (PST)
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com [209.85.217.172])
        by gmr-mx.google.com with ESMTPS id x17si828275bkw.3.2012.11.13.06.04.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:32 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.172 as permitted sender) client-ip=209.85.217.172;
Received: by mail-lb0-f172.google.com with SMTP id y2so2528055lbk.3
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 06:04:32 -0800 (PST)
Received: by 10.152.106.237 with SMTP id gx13mr21298160lab.46.1352815472488;
        Tue, 13 Nov 2012 06:04:32 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id l1sm3835409lbm.1.2012.11.13.06.04.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:31 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.1.g1cbcfae.dirty
In-Reply-To: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.172 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209607>

On Windows, the terminal cannot be opened in read-write mode, so
we need distinct pairs for reading and writing. Since this works
fine on other platforms as well, always open them in pairs.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/terminal.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 3217838..4a1fd3d 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -50,29 +50,36 @@ char *git_terminal_prompt(const char *prompt, int echo)
 {
 	static struct strbuf buf = STRBUF_INIT;
 	int r;
-	FILE *fh;
+	FILE *input_fh, *output_fh;
 
-	fh = fopen("/dev/tty", "w+");
-	if (!fh)
+	input_fh = fopen("/dev/tty", "r");
+	if (!input_fh)
 		return NULL;
 
+	output_fh = fopen("/dev/tty", "w");
+	if (!output_fh) {
+		fclose(input_fh);
+		return NULL;
+	}
+
 	if (!echo && disable_echo()) {
-		fclose(fh);
+		fclose(input_fh);
+		fclose(output_fh);
 		return NULL;
 	}
 
-	fputs(prompt, fh);
-	fflush(fh);
+	fputs(prompt, output_fh);
+	fflush(output_fh);
 
-	r = strbuf_getline(&buf, fh, '\n');
+	r = strbuf_getline(&buf, input_fh, '\n');
 	if (!echo) {
-		fseek(fh, SEEK_CUR, 0);
-		putc('\n', fh);
-		fflush(fh);
+		putc('\n', output_fh);
+		fflush(output_fh);
 	}
 
 	restore_term();
-	fclose(fh);
+	fclose(input_fh);
+	fclose(output_fh);
 
 	if (r == EOF)
 		return NULL;
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
