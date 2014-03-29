From: "Jonas Bang" <email@jonasbang.dk>
Subject: RE: Git feature request: Option to force Git to abort a checkout if working directory is dirty (i.e. disregarding the check for conflicts)
Date: Sat, 29 Mar 2014 12:49:47 +0100
Message-ID: <002001cf4b44$fe3550c0$fa9ff240$@jonasbang.dk>
References: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk> <xmqqk3bfedqi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 12:50:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTrmZ-0000EB-M4
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 12:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbaC2Ltz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Mar 2014 07:49:55 -0400
Received: from mail4.surf-town.net ([212.97.132.44]:50629 "EHLO
	mailgw18.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751415AbaC2Lty convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Mar 2014 07:49:54 -0400
Received: by mailgw18.surf-town.net (Postfix, from userid 65534)
	id 3E2F311B727; Sat, 29 Mar 2014 12:49:52 +0100 (CET)
Received: from localhost (unknown [127.0.0.1])
	by mailgw18.surf-town.net (Postfix) with ESMTP id 266C511B727;
	Sat, 29 Mar 2014 12:49:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mailgw18.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw18.surf-town.net ([127.0.0.1])
	by localhost (mailgw18.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 655g1TxBRuWv; Sat, 29 Mar 2014 12:49:49 +0100 (CET)
Received: from Mainframe (unknown [5.103.38.58])
	(Authenticated sender: email@jonasbang.dk)
	by mailgw18.surf-town.net (Postfix) with ESMTPA id 9B4AD11B73A;
	Sat, 29 Mar 2014 12:49:46 +0100 (CET)
In-Reply-To: <xmqqk3bfedqi.fsf@gitster.dls.corp.google.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQNHwG5eq+VqsEUk7jNiAAPbKL6k0gDp71pIl/+QoHA=
Content-Language: da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245432>

Thanks for your feedback, Junio, I have added more details and tried to=
 simplify the request.

> "Jonas Bang" <email@jonasbang.dk> writes:
>=20
> > Hi Git developers,
> >
> > This is my first Git feature request, I hope it won=E2=80=99t get m=
e hanged on
> > the gallows ;o)
> >
> > *Git feature request:*
> > Add an option to Git config to configure the criteria for when a "g=
it
> > checkout" should abort.
> >
> > *Name proposal and options:*
> > checkout.clean false <default>
> > checkout.clean true
>=20
> A configuration variable without command line override will make the =
system
> unusable.  When thinking about a new feature, please make it a habit =
to first
> add a command line option and then if that option turns out to be use=
ful in
> the real world (not in the imaginary world in which you had such a fe=
ature,
> where even you haven't lived in yet), then think about also adding
> configuration variables to control the default.

Proposal for "git checkout" command line option:
--clean false|true|include-untracked|all

If the 'false' option is used then 'git checkout' will work as today. T=
his should be the default behavior and it is not needed to use this com=
mand line option, nor set the configuration variable. The need for the =
'--clean false' option is if the configuration variable is set to 'true=
', ' include-untracked' or 'all' in global or local config then it is p=
ossible to override this configuration from command line by using '--cl=
ean false'.

If the 'true' option is used then 'git checkout' will abort if the inde=
x or the working tree differs from HEAD.

If the 'include-untracked' option is used then 'git checkout' will abor=
t if there are any untracked files, or if the index or the working tree=
 differs from HEAD.

If the 'all' option is used then 'git checkout' will abort if there are=
 any ignored files added, or if there are any untracked files, or if th=
e index or the working tree differs from HEAD.

Proposal is also to add this as a configuration variable (e.g. checkout=
=2Eclean false|true|include-untracked|all), as the usecase is most rele=
vant for people using 3rd party IDE or GUI which calls the standard "gi=
t checkout" command.

> Also, a useful definition of "clean"-ness may have to change over tim=
e as we
> gain experience with the feature.  And also as a user personally gain=
s
> experience with using Git.  It is somewhat implausible that a boolean
> true/false may remain sufficient.

I have added more options to specify more precisely the definition of "=
clean"-ness.
=20
> > *False behavior:*
>=20
> What is "false"?
>=20
> Ah, when the configuration is set to "false", which will be the defau=
lt?

Yes, exactly, this was what I meant.

> > As is:
> > When doing a checkout then Git will check if your working directory=
 is
> > dirty, and if so check if the checkout will result in any conflicts=
,
> > and if so abort the checkout with a message:
> >
> > $ git checkout some_branch
> > error: Your local changes to the following files would be overwritt=
en
> > by
> > checkout:
> >        some_file
> > Please, commit your changes or stash them before you can switch bra=
nches.
> > Aborting
> >
> > If no conflicts then:
> >
> > $ git checkout some_branch
> > M       some_file
> > M       some_other_file
> > Switched to branch 'some_branch'
> >
> > I.e. it will only abort if there are conflicts.
>=20
> Sensible.  This is the behaviour that is very often depended upon by =
people
> who use Git with multiple branches.  Are you thinking about changing =
it in
> any way when the new configuration is set to "false", or is the above=
 just a
> summary of what happens in the current system?

This was just meant as a summary.

> > *True behavior:*
> > When doing a checkout then Git will check if your working directory=
 is
> > dirty (checking for both modified and added untracked files), and i=
f
> > so abort the checkout with a message:

This will in fact be the 'include-untracked' option where all untracked=
 files are also checked in addition to the index and the working tree.

> > $ git checkout some_branch
> > error: Your working directory is not clean.
> > Please, commit your changes or stash them before you can switch bra=
nches.
> > Aborting
> >
> > I.e. it will abort if working directory is dirty (checking for both
> > modified and added untracked files).
> > I.e. you can only do checkout if you get "nothing to commit, workin=
g
> > directory clean" when running "git status" (ignoring ignored files =
though).
>=20
> The above two say very different things.  For some people, having man=
y
> throw away untracked files is a norm that they do not consider it is =
even
> worth their time to list them in .gitignore and they do not want to b=
e
> reminded in "git status" output, and the latter definition of
> "checkout.clean=3Dtrue will kill checkout when status says there are =
some
> things that could be committed" would suit them, while the former def=
inition
> "checkout.clean=3Dtrue will kill checkout when there is any untracked=
 files"
> would be totally useless.

Regarding those who has many throw away untracked files, they can eithe=
r not change the configuration (i.e. keep the 'git checkout' functional=
ity as it is), or optionally use the 'true' option which only checks th=
e index and the working tree (i.e. not checking on untracked files).

> So I can understand the latter, but I do not see how the former could=
 be a
> useful addition.

By changing my original behavior of 'true', and by adding 'include-untr=
acked' and 'all', I believe I have taken into account the scenarios you=
 describe.

> For some people it is also a norm to keep files that have been modifi=
ed from
> HEAD and/or index without committing for a long time (e.g. earlier, L=
inus said
> that the version in Makefile is updated and kept modified in the work=
ing tree
> long before a new release is committed with that change).  The defaul=
t
> behaviour would cover their use case so your proposal would not hurt =
them,
> but I wonder if there are things you could do to help them as well, p=
erhaps
> by allowing this new configuration to express something like "local c=
hanges in
> these paths are except from this new check".

Yes, those people would probably use the default 'false' behavior as it=
 is already. If they however would like to use e.g. the 'true' or 'incl=
ude-untracked' setting as a configuration variable, then they can use t=
he command line option 'false' if they wish to do a 'git checkout' even=
 with modified files in the working tree.
