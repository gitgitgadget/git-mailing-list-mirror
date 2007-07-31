From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge time
Date: Tue, 31 Jul 2007 20:06:24 +0200
Message-ID: <9DCA19D8-EDAE-4D04-A8C1-E0FF0A71DC93@zib.de>
References: <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net> <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de> <20070730074937.GT20052@spearce.org> <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de> <20070730081439.GA907@coredump.intra.peff.net> <E1575DD6-AC8C-49FD-A765-801A19E1FA73@zib.de> <20070730083223.GB3150@coredump.intra.peff.net> <Pine.LNX.4.64.0707300133210.6478@asgard.lang.hm> <20070730084138.GA4100@coredump.intra.peff.net> <alpine.LFD.0.999.0707301038380.4161@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, david@lang.hm,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFwCb-0001Ib-Q9
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 20:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbXGaSMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761750AbXGaSMI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 14:12:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:50939 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbXGaSMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 14:12:07 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6VI5Wqj017511;
	Tue, 31 Jul 2007 20:05:33 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6VI5US1009552
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 31 Jul 2007 20:05:30 +0200 (MEST)
In-Reply-To: <alpine.LFD.0.999.0707301038380.4161@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54366>


On Jul 30, 2007, at 7:42 PM, Linus Torvalds wrote:

> On Mon, 30 Jul 2007, Jeff King wrote:
>>
>> If you followed a strict policy of always merging topics to a "base"
>> branch as your first parent, then never allowing fast forwards should
>> allow a very easy-to-read history in gitk.
>
> Only if only *one* person ever does any merges.
>
> Immediately when you have other people merging code, you're now  
> back in
> the same boat.
>
> This is why I personally think the whole policy of "no fast  
> forward" is
> totally broken. It's only usable in a non-distributed environment,  
> where
> there is one central person who does everything (a so-called "star
> topology").

I think no fast forward merges can always provide useful information.

Public releases are often created from a public, linear branch that
is not arbitrarily jumping around. Even if more than one person creates
such releases there must be some agreement upon the responsibility for
the release and thus for the branch the releases are created from.

If all agreed to merge topics following the "no fast forward" policy and
to use the release branch as a first parent, the commits along the first
parents would document how commits came into the release branch. Non  
fast
forward merges would always document that a series of commits was added
to the release branch at once at the (local time) of the merge commit.

If fast forwards are allowed it depends on whether the release branch  
can
be fast-forwarded over a series of commits on a topic branch or not.
In case of fast-forward, the history makes you believe each of the  
commits
of the topic branch entered the release branch separately. It hides that
they were all merged at once.

I think, avoiding fast forwards may also be used to document a different
level of quality required from commits to a topic branch and from  
commits
to the release branch. A the time of the merge the tip of a topic branch
must fulfill all quality requirements, for example compile on all  
platforms
and pass all tests. But this need not be the case for every single  
commit
on the topic branch. If you avoid fast forwards you still get a chain of
commits along the first parent that would fulfill your quality  
requirements.
If you allowed a fast forward over a low quality topic branch your chain
might be broken and you can't be sure, which commits will have high  
quality
and which one have a lower quality.

You may argue that this is all crap because every single commit  
should be
of highest quality, but I think this is unrealistic. Especially if  
more than
one person is jointly working on a topic branch and less experienced and
more experienced developers work together. It may also be rational to  
first
get the basic functionality right and later polish work for several  
platforms
and usage scenarios.

Obviously other techniques, like rewriting a topic branch to a  
perfect commit
series may be used as well. But from my understanding this may be  
hard if more
than a single person is involved. You could also squash the complete  
topic
branch into a single commit but then valuable history might get lost.

I don't see why what I have in mind would break if other people are  
merging
code, too. They may or may not follow my local rules. But at the time of
merging their changes, I can enforce my local quality policy and  
document
this by create a merge commit.

This could even be applied recursively. You could start to do a  
couple of
merges but only thoroughly test the final result of the last merge.  
You could
then enforce a link between the last very stable commit before you  
did all the
merges and the very well tested result after the final merge by  
enforcing a
"no fast forward" merge.

I'm not quite sure if such a history would be useful in the long term or
may just become to complex. I'm also not sure if the artificial links  
would
cause any trouble. I'm wondering, for example, if there are any cases  
in which
the additional links would make branching and merging harder.

	Steffen
