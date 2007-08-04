From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 15:50:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041542270.11191@beast.quantumfyre.co.uk>
References: <854pjfin68.fsf@lola.goethe.zz> <85tzrfh3yg.fsf@lola.goethe.zz>
 <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
 <85k5sbh129.fsf@lola.goethe.zz> <8c5c35580708040703w44781498t7396588a3f8c81c8@mail.gmail.com>
 <854pjfgzit.fsf@lola.goethe.zz> <85y7grfkbe.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKxX-0000a1-07
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898AbXHDOuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbXHDOuY
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:50:24 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:35901 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754599AbXHDOuY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 10:50:24 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6C9C9B8D7E
	for <git@vger.kernel.org>; Sat,  4 Aug 2007 15:50:22 +0100 (BST)
Received: (qmail 13583 invoked by uid 103); 4 Aug 2007 15:50:21 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3852. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.050437 secs); 04 Aug 2007 14:50:21 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 4 Aug 2007 15:50:21 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <85y7grfkbe.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54861>

On Sat, 4 Aug 2007, David Kastrup wrote:

> David Kastrup <dak@gnu.org> writes:
>
>> "Lars Hjemli" <hjemli@gmail.com> writes:
>>
>>>>> Was this helpful?
>>>
>>> Talking to myself: obviously not
>>
>> Disagree.  "Does this answer all questions and makes git's behavior
>> perfectly transparent" -- no.  But let's not confuse "magical" with
>> "helpful" here.
>
> Ok, let's have another go.  Maybe I have understood more as compared
> with last time.
>
> git-branch/git-commit -b creates and manages local branches, nothing
> else.  Local branches' defining feature is that they have a branch
> head I can move around myself.
>
> Then there are non-local branches.  Their defining feature is that
> they have no locally moving branch head and _must_ track a remote
> branch.
>
> But local branches _also_ can track the progress/head of a remote
> branch.  Since they have a locally moving branch head, this will often
> lead to merge conflicts which must be resolved.
>
> So this is more or less what I understand now.  There really is no
> difference between "tracking" and "following" as I thought previously.
> It is just that a local branch which happens to track a remote branch
> is basically a remote tracking branch with a head of its own.
>
> Which means it can get merge conflicts.  Can we get merge conflicts
> with a remote tracking branch, too?  Namely when the remote branch
> messed with its history, rebased/reverted stuff?

Well, sort of - they are not really merge conflicts as there is no merging 
involved.  Fetching is strictly an updating process, either we update the 
branch or we don't.

When updating a remote tracking branch there are two possible scenarios:

1) the new head is a superset of the old head (i.e. the old head forms 
part of the history of the new)
2) the new head is not a superset of the old head (i.e. the old head does 
not form part of the history of the new)

The normal case is 1), and we simply update the branch to point at the 
new commit.  However what happens in case 2) depends on the configuration. 
If we have told git to force an update (indicated by the '+' on the 
beginning of the fetch line in the config) then we simply accept the new 
head as with case 1), otherwise we complain to the user and don't update 
that branch

> So that the real difference between a local and a remote tracking
> branch is not that the latter tracks a remote branch (the former can
> do that as well), but that the latter has no local branch head and
> that saves us a lot (but not necessary all) merge conflicts?

Yes.  A remote tracking branch is basically a read-only local cache of 
something that exists in some other repository.

-- 
Julian

  ---
If you're going to do something tonight that you'll be sorry for tomorrow
morning, sleep late.
 		-- Henny Youngman
