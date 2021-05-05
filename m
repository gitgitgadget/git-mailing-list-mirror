Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDB3C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEAC613BA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhEENoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhEENoy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:44:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CAC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 06:43:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y9so2524807ljn.6
        for <git@vger.kernel.org>; Wed, 05 May 2021 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7WqIS7KnoU1sCHqugzsK5I3ZoCQ73m5JOKlR7TP97D4=;
        b=fXP8arlHwBvxh02TZyxGUH1M67NbPIUyjnhvEi7LXvcwGnvtfrpYaiWHCjpZNPmWb2
         Fmreu10UafArZv1VPiQHBlBWt1wSggvbfz7Nkzv8zrsJFlHBF/y6t82b8+rdlR+nTUoM
         BnLupBNuwj/+SUjpSDR7LUjd7VlEKA+Z8yDKGk7yan2AyA41kCWVswtQnEH7F1Ts5dGr
         4EB0SdaTpB5QtstCUSRsZxbXI6RFDcbsg7GA6TYavtXZrGUyRrAA8/GBC/J2dvkWIMBb
         +4nMWuD7jaAwEs4uPF1IUkukXg/IyINSZYMCEzQGRe3d7SRPCMea/bqyc35mXASuUexm
         35BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=7WqIS7KnoU1sCHqugzsK5I3ZoCQ73m5JOKlR7TP97D4=;
        b=jgVwEn6kFQGPiO9MyjKmVn/ozn66YOm13N5TZ/UQRy+MSazxmmFw6dEQ7ehIksWS3S
         66zYmCZUhdP05h3bIQnni/MYBUn19F4O8SYDtWQmjV3wIlqEy2/iC6ix07weG6kl9DH6
         iISdtfM1df2JLVbIZvXg7FNYwo5jrnonFN5PBYzryaySwwKxXkjTjhrhScNaSuayKFQu
         tYS1P9BuUWq1f85AAII6+V2Nk9WyAFesURh1Ha2++Z1x/2M05MnPOLl7IppP8P0sxjch
         aiaxKp0pgUD0NbHtE4f5FJFfeyx+Wp/Tuy7tc+jRAFyIK/LWaW3G3Epvje0mqB8ZCTLR
         DAJA==
X-Gm-Message-State: AOAM531P/aaQlx65TSYLMjUwkZYLZTVP1V5FAP3ef/eWDyKo1FL7xWKM
        7ifUwEOU2FN4IR9ZDxUlM6pvPWAr++k=
X-Google-Smtp-Source: ABdhPJwdxW2PFOX9j16c6geMr9Ij6igFzWNgDencJWRI2CJSAzs3bVcgPXteuph2YH4pXyvIK8brHg==
X-Received: by 2002:a2e:2416:: with SMTP id k22mr2806334ljk.332.1620222235505;
        Wed, 05 May 2021 06:43:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p18sm2115762ljo.75.2021.05.05.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 06:43:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
        <87eeemhnj4.fsf@osv.gnss.ru> <xmqqbl9q7jxf.fsf@gitster.g>
        <87r1imbmzz.fsf@osv.gnss.ru> <xmqqy2cu58vo.fsf@gitster.g>
Date:   Wed, 05 May 2021 16:43:53 +0300
In-Reply-To: <xmqqy2cu58vo.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        05 May 2021 09:20:27 +0900")
Message-ID: <87tunh9tye.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> I thought I already said this, but in case I didn't, I think
>>> "--diff-merges=separate" should imply "some kind of diff", and not
>>> necessarily "-p".
>>
>> Is this a more polite way to say "no"? If not, how is it relevant for
>> -m, now being a synonym for --diff-merges=on?
>
> Sorry, I didn't mean to say "no" to anything.

To me "no" is as good answer as any, I just want to reach better
understanding.  

>
> I wrote 'separate' not because I wanted to special case that (and
> treat others like 'on' differently), but simply because I didn't
> want to write "--diff-merges=<anything>" as "off/no" should not
> imply "show some kind of diff".
>
>> As for particular idea, I'll repeat myself as well and say that I'm
>> still against implying anything by any off --diff-merges, and even more
>> against implying something that affects non-merge commits. --diff-merges
>> are not convenience options that need to be short yet give specific
>> functionality, so there is no place for additional implications.
>
> So -m (a shorthand for --diff-merges=on) should not imply any patch
> generation, you mean?

No, I don't mean it. The idea is to let -m be alias for
"--diff-merges=on -p", exactly the same way --cc is currently
essentially an alias for "--diff-merges=dense-combined -p".

What I meant is that --diff-merges itself should not imply any patch
generation for non-merge commits, so --diff-merges=on should not imply
-p.

