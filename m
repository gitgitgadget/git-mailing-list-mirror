From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 14/16] git: add performance tracing for git's
 main() function to debug scripts
Date: Wed, 02 Jul 2014 01:03:55 +0200
Message-ID: <53B33E5B.9040307@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBW74ZSOQKGQE6SNWDRA@googlegroups.com Wed Jul 02 01:03:57 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBW74ZSOQKGQE6SNWDRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBW74ZSOQKGQE6SNWDRA@googlegroups.com>)
	id 1X275g-0005WL-L4
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 01:03:56 +0200
Received: by mail-wi0-f189.google.com with SMTP id n15sf781165wiw.16
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=w7ykQjdE1IQmhdqeR0KLyHnZdBzD3YCslXr4S4el1uE=;
        b=BXXAafxcWmoNCTdDbTXBfdLvda+ESo/3tKl1sGr/gt7x5XebvYdowdkjXQhpnwCQ8C
         7Su6ABmvm3rVHnuF0AWyCNSgN+DF6HhwB3xxYDkwgBe24G5iYBpCvPZgCk5LTtt3hyas
         7bS4a/woJagb5rISLM68yvOTUxbV7eeRrfhC8KZSxbqt1SmbyDC13YaywDdjoAag2mWW
         GWeiARblBexJLEiAxr2yAD92SJfAJgqtVWqKoOLTnXpX0swYhwUe3sNctS05bsf32NNF
         rsYeGrqrDh/DGHtV6AVMvroxsp4BaXTQIXK9rchzrwsm+eYGTNwC643kPFZoifCckXO8
         HY0w==
X-Received: by 10.153.6.39 with SMTP id cr7mr537550lad.1.1404255836392;
        Tue, 01 Jul 2014 16:03:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.99 with SMTP id p3ls398522laj.6.gmail; Tue, 01 Jul 2014
 16:03:55 -0700 (PDT)
X-Received: by 10.112.1.70 with SMTP id 6mr690303lbk.16.1404255835281;
        Tue, 01 Jul 2014 16:03:55 -0700 (PDT)
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com [2a00:1450:400c:c05::232])
        by gmr-mx.google.com with ESMTPS id l9si805797wiy.2.2014.07.01.16.03.55
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:03:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::232 as permitted sender) client-ip=2a00:1450:400c:c05::232;
Received: by mail-wi0-f178.google.com with SMTP id n15so8574243wiw.5
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 16:03:55 -0700 (PDT)
X-Received: by 10.180.97.67 with SMTP id dy3mr532681wib.16.1404255835144;
        Tue, 01 Jul 2014 16:03:55 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o2sm48237175wia.16.2014.07.01.16.03.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:03:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252763>

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
 Documentation/git.txt |  5 +++++
 git.c                 |  2 ++
 trace.c               | 22 ++++++++++++++++++++++
 trace.h               |  1 +
 4 files changed, 30 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9d073f6..fcb8afa 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -938,6 +938,11 @@ Unsetting the variable, or setting it to empty, "0" or
 	starting with "PACK".
 	See 'GIT_TRACE' for available trace output options.
 
+'GIT_TRACE_PERFORMANCE'::
+	Enables performance related trace messages, e.g. total execution
+	time of each Git command.
+	See 'GIT_TRACE' for available trace output options.
+
 'GIT_TRACE_SETUP'::
 	Enables trace messages printing the .git, working tree and current
 	working directory after Git has completed its setup phase.
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
index af64dbb..e583dc6 100644
--- a/trace.c
+++ b/trace.c
@@ -404,3 +404,25 @@ inline uint64_t getnanotime(void)
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
+	if (!trace_want(&trace_perf_key))
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
index 92d0fa6..74d7396 100644
--- a/trace.h
+++ b/trace.h
@@ -17,6 +17,7 @@ extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
+extern void trace_command_performance(const char **argv);
 
 #ifndef HAVE_VARIADIC_MACROS
 
-- 
2.0.0.406.ge74f8ff

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
