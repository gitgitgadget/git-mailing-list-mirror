From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 01 Aug 2011 21:39:51 +0200
Message-ID: <4E370107.3050002@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>  <7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>  <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>  <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>  <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com>  <1311843465.3734.40.camel@Naugrim.eriador.com>  <4E3192D4.5000504@web.de>  <1311932377.3734.182.camel@Naugrim.eriador.com>  <4E34122B.5020509@web.de> <1312062927.3261.334.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 21:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnyLO-0005Re-Vb
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 21:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab1HATkB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 15:40:01 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47381 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab1HATjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 15:39:54 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8CFAD19644AD6;
	Mon,  1 Aug 2011 21:39:52 +0200 (CEST)
Received: from [91.48.110.244] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QnyL9-0002zo-00; Mon, 01 Aug 2011 21:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1312062927.3261.334.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/nxvNrAaV7GZPTGGDB0T+vQlZLR4+ixJURmde9
	MRLqmy/vayxm5HG9NyLIOwwZWGL++DFNLN9/KqJB7glJ+1tglk
	0CJxSDbVQLBXTuWfzwjw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178403>

Am 30.07.2011 23:55, schrieb henri GEIST:
> Le samedi 30 juillet 2011 =C3=A0 16:16 +0200, Jens Lehmann a =C3=A9cr=
it :
>> Am 29.07.2011 11:39, schrieb henri GEIST:
>>> Le jeudi 28 juillet 2011 =C3=A0 18:48 +0200, Jens Lehmann a =C3=A9c=
rit :
>>>> Am 28.07.2011 10:57, schrieb henri GEIST:
>>>
>>> It is not a matter of disabling any control of git in its own
>>> repository.
>>> It is just a matter of adding inside the git repository a reference
>>> (dependency) to an other git repository.
>>
>> ... which you want to have *outside* of the containing repository!
>=20
> yes
>=20
>> That will then be registered in other git repositories too in your m=
odel,
>> which gets rid of the "one file/submodule, one repo" assumption we n=
ow have
>> and will introduce ambiguities which are *really* hard to handle.
>=20
> I am sorry, I am not a native English speaker. This sentence is to
> complex for me. And google translator is of no help in this case.

Your proposal of letting multiple gitlinks in different repos point to =
the
same submodule will break the assumption that each file is only handled=
 by
a single git repo. For example when you have a conflict and do a "git
submodule update --recursive" in the superproject, the SHA1 used for "l=
ib"
will depend on the alphabetical order of "project1" and "project2". And
normally after running "git submodule update --recursive" you expect al=
l
submodules of the superproject to be clean. But your change breaks this
expectation, it will still contain unclean submodule entries even thoug=
h
you just told git it should clean them. What will a "git submodule sync
--recursive" do when "project1" and "project2" use different urls in th=
eir
=2Egitmodules? And so on.

Commands won't always behave like you expect them to and sometimes will
give different results just because different names are used. That's wh=
at
I meant with ambiguities and that's why I don't think gitlinks are the
right method here.

> But I agree the step is really weak before enabling to put any regula=
r
> file outside of the directory.
> I do not see any reasonable workflow (to my eyes) for it but' maybe s=
ome
> day someone will came with a justifiable workflow which need it. we w=
ill
> never know.
>=20
> But in this case we need solve some questions :
>   - Will we extend git status signaling untracked files out of the
>     repository ?

I don't think that would work well.

>   - What will do git-clean ? it is already dangerous inside the
>     repository. and it will be worst if it can access outside of it.

Hopefully git clean will learn the --recurse-submodules option in the n=
ot
too distant future, then you will have just the same danger for the fil=
es
inside a submodule.

>>> Because in this case it is not just a reference that is managed but=
 the
>>> file itself. And this way there is a risk to overwrite some data no=
t
>>> under revision control outside of the repository.
>>
>> You have the same risk when a gitlink points outside, as a submodule=
 is a
>> way of controlling a bunch of files through that reference. And the =
file
>> would be under version control in the repository where it is registe=
red, no?
>=20
> I agree on this point.
>=20
> But they are still confined in an another git repository not
> disseminated all over the file system.
> And it never corrupt this pointed repository. just ask it to do by it=
's
> own regular git commands.

