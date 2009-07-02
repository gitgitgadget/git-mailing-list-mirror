From: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
Subject: AW: AW: Parallell Development / Switching to GIT
Date: Thu, 2 Jul 2009 02:47:34 +0200
Message-ID: <B81058949321C8439B9D742F5F8D8FCA01A75CFA@hpserver.intranet.local>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local> <20090628184714.GA8634@sigio.peff.net> <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local> <4A487CCD.1040406@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jeff King" <peff@peff.net>, <git@vger.kernel.org>,
	"David Aguilar" <davvid@gmail.com>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jul 02 02:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMASp-0000pi-4s
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 02:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbZGBArh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2009 20:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZGBArg
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 20:47:36 -0400
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:36177 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957AbZGBArf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jul 2009 20:47:35 -0400
Received: from source ([80.109.165.251]) (using TLSv1) by eu1sys200aob109.postini.com ([207.126.147.11]) with SMTP
	ID DSNKSkwDqD52XiOJm33pGZYAhrn1k9cF6/C7@postini.com; Thu, 02 Jul 2009 00:47:38 UTC
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <4A487CCD.1040406@op5.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AW: Parallell Development / Switching to GIT
Thread-Index: Acn4lJS0jXXIf5GAQw+JAHZwojPqYQCF+9Ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122614>

Hello,

thanks for your really helpful and detailled information I got, it help=
ed us a lot to get started.=20
And I got the point of using branches and thinking different about the =
workflow.=20

I stumbled over something I just can't figure out, I kinda feel stupid =
as it must be something really simple, but going up and down docs, just=
 can't figure it out.=20

We use the update-hook to check into which branches pushes are allowed =
per different ssh keys.=20
Now, I wonder how I am able to create branches that are below another b=
ranch.=20

Like=20
Refs/heads/master
Refs/heads/dev
Refs/heads/dev/featureA
Refs/heads/dev/featureB

Instead of
Refs/heads/featureA

Anything I tried either results in an error or creates the branch under=
 /refs/heads/.=20

=46or the update hook this would be helpful as we won't always be able =
to pull from a developer, so they would need to push their feature bran=
ches up to our public one. (as we prefer it this way instead of receivi=
ng patches).=20

I found on following page what we need, so I bet there is a way I just =
couldn't figure out how?
Basically the refs/heads/bw/.* example is what I am seeking, so each de=
veloper can push feature branches up under development.=20
I do understand it's nothing different if the branch is under /refs/hea=
ds, but first it would be cleaner, 2nd access control is better handled=
=2E=20

++
http://www.kernel.org/pub/software/scm/git/docs/howto/update-hook-examp=
le.txt

        refs/heads/master	junio
	+refs/heads/pu		junio
        refs/heads/cogito$	pasky
        refs/heads/bw/.*	linus
        refs/heads/tmp/.*	.*
        refs/tags/v[0-9].*	junio

With this, *Linus can push or create "bw/penguin" or "bw/zebra"
or "bw/panda" branches*, Pasky can do only "cogito", and JC can
do master and pu branches and make versioned tags.  And anybody
can do tmp/blah branches. The '+' sign at the pu record means
that JC can make non-fast-forward pushes on it.
++

Thanks


Patrick=20


-----Urspr=FCngliche Nachricht-----
Von: Andreas Ericsson [mailto:ae@op5.se]=20
Gesendet: Montag, 29. Juni 2009 10:35
An: Patrick Neuner - Futureweb.at
Cc: Jeff King; git@vger.kernel.org
Betreff: Re: AW: Parallell Development / Switching to GIT

Patrick Neuner - Futureweb.at wrote:
> Hi,
>=20
> thanks for your answers, I appreciate that. I read about
> cherry-picking, but I am not quite sure if that's really what we
> need. Lets assume, you do a new feature:
>=20
> /featureX
>=20
> You will commit it, check it out on the testserver and probably see a
> bug, fix it, commit and push it again. (and probably more commits
> after the testing person ran over other issues).
>=20
> With cherry-picking, I would need to know all commits I have to pick.
>  But as there have been serveral commits, so wouldn't it be a pain to
> check all commits to that file or directory to have the same version?
>=20
>=20
> Just trying to find the right way to handle that.
>=20

