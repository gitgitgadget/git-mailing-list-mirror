Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2C302163
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181311; cv=none; b=GlcLfyh9DSCujHBp3kdkOGAhL9/HdVzyNTPqmd5EB/wuFeBiv8BTGVDgewgaCuOC6GeZwDRyr+dnbWCyscdtvxlXYuGyB2KqBYlbpvQw8nAJfb5uOOWRtVXvOTe0pAG5Mig6V5YrokpehLwYqPP2puZS9C5QGModNoI0rqNFZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181311; c=relaxed/simple;
	bh=z6d1NnTa0Tq7NRy9TK54WEBKoKDQQxdASBe+kXFacoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V5KbvKQivmq51nsqLU+K5oEHKVeDHJ/CCBCgeGJE+h6sG10bVe+RnbZ+cIp1z3qzFA5GZV53K04igdUK+8eoQAKLbkHQqOIFrnh3MTuLgXKXQ5/YyqxMH0yNwLco48e+lFdIaw8nkhWzBOQd3hK0uR3YVBQLnocADKY8iSPBDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sPZFJTIy; arc=none smtp.client-ip=91.218.175.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sPZFJTIy"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z6d1NnTa0Tq7NRy9TK54WEBKoKDQQxdASBe+kXFacoI=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788181301; v=1; x=1788786101;
 b=sPZFJTIyHm4HWeJ+WtQQkvnIOW3JUf4xWq6cF57Fk5cI2ffxeHzVRtB3bhp9uWc2OHg6E5Bq
 b1c2xrEN0r9MT1TaPT2NRb1DjpLyhZTTwv+dQlDjuYwGPKGcle32hiiSohZ7JTyraND0xcf3ADa
 SrDubDr3y/b6MeiSRtbPq1Uo=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7626c8eb277b6d09;
	Mon, 31 Aug 2026 13:01:31 +0000
X-Mizu-Trace-ID: 7626c8eb277b6d09
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Elijah Newren <newren@gmail.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <CABPp-BEFGku8msiJCcXburV+tcersr6uqEumKaPh-TguA1LjSg@mail.gmail.com>
References: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
 <20260728-toon-git-replay-drop-merges-v8-3-ced11dffe749@iotcl.com>
 <anYLeQj4Sx2vZqvy@denethor>
 <CABPp-BEFGku8msiJCcXburV+tcersr6uqEumKaPh-TguA1LjSg@mail.gmail.com>
Date: Mon, 31 Aug 2026 15:01:22 +0200
Message-ID: <87zey2wijh.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> Adding my comments in response to Justin's, since I think he
> highlights some good points.
>
> First of all, Toon, thanks for making --linearize and multiple
> branches incompatible to avoid concatenating histories.  I really
> appreciate it.

To be honest, I would rather not to. But for now I think it's the best
we can do. We could dive deeper into the "last_commit per command-line"
suggestion you've made, but I think it would be more complex to
implement it correctly than you made it appear to be. So let's leave
that out now. And perhaps we can share this when we implement real
replaying of commits at some point. So I'm leaving that out for now

> On Fri, Aug 7, 2026 at 10:34=E2=80=AFAM Justin Tobler <jltobler@gmail.com=
> wrote:
>>
>> On 26/07/28 05:45PM, Toon Claes wrote:
>> > One of the stated goals of git-replay(1) is to allow implementing the
>> > git-rebase(1) functionality on the server side.
>> >
>> > The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
>> > was given. This mode drops merge commits instead of replaying them, and
>> > linearizes the history into a sequence of regular (single-parent)
>> > commits.
>> >
>> > Add option `--linearize` to git-replay(1) to do the same. Each replayed
>> > commit is stacked on top of the previously replayed one. When a merge =
is
>> > encountered, the commits reachable from all of its sides are replayed
>> > into the single line and the merge itself is dropped.
>> >
>> > If a ref was pointing to a merge commit, that ref is updated to the
>> > merge's last replayed ancestor.
>>
>> Just to clarify, does it really matter if the ref was pointing to the
>> merge commit directly? I assume it is just "flattening" the merge
>> commits in the revision range.
>
> Toon's clarification is important, though depending on your mental
> model it might _appear_ to be an unnecessary clarification.  I think
> there are two mental models:
>   - Each commit of the branch is replayed and the ref is updated as it
> goes.  (This matches underlying implementation mechanics for `git
> rebase`, but not for `git replay`.)
>   - Each commit of the branch is replayed.  The ref is updated at the
> end to the corresponding replay of the final commit.  (Matches
> underlying implementation mechanics for `git replay`.)
>
> Readers could possibly assume either mental model without knowing the
> underlying mechanics.  Toon's clarification doesn't hurt those who
> assume the first style, but is an important clarification for those
> who assume the second style.

@Justin, what I intended to explain is the following scenario:

   A---B---C
        \
         D---E---F---G
              \     /
               X---Y