The only difference here is that a submodule can contain more than one =
file,
but you can corrupt those files just as easily as a single file using g=
it
commands.

> In fact you can argue that it can disseminate some complete git
> repository anywhere in the file system.
> And you will be right. (nothing is perfect.)

I'm not concerned about not being perfect (nothing is perfect), but it =
is
dangerous.

> I can do a second patch to prevent git submodule command to make clon=
es
> outside of the repository.
> It will requires the user to do those clones manually.
> In fact this is already what I do.
> My only use of this is to track dependencies.

But gitlinks are more than simple dependencies, they are followed! "git
submodule", status, diff and fetch already follow them. push is learnin=
g
that right now. checkout, reset, merge and friends are being taught tha=
t
too (see the enhance_submodule branch in my github repo for the current
state). So a gitlink is more than just a simple reference, it is follow=
ed
by a lot of commands and the submodule it points to is manipulated by
those commands. We had a patch for "git archive --recurse-submodules" o=
n
the list, what will that do when used in "project1"?

>>> And in fact it is just what I want, it enable me if I decide to wor=
k on
>>> an optional "BigProject" depending on both project 1 & 2.
>>>
>>> Then If lib1 is in version M:
>>>  - a git status in project2 will say nothing
>>>  - a git status in project1 will say
>>>    "modified:   ../lib1 (modified content)
>>>  - a git status in BigProject will say
>>>    "modified:   ../project1 (modified content)
>>>
>>> Then I know that I need to update project1 to work with the last ve=
rsion
>>> M of lib1.
>>
>> Maybe no update for project1 is needed, because M only contains a bu=
gfix
>> which doesn't even need a recompilation of project1. But now you nee=
d to
>> add a commit to project1 nonetheless with a message like "Updated li=
b1
>> with a bugfix which is needed by project2" which makes your idea of
>> independent submodules break down.
>=20
> In fact I work ni the world of "high integrity programming" then It i=
s
> just what I need.
> If there is a bugfix in any library, used by the program it is no mor=
e
> the same program.
> I need the "SHA1" to correspond to the exact and complete source code
> involved in my executable.
>=20
> And this way the "SHA1" of the project sign the "SHA1" of the
> libraries.=20

I cannot believe you want single commits in your "Gimp" repo for every
combination of distributions and library versions where someone said
"this works". This is insane and won't scale at all.

What you do is that each distribution tests their combination of progra=
ms
and libraries and says "that works". And that is why the only sane way =
to
record this "high integrity programming" test result is in the superpro=
ject
(=3D distribution) and not in each of the program repositories.

I also see that it would be cool when a program could record "I do work=
 with
that library version, if you use another you are on your own". But it w=
ill
never say "I only work with *this* specific library version", which is =
what
your proposal is trying to do.

>>>> You are opening a can of worms by having two different repos point=
 to the same
>>>> submodule living in a third repo (which also happens to be their s=
uperproject
>>>> and must somehow ignore it). You'll have two SHA1s for a single su=
bmodule;
>>>> "git submodule foreach --recursive" will have interesting results =
too; and so
>>>> on. Not good.
>>>
>>> As I just said before it is my purpose to do it like that.
>>
>> I understood that, but what are you proposing to do to solve all the
>> problems your approach introduces? You can't just hand wave them awa=
y.
>=20
> There is some solutions :
>=20
>   - First it is one more **feature** if it does not correspond to you=
r
>     work flow it does not prevent you to work exactly the way you did
>     until now.
>=20
>   - Second if you want to use the feature but not want to have the
>     conflict **feature** (for me it is one), just put the independent
>     project with there libs in different directory
>=20
>       -+- foo -+- lib1     (in version N)
>        |       +- project1
>        |
>        +- bar -+- lib1     (in version M)
>                +- project2
>=20
>   - Third if you really need to have project 1 & 2 in the same
>     directory foo, that means they are needed by a third BigProject i=
n
>     the same directory foo depending on project 1 & 2.
>     And then you really need git to declare a conflict.

No you don't. You just need to git to tell you: this is not the version=
 I
was tested against, repeat the tests to be sure.

