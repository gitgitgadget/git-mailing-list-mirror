From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What to do with patches that should go upstream?
Date: Wed, 13 Jan 2010 02:13:46 -0800
Message-ID: <7vzl4inwh1.fsf@alter.siamese.dyndns.org>
References: <5195c8761001130151q12ac636cnc69513087320195@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 11:13:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV0Eh-0004Kn-2p
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 11:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab0AMKNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 05:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755324Ab0AMKNy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 05:13:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab0AMKNx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 05:13:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFBFF90100;
	Wed, 13 Jan 2010 05:13:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UQWNVxApIL4FpC/CbZ/0vpnnU18=; b=l2gNOS
	raN+kWHHaBF9JYdLNbNsoVNx30PntIaeczvacHGeQcmG+yPAhXq7QR1BH1IiFplB
	bbU3iWhF2WEycniP4ZiLMsQlnvi1EWm6IOR5yQR7+hROseS4Lj4NjgGND23G+tu+
	m72IYRVcIR+TNeRCvV2ek8XrJTY3g60JpsXCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+IOzvemrxpd+ksl7c8XzVXEh/AEZpe0
	HJfaSKtRO3qa1JbsO1KdEkT5Qu8Wd5DcpvojPs+nLIy0wOT6qUgfq2Up3SbWN9TI
	En147bMjCkd5S7VcEE3BGC24srVafVakFgLsv/ZT/Pzq4YZw4aX8kweN2v6ALJIX
	IhU6EjYKSV8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7296900FE;
	Wed, 13 Jan 2010 05:13:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD2AC900F9; Wed, 13 Jan
 2010 05:13:47 -0500 (EST)
In-Reply-To: <5195c8761001130151q12ac636cnc69513087320195@mail.gmail.com>
 (Jeenu V.'s message of "Wed\, 13 Jan 2010 15\:21\:11 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5876ED40-002C-11DF-9874-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136806>

Jeenu V <jeenuv@gmail.com> writes:

> For example, in the following figure,
>
>      A
> -O---O-+
>         \        A'  B'
> -O---O---O---O---O---O---O W
>             /
>   -O----O--+
>
> W is the current working branch. But there are commits A' and B' which
> should go upstream. What I wanted to know is the next step from here.
>
> 1) Do I switch to A and B, and then cherry pick the commits A' and B'?
> 2) If I send the patch out to include in upstream, wouldn't it
> conflict the next time I happen to merge from A or B?

I don't see B in your picture, so I may not be answering the question you
wanted to ask, or you perhaps asked something other than the question you
wanted to ask.  Having said that, I think you are asking two more-or-less
independent questions.

Whether you interact with your upstream by sending patches, asking them to
pull, or directly pushing into them, from your problem description, it is
clear that you _only_ want to give change contained in A' and B'.  So
there is no room for "how do I" involved in it.

 (1) First check out a pristine copy of your upstream, and cherry-pick A'
     and B'

	$ git checkout upstream ;# or whatever
        $ git cherry-pick A'
        $ git cherry-pick B'

 (2-a) If you are sending patches to interact with your upstream, then
       format-patch the two [*1*]

	$ git format-patch -2

       and send them out.

 (2-b) If you are asking for them to pull, publish that to your public
       repository and ask.  Perhaps...

	$ git push $publicURL HEAD:for-upstream

	$ mail integrator@upstream.com
        Subject: please pull

	Please find my two changes at
        $publicURL for-upstream

 (2-c) If you can push, you push it to whichever branch the others are
       expecting you to push to.  Perhaps...

	$ git push $upstreamURL HEAD:$branch
 
Now, how to deal with the duplicate copies A' and B' in your private
history is your problem, and it is largely independent from the above.

If your branch W is private and you haven't published, then you would want
to drop the now-obsolete two commits that do not belong to what you wanted
to achieve in that branch by running "rebase -i", perhaps...

	$ git rebase -i A'^
	... delete lines that correspond to A' and B' and save ...

If your branch W has been published (iow, other people have seen the
commits on it), then you shouldn't be doing rebase.  When you merge
upstream to W (but why would you do that in the first place?  You
shouldn't be working directly on a branch that you merge random changes
from other people), you _will_ end up having A and A' (and B and B') as
duplicates in your history.  You'll need to live with it.

A good news is that git was designed for the Linux kernel community where
patch duplication is the norm, not exception.  Over there, it is not
uncommon for a subsystem maintainer to pick up a patch from the mailing
list that falls within his area, while the maintainer at the higher level
than the subsystem maintainer picks up the same patch (perhaps because it
trivially fixes a rather urgent issue) and then later ends up merging with
the subsystem maintainer.  When this happens, git notices that the two
sides made exactly the same change and resolves it as a non-conflicting
event when able (and it often is).


[Footnote]

*1* cherry-pick may not seem useful in this case, but it is a courtesy
to your upstream to give them a clean patch; cherry-picking and adjusting
for potential conflicts on top of the pristine upstream before running
format-patch will ensure this.
