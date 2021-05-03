Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D651C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426FD61185
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhECRm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhECRm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 13:42:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E1DC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 10:42:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 12so9231453lfq.13
        for <git@vger.kernel.org>; Mon, 03 May 2021 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fq2Unr3MII8p68L34sxfxoBp/SQv4MTLckYLuVX79ck=;
        b=EGdWpr/BLxY5IkamD29tT3vozAavgoPfW50aVqjSMjNsQAlD0fIcqLP5frRHikHYFD
         RRjd1wQgVu9EBcDtu49hdUj761FZuFDDsnicGw7wBzhFQ1HlauxIZvbuAzCZIddH9fsG
         1hakQehi4gNT8W6u/kyrCGUxSE+SgOfPvjKoMxGWBSyhUk7UbGmMm8n6J0fN6NhZdFxT
         d7AseYegCA6hcwyaf/v3fn4He6dEtpFnhq6WwBr9A/Gz1eXcpeB7NVE5m9wAomRvkTha
         Q2L2NdF1nW9vxJgA6c5p/8f+wIto1K6qw4VaWaoZh+Qmg89BREuK8pZrsgEV90DJ012F
         fyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Fq2Unr3MII8p68L34sxfxoBp/SQv4MTLckYLuVX79ck=;
        b=DEOrf6sDLNiWrmuIjL9H2c66HaqAvhhnBCPE0jgwVr+iN6WYka7kb8W9yevOK75QLO
         ER+1ERojAOP49p4vPLf+gePjoHZz/Mpdjl/FbTzWHq1eJD8ZL4Tv1Pomeh/tnsoaHVjR
         5r3Miax7qG68nb+kC3zBJvjwF/DIibG3A4+TANYfbAqjsiTmMcY9q1GJaVk4Hqp4JNU5
         4Coqxp1gtuwXstE/DtqEAwEWYcDabY7orKlQ0M9MbQaQdZjZgAPcQKuKk5IyCrrkglEE
         x5xuLnqmaMtawKHLGqcLgkpG9q1LTHBGSwNoiQJXktz/AoCNrtVLSVGlwL/I2jJ10aaF
         A3ag==
X-Gm-Message-State: AOAM532gYuUgl+WMNwteIWbX036lBjAm99mQEKm4ruEJYULlp4Wkd91E
        6TQWx1T1oDeqLWLx2x7paNihryB29/M=
X-Google-Smtp-Source: ABdhPJwUyjZtTl/qlUT711lb78xMxqRoBki6KvCth1px0sot5cgbbG/urtUOrVxPgqXc+xVGN+d9uw==
X-Received: by 2002:a05:6512:102a:: with SMTP id r10mr14009694lfr.224.1620063722071;
        Mon, 03 May 2021 10:42:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f17sm23328lfu.215.2021.05.03.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:42:01 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
Date:   Mon, 03 May 2021 20:42:00 +0300
In-Reply-To: <xmqqzgxfb80r.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        01 May 2021 09:41:08 +0900")
Message-ID: <87czu7u32v.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> Luckily,
>>>
>>>     $ git log [--stat] --diff-merges=first-parent master..seen
>>>
>>> seems to do almost the right thing, with respect to the "It is
>>> probably OK to special case" I gave above.
>>
>> I believe any special-casing is to be a last resort, and definitely is
>> not the right thing to do in this particular case.
>
> I do not know if I get it.  "log --diff-merges=<kind>" giving the
> same output as "log" (i.e. no trace of any kind of diff) would be
> puzzling to users, and to help them, it is OK to say that

I thought (apparently wrong) that the idea was to special-case "-m", and
only "-m". I.e., if -m is alone, let it imply -p, otherwise not. That
was the thing I was in opposition to.

>
>  * "--diff-merges=<kind>" enables some kind of diff output
>    automatially (for both merges and non-merges), and

No, I don't think this is OK, sorry. I fail to see why --diff-merges
should affect non-merge commits. I believe it shouldn't.

>
>  * when there is no user preference given as to what kind of diff is
>    desired, we default to "-p".

What kind of diff "-p" gives for merge commits, exactly? As far as I can
tell, it's "none".

>
> As it is natural to expect "--stat --diff-merges=<kind> would give
> only the diffstat without patch, we end up "special casing"
> "--diff-merges=<kind>" that is given alone, without specifying what
> kind of diff is desired, and behave as if "-p" was given.

In general, I hate dependencies between options. The only thing that is
actually needed for convenience is an ability for an option to imply
other options. What's currently there is already too complex for my
personal taste, and I'd hate to add even more complexity on top.

Right now --diff-merges is pretty simple and straightforward: it
specifies diff output for merge commits, and only for merge commits. If
any other option disables diff machinery altogether, it will disable
diff for merges as well.

OTOH, we have --patch that deals with non-merge commits.