>>> Let say a concret exemple
>>>
>>> 3 different teams work on libtiff, libpng, and libjpeg they are tot=
ally
>>> unrelated.
>>>
>>> One more team is working on the "gimp". And they need those 3 libs =
in
>>> specific versions not necessarily there heads.
>>>
>>> One other unrelated team is working on "gqview" and need the same l=
ibs
>>> in other specifics versions (Why should they know what te gimp team
>>> does)
>>>
>>> Neither "gimp" and "gqview" project will contain directory with tho=
se
>>> libs inside. They just depend on them.
>>>
>>> And the last team work on the gnome project which need the "gimp" a=
nd
>>> "gqview". It will be this team witch have to care about having both
>>> "gimp" and "gqview" sharing the same libs version>
>>> And has well the gnome project will not contain "gqview" and "gimp"=
 in
>>> its own tree.
>>> It will also depend on them.
>>
>> Cool, that is a real life example resembling what we have a my dayjo=
b. But
>> a "gimp" and "gqview" project will only have dependencies like "use =
libpng
>> of version 1.2.3 or newer (because we need a feature/bugfix introduc=
ed
>> there)" and won't be tied to a special version of that library. This=
 means
>> they need a dependency like "SHA1 or newer" instead of "exactly this=
 SHA1".
>=20
> It is useful and simpler to work like this but could introduce some
> bugs.

But that model is awfully successful and is used by all distributions I=
 know,
so I suspect it is not that dangerous (especially when you do your own =
QA).

> The "gimp" team has tested it with libpng 1.2.3 and maybe know that i=
t
> did not work with previous versions but if they do not have any cryst=
al
> ball they never know if newer versions will not break something.
> In fact I doubt that the first version of gimp will work with the las=
t
> version of libpng.

But in the real world it is exactly like that: gimp will work with all =
libpng
1.2.3 and newer, only when libpng is updated to 2.0.0 you have to check=
 that
again. Of course there will be bugs in some combinations. But the advan=
tage of
being able to then only fix libpng and have the bug fixed in Gimp witho=
ut
having to change it is far greater than the possible problem you are de=
scribing
here.

>>> It is just the same with aptitude on debian.
>>> Each package know there dependency by themselves, does not contain =
there
>>> dependencies, and do not need a bigger superpackage to tell them wh=
at
>>> are there own dependencies.
>>
>> And this is a very good point for the "version x.yy-z *or newer*" ar=
gument,
>> they are /never/ tied to the /exact/ x.yy-z version, as that would m=
ake the
>> dependencies pretty much unusable. They use a "newer than x.yy-z" sc=
heme.
>=20
> It is an other feature that the one I need.
> But it is a good idea.
>=20
> Nothing prevent us to make a patch to add a new test in git status to
> see if the current SHA1 in the libpng repository has the SHA1 of the
> gitlink in the gimp in its ancestor.

To make that feature useful for others (e.g. at my dayjob) this would b=
e
necessary. And we would never want the exact SHA1 match, even though th=
at
information might be what others (like you) want.

>>> And Still I realy want to have every project knowing there own
>>> dependency by themselves and not needing an external superproject t=
o
>>> tell them what they need.
>>
>> I want to have that too! I'm just convinced using a gitlink to achie=
ve that
>> is wrong in so many ways. I'd rather prefer to express such dependen=
cies in
>> something like a config file, and I believe they should not be as st=
rict as
>> "I need exactly that version" but rather like "this version or newer=
 (and by
>> the way: we of course only tested that specific version ;-)". These
>> dependencies could then be checked and displayed by git status.
>=20
> It effectively could be in a config file it seem good to me as well.

Ok.

> But if git handle this config file.
> Update it on a "git add ../libpng && git commit"

I'm not sure an automatic update at "git commit" would be the right thi=
ng to
do, as I think that should only happen after all tests have run success=
ful,
not at the time you commit it. But anyways, that could be done with a p=
ost
commit hook. Or the test script can do it when it succeeded.

> And control the matching between the project and libraries on
> "git status">

An extension to "git status" to display the dependencies that aren't me=
t is
a valid goal. What about starting with a script ("git depends"?) and th=
en see
what can go into status?

> I can not see the difference with a gitlink.

Then you can just use a config file for that, no? ;-)
