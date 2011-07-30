From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Sat, 30 Jul 2011 16:16:11 +0200
Message-ID: <4E34122B.5020509@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>  <7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>  <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>  <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>  <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com>  <1311843465.3734.40.camel@Naugrim.eriador.com>  <4E3192D4.5000504@web.de> <1311932377.3734.182.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 16:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnAKz-0001EE-SM
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 16:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab1G3OQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 10:16:17 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:52959 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1G3OQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 10:16:15 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6B8AC1A755F3C;
	Sat, 30 Jul 2011 16:16:14 +0200 (CEST)
Received: from [93.246.57.12] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QnAKs-0003XZ-00; Sat, 30 Jul 2011 16:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1311932377.3734.182.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19zST0ajIP1xR9CMZyhWZDiG+6kHlJb/RTJTm4h
	QQxfcegxoRgVKXayhb6Ag67eI1DXfQFvVQE2m08WlgWJx9mp7u
	ihHqGrmY55mm+koZ5lfg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178198>

Am 29.07.2011 11:39, schrieb henri GEIST:
> Le jeudi 28 juillet 2011 =C3=A0 18:48 +0200, Jens Lehmann a =C3=A9cri=
t :
>> Am 28.07.2011 10:57, schrieb henri GEIST:
>>> In the current code it was not possible to add a gitlink to a repos=
itory
>>> outside of the main repository.
>=20
> Of course that is why I have done the patch.
>=20
>> Me thinks this is a *feature* this patch removes (as I understand it=
 it was
>> a major design decision that everything /inside/ a directory is cont=
rolled
>> by git).
>=20
> That is still the case.

No, as "everything /inside/ a directory" also means "nothing /outside/ =
that
directory" in this context.

> It is not a matter of disabling any control of git in its own
> repository.
> It is just a matter of adding inside the git repository a reference
> (dependency) to an other git repository.

=2E.. which you want to have *outside* of the containing repository! Th=
at will
then be registered in other git repositories too in your model, which g=
ets
rid of the "one file/submodule, one repo" assumption we now have and wi=
ll
introduce ambiguities which are *really* hard to handle.

>>> This pach :
>> <snip>
>>>   - Still forbids to add anything else.
>>
>> Why? If you let submodules live outside the tree I don't see any rea=
son why
>> regular files shouldn't live there too (Disclaimer: I d not think th=
at would
>> be a good idea either ;-).
>=20
> there is regular file in the submodule repository but they are contro=
led
> by the submodule itself. Then the main repository do not need to hand=
le
> them.
>=20
> Just like you I think that regular file should not be touche outside =
of
> the repository by git.

No, I think we should /either/ allow gitlinks *and* files to live outsi=
de of
the repository /or/ *none* of them, as they have a lot in common (and I=
'm
working on making them to behave as similar as possible). And in the us=
e case
you describe here it is totally irrelevant if you dependency consists o=
f a
directory tree in a submodule (=3D a bunch of files) or just a single f=
ile (say
a header containing project wide definitions).

> Because in this case it is not just a reference that is managed but t=
he
> file itself. And this way there is a risk to overwrite some data not
> under revision control outside of the repository.

You have the same risk when a gitlink points outside, as a submodule is=
 a
way of controlling a bunch of files through that reference. And the fil=
e
would be under version control in the repository where it is registered=
, no?

>> What you want looks like this:
>>
>> -+- lib1    #registered as submodule of project1 *and* project2 but =
not here
>>  +- project1            # submodule of the superproject
>>  |  +- ../lib1
>>  +- project2            # submodule of the superproject
>>     +- ../lib1
>=20
> In fact no.
> What I want is to have this:
>=20
> -+- lib1
>  +- project1
>  +- project2
>=20
> With :
>  - lib1 not knowing anything about projects 1 & 2
>  - project1 not knowing anything about project2 and vice et versa
>  - project1 knowing that it need lib1 in version N.
>  - project2 knowing that it need lib1 in version M.

