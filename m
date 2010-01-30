From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 23:03:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001292232130.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ron1-F006CF.18381129012010@news.gmane.org>
 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
 <ron1-8B7921.19261029012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 05:03:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb4YW-000100-MM
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 05:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab0A3ED1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 23:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104Ab0A3ED1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 23:03:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21168 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0A3ED0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 23:03:26 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX100EAPKLPQBL0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 23:03:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ron1-8B7921.19261029012010@news.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138438>

On Fri, 29 Jan 2010, Ron Garret wrote:

> In article <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>,
>  Junio C Hamano <gitster@pobox.com> wrote:
> 
> > "A commit that is in the middle of an ancestry chain with existing
> > descendants" can be at the tip of a branch and does not have anything to
> > do with detached HEAD state.
> 
> Ah, then you're right.  I really don't get it yet.

Have a look at http://eagain.net/articles/git-for-computer-scientists/

That's one of the clearest explanation of the Git branching model I've 
seen.

> > When HEAD points at a branch, making a commit advances _that_ branch.  And
> > we say you are "on that branch".  When HEAD is detached, because it is not
> > attached to anything, it advances no branch.  "detached HEAD" is detached
> > in the very real sense.  It is not attached to _any_ branch.
> 
> OK.  The docs do not make that clear at all.  In fact, the following 
> statement, copied straight from the manual, flatly contradicts what you 
> just said:
> 
> "The special symbol "HEAD" can always be used to refer to the current 
> branch."
> 
> Always.  Except when it can't.

There is no contradiction.  The "detached HEAD" corresponds to HEAD 
pointing at no branch in particular.  There is just no current branch in 
that case.

> Soooo.....
> 
> Sometimes HEAD can refer to a branch head which is a pointer to a 
> commit, and sometimes HEAD can refer to a commit directly without 
> indirecting through a branch head (lower case), in which case it is 
> detached.  Is that right?

Exact.

> If that's true, then I'm back to wondering what good is a detached head.  
> Why would you ever want one?  What can you do with a detached head that 
> you could not do just as easily without one?

By definition, remote tracking branches are "read-only" because we want 
those branch heads to reflect what the remote repository they're 
tracking has.  In other words, you're not supposed to add commits to a 
remote branch or it would move that branch to the new commit which is no 
longer a representation of the corresponding remote repository.  In 
order to actually add commits on top of a remote branch, you first have 
to make a local branch being a copy of the remote branch of interest 
(which in practice means only making the local branch point at the same 
commit node as the remote branch) and then any commit will advance that 
local branch and leave the remote branch behind.

But what if you just want to check out the content corresponding to that 
remote branch without adding any new commits?  What if you wish to do 
the same with a tag instead of a branch (a tag being immutable)?

If you could have HEAD pointing to a tag or a remote branch then many 
operations such as 'git commit' would need to be blocked in order to 
preserve the read-only nature of such references.

The detached HEAD solves the issue really neatly in those cases.  
Instead of having HEAD pointing to a remote branch record, the detached 
HEAD points directly at the provided commit from the remote branch head 
or tag, and any commit operation will simply update that direct 
reference alone, creating a fork point in the history graph.

If you wish to preserve this branch in the graph sense then you can 
create a new branch head with the current HEAD position.  Or if you 
don't care about those commits you made on the detached HEAD, then 
simply moving HEAD to anything else with another checkout command will 
drop and forget about that string of commits you created.

So a detached HEAD is useful for checking out a read-only branch or tag 
without having to forbid a bunch of operations or needing for you to 
create a dummy temporary local branch just for the purpose of such a 
checkout.  Many operations with intermediate states such as 'git rebase' 
or 'git bisect' can be implemented without polluting the branch 
namespace, etc.


Nicolas
