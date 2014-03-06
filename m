From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Thu, 06 Mar 2014 20:48:17 +0100
Message-ID: <5318D101.9050305@web.de>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>	 <1393878866.7891.22.camel@Naugrim> <53176951.7000201@web.de> <1394069128.7891.29.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:48:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLeHN-0001GH-W0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbaCFTsZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 14:48:25 -0500
Received: from mout.web.de ([212.227.15.3]:56335 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbaCFTsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:48:25 -0500
Received: from [192.168.178.41] ([84.132.148.165]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M3jsn-1XCVud2vnF-00rJcf; Thu, 06 Mar 2014 20:48:18
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394069128.7891.29.camel@Naugrim>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:O10FA7VnFcmdD0wKKv1HnSRm38UkaRqdGIwyhsEeU/j7SWOx2rP
 PgqHLvH3XO8cKEvQsNI+R6buj2gKm64dT6rQK8AiDfQncWryDbNTitQA9foC6DdWhfPhhpY
 MvYmpFSFwtJNGmjNmbMHup01gC+aOCNUsZbGVTAGqVv/hHGsnqwT5IzINRwDZ00wFvyjqez
 Gu1jyUyQYBLg0fnUOnwZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243543>

Am 06.03.2014 02:25, schrieb Henri GEIST:
> Le mercredi 05 mars 2014 =C3=A0 19:13 +0100, Jens Lehmann a =C3=A9cri=
t :
>> Am 03.03.2014 21:34, schrieb Henri GEIST:
>>> Le lundi 03 mars 2014 =C3=A0 17:45 +0000, Jens Lehmann a =C3=A9crit=
 :
>>>> Am 03.03.2014 14:47, schrieb Henri GEIST:
>>>>> This new option prevent git submodule <add|update> to clone the m=
issing
>>>>> submodules with the --separate-git-dir option.
>>>>> Then the submodule will be regular repository and their gitdir wi=
ll not
>>>>> be placed in the superproject gitdir/modules directory.
>>>>
>>>> And what is your motivation for this? After all submodules contain=
ing
>>>> a .git directory are second class citizens (because they can never=
 be
>>>> safely removed by regular git commands).
>>>>
>>>
>>> I recognize most people will prefer to have the .git directory sepa=
rate.
>>> And I do not intend to make this option the default.
>>>
>>> My reasons are:
>>>
>>>   - As it is not clearly stated in the doc that the gitdir is separ=
ate.
>>>     The first time I have copied one module to an USB key I had a b=
ig
>>>     surprise.
>>
>> Oops! Could you please help us by hinting how the documentation
>> could be improved here?
>>
>=20
> Of course.
> There is nothing in Documentation/git-submodule.txt to inform that su=
bmodules
> clones are different from regular clones.
> I will write and propose a patch for the documentation.
> But maybe in a new thread.

Thanks!

>>>   - This will not change anything for people not using it.
>>
>> I do not agree, as they'll be seeing a new option and might use
>> it to "go backward" as Junio explained in his answer.
>>
>>>   - I use an other patch which I plane to send later which enable m=
ultiple
>>>     level of superproject to add a gitlink to the same submodule.
>>>     And in this case the superproject containing the separate gitdi=
r will be
>>>     arbitrary and depend on the processing order of the
>>>     'git submodule update --recursive' command.
>>
>> I don't understand that. How is that different from using different
>> names (and thus different separate gitdirs) for that duplicated
>> submodule? After all, the .git directory is just moved somewhere
>> else in the superproject's work tree, and as the name defaults to
>> the path of the submodule ...
>>
>=20
> I think I should give an example.
> If I have a hierarchy like this :
>=20
> superproject/submodule/subsubmodule
>=20
> What I often do is:
>=20
> superproject --> submodule --> subsubmodule
>              |                 ^
>              '-----------------'
>=20
> Where '-->' is a gitlink.
>=20
>=20
> That mean .gitmodules and index of the superproject contain both subm=
odule and
> submodule/subsubmodule.

Wow, that shouldn't even work (as everything inside "submodule"
shouldn't be part of the superproject but must be contained in
the submodule itself). Do the "git submodule" script and other
git commands like "git status" work for you in such setups?

> And also mean (and that is the point) subsubmodule is a direct 'child=
' of both
> superproject and submodule.

Which I think should not be possible. If that works with current
Git I suspect we have a bug to fix ... or does your other patch
make this work?

> In this case where should the separate gitdir of subsubmodule be plac=
ed ?
>   - In superproject/modules/submodule/subsubmodule ?
>   - In superproject/submodule/modules/subsubmodule ?
>   - Depending on the 'git submodule update' command order ?
>   - Or both ?

It should be placed in .git/modules/submodule/modules/subsubmodule
of the superproject (assuming the subsubmodule is part of the first
level submodule). But in your example that would live in
=2Egit/modules/submodule/subsubmodule (but as mentioned above, I do
not consider this a valid setup because then two repositories would
be responsible for the data inside subsubmodule, which will lead to
lots of trouble).
