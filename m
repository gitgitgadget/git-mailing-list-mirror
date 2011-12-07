From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git Submodule Problem - Bug?
Date: Wed, 07 Dec 2011 22:56:54 +0100
Message-ID: <4EDFE126.2060504@web.de>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com> <201111291024.01230.trast@student.ethz.ch> <20111129101546.GB2829@kolya> <201111291125.41943.trast@student.ethz.ch> <20111129104105.GA10839@kolya> <4ED5196B.5030200@web.de> <20111129220303.GA2812@sandbox-rc.fritz.box> <CAPUobv1QnuAT76=yGDM-KKjoiXCzMt0jCda0LdYxAjN49qmAgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Manuel Koller <koller.manuel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 22:57:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPU9-0006Xa-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 22:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494Ab1LGV5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 16:57:00 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:42587 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062Ab1LGV47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 16:56:59 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id 654881A4361A7
	for <git@vger.kernel.org>; Wed,  7 Dec 2011 22:56:58 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MRl2f-1RN2Yb1uMz-00Svza; Wed, 07 Dec 2011 22:56:57
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CAPUobv1QnuAT76=yGDM-KKjoiXCzMt0jCda0LdYxAjN49qmAgA@mail.gmail.com>
X-Provags-ID: V02:K0:dpgC+2j4E/aRrzbkI4MWMJaFkQQJ6DiAQ7Ll2duw7/U
 Sb5aqxqac/WIPZDva1HUkjXlVND6kjEErSqULjNrRcqgLao2pQ
 pQmizOqm2YBf0PediphdUl3BFQKNpSLOcWTATCG0XAoF15bvv3
 qgBaAEgZGSx2C6YYjxe6HPe/VTxYMObMG3Q/JtXdyscpDLeV39
 sGQXtepB3A2jnpzSYk+jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186505>

Am 07.12.2011 09:21, schrieb Manuel Koller:
>> How about this:
>>
>> The user issues 'git submodule add foo' and we discover that there is
>> already a local clone under the name foo. Git then asks something like
>> this
>>
>>        Error when adding: There is already a local submodule under the
>>        name 'foo'.
>>
>>        You can either rename the submodule to be added to a different
>>        name or manually remove the local clone underneath
>>        .git/modules/foo. If you want to remove the local clone please
>>        quit now.
>>
>>        We strongly suggest that you give each submodule a unique name.
>>        Note: This name is independent from the path it is bound to.
>>
>>        What do you want me to do ([r]ename it, [Q]uit) ?
>>
>> When the user chooses 'rename' git will prompt for a new name.
>>
>> If we are going to support the remove use case with add we additionally
>> need some logic to deal with it during update (which is not supported
>> yet AFAIK). But we probably need this support anyway since between
>> removal and adding a new submodule under the same can be a long time.
>> If users switch between such ancient history and the new history we
>> would have the same conflict.
>>is_submodule_modified()
>> We could of course just error out and tell the user that he has to give
>> the submodule an uniqe name. If the user does not do so leave it to him
>> to deal with the situation manually.
>>
>> What do you think?
>>
>> Cheers Heiko
> 
> Prompt to choose another name would be fine I guess - but it solves
> the problem only if the submodule has been initialized already. There
> could be a submodule of the same name in another branch, which I
> haven't checked out yet, for example. The user would have to be forced
> choose a unique name for every submodule.

Which seems pretty much impossible in a distributed system ...

> Anyway, it seems impossible to handle a name clash automatically,
> since there are good reasons to have different urls for the same
> submodule.> Having read the thread linked by Junio, the only way out
> seems to be a kind of url rewrite scheme and using the url as name.
> Doesn't it solve all the problems?
> 
> - the url is more or less unique (there are problems now if we have to
> different submodules at the same path, which is much more likely to
> happen than a different repository at the same url some time in the
> future)
> - after a change of the submodule's url, we can still check out old
> commits in a comfortable way
> - we could have the same submodule at different paths, but downloaded only once
> - the user is not forced to do anything, but the .gitmodule config can
> still be overruled if necessary

Hmm, using the URL has the downside that when one URL is just a fork of
the other we might have most of the repo duplicated in the .git/modules
directory ... but if it solves the problem of having a totally different
submodule cloned into the same path it might be worth it.
