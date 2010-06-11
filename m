From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Question about tracking multiple Subversion repository from
	the same git repository with git-svn
Date: Fri, 11 Jun 2010 21:28:08 +0000
Message-ID: <20100611212808.GB7262@dcvr.yhbt.net>
References: <AANLkTimMOPXecB0lZM3v2MaZgbhJWwtxOUIGgkxr_PGF@mail.gmail.com> <20100610190417.GA15731@dcvr.yhbt.net> <AANLkTim_wx9lQ_IClmajo5etFKay0xPCTz1UrKilGWln@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 23:28:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONBmB-0005Tc-Pm
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 23:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364Ab0FKV2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 17:28:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55748 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932281Ab0FKV2J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 17:28:09 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C711F513;
	Fri, 11 Jun 2010 21:28:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTim_wx9lQ_IClmajo5etFKay0xPCTz1UrKilGWln@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148971>

Daniele Segato <daniele.bilug@gmail.com> wrote:
> On Thu, Jun 10, 2010 at 9:04 PM, Eric Wong <normalperson@yhbt.net> wr=
ote:
> >> 1. Is there a way to tell git that abc/trunk is a branch of svn/ta=
gs/1.2.3 ?
> >
> > You need to use grafts.
>=20
> this one?
> https://git.wiki.kernel.org/index.php/GraftPoint
>=20
> seems what I need..

Yes

> in this case, I had a question:
>=20
> since if I use this feature my commit will have different SHA-1. I
> used to write the commit SHA-1 in some of the svn tags. If I do this
> they will no longer be valid.
> I think with git SVN the "best" way to identify a commit is using the
> "Tree" object SHA-1, it should be the same for every revision that
> contains the same content...
> so..
> 1b. Can I extract the tree sha-1 from a commit?

Yes, "git cat-file commit $commit" will show you the tree.

> 1c. Is there a way to get every commit pointing to to a tree?
>=20
> Ideally I would do something like
>=20
> git contain-tree <sha-1-of-the-tree>
> [list of commit's here]
>=20
> does this make any sense to you?

Sort of, yes...

Back in ancient times, there used to be a "git svn graft-branches"
command which could automate what you're doing.  It was removed in
commit d05d72e07e49869fe988d4d99e6ac60711570db5 because it was largely
unused.

Perhaps you can resurrect it as a standalone command.  I imagine it
could be used for other import utilities, too.

> >> 2. can I rename svn-remote "svn" to something like "main" without =
side effect?
> >
> > You should be able to (and use GIT_SVN_ID=3Dmain in the env),
> > though I haven't used these features in a while.
>=20
> Renamed, thanks.
> do you know if I can set a GIT_SVN_ID (default) per-repository instea=
d
> of using the environment
> variable?

Err, actually, --svn-remote=3Dmain is probably preferred, these days.
GIT_SVN_ID is --id=3Dfoo.  Sorry for the confusion.

> (since I use git-new-workdir it would be best if I can use a default
> per workdir)
>=20
> >> 3. after 2) can I also rename all the names of the remote branches=
 to
> >> main/* instead of svn/* ?
> >
> > It should be possible... =A0you need to edit $GIT_DIR/svn/.metadata=
, too.
>=20
> thanks, did it.
>=20
> >> 7. if the merge --squash cause a lot of conflicts is there a way t=
o
> >> split the conflict resolution across different persons?
> >
> > I'm not sure what you mean... multiple people working on the same
> > working tree? =A0On a shared screen session? =A0I don't see why not=
=2E
>=20
>=20
> no,
> what I had in mind was a "migration team" to work on the migration of
> the customization
> to a product to the new version of the main product.
>=20
> What I have in mind here is some kind of "selective merge".
> For example...
>=20
> I merge a group of commits, someone else, on another computer with
> git-svn or subversion merge another part and so on..
>=20
> like...
>=20
> git merge --squash -- path/to/something
> or something like
>=20
> git merge --squash --interactive
>=20
> this could give you a way to choose different paths you want to "merg=
e".
>=20
> I know this is not very like a merge but I hope I gave you the idea o=
f
> what I meant.

I'll wait for others to answer that.  I rarely encounter conflict-heavy
merges, partly because my workflows are setup to avoid them.

--=20
Eric Wong
