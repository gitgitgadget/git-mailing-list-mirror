From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Mon, 02 May 2011 10:42:31 +0200
Message-ID: <4DBE6E77.3030703@drmicha.warpmail.net>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>	<20110429223433.GA3434@sigill.intra.peff.net>	<m2k4ecy6rv.fsf@igel.home> <7vfwp0uwu4.fsf@alter.siamese.dyndns.org> <m21v0kw1es.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon May 02 10:42:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGoiH-0001im-EA
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 10:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab1EBImf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 04:42:35 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54278 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753404Ab1EBImf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 04:42:35 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2847C205B6;
	Mon,  2 May 2011 04:42:34 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 02 May 2011 04:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=p2aeNQBSCgCk0JcY70pDwiReOG8=; b=rNlQ/G8KSeXhQvzTh6iCZwO7p+HT8BNSyLLVSHUDMtyvbdkjHis+pP4MtBURW5oL/CBOijmwHJPkxnYU5Mw1y7trmZClLIQejmGatXJkn/YqQ91BHQDDmYtVwXr+lxtgu1mf2EUGasnvwelJgPP4MKvtCj+q4FV5Zccjb+X1sV0=
X-Sasl-enc: JLr/DfR2OV6YRY9iq9Sg969k24g7yxH07CF5aLTBCB0N 1304325753
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6C2BE4458F5;
	Mon,  2 May 2011 04:42:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <m21v0kw1es.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172566>

Andreas Schwab venit, vidit, dixit 30.04.2011 11:09:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> It also conflicts a little with the shell's "~user" syntax, though
>>>> presumably you don't have users named "1" and "2".
>>>
>>> Well, you sorta do if you did use pushd.
>>
>> Yeah, I was also worried about that.  Or some arcane system
>> misinterpreting "~0" as the home directory of root ;-)
> 
> On non-arcane systems ~0 is expanded to the current directory.
> 
> Andreas.
> 
[cumulative reply :)]

While we could use a short-hand for HEAD also I don't think ~0 really is
a concern.

Regarding consistency:
We try to have reasonable defaults and try to dwim (which are different
things) even if that breaks consistency/systematics, because
useful/reasonable and "what I mean" depend on the context.

"^" resp. ".." and "..." are ambiguous and cannot be resolved easily
because for most commands they can mean two things resp. require two
arguments. (".." and "..." could maybe default do "@{u}..HEAD" etc.)

"~<n>" can only take a revision argument to its left, and also it needs
an argument to its left (as opposed to "^"). Therefore we can default it
unambiguously and without braking any current usage (that I know of).

Regarding rebase -i -<n>:
git-rebase (-i) does not have a log/rev-list like interface at all (just
like git-cherry does not), and introducing an argument which looks like
it did would just increase the user confusion, I'm afraid.

Michael
