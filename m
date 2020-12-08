Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F0C2BB40
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F276239FD
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgLHWb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731512AbgLHWb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:31:26 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB8FC061794
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:30:40 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id x23so22115lji.7
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kxFFkkuwjXZlJ//kcm/u9Hykr9r/CGYMUv96Z4HU/3M=;
        b=YFwJqyiXTNE26S3XLf01X+ofZw6ZQa4TxjuDvk9LbsDjVSICreMYUT19i0fXp0wWt1
         BR5dmg/V+HWs9X3gB8yRpg3jCfipzHq8NInK7CHdNC9qOGFAPLpE+lUd3ddtaDIz6l+n
         TSyzsmjbnxAdtKXn+xAVurMD9H3tLLYl3LTUqPaccsMTFS3Z26p+7aD9ryeCR9+V2anW
         TSdKh1gYpo7FmBBYbjrrdITMsop8riAzEPltDQR2UT9pOnl4obxAVVa9+Sr1Ns4gwLCW
         4Oyfn6G5RxwYdt3axCN/MtYg21p1dK7i0J4mR3h+bJolX7pM8+MwCuH2hBYVjasqaEh0
         iCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=kxFFkkuwjXZlJ//kcm/u9Hykr9r/CGYMUv96Z4HU/3M=;
        b=tUiGaX4vWue2Ozb999W3JZYoebEPQ4APHPiVY+5a6wt9ys7MVbkh033QSkZ68in00O
         TwATap2oaGee1aDAEP2Ujp7VWobPgqi2WvVhRXnxHK0lUypyCY23YT41j5d60Z470o0j
         6C1Cuy0LZGeMGH2HNMY8/TFACq9zWNv+MDI0bXzT0Qpk9BwwY2KBHHa7scJ3MbOQfp3q
         Hsauix0UQh3iAMcv5UeJToVBDX6AxKT5wUFOMK2loDKzEN2xNrQOnhoYpqTYCnzxZ6F/
         34GQFub5ARaCEDXZR+BjluNtKZb2wfGIWfJtrOwOn1WrOktk7PjgNDPYhDX03jTaqv4Y
         HCZg==
X-Gm-Message-State: AOAM533dOMifVr2WTWzm5iyc2FvtPfef9BKHWkcCn7AZjV1pTYLDhe7F
        t+gGtXppCyU+KeEVyg/7A1zAEmB+ajE=
X-Google-Smtp-Source: ABdhPJw5JqTTUVDsVurDQv0GBC9llQorEYQaGpKQC/4hb/N5Bq2vwACq0rKaANyQNk2v3tgI8bFzQA==
X-Received: by 2002:a2e:9195:: with SMTP id f21mr5178302ljg.191.1607466638720;
        Tue, 08 Dec 2020 14:30:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c18sm16197lfp.307.2020.12.08.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:30:37 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
Date:   Wed, 09 Dec 2020 01:30:36 +0300
In-Reply-To: <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Dec 2020 12:52:52 -0800")
Message-ID: <87y2i8c4mr.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi Sergey,

Hi Elijah,

>
> On Tue, Dec 8, 2020 at 12:07 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>
>> [...]
>>
>> > The series also cleanup logic of handling of diff merges options and
>> > fix an issue found in the original implementation where logically
>> > mutually exclusive options -m/-c/--cc failed to actually override each
>> > other.
>>
>> Working further on this, I've noticed very irregular interactions
>> between -m/-c/--cc and --oneline:
>>
>> 1. --oneline disables -m output for 'git log', and leaves -m output enabled
>> for 'git show':
>>
>> $ /usr/bin/git show -n1 -m --oneline 2e673356aef | wc -l
>> 80
>> $ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
>> 1
>
> If you leave off --oneline, you'll note that git show produces a diff
> and git log does not (regardless of whether 2e673356aef is a merge
> commit or a regular commit).  So, I don't think this is related to
> --oneline.

Yeah, looks exactly like this, thanks for correcting!

>
>> 2. For 'git log', --oneline disables -m output, and leaves -c/--cc output
>> enabled:
>>
>> $ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
>> 1
>> $ /usr/bin/git log -n1 -c --oneline 2e673356aef | wc -l
>> 16
>> $ /usr/bin/git log -n1 --cc --oneline 2e673356aef | wc -l
>> 16
>>
>> The question is: what's the right interaction between --oneline and
>> -m/-c/--cc?
>
> I believe the right question is: Should -m be a no-op unless -p is
> also specified?

Right.

> In the past, --cc and -c were no-ops except when -p
> was also specified.  It was somewhat unfriendly and surprising, and
> thus was changed so that --cc and -c implied -p (and thus would cause
> output for non-merge commits to be shown differently, namely shown
> with a diff, in addition to affecting the type of diff shown for merge
> commits).

Well, so one surprise has been replaced with another, supposedly more
friendly, right?

I mean, obviously, with --cc I don't ask for diffs for non-merge
commits, so it is still a surprise they are thrown at me.

> I think -m was overlooked at the time.

Looks like it was, but maybe there was rather an actual reason for not
implying -p by -m? Maybe Junio will tell?

>
>> I tend to think they should be independent, so that --oneline doesn't
>> affect diff output, and then the only offender is -m.
>
> I agree that they should be independent, but I believe they are
> already independent unless you have more evidence of weirdness
> somewhere.  The differences you are seeing are due to -m, -c, and --cc
> being handled differently, and I think we should probably just give -m
> the same treatment that we give to -c and --cc (namely, make all three
> imply -p).

I think that either all diff-merge options should imply -p, or none,
from the POV of least surprise.

However, it'd give us yet another challenge: for some time already,
--first-parent implies -m, that once it starts to imply -p, will result in

  git log --first-parent

suddenly producing diff output for everything.

One way out I see is to specify that implied -m/-c/--cc don't imply
-p, only explicit do.

Entirely different approach is to get rid of -m/-c/--cc implying -p, and
just produce diff output for merges independently on -p being provided
or not. This will give us additional functionality (ability to get diff
for merges, but not for regulars), and will get rid of all the related
surprises.

Thoughts?

Thanks,
-- Sergey Organov
