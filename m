From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH, maint] setup: make sure git_dir path is in a
 permanent buffer, getenv(3) case
Date: Thu, 11 Nov 2010 21:08:23 +0300
Message-ID: <1289498903-18413-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	msysgit@googlegroups.com,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncCM2jlMK5EBCn5PDmBBoEPL76tg@googlegroups.com Thu Nov 11 19:13:21 2010
Return-path: <msysgit+bncCM2jlMK5EBCn5PDmBBoEPL76tg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM2jlMK5EBCn5PDmBBoEPL76tg@googlegroups.com>)
	id 1PGbeB-0006MO-KB
	for gcvm-msysgit@m.gmane.org; Thu, 11 Nov 2010 19:13:19 +0100
Received: by wwb28 with SMTP id 28sf1382359wwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 11 Nov 2010 10:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received:received-spf:received:received
         :from:to:cc:subject:date:message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Hrg3aW+3/7nfPZQP8BR33N3SlSxmLFO3vSGZgNvmH6Y=;
        b=q8QdxciV2EwtV2Cgnya06g9EsABr1ha8AHBw/kqlAmzxOr+HLHl2vfUmT+wbpyCbnq
         klSf1ttHVJZMXV8STaQJTx1dKeXXMcBbvF5DEOn7fAFG8q794RmWrdG8n5ZxD7mdX6Ue
         KOXfspkUSuRmJ1CF9lt/i03Og7ooxq/ho9s2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=fvapZxcBK03A98imQxS21ZIa9CPJHRb4tjdfFqtOR6uLsVbjYhyRUVVSLT2d/fSs3I
         NpT9At0OHBWnqtOCxIOMFAC2HuYQh1Vdn4SKQoUjJuV2VbckyQIbEjSlXhjNaojfu4N2
         TABMjCNz/68nbgezt0y6yXegcW2cpssm7gOYk=
Received: by 10.216.52.195 with SMTP id e45mr255270wec.19.1289499175621;
        Thu, 11 Nov 2010 10:12:55 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.208.4 with SMTP id p4ls851235weo.2.p; Thu, 11 Nov 2010
 10:12:54 -0800 (PST)
Received: by 10.216.19.143 with SMTP id n15mr214941wen.6.1289499174272;
        Thu, 11 Nov 2010 10:12:54 -0800 (PST)
Received: by 10.14.47.65 with SMTP id s41mr152559eeb.14.1289498849535;
        Thu, 11 Nov 2010 10:07:29 -0800 (PST)
Received: by 10.14.47.65 with SMTP id s41mr152558eeb.14.1289498849523;
        Thu, 11 Nov 2010 10:07:29 -0800 (PST)
Received: from mail.mnsspb.ru (mail.mnsspb.ru [84.204.75.2])
        by gmr-mx.google.com with ESMTP id t6si704226eeh.4.2010.11.11.10.07.28;
        Thu, 11 Nov 2010 10:07:29 -0800 (PST)
Received-SPF: pass (google.com: domain of kirr@mns.spb.ru designates 84.204.75.2 as permitted sender) client-ip=84.204.75.2;
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PGbXq-00043q-I1; Thu, 11 Nov 2010 21:06:46 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PGbZS-0004nX-0k; Thu, 11 Nov 2010 21:08:26 +0300
X-Mailer: git-send-email 1.7.3.2.161.g3089c
X-Original-Sender: kirr@mns.spb.ru
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kirr@mns.spb.ru designates 84.204.75.2 as permitted sender) smtp.mail=kirr@mns.spb.ru
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161284>

getenv(3) returns not-permanent buffer which may be changed by e.g.
putenv(3) call (*).

In practice I've noticed this when trying to do `git commit -m abc`
inside msysgit under wine, getting

    $ git commit -m abc
    fatal: could not open 'DIR=.git/COMMIT_EDITMSG': No such file or directory
                           ^^^^
    (notice introduced 'DIR=' artifact.)

The problem was showing itself only with -m option, and actually, as
debugging showed, originally

    git_dir = getenv("GIT_DIR")

returned pointer to

        "GIT_DIR=.git\0"
                 ^
               git_dir

, we stored it in git_dir, than, after processing -m git-commit option,
we did setenv("GIT_EDITOR", ":") which as (*) says changed environment
variables memory layout - something like this

       "...\0GIT_DIR=.git\0"
                 ^
               git_dir

and oops - we got wrong git_dir.

Avoid that by strdupping getenv("GIT_DIR") result like we did in 06f354
(setup: make sure git dir path is in a permanent buffer). Unfortunately
this also shows that other getenv usage inside git needs auditing...

(*) from man 3 getenv:

       The implementation of getenv() is not required to  be  reentrant.   The
       string  pointed  to  by  the return value of getenv() may be statically
       allocated, and can be  modified  by  a  subsequent  call  to  getenv(),
       putenv(3), setenv(3), or unsetenv(3).

Cc: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 environment.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/environment.c b/environment.c
index eaf908b..d5021e8 100644
--- a/environment.c
+++ b/environment.c
@@ -88,6 +88,7 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
+	git_dir = git_dir ? xstrdup(git_dir) : NULL;
 	if (!git_dir) {
 		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
 		git_dir = git_dir ? xstrdup(git_dir) : NULL;
-- 
1.7.3.2.161.g3089c
