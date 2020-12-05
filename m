Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFDC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1582311B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLEUKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 15:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEUKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 15:10:22 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E78C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 12:09:35 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h18so4766371otq.12
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 12:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynEcRcM6rJmVOrt5bnlTDUmZfXeXFuRl7uVzFkEd6dc=;
        b=sd/Jj3yiTwO+rVkdoYTUNCkK1po+NX/bFUCq/1vS6iWFnvLq/2ApUBFeWQVLMzKoqA
         Tq5JCRtKv4Kj1wPtlGgyRsJjAObO4aTi3klH2/Tr6yOaqxPiXuvpQJZ5/KuWB5tVAJos
         OxTP2EOdyqhRgzhp3xfmiBrjLgN/22IWkIMOERF2S1tMfhtvN7sL9TH7Jb9KMLMV3eAN
         AjGySYZWFuZqwHTkgMHRro8GQQzjnlG1t/bm7Md45EkSJ03n+13YkBFDSAeK73WFZCbz
         8ViyemSMBkIDhjcLzEl6Y+v4xkl2Py3b4DMnxbwAL6qAUBIG8mSa2hX3WtQTKS5UaTkM
         gRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynEcRcM6rJmVOrt5bnlTDUmZfXeXFuRl7uVzFkEd6dc=;
        b=C5OR3f1QASZR1fdrjP//qxwFO0lkA4bITp9P4aGaNETbMx5BRfKJBoN4cVwFoZj8oS
         PJHMWdfSazVo6f0UuzoFlGGPkgWz9Yzx9mhdjUoh9OULfmhFY8Etppzh3BGXJv0SrYfi
         oKbxPRSu3A+yp0I5y+xfAz+/Umyjw0U13iJ1pM1J2uXOrtyOchFI+gBD/jcVUnupYl+4
         uCQUpT470YIlsi4grBYsbqKOIZIwSlqtAjE2I0xyixq+Fyq4qA24e8ekYtPRr914bzE1
         wBkVuOHtrXnvduoHbj1OTC+4PZCnnHNWIbDTDt42/weUmOXlEDmbig3PGGLhe0op44GS
         5tuw==
X-Gm-Message-State: AOAM532Yj6zCusIPJFjtb5I/KwJZuCRMw0Yk260+E1nlTHsRTe6vBHtv
        Z8Q2XWmaX0fASuVGUj8di9WHNJ/UZhlJdpbhOek=
X-Google-Smtp-Source: ABdhPJyVx7mp1DgnsCIkyTsrA6UGSjLcwdYpSHIrVaBPyckqXVbkhhV869gBOtiGz+ipSXwA3jD11Pyzo/XrX4jOrFg=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr5954657oth.316.1607198974873;
 Sat, 05 Dec 2020 12:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com>
 <871rg6hdrk.fsf@osv.gnss.ru> <CABPp-BGE4rA5=8NUaK5607moR13bE7PcyVKdbw6nDw5YBeq9bQ@mail.gmail.com>
 <87sg8lnzor.fsf@osv.gnss.ru> <CABPp-BFB9aaJV1uvYk1QQ6E8zQ=_Jv6KhHb1grA5+Bh+qsTG8g@mail.gmail.com>
 <878sacjaws.fsf@osv.gnss.ru>
