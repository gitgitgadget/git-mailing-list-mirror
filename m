From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is	strict
 subset of remote ref
Date: Fri, 02 Nov 2007 14:52:15 +0100
Message-ID: <472B2B8F.1060203@op5.se>
References: <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@zib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <472AF5F8.40208@op5.se> <20071102132446.GA31758@hermes.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inwx6-0008EW-FB
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 14:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbXKBNwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 09:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbXKBNwd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 09:52:33 -0400
Received: from mail.op5.se ([193.201.96.20]:46718 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbXKBNwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 09:52:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9448A173072C;
	Fri,  2 Nov 2007 14:52:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQq8V1WUF7d6; Fri,  2 Nov 2007 14:52:18 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id AC8C217306F2;
	Fri,  2 Nov 2007 14:52:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071102132446.GA31758@hermes.priv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63120>

Tom Prince wrote:
> On Fri, Nov 02, 2007 at 11:03:36AM +0100, Andreas Ericsson wrote:
>> Steffen Prohaska wrote:
>>> On Nov 1, 2007, at 10:11 AM, Andreas Ericsson wrote:
>>>> It's easier to bisect. If git bisect lands you on a merge-commit,
>>>> you need to start a new bisect for each of the parents included
>>>> in the merge. Hopefully the nature of the merge gives a clue so
>>>> the user can make an educated guess as to which parent introduced
>>>> the bogus commit, but for an "evil octopus" (unusual) or if the
>>>> merge had conflicts which were resolved in a buggy way (not
>>>> exactly uncommon), it can be quite a hassle to get things right.
>>>> With a mostly linear history, this problem goes away.
>>> This is really an interesting point. I did not start to use
>>> git bisect regularly. But I certainly plan to do so in the future.
>>> Couldn't bisect learn to better cope with non-linear history?
>> Perhaps it could, but it's far from trivial. I started hacking on
>> a wrapper for git-bisect which would do just that, but gave up
>> rather quickly as the book-keeping required to remember each and
>> every parent-point tried just got out of hand, and it *still*
>> wouldn't run in full automatic. It broke down because I also
>> wanted merges on non-first-line parents to be delved into. If
>> that didn't happen, I wouldn't *know* the bisect would run fine
>> without me watching it, so then it was as useless as if I'd have
>> had to sit there the entire time anyway.
> 
> I haven't had occasion to use git-bisect much, but I was under the
> impression that bisect could already handle merges, or any other shaped
> history just fine.
> 

It appears the code supports your statement. I started writing on my
hack-around about a year ago, and the merge-handling code got in with
1c4fea3a40e836dcee2f16091bf7bfba96c924d0 at Wed Mar 21 22:16:24 2007.
Perhaps I shouldn't be so paranoid about useless merges anymore then.
Hmm. I shall have to look into it. Perhaps Junio can clarify how it
works? The man-page was terribly silent about how git-bisect handles
merges.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
