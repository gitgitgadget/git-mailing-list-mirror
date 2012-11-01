From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Thu, 01 Nov 2012 18:40:52 +0000
Message-ID: <5092C234.9000307@ramsay1.demon.co.uk>
References: <20121029102114.GA14497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 20:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU0Kb-0003I6-6F
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 20:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab2KATVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 15:21:19 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:42788 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751933Ab2KATVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 15:21:18 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id F07036F82FF;
	Thu,  1 Nov 2012 19:21:15 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 4C5FF6F8148;	Thu,  1 Nov 2012 19:21:14 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;	Thu,  1 Nov 2012 19:21:13 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121029102114.GA14497@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208884>

Jeff King wrote:
> What's cooking in git.git (Oct 2012, #09; Mon, 29)
> --------------------------------------------------
> 

[snip]

> * cr/cvsimport-local-zone (2012-10-16) 1 commit
>  - git-cvsimport: allow author-specific timezones
> 
>  Allows "cvsimport" to read per-author timezone from the author info
>  file.
> 
>  Will merge to 'next'.

Just FYI, t9604-cvsimport-timestamps.sh is still failing for me.

I haven't spent too long on this yet, but I had hoped that setting
TZ would sidestep any DST issues. (I have downloaded new tzdata, but
have yet to install - actually I don't really want to!). It is not
clear from the tzset manpage what happens if you use the DST format
for TZ, but you don't provide the start/end date for DST, which is
what this test is doing.

Perhaps the test should use the non-DST format? e.g. "TZ=CST6 git ..."
Does the test really care about DST? (*if* that is indeed the problem).

Also: Note that the first test calls git-cvsimport twice, first *with*
TZ set then again without; I suspect a cut/paste editing error.

I have added the output of "./t9604-cvsimport-timestamps.sh -v" below.

ATB,
Ramsay Jones



ramsay@ramsay-laptop:$ ./t9604-cvsimport-timestamps.sh -v
Initialized empty Git repository in /home/ramsay/git/t/trash directory.t9604-cvsimport-timestamps/.git/
expecting success: 

        TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
        git cvsimport -p"-x" -C module-1 module &&
        (
                cd module-1 &&
                git log --format="%s %ai"
        ) >actual-1 &&
        cat >expect-1 <<-EOF &&
        Rev 16 2006-10-29 07:00:01 +0000
        Rev 15 2006-10-29 06:59:59 +0000
        Rev 14 2006-04-02 08:00:01 +0000
        Rev 13 2006-04-02 07:59:59 +0000
        Rev 12 2005-12-01 00:00:00 +0000
        Rev 11 2005-11-01 00:00:00 +0000
        Rev 10 2005-10-01 00:00:00 +0000
        Rev  9 2005-09-01 00:00:00 +0000
        Rev  8 2005-08-01 00:00:00 +0000
        Rev  7 2005-07-01 00:00:00 +0000
        Rev  6 2005-06-01 00:00:00 +0000
        Rev  5 2005-05-01 00:00:00 +0000
        Rev  4 2005-04-01 00:00:00 +0000
        Rev  3 2005-03-01 00:00:00 +0000
        Rev  2 2005-02-01 00:00:00 +0000
        Rev  1 2005-01-01 00:00:00 +0000
        EOF
        test_cmp actual-1 expect-1

Initialized empty Git repository in /home/ramsay/git/t/trash directory.t9604-cvsimport-timestamps/module-1/.git/
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
Already up-to-date.
--- actual-1    2012-10-31 21:20:20.000000000 +0000
+++ expect-1    2012-10-31 21:20:20.000000000 +0000
@@ -13,4 +13,4 @@
 Rev  4 2005-04-01 00:00:00 +0000
 Rev  3 2005-03-01 00:00:00 +0000
 Rev  2 2005-02-01 00:00:00 +0000
-Rev  1 2004-12-31 18:00:00 +0000
+Rev  1 2005-01-01 00:00:00 +0000
not ok 1 - check timestamps are UTC (TZ=CST6CDT)
#
#
#               TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
#               git cvsimport -p"-x" -C module-1 module &&
#               (
#                       cd module-1 &&
#                       git log --format="%s %ai"
#               ) >actual-1 &&
#               cat >expect-1 <<-EOF &&
#               Rev 16 2006-10-29 07:00:01 +0000
#               Rev 15 2006-10-29 06:59:59 +0000
#               Rev 14 2006-04-02 08:00:01 +0000
#               Rev 13 2006-04-02 07:59:59 +0000
#               Rev 12 2005-12-01 00:00:00 +0000
#               Rev 11 2005-11-01 00:00:00 +0000
#               Rev 10 2005-10-01 00:00:00 +0000
#               Rev  9 2005-09-01 00:00:00 +0000
#               Rev  8 2005-08-01 00:00:00 +0000
#               Rev  7 2005-07-01 00:00:00 +0000
#               Rev  6 2005-06-01 00:00:00 +0000
#               Rev  5 2005-05-01 00:00:00 +0000
#               Rev  4 2005-04-01 00:00:00 +0000
#               Rev  3 2005-03-01 00:00:00 +0000
#               Rev  2 2005-02-01 00:00:00 +0000
#               Rev  1 2005-01-01 00:00:00 +0000
#               EOF
#               test_cmp actual-1 expect-1
#

expecting success: 

        cat >cvs-authors <<-EOF &&
        user1=User One <user1@domain.org>
        user2=User Two <user2@domain.org> CST6CDT
        user3=User Three <user3@domain.org> EST5EDT
        user4=User Four <user4@domain.org> MST7MDT
        EOF
        git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
        (
                cd module-2 &&
                git log --format="%s %ai %an"
        ) >actual-2 &&
        cat >expect-2 <<-EOF &&
        Rev 16 2006-10-29 01:00:01 -0600 User Two
        Rev 15 2006-10-29 01:59:59 -0500 User Two
        Rev 14 2006-04-02 03:00:01 -0500 User Two
        Rev 13 2006-04-02 01:59:59 -0600 User Two
        Rev 12 2005-11-30 17:00:00 -0700 User Four
        Rev 11 2005-10-31 19:00:00 -0500 User Three
        Rev 10 2005-09-30 19:00:00 -0500 User Two
        Rev  9 2005-09-01 00:00:00 +0000 User One
        Rev  8 2005-07-31 18:00:00 -0600 User Four
        Rev  7 2005-06-30 20:00:00 -0400 User Three
        Rev  6 2005-05-31 19:00:00 -0500 User Two
        Rev  5 2005-05-01 00:00:00 +0000 User One
        Rev  4 2005-03-31 17:00:00 -0700 User Four
        Rev  3 2005-02-28 19:00:00 -0500 User Three
        Rev  2 2005-01-31 18:00:00 -0600 User Two
        Rev  1 2005-01-01 00:00:00 +0000 User One
        EOF
        test_cmp actual-2 expect-2

Initialized empty Git repository in /home/ramsay/git/t/trash directory.t9604-cvsimport-timestamps/module-2/.git/
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
* UNKNOWN LINE * Branches: 
--- actual-2    2012-10-31 21:20:21.000000000 +0000
+++ expect-2    2012-10-31 21:20:21.000000000 +0000
@@ -1,16 +1,16 @@
 Rev 16 2006-10-29 01:00:01 -0600 User Two
 Rev 15 2006-10-29 01:59:59 -0500 User Two
 Rev 14 2006-04-02 03:00:01 -0500 User Two
-Rev 13 2006-04-02 00:59:59 -0600 User Two
-Rev 12 2005-11-30 19:00:00 -0700 User Four
-Rev 11 2005-10-31 18:00:00 -0500 User Three
-Rev 10 2005-10-01 01:00:00 -0500 User Two
-Rev  9 2005-08-31 18:00:00 +0000 User One
-Rev  8 2005-07-31 20:00:00 -0600 User Four
-Rev  7 2005-06-30 19:00:00 -0400 User Three
-Rev  6 2005-06-01 01:00:00 -0500 User Two
-Rev  5 2005-04-30 18:00:00 +0000 User One
-Rev  4 2005-03-31 19:00:00 -0700 User Four
-Rev  3 2005-02-28 18:00:00 -0500 User Three
-Rev  2 2005-02-01 00:00:00 -0600 User Two
+Rev 13 2006-04-02 01:59:59 -0600 User Two
+Rev 12 2005-11-30 17:00:00 -0700 User Four
+Rev 11 2005-10-31 19:00:00 -0500 User Three
+Rev 10 2005-09-30 19:00:00 -0500 User Two
+Rev  9 2005-09-01 00:00:00 +0000 User One
+Rev  8 2005-07-31 18:00:00 -0600 User Four
+Rev  7 2005-06-30 20:00:00 -0400 User Three
+Rev  6 2005-05-31 19:00:00 -0500 User Two
+Rev  5 2005-05-01 00:00:00 +0000 User One
+Rev  4 2005-03-31 17:00:00 -0700 User Four
+Rev  3 2005-02-28 19:00:00 -0500 User Three
+Rev  2 2005-01-31 18:00:00 -0600 User Two
 Rev  1 2005-01-01 00:00:00 +0000 User One
not ok 2 - check timestamps with author-specific timezones
#
#
#               cat >cvs-authors <<-EOF &&
#               user1=User One <user1@domain.org>
#               user2=User Two <user2@domain.org> CST6CDT
#               user3=User Three <user3@domain.org> EST5EDT
#               user4=User Four <user4@domain.org> MST7MDT
#               EOF
#               git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
#               (
#                       cd module-2 &&
#                       git log --format="%s %ai %an"
#               ) >actual-2 &&
#               cat >expect-2 <<-EOF &&
#               Rev 16 2006-10-29 01:00:01 -0600 User Two
#               Rev 15 2006-10-29 01:59:59 -0500 User Two
#               Rev 14 2006-04-02 03:00:01 -0500 User Two
#               Rev 13 2006-04-02 01:59:59 -0600 User Two
#               Rev 12 2005-11-30 17:00:00 -0700 User Four
#               Rev 11 2005-10-31 19:00:00 -0500 User Three
#               Rev 10 2005-09-30 19:00:00 -0500 User Two
#               Rev  9 2005-09-01 00:00:00 +0000 User One
#               Rev  8 2005-07-31 18:00:00 -0600 User Four
#               Rev  7 2005-06-30 20:00:00 -0400 User Three
#               Rev  6 2005-05-31 19:00:00 -0500 User Two
#               Rev  5 2005-05-01 00:00:00 +0000 User One
#               Rev  4 2005-03-31 17:00:00 -0700 User Four
#               Rev  3 2005-02-28 19:00:00 -0500 User Three
#               Rev  2 2005-01-31 18:00:00 -0600 User Two
#               Rev  1 2005-01-01 00:00:00 +0000 User One
#               EOF
#               test_cmp actual-2 expect-2
#

# failed 2 among 2 test(s)
1..2
ramsay@ramsay-laptop:$
