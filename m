From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Tue, 04 Jun 2013 23:39:25 +0200
Message-ID: <51AE5E8D.7080007@web.de>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org> <51A7A73C.6070103@web.de> <20130531194051.GC1072@serenity.lan> <51AD0EEB.4020106@web.de> <20130603222341.GL1072@serenity.lan> <20130604052950.GA2943@book.hvoigt.net> <20130604081045.GM1072@serenity.lan> <20130604111717.GA306@book.hvoigt.net> <20130604124826.GN1072@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:39:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyxM-0008Ox-No
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab3FDVjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 17:39:49 -0400
Received: from mout.web.de ([212.227.17.12]:50144 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab3FDVjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:39:48 -0400
Received: from [192.168.178.41] ([91.3.135.67]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Letkl-1U2wyI3GVL-00qY1a; Tue, 04 Jun 2013 23:39:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <20130604124826.GN1072@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:K+h222FsqpPxD551MU1cuJbvOJO6goxxRleF743r2IW
 luQYMvgls+XBa5o+fiEgJtFe9FznrsSxecLdD1AyYVjaub4hfP
 +xx43iqPVC6Tcfg54PiT5oMd8Vv8j1v2yL6/9XL7m43sHgEjjD
 XImexV7tSGMmtWi272HwdsaOnECgY7I1xjMTkAYPFildR/yC8y
 3FSZSt+7xzZiXeihuxO9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226413>

Am 04.06.2013 14:48, schrieb John Keeping:
> On Tue, Jun 04, 2013 at 09:17:17PM +1000, Heiko Voigt wrote:
>> On Tue, Jun 04, 2013 at 09:10:45AM +0100, John Keeping wrote:
>>> On Tue, Jun 04, 2013 at 03:29:51PM +1000, Heiko Voigt wrote:
>>>> On Mon, Jun 03, 2013 at 11:23:41PM +0100, John Keeping wrote:
>>>>>> Sorry, I should have been more specific here. I saw that you did=
 some
>>>>>> changes to make "submodule add" do the right thing with relative=
 paths,
>>>>>> but the following change to t7406 does not work like I believe i=
t
>>>>>> should but instead makes the test fail:
>>>>>> -------------------8<---------------------
>>>>>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-upd=
ate.sh
>>>>>> index a4ffea0..9766b9e 100755
>>>>>> --- a/t/t7406-submodule-update.sh
>>>>>> +++ b/t/t7406-submodule-update.sh
>>>>>> @@ -559,7 +559,9 @@ test_expect_success 'add different submodule=
s to the same pa
>>>>>>  test_expect_success 'submodule add places git-dir in superproje=
cts git-dir' '
>>>>>>         (cd super &&
>>>>>>          mkdir deeper &&
>>>>>> -        git submodule add ../submodule deeper/submodule &&
>>>>>> +        (cd deeper &&
>>>>>> +         git submodule add ../../submodule submodule
>>>>>> +        ) &&
>>>>>>          (cd deeper/submodule &&
>>>>>>           git log > ../../expected
>>>>>>          ) &&
>>>>>> -------------------8<---------------------
>>>>>
>>>>> Ah, ok.  I think this case is problematic because the repository
>>>>> argument is either relative to "remote.origin.url" or to the top =
of the
>>>>> working tree if there is no "origin" remote.  I wonder if we shou=
ld just
>>>>> die when a relative path is given for the repository and we're no=
t at
>>>>> the top of the working tree.
>>>>
>>>> Why not behave as if we are at the top of the working tree for rel=
ative
>>>> paths? If there is an origin remote thats fine. If there is no ori=
gin
>>>> remote you could warn that the path used is taken relative from th=
e root
>>>> of the superproject during add. What do you think?
>>>
>>> That's what the patch currently queued on "pu" does, which Jens wan=
ts to
>>> change, isn't it?
>>
>> True I did not realize this when reading it the first time. But I th=
ink
>> we should still not die when in a subdirectory. After all this serie=
s is
>> trying to archive that the submodule command works in subdirectories
>> seamlessly right? So you probably want to translate a relative path
>> without "origin" remote given from a subdirectory to the superprojec=
t
>> level and use that. Then you do not have to die.
>=20
> The problem is that sometimes you do want to adjust the path and
> sometimes you don't.  Reading git-submodule(1), it says:
>=20
>      This may be either an absolute URL, or (if it begins with ./ or
>      ../), the location relative to the superproject=E2=80=99s origin
>      repository.
>      [snip]
>      If the superproject doesn=E2=80=99t have an origin configured th=
e
>      superproject is its own authoritative upstream and the current
>      working directory is used instead.
>=20
> So I think it's quite reasonable to have a server layout that looks l=
ike
> this:
>=20
>     project
>     |- libs
>     |  |- libA
>     |  `- libB
>     |- core.git
>=20
> and with only core.git on your local system do:
>=20
>     cd core/libs
>     git submodule add ../libs/libB
>=20
> expecting that to point to libB.  But if we adjust the path then the
> user has to do:
>=20
>     git submodule add ../../libs/libB
>=20
> However, it is also perfectly reasonable to have no remote configured
> and the library next to the repository itself.  In which case we do w=
ant
> to specify the additional "../" so that shell completion works in the
> natural way.

Exactly.

> The only way I can see to resolve the ambiguity is to die when we hit
> this particular case.

Hmm, I'm not so sure about that. Don't the first three lines in
resolve_relative_url() show how to distinguish between these two
cases?

resolve_relative_url ()
{
	remote=3D$(get_default_remote)
	remoteurl=3D$(git config "remote.$remote.url") ||
		remoteurl=3D$(pwd) # the repository is its own authoritative upstream
=2E..

And this looks like a central place to handle this issue too (but I
admit I only glanced over the call sites of resolve_relative_url(),
so I might be missing something here).
