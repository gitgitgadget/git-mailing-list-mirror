From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Newbie grief
Date: Tue, 1 May 2012 07:14:15 -0400
Message-ID: <20120501111415.GD5769@thunk.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org>
 <4F9F3919.6060805@palm.com>
 <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rich Pixley <rich.pixley@palm.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 13:14:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPB2e-0007Cu-BX
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 13:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab2EALOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 07:14:35 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:56056 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab2EALOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 07:14:21 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1SPB2A-0002R6-Ed; Tue, 01 May 2012 11:14:18 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SPB27-0003ms-On; Tue, 01 May 2012 07:14:15 -0400
Content-Disposition: inline
In-Reply-To: <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196678>

On Tue, May 01, 2012 at 09:14:24AM +0530, Sitaram Chamarty wrote:
>=20
> > Multiple heads are the idea that a single commit can "branch" in th=
e
> > repository and that both commits can be HEADS of the same branch at=
 once in
> > a single repository. =A0This allows a potential collision to exist =
in the
> > repository and to be pushed and pulled through multiple repositorie=
s. =A0It
>=20
> That is bizarre; I have no other word for it.
>=20
> I teach git (occasionally), and if this feature existed I would
> totally ignore it in my teaching material because I wouldn't know how
> to defend or explain the need for "hydra branches".

I wouldn't use the verb branch (and certainly not "hydra branch"),
because it's confusing to someone who thinks this has something to do
with noun "branch".  But that's a confusion because of the english, or
rather the terminology that was used.

I would put it this way.  Every non-merge commit has a parent (we'll
ignore merge commits for now).  When you look at that commit via "git
show <commit-id>", what you see is the diff between its parent and the
state of the source tree as described by that commit-id.  If you put
it this way, it becomes obvious that a particular parent commit can
have multiple child commits.  (This seems to be what you are calling
"hydra branches".)

A branch is a pointer to a commit.  When you add a commit to a branch,
you are adding a new commit whose parent is pointing to the current
branch head, and afterwards, the branch head pointer is changed to
point at the new commit.

> Does Hg do this?  That would explain why my (admittedly half-hearted)
> attempts to learn it have failed -- whatever tutorial I used must hav=
e
> been written with the idea that hydra branches are intuitive and
> logical and sane, but did not express the concept as clearly and
> succinctly as you did.

What Hg does is it requires that all terminal commits (commits that do
not have children) must be named by a branch pointer.  So when you
pull in some changes from Hg, there may be a non-terminal commit, but
before the hg pull finishes, it will create a merge commit which
merges the current branch pointer and the newly pulled in commits, so
that when you are done, the branch pointer points at the new merge
commit, and the requirement that there be no non-named terminal
commits is maintained.

Git differs in that you can have a child commit which is not pointed
to by a branch pointer, and which is referred to only by commit-id.
These child commits can disappear on you, when you do a garbage
collection; but it allows you to have multiple child commits hanging
off of a single parent commit, and you can do diffs, cherry picks,
etc.  But they *do* have a unique name --- the commit id, which is a
SHA1 hash of the contents of the diff.

Does this help?

						- Ted
