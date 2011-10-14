From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 8/8] mingw: ensure sockets are initialized before
 calling gethostname
Date: Fri, 14 Oct 2011 23:53:35 +0100
Message-ID: <1318632815-29945-9-git-send-email-patthoyts@users.sourceforge.net>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com Sat Oct 15 00:55:55 2011
Return-path: <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>)
	id 1REqfQ-0001EQ-0g
	for gcvm-msysgit@m.gmane.org; Sat, 15 Oct 2011 00:55:52 +0200
Received: by wyg19 with SMTP id 19sf5251041wyg.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Oct 2011 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-cloudmark-analysis
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=61h8zJFwo4+XCFYOajqwBNJHKovr4I6SIirWKMWaDC0=;
        b=wmQq3Nqrmv7mjsp0kN0uFyxachyMLjbiujLnV2SFql0x2eu7iEOGezvn/mt+nfqZ2B
         m4o+eQY4sWh8/jybstqiMIWDCEYHHbRc/lgZNEH3sM/JoOeh0xdQzniF2AUvGd/pyO0f
         D/2GyTDeifT8x3K2fK7MIAebSCXAwlEgb6nx4=
Received: by 10.216.179.205 with SMTP id h55mr123864wem.2.1318632922386;
        Fri, 14 Oct 2011 15:55:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.205.7 with SMTP id i7ls14966761weo.0.gmail; Fri, 14 Oct
 2011 15:55:21 -0700 (PDT)
Received: by 10.216.221.89 with SMTP id q67mr267941wep.2.1318632921670;
        Fri, 14 Oct 2011 15:55:21 -0700 (PDT)
Received: by 10.216.150.224 with SMTP id z74mswej;
        Fri, 14 Oct 2011 15:54:09 -0700 (PDT)
Received: by 10.216.229.85 with SMTP id g63mr47334weq.10.1318632848823;
        Fri, 14 Oct 2011 15:54:08 -0700 (PDT)
Received: by 10.216.229.85 with SMTP id g63mr47333weq.10.1318632848807;
        Fri, 14 Oct 2011 15:54:08 -0700 (PDT)
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com. [81.103.221.49])
        by gmr-mx.google.com with ESMTP id d7si5620766wbp.2.2011.10.14.15.54.08;
        Fri, 14 Oct 2011 15:54:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of pat@patthoyts.tk designates 81.103.221.49 as permitted sender) client-ip=81.103.221.49;
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225408.CLYZ8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:54:08 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqdk-0000kG-9N; Fri, 14 Oct 2011 23:54:08 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id D88E320A65; Fri, 14 Oct 2011 23:54:07 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=VBQoK72hXr8A:10 a=FP58Ms26AAAA:8 a=UD-kLrrJ6qfRlAyR1vwA:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pat@patthoyts.tk designates 81.103.221.49 as permitted sender) smtp.mail=pat@patthoyts.tk
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183625>

If the Windows sockets subsystem has not been initialized yet then an
attempt to get the hostname returns an error and prints a warning to the
console. This solves this issue for msysGit as seen with 'git fetch'.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 compat/mingw.c |    7 +++++++
 compat/mingw.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8947418..efdc703 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1321,6 +1321,13 @@ static void ensure_socket_initialization(void)
 	initialized = 1;
 }
 
+#undef gethostname
+int mingw_gethostname(char *name, int namelen)
+{
+    ensure_socket_initialization();
+    return gethostname(name, namelen);
+}
+
 #undef gethostbyname
 struct hostent *mingw_gethostbyname(const char *host)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index ce9dd98..fecf0d0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -190,6 +190,9 @@ char *mingw_getcwd(char *pointer, int len);
 char *mingw_getenv(const char *name);
 #define getenv mingw_getenv
 
+int mingw_gethostname(char *host, int namelen);
+#define gethostname mingw_gethostname
+
 struct hostent *mingw_gethostbyname(const char *host);
 #define gethostbyname mingw_gethostbyname
 
-- 
1.7.7.1.gbba15
