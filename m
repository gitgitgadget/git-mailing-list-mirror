From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: GSoC proposal for svn remote helper
Date: Fri, 8 Apr 2011 14:47:58 +0600
Message-ID: <BANLkTinWtqNYvZP2yamx831_U9KHZ4x3qA@mail.gmail.com>
References: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com>
	<BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com>
	<20110408052126.GA22256@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, artagnon@gmail.com, david.barr@cordelta.com,
	srabbelier@gmail.com, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 10:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q87MR-0002gX-0l
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 10:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab1DHIsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 04:48:04 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55513 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1DHIsB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 04:48:01 -0400
Received: by ewy4 with SMTP id 4so1035432ewy.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wwpzXygKdvk4Ne0Lbkz4ZLAmK75pNHh/IHAluGJhFVo=;
        b=kEGOUQNmj+Kzwc7vUE1nPlBVhZ1lzyVZfUb0XkKxeAARhXnOhiv2ZjL18nRN3tMxaw
         WaraQy8Mcy8cWZUm9FUKzs7h9HktmOer6UIWoeUfO6w85GQBq993QaO0hvGH4Hpaz7/b
         /e/kq0CkbwXO8+TlNYiD9yl5YiTRR3prJz8ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IdLX2iK2xDEB1UiH5GE7TqhhrotCtNIjq4gVsYVkUKeJfCY2Esm/bAXKBFITRJz/TQ
         Y1EJgyojChBQXYFNlHymo3eN1WtJL64G21w+axL8iDsy9lSMUJHeeIl8eLODh9yGqPSA
         X1gq9oOD5GLhm3lCqrsLl7JNpFqImQZiaVwCQ=
Received: by 10.14.124.200 with SMTP id x48mr856308eeh.237.1302252478221; Fri,
 08 Apr 2011 01:47:58 -0700 (PDT)
Received: by 10.14.37.10 with HTTP; Fri, 8 Apr 2011 01:47:58 -0700 (PDT)
In-Reply-To: <20110408052126.GA22256@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171116>

On Fri, Apr 8, 2011 at 11:21 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> (+cc: Eric who brought us git-svn)
> Hi Dmitry,
>
> Dmitry Ivankov wrote:
>
>> This is the second iteration of my GSoC proposal
>
> Great; let's iron this out.
>
>> I would like to work on "Remote helper for Subversion and git-svn".
>> My major motivation is to make git-svn repository easy to clone, and=
 to make
>> git-svn (fetch) faster on huge repositories.
>
> So, my new first impression is that this goal might make things hard[=
1].
>
> I think replacing git-svn with an imperfect emulation would not leave
> people happy. =A0Existing configurations need to continue to work.
I should have used different names for current git-svn.perl and what
should be tracking svn repo in git somewhat better than git-svn.perl.
Maybe call it git-svn-ng. It should definitely support common
workflows, but I think that it should not be too close in
configuration and behavior details. git-svn.perl is a personal setup
and I doubt someone shares it somehow, so transition won't be hard. My
focus is on git-svn-ng core operations - fast fetch, push, ability to
clone at least upstream svn state from another git repo, and I see way
to a complete replacement as follows:
1) introductory step, nothing new compared to git-svn.perl, but
expected to be already faster on allowed operations
git clone svn::/svnroot (svnroot can be a path in local or remote
repo, this is already supported by svn layers)
=2E.hack..
git svn dcommit or like - put changes to the remote

2) allow private clones, that is be able to exchange svn updates or do
initial clone via git
git clone /somewhere/git_ro_version_of_svn.git (maybe some additional
command/key to get svn metadata)
git remote add upstream svn://svnroot (git remote update should be as
quick as on origin)
=2E.hack..
git svn dcommit

3) allow tracking of a path, something like, intermediate,
functionally the same or slightly different in corner cases
git remote add svn svn:://svnroot/ (it's still a good idea to have
whole root specified)
git svn branch trunk svn/trunk@12 (at first it'll be ok to behave like
as if root is svnroot/trunk, just a new syntax)

