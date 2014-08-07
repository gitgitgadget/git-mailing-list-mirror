From: Nico Williams <nico@cryptonector.com>
Subject: Re: Rebase safely (Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 00:11:31 -0500
Message-ID: <20140807051129.GJ23449@localhost>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
 <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
 <53DBBFE8.8060607@gmail.com>
 <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
 <53DBF4C9.2090905@vilain.net>
 <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
 <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
 <96B703A6-58B0-458A-8A2D-699EA8F1941B@comcast.net>
 <20140806194457.GD23449@localhost>
 <A769B84E-42D1-44AC-B0A8-0F4E68AB71FB@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Thu Aug 07 07:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFFzF-0003Ao-KJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 07:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbaHGFLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Aug 2014 01:11:35 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:45389 "EHLO
	homiemail-a24.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932143AbaHGFLc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Aug 2014 01:11:32 -0400
Received: from homiemail-a24.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a24.g.dreamhost.com (Postfix) with ESMTP id 246D82C806E;
	Wed,  6 Aug 2014 22:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to:content-transfer-encoding; s=
	cryptonector.com; bh=/XACosLwuEy9jxcd1QVDpzrgEGs=; b=V0cUlXq+hzS
	ydjoDfy2AYtEbyz1KpkYCeTYd+snw5jLkDDzksYudjC9eBFSXMIJIZmVoEWTTq0L
	7X5G/W2CbcYeQdBswKZ/mdZEeNDtiJDhUcCJ4pq12ecKgz5d5HouSTOMs70Tw70/
	JDZFSObbAqvWXlqFLMf0VAv0OiIiAtj8=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a24.g.dreamhost.com (Postfix) with ESMTPA id D2AEC2C806D;
	Wed,  6 Aug 2014 22:11:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A769B84E-42D1-44AC-B0A8-0F4E68AB71FB@comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254945>

On Wed, Aug 06, 2014 at 05:38:43PM -0700, Mike Stump wrote:
> Oh, wait, maybe I have misunderstood the prohibition.  I have:
>=20
>        upstream  <=E2=80=94=E2=80=94 fsf
>            |
>             \
>              |
>              v
> Me  <=E2=80=94>   master  <=E2=80=94> coworker.

This looks a lot like what I meant about project repos.

> Me is a git clone of master, coworker is a git clone of master.
> Master is a bare repo on a shared server where we put all of our work=
=2E
> upstream is a bare git repo of the fsf git tree for gcc.  fsf is a bo=
x

Yes, exactly.  We did used exactly this at Sun, with a rebase-only
workflow.  You won't believe it till you see it [below].

> owned by other that hosts the gcc git repository.  I do a git pull fs=
f
> in upstream from time to time, and a corresponding git merge fsf in M=
e
> from time to time.  When I like my work I do a git push (to master
> exclusively).  To go to upstream, we submit patches by hand, git is
> not really involved.  I never pull into master from upstream (don=E2=80=
=99t
> even think that=E2=80=99s possible since they are both bare).

I see.  Hey, if that works for you...  You could, of course, merge or
cherry-pick, or rebase your team's commits onto another copy of the FSF
(upstream) master and then send those commits: sending commits is bette=
r
than sending diffs, IMO, mostly because you get to have some metadata
and integrity protection, and because git can ensure lineage and so on.

But you could live purely with diff/patch, no question, and anywhere
between that and making full use of a VCS' powers.

Here now is what we did at Sun, mapped onto git, written as something o=
f
a hardcopy to be more exact.

Remember, this was what we did for _all_ of Solaris.  You can probably
still find docs from the OpenSolaris days describing how to do it with
Mercurial, so you can see I'm not lying.  Thousands of engineers,
working on many discrete projects, with a large OS broken up into a few
"consolidations" (each with its own repo).

(Here the "project gate" is the team repo, that I think you call
"master" above.)

$ # on a bi-weekly (or whatever's best) basis:
$
$ git clone $foo_project_gate foo
$ cd foo
$ git remote add upstream ...
$ git fetch upstream
$ git checkout $current_master
$ new_snapshot=3Dmaster-$(date +%Y-%m-%d)
$ git checkout -b $new_snapshot
$ git rebase upstream/master
$ git push origin $new_snapshot
$
$ mutt -s "PROJECT FOO: Rebase onto new master branch master-$(date +%Y=
-%m-%d)" foo-engineers < /dev/null

Then the engineers on this project do this (at their leisure):

$ old_snapshot=3D<YYYY-mm-dd from current master branch>
$ new_snapshot=3D<YYYY-mm-dd from new master branch>
$ cd $my_foo_project_clone
$ git fetch origin
$ for topic_branch in ...; do
    git checkout -b ${topic_branch%"-${old_snapshot}"}-$new_snapshot
    git rebase --onto master-$new_snapshot master-$old_snapshot
  done
$
$ # Ready to pick up where I left off!
=2E..

Eventually engineers integrate commits into the project gate:

$ # I'm ready to push to the project gate!
$
$ git checkout some_topic_branch
$
$ # Note: no -f!
$ git push origin HEAD:master-$current_snapshot
=2E..
$ # yay

Eventually the project is ready to push its commits upstream:

$ git clone $project_gate foo
$ cd foo
$ git remote add upstream ...
$ git checkout master-$current_snapshot
$ git push upstream HEAD:master

If you're not going to be sending all local commits upstream yet then
you can do an interactive rebase, put the commits you do want to send
immediately after the upstream's HEAD commit, all the others after, and
send just those.  If you do this you should create a new snapshot and
tell your team members to git rebase --onto it.

Note that we're always rebasing _new_ branches.  Never old ones.  The
project gate does plain rebases of those new branches.  Downstreams hav=
e
to rebase --onto to "recover" (it works fine).

This is a very rebase-happy workflow.  It keeps as-yet-not-contributed
commits "on top" relative to the immediate upstream of any repo.  This
makes them easy to identify, and it keeps the author/date/subject
metadata.  Because you rebase often, you don't lag the upstream by much=
=2E
Because they are "on top" it's always fast-forward merge to push --
you're always "merged", with some lag, yes, but merged.  And the person
doing the merging is the owner of the repo (team members, project
gatekeeper).

It's a bit more work each time you rebase than a merge-heavy workflow.
But it's also easier to contribute, and it's easier on each successive
upstream's maintainers.

(The upstream also kept "snapshot" branches.  Doing this has many good
side effects, not the least of which is that git prune (and gc, which I
knew about) doesn't go deleting the past of each rebase.)

> > The only use-case I've seen where a rebase-based workflow doesn't w=
ork
>=20
> Well, and now mine, which I claim is a the canonical open source use
> [...]

Nah.  Sun managed this for decades without a hitch, and for products
much larger than GCC.  See above.

(It's true that it's difficult to sell some people on this workflow,
especially when their previous experiences are with VCSes that look dow=
n
on rebase.  You don't have to buy it either.  However, it works very
well.)

> I=E2=80=99m trying to envision how anyone could ever use rebase.  If =
you
> can=E2=80=99t share your work, it isn=E2=80=99t work.

Do some experiments based on the above hardcopy.  If that doesn't
convince you that it works, oh well, I'll have given it a good try.

Nico
--=20
