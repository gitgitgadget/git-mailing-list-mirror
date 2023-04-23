Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35323C77B76
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 01:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDWBSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 21:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDWBS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 21:18:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130061FD5
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:18:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a8a6602171so29185141fa.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682212704; x=1684804704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfVDhdO920g1AidN9clZ1OJt/sMUkLtIdZUEZ6P+nwM=;
        b=in24VluJ4DkxS42AOiTw1O2VmwZtG0RaQdFl2xAEU/MLI0oZ3I7K0iPJ81QKITZ1r2
         YuJYBK2vLmO9fHc4rhMKjUfwH/74veWTL+HaIpyq37LfcDZuLGL0ovthXFsAqZiqYStn
         TTCxkuT2oDfkKDTIaFhk/IKHxccAV1Mn7How7/Hedx8kLQLIKgCHAxNEu3fa5DKTJf52
         AFu9nAVyyTXSonOjaZJlLpMiGudjHnsT6TXjTsKI7bFbKTm2MrF13Z9ZB7AT8FdEoaws
         aTs+aOCShPdIKnyFmNlgHuKtCbAjv4ARCdAsEUlcwedtufH8abVez6KV71FDv56yWbtX
         SZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682212704; x=1684804704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfVDhdO920g1AidN9clZ1OJt/sMUkLtIdZUEZ6P+nwM=;
        b=CzpaDXTexHNkfVfhQj/sqbYjZ/WHivxkTxuc6/nAanDkyNoUAi+Q2rAvxutAHMoh4y
         P1sO1dGwjgrLGRsQO1M1zygqT0DDraZ4ekrK3fzmCPxLJbm7cwZL6+Cziux3+na2gHs+
         FQvjNBtSi1HQpeHDtqBOkBym3Mnks+fRa2qmWksM0RQLCef6nqKFM64hrdoCP8qKQ286
         ELHtE1TXbBC7obNVtiU5Ccaux+HNCbAyjJHiO6o0n2yAFU52joQ59NgYQVJdtE7pg7gx
         PEqPmBcnitDwtljc/kfAWXb0aWVInLy/PuWfFWsTDJCAp90qaLC++efquILV3MZMCgWi
         Xnlw==
X-Gm-Message-State: AAQBX9cHB2IGhaLlkukV/uDaMRpv1g8g7zIKOl5L9eaNKCZkn6IPLyuB
        s5dG4WrP7f61dPSM6K3eNwRDYl9SXSu7larTYKo=
X-Google-Smtp-Source: AKy350brIs2ZAZ1ZKNM4w+wbRAdMh2JyXUB0zAI64I4AmRYTZy0B4rzxzRBgj7D0Fu+j87V1SgOp7g2ye3/+FuBbVa0=
X-Received: by 2002:a2e:7c07:0:b0:29f:e144:6c6c with SMTP id
 x7-20020a2e7c07000000b0029fe1446c6cmr1570787ljc.30.1682212703670; Sat, 22 Apr
 2023 18:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com> <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
 <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com> <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
 <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com>
In-Reply-To: <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 22 Apr 2023 18:18:00 -0700
Message-ID: <CABPp-BFCKrbSZQtRD1MnXrwB91O2YK9ZuGd6BiYQZ2zrpLp+uw@mail.gmail.com>
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

