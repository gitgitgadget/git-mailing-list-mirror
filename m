From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Mon, 6 Feb 2012 18:14:57 +0100
Message-ID: <201202061814.58346.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202061544.14417.jnareb@gmail.com> <CALKQrgcN9Miq7SN_ETvjboRkHRFzcZejrQfy36BQFxYDnVPP6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 18:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuS9j-0007VK-7A
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 18:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab2BFRO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 12:14:58 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64596 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab2BFRO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 12:14:56 -0500
Received: by eaah12 with SMTP id h12so2535476eaa.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 09:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OutQF2muXnn2Ae60yPmvQpEmQb+6dxowF5p1is0XB60=;
        b=MYr/9ea9065SDo9TxaqgKmRj2v9dOnsBFItnhWg9XwPrgO93ivNgjO6Ttq8/L0RQSI
         w6lSW6sQonj1K4lbHAW93SXeyYMKkS4tN+jpxIiZhywtgdnpaOsE4lB8Qowu6MFOU2p2
         NjG8Tnk6ZPzwXNV7sJEvTHQn8RTQgu7nPlg+A=
Received: by 10.213.26.20 with SMTP id b20mr3075531ebc.19.1328548495141;
        Mon, 06 Feb 2012 09:14:55 -0800 (PST)
Received: from [192.168.1.13] (abrz152.neoplus.adsl.tpnet.pl. [83.8.119.152])
        by mx.google.com with ESMTPS id e12sm62985740eea.5.2012.02.06.09.14.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 09:14:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CALKQrgcN9Miq7SN_ETvjboRkHRFzcZejrQfy36BQFxYDnVPP6w@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190080>

On Mon, 6 Feb 2012, Johan Herland wrote:
> On Mon, Feb 6, 2012 at 15:44, Jakub Narebski <jnareb@gmail.com> wrote=
:
> > On Sun, 5 Feb 2012, Johan Herland wrote:

> > Relying on (default) hooks to implement this feature has the disadv=
antage
> > that it wouldn't be turned on by default... while this feature woul=
d be
> > most helpful for users new to git (scared by refuse to push).
>=20
> True. I too believe that this will be most helpful if it is enabled b=
y
> default. That said, the easiest way to get there might be through
> first demonstrating that it works in practice when implemented as
> hooks.

Yes, starting with prototype implementation using existing infrastructu=
re
(hooks) would be a very good idea.  (That's how first versions of what
became submodules were implemented.)

