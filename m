From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 11/11] git: add performance tracing for git's
 main() function to debug scripts
Date: Wed, 11 Jun 2014 10:02:01 +0200
Message-ID: <53980CF9.9080906@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBB6UZ4COAKGQEGHA6XBA@googlegroups.com Wed Jun 11 10:02:05 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB6UZ4COAKGQEGHA6XBA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB6UZ4COAKGQEGHA6XBA@googlegroups.com>)
	id 1WudTw-00013G-7W
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 10:02:04 +0200
Received: by mail-we0-f192.google.com with SMTP id u57sf19398wes.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=NUEHFrnrCVMS7zjbjq0XPZHLfqiJyB0NjpycSUNn8UA=;
        b=Zrq1KrrdjrJaSutQe5yvvUyxKPL1KyVf7t0rJnRkRd1ToZ4ToGy5yFB9R5KdwN5s3W
         3CdT2xuiDSTj3b0Uceq5EWRpOiTateRTZBhM76B4AOiQPoiiydL/UpCmXplPNUGnfboo
         szsY3g5outU9sBbA6e1OldfZHjU2ziJlwHqcE/4Tf9EKUUM3kP8gMhR236F7scxcC30D
         iZ9dMVD2NkpnnKn+bqGdQh6GqRnzRoNQIn5FTN+g41kWyNbvHDf7hq1+OFM+y4ULYWWE
         NyH3Ca8tvFv2UzlknU8UK9rAI5OMXTJNIzEGQdH+Dsqklzp/4b3w1j1Wv+RfIjvVl4nG
         qQDg==
X-Received: by 10.152.43.16 with SMTP id s16mr4683lal.15.1402473723972;
        Wed, 11 Jun 2014 01:02:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.241.37 with SMTP id wf5ls464549lac.53.gmail; Wed, 11 Jun
 2014 01:02:01 -0700 (PDT)
X-Received: by 10.112.149.162 with SMTP id ub2mr83512lbb.18.1402473721622;
        Wed, 11 Jun 2014 01:02:01 -0700 (PDT)
Received: from mail-we0-x233.google.com (mail-we0-x233.google.com [2a00:1450:400c:c03::233])
        by gmr-mx.google.com with ESMTPS id eh2si1264397wib.2.2014.06.11.01.02.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:02:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::233 as permitted sender) client-ip=2a00:1450:400c:c03::233;
Received: by mail-we0-f179.google.com with SMTP id w62so4170583wes.38
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 01:02:01 -0700 (PDT)
X-Received: by 10.194.80.161 with SMTP id s1mr49327865wjx.47.1402473721476;
        Wed, 11 Jun 2014 01:02:01 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id l41sm57956636eew.8.2014.06.11.01.02.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:02:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::233
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251340>

Use trace_performance to measure and print execution time and command line
arguments of the entire main() function. In constrast to the shell's 'time'
utility, which measures total time of the parent process, this logs all
involved git commands recursively. This is particularly useful to debug
performance issues of scripted commands (i.e. which git commands were
called with which parameters, and how long did they execute).

Due to git's deliberate use of exit(), the implementation uses an atexit
routine rather than just adding trace_performance_since() at the end of
main().

Usage example: > GIT_TRACE_PERFORMANCE=~/git-trace.log git stash list

Creates a log file like this:
23:57:38.638765 trace.c:405 performance: 0.000310107 s: git command: 'git' 'rev-parse' '--git-dir'
23:57:38.644387 trace.c:405 performance: 0.000261759 s: git command: 'git' 'rev-parse' '--show-toplevel'
23:57:38.646207 trace.c:405 performance: 0.000304468 s: git command: 'git' 'config' '--get-colorbool' 'color.interactive'
23:57:38.648491 trace.c:405 performance: 0.000241667 s: git command: 'git' 'config' '--get-color' 'color.interactive.help' 'red bold'
23:57:38.650465 trace.c:405 performance: 0.000243063 s: git command: 'git' 'config' '--get-color' '' 'reset'
23:57:38.654850 trace.c:405 performance: 0.025126313 s: git command: 'git' 'stash' 'list'

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 git.c   |  2 ++
 trace.c | 22 ++++++++++++++++++++++
 trace.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/git.c b/git.c
index 7780572..d4daeb8 100644
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
index 0551509..9fc3921 100644
--- a/trace.c
+++ b/trace.c
@@ -395,3 +395,25 @@ inline uint64_t getnanotime(void)
 		return now;
 	}
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
+	if (!trace_want(GIT_TRACE_PERFORMANCE))
+		return;
+
+	if (!command_start_time)
+		atexit(print_command_performance_atexit);
+
+	strbuf_reset(&command_line);
+	sq_quote_argv(&command_line, argv, 0);
+	command_start_time = getnanotime();
+}
diff --git a/trace.h b/trace.h
index 9687563..a51e731 100644
--- a/trace.h
+++ b/trace.h
@@ -7,6 +7,7 @@
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
 extern uint64_t getnanotime(void);
+extern void trace_command_performance(const char **argv);
 
 #ifndef HAVE_VARIADIC_MACROS
 
-- 
1.9.2.msysgit.0.501.gaeecf09

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
