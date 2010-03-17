From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 14:10:43 -0400
Message-ID: <4BA11B23.4090801@xiplink.com>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock> <4BA07DC7.9070502@viscovery.net> <4BA0FD5B.5090408@xiplink.com> <4BA1010E.8030908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 17 19:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrxgH-0006aR-Gy
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 19:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab0CQSJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 14:09:16 -0400
Received: from smtp112.dfw.emailsrvr.com ([67.192.241.112]:58094 "EHLO
	smtp112.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab0CQSJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 14:09:15 -0400
Received: from relay1.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay1.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id B4D4F1279A3C;
	Wed, 17 Mar 2010 14:09:10 -0400 (EDT)
Received: by relay1.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0E3351279923;
	Wed, 17 Mar 2010 14:09:09 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4BA1010E.8030908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142422>

Johannes Sixt wrote:
> Marc Branchaud schrieb:
>> Johannes Sixt wrote:
>>> If I were to re-merge topic into master a second time after this
>>> situation, I would install a temporary graft that removes the second
>>> parent of M and repeat the merge. After the graft is removed, the history
>>> would look like this:
>>>
>>>      B --- C --- D --------------.   [topic]
>>>    /              \               \
>>>   A ---  ...   --- M ... --- U ... N [master]
>>>
>>> Are there any downsides? I don't know - I haven't thought it through.
>> I'm not sure I follow how to create that graft.
> 
>   $ echo $(git rev-parse M M^) >> .git/info/grafts
> 
>> But the original point (which I hadn't made clear) is that at least one of
>> the topic's commits needs to change in some substantial way.  So it's not
>> just a straight re-merge but a new take on the topic.
>>
>> Consider that if the topic's first commit (B) needed to be rewritten then the
>> repaired topic would contain only new commits and it could be merged into
>> master without reverting the first merge's reversion.
> 
> You don't need --ff nor --no-ff in this case.
> 
>> What "rebase -i --no-ff" does is allow you to ensure that this will always be
>> the case, even if you don't actually need to change the topic's first commit.
> 
> But why do you base the reworked topic on A instead of U or later?

I want the topic based on A so that I can merge it into other branches that
are also based on A.

> Or why don't you just mark the first commit as r(eword) and just exit the
> editor; it would rewrite the commit and all subsequent ones will be
> rewritten as well.

Yes, that works just as well (at least until someone optimizes the reword
command).

> Never in my life would I have searched for a *option*
> that achieves the goal. It is such a rare situation that we don't need an
> option, do we?

That's a more fundamental question.  I don't feel strongly either way.  The
main advantage I see with having the option is that it codifies the process,
with documentation and a unit test to help make sure it doesn't break.  So if
nobody wants the new option, I would then like to add a unit test to ensure
that rebase's reword command doesn't get optimized (if such a test doesn't
already exist), and maybe also add a note to the revert-a-faulty-merge howto.

		M.