On Thu, Apr 20, 2023 at 6:44=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/20/2023 12:53 AM, Elijah Newren wrote:
> > On Tue, Apr 18, 2023 at 6:10=E2=80=AFAM Derrick Stolee <derrickstolee@g=
ithub.com> wrote:
> >>
> >> On 4/18/2023 1:54 AM, Elijah Newren wrote:
[...]
> >>>     * allow --first-parent
> >>>     * allow --ancestry-path[=3D<commit>]
> >>> I think it should also be able to eventually support
> >>>     * --branches[=3D<pattern>]
> >>>     * --not
> >>>     * --tags[=3D<pattern>]
> >>>     * --remotes[=3D<pattern>]
> >>>     * --glob=3D<pattern>
> >>>     * --exclude=3D<glob-pattern>
> >>>     * --all
> >>
> >> However, I think very few of these should be generally supported, and
> >> if there are reasons to include some then they should be motivated by
> >> a specific use case and tested directly.
> >
> > None of these need to be in v1.  Some aren't even useful yet without
> > other changes that Christian excluded in this initial version.
> >
> > But can I take a step back and ask if you are saying few of these
> > should be generally supported _in v1_ (which I'm fine with) or _ever_
> > (which puts us at total loggerheads)?  It reads to me like you're
> > saying the latter, but I can't fathom why.  While I totally understand
> > the apprehension with "every possible rev-list option", this is far
> > from that extreme and I don't see why flags selecting contiguous
> > revision ranges should be of any concern.  They all have usecases, and
> > I've even pointed out multiple already.  Going slightly out of order:
>
> (going more out of order)
>
> > * --first-parent:
> >
> > This option was already referenced with a usecase in the link "[5]"
> > from my last email.  I also listed two other usecases in my
> > replay-design-notes file[7].
>
> I agree on this one.

:-)

> > * --ancestry-path=3D<commit>:
> >
> > I don't see why this option is getting pushback at all.  It was
> > invented specifically and almost exclusively for use in git-replay.
>
> (Edited out your explanation.)
>
> I'm still not super convinced that this solves a common user problem,

Why does it have to be common?  I said I wanted to be able to do
things that I cannot do with existing tooling, which usually implies
less common usecases.


> > * all the others (which can be summarized as shorthand options for
> > various sets of multiple positive refs or multiple negative refs):
>
> I think you're over-simplifying here, because...

