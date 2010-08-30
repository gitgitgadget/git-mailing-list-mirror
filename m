From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: Detection of relocations within a file
Date: Tue, 31 Aug 2010 03:13:16 +1000
Message-ID: <SNT124-W40BFB8E681711F9CD33D9AC4890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>, <jnareb@gmail.com>,
	<struggleyb.nku@gmail.com>
To: <matthieu.moy@grenoble-inp.fr>, <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 19:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq7v9-0004PL-Am
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 19:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab0H3RNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 13:13:18 -0400
Received: from snt0-omc4-s17.snt0.hotmail.com ([65.55.90.220]:18832 "EHLO
	snt0-omc4-s17.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756011Ab0H3RNR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 13:13:17 -0400
Received: from SNT124-W40 ([65.55.90.199]) by snt0-omc4-s17.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 30 Aug 2010 10:13:17 -0700
X-Originating-IP: [60.241.190.75]
Importance: Normal
X-OriginalArrivalTime: 30 Aug 2010 17:13:17.0453 (UTC) FILETIME=[A35853D0:01CB4866]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154833>


Hi guys,

>> I was just wondering if git can/does detect relocations of sections of code/text within a file.
>>
>> For example, moving a function from the top of a file to the end.
>
> Depends what you are trying to do.
>...
> 4. I want a simple, easy-to-review patch representing a code movement.
> No one I know of has worked on this, and if you have ideas for it,
> that would be very neat.
>
> 5. I have a history with a lot of code movement, someone branched from
> me a while ago, modified various pieces of code which moved in the
> meantime, and we want to merge.
>
> Unfortunately, I don't think any VCS does a really good job here
> either.

Yeah, go figure, the ones I'm after are the one that don't exist. :P

As for ideas, all I can really think of is that git detects that the '-' lines and the '+' lines are actually the same thing, and so instead of actually showing the changes as deletions and insertions, actually shows the change in the context surrounding the lines.

This should also be able to be mixed in with insertion and deletion lines.
For example, if you move a chunk of code, and then stick a comment (or code) line in the middle, or, conversely delete one, it should still see it as a movement patch, with an insertion or deletion.

I *think* that this *might* also work to "solve" or at least help with point 5, made by Matthieu (sorry if I misspelt your name).

However, as I haven't delved into the insides of git, I don't know how this would be represented internally, how it would differ from a normal patch, or exactly how horribly painful it would be to implement.


> 2. I am mystified not by some particular piece of code but by an
> entire file.  The command
> $ git gui blame -- git.c
> works okay.

It does, to an extent.

The specific case I was thinking of is when, as a function grows larger, you decide to break it down and move a section of it to a new function.
Now, if the two lines remain exactly the same, there is no problem and git gui blame does the job.
However, if there is any change in the line at all, even leading whitespace, as moving code around usually changes its "tabbage", then git gui blame will not detect that as being the same line of code sitting somewhere else, as it sees the two as "different".
Is there any way to get around this?

Further, in the previous point regarding a movement patch, it too should not be overly sensitive to leading whitespace.

Actually, git in general shouldn't be too sensitive to leading whitespace (or at least should have an option to turn this on/off).


Well, yeah, that's my ramblings, what do you guys think?
 		 	   		  