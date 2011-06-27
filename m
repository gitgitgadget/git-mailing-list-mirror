From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 21:40:33 +0200
Message-ID: <4E08DCB1.3080503@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com> <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de> <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: henri GEIST <henri.geist@flying-robots.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 21:40:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbHfp-0002ax-3s
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 21:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab1F0Tki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 15:40:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35586 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab1F0Tkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 15:40:35 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 30B6B1A3CD5A2;
	Mon, 27 Jun 2011 21:40:34 +0200 (CEST)
Received: from [93.240.101.84] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbHfe-0005bw-00; Mon, 27 Jun 2011 21:40:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+JUB3iNHp2EMuPTKbVbebwp/Fz6X5fb5m5IgtV
	WBBzpDAOItN8uLJHoZ08wj7Xti8NIliH1KJjvaOqziYENyyLvA
	jYnkliSyVn0qmpl0l5tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176368>

Am 27.06.2011 21:05, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 27.06.2011 18:51, schrieb Junio C Hamano:
>>> One possible working tree organization may look like this:
>>>
>>> 	-+- lib1
>>>          +- project1/Makefile -- refers to ../lib1
>>>          +- project2/Makefile -- refers to ../lib1
>> ...
>>> An interesting point your situation raises is that there is no direct way
>>> to express module dependencies in .gitmodules file right now, I think.
>>> Ideally you would want "submodule init project1" to infer automatically
>>> that project1 needs lib1 and run "submodule init lib1" for you. My gut
>>> feeling is that it belongs to .gitmodules of the superproject
>>
>> That is where this is handled now, but having a submodule refer to a
>> submodule outside of it as a dependency is an interesting thought. But
>> as that only matters at the moment you add project1 (and it won't compile
>> because ../lib1 is missing, which can easily handled by: "oh, then I have
>> to add lib1 as a submodule to the superproject too"), ...
> 
> That is what I called "there is no direct way". Wouldn't it be nicer if
> the .gitmodules file in the superproject said something like
> 
> 	[module "project one"]
> 		path = project1
>         	url = ...
>                 depends = lib1
> 	[module "lib1"]
>         	path = lib1
>                 url = ...
> 
> and then "git submodule init project1" run by the end user implied running
> also "git submodule init lib1"?

And if lib1 happens to have another dependency, that will be initialized
too? That would make life much easier for users who only want certain
submodules populated to work on, as they won't have to chase compile
errors anymore until they found all necessary submodules ... very nice.