I don't think so.  Was the context lost?  I suspect it was, because
right after this you started talking about completely unrelated
options (though in a very useful manner, so it's all good in the end.)

Since I was responding to "few of these should be generally
supported", and the first two of those had been discussed above, "all
the others" here refers to exactly these 7 flags:
    * --branches[=3D<pattern>]
    * --not
    * --tags[=3D<pattern>]
    * --remotes[=3D<pattern>]
    * --glob=3D<pattern>
    * --exclude=3D<glob-pattern>
    * --all

All I did was read our own documentation for these options and
categorize exactly what they share in common.  That yields my
statement that these "can be summarized as shorthand options for
various sets of multiple positive refs or multiple negative refs".

> >> Or, could we extract the portion of setup_revisions() that parses
> >> just the revision ranges in to a new setup_revision_ranges() method?
> >> It could reject any options that are not directly about revision
> >> ranges. This option makes less sense if we are going the allowlist
> >> approach.
> >
> > However, would the name lead people to think
> > that e.g. --reflog, --walk-reflogs, --author, --committer, --grep,
> > --min-parents, --max-parents, --cherry-pick are relevant?  Should we
> > perhaps use a name like setup_contiguous_revision_ranges() so it's
> > clear these flags are disallowed, while things like A, ^B, C..D,
> > --first-parent, --ancestry-path, --branches, --remotes, are allowed?
>
> I think one thing that might help bridge the divide here is a
> different split when I think of "revision range" and "rev-list options".
>
> We have several categories of rev-list options, and we need to find
> the right set to care about and the ones that aren't useful for git-repla=
y:
>
>  1. (What I call revision ranges) a collection of starting revisions,
>     each marked as an "include" or "exclude" (A..B includes B,
>     excludes A). The --not option helps with defining these starting
>     points.

There are also shorthands for building up these collections of
starting revisions, so that instead of saying e.g. `maint main next
seen mytopic`, one can just use `--branches`.  Thus, options like
--branches[=3D<pattern>], --tags[=3D<pattern>], --exclude=3D<pattern>, etc.
also belong in this category.

>  2. (Walk options) Modifications to how we walk commits, such as
>     --first-parent, --ancestry-path. These are so far the kind of
>     options you have motivated with use cases.

I think I also motivated category 1 with use cases.  Since you
acquiesced on including that category first, I think you may have
meant this last sentence to refer to both of these categories?

>  3. (Ordering options) Modifications to how those commits are ordered,
>     such as --topo-order, --date-order, and --reverse. These seem to
>     be overridden by git-replay (although, --reverse probably causes
>     some confusion right now).

Yep, intentionally overridden.

Could you elaborate on what you mean by --reverse causing confusion?

>  4. (Filtering options) A post-walk filter on a per-commit basis.
>     This includes --(max|min)-parents, --author, --grep.

I think pathspecs are an additional example that is worth specifically
calling out as belonging in category 4.

This is a reasonable splitting of categories, if a bit incomplete.
(However, other categories I can think of matter less to git-replay
than these four.)

> note: at this point I'm not sure into which of these categories we
> should put time-based options like --since.

Fair enough, there were also some options I was unsure of.  And there
are some that look like a can of worms.  (Which I'd rather not get
into, but I'll obliquely note that I would place `--since` and
`--until` in separate categories.)

> My main objection to the generic rev-list options come from allowing
> categories (3) and (4), since this is more likely to cause user
> confusion rather than actually be of any use to the feature.

That is a reasonable objection; I wish what you had stated earlier
looked more like this.

I might disagree with you on the severity of the issue, or the
relative necessity/importance of cleaning up the widely-used existing
code as a pre-requisite to using it in another place, but it's a
totally fair review comment to bring up.  Further, I agree with you
that the options in these two categories would not be of any use to
git-replay.

> While I was not considering (2) to be included in setup_revision_ranges()=
,
> I could see it being valid to include both (1) and (2) in those options.

Awesome, I think this provides me with what I need.  Note that
categories (1) and (2) include every single option in my previous "at
a minimum" list:

    * several negative revisions (or maybe even zero of them)
    * several positive revisions
    * standard basic range syntax, i.e. A..B
    * --first-parent
    * --ancestry-path[=3D<commit>]
    * --branches[=3D<pattern>]
    * --not
    * --tags[=3D<pattern>]
    * --remotes[=3D<pattern>]
    * --glob=3D<pattern>
    * --exclude=3D<glob-pattern>
    * --all

There may also be additional options that fit within categories (1) and (2)=
.

> I would like to see tests for options in category (2) to demonstrate
> these use cases and solidify them in our supported scenarios.

Yup, totally fair.  Probably not as part of this initial patchset,
though, since Christian and Dscho are only interested in a small
subset of usecases and are the ones pushing these patches early.
(Whereas I'm focused on answering questions, and making sure that
whatever happens doesn't make my goals for the tool impossible.)

> > "if we find a motivation"??
> >
> > I find this is a bit frustrating.  Several things in the merge-ort
> > machinery were designed with these kinds of capabilities in mind.
> > git-merge-tree, on my end, was designed, written, submitted, iterated,
> > and improved (taking 9+ months) almost solely as a feedback gathering
> > mechanism for this tool (it has much simpler design and conflict
> > handling needed).  I've been working on the usecases for this tool for
> > years, and have put quite a bit of time into this tool already, with
> > specific usecases in mind driving how the tool is being written.  And
> > I'm specifically motivated by things that rebase cannot do.
> >
> > I've linked to several of those usecases multiple times in this thread
> > already.  Many were also in the cover letter in this series.  (And
> > more are in my replay-design-notes.txt file on my replay branch.)
> >
> > I feel like you're brushing aside those repeated attempts to point out
> > those usecases as though they don't exist or don't matter, with some
> > separate new motivation needed for these options to be allowed?  And
> > perhaps saying those usecases should all be *ruled out* apriori,
> > because you're concerned the implementation *might* also allow other
> > unintended uses?
> >
> > Something isn't working here.
>
> I'm trying to read the patches and make sense of what is written there.
>
> The current patch especially is far too lightly documented for what
> it is actually implementing.
>
> Even its documentation states this:
>
> +<revision-range>::
> +       Range of commits to replay; see "Specifying Ranges" in
> +       linkgit:git-rev-parse.
>
> This "Specifying Ranges" section describes exactly category (1) of
> what I was talking about, but really the patch enables everything
> in "Commit Limiting" from git-rev-list.
>
> Based on what I see in the patch, I can't help but think that the
> extra options are an accident.

This all would be a fine review comment, if you had said that.
Instead, you stated that setup_revisions() shouldn't be used (which
might have been fine as an initial comment), and when I pointed out
exact options and flags that were needed at a minimum you still said
they shouldn't generally be supported, and after pointing out
usecases, multiple times, you responded with "if we can find a
motivation".

There are two reasons I found that problematic:

Sometimes it makes sense to say that a usecase shouldn't be supported.
But, when there's months of effort so far put into implementing those
usecases, I would expect strong statements about ruling out usecases
to be accompanied with really good explanations of why those exact
cases are deemed "bad" and the best possible alternative solutions
that should instead be implemented to solve something close to the
proposer's stated desires.  I didn't see that.

Similarly, there are times when a reviewer should say that code should
not be implemented a certain way.  But when the person responds with
some alternatives and their _minimum_ needs trying to find some common
ground, and has put months of efforts into this wider goal, I would
expect that ruling out certain methods and their follow up
alternatives to be accompanied with alternative solutions of your own
that can solve the proposer's goals; not merely attempting to veto
suggestions immediately with seemingly no path forward.

It was an unfortunate set of examples that seemed far below your
typically excellent reviews.  In contrast, this latest email of yours
is another high quality response in line with your emails prior to this thr=
ead.

> And _even with the extra context linked elsewhere_ I will still hold
> that using something as generic as setup_revisions() isn't a good
> practice for software development. It adds too may things that all
> at once, some of which I don't think match the purpose of git-replay.
> You've convinced me to expand my understanding of what fits in that
> category, but I still think we need to test this more. Tests can
> demonstrate use cases much better than anything else.

Yaay on the convincing bit.  :-)

