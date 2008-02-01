From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 1 Feb 2008 15:17:27 +0100
Message-ID: <200802011517.28895.robin.rosenberg.lists@dewire.com>
References: <47975FE6.4050709@viscovery.net> <200802011010.41938.robin.rosenberg.lists@dewire.com> <7v63x99dt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 15:18:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKwiJ-0006Ih-3l
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 15:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbYBAORX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 09:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbYBAORX
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 09:17:23 -0500
Received: from [83.140.172.130] ([83.140.172.130]:14389 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbYBAORW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 09:17:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3CFF21475CE3;
	Fri,  1 Feb 2008 15:17:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tRJcq5qEQKo; Fri,  1 Feb 2008 15:17:19 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 17F95802662;
	Fri,  1 Feb 2008 15:17:18 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7v63x99dt9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72175>

fredagen den 1 februari 2008 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> >> > +test_expect_failure 'add a directory outside the work tree' '
> >> > +	d1="$(cd .. ; pwd)" &&
> >> > +	git add "$d1"
> >> > +	echo $?
> >> > +'
> >
> > Oops. Remove the echo $?. It still fails, i.e. git add succeeds when
> > it shouldn't. I was double checking it just before sending the patch.
> 
> Ah, you found breakages.
> 
> I could not quite tell what you meant by these tests with
> test_expect_failure, either they were misuse or "currently fails
> but they shouldn't".  Coming up with a small reproducible
> failure case is 50% of solving the problem.  That's very
> appreciated.
> 
> In any case, I think the large-ish test framework update patch I
> sent tonight should go in very early post 1.5.4 cycle, so plesae
> use the new-and-improved test_expect_failure to mark these
> reproducible failure cases.  Also, there is no need for hurry
> for you to just send test cases without fixes.  When I say I do
> not take patches early, I do mean it --- I do not even take _my_
> own patches like the one you are following up on.  I've sent
> quite a many of them, and I think some are on 'pu' or 'offcuts',
> but most are only in the list archive.  If nobody cares deeply
> enough about them to test and resend with Tested-by: , I am not
> planning to go back to pick them up.

I had those test cases on my machine from my earlier work on absolute
path names so I just ran them with your code and extracted those that
failed and put them into your testsuite instead. That's why I sent them
so early. Read them as comments on your patches, "oh you need to cover
this too". It was simply very convenient for me, and hopefull for you,
to supply them in  patch form.

The reasone my code for absolute path names wasn't re-submitted was
because I had some test cases that didn't pass. I don't really care how
the problem is solved.

> > Can we move the default trash one level down for all tests? That
> > would give us one free level to play with.
> 
> I'd rather not.  Most tests do not have to step outside and it
> is very handy to debug any breakage they find by always being
> able to go there with "cd t/trash".

The change would be to "cd t/trash/repo" instead. Not much different.

> The updated get_pathspec() issues a warning message and returns
> the result that omits paths outside of the work tree.  It does
> not die (and it is intentional, by the way).  The callers that
> expect to always receive the same number of paths in the return
> value as argv+i they pass to get_pathspec() should be updated to
> notice that they got less than they passed in, if they care
> about this error condition, and --error-unmatch codepath is one
> of them.  I did not touch that in the weatherbaloon patch.

Git add in the current version on an absolute path outside the repo
fails, so I think the updated one should. It really doesn't make sense.

ls-files outside the repo doesn't make sense either, but then the 
current version exits with 0 so I can't make the same reference to 
existing behaviour there. It just might break someone's script.

-- robin
