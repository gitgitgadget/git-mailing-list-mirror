From: Johan Herland <johan@herland.net>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 08 Jun 2010 23:52:37 +0200
Message-ID: <201006082352.38136.johan@herland.net>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
 <201006080912.31448.johan@herland.net> <4C0E6A8A.70608@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:55:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM6lX-0006N1-Vm
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab0FHVzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 17:55:18 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38887 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab0FHVzR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 17:55:17 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3P005QXU3RUG30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Jun 2010 23:52:39 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3351E1EA53B0_C0EBBA7B	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 21:52:39 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7C2F61EA31F6_C0EBBA6F	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 21:52:38 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3P009B8U3Q4S00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Jun 2010 23:52:38 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C0E6A8A.70608@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148725>

On Tuesday 08 June 2010, Jens Lehmann wrote:
> Am 08.06.2010 09:12, schrieb Johan Herland:
> > - When switching branches in the superrepo, you sometimes also want=
 to
> > switch branches in the submodule. This is signalled by changing the
> > submodules.subthing.branch variable in .gitmodules between the two
> > branches. However, it means that the submodule's update/pull operat=
ion
> > must also be done on 'checkout' in the superrepo.
>=20
> Hm, I always want the submodules to switch branches along with the su=
per-
> project (I posted a RFC patch for that), but i can see other people d=
on't
> want that at all or just for some submodules. But am I wrong assuming
> that it's either "switch branches in submodules too every time" or
> "never do that" for a single submodule?

Well, the good thing is that keeping this config/info in .gitmodules (w=
hich=20
is versioned-controlled along with the rest of the project) enables you=
 to=20
choose one or the other, or anything in between. For example, given a=20
submodule "foo", say I want to keep it on its "master" branch when the=20
super-repo is on _its_ master branch. The .gitmodules file on the super=
-
repo's "master" branch would contain:

    [submodule "foo"]
        path =3D foo
        url =3D git://url/to/foo/upstream
        branch =3D master

Now, if I create a new branch "topic" in the super-repo, the submodule =
would=20
by default keep on tracking its "master" branch. If I want to track ano=
ther=20
branch, called "subtopic", inside "foo", I change .gitmodules on my sup=
er-
repo's "topic" branch to say:

    [submodule "foo"]
        path =3D foo
        url =3D git://url/to/foo/upstream
        branch =3D subtopic

=46inally, if I have a branch "release" in the super-repo, in which I w=
ant to=20
pin submodule "foo" to a specific commit, I change .gitmodules on the s=
uper-
repo's "release" branch to say:

    [submodule "foo"]
        path =3D foo
        url =3D git://url/to/foo/upstream

(i.e. no branch tracking), and then record the appropriate submodule co=
mmit=20
the "old-fashioned" way.

The good thing with =C3=86var's approach is that this is all configurab=
le per=20
branch (indeed, per commit[1]) by editing your .gitmodules file.

> > - When you track submodule branches instead of commits, the actual
> > commit referenced in the superrepo is no longer as important (provi=
ded
> > it's part of the ancestry of the submodule branch you're tracking).
> > However, diff/status will still list the submodule as changed becau=
se
> > you checked out a different commit from what Git has recorded. This
> > raises two concerns: (1) What _should_ be considered "changed" from
> > the diff/status perspective when tracking submodule branches? and (=
2)
> > When do you update the commit reference in the submodule? "never"
> > would work (since you're checking out a different commit anyway),
> > "always" would also work (for the same reason), but would litter th=
e
> > superrepo history with submodule updates. There may be a better
> > alternative somewhere in between.
>=20
> Don't record a commit in the first place, following a branch is not b=
ound
> to a special commit, so pretending to do that might do more harm than
> good. Just putting the 0-hash there might be the solution.

Interesting. Will the object parsing machinery handle that without hicc=
ups?=20
What if an older Git version tries to checkout/update a submodule with =
a 0-
hash?

> > - If you want to give the illusion of "one big repo" then maybe it
> > should also be possible to trigger submodule commits from a superre=
po
> > commit? (i.e. having a single toplevel "git commit" also trigger
> > commits in submodules). Some users will want to specify the commit
> > message for each submodule separately (IMHO the better approach),
> > while some will want to give only one commit message that is reused=
 in
> > every submodule commit.
>=20
> Hm, personally I am fine with first committing in the submodules and =
then
> in the superproject.

Me too, but I suspect that if you draw the "one big repo" approach to i=
ts=20
logical conclusion, there will be some demand for recursive commits.


Have fun! :)

=2E..Johan


[1]: Say your submodule usually tracks a branch, but you're creating so=
me=20
tag in the super-repo, and you want that tag to uniquely identify the=20
submodule. You achieve this by making sure the tagged commit removes th=
e=20
relevant "branch =3D whatever" line from .gitmodules, and records the=20
appropriate submodule version in the super-repo tree. Then, you can rev=
ert=20
the .gitmodules change on the next commit to resume tracking the submod=
ule=20
branch.

Now, whenever you checkout the tag, you will always get the exact same=20
version of the submodule, although the submodule otherwise tracks some=20
branch.


--=20
Johan Herland, <johan@herland.net>
www.herland.net
