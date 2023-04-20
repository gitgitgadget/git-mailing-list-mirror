Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A241CC77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 04:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjDTEzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 00:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTEzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 00:55:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD54216
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 21:55:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j11so1368252ljq.10
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681966502; x=1684558502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hunxaUYeDkr+RXgIRBljlWYF4wpXNuwr8PRT9NwfG3c=;
        b=bPzLvXeuQOfhb1xtFjD1epmcKPojkxBcmxLWG+ExAt6wTTD310NoJmn7YVh0qBcE1+
         4bvZup3wVDTpG4TG8SzO2WT6IgMVY2SY5z1K7NeIT5A0c5AMMDjcmjTg5Gzr727WkU/h
         xOnnOS52V8aXiO9ky9nf+70i5kUD7YJcgAlcLQazO3n1V1b6i/MV/wrbQQCohtv4Ju4S
         /+EXDE2Fb5vwQiCSasm2E1wHkuukT7KgmEHCmKVLcSUNS+5zCvl4HDD2QDRXOxHvCzeI
         AtI55vqHbxGkH3LveXBfg6TkMGTWiWpRKFaUbbj8ECyn23WWHLNm8JrgtBBOq3X35jDh
         zNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681966502; x=1684558502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hunxaUYeDkr+RXgIRBljlWYF4wpXNuwr8PRT9NwfG3c=;
        b=SnbHUOAbsD+khq8o3INfQWAdQJ0yobMTpYwNoOd23i42aujqI73njp24jQ61iG3L24
         pSQe7kb9YuE7ph4OZ9KRRaZri3UXhLF9EAYRFQuI6r7bM32BHH4IxeFkOa+kLA89Ng3T
         hZG+MsBblq9eKdqAXNjzuMz+40mvM8E8olUv4u6xYhCJ6Dml34kxW5grJvhB9SsbT9WF
         pDmPIied2t2o2uBBANfxWQD9B4GK2iV5uuW1we77xfzLluB/R+Q7r+hfcW8WdbXlSPOf
         QPnAa961wE5tG58jxhXNz75ZV8uX14z0xwAg9zBqDh9rNEbh1piCaP7mh+KH/osTJzDH
         CpJA==
X-Gm-Message-State: AAQBX9fk5EepDwek6fNltrglbIo4dJL/EdHlEPGbJys9MORbzw2ARN8G
        OGYlwqIkAxWokBkApYLysTwRRlelp+FjIjEAuMg=
X-Google-Smtp-Source: AKy350Zv6Rru2fHBGnwfiBlgVH8NYsHxj6FJdb16zG1u1kQP9c0J5NAzQbuHlDJZ9a5Mm3HLf1zKwTSBuSo81lLE+Hw=
X-Received: by 2002:a2e:b0cf:0:b0:2a5:fa58:cac2 with SMTP id
 g15-20020a2eb0cf000000b002a5fa58cac2mr2704115ljl.1.1681966501852; Wed, 19 Apr
 2023 21:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com> <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
 <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com>