> It matches what we seem to have agreed on to be the purist view in a
> few messages ago. --diff-merges controls which parent(s) comparison is
> made against in a merge, -p/--cc/--raw/--stat etc. control how the
> result of that comparison is expressed.

I see this as your vision, but I don't recall we agree on it. At least
that's not how it currently works, as far as I can tell, see command
examples I gathered in one of my previous answers.

>
> But I also remember that we agreed that the purist view design was
> cumbersome to use, so --diff-merges=<anything but no> implying "show
> some kind of diff" is OK, plus if nobody says "what kind" via the
> command line with -p/--cc/--raw/--stat etc., it is OK to default to
> '-p'.

The latter part of this sentence is something rather new to me, that
only appeared in this particular thread of discussion recently, and it
does not match my own vision. Neither my vision of the current
implementation nor of what we should aim for.

>
> One thing I think our unnecessary "disagreement" comes from is that
> among "-m", "--cc", "-c", you say "-m" is the only thing that does
> not imply "-p", but I do not view "--cc" and "-c" as sitting next to
> "-m" at all in the first place.

I was sure you rather did when we've discussed it the last time before
this thread. Now your opinion seems to have changed, and I don't see
why. In fact I'm very confused. As far as understood, that time you said
that -m has been simply overlooked when --cc/-c started to imply -p, and
that you actually don't care about -m that much anyway.

I also recall you said that -c (and later --cc) has been invented as
alternative to not that useful -m, so -m, -c, and -cc have always been
exactly sitting next to each other in my view.

> "-m" is on the "which parent(s) to compare with" side,

This has never been the case, has it? See:

  -m
      This flag makes the merge commits show the full diff like regular
      commits; for each merge parent, a separate log entry and diff is
      generated. An exception is that only diff against the first parent
      is shown when --first-parent option is given; in that case, the
      output represents the changes the merge brought into the
      then-current branch.

  -c
      With this option, diff output for a merge commit shows the
      differences from each of the parents to the merge result
      simultaneously instead of showing pairwise diff between a parent
      and the result one at a time. Furthermore, it lists only files
      which were modified from all parents.

First, -m doesn't select the parents at all and shows "full diff", so it
rather defines the format. And second, -c is described exactly as being
alternative format to -m, as far as I can tell, making -c sit right next
to -m again, contrary to what you say above.

BTW, I recall I once suggested something like what you said, let -m
match what in means in cherry-pick, to what parent(s) to compare, but
it'd need -m to take (optional) argument(s), that has been considered
unacceptable, so the idea has been rejected (and for the better.)

> while "--cc" and "-c" are "now you decided which parent(s) to compare
> with, how does the result of comparison presented?" side. And because
> "--cc"/"-c" explicitly wants to work on merge commits (because it
> naturally degenerates to simple "--patch" for non merges), THEY are
> made to imply "-m" (i.e. compare with all parents).

That's a reasonable interpretation. The problem is that currently this
does not match nor design, nor implementation, nor documentation at all,
as far as I can tell.

> So from my point of view, "--cc/-c" implying "-m" has no relevance
> to whether "-m" should or should not imply "some kind of comparison
> should be shown".

What you describe is a different design that may well be a good one, but
do we actually want to change what's already there? What for?

>
> But because we agreed that we want to bend the purist view for
> usability and included cc/c among the choices diff-merges=<choice>
> can take, I think -m (but not log.diffMerges=no case) should imply
> "we should show some kind of patch".

Once again, this doesn't fit into the current design, as far as I can
tell, or I misunderstand the design, that could well be the case as
well.

>
> Which would mean that unless when log.diffMerges or --diff-merges
> say off/no, and unless there is any option to specify how the result
> of comparison should bepresented on the command line:
>
>  - when log.diffMerges or --diff-merges say cc or c, default to --cc
>    or -c.
>
>  - otherwise,default to --patch.
>
> is what I think should happen.  But the reason I think so is not
> because "--cc" and "-c" gives output without "-m" (i.e. "-p" does
> not imply "-m" and it should not).

I don't like this so far. Considering -m to be just one of different
formats to represent merge commits (among -c and --cc), as it has always
been, looks more straightforward and useful to me.

Besides, all the recent design I authored assumed -m to be just that,
one of multiple ways to specify how to represent merge commits, the
other 2 being -c and --cc. If we decide to change this view, it'd likely
need significant re-design, and I'm yet to see any actual advantages.

If, on the other hand, it's just me who fundamentally misunderstands the
design, then I need to be corrected fast, before I make significant
damage.

Thanks,

-- Sergey Organov
