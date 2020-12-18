Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F4C2D0E4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5641F23406
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgLRWHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLRWHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 17:07:12 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF23C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:06:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id l207so4477328oib.4
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3GBRrHKN/ZR5Tzg473hrbZDDgpzAZDvl52KGmRN0XI=;
        b=mO/wHO6cUvUDOp5TZUI0w1B+eqhsT9rHnuP/B8/ZjtrBxbAztjsaNv6gjxfHtW2Wn5
         vS8m3AeI+E24p2iqoC1cbIA7RZ5hnfNU3MBIk1PG4OjI93DfYG01SvEoCUjgCWTaPFVb
         iy39XqQKKnVZA+Im7Epi/nGg4ePrUE8jkJJBTWv6ntesQlYJfZ43VQd/PDYCHyW8Lx4g
         28XlMiZsm/f8MVUsUn0GdjDBMQZ+rAOViYrbmBjn86XARLUeAV7c3un6BIx0JuUCUp1o
         HNEDBtBxSlcUOkG84EnPBP1BNwGAkf5qSop3S9Sueq43XcbBPx7KFaCqJk7FKc5geQYg
         /o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3GBRrHKN/ZR5Tzg473hrbZDDgpzAZDvl52KGmRN0XI=;
        b=riXHXOBCfL4/fWEnLMoIYGR6pxgHRYF9imaQ/N6SqrDWf5o1Xc2yu5X5vrrMiqsDHa
         /Ylc2Ky/niZkTEGKPHmD2LXYTk+iWr9k8ypfdRw6DGfEcgmmXx6lo6gkRx7fsa66X2n+
         GllYDawkD1KTNjtw3M4DrO6GzOfZsQM2AXSNXiJXSW41XJcPQkr/++kJmKABM1PJpstM
         5vJrkrydIVXENFWeXj7BUdho4TkwwsnDnC5neE/BNKYVQWGq5eb0dDYVl4mkmT65hM8x
         /mNMGnACAv6ulK5mTf9Q25m20EoaFEj+O4fOIUGkF0ubCLsfgn3/fLmOaDGHax8nbHP1
         Hh5w==
X-Gm-Message-State: AOAM532ypTCAEQ2fArlp1603Heqgk2jR4hSset2MENiCHCkhL+RgQMpv
        agvbwD/+n97jzjEz5SVwPTS8bwF+ysL6SE+Jixg=
X-Google-Smtp-Source: ABdhPJyrcGEHKJlTZhf5aENuWnKxPeqkQQqKs8m+X08kEFelsQUevqpm0VjMUhMehNUASdlFEYYo49eHLKnTXuEu7Zk=
X-Received: by 2002:aca:3151:: with SMTP id x78mr4198608oix.39.1608329191233;
 Fri, 18 Dec 2020 14:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-27-sorganov@gmail.com> <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
 <87wnxfb2gt.fsf@osv.gnss.ru> <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
 <87o8iq97o2.fsf@osv.gnss.ru>
In-Reply-To: <87o8iq97o2.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 14:06:20 -0800
Message-ID: <CABPp-BF6YyNNYT1i_56=89TjtKEj09bs6TOXJWYKXsC6yAZ0Rw@mail.gmail.com>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff without -p
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 12:32 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Dec 18, 2020 at 6:42 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> [...]
>
> >> >> diff --git a/log-tree.c b/log-tree.c
> >> >> index f9385b1dae6f..67060492ca0a 100644
> >> >> --- a/log-tree.c
> >> >> +++ b/log-tree.c
> >> >> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
> >> >>         int showed_log;
> >> >>         struct commit_list *parents;
> >> >>         struct object_id *oid;
> >> >> +       int is_merge;
> >> >> +       int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
> >> >
> >> > So rev_info.diff has changed in meaning from
> >> > commits-need-to-show-a-diff, to non-merge-commits-need-to-show-a-diff.
> >> > That's a somewhat subtle semantic shift.  Perhaps it's worth adding a
> >> > comment to the declaration of rev_info.diff to highlight this?  (And
> >> > perhaps even rename the flag?)
> >>
> >> No, the meaning of rev_info.diff hopefully didn't change. rev_info.diff
> >> still enables all the commits to pass further once set. It is still
> >> exactly the same old condition, just assigned to a variable for reuse.
> >> My aim was to avoid touching existing logic of this function and only
> >> add a new functionality when opt->merges_need_diff is set.
> >>
> >> It looks like I rather choose confusing name for the variable, and it'd
> >> be more clear if I'd call this, say:
> >>
> >>   int need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
> >>
> >> ?
> >>
> >> What do you think?
> >
> > I think need_diff would actually be confusing.  It can be false when
> > you need diffs (e.g. --diff-merges=cc with no -p, because then you'd
> > need diffs for merge commits and not for non-merge commits).  I'd
> > stick with your original local variable name.
> >
> > Perhaps opt->diff hasn't changed meaning and I just had a wrong mental
> > model in my head for what it meant, but even then what seems like its
> > obvious purpose given its name is mismatched with what it actually
> > does.  Since you are already changing struct rev_info in this series,
> > this was more a note that a name change or at least a comment for
> > opt->diff might be useful.  I mean, you asked a couple times on the
> > previous series for help trying to understand it, and I could only
> > offer some flailing guesses and Junio responded with a couple bits of
> > history.  Clearly, it isn't very clear and this patch reminded me of
> > that and made me wonder if we're possibly making it a little harder
> > for others further down the road to figure out.
>
> I still don't see why opt->diff is needed in the first place, and
> second, why opt->diffopt.flags.exit_with_status check is here? Why
> whoever sets opt->diffopt.flags.exit_with_status doesn't just set
> opt->diff as well (provided opt->diff is needed in the first place)?
>
> From the aforementioned discussion it looks like opt->diff is an
> optimization (maybe a remnant from the times when diff was a separate
> script), and that apparently there is some code instance somewhere that
> actually relies on the fact that clearing opt->diff is enough to disable
> diff machinery (as followed from my experiment of removing the check
> altogether and then getting only single seemingly unrelated test
> failing.)
>
> Overall, neither have I any idea how to clarify this, nor do I want to
> bother in this patch series. It'd be nice though if somebody who really
> does understand diff machinery in Git does the job.

Doh, I was hoping you had it all figured out.  If not, then that's a
fair enough argument not to attempt to clarify.
