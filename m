From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Tue, 7 Feb 2012 15:31:07 +0100
Message-ID: <201202071531.08385.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202061814.58346.jnareb@gmail.com> <CALKQrgcUdigB5zB_bqgpW8=o-TuGChs+q2nYoXu5YdyWu+oWZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 15:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rum4n-0002Md-Om
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 15:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab2BGObP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 09:31:15 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36319 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab2BGObN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 09:31:13 -0500
Received: by eaah12 with SMTP id h12so2843950eaa.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=nQ4a30F2LaPVZR+pPAOBpn19VbyLWFAKByxe1lmK7D8=;
        b=VDvr6Qi5XHDw9whv9v11huCsam5InSRiMtealTpvG5GCYiSV1DttFgpVSiA3l1wZOm
         m3nqrmv/F/L7iEK80adzNSyLtvnp0igNRwIdomv7jX4T1lFGrOnrvWtt4zWfmAe6op1k
         IzRf/s3P85UtTEJOrDDPlAdgkiY2aa9mVZ/2I=
Received: by 10.213.28.206 with SMTP id n14mr2158678ebc.2.1328625072340;
        Tue, 07 Feb 2012 06:31:12 -0800 (PST)
Received: from [192.168.1.13] (abrz152.neoplus.adsl.tpnet.pl. [83.8.119.152])
        by mx.google.com with ESMTPS id a58sm73966107eeb.8.2012.02.07.06.31.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 06:31:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CALKQrgcUdigB5zB_bqgpW8=o-TuGChs+q2nYoXu5YdyWu+oWZw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190176>

On Mon, 6 Feb 2012, Johan Herland wrote:
> On Mon, Feb 6, 2012 at 18:14, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> On Mon, 6 Feb 2012, Johan Herland wrote:
>>> On Mon, Feb 6, 2012 at 15:44, Jakub Narebski <jnareb@gmail.com> wro=
te:

[...]
>> Yes, starting with prototype implementation using existing infrastru=
cture
>> (hooks) would be a very good idea. =C2=A0(That's how first versions =
of what
>> became submodules were implemented.)
>>
>> OTOH we should be aware of limitations of said prototype due to the =
fact
>> that it is a prototype...
>=20
> Agreed, but AFAICS (and modulo the addition of pre-rewrite and
> pre/post-push hooks mentioned earlier) all of the things discussed so
> far in this thread can be implemented as hooks.

That would be nice.

And the new hooks (pre-rewrite, pre/post-push) would be useful anyway,
I think.

[...]
>>> And trying to plug too many holes might end
>>> up annoying more experienced users who "know what they're doing".
>>
>> Second, forcing via command line parameter should always be an optio=
n.
>=20
> Obviously, but if a large portion of the Git community felt the need
> to always disable this feature, I'd say that we'd failed. The best
> features are those that Just Work(tm).

Well, we have some features in git like advice.* that cater to newbies.
This could be such newbie-mostly feature too.

Anyway what I was thinking about is that forcing is for those hopefully
rare cases where Git safety net is too strict, where DWIM-mery fails.

>>> Instead we might want to add a client-side check at push time. I
>>> realize that this check is already done by the remote end, but the
>>> client-side might be able to give a more helpful response along the
>>> lines of:
>>
>> [...]
>>
>> Explanation is good, but the whole idea of rewriting safety is that =
you
>> are informed (warned or denied) _before_ attempting rewrite and doin=
g much
>> work.
>=20
> True, but there may be cases where the rewrite is not apparent until
> after it has happened. E.g. a novice user may use 'git reset --hard'
> in order to get to an earlier state for testing purposes, and then -
> after completing the test - 'git reset --hard' back to the starting
> point. I know this is not best practice, but is it bad enough that we
> want to refuse it?