If `my-branch` points to G, replaying that branch onto C ends up into:

   A---B---C---D'---E'---F'---X'---Y'  (order not guaranteed)

`my-branch` will now point to Y', because G is dropped the ref is
"moved".

>> > git-replay(1) accepts multiple revision ranges, for example:
>> >
>> >     $ git replay --onto main topic1 topic2
>>
>> Per some discussion earlier in the thread, is "accepts multiple revision
>> ranges" the correct wording here? Would it be more correct to say
>> multiple branches instead?
>
> Yes, please; it would be nice to see this fixed.

Will do.

>> > Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
>> > independently and updates both refs.
>>
>> Ok, so git-replay(1) updates each branch sepecified separately.
>
> Oh, that's a good callout.  The word "independently" and "separately"
> here may well mislead users.  If branches "topic1" and "topic2" share
> some history, claiming they are replayed "independently" or
> "separately" may cause people to assume the shared history becomes
> copied and no longer shared.  I think the word "independently" should
> be dropped.  If wanted, we could word this to something like:
>
> Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
> (keeping shared portions of history shared and keeping divergent parts
> divergent), and updates both refs.

Okay, let's take this.

>> > For now this is disallowed with option `--linearize`. Linearizing more
>> > than one branch at once would concatenate unrelated histories into a
>> > single line, and update each branch to some point in that line. That
>> > won't be the result most users want, especially because the order
>> > depends on the order of the revision walk, not the order of the branch
>> > names on the command line.
>>
>> I'm not quite sure I follow. Why would the inclusion of the
>> `--linearize` option force concatenation of multiple references? Is it
>> mot possible to linearize each of the branches in isolation and update
>> the reference accordingly?
>
> Maybe:
>
> Due to current implementation limitations, replaying multiple branches
> with `--linearize` is disallowed to avoid concatenating unrelated
> histories into a single line...

Works for me.

@Justin there's a whole history of mails preceding this issue, but to
give you the short summary: I think in v5 I've made a change because
Junio and Philip noticed a bug where only one side would get replayed.
But the "fix" I made caused every branch to be replayed together in one
signle long history. This is probably unwanted behavior to most users,
so Elijah suggested to disallow multiple branches with --linearize, at
least for now.

>> > For the same reason disallow the use of `--contained` with
>> > `--linearize`.
>
> Good catch and callout, Toon.

<3

>> > Users who want to linearize multiple branches are advised to do this in
>> > separate git-replay(1) invocations. Linearizing multiple branches at
>> > once might be added later.
>>
>> Ok.
>>
>> > Note that `--linearize` is not modeled after git-rebase(1)'s
>> > `--rebase-merges[=3D<mode>]` interface. Recreating merges, by preservi=
ng
>> > their topology, is a distinct operation that would be a separate mode.
>> > `--linearize` only drops merges and replays commits linearly. So
>> > git-replay(1) uses its own option rather than reusing that interface.
>> >
>> > Based-on-patches-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > Signed-off-by: Toon Claes <toon@iotcl.com>
>> > ---
>> >  Documentation/git-replay.adoc |  19 +++++++-
>> >  builtin/replay.c              |   6 ++-
>> >  replay.c                      |  60 +++++++++++++++--------
>> >  replay.h                      |   5 ++
>> >  t/t3650-replay-basics.sh      | 109 +++++++++++++++++++++++++++++++++=
++++++++-
>> >  5 files changed, 176 insertions(+), 23 deletions(-)
>> >
>> > diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.=
adoc
>> > index a32f72aead..656a6924d9 100644
>> > --- a/Documentation/git-replay.adoc
>> > +++ b/Documentation/git-replay.adoc
>> > @@ -10,7 +10,7 @@ SYNOPSIS
>> >  --------
>> >  [verse]
>> >  (EXPERIMENTAL!) 'git replay' ([--contained] --onto=3D<newbase> | --ad=
vance=3D<branch> | --revert=3D<branch>)
>> > -                          [--ref=3D<ref>] [--ref-action=3D<mode>] <re=
vision-range>
>> > +                          [--ref=3D<ref>] [--ref-action=3D<mode>] [--=
linearize] <revision-range>
>> >
>> >  DESCRIPTION
>> >  -----------
>> > @@ -88,6 +88,23 @@ incompatible with `--contained` (which is a modifie=
r for `--onto` only).
>> >  +
>> >  The default mode can be configured via the `replay.refAction` configu=
ration variable.
>> >
>> > +--linearize::
>> > +     In this mode, each replayed commit is stacked on top of the
>> > +     previously replayed one, so all replayed commits are flattened i=
nto
>> > +     a single linear history.
>> > ++
>> > +When a merge commit is encountered, the behavior of git-rebase(1)'s
>> > +option `--no-rebase-merges` is imitated. All commits in the range
>
> I dislike pointing new users to read a big chunk of another manual
> page to understand an option.  I have a personal gripe against the
> manual for `git merge-base`, in particular, which feels like in order
> to understand various flags you have to understand what at first looks
> like an unrelated command and multiple of its options first.  The rest
> of your paragraph is a good self-standing description; can you just
> move your first sentence to the end of the paragraph and make it a
> parenthetical pointing out the similarity of the two options of the
> two commands?

