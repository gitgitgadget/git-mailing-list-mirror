From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] MinGW: Quote arguments for subprocesses that
 contain a single-quote
Date: Tue, 24 Mar 2009 21:43:02 +0100
Message-ID: <200903242143.03010.j6t@kdbg.org>
Reply-To: j6t@kdbg.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Mar 24 21:44:43 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmDUG-0008Qt-5H
	for gcvm-msysgit@m.gmane.org; Tue, 24 Mar 2009 21:44:40 +0100
Received: by yw-out-2122.google.com with SMTP id 1so1066264ywp.63
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Mar 2009 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=4NzLOvg1Yu8H27wpM0utCt6Fw6KEnYcLtBzCa9a+fDs=;
        b=4nQJnr06IYvlg763SragPLJK9muMeQ4UebS2ev2MkrNk+JJB43QBjPhK3OYsOOXfSb
         MouX4WZcUB9JHw/XCLVbqYx+ZyW7BZteLbvMhweWyyqPkQe4dfA+wVBJu+3mZ16Dl0qK
         keJaZAyskWApCpOlhFBKV17lx46rANOEW4I4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=t7YRx+RL9ULZVhr8Zg3voIzbpFEEd6CUug2b0iAYmgpJvU6xKYpOA+qWTMW1KK+G+d
         xCV7aLNgC87gWhn0pIxISdiOimoCYzEUcJuHjdals7F0lZsIwkFc6+WnnU0e8JWigjCA
         cxiU7Sy/y52dxFQkWxnXo1u3CI4gXmlVyGyTA=
Received: by 10.150.212.16 with SMTP id k16mr1407308ybg.21.1237927384651;
        Tue, 24 Mar 2009 13:43:04 -0700 (PDT)
Received: by 10.177.145.19 with SMTP id x19gr4418yqn.0;
	Tue, 24 Mar 2009 13:43:04 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.77.93 with SMTP id f29mr214787bkk.16.1237927383874; Tue, 24 Mar 2009 13:43:03 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14]) by gmr-mx.google.com with ESMTP id 13si644575bwz.3.2009.03.24.13.43.03; Tue, 24 Mar 2009 13:43:03 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.14;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from dx.sixt.local (unknown [93.83.142.38]) by bsmtp.bon.at (Postfix) with ESMTP id 51800CDF93; Tue, 24 Mar 2009 21:43:03 +0100 (CET)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id 216CA5BC0A; Tue, 24 Mar 2009 21:43:03 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114487>


Before a process can be spawned by mingw_spawnve, arguments must be
surrounded by double-quotes if special characters are present.  This is
necessary because the startup code of the spawned process will expand
arguments that look like glob patterns.  "Normal" Windows command line
utilities expand only * and ?, but MSYS programs, including bash, are
different: They also expand braces, and this has already been taken care
of by compat/mingw.c:quote_arg().

But MSYS programs also treat single-quotes in a special way: Arguments
between single-quotes are spliced together (with spaces) into a word.
With this patch this treatment is avoided by quoting arguments that contain
single-quotes.

This lets t4252 pass on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t4252 passes a --directory argument with a single-quote to git-am. As a
 consequence, this argument was spliced into a single word with the
 remaining arguments, including the mbox file name. Following that,
 git-mailsplit was called without a mailbox, upon which it waited for input
 on stdin.

 -- Hannes

 compat/mingw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 171fa85..2839d9d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -457,7 +457,7 @@ static const char *quote_arg(const char *arg)
 	const char *p = arg;
 	if (!*p) force_quotes = 1;
 	while (*p) {
-		if (isspace(*p) || *p == '*' || *p == '?' || *p == '{')
+		if (isspace(*p) || *p == '*' || *p == '?' || *p == '{' || *p == '\'')
 			force_quotes = 1;
 		else if (*p == '"')
 			n++;
-- 
1.6.2.1.224.g2225f