I'd like to have safety net also for using 'git reset --hard' to rewind
publishable branch past published history.  Though preventing e.g. forc=
e
rename of other branch to publishable branch so it doesn't fast-forward
WRT its upstream would be going to far, I guess...
=20
>>> First, we don't need to annotate _all_ commits. For the 'public'
>>> state, we only annotate the last/tip commit that was pushed/publish=
ed.
>>> From there, we can defer that all ancestor commits are also 'public=
'.
>>
>> Right.
>>
>>> For the 'secret' state, we do indeed annotate _all_ secret commits,
>>> but I believe this will be a somewhat limited number of commits. If
>>> your workflow forces you to annotate millions of commits as 'secret=
',
>>> I claim there is something wrong with your workflow.
>>
>> Well, for the 'secret' we can rely on the fact that child of 'secret=
'
>> commit must also be 'secret' (non-publishable) if secret is to stay
>> secret. =C2=A0Still marking all 'secret' commits might be better ide=
a from
>> UI and from performance point of view.
>=20
> I don't think we should automatically assume that all children of a
> 'secret' commit are also 'secret'.

All right.  What is important is that safety net related to 'secret'
commits would prevent publishing such commits even if you build non-sec=
ret
commits on top of 'secret' one.

>                                 First of all, the git DAG was not=20
> made for iterating forwards in history, so given a 'secret' commit, i=
t
> is computationally expensive to enumerate all its implied-'secret'
> descendants.

Right, this would enormously complicate detecting 'secret'-ness of comm=
it
when browsing history / querying "phase" of a commit..

> More importantly though, I don't agree with the premise.=20
> I would typically use the 'secret' state as follows: While debugging =
a
> piece of code, I might commit a few debug print statements, and I
> would typically mark this debug commit as 'secret', in order to
> prevent myself from accidentally pushing this. Although it probably
> doesn't matter in practice, I think it is wrong for the commits made
> (temporarily) on top of this debug commit to be also considered
> 'secret'. They are only unpublishable as a consequence of being based
> on the debug commit, and only until I get around to rebasing away the
> 'secret' debug commit.

Right, thanks for sanity check.

So another difference that in its full complexity the 'secret' is an
attribute of an individual commit which is (usually) local to repositor=
y,
while 'public' is in its full complexity an attribute of revision walki=
ng
rather than something that can be attached to a commit.

Also, when thinking about different scenarios of why one would like to
mark commit as 'secret', we might want to be able to mark commit as
secret / unpublishable with respect to _subset_ of remotes, so e.g.
I am prevented from accidentally publishing commits marked as 'secret'
to public repository, or to CI/QA repository, but I can push (perhaps
with warning) to group repository, together with 'secret'-ness state
of said commit...=20

=2E.. though it wouldn't be as much 'secret' as 'confidential' ;-)

>>>> Second, I have doubts if "phase" is really state of an individual =
commit,
>>>> and not the feature of revision walking.
>>
>> It matters to presentation: can commit be simultaneously 'public' be=
cause
>> of one branch, and 'draft' because of other.
>>
>>> I believe the 'public' state is a "feature of revision walking" (i.=
e.
>>> one annotated 'public' commit implies that all its ancestors are al=
so
>>> 'public'). However, the 'secret' state should be bound to the
>>> individual commit, IMHO.
>>
>> Good call, otherwise 'secret' commit could have been "side-leaked"
>> by other refs being pushed.
>>
>> This means though that 'public' / 'draft' while looking similar to '=
secret'
>> are in fact a bit different things. =C2=A0In other words 'immutable'=
 and
>> 'impushable' traits are quite a bit different in behavior...
>>
>> Especially that one acts at pre-rewrite time, and second pre-push ti=
me.
>=20
> Exactly. I find Mercurial 'phase' language confusing, precisely for
> the reason that 'public' and 'secret' are DIFFERENT concepts. One
> hinders rewrite and naturally applies to a commit AND its ancestors,
> while the other hinders push and only applies to the commit itself.
> The fact that they could be implemented by the same mechanisms (hooks
> and notes) does not make them the same thing.

