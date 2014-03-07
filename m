From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Sat, 08 Mar 2014 00:00:51 +0100
Message-ID: <531A4FA3.3040007@web.de>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>	 <1393878866.7891.22.camel@Naugrim> <53176951.7000201@web.de>	 <1394069128.7891.29.camel@Naugrim> <5318D101.9050305@web.de>	 <1394136925.7891.31.camel@Naugrim> <5318DFDD.4060006@web.de> <1394144428.7891.33.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 00:01:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM3lL-0005R0-OJ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 00:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbaCGXBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 18:01:03 -0500
Received: from mout.web.de ([212.227.17.12]:58104 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbaCGXBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 18:01:02 -0500
Received: from [192.168.178.41] ([84.132.147.179]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LzsGF-1XH67b0kgF-01532q; Sat, 08 Mar 2014 00:00:52
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394144428.7891.33.camel@Naugrim>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:rk1Ksd73eWOz51SR7Y32eZkaDlb8LcGBUECNdMhLwW19/vC6Fjm
 T62nRWuwjK5ZncsAf0ieM5AeCkFxJjjpcTG6w6K+Zr7BL1+D1l26ED22rgS/MbeQILBK23t
 PodLC9OxM+30Ke8lJ99gpo7C65jfcip9VuDQ6yj6d4GGHgCjtRYFfIPxOYDR+Vmc+VKB0Ka
 VuBIm22SxaGHWXNMSPwIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243636>

Am 06.03.2014 23:20, schrieb Henri GEIST:
> Le jeudi 06 mars 2014 =C3=A0 21:51 +0100, Jens Lehmann a =C3=A9crit :
>> Am 06.03.2014 21:15, schrieb Henri GEIST:
>>> Le jeudi 06 mars 2014 =C3=A0 20:48 +0100, Jens Lehmann a =C3=A9crit=
 :
>>>> Am 06.03.2014 02:25, schrieb Henri GEIST:
>>>> Wow, that shouldn't even work (as everything inside "submodule"
>>>> shouldn't be part of the superproject but must be contained in
>>>> the submodule itself). Do the "git submodule" script and other
>>>> git commands like "git status" work for you in such setups?
>>>
>>> As I stated above it is the purpose of the other patch that I have =
not already send
>>> to implement this behavior. And that is why it work.
>>
>> Ok.
>>
>>> Everything including 'git submodule' and 'git status' work perfectl=
y.
>>> The intent of this patch is only to permit this for gitlinks. Not f=
or regular files.
>>
>> But I still believe that this shouldn't be permitted at all,
>> no matter if files or submodules are concerned. The pitfalls
>> files face in such a scenario are pretty much the same for
>> submodules too.
>=20
> May be you have a good argument for this belief ?

Sure, I stated it further down:

>> The problem you're creating with your future patch
>> is related to the work tree, not the GIT_DIR: "subsubmodule"
>> could also be added to and tracked by "submodule" (as that is
>> completely unaware of "subsubmodule" already being tracked by
>> the superproject). Then you would end up in real trouble, as
>> "superproject" and "submodule" could have differing SHA-1s
>> recorded for subsubmodule. Don't go there, for just the same
>> reasons we do not allow that for files.

> As for the difference between submodules and regular files
> the only difference is in the meaning.
> Technically directory are just a special kind of file.
> But there day to day use is drastically different of
> the use of files which are not directories.
> I am not against enabling it for files as well.
> I am just unable to imagine a case where it make sens.

It doesn't make sense for both files and submodules.

> A possible solution when someone try to do it is to issue a warning.
> "We are not able to see any good reason to do this are sure (y/n) ?"

No, the only possible solution I see is not to allow that at
all.

>>>>> In this case where should the separate gitdir of subsubmodule be =
placed ?
>>>>>   - In superproject/modules/submodule/subsubmodule ?
>>>>>   - In superproject/submodule/modules/subsubmodule ?
>>>>>   - Depending on the 'git submodule update' command order ?
>>>>>   - Or both ?
>>>>
>>>> It should be placed in .git/modules/submodule/modules/subsubmodule
>>>> of the superproject (assuming the subsubmodule is part of the firs=
t
>>>> level submodule). But in your example that would live in
>>>> .git/modules/submodule/subsubmodule (but as mentioned above, I do
>>>> not consider this a valid setup because then two repositories woul=
d
>>>> be responsible for the data inside subsubmodule, which will lead t=
o
>>>> lots of trouble).
>>>
>>> That is why a had proposed an option '--no-separate-git-dir'
>>> for 'git submodule <add|update>' then no repository is responsible =
for the data
>>> in subsubmodule except subsubmodule itself.
>>
>> As I mentioned in my other email, it doesn't matter at all for
>> the setup you're describing if the git directory lives under
>> .git/modules of the superproject or in a .git directory in the
>> submodule. The problem you're creating with your future patch
>> is related to the work tree, not the GIT_DIR: "subsubmodule"
>> could also be added to and tracked by "submodule" (as that is
>> completely unaware of "subsubmodule" already being tracked by
>> the superproject). Then you would end up in real trouble, as
>> "superproject" and "submodule" could have differing SHA-1s
>> recorded for subsubmodule. Don't go there, for just the same
>> reasons we do not allow that for files.
>=20
> In fact it mater.
> Because multiples checkout of superproject and submodules in versions
> where subsubmodule is present and not.
> subsubmodule could have been clone one time by submodule and one time
> by superproject.

And each would have a different .git directory. Where is the
problem with that? Size? Different refs?

> And then if they are cloned with --separate-gitdir subsubmodule can
> have two gitdirs in superproject/modules/submodule/subsubmodule and
> in superproject/submodule/modules/subsubmodule.
> Only one is active at a given time but they are two and not synchroni=
zed.

But the synchronization is done via the superproject, no?

>> What is the use case you are trying to solve and why can that
>> not be handled by adding "subsubmodule" inside "submodule"?
>=20
> The problem is access rights.
>=20
> Imagine you have 2 people Pierre and Paul.
> Each with different access write on the server.
> Pierre has full access on every things.
> Paul has full access on superproject and subsubmodule but no read/wri=
te
> access to submodule only execution on the directory.

Ok, I think I'm slowly beginning to understand your setup.

> I want all user to get every things they are allowed to have with the
> command 'git submodule update --init --recursive'.
> Then as Paul can not clone submodule he can not get subsubmodule
> recursively through it.

Sure, that's how it should work. Paul could only work on a branch
where "submodule" is an empty directory containing "subsubmodule",
as he doesn't have the rights to clone "submodule".

> And I need superproject to add also submodule/subsubmodule.

No. Never let the same file/directory be tracked by two git
repositories at the same time. Give Paul a branch to work on
where "submodule" is just an empty directory, and everything
will be fine. Or move "subsubmodule" outside of "submodule"
(and let a symbolic link point to the new location if the
path cannot be easily changed). Would that work for you?
