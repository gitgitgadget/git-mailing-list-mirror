From: Thell Fowler <git@tbfowler.name>
Subject: Re: Help/Advice needed on diff bug in xutils.c
Date: Mon, 10 Aug 2009 13:54:44 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908101211590.32213@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <alpine.DEB.1.00.0908052239180.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 20:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maa1I-0007Zr-M6
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 20:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbZHJSys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 14:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbZHJSys
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 14:54:48 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:43294 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZHJSyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 14:54:47 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Maa19-0004EJ-GY; Mon, 10 Aug 2009 13:54:47 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <alpine.DEB.1.00.0908052239180.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125497>

Johannes Schindelin (Johannes.Schindelin@gmx.de) wrote on Aug 5, 2009:

> On Tue, 4 Aug 2009, Thell Fowler wrote:
>
>> There is a bug in git diff (ignoring whitespace) that does not take into
>> account a trailing space at the end of a line at the end of a file when
>> no new line follows.

First, please forgive my hubris at thinking I had _found_ a bug when my 
ignorance of the issue was so obvious.  I am definitely humbled after 
reading every post in the archive having to do with whitespace and diff.

>>
>> Here is the example of the bug:
>> mkdir test_ws_eof
>> cd test_ws_eof
>> git init
>> echo -n "Test" > test.txt
>> git add .
>> git commit -m'test'
>> git symbolic-ref HEAD refs/heads/with_space
>> rm .git/index
>> git clean -f
>> echo -n "Test ">test.txt
>> git add .
>> git commit -m'test'
>> # Ignoring all whitespace there shouldn't be a diff.
>> git diff -w master -- test.txt
>> # Ignoring space at eol there shouldn't be a diff
>> git diff --ignore-space-at-eol master -- test.txt
>> # Ignoring with -b might have a case for a diff showing.
>> git diff -b master -- test.txt
>
> If you turn that into a patch to, say, t/t4015-diff-whitespace.sh (adding
> a test_expect_failure for a known bug), it is much easier to convince
> developers to work on the issue.
>

Thank you.  In progress.

I am curious if t4015 is planned to be to be rewritten to follow what 
Junio had outlined and Giuseppe implemented for 
t4107-apply-ignore-whitespace.sh to make the spaces more obvious to the reader:

One other question on the making of the test in regards to the 
following quote from:
http://article.gmane.org/gmane.comp.version-control.git/124765
where Junio C Hamano wrote:

>>>>	sed -e 's/Z/ /g' >patch3.patch <<\EOF
>>>>        ...
>>>>        +Z 	print_int(func(i));Z
>>>>        EOF
>>>>
>>>> to make invisible SP stand out more for the benefit of people reading 
>>>> the test script (I know you did not have leading SP before HT in 
>>>> yours, but the above illustrates the visibility issues).  For other 
>>>> tests with test vector patches, visibility of whitespace is not much 
>>>> an issue, but this script is _all about_ whitespace, so anything that 
>>>> clarifies what is going on better would help.

The test being implemented was t4107-apply-ignore-whitespace.sh.

Are there any plans to have t4015-diff-whitespace.sh tests rewritten in 
the same fashion?

> First, your coding style is different from the surrounding code.  I think
> it goes without saying that this should be fixed.
>
> Second, you do not need the parentheses at all (and therefore they should
> go).
>
> Third, libxdiff does not assume to be fed NUL delimited strings.
>

You're absolutely right, I'll be more aware in the future.

> Fourth, that condition "ptr + 1 < top" is already doing what you tried to
> accomplish here.
>
> So I guess that you need to do add "ptr + 1 < top" checks
> instead.
>

I'll give it another go.

Thank you for the advice Dscho.

-- 
Thell
