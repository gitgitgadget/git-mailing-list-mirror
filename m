From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] compat/mingw.[ch]: Change return type of exec functions
 to int
Date: Thu, 5 Apr 2012 13:16:01 -0500
Message-ID: <20120405181600.GA6340@burratino>
References: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 05 20:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFrEM-0004ms-Ib
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 20:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab2DESQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 14:16:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49756 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab2DESQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 14:16:11 -0400
Received: by iagz16 with SMTP id z16so2079243iag.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bDDniGFsA1wv+H8vzNVaUwb34p1lDybTL5tYxEGya10=;
        b=JR0oseIPXiAnf7Hu3jFF1Xn7437nS5kmOlKoVmu3XxXoTIQAR4m45G3V1gZd5ptSGl
         cqq18Ivb4o17LoN7PjIGrs+ly3+QwW5qN04+3V2t5STM5nu69Xflsji9QM/PRF+gSeJt
         XhqoeRz+OmDtOXmTnRl277ptiQnV3dHv6Il2I4NSu5XZNT7Rmyr681V5Jr0QMbcgujNz
         AfLSxuLer2qsOb8Kz5mm/Al3aeCJHR/sB9H0Oc5u3OyWYsJ0n5i6eWLGVi94a9tS0YNa
         yctLzeO9Oq63RW8w++g9sTjoFFyKNyIwVWzhQhdrDbbDdErRfTS9YkDSyHSYKtj0po7M
         6WRQ==
Received: by 10.43.126.68 with SMTP id gv4mr2437708icc.30.1333649771030;
        Thu, 05 Apr 2012 11:16:11 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dl10sm8156225igb.5.2012.04.05.11.16.09
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 11:16:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194792>

Ramsay Jones wrote:

>         CC run-command.o
>     run-command.c: In function 'sane_execvp':
>     run-command.c:124: error: invalid use of void expression
>     make: *** [run-command.o] Error 1
>
> My first reaction was to simply remove the conditional since, if execvp()
> returns at all, the result will always be -1 and so the condition will
> always be false. ie. the conditional is pointless.
>
> However, I found the incorrect return type of the mingw_execv[p]() to be
> a gratuitous incompatibility, so ... :-P

My bad.  I agree that in addition to making the return type fix,
squashing the following into jk/run-command-eacces would be a good
idea.

diff --git i/run-command.c w/run-command.c
index 04f0190d..fcd7e192 100644
--- i/run-command.c
+++ w/run-command.c
@@ -59,8 +59,7 @@ static int exists_in_PATH(const char *file)
 
 int sane_execvp(const char *file, char * const argv[])
 {
-	if (!execvp(file, argv))
-		return 0;
+	execvp(file, argv);
 
 	/*
 	 * When a command can't be found because one of the directories