Well, if one doesn't think about all possible usages and complications,
the simplicity of metaphor of "phases" is quite compelling.  We have
(at first glance)

   public < draft < secret

states of a commit (changeset), just like we have

   solid < liquid < gaseous

phases of matter. =20

If we treat traits of 'immutability' and 'publishability' as true boole=
an,
such ordering of "phases" looks natural.  Just like matter goes from ga=
s
to liquid to solid with lowering temperature, changeset "phase" goes fr=
om
'secret' to 'draft' to 'public' following ancestry chain.

But if we go for expressivity and power like the rest of Git, rather th=
an
for simplicity like Mercurial does, the differences between 'secret'-ne=
ss
and 'public'-ness make it unlikely that it would be a good idea to enco=
mpass
those in a single UI and a single concept.  I guess that it can be anot=
her
issue where Mercurial oversimplifies its approach (c.f. branches which
started from clone to branch and anonymous branches, to "named branches=
"
which are really commit labels, to local-only bookmark branches, to=20
transferrable Git-like bookmark branches but with single namespace, and
only just considering equivalent of Git's refspec and refs mapping; c.f=
=2E
revision ranges based on local numbering of commits which made ranges
local too, to new Git-like topological `--ancestry-path`-like ranges).=20


Also with per-remote 'secret'-ness, we might have the scenario where
a commit is marked as 'secret' for public repo, we have pushed it to
group repo (and it's 'secret'-ness trait together with it), an now we
want to be warned if we try to rewrite said commit.

So, separate traits it is (of revision walk, or of a commit), rather
than "smush-together" antity / attribute of "phase" of revision.


That is BTW why I wanted us to have this discussion... :-D

[...]
>>> Basically, there are three different "levels" for this rewrite/publ=
ish
>>> protection to run at:
>>>
>>> 1. Do not meddle at all. This is the current behavior, and assumes
>>> that if the user rewrites and pushes something, the user knows what
>>> he/she is doing, and Git should not meddle (obviously unless the
>>> server refuses the push).
>>
>> I think that there should be some easy way to force such behavior,
>> i.e. to discard rewrite safeties.
>=20
> Indeed. We should probably have a simple config flag to enable the
> rewrite protection. In fact I would argue that the flag should defaul=
t
> to false (disable protection) when unset, and then we should let
> init/clone set the config flag to true (enable protection) in newly
> created repos (unless explicitly disabled in the user/system configs)=
=2E
> This way, behavior does not change for existing repos, but new repos
> are protected by default (with only a single command needed to disabl=
e
> the protection).

And commit option for discarding safeties for specific push, or for
specific rewrite (e.g. pushed at night, noticed an error in commit
message, force-amended, and force-pushed again, hoping that the window
of opportunity is sufficintly small so that nobody will be affected).

>>> 2. Warn/refuse rewriting commits in your upstream. This would only
>>> check branch X against its registered upstream. Only if there is a
>>> registered upstream, and you're about to rewrite commits that are
>>> reachable from the upstream remote-tracking branch, should Git
>>> intervene and warn/refuse the rewrite. This level would IMHO provid=
e
>>> most of the benefit, and little or no trouble (i.e. false positives=
).
>>
>> Right. =C2=A0I wonder if we can get usage statistics from Mercurial =
users
>> about usage of their "phases" feature... though mapping terminology
>> for example 'upstream' from Git to Mercurial and vice versa can be
>> a pain, I guess.
>=20
> I'm unsure how useful it would be. IMHO Git and Mercurial are
> different enough (and promote sightly different workflows) that I
> don't trust the the average Mercurial user's preference for
> Mercurial's 'phase' behavior to be transferable to the average Git
> user's preference for a similar behavior in Git.

Well, bad statistics might be better than no statistics.  What would
be especially interesting is _complaints_ about "phases" feature,
don't you think, i.e. where the "phases" metaphor fails.

[...]

--=20
Jakub Narebski
Poland
