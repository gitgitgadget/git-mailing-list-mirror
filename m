From: chris <jugg@hotmail.com>
Subject: Re: [PATCH 2/3] remote: separate the concept of push and fetch mirrors
Date: Thu, 31 Mar 2011 12:59:51 +0000 (UTC)
Message-ID: <loom.20110331T140539-266@post.gmane.org>
References: <20110330195139.GA814@sigill.intra.peff.net> <20110330195318.GB30624@sigill.intra.peff.net> <7vhbakmj5k.fsf@alter.siamese.dyndns.org> <20110330205734.GA2940@sigill.intra.peff.net> <7v62r0meok.fsf@alter.siamese.dyndns.org> <loom.20110331T040801-714@post.gmane.org> <loom.20110331T044824-341@post.gmane.org> <7vfwq4kkbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 15:00:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5HTy-00085V-QG
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 15:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab1CaNAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 09:00:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:48899 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627Ab1CaNAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 09:00:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q5HTn-000837-GF
	for git@vger.kernel.org; Thu, 31 Mar 2011 15:00:04 +0200
Received: from 118-170-8-41.dynamic.hinet.net ([118.170.8.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 15:00:03 +0200
Received: from jugg by 118-170-8-41.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 15:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 118.170.8.41 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/7.0.541.0 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170486>

Junio C Hamano <gitster <at> pobox.com> writes:
> 
> chris <jugg <at> hotmail.com> writes:
> 
> >> I use the mirror for synchronizing "local" work between my workstations 
> >> (home/office). So, I use the fact that I can fetch from and push to the 
mirror.
> 
> It is not quite clear what you meant by "mirror" above, but I am assuming
> that you meant that you have a third repository that you use for the sole
> purpose of synchronizing your work done in two repositories, one at home
> and the other at office.

Yes, I was referencing my original post from the top level thread that triggered 
these patches.

> The synchronizing point should be a normal remote in such a case.

I find that much more cumbersome.  It is much simpler for me to generate various 
patch branches and before calling it a day/night put all of my pending changes 
into a wip branch that isn't already on another branch and push to my mirror 
remote - all refs are pushed. No need to concern myself with ensuring I don't 
forget a newly created local ref.

> If you
> mirror-push into the mirror from home, you may lose what you have pushed
> from office that you forgot to pull back to home before starting to work
> at home via the mirror.

It is much more likely for me to forget to push a local ref than to forget to 
synchronize - the point of this activity is to continue my work in a different 
location, something I couldn't do if I don't synchronize.  As for content in the 
mirror itself being lost - that is irrelevant, it is just a buffer.  The home 
and/or work repositories have whatever is in the mirror - fetching from the 
mirror is where fail safes, if any, are needed.

> If you mirror-fetch from the mirror from office,
> you may lose what you worked locally on office and forgot to push out
> before mirror-fetching for one thing, and for another, you will be
> overwriting the tip of your current branch.

yes, which is the point of my second suggestion to change the fetch refs for a 
mirror remote if the local repository is not bare.  But generally, when 
intentionally fetching from a mirror I want it to overwrite whatever I have 
locally, probably because I *had* forgotten to push from home the night before, 
and subsequently re-implemented the work at the office, so when I get home the 
following night, I just blow away whatever I have locally with my work from the 
office.  But that action certainly should be explicitly requested and not the 
default.

> Using a pure mirror in such a three-repository situation _can_ be made to
> work, but only if you are very careful:

*careful* depends on work flow.  And a pure mirror approach works quite well for 
me in this situation, with less effort than manually managing what refs to push.

> Hopefully we are already forbidding mirror fetching into a non-bare
> repository, so the system is foolproofed in that direction at least to
> avoid such mistakes.

If you mean what I think you mean, then you are not.

>  I offhand do not remember if we protect the branch
> that is currently checked out from mirror pushing, though.

I don't know - I've only mirror pushed to a bare repository.

> A safer and more customary way to set up the synchronization between two
> repositories is to arrange them to pull from each other (and if you can
> initiate connections only in one direction, emulate one side of "git
> fetch" with "git push").

"customary" or "ideal"?  I certainly won't argue the convenience of such a setup 
if the logistics allowed for it.

Of course the most ideal way to solve this problem would be to have a laptop. In 
the mean time I have a really useful tool called Git that generally has just 
enough rounded edges to avoid stabbing myself, but does not dumb things down to 
the point of being controlling.  :)

chris
