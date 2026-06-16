Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10713314B72
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593767; cv=none; b=ebVQNykViX1sqca3utBUGbqcTr8Bchg8bGarPRHZw8+h48h57UZUPqlqj3Ck8vQ8aGI3RSN7futC/db8wVDhwI1jdpDoezPK3D6pbatba/RYdm6KYlwr5A81DcMQu1NiqElcUq2Aa0YR5bH3LO7cE3GzXETLmkCgyk0/t+PoR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593767; c=relaxed/simple;
	bh=phXgV5uWtwT3pbefnmw1hcPOknLq/l1nNVq3euEUoeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sbc6pgjOtY26NAmEij6ZSd/f9aGwBVdHnU5lPlNJaS0XMKBWn/PhMo5DObVjwusGqAx1ddSFKIuz9z2BUH/zdj16gbxNJE1zSsX1G1NPJMOnYQHE9leYYorhDbvGsQ22CCzfoZRv3cVzawVVC4NbfI7MxJueUv4s40GV+J4k8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VqhzWRS3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VqhzWRS3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781593763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbX+MwkfkOsem9KL32ilbpTSIYBZO65wWjsd+5VQw4s=;
	b=VqhzWRS3JHrF+3AdfvmFYbTQ5oNNZXcctyYq1HAQzq+eW/oFKoeWfRwQUjOo2/5J9B3CH4
	xhXDLyfW7yXSJL9hfQJ/owv0+VfOmW7WjsxLN+nN/lXhVe5ez+FnIALTEWccw6N/uHLH73
	8BlocFP0McJK0d9jEifUcxkqN4tlPLA=
From: Toon Claes <toon@iotcl.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <CABPp-BGRi2obnqRGEY9pSMyvRbNGs8AdVUpZmr0C6vZSgHb=cg@mail.gmail.com>
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
 <20260610-toon-git-replay-drop-merges-v2-3-5714a71c6d83@iotcl.com>
 <CABPp-BGRi2obnqRGEY9pSMyvRbNGs8AdVUpZmr0C6vZSgHb=cg@mail.gmail.com>
Date: Tue, 16 Jun 2026 09:09:16 +0200
Message-ID: <874ij3ynab.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Elijah Newren <newren@gmail.com> writes:

> Hi,
>
> On Wed, Jun 10, 2026 at 7:51=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>>
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>
>> One of the stated goals of git-replay(1) is to allow implementing the
>> git-rebase(1) functionality on the server side.
>>
>> The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
>> was given. This mode drops merge commits instead of replaying them, and
>> linearizes the commit history into a sequence of the
>> regular (single-parent) commits.
>>
>> Add option `--linearize` to git-replay(1) to do the same.
>
> I think this version is nicer overall than the one from my
> replay-upstream branch; sorry for repeatedly getting distracted from
> that, but this does look nice.

Dscho gets most of the credit here. And don't worry about being
distracted, we know how things go around here. I appreciate the review!