Personally, I don't like the resulting interface very much, but it's
historical, and can't be easily changed.

> So I would have expected you to call this kind of "special casing" a
> good thing.

Well, even though I was originally commenting about -m only, I must
admit I'm in general against any "special casing", unless there is
extremely strong reason to consider it.

>
>>> It only "enables diff" for merge commits, which does not quite feel
>>> right and we may want to do the same "enable diff" for single parent
>>> commits,

I fail to see why --diff-merges should ever affect non-merge commits.
It'd be at least counter-intuitive, not to say directly opposite to the
original design goal.

>>> but the good part is that it does not blindly imply "-p".

Yep.

>>>
>>> It seems to do the "enable diff" the right way by honoring other
>>> command line options that specify the format of the diff, so with
>>> "--stat" included in the sample command line above, we get the
>>> diffstat for single parent commits (because we ask for "--stat" from
>>> the command line to show it throughout the history) and also for
>>> merge commits (because --diff-merges=first-parent does *not* blindly
>>> turn the textual patch '-p' on).
>>
>> Good to know! I must admit I did nothing special in this regard, just
>> paid attention to avoid breaking any existing logic, at least knowingly.
>>
>>>
>>>> [Footnote]
>>>>
>>>> *1* They are not limited to "-p", "--stat" and "--summary", but
>>>> you'd need to also pay attention to "--raw", "--name-only", etc.)
>>>
>>> I've merged the so/log-diff-merge topic to 'master', with this
>>> (possibly) known breakage that it does not do anything for single
>>> parent commits.  We may want to fix this last mile before the
>>> release that is scheduled to happen around early June.
>>
>> I have no idea what the breakage is or could be.
>
> Because I view
>
>  * "--diff-merges" is a way to specify how merge commits are passed
>    to the diff machinery (e.g. pass nothing to the diff machinery,
>    compare only with the first parent, etc.), and

As I see it, it only defines the way they are to be represented by the
diff machinery once passed to it, though it obviously depends on where
we put the margin of "diff machinery".

>
>  * "--patch", "--stat", "--cc" etc are to specify if we use the diff
>    machinery and what kind of output is desired.

So, in your view, --cc output is not a product of "diff machinery"?

> but we are conflating the "enable diff" feature into the former to
> match end-user expectation, if "--diff-merges" without any of the
> "--patch", "--stat", etc. enables the "--patch" output for merge
> commits, it would be confusing if we do not give the same "--patch"
> output for single-parent commits, too.
>
> But the current code gives "--patch" output only for merge commits,
> doesn't it?  E.g.

No, as far as I understand it, "--patch" output is for non-merge commits
only. One can't sensibly use patch utility to pick merge commits anyway,
so "--patch" makes no sense for merge commits and doesn't affect them,
at least for now.

>
>     $ git log --diff-merges=first-parent master..next
>
> would give patches only for merge commits, but

It will give the output similar to what "--patch" would give for
non-merge commits, yes, but in fact it's not "--patch" output, I think,
so I doubt it should be called "give patches". It's just happens to be
the same diff format.

>
>     $ git log --stat --diff-merges=first-parent master..next
>
> would give us diffstat for all commits, including merges (against
> their first parents).

Yep, but I think it just matches the old behavior that has been always
there, see below.

I'd start from the behavior even before my patches. Let's see:

  git log -n1 -p <merge_commit>
  git log -n1 --stat <merge_commit>
  git log -n1 --stat -p <merge_commit>

all give no diff no stat. No surprise for diff, though not that sure about
stat, but it could be argued either way.

  git log -n1 -c <merge_commit>

does give diff output in particular format, nice!

  git log -n1 --stat -c <merge_commit>

gives stat output, but no diff! That's not what I expected at all.
Effectively, this looks like --stat *disables* -c/-cc output?

Finally, the way to get both diff and stat for merge commits is... who'd
guess, adding -p to the command, and that provided -p is already
supposedly implied by -c (!):

  git log -n1 --stat -c -p <merge_commit>

In particular, this means that contrary to documentation, -c does not
imply -p in the common sense of the word "imply", and interdependencies
between all these options are already too complex to easily grok for a
human being.

As for newer --diff-merges, they behave similar to -c here that seems
reasonable. Overall, I still don't see any breakage introduced by
--diff-merges, and it seems to behave according to its documentation, so
shouldn't break any expectations either.

Getting back to the original question of letting -m imply -p, it
shouldn't behave differently than -c/-cc, that do imply -p, so I don't
see any significant problem that'd be added to the current status.

Right now the following two give exactly the same output:

  git log -n1 --stat -c <merge_commit>
  git log -n1 --stat -m <merge_commit>

the stat to the first parent, and it shouldn't change if we let -m "imply"
-p the same way -c "implies" -p, whatever it actually means.

Best Regards,

-- Sergey Organov
