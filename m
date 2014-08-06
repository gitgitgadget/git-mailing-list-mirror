From: Nico Williams <nico@cryptonector.com>
Subject: Rebase safely (Re: cherry picking and merge)
Date: Wed, 6 Aug 2014 14:44:59 -0500
Message-ID: <20140806194457.GD23449@localhost>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
 <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
 <53DBBFE8.8060607@gmail.com>
 <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
 <53DBF4C9.2090905@vilain.net>
 <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
 <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
 <96B703A6-58B0-458A-8A2D-699EA8F1941B@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git discussion list <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 21:45:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF792-0003Vs-ER
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 21:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbaHFTpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 15:45:01 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:59852 "EHLO
	homiemail-a35.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752486AbaHFTpA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 15:45:00 -0400
Received: from homiemail-a35.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a35.g.dreamhost.com (Postfix) with ESMTP id 2030154075;
	Wed,  6 Aug 2014 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to:content-transfer-encoding; s=
	cryptonector.com; bh=9BzKQYsVP7hik4+f1TN3b01B19M=; b=VVb61QvYWrk
	jKpeUVrLkO02YoPiv1Gfsa3MGkrgISGvsxgNKKcjwPcnP3/c/QSw9svbC/0jwx9K
	P5FeklI0Q3tvgj/Hlf7IwTzvPlVvsCIj8n4ltKdPo8TeUSNVh44Y13dxxAircbTs
	WjZxZjjA/c5QBAPn3BIB51f/F0pA4Z4g=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a35.g.dreamhost.com (Postfix) with ESMTPA id 9A29A54073;
	Wed,  6 Aug 2014 12:44:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <96B703A6-58B0-458A-8A2D-699EA8F1941B@comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254895>

On Wed, Aug 06, 2014 at 12:11:16PM -0700, Mike Stump wrote:
> On Aug 1, 2014, at 4:40 PM, Nico Williams <nico@cryptonector.com> wro=
te:
> > As for rebase, I still don't understand why it doesn't work for you=
=2E
>=20
> http://git-scm.com/docs/git-rebase says:
>=20
>   Rebasing (or any other form of rewriting) a branch that others have
>   based work on is a bad idea
>=20
> If you read stack-overflow, you will discover a ton of people that
> like doing this, and they get hammered because of it.  My use case
> fits exactly (as near as I can tell) the hammer case.

It's not a good idea to rebase a branch in a repo that others pull from=
=2E

There's nothing wrong with rebasing your patches on that same branch in
your clone as long as the end result is a fast forward merge when you
push.

    $ git clone https://..../blah
    $ cd blah
    $ <do some work>
    $ git commit ...
    $ git fetch origin
--->$ git rebase origin/master
    $ git push origin master

There's NOTHING wrong with that rebase.  It's perfectly safe because
it's only in your *private* clone.

(If later you publish that clone and expect people to track your master
branch, then rebase becomes problematic, but that's not something most
people ever do with their clones.)

The only use-case I've seen where a rebase-based workflow doesn't work
is where you have multiple upstreams that you're following.  I.e., the
upstream forked and you want to take some commits from one, some from
the other, or otherwise keep a merge of both.

(Also, if an upstream is ever rebased you can usually recover on the
downstream side by rebasing with the --onto option, so it's not the end
of the world.)

> Now, I found the stack-overflow commentary first, and all the horrors
> of it, and all the nuances.  I carefully read what people were doing,
> how what I wanted to related to what they were doing, and it sure fel=
t
> like I was in the, don=E2=80=99t go there camp.

A lot of people rant about rebase.  They're wrong.  They've distorted
your perspective.

> So, I like to know if I=E2=80=99m driving off a cliff, before I do.  =
I=E2=80=99m the
> [...]

There's just two simple rules to follow and you'll be safe:

1) NEVER git push -f (--force) to a "published" repo/branch.

   The upstream should enforce this with a receive hook.

2) NEVER work directly in a published repo.  Instead work in a private
   clone.  To help make sure of this, never publish a non-bare repo
   (bare =3D=3D has no workspace; non-bare =3D=3D has a workspace).

If you ever do a rebase that produces results you're unhappy with you
can undo that rebase like so:

 - use git reflog to find the branch's previous HEAD commit
 - reset the branch to point to that commit

It really helps to think of git as a pile of commits arranged in a
Merkle has tree.  Branches and tags are just symbolic names for specifi=
c
commits.  Rebase builds a new line of commits in the tree then it
changes the symbolic branch name's HEAD to point to the head of that ne=
w
line of commits, BUT NOTHING IS LOST in the pile of commits that is the
repo, not until you git-prune(1) to remove commits not reachable from
symbolic names (branches and tags).

> > The only case where I can imagine not using a
> > rebase-heavy workflow is where I have to track multiple forked
> > upstreams and so I want to merge each into my branch.
>=20
> So, sounds like I fit that use case and rebase could be my friend.

Excellent.

> How do I square what you said and:
>=20
>   Rebasing (or any other form of rewriting) a branch that others have
>   based work on is a bad idea
>=20
> ?

See above.

> I want all old refs in old emails to work.  I want all refs in

They will if you stick to the two rules I mention above.

> bugzilla to work.  I want to see the original dates of all the work.

Ditto.

> I want git blame to report those artifacts in email and bugzilla.  I
> have coworkers that I push to, pull from (through a single sharing
> point, we call the master tree).  We work on gcc, we pull git gcc dow=
n
> to a local copy, then merge it into our tree.  I want to cherry pick
> changes from upstream.  I do work and push to our master, I pull work
> of coworkers from the master, my coworkers do the same.  Isn=E2=80=99=
t this
> the canonical open source use case?

That means that you have/maintain an intermediate upstream, yes?

This is a bit trickier since once in a while that intermediate upstream
and everyone downstream of it has to catch up with the real upstream.

Here you have two options:

 - the intermediate diverges from the real upstream, and then you
   merge/cherry-pick from the upstream as needed
  =20
   The intermediate's maintainer must still merge/rebase/cherry-pick
   from the intermediate branch and onto a branch of the upstream in
   order to push to the upstream.

or

 - the intermediate occasionally rebases onto the upstream, and then th=
e
   repos downstream of the intermediate must also rebase with --onto.

   In this case the intermediate's maintainer must tell the downstreams
   what rebase command to execute.

   This makes it easier to push from the intermediate to the upstream:
   the intermediate's commits should always be on top of the upstream
   (at rebase time) so it's easy to push them.

The latter is the workflow we used at Sun for decades for large
projects.  We followed that workflow long before git, first with
Teamware, then later with Mercurial (even though Mercurial technically
had no support for rebasing at that time; we just made it work).

(We always left symbolic names for the pre-rebase branch HEADs, mind
you, to make life easier for everyone.)

> > (I find that many users are allergic to rebasing.  Many people have
> > told me that rebase is lying, that history must be immutable, and s=
o
> > on, all ignoring that: git users don't rebase published branches,
>=20
> So, when I push, and someone else pulls, is that published?  I though=
t
> it was.

Yes.  You shouldn't push -f.  As long as you don't there's no problem.

Nico
--=20
