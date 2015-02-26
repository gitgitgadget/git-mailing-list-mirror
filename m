From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Thu, 26 Feb 2015 12:05:27 +0100
Message-ID: <54EEFDF7.8090306@drmicha.warpmail.net>
References: <1424540906.15539.22.camel@scientia.net>	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>	<xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>	<54EC98BD.7060100@drmicha.warpmail.net>	<xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>	<54ED9AF7.6080908@drmicha.warpmail.net> <xmqqoaohonpt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 12:05:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQwGD-0002NI-C1
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 12:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbbBZLFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 06:05:30 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60420 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762AbbBZLF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 06:05:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 596B7208FF
	for <git@vger.kernel.org>; Thu, 26 Feb 2015 06:05:28 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 26 Feb 2015 06:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=GTD3Ruyne4dOqw1l9uBNdv
	+MWdc=; b=eb27dB318KpUmPi2pyqwaSCAX+pdK18IybNgDLc/jWp1fgM0oflO9g
	ZZ/PKyknbYcrVdBmbn2zIcnDFL+kK1kRLL+6534GM+3Kq897Jb3ffKwJv2Yfow9N
	5TkiAOa0XQoGY1LVa+wFw91l8moYdCKr0gZGlcz712htHyn4wfxZE=
X-Sasl-enc: 41AI5q+UDGxga23fqKrRsGx1iKy6TrRS7KnqQt6UAI4n 1424948728
Received: from localhost.localdomain (unknown [188.96.114.76])
	by mail.messagingengine.com (Postfix) with ESMTPA id 72F0F680122;
	Thu, 26 Feb 2015 06:05:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqoaohonpt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264432>

Junio C Hamano venit, vidit, dixit 25.02.2015 19:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 24.02.2015 19:29:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>>> Hmm, wouldn't it introduce a grave regression for users who
>>>>> explicitly ask to clean crufty messages up (by setting their own
>>>>> commit.cleanup configuration) if you unconditionally force
>>>>> "--cleanup=verbatim" here?
>>>>>
>>>>
>>>> That's what I meant by possible side-effects below.
>>>> ...
>>>> But git cherry-pick without conflict should no re-cleanup the commit
>>>> message either, should it?
>>>
>>> Hmm, but if it does not, wouldn't that countermand the wish of the
>>> user who explicitly asked to clean crufty messages up by setting
>>> their own commit.cleanup configuration?
>>
>> Note that "verbatim" is not the default - we cleanup commits even
>> without being asked to. And this makes sense for "git commit", of course.
> 
> I am fine with the result of the updated code if the user does not
> have anything in the config and uses the "default".  Not touching in
> "cherry-pick" would be more desirable than cleaning.  We are in
> agreement for that obvious case.

I didn't know we were. It's clear now.

> But your response is sidestepping my question, isn't it?

I simply misunderstood it.

> What does your change do to the user who wants that the clean-up to
> always happen and expresses that desire by setting
> commit.cleanup=strip in the config?  Doesn't the internal invocation
> of "commit --cleanup=verbatim" that is unconditional override it?
> 

Yes, it obviously overrides it.

I have to re-check which cleanups rebase does. I hope none.

But I would think that to clean up a commit message according to the
current config settings, a user should have to "commit --amend" or
"rebase -i with reword" explicitly.

I still think of rebase and cherry-picks as means to transplant a commit
as unchanged as possible.

Now, if there are conflicts and the user has to resolve them, they will
use "git commit" themselves with their current config in effect. That is
to be effected, and the user can use "git commit --cleanup=..." however
they want.

That leaves the case of "git cherry-pick --edit". I could easily catch
that and not overrride config in this case. But the user cannot
influence that other than by using "git -c commit.cleanup=...
cherry-pick --edit".

Hmm. With "--edit", current config being in effect should be expected,
right? So how about:

In case of no conflict: force cleanup=verbatim unless --edit is used?

Michael
