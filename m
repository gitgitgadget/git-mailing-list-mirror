From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 10/14] daemon: use full buffered mode for stderr
Date: Fri, 15 Jan 2010 22:30:29 +0100
Message-ID: <1263591033-4992-11-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3yN5QSwkOB0Mpzxrfgnyjlttlqjrfnq.htrrx3xlnylttlqjlwtzux.htr@listserv.bounces.google.com Fri Jan 15 22:32:15 2010
Return-path: <3yN5QSwkOB0Mpzxrfgnyjlttlqjrfnq.htrrx3xlnylttlqjlwtzux.htr@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtm4-0005YL-Vf
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 22:32:09 +0100
Received: by mail-yw0-f161.google.com with SMTP id 33sf2129132ywh.24
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 13:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=RxJLNlkPltQXvlNor7ua6ulrl6RLnVXl0oiMS/LnD3k=;
        b=e76WRASz1DVW6mqZU/MFJ2HSCpHdsPnFBid7QFyK84xFcr1dSUsDt7hG7q9N6AWKG6
         N7Y94DSQru3HmZGtERKSELk5I/Rhsu5MJLNu1mseeWVjx4QixdW6PTihRkoar4pt9a4l
         8uFsCxo3KJFn4xB/7pf03Ex2z96+9T9MFcHr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=OyQn0/dnSQQYXiP54Cy3mq1zq14j5HArUUOpu0troAMdWwxDb3Mjw8hLF0tZHXsR2G
         fJ+abbE0uQXXyzj3SMXZB1J19HR9QSZ4FwU01sb0i94xumVODCdz3cOx/BazVGW7YKEM
         W3RT520AVlGvVNXBk92jW4VM6OL3nLOlj+JqQ=
Received: by 10.101.180.10 with SMTP id h10mr223792anp.18.1263591112253;
        Fri, 15 Jan 2010 13:31:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.60.1 with SMTP id n1ls305046ebh.3.p; Fri, 15 Jan 2010 
	13:31:50 -0800 (PST)
Received: by 10.213.109.147 with SMTP id j19mr455039ebp.13.1263591110242;
        Fri, 15 Jan 2010 13:31:50 -0800 (PST)
Received: by 10.213.109.147 with SMTP id j19mr455038ebp.13.1263591110217;
        Fri, 15 Jan 2010 13:31:50 -0800 (PST)
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com [209.85.219.226])
        by gmr-mx.google.com with ESMTP id 17si34027ewy.7.2010.01.15.13.31.49;
        Fri, 15 Jan 2010 13:31:49 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.226 as permitted sender) client-ip=209.85.219.226;
Received: by ewy26 with SMTP id 26so1283666ewy.3
        for <msysgit@googlegroups.com>; Fri, 15 Jan 2010 13:31:49 -0800 (PST)
Received: by 10.213.100.229 with SMTP id z37mr2841877ebn.87.1263591108800;
        Fri, 15 Jan 2010 13:31:48 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 13sm1807041ewy.13.2010.01.15.13.31.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:48 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.226 as permitted 
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
X-Message-Url: http://groups.google.com/group/msysgit/msg/a4980671d52edcf
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137129>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 2d63cbc..fc2c150 100644
--- a/daemon.c
+++ b/daemon.c
@@ -66,12 +66,14 @@ static void logreport(int priority, const char *err, va_list params)
 		syslog(priority, "%s", buf);
 	} else {
 		/*
-		 * Since stderr is set to linebuffered mode, the
+		 * Since stderr is set to buffered mode, the
 		 * logging of different processes will not overlap
+		 * unless they overflow the (rather big) buffers.
 		 */
 		fprintf(stderr, "[%"PRIuMAX"] ", (uintmax_t)getpid());
 		vfprintf(stderr, err, params);
 		fputc('\n', stderr);
+		fflush(stderr);
 	}
 }
 
@@ -1062,7 +1064,7 @@ int main(int argc, char **argv)
 		set_die_routine(daemon_die);
 	} else
 		/* avoid splitting a message in the middle */
-		setvbuf(stderr, NULL, _IOLBF, 0);
+		setvbuf(stderr, NULL, _IOFBF, 4096);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
-- 
1.6.6.211.g26720
