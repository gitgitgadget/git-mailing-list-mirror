From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Re: Switching branches without committing changes
Date: Fri, 21 Mar 2008 00:58:37 -0400
Message-ID: <5929C66E-EC03-4C1A-BC7A-14823B97DD64@faithfulgeek.org>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org> <20080321040647.GE8410@spearce.org> <20080321041013.GA2502@coredump.intra.peff.net> <7vod98u1pr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:01:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZNj-0002pW-3d
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 06:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYCUFAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 01:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbYCUFAr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 01:00:47 -0400
Received: from mail-out2.fuse.net ([216.68.8.171]:53500 "EHLO
	mail-out2.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYCUFAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 01:00:46 -0400
X-CNFS-Analysis: v=1.0 c=1 a=wnOyx2Aoai8A:10 a=big5-heUcSwJHT5sq_8A:9 a=QxizWIW117U-tz6YalMA:7 a=CECdm6cygEJr4z5zfjaZ1iswNRcA:4 a=OdWmie4EkE0A:10 a=XF7b4UCPwd8A:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout2 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:53030] helo=[192.168.1.33])
	by mail-out2.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id 51/37-05263-E7043E74 for <gitster@pobox.com>; Fri, 21 Mar 2008 00:59:00 -0400
In-Reply-To: <7vod98u1pr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77713>

Thanks all for the great info!  The scenarios you describe, Junio,  
make perfect sense.  In fact, that's pretty much the way I think when  
I'm coding and decided to branch or not to branch (that is the  
question).  Along the lines of those scenarios (maybe this should be a  
separate post), are there any guidelines or best practices on when/if  
to sync your branches with master (hope that's not a stupid question,  
I'm still learning)?

-Joe

On Mar 21, 2008, at 12:42 AM, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Mar 21, 2008 at 12:06:47AM -0400, Shawn O. Pearce wrote:
>>
>>> Use `git checkout -m` to switch the branch anyway.  However, if
>>> there is a merge conflict while you are trying to carry the changes
>>> to the other branch you may be faced with a merge conflict you are
>>> not prepared to resolve, or simply cannot resolve in a reasonable
>>> period of time.
>>
>> Ah, for some reason I didn't think of '-m' in the advice I gave (I  
>> guess
>> I have just never used it). It is almost certainly simpler than  
>> using a
>> 'stash' at this point (but I do think stashing _beforehand_ still has
>> advantages).
>
> The thing is, that -m is really to mollify people who are _too_  
> accustomed
> to CVS/SVN update behaviour.  Over there, "scm update" does not give  
> you
> any choice other than having to merge.
>
> With git, stashing or creating Park commits are very cheap operation  
> and
> unless you are reasonably sure that your local changes do not conflict
> with the branch you are switching to, there is no strong reason to  
> prefer
> "checkout -m".
>
> Switching branches with dirty state can have three scenarios:
>
> (1) you are getting interrupted and your current local changes do not
>     belong to what you are going to commit after switching (e.g. "the
>     boss says fix that right away").
>
>     recommendation: stash, or Park commit
>
> (2) you have started working but realized what you are working on  
> belongs
>     to a new topic.
>
>     recommendation: checkout -b
>
> (3) you have started working but realized what you are working on  
> belongs
>     to an existing topic.
>
>     recommendation: checkout -m
>
> In case (1), if the change is small, trivial or independent from  
> what you
> are switching branches to work on, you can "git checkout" (if the  
> change
> is about an unrelated thing, hopefully there won't be any overlap at  
> the
> file level) or "git checkout -m" (again, if the change is about an
> unrelated thing, the merge hopefully would be trivial) to switch  
> branches,
> perform the unrelated change and commit only that unrelated change,  
> and
> "git checkout" (or "git checkout -m") to come back to where you  
> started.
> But if you had to use "-m" when switching branches, that means the  
> change
> you need to commit in the switched branch may have to include some  
> changes
> you will do to that modified file, and you would need per-hunk  
> commit with
> "git add -i" to exclude existing changes.  In such a case, stashing  
> the
> local changes away before branch switching would be much easier  
> workflow.
>
> In case (2), the solution is always "checkout -b".  There is no other
> choice.
>
> In case (3), the solution is always "checkout -m".  Stashing,  
> switching
> and then unstashing will give the same conflicts as "checkout -m"  
> would
> give you, and the change you were working on has to be done on that
> switched to branch, so there is no escaping from conflict resolution,
> unless you are willing to redo your change on the breanch you  
> switched to
> again.
>
>
>
>
