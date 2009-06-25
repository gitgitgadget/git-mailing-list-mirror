From: Andreas Ericsson <ae@op5.se>
Subject: Re: Parallell Development / Switching to GIT
Date: Thu, 25 Jun 2009 12:11:59 +0200
Message-ID: <4A434D6F.2090105@op5.se>
References: <loom.20090625T095000-90@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Patrick Neuner <neuner@futureweb.at>
X-From: git-owner@vger.kernel.org Thu Jun 25 12:12:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJlwB-0004vc-CF
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbZFYKMB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 06:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbZFYKMB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:12:01 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58179 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751321AbZFYKMA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 06:12:00 -0400
Received: from source ([209.85.220.225]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkNNcvT+lRY3YZ00Cm1kUHp7Z8HYHW0d@postini.com; Thu, 25 Jun 2009 03:12:03 PDT
Received: by mail-fx0-f225.google.com with SMTP id 25so1402744fxm.35
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:12:02 -0700 (PDT)
Received: by 10.86.33.9 with SMTP id g9mr2427847fgg.41.1245924722118;
        Thu, 25 Jun 2009 03:12:02 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d4sm2975653fga.3.2009.06.25.03.12.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:12:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <loom.20090625T095000-90@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122192>

Patrick Neuner wrote:
> Hello,
>=20
> we are using SVN right now and with the way we do / need to develop, =
it seems we
> are constantly get in a merging horror.=20
> I did quite some reading about git now, but I am still not really sur=
e if that
> what we try to accomplish can be done with git,
> Or if we are really doing something a too odd way.=20
>=20

Conflicts will still happen with git, but "merge horror" no longer appl=
ies,
for a couple of reasons (I come from a similar background, but switched=
 to
git in late 2005).
1. In SVN (and CVS), you're merging *unknown changes* into *unsaved sta=
te*.
   You haven't committed your changes to the repository before you merg=
e,
   and you haven't (usually) looked at the upstream changes before you
   try to merge. Git doesn't have this problem (and neither does any ot=
her
   distributed version control system), since you first fetch changes f=
rom
   someone else and then merge them into an already saved state. When a
   merge conflict resolution goes wahoonie-shaped, you can easily resto=
re
   either of the previously saved states with zero hassle.
2. Git has "rerere", which records and reuses previously resolved merge
   conflicts, so you won't get the same merge-conflict more than once, =
if
   you enable rerere.
3. SVN (and CVS) won't remember which changes are already merged in, so
   they will fail horribly at repeated same-branch merges. Git (and oth=
er
   DAG-based scm's) can and do calculate the merge-base for you so you'=
ll
   never have to think about that yourself.

> Let my try to describe =E2=80=93 I also added an image.=20
>=20
> ---- repo 1
>   |
>    - repo 2 (=3Dbranch of repo 1 - for our external developers)
>=20
> We have the main branch and 2nd branch for external developers.=20
>=20
> We work inside the repo1, which are usually features/updates that go =
life after
> a short turn.=20
> Our external developer work on different features that will be merged=
 into repo1
> from time to time.=20
>=20
> Usually during development, we sometimes need to push features from r=
epo1 to
> repo2, and later the features developed on repo2 will be pushed back =
to repo1,=20
> And also smaller bug fixes come from repo2 that needs to go into repo=
1.=20
>=20
> But this is a constant process, meaning, that both branches will exis=
t,
> especially repo2 will exist after this feature has finished for small=
er
> updates/bugfixes.=20
> We don=E2=80=99t want to do a new branch for each bugfix, for each ne=
w small feature,
> but have different branches for different developer teams.=20
>=20
> So I was wondering, if this could cause troubles with GIT in case of =
merging
> around without closing a branch.=20
>=20

Git doesn't take away merge conflicts, but it does make it (a LOT) easi=
er to
handle them when they appear, for the reasons stated above. What you wa=
nt to
do sounds pretty reasonable, although I'd personally use feature-branch=
es
for both internal and external developers, since they make it possible =
to
pick which features and fixes you want to release while allowing develo=
pers
to make as many commits as they feel is necessary for each feature.

> I am adding an link to an image that might show what I tried to expla=
in.=20
> http://temp.in.futureweb.at/parallell-development.png
>=20

We're quite fond of ascii-art here on git@vger. Since I don't know what=
 the
different colors mean in the picture, ascii would probably have made mo=
re
sense (since I then could have commented on it).

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