>
> A few small comments:
>
>> Co-authored-by: Toon Claes <toon@iotcl.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>  Documentation/git-replay.adoc |  5 +++++
>>  builtin/replay.c              |  4 ++++
>>  replay.c                      | 30 +++++++++++++++++++++++-------
>>  replay.h                      |  5 +++++
>>  t/t3650-replay-basics.sh      | 26 ++++++++++++++++++++++++++
>>  5 files changed, 63 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.ad=
oc
>> index a32f72aead..41c96c7061 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -88,6 +88,11 @@ incompatible with `--contained` (which is a modifier =
for `--onto` only).
>>  +
>>  The default mode can be configured via the `replay.refAction` configura=
tion variable.
>>
>> +--linearize::
>> +       In this mode, `git replay` imitates `git rebase --no-rebase-merg=
es`,
>> +       i.e. it cherry-picks only non-merge commits, each one on top of =
the
>> +       previous one.
>
> The SYNOPSIS block at the top of the file is missing this new flag.
>
> The replay_usage[] variable in cmd_replay is also missing this new flag.
>
>>  <revision-range>::
>>         Range of commits to replay; see "Specifying Ranges" in
>>         linkgit:git-rev-parse[1]. In `--advance=3D<branch>` or
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 39e3a86f6c..fedfe46dc6 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -111,6 +111,8 @@ int cmd_replay(int argc,
>>                              N_("mode"),
>>                              N_("control ref update behavior (update|pri=
nt)"),
>>                              PARSE_OPT_NONEG),
>> +               OPT_BOOL(0, "linearize", &opts.linearize,
>> +                        N_("ignore merge commits instead of replaying t=
hem")),
>
> "ignore" feels a bit ambiguous to me.  Can we use "drop" instead,
> matching your commit message?

Agreed, I don't like it too. "drop" sounds better.

>>                 OPT_END()
>>         };
>>
>> @@ -132,6 +134,8 @@ int cmd_replay(int argc,
>>                                   opts.contained, "--contained");
>>         die_for_incompatible_opt2(!!opts.ref, "--ref",
>>                                   !!opts.contained, "--contained");
>> +       die_for_incompatible_opt2(!!opts.revert, "--revert",
>> +                                 opts.linearize, "--linearize");
>
> Sensible; should the docs mention this incompatibility?  (I'm not sure
> myself; just throwing it out as food for thought.)

Let's add it.

>>
>>         /* Parse ref action mode from command line or config */
>>         ref_mode =3D get_ref_action_mode(repo, ref_action);
>> diff --git a/replay.c b/replay.c
>> index 7921d7dba3..81033fb889 100644
>> --- a/replay.c
>> +++ b/replay.c
>> @@ -277,12 +277,16 @@ static struct commit *pick_regular_commit(struct r=
epository *repo,
>>                                           struct commit *onto,
>>                                           struct merge_options *merge_op=
t,
>>                                           struct merge_result *result,
>> +                                         struct commit *replayed_base,
>>                                           bool reverse,
>>                                           enum replay_empty_commit_actio=
n empty)
>>  {
>> -       struct commit *base, *replayed_base;
>> +       struct commit *base;
>>         struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>>
>> +       if (replayed_base && reverse)
>> +               BUG("Linearizing commits is not supported when replaying=
 in reverse");
>> +
>
> This is dead code given the die_for_incompatible_opt2 check above,
> right?  Just extra defense in depth?

We also have another defense-in-depth for --onto/--advance/--revert:

    BUG("expected one of onto_name, *advance_name, or *revert_name");

I don't mind having it for --linearize too.

>>         if (pickme->parents) {
>>                 base =3D pickme->parents->item;
>>                 base_tree =3D repo_get_commit_tree(repo, base);
>> @@ -291,7 +295,8 @@ static struct commit *pick_regular_commit(struct rep=
ository *repo,
>>                 base_tree =3D lookup_tree(repo, repo->hash_algo->empty_t=
ree);
>>         }
>>
>> -       replayed_base =3D get_mapped_commit(replayed_commits, base, onto=
);
>> +       if (!replayed_base)
>> +               replayed_base =3D get_mapped_commit(replayed_commits, ba=
se, onto);
>>         replayed_base_tree =3D repo_get_commit_tree(repo, replayed_base);
>>         pickme_tree =3D repo_get_commit_tree(repo, pickme);
>>
>> @@ -430,12 +435,23 @@ int replay_revisions(struct rev_info *revs,
>>         while ((commit =3D get_revision(revs))) {
>>                 const struct name_decoration *decoration;
>>
>> -               if (commit->parents && commit->parents->next)
>> -                       die(_("replaying merge commits is not supported =
yet!"));
>> +               if (commit->parents && commit->parents->next) {
>> +                       if (!opts->linearize)
>> +                               die(_("replaying merge commits is not su=
pported yet!"));
>> +                       /*
>> +                        * When linearizing, a merge commit itself is no=
t picked,
>> +                        * but refs that point to it might need updating.
>> +                        */
>
> Is it worth pointing out that last_commit is intentionally not updated
> by this code path?  That is implied by your comment, but it takes a
> bit of reasoning to get there, and I think it might help future
> readers to just explicitly state it.

Ah yes, I didn't realize that, but you make a good point. I'll rephrase
the comment a bit.

>> +               } else {
>> +                       struct commit *to_pick =3D reverse ? last_commit=
 : onto;
>> +                       last_commit =3D
>> +                               pick_regular_commit(revs->repo, commit,
>> +                                                   replayed_commits, to=
_pick,
>> +                                                   &merge_opt, &result,
>> +                                                   opts->linearize ? la=
st_commit : NULL,
>> +                                                   reverse, opts->empty=
);
>> +               }
>>
>> -               last_commit =3D pick_regular_commit(revs->repo, commit, =
replayed_commits,
>> -                                                 reverse ? last_commit =
: onto,
>> -                                                 &merge_opt, &result, r=
everse, opts->empty);
>>                 if (!last_commit)
>>                         break;
>>
>> diff --git a/replay.h b/replay.h
>> index 1851a07705..07e6fdcca3 100644
>> --- a/replay.h
>> +++ b/replay.h
>> @@ -62,6 +62,11 @@ struct replay_revisions_options {
>>          * Defaults to REPLAY_EMPTY_COMMIT_DROP.
>>          */
>>         enum replay_empty_commit_action empty;
>> +
>> +       /*
>> +        * Whether to linearize the commits (i.e. drop merge commits).
>> +        */
>> +       int linearize;
>>  };
>>
>>  /* This struct is used as an out-parameter by `replay_revisions()`. */
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index 3353bc4a4d..64e0731188 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -565,4 +565,30 @@ test_expect_success '--onto with --ref rejects mult=
iple revision ranges' '
>>         test_grep "cannot be used with multiple revision ranges" err
>>  '
>>
>> +test_expect_success 'replay merge commit fails' '
>> +       echo "fatal: replaying merge commits is not supported yet!" >exp=
ect &&
>> +       test_must_fail git replay --ref-action=3Dprint --onto main I..P =
2>actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'replay to rebase merge commit with --linearize' '
>> +       git replay --ref-action=3Dprint --linearize --onto main I..topic=
-with-merge >result &&
>> +
>> +       test_line_count =3D 1 result &&
>> +
>> +       git log --format=3D%s $(cut -f 3 -d " " result) >actual &&
>> +       test_write_lines O N J M L B A >expect &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'replay to rebase merge commit with --linearize dow=
n to root commit' '
>> +       git replay --ref-action=3Dprint --linearize --onto main A..topic=
-with-merge >result &&
>
> You'd need to drop "A.." to have it go down to the root commit, as
> Junio mentioned elsewhere.

Yes, thanks for double confirmation.

>> +
>> +       test_line_count =3D 1 result &&
>> +
>> +       git log --format=3D%s $(cut -f 3 -d " " result) >actual &&
>> +       test_write_lines O N J I M L B A >expect &&
>> +       test_cmp expect actual
>> +'
>> +
>>  test_done
>
> Should there also be a testcase combining --linearize and --advance?

Sure.

> Should there be a test with the incompatibility of --revert &
> --linearize?  I think we have a few other tests for incompatible
> options.

I was already about to add that.

> One additional testing idea, borrowed from an older variant of
> this patch I had sitting in a local branch (dscho's original
> linearize patch, adapted): in addition to checking specific commit
> subjects, it's worth verifying that the linearized chain produces
> the *same patches* as the original.  Something along the lines of:
>
>         test_expect_success '--linearize preserves patches' '
>                 test_when_finished "git update-ref -d refs/heads/merge_I_=
L" &&
>                 test_tick &&
>                 git checkout -b merge_I_L I &&
>                 git merge --no-edit L &&
>
>                 git replay --linearize --onto A B..merge_I_L &&
>
>                 # range-diff ignores merges, so the original
>                 # {I, L, merge} reduces to {I, L} on the LHS,
>                 # and the replayed chain on the RHS should match.
>                 git range-diff B..merge_I_L@{1} B..merge_I_L >out &&
>                 ! test_grep -v "=3D" out &&
>
>                 git log --oneline A..merge_I_L >out &&
>                 test_line_count =3D 2 out
>         '
>
> The range-diff check is nice because it asserts patch equivalence
> rather than tying the test to a particular replay ordering, which
> makes the test less brittle if the rev-walk order ever changes.
> Feel free to take, adapt, or ignore.

Interesting idea and I like it. Lemme add it.

> Anyway, thanks for working on this; looking good.

Thanks!

--=20
Cheers,
Toon
