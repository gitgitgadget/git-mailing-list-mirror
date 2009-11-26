From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 10/11] daemon: use full buffered mode for stderr
Date: Thu, 26 Nov 2009 00:44:19 +0000
Message-ID: <1259196260-3064-11-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-10-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org, dotzenlabs@gmail.com, Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3lM8NSwkOB7wmwuocdkvgiqqingockn.eqoou0uikviqqingitqwru.eqo@listserv.bounces.google.com Thu Nov 26 01:45:28 2009
Return-path: <3lM8NSwkOB7wmwuocdkvgiqqingockn.eqoou0uikviqqingitqwru.eqo@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pw0-f74.google.com ([209.85.160.74])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSUA-0001Ju-As
	for gcvm-msysgit@m.gmane.org; Thu, 26 Nov 2009 01:45:26 +0100
Received: by mail-pw0-f74.google.com with SMTP id 12sf58861pwi.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Nov 2009 16:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:x-thread-url:x-message-url
         :list-unsubscribe:list-subscribe;
        bh=un6dowA3DOnumJc3fTRmaSncTzAVzrKjywrpoOEaUoQ=;
        b=FNT/TdKLjsFk0bz/rbdTcYIEVSWpZAKnLZ/bObvDnzNpN5+MKDgvOBuUTIhe4IOjSv
         jR0R8dDXsWXiyEcrpdZ7BTunLi1x3uj30qi6I0xQ+OmDqXKIZxwaMnxGQ3BP3CB2xYP8
         qzjc2vQFW+/SAcHFZ3y6u09e0zjqm28DOCr2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:x-thread-url:x-message-url
         :list-unsubscribe:list-subscribe;
        b=thjB1kOnIzeqUCC0eclqB/zG4qN7mgrY4WCIa/T6ncURbLwjaAyQPgvdxnGnpbs0io
         EJbfSyVVtbIaUerhNvL5SLWxnOS/kUIBXByhLOEA+XADmJoqoYzEgMV/1eRF529cWCso
         277/R4NhmWgU2qD4UV0MWig21frFzCokJlWpA=
Received: by 10.115.101.29 with SMTP id d29mr299629wam.2.1259196308902;
        Wed, 25 Nov 2009 16:45:08 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.114.187.1 with SMTP id k1ls88781waf.0.p; Wed, 25 Nov 2009 
	16:45:07 -0800 (PST)
Received: by 10.114.105.11 with SMTP id d11mr2051501wac.21.1259196307335;
        Wed, 25 Nov 2009 16:45:07 -0800 (PST)
Received: by 10.114.105.11 with SMTP id d11mr2051500wac.21.1259196307300;
        Wed, 25 Nov 2009 16:45:07 -0800 (PST)
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com [209.85.219.217])
        by gmr-mx.google.com with ESMTP id 16si26968pxi.5.2009.11.25.16.45.05;
        Wed, 25 Nov 2009 16:45:06 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.217 as permitted sender) client-ip=209.85.219.217;
Received: by mail-ew0-f217.google.com with SMTP id 9so299172ewy.11
        for <msysgit@googlegroups.com>; Wed, 25 Nov 2009 16:45:05 -0800 (PST)
Received: by 10.213.107.17 with SMTP id z17mr8686682ebo.10.1259196305642;
        Wed, 25 Nov 2009 16:45:05 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 10sm386164eyz.47.2009.11.25.16.45.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:45:05 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-10-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.217 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/15f3dd983aa85143
X-Message-Url: http://groups.google.com/group/msysgit/msg/e765e9b569b29783
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133741>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 1b0e290..130e951 100644
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
 
@@ -1094,7 +1096,7 @@ int main(int argc, char **argv)
 		set_die_routine(daemon_die);
 	} else
 		/* avoid splitting a message in the middle */
-		setvbuf(stderr, NULL, _IOLBF, 0);
+		setvbuf(stderr, NULL, _IOFBF, 4096);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
-- 
1.6.5.rc2.7.g4f8d3