Right, I should have explained the "../lib1" entries better.

> I know that means a conflict in the required lib version but it is
> required by the independence of projects 1 & 2 which do not have to k=
now
> what happen in the other one.
>=20
> And in fact it is just what I want, it enable me if I decide to work =
on
> an optional "BigProject" depending on both project 1 & 2.
>=20
> Then If lib1 is in version M:
>  - a git status in project2 will say nothing
>  - a git status in project1 will say
>    "modified:   ../lib1 (modified content)
>  - a git status in BigProject will say
>    "modified:   ../project1 (modified content)
>=20
> Then I know that I need to update project1 to work with the last vers=
ion
> M of lib1.

Maybe no update for project1 is needed, because M only contains a bugfi=
x
which doesn't even need a recompilation of project1. But now you need t=
o
add a commit to project1 nonetheless with a message like "Updated lib1
with a bugfix which is needed by project2" which makes your idea of
independent submodules break down.

>> You are opening a can of worms by having two different repos point t=
o the same
>> submodule living in a third repo (which also happens to be their sup=
erproject
>> and must somehow ignore it). You'll have two SHA1s for a single subm=
odule;
>> "git submodule foreach --recursive" will have interesting results to=
o; and so
>> on. Not good.
>=20
> As I just said before it is my purpose to do it like that.

I understood that, but what are you proposing to do to solve all the
problems your approach introduces? You can't just hand wave them away.

> Let say a concret exemple
>=20
> 3 different teams work on libtiff, libpng, and libjpeg they are total=
ly
> unrelated.
>=20
> One more team is working on the "gimp". And they need those 3 libs in
> specific versions not necessarily there heads.
>=20
> One other unrelated team is working on "gqview" and need the same lib=
s
> in other specifics versions (Why should they know what te gimp team
> does)
>=20
> Neither "gimp" and "gqview" project will contain directory with those
> libs inside. They just depend on them.
>=20
> And the last team work on the gnome project which need the "gimp" and
> "gqview". It will be this team witch have to care about having both
> "gimp" and "gqview" sharing the same libs version>
> And has well the gnome project will not contain "gqview" and "gimp" i=
n
> its own tree.
> It will also depend on them.

Cool, that is a real life example resembling what we have a my dayjob. =
But
a "gimp" and "gqview" project will only have dependencies like "use lib=
png
of version 1.2.3 or newer (because we need a feature/bugfix introduced
there)" and won't be tied to a special version of that library. This me=
ans
they need a dependency like "SHA1 or newer" instead of "exactly this SH=
A1".

> It is just the same with aptitude on debian.
> Each package know there dependency by themselves, does not contain th=
ere
> dependencies, and do not need a bigger superpackage to tell them what
> are there own dependencies.

And this is a very good point for the "version x.yy-z *or newer*" argum=
ent,
they are /never/ tied to the /exact/ x.yy-z version, as that would make=
 the
dependencies pretty much unusable. They use a "newer than x.yy-z" schem=
e.

>> What about solving that with a "ln -s ../lib1" in "project1" and "pr=
oject2"
>> (you seem to need that for your build environment) and adding the su=
bmodule
>> "lib1" to the superproject just like "project1" and "project2"?
>>
>=20
> For my build environment I do not use simlinks.
> I use tu put :
>=20
> #include "../lib1/lib1.h"
> in project1/project1.c
>=20
> And even if I do not face this problem myself, simlinks do not work s=
o
> well on Windows.

Agreed.

> And Still I realy want to have every project knowing there own
> dependency by themselves and not needing an external superproject to
> tell them what they need.

I want to have that too! I'm just convinced using a gitlink to achieve =
that
is wrong in so many ways. I'd rather prefer to express such dependencie=
s in
something like a config file, and I believe they should not be as stric=
t as
"I need exactly that version" but rather like "this version or newer (a=
nd by
the way: we of course only tested that specific version ;-)". These
dependencies could then be checked and displayed by git status.
