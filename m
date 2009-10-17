From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 23:19:46 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910172257270.9794@reaper.quantumfyre.co.uk>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet> <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk> <7vvdiftb0d.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk> <7vk4yvt7kp.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910171617580.6644@reaper.quantumfyre.co.uk> <7vljj97w7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 00:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzHjI-0000zx-S3
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 00:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbZJQWYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 18:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbZJQWYn
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 18:24:43 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58984 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751465AbZJQWYn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 18:24:43 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D92B535889C
	for <git@vger.kernel.org>; Sat, 17 Oct 2009 23:24:45 +0100 (BST)
Received: (qmail 11501 invoked by uid 103); 17 Oct 2009 23:19:46 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9906. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026941 secs); 17 Oct 2009 22:19:46 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Oct 2009 23:19:46 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vljj97w7u.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130579>

On Sat, 17 Oct 2009, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>>>> My interest in this thread is solely that it might provide a mechanism
>>>> to find out which tag was checked out.
>>>
>>> Hmm, what is lacking in "git describe HEAD" for that?  I am not
>>> complaining that you might be asking for something that exists, but I _do_
>>> want to know if something that exists is not a satisfactory solution and
>>> if so how it can be improved.
>>
>> What is lacking is the "checked out" part.  "git describe HEAD" will
>> tell me _a_ tag that matches the currently checked out state.
>> However, it makes no guarantee that it was the one I checked out.  If
>> I tag the code with "v1.0.0", and a colleague later tags it with
>> "this_version_sucks", then when I check out and build the code for the
>> customer the version it reports could well be "this_version_sucks"
>> instead of "v1.0.0" ...
>
> I think I understand why you think showing what you gave to your last "git
> checkout" (e.g. "checkout origin/master" or "checkout v1.0.0") and using
> that as a build identification token is a good idea.  But "origin/master"
> is a moving target---it depends on when you checked it out.  describe uses
> tags and does not use branch heads for a good reason.

For my purposes the branch that I built from is much more useful than the 
output from describe.  Releases are always made from tags, but for builds 
used in the lab it is generally much more useful to know which branch was 
built directly rather than being able to find the exact commit that was 
built.

> "v1.0.0" also is to a lessor degree, as you may have tagged v1.0.0 locally
> and somebody else also has used the tag for a different version, but a tag
> is far less likely to move due to social convention.  "describe --long"
> would make sure this won't be an issue anyway, though.

For any particular release only one person is given the job of making the 
release tag, so we don't have the problem of multiple instances of the 
same tag - but we do need to make sure that the version output is the 
correct tag.

-- 
Julian

  ---
Water, taken in moderation cannot hurt anybody.
 		-- Mark Twain