4) follow tracked path, create branches
git remote add svn svn:://svnroot/
git svn branch trunk svn/trunk@12
git svn branch trunk svn/branches/stable@14
git remote update
git merge-base svn/trunk svn/branches/stable
#for example svn/trunk@13
git remote update
#got svn/trunk@23 -> svn/branches/fixups (maybe if option discover is
set; here we need the root to check that the destination is ok)
git svn branch trunk svn/branches/old@13 (if somehow it wasn't discover=
ed)
git remote update (maybe, if we store whole root history, will be fast)
and also create svn branches with git, ugly way is to:
git checkout svnroot
cp -r trunk branches/experimental
git add branches/experimental
git commit && git svn dcommit
or maybe:
git svn branch trunk svn/branches/experimental
git checkout svn/branches/experimental
git commit --allow-empty -m "create new branch"
git svn dcommit

These four imho are fine as a minimal functionality - one can use it
for git-svn.perl replacement if perfomance and clones are more
important than heuristics and easy of use.

5) tweak 3-4), allow tracking branches, sharing branches, committing
merges, and a lot more, see below for an idea of getting rid of
rebase.

Uh, that became a long story, anyway, I clearly see that there is
git-svn.perl which can do git<->svn interaction quite comfortable for
users, there is almost ready faster git<->svn transport, there are
already a bunch remote-helpers available on the good side, and on the
bad it's currently hard to get even initial clone. So I consider it
quite possible for a GSoC project to get a kind git-svn-ng that is
cloneable, faster than git-svn.perl, and hopefully doesn't involve
deep understanding and patching git-svn.perl. All this with the idea
of extending it to handle git workflows between two git-svn-ng clones
and a svn repo, or just better git workflows inside one git-svn-ng.

>
>> Project Goals:
>> + * Design and create fully functional prototype of new git-svn whic=
h is
>> cloneable and quite fast.
>
> *If* one does not have this goal ("new git-svn") then there is a
> chance to move past some of git-svn's limitations[2].
I'll write inline in [2]
>
> All that said, these tools could be used to speed up git-svn.
>
>> By fully functional I mean that it'll be
>> able to fetch, push, etc. but probably won't have automatic tags and
>> branches discovery and like, but will allow it to be implemented on
>> top. Oh, it just hit me that given a path (read trunk) to track and =
a
>> svndump it looks trivial to discover all it's branches - just seek f=
or
>> copies.
>
> As mentioned before, this sounds very ambitious. =A0Once we have a
> timeline showing how this breaks down into small steps it should
> hopefully be clearer way.
Ok, I'll try to break it into some steps.
>
>> + * Get all the needed core git changes merged.
>
> The following is probably controversial. =A0It's my opinion only.
>
> Since you can't control what other people do, I don't think it's righ=
t
> to judge your project's success or failure based on whether it gets
> merged. =A0Put another way, the product of your work that can be judg=
ed
> is not whatever fraction gets accepted in git.git by the end of the
> summer[3].
That means one can't blame them if it's not merged, but also git is a
mentor and that'd be strange to choose a goal like "write a thing I'll
use myself" :)

> So I think the goal is whatever it is (a working and suitable "git
> clone svn://foo" command, say) and getting feedback by pushing change=
s
> upstream and responding to it is a part of how that happens.
That makes a great sense to keep both things in mind, yes :)
>
> At some point there will probably be a point of no return --- "if the
> design of this patch is not right, I would have to rewrite everything
> on top of a redesign of it". =A0I'd encourage getting input on such
> patches _very_ early and working hard to get them merged at least to
> "next" (i.e., to have a rough consensus that they are suitable modulo
> small tweaks). =A0I would love it if the proposal included a timeline
> pointing out some examples of this.
>
>> Some of these exist already and
>> only need help with polishing, reviewing and merging.
>
> Do you mean support for parsing "svnadmin dump --deltas" output? =A0I=
t
> is already polished and reviewed; it's only sitting out-of-tree for
> now because it makes the commandline usage awkward and it would be
> nice to merge some improvements to that at the same time.
Yep, help in whatever way I can with this one and also I saw helpers
branches introducing new remote-helpers commands or extending existing
core functions. I hope all the needed core changes will quickly popup
on early stages.
>
>> + * Make the prototype as close to being merged as possible.
>
> That's kind of vague, you know. :)
Yep, but I don't know any good metric for this :)
>
>> Milestones for prototype functionality:
> [list of features snipped]
>
> Could you say something about how you would go about implementing
> these?
>
> Sorry for the ramble, and thanks for working on this.
No problem absolutely, thank you for feedback, I like the challenges.
>
> Ciao,
> Jonathan
>
> [1] git-svn.perl is a work of art and a wonder to behold, and if your=
 aim
