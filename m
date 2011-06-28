From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 28 Jun 2011 09:20:53 +0200
Message-ID: <4E0980D5.8040004@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org> <1309211460.2497.395.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 09:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbSgA-0008Ph-7h
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 09:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab1F1HWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 03:22:03 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46934 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124Ab1F1HVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 03:21:02 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 32BA71921943C;
	Tue, 28 Jun 2011 09:20:56 +0200 (CEST)
Received: from [93.246.58.144] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbSbP-000267-00; Tue, 28 Jun 2011 09:20:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <1309211460.2497.395.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19HZlBmxzH0ZWzhmdJ2MbdkfDLHlouKsuVWZTsm
	wqAQgFlcxSZT1rM7zKypWRtip7s0D8xeSyOoXDsw/GLIBpd+Bd
	i+DFmJggwfeDfDp6b/og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176385>

Am 27.06.2011 23:51, schrieb henri GEIST:
> Le lundi 27 juin 2011 =C3=A0 12:05 -0700, Junio C Hamano a =C3=A9crit=
 :
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> Am 27.06.2011 18:51, schrieb Junio C Hamano:
>>>> One possible working tree organization may look like this:
>>>>
>>>> 	-+- lib1
>>>>          +- project1/Makefile -- refers to ../lib1
>>>>          +- project2/Makefile -- refers to ../lib1
>>> ...
>>>> An interesting point your situation raises is that there is no dir=
ect way
>>>> to express module dependencies in .gitmodules file right now, I th=
ink.
>>>> Ideally you would want "submodule init project1" to infer automati=
cally
>>>> that project1 needs lib1 and run "submodule init lib1" for you. My=
 gut
>>>> feeling is that it belongs to .gitmodules of the superproject
>>>
>>> That is where this is handled now, but having a submodule refer to =
a
>>> submodule outside of it as a dependency is an interesting thought. =
But
>>> as that only matters at the moment you add project1 (and it won't c=
ompile
>>> because ../lib1 is missing, which can easily handled by: "oh, then =
I have
>>> to add lib1 as a submodule to the superproject too"), ...
>>
>> That is what I called "there is no direct way". Wouldn't it be nicer=
 if
>> the .gitmodules file in the superproject said something like
>>
>> 	[module "project one"]
>> 		path =3D project1
>>         	url =3D ...
>>                 depends =3D lib1
>> 	[module "lib1"]
>>         	path =3D lib1
>>                 url =3D ...
>>
>> and then "git submodule init project1" run by the end user implied r=
unning
>> also "git submodule init lib1"?
>>
>>
>=20
> This could be a way if .gitmodules can contain something like
>=20
> 	[module "project one"]
> 		path =3D project1
>         	url =3D ...
>                 depends =3D lib1	"123456"
> 	[module "project two"]
> 		path =3D project2
>         	url =3D ...
>                 depends =3D lib1	"abcdef"
> 	[module "lib1"]
>         	path =3D lib1
>                 url =3D ...

But there is no need for that as "123456" and "abcdef" are already pres=
ent
as the sha1 values for the gitlinks "lib1" and "lib2".