I'll rephrase it.

>> > +reachable from the merge commit are replayed into a linear history, a=
nd
>> > +the merge commit itself is dropped. A ref that pointed to a merge com=
mit
>> > +is updated to the merge's last replayed ancestor.
>> > ++
>> > +Only a single branch can be linearized at a time: `--linearize` cannot
>> > +be combined with multiple positive revisions or with `--contained`,
>> > +because that would concatenate otherwise unrelated histories into one
>> > +line. To linearize several branches, replay them in separate `git
>> > +replay` invocations.
>>
>> I still don't fully understand the justification here. I'm not sure it
>> really needs to be in the documentation though. It may be fine to just
>> say "multiple branches are not supported with this option" or something
>> along those lines.
>
> It does feel like this unnecessarily explains implementation
> shortcomings, and further tries to list them as fundamental
> limitations.  (If each commit were tagged with all branches it was
> reachable from, then as the replay walked over the commits and
> replayed each, it could simply track the last commit for each branch
> rather than an overall last commit, and at the end update each branch
> to its corresponding last seen commit.  That would allow us to lift
> the limitation.)  So, I agree with Justin's suggestion here to just
> more simply state that the combination isn't supported.

Sure.

>> > +
>> >  <revision-range>::
>> >       Range of commits to replay; see "Specifying Ranges" in
>> >       linkgit:git-rev-parse[1]. In `--advance=3D<branch>` or
>> > diff --git a/builtin/replay.c b/builtin/replay.c
>> > index 39e3a86f6c..d39626a37d 100644
>> > --- a/builtin/replay.c
>> > +++ b/builtin/replay.c
>> > @@ -85,7 +85,7 @@ int cmd_replay(int argc,
>> >       const char *const replay_usage[] =3D {
>> >               N_("(EXPERIMENTAL!) git replay "
>> >                  "([--contained] --onto=3D<newbase> | --advance=3D<bra=
nch> | --revert=3D<branch>)\n"
>> > -                "[--ref=3D<ref>] [--ref-action=3D<mode>] <revision-ra=
nge>"),
>> > +                "[--ref=3D<ref>] [--ref-action=3D<mode>] [--linearize=
] <revision-range>"),
>> >               NULL
>> >       };
>> >       struct option replay_options[] =3D {
>> > @@ -111,6 +111,8 @@ int cmd_replay(int argc,
>> >                            N_("mode"),
>> >                            N_("control ref update behavior (update|pri=
nt)"),
>> >                            PARSE_OPT_NONEG),
>> > +             OPT_BOOL(0, "linearize", &opts.linearize,
>> > +                      N_("drop merge commits, replaying only non-merg=
e commits")),
>> >               OPT_END()
>> >       };
>> >
>> > @@ -132,6 +134,8 @@ int cmd_replay(int argc,
>> >                                 opts.contained, "--contained");
>> >       die_for_incompatible_opt2(!!opts.ref, "--ref",
>> >                                 !!opts.contained, "--contained");
>> > +     die_for_incompatible_opt2(opts.linearize, "--linearize",
>> > +                               !!opts.contained, "--contained");
>> >
>> >       /* Parse ref action mode from command line or config */
>> >       ref_mode =3D get_ref_action_mode(repo, ref_action);
>> > diff --git a/replay.c b/replay.c
>> > index 7e35f40d37..1e1bc7c10a 100644
>> > --- a/replay.c
>> > +++ b/replay.c
>> > @@ -404,6 +404,12 @@ int replay_revisions(struct rev_info *revs,
>> >       set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
>> >                          &detached_head, &advance, &revert, &onto, &up=
date_refs);
>> >
>> > +     if (opts->linearize &&
>> > +         update_refs && strset_get_size(update_refs) > 1) {
>> > +             ret =3D error(_("'--linearize' cannot be used with multi=
ple revision ranges"));
>>
>> Should this say "multiple branches" instead?
>
> Yes, please.

Ack.

> Also, should we replace opts->linearize with (opts->linearize || mode
> =3D=3D REPLAY_MODE_REVERT) ?  The reason being this line of code below:
>
>> > +                     if (opts->linearize || mode =3D=3D REPLAY_MODE_R=
EVERT)
>> > +                             base =3D last_commit;
>
> Trying to revert with multiple branches will (a) concatenate the
> reverts into a single branch (which probably *is* what is wanted) and
> (b) do so in revision walking order instead of the order of branches
> specified by the user on the command line.  That ordering could have
> bisection or conflict ramifications that may surprise the user.  Also,
> cherry-pick disallows multiple branches (even though concatenation
> would be wanted there too) because of this
> ignore-user's-command-line-order issue.

This is already covered in set_up_branch_mode(), used by both --revert
and --advance.

--=20
Laters,
Toon