The rest is all fair, but I'd like to point out that there are a few
problems here:

  * Tests should generally be passing before submitting upstream, so
all the code to implement them needs to be sent too
  * Submitted patch series have to be digestible sizes; not everything
can be submitted at once
  * Christian and Dscho wanted some of what I had implemented despite
other parts not being ready

Importantly, the first two issues in particular mean that when the
first series comes:

  * If you insist on (or even just suggest) certain changes that
happen to break capabilities in the pipeline, especially in a fashion
that cannot backward-compatibly be fixed, then I think the only path
forward (other than dropping your suggestions) is to engage in
discussions about those usecases & design *without* the testcases and
code being available yet.

> > Is it worth refactoring setup_revision() into more divisible chunks,
> > so that callers can make use of just the relevant parts of it?  We
> > have numerous other tools looking for revision ranges, which currently
> > accept full rev-list options and pass along user-supplied command-line
> > arguments to them.  Beyond rev-list/log/shortlog, these seem to
> > include at least:
> >   * fast-export
> >   * blame
> >   * cherry-pick
> >   * revert
> >   * format-patch
> >   * bisect (at least the skip subcommand)
> >   * stash (at least the show subcommand)
> >   * filter-branch (actually, as a horrible shell script, it'll
> > continue accepting all rev-list options anyway)
> >
> > Some of these could probably get away with non-contiguous revision
> > ranges, but most wouldn't find any benefit from:
> >   * tree/blob/packing options (e.g. --objects*, --unpacked, --filter*,
> > --verify-objects, --in-commit-order)
> >   * anything dealing with reflogs (e.g. --reflog, --walk-reflogs)
> >   * various forms of history simplification (e.g. --simplify-merges,
> > --simplify-by-decoration, --sparse, --show-pulls)
> >   * flags related to display (e.g. --pretty, --graph,
> > --show-signature, --early-output, --disk-usage, --abbrev-commit,
> > --relative-date, --log-size, --left-right, --cherry-mark)
> >   * flags related to file contents (e.g. <pathspecs>, --merge,
> > --follow, --full-diff, --remove-empty)
> >
> > Here's a fun and valid (and innocuous) command.  Guess which flags are
> > ignored and which aren't:
> >
> >   $ git stash show --graph --relative-date --min-parents=3D3
> > --simplify-merges --cherry --show-pulls --unpacked -v -t -8
> > --format=3Doneline --abbrev=3D12 --pretty=3Dfuller --show-notes
> > --encode-email-headers --always --branches --indexed-objects stash@{0}
>
> This investigation is exactly why I'm concerned about using the
> generic setup_revisions(). I've already noticed its use elsewhere
> and been disappointed. But I wasn't around when those were written,
> so you get the short straw and become the reason I bring it up.
>
> > That all said, while I like the idea of someone dividing
> > setup_revisions() into divisible chunks so tools can just use the bits
> > that are relevant, and doing so sounds like it'd avoid weird surprises
> > from use of unintended flags, I'm surprised that the solution to the
> > "setup_revisions() is scary" problem isn't to provide easy-to-use API
> > that allows selecting the relevant subsets for each command, but to
> > instead expect every one that comes along to do some heavy lifting and
> > special whitelisting.  We have half a dozen users in the tree already
> > facing these problems, so shouldn't these be fixed and the API made to
> > be easy to use more safely so that this problem is solved more
> > generally rather than just putting it on each future functionality
> > implementor who comes along to work around it in their particular
> > situation?
>
> I think a better API is a great idea! Splitting into multiple methods
> or providing option flags for "categories" of options allowed would
> also work.
>
> But back to my original suggestion: you can also do something simpler
> for v1 of git-replay

