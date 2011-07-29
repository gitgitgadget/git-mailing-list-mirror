From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Fri, 29 Jul 2011 11:39:37 +0200
Message-ID: <1311932377.3734.182.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
	 <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
	 <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com>  <4E3192D4.5000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 29 11:36:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmjUl-0006eG-7O
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 11:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab1G2Jgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 05:36:33 -0400
Received: from mailgw1.surf-town.net ([212.97.132.64]:40218 "EHLO
	mailgw14.surf-town.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab1G2Jgc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 05:36:32 -0400
Received: by mailgw14.surf-town.net (Postfix, from userid 65534)
	id 1F84C3E1DE; Fri, 29 Jul 2011 11:36:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw14.surf-town.net (Postfix) with ESMTP id D39423E1DE;
	Fri, 29 Jul 2011 11:36:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw14.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw14.surf-town.net ([127.0.0.1])
	by localhost (mailgw14.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6n4SAzE6B1Zj; Fri, 29 Jul 2011 11:36:24 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-37-200.w92-141.abo.wanadoo.fr [92.141.172.200])
	by mailgw14.surf-town.net (Postfix) with ESMTPSA id 587933E45D;
	Fri, 29 Jul 2011 11:36:19 +0200 (CEST)
In-Reply-To: <4E3192D4.5000504@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178129>

Le jeudi 28 juillet 2011 =C3=A0 18:48 +0200, Jens Lehmann a =C3=A9crit =
:
> Am 28.07.2011 10:57, schrieb henri GEIST:
> > In the current code it was not possible to add a gitlink to a repos=
itory
> > outside of the main repository.
>=20

Of course that is why I have done the patch.

> Me thinks this is a *feature* this patch removes (as I understand it =
it was
> a major design decision that everything /inside/ a directory is contr=
olled
> by git).
>=20

That is still the case.
It is not a matter of disabling any control of git in its own
repository.
It is just a matter of adding inside the git repository a reference
(dependency) to an other git repository.

> > This pach :
> <snip>
> >   - Still forbids to add anything else.
>=20
> Why? If you let submodules live outside the tree I don't see any reas=
on why
> regular files shouldn't live there too (Disclaimer: I d not think tha=
t would
> be a good idea either ;-).
>=20

there is regular file in the submodule repository but they are controle=
d
by the submodule itself. Then the main repository do not need to handle
them.

Just like you I think that regular file should not be touche outside of
the repository by git.
Because in this case it is not just a reference that is managed but the
file itself. And this way there is a risk to overwrite some data not
under revision control outside of the repository.

> What you want looks like this:
>=20
> -+- lib1    #registered as submodule of project1 *and* project2 but n=
ot here
>  +- project1            # submodule of the superproject
>  |  +- ../lib1
>  +- project2            # submodule of the superproject
>     +- ../lib1
>=20

In fact no.
What I want is to have this:

-+- lib1
 +- project1
 +- project2

With :
 - lib1 not knowing anything about projects 1 & 2
 - project1 not knowing anything about project2 and vice et versa
 - project1 knowing that it need lib1 in version N.
 - project2 knowing that it need lib1 in version M.

I know that means a conflict in the required lib version but it is
required by the independence of projects 1 & 2 which do not have to kno=
w
what happen in the other one.

And in fact it is just what I want, it enable me if I decide to work on
an optional "BigProject" depending on both project 1 & 2.

Then If lib1 is in version M:
 - a git status in project2 will say nothing
 - a git status in project1 will say
   "modified:   ../lib1 (modified content)
 - a git status in BigProject will say
   "modified:   ../project1 (modified content)

Then I know that I need to update project1 to work with the last versio=
n
M of lib1.

> You are opening a can of worms by having two different repos point to=
 the same
> submodule living in a third repo (which also happens to be their supe=
rproject
> and must somehow ignore it). You'll have two SHA1s for a single submo=
dule;
> "git submodule foreach --recursive" will have interesting results too=
; and so
> on. Not good.
>=20

As I just said before it is my purpose to do it like that.

If you want to avoid this just put (project1 lib1) and (project2 lib2)
in different places on your hard disk

Let say a concret exemple

3 different teams work on libtiff, libpng, and libjpeg they are totally
unrelated.

One more team is working on the "gimp". And they need those 3 libs in
specific versions not necessarily there heads.

One other unrelated team is working on "gqview" and need the same libs
in other specifics versions (Why should they know what te gimp team
does)

Neither "gimp" and "gqview" project will contain directory with those
libs inside. They just depend on them.

And the last team work on the gnome project which need the "gimp" and
"gqview". It will be this team witch have to care about having both
"gimp" and "gqview" sharing the same libs version>
And has well the gnome project will not contain "gqview" and "gimp" in
its own tree.
It will also depend on them.

It is just the same with aptitude on debian.
Each package know there dependency by themselves, does not contain ther=
e
dependencies, and do not need a bigger superpackage to tell them what
are there own dependencies.

> What about solving that with a "ln -s ../lib1" in "project1" and "pro=
ject2"
> (you seem to need that for your build environment) and adding the sub=
module
> "lib1" to the superproject just like "project1" and "project2"?
>=20

=46or my build environment I do not use simlinks.
I use tu put :

#include "../lib1/lib1.h"
in project1/project1.c

And even if I do not face this problem myself, simlinks do not work so
well on Windows.

And Still I realy want to have every project knowing there own
dependency by themselves and not needing an external superproject to
tell them what they need.

        Henri GEIST
