From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: who's on first? - following first parent and merge-management
Date: Fri, 09 Mar 2012 14:25:14 +0100
Message-ID: <4F5A04BA.8030401@ira.uka.de>
References: <jj6s47$m98$1@dough.gmane.org> <7vwr6woo8p.fsf@alter.siamese.dyndns.org> <7vty1zfwmd.fsf@alter.siamese.dyndns.org> <20120308071403.GE7643@sigill.intra.peff.net> <4F5867D4.1010904@viscovery.net> <7vpqcndmpa.fsf@alter.siamese.dyndns.org> <4F59F212.6030701@ira.uka.de> <4F59F7A2.3030606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 14:24:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5zoM-0005fy-AX
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 14:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab2CINYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 08:24:40 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43523 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753937Ab2CINYk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 08:24:40 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S5znv-0003KK-2R; Fri, 09 Mar 2012 14:24:34 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S5znu-0002Sd-UP; Fri, 09 Mar 2012 14:24:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F59F7A2.3030606@viscovery.net>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1331299474.770739000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192717>

On 09.03.2012 13:29, Johannes Sixt wrote:
> Am 3/9/2012 13:05, schrieb Holger Hellmuth:
>> On 08.03.2012 18:30, Junio C Hamano wrote:
>>> Johannes Sixt<j.sixt@viscovery.net>   writes:
>>>> To avoid the situation,...
>>>> This would not be necessary if the order of the merge parents could be
>>>> specified, e.g.:
>>>>
>>>>      # on topic
>>>>      git merge --into master
>>>
>>> I think the underlying mechanism needed to implement the above
>>> shares a lot with what Jeff called "crazy idea", but where you would
>>> want to be after such a merge may be different in these two cases.
>>
>> I don't think there is much question that you should still be in the same
>> branch. Not because you necessarily want to be in that branch. But because
>> it would be surprising if git-merge changed your branch sometimes and most
>> times not.
>
> I don't think that it is so clear-cut. And for this reason, I would even
> go as far as to suggest that you should end up with a detached HEAD.
>
> Before the merge we have this situation:
>
> --o--o--o--o<- master
>     \
>      o--o--o--X<- topic
>
> The result of 'git merge --into master' must advance branch master by the
> merge commit (I think there is no doubt about this):
>
> --o--o--o--o---M<- master
>     \          /
>      o--o--o--X<- topic
>
> Also, the index and worktree must match M (no doubt, either, IMO). But
> what does HEAD refer to? I see three possibilities:

I see we have different ideas. I envisioned --into to be the equivalent of
git checkout master
git merge topic
git checkout topic

and in that case index and worktree would be topic naturally.

But your caveat below would be even more problematic in this case.

> 1. master; as you say, this may be surprising if we were on topic before
> the branch.
>
> 2. topic; but then the index would be dirty because it does not match X.
>
> 3. M, i.e. a detached HEAD; this is just a compromise and a fat warning at
> the end of the merge output would be necessary that instructs the user to
> checkout a suitable branch.
>
> Now that I have tossed around these ideas, there's another caveat: What if
> the merge fails due to a conflict? After the conflicts were resolved, 'git
> commit' is needed to complete the merge. But this would create the commit
> where HEAD points to. IOW, we have to chose option 1 so that the merge
> commit advances master.
>
> Would this be less surprising if the option were named --checkout-into?

Don't think so. It would make it clear where you end up but it would 
muddle/hide the original purpose of the parameter. "git merge --into 
xxx" sounds like a real sentence (Larry Wall would approve ;-).

Guess we would have to rely on the documentation to make it clear that a 
branch switch happens. And a message "Changing to branch xxx" on STDOUT 
wouldn't hurt either.
