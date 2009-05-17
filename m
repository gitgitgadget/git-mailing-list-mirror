From: david@lang.hm
Subject: Re: On data structures and parallelism
Date: Sun, 17 May 2009 12:31:35 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0905171230070.26653@asgard>
References: <20090517152335.GC11543@zakalwe.fi> <alpine.LFD.2.01.0905170950230.3301@localhost.localdomain> <alpine.LFD.2.01.0905171038320.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 17 21:31:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5m5K-0006Ud-KK
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 21:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbZEQTbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 15:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbZEQTbi
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 15:31:38 -0400
Received: from mail.lang.hm ([64.81.33.126]:48417 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbZEQTbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 15:31:37 -0400
Received: from asgard.local (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n4HJVZgn006486;
	Sun, 17 May 2009 12:31:35 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <alpine.LFD.2.01.0905171038320.3301@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119406>

On Sun, 17 May 2009, Linus Torvalds wrote:

> On Sun, 17 May 2009, Linus Torvalds wrote:
>>
>> That said, on my laptops, CPU time really _never_ is the issue. Every
>> single time something is slow, the issue is a slow 4200rpm disk that may
>> get 25MB/s off it for linear things in the best case, but seeks take
>> milliseconds and any kind of random access will just kill performance.
>
> Side note - I've several times desperately tried to see if IO parallelism
> helps. It doesn't. Some drives do better if they get many independent
> reads and can just do them concurrently. Sadly, that's pretty rare for
> reads on rotational media, and impossible with legacy IDE drives (that
> don't have the ability to do tagged queueing).
>
> So when I try to do IO in parallel (which git does support for many
> operations), that just makes the whole system come to a screeching halt
> because it now seeks around the disk a lot more. A similar issue that
> often kill parallelism on CPU's (bad cache behavior, and lots of
> outstanding memory requests) kills parallelism on disks too - disk
> performance simply is much _better_ if you do serial things than if you
> try to parallelize the same work.
>
> It would be different if I had a fancy high-end RAID system with tagged
> queueing and lots of spare bandwidth that could be used in parallel. But
> that's not what the git usage scenario often is. All the people pushing
> multi-core seem to always ignore the big issues, and always working on
> nice trivial problems with a small and well-behaved "kernel" that has no
> IO and preferably didn't cache well even when single-threaded (ie
> "streaming" data).

do things change with SSDs? I've heard that even (especially??) with the 
Intel SSDs you want to have several operations going in paralllel to get 
the best out of them.

David Lang
