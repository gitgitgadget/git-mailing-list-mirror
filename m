From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 4/6] compat/terminal: separate input and output handles
Date: Tue,  4 Dec 2012 09:10:40 +0100
Message-ID: <1354608642-5316-5-git-send-email-kusmabite@gmail.com>
References: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBMHA62CQKGQES7M4B4Y@googlegroups.com Tue Dec 04 09:11:41 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBMHA62CQKGQES7M4B4Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBMHA62CQKGQES7M4B4Y@googlegroups.com>)
	id 1TfnbQ-0004ur-HM
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 09:11:40 +0100
Received: by mail-la0-f58.google.com with SMTP id m14sf1486014lag.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 00:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=984yJwKajjmeEeTXLba46xWATQ1SnSXDSmNog8Lb6qU=;
        b=SVSNt20WnLuCddWw5GrFF3YTr7czQrCs6DjjdyCZh1k5YgVCPWk6VxoDdHspt0ia7A
         YXjO3z3ZTGxz2ToiM46eRBEVVMWt/82vJeNTZqw5zfBiN/et6DvTgOjBbLdmV7I6ya89
         vpgUUzqMTaLCGZiumehYU2Ii+k7Dlad36yBlzsPApnQWIdg3cbCaE2Efkr6AgC0Wl2xK
         zFSaKRMugdh/lrtnM/7N4s6QDy6sI2ySr9sDsCb0cbRHL+NQ8ClC6jsfGNn/pCRmRC/d
         Xncbjg2Kxj5QWOn2FbFxgJSKRwiYamFSs52n+ttKG1ESzjrzpOLcp1gcu82JieyJ5Ve3
         p4CA==
Received: by 10.180.97.225 with SMTP id ed1mr347756wib.0.1354608688820;
        Tue, 04 Dec 2012 00:11:28 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.87.230 with SMTP id bb6ls120946wib.12.gmail; Tue, 04 Dec
 2012 00:11:28 -0800 (PST)
Received: by 10.204.146.25 with SMTP id f25mr1791596bkv.1.1354608688035;
        Tue, 04 Dec 2012 00:11:28 -0800 (PST)
Received: by 10.204.146.25 with SMTP id f25mr1791595bkv.1.1354608688021;
        Tue, 04 Dec 2012 00:11:28 -0800 (PST)
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com [209.85.215.44])
        by gmr-mx.google.com with ESMTPS id 7si44288bkr.3.2012.12.04.00.11.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:28 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.44 as permitted sender) client-ip=209.85.215.44;
Received: by mail-la0-f44.google.com with SMTP id d3so3174158lah.3
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 00:11:27 -0800 (PST)
Received: by 10.152.124.83 with SMTP id mg19mr12228316lab.6.1354608687668;
        Tue, 04 Dec 2012 00:11:27 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id sq2sm201087lab.14.2012.12.04.00.11.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:26 -0800 (PST)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
In-Reply-To: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.44 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211074>

On Windows, the terminal cannot be opened in read-write mode, so
we need distinct pairs for reading and writing. Since this works
fine on other platforms as well, always open them in pairs.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/terminal.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index a6212ca..9aecad6 100644
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
