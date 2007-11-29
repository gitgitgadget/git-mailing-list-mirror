From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: problem with git detecting proper renames
Date: Thu, 29 Nov 2007 13:06:58 -0600
Message-ID: <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:07:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixoja-0003ES-9m
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 20:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbXK2THF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 14:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758786AbXK2THF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 14:07:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:34525 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758256AbXK2THD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 14:07:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lATJ6GMm000353;
	Thu, 29 Nov 2007 13:06:59 -0600
In-Reply-To: <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66553>


On Nov 29, 2007, at 11:44 AM, Linus Torvalds wrote:

> On Thu, 29 Nov 2007, Kumar Gala wrote:
>>
>> I did some git-mv and got the following:
>>
>> the problem is git seems confused about what file was associated  
>> with its
>> source.
>
> Well, I wouldn't say "confused". It found multiple identical options  
> for
> the source, and picked the first one (where "first one" may not be  
> obvious
> to a human, it can depend on an internal hash order).
>
> But if you have the resultant git tree somewhere public (or just  
> send me
> the exact "git mv" and revision to recreate), I'll happily give it a  
> look,
> to see if we can improve our heuristics to be closer to what a human  
> would
> expect.
>
> For example, in this case, it looks  like there were two totally  
> identical
> "init.S" files that got renamed with the same identical content to  
> two new
> names. YOU seem to expect that it would stay as two renames, but  
> from a
> content angle, since the two sources were identical, it's a totally
> arbitrary choice whether it's a "copy one source to two destinations  
> and
> delete the other source" or whether it's two cases of "move one  
> source to
> another destination" (and the latter case also has the issue of  
> which way
> to move it).
>
> (You also had two identical Makefile's with the exact same issue).
>
> So git doesn't care about how you did the rename, it only cares  
> about the
> end result, and the exact same way that it will detect a rename if you
> implement it as a "copy file" and then a later "delete old file", it  
> will
> also potentially go the other way, or just decide that identical  
> contents
> moved in different ways.

I was guessing most of this but wanted to make sure there wasn't some  
cool feature of git I wasn't aware of.

> But we can certainly tweak the heuristics. For example, if we find
> multiple identical renames, right now we just pick one fairly at  
> random,
> and have no logic to prefer independent renames over "multiple  
> copies and
> a delete". But this code is actually fairly simple, and with a good
> example I can easily add heurstics (for example, it probably *is*  
> better
> to consider it to be two renames, just because the resulting diff  
> will be
> smaller - since a "delete" diff is much larger than a rename diff).

In the case of multiple identical matches can we look at the file name  
as a possible heuristic?

- k