In-Reply-To: <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Apr 2023 21:53:00 -0700
Message-ID: <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 6:10=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/18/2023 1:54 AM, Elijah Newren wrote:
> > On Mon, Apr 17, 2023 at 7:05=E2=80=AFAM Derrick Stolee <derrickstolee@g=
ithub.com> wrote:
> >>
> >> On 4/15/2023 3:07 PM, Elijah Newren wrote:
>
> >>> In short, I don't want another limited rebase; I want a more generic =
tool.
> >>
> >> The primary value of git-replay (to me) is that we can do "simple" reb=
ases
> >> without a worktree or user interaction. To me, simple rebases mean app=
ly a
> >> linear sequence of commits from a single branch onto another branch (a=
nd
> >> specifying an "old base" is simple enough to include here). It also me=
ans
> >> that we abort completely if there is a conflict (and handle conflict
> >> resolution in later changes).
> >>
> >> The sooner we can deliver that, the better we can deliver on its poten=
tial
> >> (and expand its functionality to be more generic).
> >
> > Limiting the initial scope of this tool to a smaller set of features
> > is okay (and, in fact, Christian has already done that), but we really
> > need to avoid painting ourselves into a corner if we change the design
> > as part of that limiting.  As I stated previously[1], I'm worried this
> > is happening.
> >
> > [1] https://lore.kernel.org/git/CABPp-BH7ZPBtV5Hu_-_yVdqVmiydW7_s_LYAtw=
bPuYSbRQiuQw@mail.gmail.com/,
> > under "from my view"
> >
> >> And this is generally my preference, but we shouldn't get functionalit=
y
> >> "by accident"
> >
> > All of the specific flags and cases you brought up so far were ones I
> > already carefully considered over a year ago, so the "by accident"
> > comment seems a little unfair.
> >
> >> but instead do it with full intention
> >
> > The intention is listed in the subject of the commit message of this
> > patch.  I've also explicitly stated my desire on this list to make a
> > tool which replays based on a general range expression multiple
> > times[2][3][4][5].  And there are tests for general range expressions
> > in this series being reviewed.  I don't understand why you might think
> > I didn't intend to use general range expressions.
>
> It's one thing to describe commit ranges, and another to include every
> possible rev-list option.

Yes, agreed.  So clearly there is room for some middle ground.  :-)

> > If you want to move git-replay away from setup_revisions(), at a
> > minimum I think we need a proposal that can be extended to the cases I
> > highlighted previously:
> >     * allow specifying several negative revisions (or maybe even zero o=
f them)
> >     * allow specifying several positive revisions
> >     * allow standard basic range syntax, i.e. A..B
>
> I think supporting these descriptive ranges is nice, but doesn't _need_
> to be in v1 of the tool. If we need to bake them into the CLI from v1
> in order to ensure compatibility, then I understand that.

Wahoo, we're moving towards middle ground.

I personally think baking them into the CLI in v1 is the easiest way
to ensure compatibility.  They're part of the long term goal anyway,
and they are already implemented and tested.  (Well, at least the 2nd
and 3rd items.  We also have tests with a negative revision, but could
add ones with more than one.  Having zero negative revisions means
replaying a root commit onto something else, which the code does not
yet support.)

> >     * allow --first-parent
> >     * allow --ancestry-path[=3D<commit>]
> > I think it should also be able to eventually support
> >     * --branches[=3D<pattern>]
> >     * --not
> >     * --tags[=3D<pattern>]
> >     * --remotes[=3D<pattern>]
> >     * --glob=3D<pattern>
> >     * --exclude=3D<glob-pattern>
> >     * --all
>
> However, I think very few of these should be generally supported, and
> if there are reasons to include some then they should be motivated by
> a specific use case and tested directly.

None of these need to be in v1.  Some aren't even useful yet without
other changes that Christian excluded in this initial version.

