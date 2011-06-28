From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 28 Jun 2011 09:25:36 +0200
Message-ID: <4E0981F0.6040507@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>  <4E08DCB1.3080503@web.de> <1309211840.2497.401.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 09:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbSiR-0000hf-BN
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 09:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242Ab1F1H0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 03:26:53 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50775 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab1F1HZi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 03:25:38 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 30BCC1921E8FD;
	Tue, 28 Jun 2011 09:25:37 +0200 (CEST)
Received: from [93.246.58.144] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbSfx-00065w-00; Tue, 28 Jun 2011 09:25:37 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <1309211840.2497.401.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/76+21IYZ0Fv+DMoKIHEAx/87bBK9S/XaPmxIg
	chbcDdzGO8QMwZu+I7RKOURnxv79pmIDhVCga29sVAWjECM2bu
	ML4fByCU03NatWAnfZ1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176386>

Am 27.06.2011 23:57, schrieb henri GEIST:
> Le lundi 27 juin 2011 =C3=A0 21:40 +0200, Jens Lehmann a =C3=A9crit :
>> Am 27.06.2011 21:05, schrieb Junio C Hamano:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>
>>>> Am 27.06.2011 18:51, schrieb Junio C Hamano:
>>>>> One possible working tree organization may look like this:
>>>>>
>>>>> 	-+- lib1
>>>>>          +- project1/Makefile -- refers to ../lib1
>>>>>          +- project2/Makefile -- refers to ../lib1
>>>> ...
>>>>> An interesting point your situation raises is that there is no di=
rect way
>>>>> to express module dependencies in .gitmodules file right now, I t=
hink.
>>>>> Ideally you would want "submodule init project1" to infer automat=
ically
>>>>> that project1 needs lib1 and run "submodule init lib1" for you. M=
y gut
>>>>> feeling is that it belongs to .gitmodules of the superproject
>>>>
>>>> That is where this is handled now, but having a submodule refer to=
 a
>>>> submodule outside of it as a dependency is an interesting thought.=
 But
>>>> as that only matters at the moment you add project1 (and it won't =
compile
>>>> because ../lib1 is missing, which can easily handled by: "oh, then=
 I have
>>>> to add lib1 as a submodule to the superproject too"), ...
>>>
>>> That is what I called "there is no direct way". Wouldn't it be nice=
r if
>>> the .gitmodules file in the superproject said something like
>>>
>>> 	[module "project one"]
>>> 		path =3D project1
>>>         	url =3D ...
>>>                 depends =3D lib1
>>> 	[module "lib1"]
>>>         	path =3D lib1
>>>                 url =3D ...
>>>
>>> and then "git submodule init project1" run by the end user implied =
running
>>> also "git submodule init lib1"?
>>
>> And if lib1 happens to have another dependency, that will be initial=
ized
>> too? That would make life much easier for users who only want certai=
n
>> submodules populated to work on, as they won't have to chase compile
>> errors anymore until they found all necessary submodules ... very ni=
ce.
>>
>=20
> That is right.
> But could also be done with the .gitmodules in project1 containing
>=20
> 	[module "lib1"]
>         	path =3D ../lib1
>                 url =3D ...
>=20
> and making implicite if the module is describe in .gitmodules that
> mean ./ depend on it.

But that would be much more complicated than just recording that in the
superproject's .gitmodules. In a Git repo everything lives in a directo=
ry
tree, if you want to reference something outside of that tree things wi=
ll
get very complicated ... and I'm not sure the benefit is worth the hass=
le.
