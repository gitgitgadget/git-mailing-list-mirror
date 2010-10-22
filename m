From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 10/15] daemon: get remote host address from root-process
Date: Fri, 22 Oct 2010 02:05:39 +0200
Message-ID: <1287705944-5668-10-git-send-email-kusmabite@gmail.com>
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
X-From: msysgit+bncCOPdven-DxCbq4PmBBoESDJL5w@googlegroups.com Fri Oct 22 02:07:16 2010
Return-path: <msysgit+bncCOPdven-DxCbq4PmBBoESDJL5w@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCbq4PmBBoESDJL5w@googlegroups.com>)
	id 1P95AB-0004SK-Oa
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:15 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf128526wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=PZH9dhksa5eheD9DPavycizA0yIEVohQJ5bYTbm88jo=;
        b=WNJ6Kj2PHfdotOsI5ArIS81FP3se/HzRrOzUO3+T4sBIwlEnsrcVHunDV0wGUQz0uX
         vBy4R8HIYUsqr1+Px2JiKb0Ukxy4w7u7Vht+0w0gGaM1vbk7Qu2HBkclCFMM1Fh4XHBG
         e71JQLzmSG3MVs5sS3eCsr9+4c47yFfbDCt0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=MIeDYiI3MMBdaGLie2oGyrr1vrgYZe5RL9S/j7o8Tq4PpBBbhsEvDCJ5lldSc3PqRh
         3wQ/Tgmj7ufiKssTUXjE0McyBSOG9DYiOmImkSznx2qfl4KyO62ZvqmEdW3awVGjoOt3
         RaunJDvPdISxBPHKmFt/cmidmah9qAq7rjMdk=
Received: by 10.216.162.6 with SMTP id x6mr15694wek.0.1287706011353;
        Thu, 21 Oct 2010 17:06:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.10.75 with SMTP id 51ls268318eeu.6.p; Thu, 21 Oct 2010
 17:06:50 -0700 (PDT)
Received: by 10.14.2.211 with SMTP id 59mr171301eef.28.1287706010619;
        Thu, 21 Oct 2010 17:06:50 -0700 (PDT)
Received: by 10.14.2.211 with SMTP id 59mr171300eef.28.1287706010567;
        Thu, 21 Oct 2010 17:06:50 -0700 (PDT)
Received: from mail-ey0-f169.google.com (mail-ey0-f169.google.com [209.85.215.169])
        by gmr-mx.google.com with ESMTP id q11si1424383eeh.4.2010.10.21.17.06.49;
        Thu, 21 Oct 2010 17:06:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.169 as permitted sender) client-ip=209.85.215.169;
Received: by eydd26 with SMTP id d26so119997eyd.14
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:49 -0700 (PDT)
Received: by 10.213.22.81 with SMTP id m17mr8828751ebb.3.1287706009236;
        Thu, 21 Oct 2010 17:06:49 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm2455690eeh.11.2010.10.21.17.06.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.169 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159601>

Get remote host in the process that accept() and pass it through
the REMOTE_ADDR environment variable to the handler-process.
Introduce the REMOTE_PORT environmen variable for the port.

Use these variables for reporting instead of doing
getpeername(0, ...), which doesn't work on Windows.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   67 +++++++++++++++++++++++++++----------------------------------
 1 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/daemon.c b/daemon.c
index b72c89f..19b4eb3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -516,37 +516,14 @@ static void parse_host_arg(char *extra_args, int buflen)
 }
 
 
-static int execute(struct sockaddr *addr)
+static int execute(void)
 {
 	static char line[1000];
 	int pktlen, len, i;
+	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 
-	if (addr) {
-		char addrbuf[256] = "";
-		int port = -1;
-
-		if (addr->sa_family == AF_INET) {
-			struct sockaddr_in *sin_addr = (void *) addr;
-			inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-			port = ntohs(sin_addr->sin_port);
-#ifndef NO_IPV6
-		} else if (addr && addr->sa_family == AF_INET6) {
-			struct sockaddr_in6 *sin6_addr = (void *) addr;
-
-			char *buf = addrbuf;
-			*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
-			inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
-			strcat(buf, "]");
-
-			port = ntohs(sin6_addr->sin6_port);
-#endif
-		}
-		loginfo("Connection from %s:%d", addrbuf, port);
-		setenv("REMOTE_ADDR", addrbuf, 1);
-	}
-	else {
-		unsetenv("REMOTE_ADDR");
-	}
+	if (addr)
+		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen = packet_read_line(0, line, sizeof(line));
@@ -680,6 +657,8 @@ static char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
 	struct child_process cld = { 0 };
+	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
+	char *env[] = { addrbuf, portbuf, NULL };
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -692,6 +671,28 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 		}
 	}
 
+	if (addr->sa_family == AF_INET) {
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf + 12,
+		    sizeof(addrbuf) - 12);
+		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
+		    ntohs(sin_addr->sin_port));
+#ifndef NO_IPV6
+	} else if (addr && addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+
+		char *buf = addrbuf + 12;
+		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf,
+		    sizeof(addrbuf) - 13);
+		strcat(buf, "]");
+
+		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
+		    ntohs(sin6_addr->sin6_port));
+#endif
+	}
+
+	cld.env = (const char **)env;
 	cld.argv = (const char **)cld_argv;
 	cld.in = incoming;
 	cld.out = dup(incoming);
@@ -1160,16 +1161,8 @@ int main(int argc, char **argv)
 			die_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (inetd_mode || serve_mode) {
-		struct sockaddr_storage ss;
-		struct sockaddr *peer = (struct sockaddr *)&ss;
-		socklen_t slen = sizeof(ss);
-
-		if (getpeername(0, peer, &slen))
-			peer = NULL;
-
-		return execute(peer);
-	}
+	if (inetd_mode || serve_mode)
+		return execute();
 
 	if (detach) {
 		daemonize();
-- 
1.7.3.1.199.g72340
