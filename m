From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Thu, 06 Mar 2014 23:20:28 +0100
Message-ID: <1394144428.7891.33.camel@Naugrim>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>
	 <1393878866.7891.22.camel@Naugrim> <53176951.7000201@web.de>
	 <1394069128.7891.29.camel@Naugrim> <5318D101.9050305@web.de>
	 <1394136925.7891.31.camel@Naugrim> <5318DFDD.4060006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 23:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLgee-00046r-8B
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 23:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaCFWUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 17:20:36 -0500
Received: from smtpout2.laposte.net ([193.253.67.227]:44406 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaCFWUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 17:20:35 -0500
Received: from [192.168.1.104] ([109.164.199.213])
	by mwinf8504-out with ME
	id aNLU1n0064ckmKR03NLVun; Thu, 06 Mar 2014 23:20:30 +0100
In-Reply-To: <5318DFDD.4060006@web.de>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243566>

Le jeudi 06 mars 2014 =C3=A0 21:51 +0100, Jens Lehmann a =C3=A9crit :
> Am 06.03.2014 21:15, schrieb Henri GEIST:
> > Le jeudi 06 mars 2014 =C3=A0 20:48 +0100, Jens Lehmann a =C3=A9crit=
 :
> >> Am 06.03.2014 02:25, schrieb Henri GEIST:
> >>> Le mercredi 05 mars 2014 =C3=A0 19:13 +0100, Jens Lehmann a =C3=A9=
crit :
> >>>> Am 03.03.2014 21:34, schrieb Henri GEIST:
> >>>>>   - I use an other patch which I plane to send later which enab=
le multiple
> >>>>>     level of superproject to add a gitlink to the same submodul=
e.
> >>>>>     And in this case the superproject containing the separate g=
itdir will be
> >>>>>     arbitrary and depend on the processing order of the
> >>>>>     'git submodule update --recursive' command.
> >>>>
> >>>> I don't understand that. How is that different from using differ=
ent
> >>>> names (and thus different separate gitdirs) for that duplicated
> >>>> submodule? After all, the .git directory is just moved somewhere
> >>>> else in the superproject's work tree, and as the name defaults t=
o
> >>>> the path of the submodule ...
> >>>
> >>> I think I should give an example.
> >>> If I have a hierarchy like this :
> >>>
> >>> superproject/submodule/subsubmodule
> >>>
> >>> What I often do is:
> >>>
> >>> superproject --> submodule --> subsubmodule
> >>>              |                 ^
> >>>              '-----------------'
> >>>
> >>> Where '-->' is a gitlink.
> >>>
> >>>
> >>> That mean .gitmodules and index of the superproject contain both =
submodule and
> >>> submodule/subsubmodule.
> >>
> >> Wow, that shouldn't even work (as everything inside "submodule"
> >> shouldn't be part of the superproject but must be contained in
> >> the submodule itself). Do the "git submodule" script and other
> >> git commands like "git status" work for you in such setups?
> >=20
> > As I stated above it is the purpose of the other patch that I have =
not already send
> > to implement this behavior. And that is why it work.
>=20
> Ok.
>=20
> > Everything including 'git submodule' and 'git status' work perfectl=
y.
> > The intent of this patch is only to permit this for gitlinks. Not f=
or regular files.
>=20
> But I still believe that this shouldn't be permitted at all,
> no matter if files or submodules are concerned. The pitfalls
> files face in such a scenario are pretty much the same for
> submodules too.
>

May be you have a good argument for this belief ?

As for the difference between submodules and regular files
the only difference is in the meaning.
Technically directory are just a special kind of file.
But there day to day use is drastically different of
the use of files which are not directories.
I am not against enabling it for files as well.
I am just unable to imagine a case where it make sens.
A possible solution when someone try to do it is to issue a warning.
"We are not able to see any good reason to do this are sure (y/n) ?"

> >>> and also mean (and that is the point) subsubmodule is a direct 'c=
hild' of both
> >>> superproject and submodule.
> >>
> >> Which I think should not be possible. If that works with current
> >> Git I suspect we have a bug to fix ... or does your other patch
> >> make this work?
> >=20
> > You have no bug on this point without my modification this is not p=
ossible.
>=20
> Glad to hear that.
>=20
> >>> In this case where should the separate gitdir of subsubmodule be =
placed ?
> >>>   - In superproject/modules/submodule/subsubmodule ?
> >>>   - In superproject/submodule/modules/subsubmodule ?
> >>>   - Depending on the 'git submodule update' command order ?
> >>>   - Or both ?
> >>
> >> It should be placed in .git/modules/submodule/modules/subsubmodule
> >> of the superproject (assuming the subsubmodule is part of the firs=
t
> >> level submodule). But in your example that would live in
> >> .git/modules/submodule/subsubmodule (but as mentioned above, I do
> >> not consider this a valid setup because then two repositories woul=
d
> >> be responsible for the data inside subsubmodule, which will lead t=
o
> >> lots of trouble).
> >=20
> > That is why a had proposed an option '--no-separate-git-dir'
> > for 'git submodule <add|update>' then no repository is responsible =
for the data
> > in subsubmodule except subsubmodule itself.
>=20
> As I mentioned in my other email, it doesn't matter at all for
> the setup you're describing if the git directory lives under
> .git/modules of the superproject or in a .git directory in the
> submodule. The problem you're creating with your future patch
> is related to the work tree, not the GIT_DIR: "subsubmodule"
> could also be added to and tracked by "submodule" (as that is
> completely unaware of "subsubmodule" already being tracked by
> the superproject). Then you would end up in real trouble, as
> "superproject" and "submodule" could have differing SHA-1s
> recorded for subsubmodule. Don't go there, for just the same
> reasons we do not allow that for files.
>=20

In fact it mater.
Because multiples checkout of superproject and submodules in versions
where subsubmodule is present and not.
subsubmodule could have been clone one time by submodule and one time
by superproject.
And then if they are cloned with --separate-gitdir subsubmodule can
have two gitdirs in superproject/modules/submodule/subsubmodule and
in superproject/submodule/modules/subsubmodule.
Only one is active at a given time but they are two and not synchronize=
d.

> What is the use case you are trying to solve and why can that
> not be handled by adding "subsubmodule" inside "submodule"?

The problem is access rights.

Imagine you have 2 people Pierre and Paul.
Each with different access write on the server.
Pierre has full access on every things.
Paul has full access on superproject and subsubmodule but no read/write
access to submodule only execution on the directory.

I want all user to get every things they are allowed to have with the
command 'git submodule update --init --recursive'.
Then as Paul can not clone submodule he can not get subsubmodule
recursively through it. And I need superproject to add also
submodule/subsubmodule.
