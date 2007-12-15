From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 22:15:22 +0100 (CET)
Message-ID: <alpine.LSU.0.99999.0712152212030.5326@castor.milkiway.cos>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos> <20071214074925.GA3525@steel.home>
 <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos> <m37ijfrcm5.fsf@roke.D-201> <alpine.LSU.0.99999.0712152117060.5151@castor.milkiway.cos> <m33au3r7zf.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 22:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3eMW-0003mg-De
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 22:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbXLOVPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 16:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756927AbXLOVPd
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 16:15:33 -0500
Received: from mailout02.sul.t-online.de ([194.25.134.17]:37996 "EHLO
	mailout02.aul.t-online.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756367AbXLOVPd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2007 16:15:33 -0500
Received: from fwd33.aul.t-online.de 
	by mailout02.aul.t-online.de with smtp 
	id 1J3eM5-00034K-04; Sat, 15 Dec 2007 22:15:29 +0100
Received: from [192.168.2.100] (STmvumZvYhEhqyuLgSAJw-qW7dlMbRRTNJ+NxdpqGQ5zB2RpVA+esM7HVecmTDxwBy@[84.163.221.165]) by fwd33.t-online.de
	with esmtp id 1J3eM3-1KAK3c0; Sat, 15 Dec 2007 22:15:27 +0100
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <m33au3r7zf.fsf@roke.D-201>
User-Agent: Alpine 0.99999 (LSU 796 2007-11-08)
X-ID: STmvumZvYhEhqyuLgSAJw-qW7dlMbRRTNJ+NxdpqGQ5zB2RpVA+esM7HVecmTDxwBy
X-TOI-MSGID: 46c4bb1f-d2e0-4871-aecf-f8945adccf10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68418>



On Sat, 15 Dec 2007, Jakub Narebski wrote:

> Michael Dressel writes:
>> On Sat, 15 Dec 2007, Jakub Narebski wrote:
>>> Michael Dressel writes:
>>>>
>>>> Since "git merge --squash <branch>" does a merge of <branch> into the
>>>> working tree why would you not call it a merge?
>>>
>>> A few illustrations. Commits A, B, C were made on 'trunk', commits
>>> a, b, c were made on 'branch'. You are on 'trunk', running
>>> "git merge <options> branch". We assume that there are no conflicts.
>>>
>>> 1. A non fast-forward case
>>>
>>>   1---2---3---A---B---C   <-- trunk    <-- HEAD
>>>            \
>>>             \-a---b---c   <-- branch
>
>>> 1.2. "git merge --no-commit branch"
>>>
>>>                        /-------- trunk  <-- HEAD
>>>                       v
>>>   1---2---3---A---B---C--*
>>>            \            /
>>>             \-a---b---c/     <-- branch
>>>                       ^
>>>                        \-------- MERGE_HEAD
>>>
>>> The merge commit '*' is prepared, but not yet committed, just
>>> as if there were merge conflict during merge. "git commit"
>>> would commit a merge (and would tell you that it does a merge
>>> commit).
>
>>> 1.4. "git merge --squash branch"
>>>
>>>   1---2---3---A---B---C--[abc]'   <-- trunk <-- HEAD
>>>            \
>>>             \-a---b---c           <-- branch
>>>
>>> "[abc]'" is a _single parent_ commit (it is not a merge commit!)
>>> which incorporates changes made on branch as if it were made in
>>> a single, large (!) commit.
>>
>> Thanks alot for the elaborate explanations.
>
> You are welcome
>
>>> Test of understanding the concepts: what does
>>> "git merge --squash --no-commit" does?
>>>
>>
>> From the man page it sounds "git merge --squash --no-commit" would do
>> the same as "git merge --squash". So in the example 1.4 [abc] should
>> not be a commit.
>
>                       /---------\
>                       v          \
>   1---2---3---A---B---C--*[abc]'  \-- trunk <-- HEAD
>            \
>             \-a---b---c           <-- branch
>
> where *[abc]' is prepared state (staged but not committed changes)
> squashing achanges into commits a, b, c into trunk.
>
> Note that using "git rebase --interactive" you can squash, reorder
> and edit commits; if you rather work in this way, reordering, editing
> etc. "on the go" you perhaps should consider patch-management
> interfaces like StGIT (Stacked GIT) or Guilt (formerly gq).
>
> BTW. in practice [abc]' in squash case is the same as M in normal
> case, only M has two parents recorded, and [abc]' does not.

Thanks again. There is a lot for me to practice now.

Cheers,
Michael