OTOH we should be aware of limitations of said prototype due to the fac=
t
that it is a prototype...
=20
> > I am not sure either if everything (wrt. safety net) can be impleme=
nted
> > via hooks. =C2=A0One thing that I forgot about is preventing rewind=
ing of
> > branch past the published commit using e.g. "git reset --hard <comm=
it>".
> > Unless `pre-rewrite` hook could be used for that safety too...
>=20
> Hmm. I don't think we'll be able to "plug" all the holes that might
> leave the user in a rewritten state (e.g. what if the user (possibly
> with the help of some tool) does an "echo $SHA1 >
> .git/refs/head/master"?).

=46irst, I was thinking about having safety net against rewriting publi=
shed
commits being present only in porcelain.  Plumbing would be not affecte=
d
(perhaps there would be need to extend or add new plumbing to query "ph=
ase"
state, though).

> And trying to plug too many holes might end=20
> up annoying more experienced users who "know what they're doing".

Second, forcing via command line parameter should always be an option.

> Instead we might want to add a client-side check at push time. I
> realize that this check is already done by the remote end, but the
> client-side might be able to give a more helpful response along the
> lines of:

[...]

Explanation is good, but the whole idea of rewriting safety is that you
are informed (warned or denied) _before_ attempting rewrite and doing m=
uch
work.

> > > If you use 'git notes' to annotate 'public' and 'secret' states, =
then
> > > you can also use the --show-notes=3D<ref> option to let show/log =
display
> > > the annotations on 'public'/'secret' commits.
> >
> > First, in my opinion annotating _all_ commits with their phase is I=
 think
> > out of question, especially annotating 'public' commits. =C2=A0I do=
n't think
> > git-notes mechanism would scale well to annotating every commit; bu=
t
> > perhaps this was tested to work, and I am mistaken.
>=20
> First, we don't need to annotate _all_ commits. For the 'public'
> state, we only annotate the last/tip commit that was pushed/published=
=2E
> From there, we can defer that all ancestor commits are also 'public'.

Right.

> For the 'secret' state, we do indeed annotate _all_ secret commits,
> but I believe this will be a somewhat limited number of commits. If
> your workflow forces you to annotate millions of commits as 'secret',
> I claim there is something wrong with your workflow.

Well, for the 'secret' we can rely on the fact that child of 'secret'
commit must also be 'secret' (non-publishable) if secret is to stay
secret.  Still marking all 'secret' commits might be better idea from
UI and from performance point of view.

> Second, git-notes were indeed designed scale well to handle a large
> number of notes, up to the same order of magnitude as the number of
> commits in your repo. (When git-notes was originally written, I
> successfully tested it on versions of a linux-kernel repo where every
> single commit was annotated).

Ah.  That is very nice!

> In this case, the number of 'public'=20
> annotations in your repo would be equal to the number of pushes you
> do, and the number of 'secret' annotations would be equal to the
> number of 'secret' commits in your repo. I'd expect both of these
> numbers to be orders of magnitude smaller than the total number of
> commits in your repo (given a fairly typical workflow in a fairly
> typical repo).

Right.
=20
> > Second, I have doubts if "phase" is really state of an individual c=
ommit,
> > and not the feature of revision walking.

It matters to presentation: can commit be simultaneously 'public' becau=
se
of one branch, and 'draft' because of other.

> I believe the 'public' state is a "feature of revision walking" (i.e.
> one annotated 'public' commit implies that all its ancestors are also
> 'public'). However, the 'secret' state should be bound to the
> individual commit, IMHO.

Good call, otherwise 'secret' commit could have been "side-leaked"
by other refs being pushed.

This means though that 'public' / 'draft' while looking similar to 'sec=
ret'
are in fact a bit different things.  In other words 'immutable' and
'impushable' traits are quite a bit different in behavior...

Especially that one acts at pre-rewrite time, and second pre-push time.

> > Take for example the situation where given commit is reference by
> > remote-tracking branch 'public/foo', and also by two local branches=
:
> > 'foo' with upstream 'public/foo', and local branch 'bar' with no up=
stream.
> >
> > Now it is quite obvious that this feature should prevent rewriting =
'foo'
> > branch, for which commits are published upstream. =C2=A0But what ab=
out branch
> > 'bar'? =C2=A0Should we prevent rewriting (e.g. rebase) here too? =C2=
=A0What about
> > rewinding 'bar' to point somewhere else. =C2=A0What if 'bar' is rea=
lly detached
> > HEAD?
> >
> > These questions need to be answered...
>=20
> Good point. There are two questions we may need to answer: "Has commi=
t
> X ever been published?", and "Has commit X ever been published in the
> context of branch Y?". In the latter case, we do indeed need to take
> the upstream branch into account.

I think the second one is more interested for rewrite safeties.

> Basically, there are three different "levels" for this rewrite/publis=
h
> protection to run at:
>=20
> 1. Do not meddle at all. This is the current behavior, and assumes
> that if the user rewrites and pushes something, the user knows what
> he/she is doing, and Git should not meddle (obviously unless the
> server refuses the push).

I think that there should be some easy way to force such behavior,
i.e. to discard rewrite safeties.

> 2. Warn/refuse rewriting commits in your upstream. This would only
> check branch X against its registered upstream. Only if there is a
> registered upstream, and you're about to rewrite commits that are
> reachable from the upstream remote-tracking branch, should Git
> intervene and warn/refuse the rewrite. This level would IMHO provide
> most of the benefit, and little or no trouble (i.e. false positives).

Right.  I wonder if we can get usage statistics from Mercurial users
about usage of their "phases" feature... though mapping terminology
for example 'upstream' from Git to Mercurial and vice versa can be
a pain, I guess.

> 3. Warn/refuse rewriting _any_ 'public' commit. Refuse to rewrite any
> commit that is reachable from any remote-tracking branch. Some would
> say that this is a Good Thing(tm), since it prevents a commit from
> being _copied_ (i.e. rebased or cherry-picked) between branches (you'=
d
> be in this camp if you run a tightly-controlled workflow, where you
> e.g. mandate upmerging patches from the oldest applicable branch
> instead of cherry-picking patches from a newer branch). However, othe=
r
> people would say that this is too limiting, and imposes unnecessary
> rules on the workflow of the project (where e.g. copying (by way of
> git-rebase) a topic branch from one place to another would cause an
> annoying false positive).

Well, we could always 'deny' on 2nd, and just 'warn' on 3rd...

--=20
Jakub Narebski
Poland
