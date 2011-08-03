From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 23:30:39 +0200
Message-ID: <4E39BDFF.3050804@web.de>
References: <4E0A08AE.8090407@web.de> <1311792580.2413.82.camel@Naugrim.eriador.com> <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de> <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de> <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de> <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de> <20110803062536.GB33203@book.hvoigt.net> <1312374382.3261.913.camel@Naugrim.eriador.com> <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de> <7vaabqb7vf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: henri GEIST <henri.geist@flying-robots.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:33:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoj4Y-0004Su-KN
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab1HCVbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:31:13 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:58859 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab1HCVbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:31:11 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id D395F196E463A;
	Wed,  3 Aug 2011 23:31:09 +0200 (CEST)
Received: from [79.247.240.110] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qoj1x-0007Fz-00; Wed, 03 Aug 2011 23:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vaabqb7vf.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18vZuvSdisDDgP/nI/TlHq9eXcjYXVMb2/hucsT
	M1Sdm1Yfuniot0FoYg6/Kd9p63HTk+zqcyMLQOlTYi71qNXuw9
	uvqNaffbJDthUdfm0mwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178621>

Am 03.08.2011 21:41, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> 1) To use me, you need another submodule "foo"
>>
>>    This is very helpful when you want to add the Gimp submodule and it
>>    can tell you you'll need the libpng submodule too in your superproject
>>    (but I'd vote to use the submodule name here, not the path as that
>>    should be the superproject's decision).
> 
> That is something you can add to .gitmodules in the superproject, no?
> E.g.
> 
> 	[submodule "Gimp"]
>         	url = http://some/where/
> 		path = gimp/
>         	depends = version 1.2.3 of "Glib"
> 
> 	[submodule "Glib"]
>         	url = http://some/where/else/
> 		path = libs/glib

The "depends" information is not very useful inside the superproject,
because when you already know that there you can simply commit version
1.2.3 of Glib together with Gimp instead of adding that information.
That's what gitlinks are for, no?

But when you fetch a new version of Gimp into your submodule, it would be
really nice if the superproject could be notified that the Gimp developers
updated to 1.2.4 of Glib and inform you that an update of Glib might be
appropriate. That could avoid having you to dig through compiler errors to
find out that the new foobar() function from Glib 1.2.4 is needed (and if
you need to pull in a bugfix in Glib, you might notice that *a lot* later
when you forget to do that).

>> In addition to that, it can (but mustn't) specify any of the following:
> 
> I am guessing you meant "does not have to", instead of mustn't, here...

Sure, thanks for deciphering that.

>> a) Of this submodule "foo" I need at least that version because I won't
>>    compile/work with older versions of that. (this can be tightened to
>>    "exactly that version" to give henri the behavior he wants, but that
>>    should be policy, not mandatory)
> 
> The "loose collection of projects" approach like that has its uses, and it
> is called "repo". Why re-invent it? The behaviour Henri wants to specify
> the exact version is how git submodules work already, so I do not see
> there is anything to be done here.

Let me make this clear: this is not about changing how submodules are
committed in a superproject. It is not about having a loose collection of
projects, they stay tied together in a defined state by the superproject.

Henri wanted it a bit upside down: any submodule could request a certain
version of another submodule somewhere else in the repo. And he wanted to
use gitlinks from one submodule to another for that, which I - hopefully -
convinced him was no good idea.

But I understand his need to have some kind of "version hint" from one
submodule to another. Just that he wants to take the hint very serious,
while I see it as means to communicate from the submodule maintainer to
the superproject developers that another submodule might have to be
updated too when they do that to his.

>> b) And if you don't know where to get it, use this url
> 
> Again that is the job of .gitmodules in the superproject.

Yes. But this idea is about how the url could get into the .gitmodules of
the superproject in the first place. That can make it easier for the
superproject's developer to import a submodule into his repo and much more
important: it makes it possible to pull in submodule dependencies
automatically e.g. when running "git submodule add --resolve-dependencies
Gimp".

>> That is all stuff the submodule knows better than the superproject.
> 
> Not necessarily. The version A0 of submodule A may depend on submodule B
> and may also know it must have at least version B0 of that submodule, but
> the superproject would know other constraints, e.g. the superproject
> itself also calls into submodule B and wants a newer version B1 of it.

Right. That's what I tried to explain to Henri, the superproject ties it all
together. But I also like his idea to add a way to communicate information
from the submodule to the superproject, and give the superproject a choice
if it wants to use it.
