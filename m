From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 16:02:26 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910171557290.6644@reaper.quantumfyre.co.uk>
References: <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk> <20091016143041.GA11821@atjola.homenet> <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <20091017075551.GA5474@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 17 17:07:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzArM-000860-I5
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 17:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbZJQPGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 11:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbZJQPGE
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 11:06:04 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49539 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678AbZJQPGD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 11:06:03 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id ECA56357726
	for <git@vger.kernel.org>; Sat, 17 Oct 2009 16:06:06 +0100 (BST)
Received: (qmail 23411 invoked by uid 103); 17 Oct 2009 16:02:27 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9906. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025986 secs); 17 Oct 2009 15:02:27 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Oct 2009 16:02:27 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20091017075551.GA5474@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130558>

On Sat, 17 Oct 2009, Bj?rn Steinbrink wrote:

> On 2009.10.16 18:31:23 +0100, Julian Phillips wrote:
>> On Fri, 16 Oct 2009, Bj?rn Steinbrink wrote:
>>> On 2009.10.16 13:15:35 +0100, Julian Phillips wrote:
>>>> How about:
>>>>
>>>> $ git checkout origin/master
>>>> $ git fetch
>>>> Refusing to fetch, as it would update a checkedout branch
>>>> "git fetch -f" will force the update, but you will need to run "git
>>>> reset --hard HEAD" to update your checkout to match.
>>>
>>> That would redefine -f (currently means "allow non-fast-forward
>>> updates"), the flag that allows the checked out branch head to be
>>> updated is -u, --update-head-ok, and is for internal use only.
>>>
>>> And suggesting "reset --hard" seems wrong, that just kills any
>>> uncommitted changes.
>>
>> Ok, so the commands were wrong.  Not important.
>>
>> It was the approach that I was trying to suggest rather than the
>> actual commands.  The point I was trying to make was how, as a user,
>> I would be happy to git behave.
>
> Your approach explicitly included "mess up the index/worktree state",
> otherwise, "git fetch" would not have to tell the user that he has to do
> a "git reset --hard HEAD". I honestly can't believe that you would be
> happy with git messing up your work.
>
>> So, I try to run fetch, git says "ooh, now that would be dangerous -
>> you can force it happen by running "git foo", but you will then be
>> in situation X, which you can then recover from by running "git
>> bar", though you may need to run "git stash" to save any edits you
>> have made" or something similar.
>
> But why make "git fetch" with non-"obscure" refspecs dangerous to begin
> with? If we detach but keep some extra information, there's no need to
> make "git fetch" dangerous, _and_ we can still provide a command that
> just fetches the most recent version of the "checked out" remote
> tracking branch and checks that out. May it be another mode of operation
> for "git pull" or some "git up" command or whatever.

My entire argument was in the context of the mail that I orginally replied 
to, i.e. assuming that the decision to not detach had been taken.  If that 
is not the case, then everything I had said is irrelevant.

I wasn't arguing against detaching, but rather trying to say that _if_ we 
are not going to detach then I think it would better like this than that. 
I don't personally have any input on the detach or not, as I have been 
using git for too long to know if detaching is a problem for others.  I 
can tell from my bash prompt if I'm detached or on a branch - and that's 
fine for me.

-- 
Julian

  ---
Wedding is destiny, and hanging likewise.
 		-- John Heywood
