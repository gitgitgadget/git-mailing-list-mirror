Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE555C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A9222DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgLETov (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgLETou (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:44:50 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37DDC0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:44:09 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s11so1849364ljp.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GRVMzH+lDLwcOVyOYay6XGS+ocxE3eLnCX4T50s4GvA=;
        b=EzaG8/B4jrLNII2Xrmzss2ki4JsxDHNPvvdU//BxtMspQ7V80NnjIs+Dytu8l9HXhS
         Ne/fLujl2tOKHORARx7xK9wg+Fbw8lSKg8l9Cs5quZ09P0xEYw74u6IAFXCLznlxTD2X
         uxutiNq8XckxPwtD4Ap3kJdLv0eJwji42Qo1IoP5bI8gVXDN/0RDKfmItF1yzk+L8w57
         mZhgfURKuMIbYKomE4eK5Xu4VnoKwoF+W8RSnbKTsxRELCBfhts1epJMS13eJk7Pc3UT
         tOhY8kcrlXeSuYqAr3CFbWU1IPC4fKWMheg9fgNotrkCg6VUe0tA2ptX/PZ1xmhwiIDA
         hu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=GRVMzH+lDLwcOVyOYay6XGS+ocxE3eLnCX4T50s4GvA=;
        b=iZVO+CVOohEGD4ZT3Q6EDcBsEw/DwoKImS8UrJaey4DKaTbn7yCB4dNnMPR8Jx5Sw+
         y15DnMso0lJrFXB+nDnhtDxDLgPHnOvPOtakNtsmWcQnC5QBhuOLTw+wlm0Wnkmnh0Nw
         58TdAD6lnbZqAWDdeuLNDqdhhkQCeQ0dHZnVIidFCoSUyzd5uJsbNC8Bm8y7FpsPOUHk
         bdkApbUfRLq0BZrcQi0ohWjCFzxOUF6jhSBdIMDpUChihZYmDke8QUAU9ioz5wLFDP3K
         sQ1Hcf2IyC+rqti27bMfbGApaxkIkWgqoWnQeobTVEWzIAZLumZYe3T+OLIdiCpN/Gxz
         5U2w==
X-Gm-Message-State: AOAM533fV+w/Wo84bG9PnUXs7ckP2fwZq118ZkFIyZav9FSmPte/DevS
        NpT6qVDdU86vdQYyXGfUG6rAdWlqtXc=
X-Google-Smtp-Source: ABdhPJwni6PEMkUF6lTVPRGRUEvRPPJfiGORlb9au1d2ixifuiLKA7qbP4TSagbADxj+z3wT1tLJBw==
X-Received: by 2002:a2e:9cd3:: with SMTP id g19mr5468907ljj.188.1607197445812;
        Sat, 05 Dec 2020 11:44:05 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b7sm2502395ljf.76.2020.12.05.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:44:04 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 00/27] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com>
        <871rg6hdrk.fsf@osv.gnss.ru>
        <CABPp-BGE4rA5=8NUaK5607moR13bE7PcyVKdbw6nDw5YBeq9bQ@mail.gmail.com>
        <87sg8lnzor.fsf@osv.gnss.ru>
        <CABPp-BFB9aaJV1uvYk1QQ6E8zQ=_Jv6KhHb1grA5+Bh+qsTG8g@mail.gmail.com>
Date:   Sat, 05 Dec 2020 22:44:03 +0300
In-Reply-To: <CABPp-BFB9aaJV1uvYk1QQ6E8zQ=_Jv6KhHb1grA5+Bh+qsTG8g@mail.gmail.com>
        (Elijah Newren's message of "Sat, 5 Dec 2020 09:49:14 -0800")
Message-ID: <878sacjaws.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 4, 2020 at 11:23 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Thu, Dec 3, 2020 at 11:48 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Elijah Newren <newren@gmail.com> writes:
>> >>
>> >> > On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov
>> >> > <sorganov@gmail.com> wrote:
>> >> >>
>> >> >> These patch series implement new set of options governing the
>> >> >> diff output
>> >> >> of merge commits, all under the umbrella of the single
>> >> >> --diff-merges=<mode>
>> >> >> option. Most of the new options being synonyms for -m/-c/--cc options,
>> >> >> there is also additional functionality provided, allowing to get
>> >> >> the format
>> >> >> of "-p --first-parent" without change in history traversal that
>> >> >> --first-parent option causes.
>> >> >>
>> >> >> The net result of these series are the following new options:
>> >> >>
>> >> >> --diff-merges=   |  old equivalent
>> >> >> -----------------+----------------
>> >> >> first-parent     | --first-parent (only format implications)
>> >> >> separate         | -m
>> >> >> combined         | -c
>> >> >> dense-combined   | --cc
>> >> >
>> >> > Interesting.  I have some local patches implementing another choice,
>> >> > with the new flag --remerge-diff.  This flag will cause `git show` or
>> >> > `git log` to automatically remerge the two parents in a 2-parent merge
>> >> > commit, and then diff the merge commit against that automatic merge,
>> >> > showing the result.  Thus, the diff for a merge commit is likely to be
>> >> > empty if the merge was clean, and is likely to show the removal of
>> >> > conflict markers if the merge was not clean.
>> >> >
>> >> > I'm curious how it'd interact with this new option.  Would it also get
>> >> > a name, e.g. --diff-merges=remerge-diff?  Feels like a mouthful, but I
>> >> > can't come up with anything better.
>> >>
>> >> Maybe, --diff-merges=remerge?
>> >>
>> >> >
>> >> > Also, I'm curious how it'd interact with another option I added, named
>> >> > --remerge-diff-only.  This latter option modifies revision traversal
>> >> > in that it skips octopus merges, root commits, and single parent
>> >> > commits IF no cherry-pick or revert information can be found.  If it
>> >> > finds a 2-parent merge commit, it behaves like --remerge-diff.  If it
>> >> > finds a 1-parent commit with cherry-pick or revert information, it'll
>> >> > do an in memory repeat of that cherry-pick (or revert) and then diff
>> >> > the actual commit against what the automatic cherry-pick would
>> >> > perform.  Again, that likely means an empty diff if the automatic
>> >> > cherry-pick was clean, and showing any changes made by the user to
>> >> > complete the original cherry-pick (such as deleting conflict markers
>> >> > and picking which chunks from which side to keep) if the automatic
>> >> > cherry-pick was not clean.  (I suspect --remerge-diff-only is much
>> >> > more likely to be used with `git show` than with `git log`.)  Anyway,
>> >> > your changes seem to suggest that anything relating to how diffs for
>> >> > merges are handled should be documented in the same section, but
>> >> > --remerge-diff-only doesn't fit.  And it'd seem odd to have
>> >> > --remerge-diff and --remerge-diff-only not show up in adjacently but
>> >> > be split into separate sections.  Any ideas?
>> >>
>> >> Sounds like commits limiting option to me. I think it could be named by
>> >> its limiting behavior only, say, --remerges. Then it will imply
>> >> --diff-merges=remerge, that'd allow user to re-define diff format if she
>> >> needs to.
>> >
>> > It is commit limiting, but the focus is more on the behavioral change
>> > in how diffs are shown:
>> >   * for 2-parent merges
>> >   * for single-parent commits with cherry-pick or revert information
>> > and acknowledging that since it has _altered_ the normal way of
>> > showing diffs for a number of single-parent commits, that it'd be
>> > confusing to show normal diffs of unaffected commits (how would you be
>> > able to tell what type of diff you're looking at if both appear in the
>> > log?).  Thus, it does commit limiting to only select commits which
>> > will make use of the new diff type.
>>
>> That's how you currently look at it.
>>
>> For me it looks like pure commit limiting with these criteria might be
>> useful by itself, and with my suggestion one could then achieve it
>> using, say:
>>
>> --remerge-diff-only --diff-merges=off
>
> I see what you're saying, and I think there's some value in it.  But I
> think there's something still missing.  For example, you suggest
> getting the commit limiting I mention with
>
>     --remerge-diff-only --diff-merges=off
>
> But --diff-merges is only supposed to control _merge_ commits, which I
> flagged as the big impedance mismatch for my new option.  Why would it
> turn off diffs for non-merge commits like cherry-picks and rebases?
>
>> >
>> > (I suspect it will be more common for folks to use the
>> > --remerge-diff-only option, or whatever we end up calling it, with
>> > `git show` where the commit limiting doesn't matter -- but I have used
>> > it with log to go looking for "evil" reverts/cherry-picks that might
>> > have occurred in history.)
>>
>> What you describe is complex enough to doubt it could be entirely
>> described by option name, so shorter --evils might be better choice
>> in this case.
>>
>> Overall, if you add --diff-merges=remerge as a new diff format, and then
>> --evils that implies the former, then it seems like all possible
>> use-cases will be covered, and you have short option name for the most
>> useful case.
>
> Since you want things to have orthogonal subcomponents that can be
> built up, let's assume we did make --remerge-diff-only be solely about
> commit limiting.  In that case, --evils could be gotten by specifying
> a combination of flags, and --evils would just be a shorthand.  What
> are the flags that you would need to specify, though?  In particular,
> you've only named two options above and they don't cover the necessary
> behavior; a third is needed:
>
>    --remerge-diff-only --diff-merges=remerge
> --${DIFF_OPTION_NAME_FOR_CHERRY_PICKS_AND_REVERTS}=remerge
>
> The first two aren't enough because --diff_merges only changes how
> diffs for _merge_ commits are shown, and we need a flag for changing
> how the single-parent cherry-pick and reverts are shown.

Yeah, I see your point. I didn't get it from the beginning that you want
yet another representation format for regular commits as well. However,
as far as I can tell, if --evils flag is active, you do consider
cherry-picks and reverts as kind of merges, that makes sense as they
actually /are/ expected to be results of specific /merge operation/,
even though they are not /merge commits/, so semantically they do have
second parent reference (to the original commit), even if a virtual one.

To further illustrate my point, reverts and cherry-picks could have been
implemented, for example, as merge commits with, say, 3-rd parent
pointing back to the original commit (not 2-nd parent, both to
differentiate from regular merges and to support cherry-picking of merge
commits.)

As a side-note, people rarely differentiate between
"merge-the-operation" and "merge-the-result" anyway, even when it leads
to confusion.

Overall, if we take the above into account, it seems to be fine if
--diff-merges does affect the representation or such "quasi-merge"
commits, for the purposes of --evils option.

-- Sergey Organov
