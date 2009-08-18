From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 23:02:09 +0200
Message-ID: <200908182302.10619.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <m3fxbpneqe.fsf@localhost.localdomain> <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdVp8-00048Q-57
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbZHRVCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZHRVCT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:02:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:5518 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbZHRVCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:02:18 -0400
Received: by fg-out-1718.google.com with SMTP id e21so938071fga.17
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TVEkUGZK9MABg5egytQX92oMpULsrOpAh+xLmK6/UWQ=;
        b=YRfPpCGphWfA3itH43qeK3q1IMvOUakXEGPJQ9f0U5Bkqo7xjXFxeKW5bnZt3QC8pl
         UjqJZHtbNTZ+pDyFmLYTv9Rgzvu0ofIH+njwoaPCSH+qRwBC7gajPuAopbFBhbha0vno
         /MJeHXJqSd5zJe2usVhtlRt745kqEfC+BGR1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=F/x53HvKvysCD7/zgqrFi79/fbPIOkYOvXRwozWgwMQQwjwImAK2Ypkozj66LGLhKg
         5cTmpjPdO+d17q5rL7cgXI435lIyxNg1ovE7+9sdiLL9dhP6UyW/q1bsxmn9gNz1hBqJ
         lnUHy46AAQNwcKhlXg1lhTuCg4E3h//FT350k=
Received: by 10.86.174.2 with SMTP id w2mr3547515fge.0.1250629338272;
        Tue, 18 Aug 2009 14:02:18 -0700 (PDT)
Received: from ?192.168.1.13? (abvk137.neoplus.adsl.tpnet.pl [83.8.208.137])
        by mx.google.com with ESMTPS id 3sm5707971fge.20.2009.08.18.14.02.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 14:02:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126456>

On Tue, 18 Aug 2009, Nicolas Pitre wrote:
> On Tue, 18 Aug 2009, Jakub Narebski wrote:
>> Nicolas Pitre <nico@cam.org> writes:

>>> That won't buy you much.  You should realize that a pack is made of:
>>> 
>>> 1) Commit objects.  Yes they're all put together at the front of the pack,
>>>    but they roughly are the equivalent of:
>>> 
>>> 	git log --pretty=raw | gzip | wc -c
>>> 
>>>    For the Linux repo as of now that is around 32 MB.
>> 
>> For my clone of Git repository this gives 3.8 MB
>>  
>>> 2) Tree and blob objects.  Those are the bulk of the content for the top 
>>>    commit. [...]  You can estimate the size of this data with:
>>> 
>>> 	git archive --format=tar HEAD | gzip | wc -c
>>> 
>>>    On the same Linux repo this is currently 75 MB.
>> 
>> On the same Git repository this gives 2.5 MB
> 
> Interesting to see that the commit history is larger than the latest 
> source tree.  Probably that would be the same with the Linux kernel as 
> well if all versions since the beginning with adequate commit logs were 
> included in the repo.

Note that having reflog and/or patch management interface like StGit,
and frequently reworking commits (e.g. using rebase) means more commit
objects in repository.

Also Git repository has 3 independent branches: 'man', 'html' and 'todo',
from whose branches objects are not included in "git archive HEAD".

> 
>>> 3) Delta objects.  Those are making the rest of the pack, plus a couple 
>>>    tree/blob objects that were not found in the top commit and are 
>>>    different enough from any object in that top commit not to be 
>>>    represented as deltas.  Still, the majority of objects for all the 
>>>    remaining commits are delta objects.
>> 
>> You forgot that delta chains are bound by pack.depth limit, which
>> defaults to 50.  You would have then additional full objects.
> 
> Sure, but that's probably not significant.  the delta chain depth is 
> limited, but not the width.  A given base object can have unlimited 
> delta "children", and so on at each depth level.

You can probably get number and size taken by delta and non-delta (base)
objects in the packfile somehow.  Neither "git verify-pack -v <packfile>"
nor contrib/stats/packinfo.pl did help me arrive at this data.

>> The single packfile for this (just gc'ed) Git repository is 37 MB.
>> Much more than 3.8 MB + 2.5 MB = 6.3 MB.
> 
> What I'm saying is that most of that 37 MB - 6.3 MB = 31 MB is likely to 
> be occupied by deltas.

True.
 
>> [cut]
>> 
>> There is another way which we can go to implement resumable clone.
>> Let's git first try to clone whole repository (single pack; BTW what
>> happens if this pack is larger than file size limit for given
>> filesystem?).
> 
> We currently fail.  Seems that no one ever had a problem with that so 
> far. We'd have to split the pack stream into multiple packs on the 
> receiving end.  But frankly, if you have a repository large enough to 
> bust your filesystem's file size limit then maybe you should seriously 
> reconsider your choice of development environment.

Do we fail gracefully (with an error message), or does git crash then?

If I remember correctly FAT28^W FAT32 has maximum file size of 2 GB.
FAT is often used on SSD, on USB drive.  Although if you have  2 GB
packfile, you are doing something wrong, or UGFWIINI (Using Git For
What It Is Not Intended).
 
>> If it fails, client ask first for first half of of
>> repository (half as in bisect, but it is server that has to calculate
>> it).  If it downloads, it will ask server for the rest of repository.
>> If it fails, it would reduce size in half again, and ask about 1/4 of
>> repository in packfile first.
> 
> Problem people with slow links have won't be helped at all with this.  
> What if the network connection gets broken only after 49% of the 
> transfer and that took 3 hours to download?  You'll attempt a 25% size 
> transfer which would take 1.5 hour despite the fact that you already 
> spent that much time downloading that first 1/4 of the repository 
> already.  And yet what if you're unlucky and now the network craps on 
> you after 23% of that second attempt?

A modification then.

First try ordinary clone.  If it fails because network is unreliable,
check how much we did download, and ask server for packfile of slightly
smaller size; this means that we are asking server for approximate pack
size limit, not for bisect-like partitioning revision list.

> I think it is better to "prime" the repository with the content of the 
> top commit in the most straight forward manner using git-archive which 
> has the potential to be fully restartable at any point with little 
> complexity on the server side.

But didn't it make fully restartable 2.5 MB part out of 37 MB packfile?

A question about pack protocol negotiation.  If clients presents some
objects as "have", server can and does assume that client has all 
prerequisites for such objects, e.g. for tree objects that it has
all objects for files and directories inside tree; for commit it means
all ancestors and all objects in snapshot (have top tree, and its 
prerequisites).  Do I understand this correctly?

If we have partial packfile which crashed during downloading, can we
extract from it some full objects (including blobs)?  Can we pass
tree and blob objects as "have" to server, and is it taken into account?
Perhaps instead of separate step of resumable-downloading of top commit
objects (in snapshot), we can pass to server what we did download in
full?


BTW. because of compression it might be more difficult to resume 
archive creation in the middle, I think...

-- 
Jakub Narebski
Poland
