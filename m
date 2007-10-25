From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 22:18:08 +0200
Message-ID: <4720FA00.1050805@op5.se>
References: <20071024212854.GB6069@xp.machine.xx>	<05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>	<Pine.LNX.4.64.0710242258201.25221@racer.site>	<008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>	<Pine.LNX.4.64.0710250021430.25221@racer.site>	<47204297.5050109@op5.se>	<Pine.LNX.4.64.0710251112390.25221@racer.site>	<472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org>	<4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org>	<4720CCE0.2090007@op5.se> <7vejfj11tk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il99x-00013N-DH
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbXJYUSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757747AbXJYUSP
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:18:15 -0400
Received: from mail.op5.se ([193.201.96.20]:52038 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbXJYUSM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:18:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5CCEF17306F0;
	Thu, 25 Oct 2007 22:18:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dstfbdioNngi; Thu, 25 Oct 2007 22:18:03 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 688001730559;
	Thu, 25 Oct 2007 22:18:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vejfj11tk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62366>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> However, there's still this issue:
>> $ git checkout -b foo origin/pu
>> Branch foo set up to track remote branch refs/remotes/origin/pu.
>> Switched to a new branch "foo"
>>
>> git checkout will say that every time a branch is created from a
>> tracking branch, unless one tells it --no-track (which people don't
>> learn about unless they're really into git), so it's quite natural
>> that people think git will actually make sure, within reasonable
>> limits, that 'foo' is kept in sync with refs/remotes/origin/pu.
>> That's not the case, however.
>>
>> So we could either change the message to be:
>> "Branch foo set up to track remote branch refs/remotes/origin/pu,
>> provided you only ever issue git-pull while having branch foo
>> checked out."
>>
>> Or we could make 'git checkout -b' default to --no-track, perhaps
>> giving annoying messages everytime someone "git-checkout -b"'s a
>> remote tracking branch.
>> Or we could make git-pull keep git checkout's promises.
> 
> The thing is, if you have 200 local branches (because you
> interact with 50 repositories with 4 primary branches each), you
> do not constantly check all of them out anyway.  And the only
> place that staleness of the local tracking fork matters is when
> you check it out (that is, as long as you train your users that
> the way to check differences with the upstream 'pu' in your case
> is by doing operations with 'origin/pu' not with your local
> 'foo').
> 

Probably, although I think the confusion of 'foo' being something
else than 'origin/pu' after it's been checked out would be hard
to explain. I'll see how the patch turns out. If it all goes tits
up, I'll see if a post-checkout hook can solve it.

> With that in mind, how about making "git checkout foo", after
> foo is set up thusly, to show:
> 
> 	git log --pretty=oneline --left-right origin/pu...foo
> 
> if (and only if) they have diverged?  Then you can deal with the
> staleness of local tracking fork 'foo' in any way you want.
> 
> You could even go one step further and make this "checkout foo",
> in addition to or instead of showing the above left-right log,
> 
>  - automatically run "git merge origin/pu" if it is a
>    fast-forward, and say it did _not_ run that merge if it is
>    not a fast-forward;
> 
>  - automatically run "git merge origin/pu" always, even if it is
>    not a fast-forward;
> 
>  - automatically run "git rebase origin/pu" always;
> 
> Would that make your life easier?

That it would, except the confusion would then be that it's automatically
rebased for the branches one currently hasn't got checked out while pulling,
and the branch that *is* checked out gets merged (crazy, yes), so those
who prefer the rebase would get what they want by doing something completely
bonkers, such as:

git checkout -b just-gonna-pull HEAD^
git pull
git checkout whatever-other-branch-they-were-on

(yes, "aggresively ignorant", I think Ted said in an earlier mail)

It'd probably be better to go with Dscho's suggestion, although I'm not quite
sure what that was any more. It involved automagical rebasing on fetch or pull
though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
