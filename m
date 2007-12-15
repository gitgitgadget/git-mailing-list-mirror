From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 21:22:27 +0100 (CET)
Message-ID: <alpine.LSU.0.99999.0712152117060.5151@castor.milkiway.cos>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos> <20071214074925.GA3525@steel.home>
 <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos> <m37ijfrcm5.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 21:23:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3dXL-000669-8x
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 21:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbXLOUWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 15:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbXLOUWi
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 15:22:38 -0500
Received: from mailout07.sul.t-online.de ([194.25.134.83]:39066 "EHLO
	mailout07.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933AbXLOUWi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2007 15:22:38 -0500
Received: from fwd30.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1J3dWs-0008Bd-02; Sat, 15 Dec 2007 21:22:34 +0100
Received: from [192.168.2.100] (XZEOuMZ-ohNV7ginMflbvl+NDDhVk9GfG06RSyIwVfgw-eyhojIBCNmZG2Sl4+MQYZ@[84.163.243.66]) by fwd30.t-online.de
	with esmtp id 1J3dWq-1adKeO0; Sat, 15 Dec 2007 21:22:32 +0100
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <m37ijfrcm5.fsf@roke.D-201>
User-Agent: Alpine 0.99999 (LSU 796 2007-11-08)
X-ID: XZEOuMZ-ohNV7ginMflbvl+NDDhVk9GfG06RSyIwVfgw-eyhojIBCNmZG2Sl4+MQYZ
X-TOI-MSGID: 7b30a426-ef90-40c9-a63f-3bf7af812cfb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68412>



On Sat, 15 Dec 2007, Jakub Narebski wrote:

> Michael Dressel <MichaelTiloDressel@t-online.de> writes:
>
>> On Fri, 14 Dec 2007, Alex Riesen wrote:
>>
>>> Michael Dressel, Thu, Dec 13, 2007 22:28:30 +0100:
>>>> On Thu, 13 Dec 2007, Alex Riesen wrote:
>>>>> On 13/12/2007, Michael Dressel wrote:
>>>>>> git merge --no-commit <branch> does "create" a commit. At lesat the
>>>>>> head and index are moved to the new commit fetched from <branch>. Maybe
>>>>>> that is because git was able to do a fast forward?
>>>>>
>>>>> Yes. Because fast-forward is what it called: fast-forward.
>>>>> It does not do any commits at all.
>>>>>
>>>>
>>>> It looks like I misunderstood the meaning of --no-commit. I have to use
>>>> --squash in this case.
>>>>
>>>
>>> Maybe. Or maybe you misunderstood the meaning of --squash, which also
>>> is not a merge.
>>
>> Since "git merge --squash <branch>" does a merge of <branch> into the
>> working tree why would you not call it a merge?
>
> A few illustrations. Commits A, B, C were made on 'trunk', commits
> a, b, c were made on 'branch'. You are on 'trunk', running
> "git merge <options> branch". We assume that there are no conflicts.
>
> 1. A non fast-forward case
>
>   1---2---3---A---B---C   <-- trunk    <-- HEAD
>            \
>             \-a---b---c   <-- branch
>
> 1.1. "git merge branch"
>
>   1---2---3---A---B---C--M   <-- trunk  <-- HEAD
>            \            /
>             \-a---b---c/     <-- branch
>
> M is _merge_ commits, with two parents: C and c. It was created
> by "git merge branch".
>
> 1.2. "git merge --no-commit branch"
>
>                        /-------- trunk  <-- HEAD
>                       v
>   1---2---3---A---B---C--*
>            \            /
>             \-a---b---c/     <-- branch
>                       ^
>                        \-------- MERGE_HEAD
>
> The merge commit '*' is prepared, but not yet committed, just
> as if there were merge conflict during merge. "git commit"
> would commit a merge (and would tell you that it does a merge
> commit).
>
> 1.3. "git merge --no-commit --no-ff branch"
>
> Like in 1.2, because it is non fast-forward case.
>
> 1.4. "git merge --squash branch"
>
>   1---2---3---A---B---C--[abc]'   <-- trunk <-- HEAD
>            \
>             \-a---b---c           <-- branch
>
> "[abc]'" is a _single parent_ commit (it is not a merge commit!)
> which incorporates changes made on branch as if it were made in
> a single, large (!) commit.
>
> 1.5. "git rebase trunk branch" (or "git pull --rebase branch")
>
>   1---2---3---A---B---C              <-- trunk
>                        \
>                         \-a'--b'--c' <-- branch  <-- HEAD
>
> Rebase is step-by-step process, replying commits a, b, c on top
> of trunk, trying for the same _changes_. a', b', c' are newly
> created commits, introducing the same changes as a, b, c if there
> were no rebase conflicts.
>
> I think that "git pull --rebase branch" goes a step further and
> actually does after-rebase fast-forward merge, and does not change
> branch, but I might be mistaken.
>
>   1---2---3---A---B---C---a'--b'--c'  <-- trunk <-- HEAD
>            \
>             \-a---b---c               <-- branch
>
>
> 2. Fast forward case; there are no commits A, B, C, and we
> start from the following situation:
>
>   1---2---3               <-- trunk    <-- HEAD
>            \
>             \-a---b---c   <-- branch
>
> 2.1. "git merge branch"
>
>   1---2---3            /----- trunk    <-- HEAD
>            \          v
>             \-a---b---c   <-- branch
>
> Fast forward results in simply moving the head of trunk.
> It does not create a commit, hence:
>
> 2.2. "git merge --no-commit branch"
>
> Like in 2.1, because fast-forwarding does not create a commit.
>
> 2.3. "git merge --no-commit --no-ff branch"
>
>   1---2---3               <-- trunk    <-- HEAD
>            \
>             \-a---b---c   <-- branch
>
> (probably with some error message).
>

Thanks alot for the elaborate explanations.

>
> Test of understanding the concepts: what does
> "git merge --squash --no-commit" does?
>

>From the man page it sounds "git merge --squash --no-commit" would do the 
same as "git merge --squash". So in the example 1.4 [abc] should not be a 
commit.

Cheers,
Michael
