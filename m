From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict
 subset of remote ref
Date: Fri, 02 Nov 2007 11:03:36 +0100
Message-ID: <472AF5F8.40208@op5.se>
References: <1193593581312-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.d
 e> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <! 47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntNe-0000kV-Mn
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbXKBKDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbXKBKDn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:03:43 -0400
Received: from mail.op5.se ([193.201.96.20]:43441 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbXKBKDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:03:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3733A17306DD;
	Fri,  2 Nov 2007 11:03:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aEtAgduCXSi5; Fri,  2 Nov 2007 11:03:07 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id BA6AA173068A;
	Fri,  2 Nov 2007 11:03:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63092>

Steffen Prohaska wrote:
> 
> On Nov 1, 2007, at 10:11 AM, Andreas Ericsson wrote:
> 
>>
>> It's easier to bisect. If git bisect lands you on a merge-commit,
>> you need to start a new bisect for each of the parents included
>> in the merge. Hopefully the nature of the merge gives a clue so
>> the user can make an educated guess as to which parent introduced
>> the bogus commit, but for an "evil octopus" (unusual) or if the
>> merge had conflicts which were resolved in a buggy way (not
>> exactly uncommon), it can be quite a hassle to get things right.
>> With a mostly linear history, this problem goes away.
> 
> This is really an interesting point. I did not start to use
> git bisect regularly. But I certainly plan to do so in the future.
> 
> Couldn't bisect learn to better cope with non-linear history?
> 

Perhaps it could, but it's far from trivial. I started hacking on
a wrapper for git-bisect which would do just that, but gave up
rather quickly as the book-keeping required to remember each and
every parent-point tried just got out of hand, and it *still*
wouldn't run in full automatic. It broke down because I also
wanted merges on non-first-line parents to be delved into. If
that didn't happen, I wouldn't *know* the bisect would run fine
without me watching it, so then it was as useless as if I'd have
had to sit there the entire time anyway.


> 
> BTW, what do you thing about the proposal to add branch.$name.push [1]?
> 
> [1] http://marc.info/?l=git&m=119384331712996&w=2
> 

I'm not so sure about it. I rather liked the "don't warn if local is
strict subset of remote" thing though. I teach our devs to just
ignore that warning, but with the same leaden feeling in my stomach
that someone, sometime, is going to get bit by it. It's worked so
far though, perhaps because our update-hook contains a check meaning
I'm the only one allowed to do "git-push --force".

>>
>> Except that it doesn't work unless you either detach the HEAD
>> (which prints a big fat ugly message) or give it -D to force
>> it, which I really, really don't recommend. We use git because
>> I'm pretty confident in its capabilities of never ever losing
>> anything. Using the seemingly harmless -D switch to git-branch
>> puts us at risk of wiping history quite without noticing.
> 
> I don't like -D either. I liked the idea mentioned recently
> to check -d against the remotes. If a remote tracking branch
> has the history it should be considered fully merged.
> 

Yes. Since remote branches are considered when prune'ing anyway,
and the git-branch -d warning is there to make sure we don't
accidentally lose any tip pointers, it should be safe to use
*all* "named" refs when checking for git-branch -d's sake (that
is, everything under refs/{heads,remotes,tags}/**/*).

> Another idea may be to distinguish between detached head and
> checkout of remote tracking branch. Maybe we could do some
> useful things if get knew that the user is 'on a remote tracking
> branch'. Committing could be forbidden.

Committing nearly *has* to be forbidden.

> A suggestion would be
> printed instead to use "git checkout -b something", which could act
> as if the remote branch was mentioned on the command line.
> 
> Something like that would be needed before I'd seriously
> suggest to delete local branches after you finished your work.
> 

Yup. I'll never suggest using "git branch -D" to my co-workers. Sooner
or later there'll be cries of anguish echoing throughout the office
when that happens ;-)

> 
> 
>>> Independently of what the best practice is, leaving the local
>>> work branch there shouldn't do any harm because I'm sure that
>>> some devs will forget to clean up, independently of what I tell
>>> them.
>>
>> I wholeheartedly agree with this one.
> 
> So I think we need to resolve this first.
> 
> Do you already have post-checkout script that makes useful
> suggestions.  I remember you mentioned something like that
> during the 200-local-branches discussion.
> 

No. Junio suggested I'd implement it as a post-checkout hook, but it
would only save me one command and could cause confusion as diff
output would change depending on whether one has checked out the
one branch or another prior to running git diff, so I decided against
it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