> is to make a compatible replacement for it, the first step will be to
> understand its design deeply. =A0And the thing is, that much, while
> valuable anyway, is pretty hard already.
[skipped git-svn.perl heuristics]
> and people rely a lot on an odd coincidence:
>
> =A0- using "git svn clone" twice with the same configuration on the s=
ame
> =A0 repository will, at least most of the time, give the same commit
> =A0 names.
I want this to happen always wherever two clone & fetch sequences
reach the same remote revision.

>
> [2] Well, it mostly comes down to one limitation. =A0To give a quick
> sketch:
>
> If I clone a repository with "git svn", then I am in a way a
> second-class citizen. =A0The history shown with "git log" is filled
> with "git-svn-id:" lines that are not very interesting to me (the
> revision number is still interesting, of course).
As already mentioned I didn't mean exact emulation of git-svn.
Ideally I'd like git commit object to include only immutable svn data,
and even more it should be the same after a round trip to the svn repo
and back.

>=A0I cannot use
> "git push" to push my work, and in fact I cannot push my work as a
> branch reflecting the real development history at all --- I have to
> rebase it at the same time as pushing. =A0Whenever I push, the commit
> names for my work change, so other branches based on my work don't
> show up in "gitk" as based on my work any more.
>
> Wouldn't it be nicer to be able to do
>
> =A0alice$ git clone svn::http://svn.apache.org/repos/asf/subversion
> =A0alice$ cd subversion
> =A0alice$ ... hack hack hack ...
>
> =A0bob$ git clone 'alice:~/src/subversion'
> =A0bob$ cd subversion
> =A0bob$ ... hack hack hack ...; =A0 # make some changes on top of ali=
ce's work
>
> =A0alice$ git fetch origin; # anything new upstream?
> =A0alice$ git push origin; # push my changes upstream
>
> =A0bob$ git remote add upstream svn::http://svn.apache.org/repos/asf/=
subversion
> =A0bob$ git fetch upstream
> =A0bob$ # push my changes on top of alice's (which were already pushe=
d):
> =A0bob$ git push upstream
>
> That is the dream. =A0Because there is not a clearly appropriate
> one-to-one mapping between possible svn histories and possible git
> histories, there are going to have to be limitations[1], but that is
> an ideal to strive for.
I have an idea for it, quite raw, but could work.
We are limited by svn:
- commit isn't a push, it's rebase & push. So we don't control the pare=
nt ref.
- there are no branches in svn. There are paths, but we can convert
them to branches of another paths.
- there are no merges in svn. That's a trouble, but maybe we can try
to use svn:mergeinfo to create and read multiple parent refs.
- we definitely want to keep everything needed inside svn, or we are
sure to diverge in different clones sometime.

So what we do:
- get rid of svn revision: just have path@rev -> sha1 mapping
separately, of course history of path@rev should look like the history
of sha1
- learn to create and fetch back merge commits: try svn:mergeinfo
- be sure to control the parents: don't let svn to commit on top of
something different from git parent:
-- if path wasn't changed in the repo while we were hacking, commit it
and it'll come back as the same sha1
-- if it was, create a svn branch of our parent, commit there, and
then create a merge commit of these two, commit it and get same merge
history back
-- and if we are commiting a merge, create/commit to branches as necess=
ary

Not perfect, but it hardly can be cleaner to emulate git history in
svn, and get it back unchanged. And it should be optional too, not all
svn commits need this.

> Sounds hard, maybe? =A0Yeah, it is, but getting at least fetch suppor=
t
> using the tools David and Ram made sounds easier to me than a fully
> compatible replacement for git-svn.
>
> [3] Meanwhile, just writing and publishing code is not enough, since
> the code might have a fatal flaw that means no one will use it ("ivor=
y
> tour syndrome"). =A0So what do I mean by the above?
>
> As students work, I hope they will keep the mailing list posted on
> their progress and find small pieces to review and merge early. =A0In
> response they might get some questions and suggestions for
> improvement; the response to these is just as important as the code.
>
> On one hand this feedback is an important sanity check on the broad
> features of your work and a means to get the details right for
> inclusion in git (i.e., get it merged). =A0On the other hand, one sho=
uld
> not be tempted by interesting side tracks and avoid getting the actua=
l
> project done; you have to be able to say "no, I will not be working o=
n
> that". =A0Out of these conversations emerge better code and
> documentation of the design in the form of list archives.
>
> See [4] for a better explanation of this workflow.
>
> [4] http://thread.gmane.org/gmane.comp.version-control.git/142623/foc=
us=3D142877
>