But can I take a step back and ask if you are saying few of these
should be generally supported _in v1_ (which I'm fine with) or _ever_
(which puts us at total loggerheads)?  It reads to me like you're
saying the latter, but I can't fathom why.  While I totally understand
the apprehension with "every possible rev-list option", this is far
from that extreme and I don't see why flags selecting contiguous
revision ranges should be of any concern.  They all have usecases, and
I've even pointed out multiple already.  Going slightly out of order:

* --ancestry-path=3D<commit>:

I don't see why this option is getting pushback at all.  It was
invented specifically and almost exclusively for use in git-replay.
I've pointed that out already and linked to the detailed usecase
explanation for using this option in git-replay twice so far in this
thread, but there's another interesting twist that may be relevant
here: to my knowledge, there are still no known usecases for this
option outside of git-replay; Junio and I at least could not imagine
any others[6].

Granted, this option is not of much use until we also support
replaying of merges, so leaving it out of v1 is no big deal.

[6] See the quoted comment of Junio including "solution in search of a
problem", found right before I give my usecase in
https://lore.kernel.org/git/CABPp-BHmj+QCBFDrH77iNfEU41V=3DUDu7nhBYkAbCsbXh=
shJzzw@mail.gmail.com/

* --first-parent:

This option was already referenced with a usecase in the link "[5]"
from my last email.  I also listed two other usecases in my
replay-design-notes file[7].

Granted, this option isn't yet useful since Christian has removed the
pick_merge_commit() function for v1.  But considering that it was part
of my original design, I've listed multiple usecases, and I have
already written code for git-replay specifically designed to be used
with both --ancestry-path[=3D<commit>] and --first-parent (just not
included in this v1), it is also one where I'm struggling to
understand pushback for eventual support.

[7] https://github.com/newren/git/blob/2a621020863c0b867293e020fec0954b4381=
8789/replay-design-notes.txt#L113-L124

* all the others (which can be summarized as shorthands options for
various sets of multiple positive refs or multiple negative refs):

I think that supporting multiple positive and negative revisions
likely leads to users wanting these shorthand versions.  For example,
say a user has a dozen different branches in their repository
(possibly intertwined), all based on various topics in main and next.
They go on vacation (or work on some other project) for a few weeks,
during which time everything in next has graduated to main (and next
has not been rewound), and the user wants to replay all of their
branches on an updated main.  They could do so via:

   $ git fetch origin
   $ git checkout --detach HEAD   # Detach HEAD so it doesn't prevent
any ref updates
   $ git replay --onto origin/main --branches --not --remotes=3Dorigin |
git update-ref --stdin

That's something I would like to have available for my use.  (And,
again, N separate rebases/replays does not achieve the same effect
since the commits in those branches being replayed may be partially or
fully contained in some of the other branches being replayed.)

> As it is, these tags do something in this v1, but we can't really be
> sure that they work because we're not testing them. That is my
> primary complaint.

Lack of testing for some of these options is a totally fair complaint.

I'm fine with these options being left out of v1, so long as there
isn't a design change that will impose backward compatibility
constraints that precludes them from being added in the future.  That
is my primary complaint.

> And testing each individually isn't enough, because they can combine in a=
ll sorts of ways.

That's kind of the point, though, right?  Letting people select a
range of (contiguous) revisions using capabilities they are familiar
with and which they have used elsewhere in Git (and which have been
tested elsewhere in Git).

> > That's a long list of things to parse, which setup_revisions() happens
> > to handle nicely.  You are right that setup_revisions() also has lots
> > of options for generating non-contiguous history that may make little
> > or no sense for replay (and makes no sense for fast-export either).
> > So, I am willing to consider other solutions if anyone has one, but
> > only alternative solutions which can eventually handle the above
> > requirements.  In particular, "three commits as positional arguments"
> > (with one implicitly being considered a negative ref) conflicts with
> > the first three bullet points above.
>
> The only way I can see using setup_revisions() safely is if you make
> sure to reject any arguments that start with "--" (or perhaps "-"
> because some of those options may have single-character versions).

Ooh, single dash.  I wonder if people might find doing an interactive
replay with e.g. `--keep-base -5 ${OTHER_BRANCH}` handy.

Granted, that's basically the same as
`${OTHER_BRANCH}~5..${OTHER_BRANCH}` in most cases, and I'm not sure
if I'd personally use it, but it might be a nice touch to allow folks who
have long branch names to get by with less typing.

Anyway, I could see employing this reject-dashed-arguments scheme for
v1, since v1 doesn't need any of the dashed options, but only if
accompanied with a code comment that it's a hack not intended to be
kept in the future.

> This could be extended to an allowlist if we find a motivation to
> include other options (I see "--not" as being a likely candidate)
> in patches that test that interaction.

"if we find a motivation"??