I can't help but think you're going about this the entirely wrong way.
It sounds as if every developer has to be able to log in to the test
server to try out their stuff, which sounds just plain insane to me
(unless you're developing supercomputer applications, but a company
named "futureweb" probably doesn't do that).

Anyways, the way you *merge* specific features in git is to develop
them on a topic-branch. If you absolutely do not want that (though I
can't think why, since branching is both cheap and easy in git), you
have to resort to cherry-picking. You cannot merge and say "I want
only changes to these and those files" because you'd end up with=20
either a disconnected DAG (meaning git wouldn't know where to merge
from when you want to merge next), or with a connected DAG that
*still* doesn't have all the changes.

In short; Your workflow seems built around the capabilities and
shortcomings of SVN. Git has a different set of capabilities and
shortcomings, so it's natural that some things will feel awkward.
It's like bringing a skateboard to a formula 1 race, really.

With SVN, noone uses feature branches, because merging is a serious
pain. With SVN, every active contributor has commit access to the
central repository, because without it they'd have to juggle patches,
which is boring, and that would hinder them in their work.

With git, a lot of people use feature-branches, because merging is
really easy. With git, there's no real need to let every developer
have write access to the "officially blessed" repository. Instead
it's often useful to have each developer set up his/her own public
repository and then issue "please pull" requests, allowing the
maintainer(s) to fetch their changes, inspect them and then decide
which of the changes to make public. A lot of active git contributors
have their own repositories, and nearly all of the linux subsystem
maintainers have them too. Git also makes it really easy to send
patches by email (and apply such emailed patches). Since git is a
distributed version control system, each developer still gains the
full benefit of using an SCM, while the trusted people act as gate-
keepers for patches that get sent in. But I digress...

>=20
> About the 2nd point - I am not sure if I get the different
> repositories thing. Do you talk about to different clones of the rep,
> and give different directory permissions on it,

I'm sure he is, yes.

> or is there a way to
> have like to completly different git rep's running and still merge
> things over (both ways)?

Yes, there is. That's what happens as soon as you have a public repo
and a local repo, and it's how all distributed version control systems
work. They're both separate repositories, but you can merge til your
heart's content between them, ofcourse.

> I just thought this approach would break
> correct mergin, as it doesn't know where it's comming from.
>=20

bzzt! wrong. You're thinking SVN. Git has a DAG, with each revision
having a unique name, based on its content and all its history, so
separate copies of the same repository can be merged without problem
at all. This is how Linux development happens; The subsystem maintainer=
s
all have their own repositories, and Linus merges from them during each
merge-window. I think there are about 30 "official" Linux repositories
if you count all the subsystem ones. Git was *designed* for scenarios
like that, so it does it very, very well.

> The only thing I ran over so far is probably doing a hook for that
> (like a pre-pull hook if that exists). didn't get to read too much
> about hooks yet, just did the update hook that checks if the user
> with specific ssh key is allowed to push to a specific branch. That
> works pretty good and is more important in fact.
>=20
> But having 2 completly different repos would be another solution, but
> I kinda wonder that mergin would work correctly this way (if both
> sides have changes).
>=20

git help merge-base

In SVN, you need to know exactly which revision you've merged before
in order to once again merge the same branch. Git holds that knowledge
already. Spend some time with gitk after following the git tutorial
and you'll probably get a much better grasp of how the DAG works and
how git uses it.

I'd advise you to clone the linux kernel and inspecting its history
using gitk. Every merge-commit you see which has a line saying somethin=
g
like "merge foo bar frotz of git://example.com/path/to/repo.git" is a
merge with branches from different repositories. I wouldn't be the leas=
t
surprised if you find more than 5000 such merges in the linux kernel
history.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
