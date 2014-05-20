From: Karsten Blees <karsten.blees@gmail.com>
Subject: [RFC/PATCH v4 3/3] add command performance tracing to debug
 scripted commands
Date: Tue, 20 May 2014 21:11:24 +0200
Message-ID: <537BA8DC.9070104@gmail.com>
References: <537BA806.50600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBW6R52NQKGQEAHP76OQ@googlegroups.com Tue May 20 21:11:25 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBW6R52NQKGQEAHP76OQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBW6R52NQKGQEAHP76OQ@googlegroups.com>)
	id 1WmpRc-0008Ga-NU
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 21:11:24 +0200
Received: by mail-wi0-f186.google.com with SMTP id hi2sf132810wib.13
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=wpeAQEflXUbL04uFAVu3BicpjXdm+ts7jst4vor+iAo=;
        b=UdrNdF6qqh1RYjsZxCO1QcwjQLlyMD4d2Oud2MDSiUZAieZhNpo1+xxP3+5ISVjVP9
         YBM7BGBWt3TNM6ll5B8Q9iFOgDndhaRlXs+/E18mrUSJqxUV6Col0dthH1rQCSpXL2Od
         byN3r13dHtGJJp+or3g+FdwuhLdnf3nhexcdtM3e4ulAI6LER/CALYO/y9x1RONwarXp
         E1R3UG3j5Ojb3t+lc/ULg7/EZXJDXoHD0u4A22n4U6Pkv0E5lwxevomKMiYXXNJLgIF/
         M5xBcsp66q5bpWNJiunsCgzkujDSJ7lmV3BjoTFQZTIPZKcQuGQ+nu390tZGXy6w9lDB
         d8uQ==
X-Received: by 10.180.90.7 with SMTP id bs7mr30537wib.7.1400613084474;
        Tue, 20 May 2014 12:11:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.13.50 with SMTP id ev18ls172527wid.48.gmail; Tue, 20 May
 2014 12:11:23 -0700 (PDT)
X-Received: by 10.180.206.33 with SMTP id ll1mr588108wic.5.1400613083480;
        Tue, 20 May 2014 12:11:23 -0700 (PDT)
Received: from mail-ee0-x233.google.com (mail-ee0-x233.google.com [2a00:1450:4013:c00::233])
        by gmr-mx.google.com with ESMTPS id r49si995286eep.0.2014.05.20.12.11.23
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::233 as permitted sender) client-ip=2a00:1450:4013:c00::233;
Received: by mail-ee0-f51.google.com with SMTP id e51so854022eek.24
        for <msysgit@googlegroups.com>; Tue, 20 May 2014 12:11:23 -0700 (PDT)
X-Received: by 10.14.219.9 with SMTP id l9mr6112926eep.115.1400613083408;
        Tue, 20 May 2014 12:11:23 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id g8sm5945884eep.0.2014.05.20.12.11.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <537BA806.50600@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::233
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249733>

Add performance tracing to identify which git commands are called and how
long they execute. This is particularly useful to debug performance issues
of scripted commands.

Usage example: > GIT_TRACE_PERFORMANCE=~/git-trace.log git stash list

Creates a log file like this:
performance: at trace.c:319, time: 0.000303280 s: git command: 'git' 'rev-parse' '--git-dir'
performance: at trace.c:319, time: 0.000334409 s: git command: 'git' 'rev-parse' '--is-inside-work-tree'
performance: at trace.c:319, time: 0.000215243 s: git command: 'git' 'rev-parse' '--show-toplevel'
performance: at trace.c:319, time: 0.000410639 s: git command: 'git' 'config' '--get-colorbool' 'color.interactive'
performance: at trace.c:319, time: 0.000394077 s: git command: 'git' 'config' '--get-color' 'color.interactive.help' 'red bold'
performance: at trace.c:319, time: 0.000280701 s: git command: 'git' 'config' '--get-color' '' 'reset'
performance: at trace.c:319, time: 0.000908185 s: git command: 'git' 'rev-parse' '--verify' 'refs/stash'
performance: at trace.c:319, time: 0.028827774 s: git command: 'git' 'stash' 'list'

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 cache.h |  1 +
 git.c   |  2 ++
 trace.c | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/cache.h b/cache.h
index cb856d9..289e8fd 100644
--- a/cache.h
+++ b/cache.h
@@ -1366,6 +1366,7 @@ extern uint64_t getnanotime(void);
 __attribute__((format (printf, 4, 5)))
 extern uint64_t trace_performance_file_line(const char *file, int lineno,
 	uint64_t nanos, const char *fmt, ...);
+extern void trace_command_performance(const char **argv);
 
 /*
  * Prints specified time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
diff --git a/git.c b/git.c
index 9efd1a3..2ea65b1 100644
--- a/git.c
+++ b/git.c
@@ -568,6 +568,8 @@ int main(int argc, char **av)
 
 	git_setup_gettext();
 
+	trace_command_performance(argv);
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
diff --git a/trace.c b/trace.c
index 1b1903b..9edcb59 100644
--- a/trace.c
+++ b/trace.c
@@ -309,3 +309,25 @@ uint64_t trace_performance_file_line(const char *file, int lineno,
 	strbuf_release(&buf);
 	return getnanotime();
 }
+
+static uint64_t command_start_time;
+static struct strbuf command_line = STRBUF_INIT;
+
+static void print_command_performance_atexit(void)
+{
+	trace_performance_since(command_start_time, "git command:%s",
+				command_line.buf);
+}
+
+void trace_command_performance(const char **argv)
+{
+	if (!trace_want_performance())
+		return;
+
+	if (!command_start_time)
+		atexit(print_command_performance_atexit);
+
+	strbuf_reset(&command_line);
+	sq_quote_argv(&command_line, argv, 0);
+	command_start_time = getnanotime();
+}
-- 
1.9.2.msysgit.0.493.g47a82c3

-- 
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

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