That's workable.

> (say, very limited revision parsing such as one A..B range)

I'm not fine with that, though.  We already have tests of multiple
positive refs, so there's no reason to exclude those.  In fact,
keeping them in is especially important as a means of avoiding having
other reviewers make suggestions to copy rebase's broken design
(namely, being limited to a couple commits passed as positional
arguments with one implicitly being an exclude).

> so your progress here isn't blocked on refactoring the revisions
> API.

Is that a positive or a negative?  That question may surprise you, so
let me explain.

I have a conflict of interest of sorts.  When Christian and Dscho
(separately) approached me earlier this year and pointed out that
git-replay had the functionality they wanted, I was happy that others
liked it, and gave some pointers here and there, but I was _very_
worried that upstreaming it would result in something getting
backward-incompatibly locked into place that prevents the pieces that
are  still in progress from getting implemented.  And I was concerned
that my plans to create a tool people could experiment with, and that
we could get usability feedback on (as I suggested at the Git
contributors summit last year) might be in jeopardy as pieces of its
functionality get locked into place before it's even ready for
usability testing.  I was silently hoping they'd lose steam on
rebasing and cleaning up my patches or choose to just delay until I
could get real time to work on it with them.  (Since then, the one
person who had ever advocated for my Git work at $DAYJOB, the best
manager I had ever worked under, became not-a-manager.  I was
blindsided by that in February.  Also, I have been transferred to a
different team and am spinning up there.  And so, to my dismay, I'm
worried my little sliver of Git time at work may evaporate entirely
rather than return to previous healthier levels.)  Anyway, I've been
fretting about things getting "locked-in" for a few months.

They didn't lose steam, as I found out when these patches were
submitted.  But, uh, I'm silently torn because I want to help
Christian and Dscho get what they want, but having them be blocked on
progress would reduce my stress.  A lot.

Is there any chance people would be willing to accept a "NO BACKWARD
COMPATIBILITY GUARANTEES" disclaimer on this command for a (long?)
while, like Victoria suggested at Review club?  That might be an
alternate solution that would lower my worries.