I find this is a bit frustrating.  Several things in the merge-ort
machinery were designed with these kinds of capabilities in mind.
git-merge-tree, on my end, was designed, written, submitted, iterated,
and improved (taking 9+ months) almost solely as a feedback gathering
mechanism for this tool (it has much simpler design and conflict
handling needed).  I've been working on the usecases for this tool for
years, and have put quite a bit of time into this tool already, with
specific usecases in mind driving how the tool is being written.  And
I'm specifically motivated by things that rebase cannot do.

I've linked to several of those usecases multiple times in this thread
already.  Many were also in the cover letter in this series.  (And
more are in my replay-design-notes.txt file on my replay branch.)

I feel like you're brushing aside those repeated attempts to point out
those usecases as though they don't exist or don't matter, with some
separate new motivation needed for these options to be allowed?  And
perhaps saying those usecases should all be *ruled out* apriori,
because you're concerned the implementation *might* also allow other
unintended uses?

Something isn't working here.

> Or, could we extract the portion of setup_revisions() that parses
> just the revision ranges in to a new setup_revision_ranges() method?
> It could reject any options that are not directly about revision
> ranges. This option makes less sense if we are going the allowlist
> approach.

Ooh, that's interesting.  However, would the name lead people to think
that e.g. --reflog, --walk-reflogs, --author, --committer, --grep,
--min-parents, --max-parents, --cherry-pick are relevant?  Should we
perhaps use a name like setup_contiguous_revision_ranges() so it's
clear these flags are disallowed, while things like A, ^B, C..D,
--first-parent, --ancestry-path, --branches, --remotes, are allowed?

Is it worth refactoring setup_revision() into more divisible chunks,
so that callers can make use of just the relevant parts of it?  We
have numerous other tools looking for revision ranges, which currently
accept full rev-list options and pass along user-supplied command-line
arguments to them.  Beyond rev-list/log/shortlog, these seem to
include at least:
  * fast-export
  * blame
  * cherry-pick
  * revert
  * format-patch
  * bisect (at least the skip subcommand)
  * stash (at least the show subcommand)
  * filter-branch (actually, as a horrible shell script, it'll
continue accepting all rev-list options anyway)

Some of these could probably get away with non-contiguous revision
ranges, but most wouldn't find any benefit from:
  * tree/blob/packing options (e.g. --objects*, --unpacked, --filter*,
--verify-objects, --in-commit-order)
  * anything dealing with reflogs (e.g. --reflog, --walk-reflogs)
  * various forms of history simplification (e.g. --simplify-merges,
--simplify-by-decoration, --sparse, --show-pulls)
  * flags related to display (e.g. --pretty, --graph,
--show-signature, --early-output, --disk-usage, --abbrev-commit,
--relative-date, --log-size, --left-right, --cherry-mark)
  * flags related to file contents (e.g. <pathspecs>, --merge,
--follow, --full-diff, --remove-empty)

Here's a fun and valid (and innocuous) command.  Guess which flags are
ignored and which aren't:

  $ git stash show --graph --relative-date --min-parents=3D3
--simplify-merges --cherry --show-pulls --unpacked -v -t -8
--format=3Doneline --abbrev=3D12 --pretty=3Dfuller --show-notes
--encode-email-headers --always --branches --indexed-objects stash@{0}


That all said, while I like the idea of someone dividing
setup_revisions() into divisible chunks so tools can just use the bits
that are relevant, and doing so sounds like it'd avoid weird surprises
from use of unintended flags, I'm surprised that the solution to the
"setup_revisions() is scary" problem isn't to provide easy-to-use API
that allows selecting the relevant subsets for each command, but to
instead expect every one that comes along to do some heavy lifting and
special whitelisting.  We have half a dozen users in the tree already
facing these problems, so shouldn't these be fixed and the API made to
be easy to use more safely so that this problem is solved more
generally rather than just putting it on each future functionality
implementor who comes along to work around it in their particular
situation?
