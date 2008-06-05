From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 05 Jun 2008 16:13:51 +0200
Message-ID: <4847F49F.8090004@viscovery.net>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 16:15:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4GEp-0005R6-Mz
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 16:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbYFEONz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 10:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbYFEONz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 10:13:55 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16133 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbYFEONy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 10:13:54 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K4GDw-0004rg-2j; Thu, 05 Jun 2008 16:13:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D50216B7; Thu,  5 Jun 2008 16:13:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0806051441560.21190@racer>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83936>

Johannes Schindelin schrieb:
> Hi,
> 
> On Thu, 5 Jun 2008, Johannes Sixt wrote:
> 
>> Johannes Schindelin schrieb:
>>
>>> On Thu, 5 Jun 2008, Johannes Sixt wrote:
>>>
>>>> Johannes Schindelin schrieb:
>>>>> +--fixup-line-counts::
>>>>> +	Fix up the line counts (e.g. after editing the patch without
>>>>> +	adjusting the hunk headers appropriately).
>>>>>
>>>> This sort of implies that there is some kind of output that tells the 
>>>> correct line counts. But that isn't the case (if I read the patch 
>>>> correctly). So I suggest to name the option --ignore-line-counts.
>>> But there is some kind of output: the hunks themselves.
>> Is there?
> 
> Yes!
> 
>> I did this (it rewrites all line counts to 1):
>>
>> $ git diff ..HEAD~1 |
>> 	sed -e '/^@@/s/,[0-9]+ /,1 /g' |
>> 	./git-apply --fixup-line-counts
>>
>> and there was no output. Instead, the patch was applied.
> 
> As I said, the data is in the _hunks_, but I maybe should have added _not 
> in the hunk headers_.

Yes, of course.

> So in a very real sense, you edit the hunks, and the hunk headers are 
> adjusted to that.  You did not adjust the hunks, so they got applied.

Yes, of course.

But the example pretends that the hunks have been edited so heavily that
they in no way match the line counts in the hunk headers.

> It seems that you think the hunk header's line counts are heeded, and the 
> hunk adjusted, with --fixup-line-counts?

NO, of course *NOT*.

>  Sorry, I find that rather 
> counterintuitive.

So would I.

>>>  And the line counts are not ignored, but they are actively rewritten.
>> Of course, internally there is some sort of "output" from the fixup 
>> routine, and the line counts are rewritten and then are not ignored. But 
>> the user doesn't care about this internal procedure. From the user's 
>> perspective, the line counts of the input patch are ignored.
> 
> But they are not!

> There are _two_ things that are the line counts.  Those numbers in the 
> hunk header, and the real line counts of the hunks.

And I was always talking about the numbers in the hunk headers.

> Now, if you say they are _ignored_, would that not imply in plain English 
> that they are left unchanged (in limbo, because those two types of numbers 
> contradict each other)?

That you *internally* rewrite those numbers and then do *not* ignore them
is totally pointless for the user. It's an implementation detail. The user
doesn't see what is going on nor should he care. From the user's
perspective, the hunk header line counts are _ignored_ (because if they
were not ignored, then there would be an error message in the
contradicting case).

> Okay, how about shikebedding this to --adjust-line-counts?

>From the user's perspective, nothing is "adjusted"; the hunk header line
counts are ... you guess it ... *ignored*.

-- Hannes
