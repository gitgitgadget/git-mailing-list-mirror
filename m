From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Wed, 10 Sep 2008 09:16:47 +0200
Message-ID: <48C7745F.1070008@statsbiblioteket.dk>
References: <1220889063-20387-1-git-send-email-marcus@griep.us> <1220892781-24343-1-git-send-email-marcus@griep.us> <48C628AA.4020100@statsbiblioteket.dk> <48C6B886.7020108@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Wed Sep 10 09:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdJxd-0002Fv-O1
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 09:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbYIJHQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 03:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbYIJHQv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 03:16:51 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:37706 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751233AbYIJHQu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 03:16:50 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Wed, 10 Sep 2008 09:16:47 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <48C6B886.7020108@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95491>

Marcus Griep wrote:
> Tom G. Christensen wrote:
>> The testsuite now passes t9100-git-svn-basic.sh and instead fails at
>> t9108-git-svn-glob.sh but this appears to be unrelated to the File::Temp
>> issue.
>>
>> --- expect.three        2008-09-09 07:34:39.000000000 +0000
>> +++ stderr.three        2008-09-09 07:34:42.000000000 +0000
>> @@ -1,2 +1,3 @@
>> +Parentheses missing around "my" list at
>> /home/tgc/projects/git/t/../git-svn line 4429.
>>  Only one set of wildcard directories (e.g. '*' or '*/*/*') is
>> supported: 'branches/*/t/*'
>>
>> * FAIL 3: test disallow multi-globs
> 
> It's probably another back-portability issue (It's not failing in my testsuite).
> However, I think that I know the offending line.  Can you give me the text of
> your line 4429 in git-svn and I'll submit a separate patch to fix that back
> portability issue.
> 
git-svn:4429:
         pipe my $rfd, my $wfd or return;

I know next to nothing about perl but I put () around my, my and then 
the test passes.

However it now fails in t9700/test.pl:
t9700 $ ./test.pl -i -v
ok 1 - use Git;
Bareword "STDERR" not allowed while "strict subs" in use at ./test.pl 
line 38.
Execution of ./test.pl aborted due to compilation errors.
1..1
# Looks like your test died just after 1.

Brandon Casey already posted a patch for this that also fixes the use of 
File::Temp->New in t9700/test.pl:
http://article.gmane.org/gmane.comp.version-control.git/92791
Applying it allowed a full a run of the testsuite to complete without error.

'/bin/sh' ./aggregate-results.sh test-results/t*-*
fixed   1
success 3709
failed  0
broken  2
total   3712

-tgc
