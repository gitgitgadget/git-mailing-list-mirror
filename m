From: david@lang.hm
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 21:26:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1107202119440.5355@asgard.lang.hm>
References: <20110720221632.14223.qmail@science.horizon.com> <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm> <alpine.LFD.2.00.1107201931510.21187@xanadu.home> <4E276DF8.8030301@cisco.com> <alpine.DEB.2.02.1107201714140.6412@asgard.lang.hm>
 <CAJo=hJuS_iYSS8iVWoJ1BiUANsGtYJoYm-WRa863isVNsq=5vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Phil Hord <hordp@cisco.com>, Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>, anthonyvdgent@gmail.com,
	git@vger.kernel.org, torvalds@linux-foundation.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 21 06:27:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjkqh-0007o3-WA
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 06:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab1GUE0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 00:26:54 -0400
Received: from mail.lang.hm ([64.81.33.126]:51792 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab1GUE0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 00:26:54 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p6L4Qhu3007526;
	Wed, 20 Jul 2011 21:26:43 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAJo=hJuS_iYSS8iVWoJ1BiUANsGtYJoYm-WRa863isVNsq=5vw@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Jul 2011, Shawn Pearce wrote:

> On Wed, Jul 20, 2011 at 17:18,  <david@lang.hm> wrote:
>>
>> if it's just locally generated, then I could easily see generation numbers
>> being different on different people's ssstems, dependin on the order that
>> they see commits (either locally generated or pulled from others)
>
> But this should only happen if the user fudges with their Git sources
> and makes Git produce a different generation number.
>
> If the algorithm is always "gen(A) = max(gen(P) for each parent_of(A))
> + 1" then it doesn't matter who merged what commits, the same commit
> appears at the same part of the graph relative to all of its
> ancestors, and therefore always has the same generation number. This
> is true whether or not the commit contains the generation number.

I have to think about this more, but I'm wondering about cases where the 
same result ia achieved via different methods, something along the lines 
of one person developing something with _many_ commits (creating a large 
generation number) that one person merges far sooner than another, causing 
the commits that they do after the merge to have much larger generation 
numbers than someone making the same changes, but doing the merge later

something like

   C9
    \
C2 - C10 - C11 - C12

vs
                 C9
                   \
C2 - C3 - C4 - C5 - C10

where the C10-12 in the first set and C3-5 in the second set are 
completely unrelated to what's done in C9 and C12 in the first set and C10 
in the sedond set are identical trees.

now I know that part of a commit is what it's parents are, so that is 
different (and that may be enough to say that generations don't matter 
and this entire issue is moot), but I haven't thought about it long enough 
to convince myself what would (or should) happen in these cases.

David Lang

>> If it's part of the commit, then as that commit gets propogated the
>> generation number gets propogated as well, and every repository will agree
>> on what the generation number is for any commit that's shared.
>
> This isn't really as beneficial as you are making it out to be. We
> already can agree on what the generation number should be for any
> given commit, if you topo-sort the commit DAG, you get the same
> result.
>
>> I agree that this consistancy guarantee seems to be valuable.
>
> Its valuable, but its consistent either with a cache, or not.
>
>