In-Reply-To: <878sacjaws.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Dec 2020 12:09:23 -0800
Message-ID: <CABPp-BFWsdb3ECcvQjN7_v2krsKAqhqv3CDWvQ9d20Oy521Vag@mail.gmail.com>
Subject: Re: [PATCH v1 00/27] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 11:44 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Dec 4, 2020 at 11:23 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Thu, Dec 3, 2020 at 11:48 AM Sergey Organov <sorganov@gmail.com> wrote:
> >> >>
> >> >> Elijah Newren <newren@gmail.com> writes:
> >> >>
> >> >> > On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov
> >> >> > <sorganov@gmail.com> wrote:
> >> >> >>
> >> >> >> These patch series implement new set of options governing the
> >> >> >> diff output
> >> >> >> of merge commits, all under the umbrella of the single
> >> >> >> --diff-merges=<mode>
> >> >> >> option. Most of the new options being synonyms for -m/-c/--cc options,
> >> >> >> there is also additional functionality provided, allowing to get
> >> >> >> the format
> >> >> >> of "-p --first-parent" without change in history traversal that
> >> >> >> --first-parent option causes.
> >> >> >>
> >> >> >> The net result of these series are the following new options:
> >> >> >>
> >> >> >> --diff-merges=   |  old equivalent
> >> >> >> -----------------+----------------
> >> >> >> first-parent     | --first-parent (only format implications)
> >> >> >> separate         | -m
> >> >> >> combined         | -c
> >> >> >> dense-combined   | --cc
> >> >> >
> >> >> > Interesting.  I have some local patches implementing another choice,
> >> >> > with the new flag --remerge-diff.  This flag will cause `git show` or
> >> >> > `git log` to automatically remerge the two parents in a 2-parent merge
> >> >> > commit, and then diff the merge commit against that automatic merge,
> >> >> > showing the result.  Thus, the diff for a merge commit is likely to be
> >> >> > empty if the merge was clean, and is likely to show the removal of
> >> >> > conflict markers if the merge was not clean.
> >> >> >
> >> >> > I'm curious how it'd interact with this new option.  Would it also get
> >> >> > a name, e.g. --diff-merges=remerge-diff?  Feels like a mouthful, but I
> >> >> > can't come up with anything better.
> >> >>
> >> >> Maybe, --diff-merges=remerge?
> >> >>
> >> >> >
> >> >> > Also, I'm curious how it'd interact with another option I added, named
> >> >> > --remerge-diff-only.  This latter option modifies revision traversal
> >> >> > in that it skips octopus merges, root commits, and single parent
> >> >> > commits IF no cherry-pick or revert information can be found.  If it
> >> >> > finds a 2-parent merge commit, it behaves like --remerge-diff.  If it
> >> >> > finds a 1-parent commit with cherry-pick or revert information, it'll
> >> >> > do an in memory repeat of that cherry-pick (or revert) and then diff
> >> >> > the actual commit against what the automatic cherry-pick would
> >> >> > perform.  Again, that likely means an empty diff if the automatic
> >> >> > cherry-pick was clean, and showing any changes made by the user to
> >> >> > complete the original cherry-pick (such as deleting conflict markers
> >> >> > and picking which chunks from which side to keep) if the automatic
> >> >> > cherry-pick was not clean.  (I suspect --remerge-diff-only is much
> >> >> > more likely to be used with `git show` than with `git log`.)  Anyway,
> >> >> > your changes seem to suggest that anything relating to how diffs for
> >> >> > merges are handled should be documented in the same section, but
> >> >> > --remerge-diff-only doesn't fit.  And it'd seem odd to have
> >> >> > --remerge-diff and --remerge-diff-only not show up in adjacently but
> >> >> > be split into separate sections.  Any ideas?
> >> >>
> >> >> Sounds like commits limiting option to me. I think it could be named by
> >> >> its limiting behavior only, say, --remerges. Then it will imply
> >> >> --diff-merges=remerge, that'd allow user to re-define diff format if she
> >> >> needs to.
> >> >
> >> > It is commit limiting, but the focus is more on the behavioral change
> >> > in how diffs are shown:
> >> >   * for 2-parent merges
> >> >   * for single-parent commits with cherry-pick or revert information
> >> > and acknowledging that since it has _altered_ the normal way of
> >> > showing diffs for a number of single-parent commits, that it'd be
> >> > confusing to show normal diffs of unaffected commits (how would you be
> >> > able to tell what type of diff you're looking at if both appear in the
> >> > log?).  Thus, it does commit limiting to only select commits which
> >> > will make use of the new diff type.
> >>
> >> That's how you currently look at it.
> >>
> >> For me it looks like pure commit limiting with these criteria might be
> >> useful by itself, and with my suggestion one could then achieve it
> >> using, say:
> >>
> >> --remerge-diff-only --diff-merges=off
> >
> > I see what you're saying, and I think there's some value in it.  But I
> > think there's something still missing.  For example, you suggest
> > getting the commit limiting I mention with
> >
> >     --remerge-diff-only --diff-merges=off
> >
> > But --diff-merges is only supposed to control _merge_ commits, which I
> > flagged as the big impedance mismatch for my new option.  Why would it
> > turn off diffs for non-merge commits like cherry-picks and rebases?
> >
> >> >
> >> > (I suspect it will be more common for folks to use the
> >> > --remerge-diff-only option, or whatever we end up calling it, with
> >> > `git show` where the commit limiting doesn't matter -- but I have used
> >> > it with log to go looking for "evil" reverts/cherry-picks that might
> >> > have occurred in history.)
> >>
> >> What you describe is complex enough to doubt it could be entirely
> >> described by option name, so shorter --evils might be better choice
> >> in this case.
> >>
> >> Overall, if you add --diff-merges=remerge as a new diff format, and then
> >> --evils that implies the former, then it seems like all possible
> >> use-cases will be covered, and you have short option name for the most
> >> useful case.
> >
> > Since you want things to have orthogonal subcomponents that can be
> > built up, let's assume we did make --remerge-diff-only be solely about
> > commit limiting.  In that case, --evils could be gotten by specifying
> > a combination of flags, and --evils would just be a shorthand.  What
> > are the flags that you would need to specify, though?  In particular,
> > you've only named two options above and they don't cover the necessary
> > behavior; a third is needed:
> >
> >    --remerge-diff-only --diff-merges=remerge
> > --${DIFF_OPTION_NAME_FOR_CHERRY_PICKS_AND_REVERTS}=remerge
> >
> > The first two aren't enough because --diff_merges only changes how
> > diffs for _merge_ commits are shown, and we need a flag for changing
> > how the single-parent cherry-pick and reverts are shown.
>
> Yeah, I see your point. I didn't get it from the beginning that you want
> yet another representation format for regular commits as well. However,
> as far as I can tell, if --evils flag is active, you do consider
> cherry-picks and reverts as kind of merges, that makes sense as they
> actually /are/ expected to be results of specific /merge operation/,
> even though they are not /merge commits/, so semantically they do have
> second parent reference (to the original commit), even if a virtual one.
>
> To further illustrate my point, reverts and cherry-picks could have been
> implemented, for example, as merge commits with, say, 3-rd parent
> pointing back to the original commit (not 2-nd parent, both to
> differentiate from regular merges and to support cherry-picking of merge
> commits.)
>
> As a side-note, people rarely differentiate between
> "merge-the-operation" and "merge-the-result" anyway, even when it leads
> to confusion.
>
> Overall, if we take the above into account, it seems to be fine if
> --diff-merges does affect the representation or such "quasi-merge"
> commits, for the purposes of --evils option.

Yeah, that could make sense.  We'd still need some additional flag.
One flag, perhaps --diff-merges=remerge, would be the one that would
_only_ affect actual two-parent merges (which I use as the default
instead of --cc with `git show`, and which I make implied by default
with `git log --patch` at $DAYJOB), and we'd need another name for
whatever turned those special diffs on for cherry-picks and reverts.
Further, the extra flag that turns on special diffs for cherry-picks
and reverts should turn off diffs entirely for any other single-parent
commits.  (I think it's just too confusing for any command to show
multiple single-parent commits with a mixture of different types of
diffs.)
