From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Thu, 06 Mar 2014 21:51:41 +0100
Message-ID: <5318DFDD.4060006@web.de>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>	 <1393878866.7891.22.camel@Naugrim> <53176951.7000201@web.de>	 <1394069128.7891.29.camel@Naugrim> <5318D101.9050305@web.de> <1394136925.7891.31.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:51:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfGi-00075f-G4
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 21:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbaCFUvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 15:51:47 -0500
Received: from mout.web.de ([212.227.15.4]:59095 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbaCFUvp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 15:51:45 -0500
Received: from [192.168.178.41] ([84.132.148.165]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LfAfQ-1WwvtV3oKm-00ojzW; Thu, 06 Mar 2014 21:51:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394136925.7891.31.camel@Naugrim>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:fJb97UFIFlE0jbdYka9zi50uB2ngR71X0XfMHqdLArWkJHdAFBU
 Y0QDj3cIAmXDjxnhbNWGyReT2Pc3VHnl/z4K3ti9yaTsf6kyPpDxexD6w0teEUth0bOkN0+
 If3ATosCP99wuRdzLTnwa0xRH87EpZTK48G3WfcVRhhBfT5ejxc8XAnGLsR/UIypdHGK/8t
 P2d5iOqGw2qSyjFHqO/ig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243549>

Am 06.03.2014 21:15, schrieb Henri GEIST:
> Le jeudi 06 mars 2014 =C3=A0 20:48 +0100, Jens Lehmann a =C3=A9crit :
>> Am 06.03.2014 02:25, schrieb Henri GEIST:
>>> Le mercredi 05 mars 2014 =C3=A0 19:13 +0100, Jens Lehmann a =C3=A9c=
rit :
>>>> Am 03.03.2014 21:34, schrieb Henri GEIST:
>>>>>   - I use an other patch which I plane to send later which enable=
 multiple
>>>>>     level of superproject to add a gitlink to the same submodule.
>>>>>     And in this case the superproject containing the separate git=
dir will be
>>>>>     arbitrary and depend on the processing order of the
>>>>>     'git submodule update --recursive' command.
>>>>
>>>> I don't understand that. How is that different from using differen=
t
>>>> names (and thus different separate gitdirs) for that duplicated
>>>> submodule? After all, the .git directory is just moved somewhere
>>>> else in the superproject's work tree, and as the name defaults to
>>>> the path of the submodule ...
>>>
>>> I think I should give an example.
>>> If I have a hierarchy like this :
>>>
>>> superproject/submodule/subsubmodule
>>>
>>> What I often do is:
>>>
>>> superproject --> submodule --> subsubmodule
>>>              |                 ^
>>>              '-----------------'
>>>
>>> Where '-->' is a gitlink.
>>>
>>>
>>> That mean .gitmodules and index of the superproject contain both su=
bmodule and
>>> submodule/subsubmodule.
>>
>> Wow, that shouldn't even work (as everything inside "submodule"
>> shouldn't be part of the superproject but must be contained in
>> the submodule itself). Do the "git submodule" script and other
>> git commands like "git status" work for you in such setups?
>=20
> As I stated above it is the purpose of the other patch that I have no=
t already send
> to implement this behavior. And that is why it work.

Ok.

> Everything including 'git submodule' and 'git status' work perfectly.
> The intent of this patch is only to permit this for gitlinks. Not for=
 regular files.

But I still believe that this shouldn't be permitted at all,
no matter if files or submodules are concerned. The pitfalls
files face in such a scenario are pretty much the same for
submodules too.

>>> and also mean (and that is the point) subsubmodule is a direct 'chi=
ld' of both
>>> superproject and submodule.
>>
>> Which I think should not be possible. If that works with current
>> Git I suspect we have a bug to fix ... or does your other patch
>> make this work?
>=20
> You have no bug on this point without my modification this is not pos=
sible.

Glad to hear that.

>>> In this case where should the separate gitdir of subsubmodule be pl=
aced ?
>>>   - In superproject/modules/submodule/subsubmodule ?
>>>   - In superproject/submodule/modules/subsubmodule ?
>>>   - Depending on the 'git submodule update' command order ?
>>>   - Or both ?
>>
>> It should be placed in .git/modules/submodule/modules/subsubmodule
>> of the superproject (assuming the subsubmodule is part of the first
>> level submodule). But in your example that would live in
>> .git/modules/submodule/subsubmodule (but as mentioned above, I do
>> not consider this a valid setup because then two repositories would
>> be responsible for the data inside subsubmodule, which will lead to
>> lots of trouble).
>=20
> That is why a had proposed an option '--no-separate-git-dir'
> for 'git submodule <add|update>' then no repository is responsible fo=
r the data
> in subsubmodule except subsubmodule itself.

As I mentioned in my other email, it doesn't matter at all for
the setup you're describing if the git directory lives under
=2Egit/modules of the superproject or in a .git directory in the
submodule. The problem you're creating with your future patch
is related to the work tree, not the GIT_DIR: "subsubmodule"
could also be added to and tracked by "submodule" (as that is
completely unaware of "subsubmodule" already being tracked by
the superproject). Then you would end up in real trouble, as
"superproject" and "submodule" could have differing SHA-1s
recorded for subsubmodule. Don't go there, for just the same
reasons we do not allow that for files.

What is the use case you are trying to solve and why can that
not be handled by adding "subsubmodule" inside "submodule"?
