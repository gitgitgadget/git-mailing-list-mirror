From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Problems switching branches
Date: Wed, 24 Nov 2010 16:33:04 -0600
Message-ID: <ick3tr$j5l$1@dough.gmane.org>
References: <loom.20101103T032930-451@post.gmane.org> <loom.20101104T012032-963@post.gmane.org> <AANLkTikK93Jt+dAkpp6K-hQEo6D67q5OKJSLs+g0YL4y@mail.gmail.com> <4CD3A5D9.6070802@seznam.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 23:34:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLNvT-00020b-7E
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 23:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab0KXWet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 17:34:49 -0500
Received: from lo.gmane.org ([80.91.229.12]:56329 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab0KXWes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 17:34:48 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PLNvL-0001wf-9j
	for git@vger.kernel.org; Wed, 24 Nov 2010 23:34:47 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 23:34:47 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 23:34:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162092>


"Maaartin-1" <grajcar1@seznam.cz> wrote in message 
news:4CD3A5D9.6070802@seznam.cz...
> On 10-11-04 15:39, Nguyen Thai Ngoc Duy wrote:
>> On Thu, Nov 4, 2010 at 7:23 AM, Maaartin <grajcar1@seznam.cz> wrote:
>>> Maaartin <grajcar1 <at> seznam.cz> writes:
>>>
>>>>
>>>> I sometimes run in a problem similar to
>>>> http://kerneltrap.org/mailarchive/git/2008/10/15/3667644/thread
>>>> There are some ignored files which I want neither track nor throw away; 
>>>> I'm
>>> just
>>>> happy to have them and keep them out of version control.
>>>>
>>>> Unfortunately, there weren't ignored in the old branch. I'd be quite 
>>>> happy
>>> with
>>>> non-destructive switching like "checkout everything what doesn't 
>>>> overwrite an
>>>> untracked file", so I would end in the old branch with a dirty working 
>>>> tree.
>>> Is
>>>> it possible?
>>>
>>> No answer?
>>
>> Which means nobody is interested in. Well, not really.
>>
>> I also get irritated by a similar situation, where the untracked files
>> have the same content as the to-be-checked-out files. I have been
>> tempted (but never got around) to make git compare the in-index
>> content and the untracked file, if it's the same, no need to abort the
>> checkout process.
>
> I was asked to provide a working example of the happening, but I haven't
> managed to reproduce it yet. However, it's not very rare (it just never
> happen when I need it).
>
>> But your approach may be better. Yes, I think it's possible. Any
>> suggestion for checkout's new argument? --no-overwrite-untracked seems
>> too long.
>
> I would go even further: a switch called "ignorant" or "lenient"
> allowing to always switch branches in a non-destructible way. All files
> normally causing abort would be left unmodified, so you could do
> git checkout --ignorant forth; git checkout back
> and would (assuming you started in branch "back") land in the original
> state without loosing anything. Of course, this means, that the ignorant
> checkout doesn't lead you into a clean state, but that's why I'd like to
> use a switch instead of making it the default. :)
>
> I may be talking non-sense as I'm quite inexperienced user, however I'd
> love an easier way for switching branches. Quite often, I'd like to put
> a modified file onto a different branch. This sounds probably strange,
> but my work is really quite chaotic in this respect at the moment and
> I'd like to organize it better by using a couple of (quite similar)
> branches (with a lifespan of a few days at most).
>

You could use git-stash in combination with git-clean.  Let's say BranchA 
has FileA (untracked), and BranchB has FileA (tracked):
git branch = BranchA
git stash = this will store your dirty working tree in a commit 
behind-the-scenes, and store your index in a commit behind-the-scenes, and 
then run a git-reset --hard behind the scenes.
git status = is FileA still 'untracked'?
    if so, git clean -f to remove it.  don't worry, its in your stash you 
just made.
git clean -f
git checkout BranchB
now you have FileA from BranchB
git checkout BranchA
git stash apply, (use git stash apply --index if you want the index back 
also)
now you have BranchA and its untracked FileA

Using the stash and clean will also keep various untracked files from 
different lines-of-development from accumulating in your worktree.  "Keep 
track" of your untracked files by stashing them away and cleaning them up, 
so to speak.  This is actually pretty straightforwarad and easy once you get 
used to it, IMHO.

v/r,
Neal 
