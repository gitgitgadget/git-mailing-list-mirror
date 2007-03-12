From: Avi Kivity <avi@qumranet.com>
Subject: Re: git merge and merge message
Date: Mon, 12 Mar 2007 19:26:49 +0200
Message-ID: <45F58D59.7000605@qumranet.com>
References: <200703111505.l2BF54Kq006625@localhost.localdomain> <20070311160424.GA629@fieldses.org> <200703111815.l2BIFHbq010315@localhost.localdomain> <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org> <45F46713.6030702@qumranet.com> <Pine.LNX.4.64.0703111348230.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQoIh-0001M7-Im
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXCLR0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbXCLR0w
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:26:52 -0400
Received: from il.qumranet.com ([82.166.9.18]:47014 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbXCLR0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 13:26:51 -0400
Received: from [10.0.1.228] (blast.qumranet.com [10.0.1.228])
	by il.qumranet.com (Postfix) with ESMTP id 33398A008C;
	Mon, 12 Mar 2007 19:26:50 +0200 (IST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <Pine.LNX.4.64.0703111348230.9690@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42042>

Linus Torvalds wrote:
> On Sun, 11 Mar 2007, Avi Kivity wrote:
>   
>> Actually there's at least one tree where this should be activated -- yours.
>> If you perform a fast-forward merge, there's no record of the merge, no record
>> of which tree was pulled, and no sign-off from you.  The commits just appear
>> there.  It partially defeats the sign-off system.
>>     
>
> Well, the thing is, I explicitly don't *want* the merges to show up if 
> it's a fast-forward. 
>
> Maybe it's just me, and maybe I'm odd, but I have for several years now 
> really thought of Linux development as being this collection of 
> maintainers, rather than being a "Linus at the top" kind of situation. 
>   

Maybe you are a little odd, but I don't think that it's just you.  It's 
quite clear that there are some areas where you don't generally involve 
yourself, and others where you do.

> So yes, obviously I do end up getting a lot of merges attributed to me, 
> simply because *in practice* my tree is generally the top of the food 
> chain, but I think that's a practical issue because people generally want 
> to avoid confusion by having a known maintainer, and it shouldn't be a 
> design thing.
>   

As it is, whether a merge is recorded or is practically random: if two 
perfectly rebased pull requests come in, one will just appear magically 
in the tree and the other will have a merge record.

You could make most pulls have no merge record by rebasing them, but 
that would cause confusion since commits would just appear and it would 
be impossible to trace them based on the contents of one's tree alone.

I agree it shouldn't be a design thing: I think that on the lower level 
of the "tree of trees", people should avoid merge records since they are 
just noise (and indeed most/all maintainers present perfectly groomed 
trees which have no relation to how development actually happened), but 
on the top levels, we need the traceability.  We need the record of a 
decision that was made to pull from X's tree at date Y.


> So I dislike the "hierarchical model" so much that even though it's true, 
> I don't want to make it even _more_ true. I'd rather make it less true, 
> and at least personally think of Linux development more as a "network of 
> developers where some people are just more connected than others". I'm not 
> saying that people are equal (because they aren't), but at the same time I 
> do think that it should be perfectly fine if submaintainers pull from each 
> other if they ever need to - ie pulling should work side-ways and not just 
> up the "command chain".
>   

-mm and a few other trees approximate that model.  These types of trees 
mostly use quilt, though, which allows an "editable history" mode of 
operation.

As a maintainer, I would be very wary of pulling sideways.  There's the 
risk of the final upstream being very different from what one pulls, and 
therefore one is left with a pile of conflicts to fix.  There's the risk 
of the other tree not being pulled at all, blocking one's own work.  I 
don't even want to think about a "no single upstream" mode, that would 
confuse users in addition to developers.

> So I think the hierarchical thing is largely a social thing, but not one 
> that is necessarily the only way of doing things. 
>
> And I believe that it might actually be *better* if we were to have some 
> more merging side-ways. Yes, I've been rather involved in kernel 
> development for fifteen years, and I don't really see myself stopping it 
> either, but at the same time, I think that in the really long run, it 
> would be a really interesting experiment to try to run things as a more 
> "amorphous" development group of people that just trust each other, than a 
> very hierarchical one.
>   

The hierarchical model does have advantages: you can always get a 
decision (it may be the wrong one, but it's better than no decision), 
and more important, it's clear and understandable.

> I realize that it can be useful, and I obviously use the "merge.summary" 
> config variable that does make it a non-symmetric situation anyway, and 
> maybe I'm just fighting windmills. It's just that I actually dislike the 
> central repository model so much that I dislike it even when the central 
> repository is *me*.
>
>   

Maybe you would like it more if the central repository wasn't you :) - 
it really provides a reference frame against which to work, even if it 
is moving all the time.  It reduces the risks of working on something 
that is going away.

-- 
error compiling committee.c: too many arguments to function
