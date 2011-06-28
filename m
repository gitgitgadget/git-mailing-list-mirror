From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Wed, 29 Jun 2011 00:24:56 +0200
Message-ID: <4E0A54B8.6050904@web.de>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com> <1309112987-3185-3-git-send-email-iveqy@iveqy.com> <7v1uydvmh0.fsf@alter.siamese.dyndns.org> <20110628193034.GB3700@book.hvoigt.net> <7viprpu1p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:25:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbgiO-0004i2-Tl
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab1F1WZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:25:00 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54363 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab1F1WY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:24:58 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id ABF2E192E62A8;
	Wed, 29 Jun 2011 00:24:56 +0200 (CEST)
Received: from [93.246.41.92] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbgiG-0003EE-00; Wed, 29 Jun 2011 00:24:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7viprpu1p5.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Xqvu3UgAiRaSmHZv8+cfJF46snWbBuMy3B2Hl
	nzJTvYNNQBxnlNp1wSWCCJ0QsOxYIxfgN6Wp/O/xxWsVvjrZL+
	EJuRyyURt6r3cZU0PBWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176425>

Am 28.06.2011 22:43, schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>>> What if
>>>
>>>  (1) you are binding somebody else's project as your own submodule, you do
>>>      not make any local changes (you won't be pushing them out anyway),
>>>      and you do not have remote tracking branches in that submodule
>>>      project?
>>
>> In this scenario the superproject can not be cloned that way that it
>> would contain the submodule right? I would consider this a rather exotic
>> way to work since pushing means to share your work somehow.
> 
> Sorry, I don't follow. Isn't this the classical example of an el-cheapo
> router firmware project (i.e. superproject) binding unmodified Linux
> kernel project as one of its submodules without you having any push
> privilege to Linus's repository, which was one of the original examples
> used in the very initial submodule discussion?

Yes, but if you push a version to el-cheapo upstream containing a Linux
submodule commit not contained in Linus' repository (because you made some
changes yourself), that won't be cloneable from upstream el-cheapo by
anyone else. This is what this check makes you aware of, and the best
practice here IMO is: make your own fork of Linus' repo (on github or
someplace similar) and then you do have the push rights. (This is what we
do where I work for every repo we don't have push access to and it solves
this problem nicely. And in fact this is pretty much the same I do for a
stand alone repo - like Git - I don't have push access to but want to
publish my changes for: I make a fork that gives me push rights and allows
me to share my work)

>> This check is solely meant as a convenience security measure. It should
>> and can not enforce a tight check whether a superproject (including its
>> submodules) can be cloned/checked out at all times. But it ensures that
>> a developer has pushed his submodule commits "somewhere" which is enough
>> in practice.
> 
> I am not entirely convinced but if this would catch more than 80% of
> casual mistakes, it would be good enough.  I was hoping that somebody may
> come up with an idea that would work even in case (3), though.

My impression is that we would catch more than 80% (but I admit that I
might be influenced by the way we use submodules). Anyways, maybe the
solution for (3) is to only take the default remote into account and to
ignore the others? (Because that's the one most users will initialize from
the .gitmodules of the superproject)
