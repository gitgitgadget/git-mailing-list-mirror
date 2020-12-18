Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A65C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900F123B7B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgLRVqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLRVqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:46:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C83C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:45:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y19so8968175lfa.13
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BKZhf8fwsQOpWTa4JLdK+jO49bGmxQ2zQk+JdPC0v1Y=;
        b=JoKcpxD/YuvEOk2eF6UU3CJVLE47waFMRXEYvIYiasYQMYMTyWLcQg2JS6RZ+9Le4t
         MqSIGiA03e901OHLjKDYK6AC0aZGOckMTlbRIvvN6Os+0xC1xufUMcb8I2sYOD/5uWOP
         frSqV/GVeDF3hBmP1Ii93EQfJ/8Fgh2H5BBToGZolEoT+ngfFbIrG3Hq3Szgu46nR0Oq
         shCMjWTkY/zJB5xj4Ychr7DjKw+B/6AyDqoO4dJWZ/nKKSeOe8PwhZIC+3jBOMdsak/T
         45Msa2QksqQLHTqxPEV961MqPb7q4fF4SHdxEiiKMu+aPKxsqgJ5N/WDaKfuw/j7Ctrd
         D7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=BKZhf8fwsQOpWTa4JLdK+jO49bGmxQ2zQk+JdPC0v1Y=;
        b=AmfV0MG6yPt11rgzEPMKvAuwE+mQxpiJJs2vlrUOX9zRrtrYvHZS7tCbRk6JWTNnwv
         Oc90J1xZOAvcLx7b0kvWY5641rh0nPKq7AVak0dOwqpeJ9rHhmp8QNp/0bfg75DVJwsK
         r8+3+Xn1LR+U6PzcIJTYo2G+MYQCZgU7Cs0/lKeM88xx+5YZL/5iHIvet7AMxf9OWL3e
         e9GsjnoI52SjIDPQTeExob8GBTtgvqyG82zGDZzdOhJ9hjA1MrD8j15FnewA2uMnf3Kb
         T5XZbsATjjskguPt4nGNa++BC+w+fxWdHJLlDe7v4tco41h1mCeC1Axbt4LYV7sO/96e
         qVwg==
X-Gm-Message-State: AOAM532bi5b/h4GugGepR7DqVzwZa6X6sS5jC28gJ4xb1WQtdjg6OQp1
        x7SIabCD7VC3Z8QVXRzQIRXcMv4yxoU=
X-Google-Smtp-Source: ABdhPJxxkt4Lm2CAyYOciXBN1IxKsiyA7mVP9oEcFK1j6mbBl8ZEDA/m2/XcNpjg7znU7Hh4LhALUw==
X-Received: by 2002:a2e:6c0f:: with SMTP id h15mr2737820ljc.305.1608327941135;
        Fri, 18 Dec 2020 13:45:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v63sm1050398lfa.89.2020.12.18.13.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:45:40 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 24/33] diff-merges: handle imply -p on -c/--cc logic
 for log.c
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-25-sorganov@gmail.com>
        <CABPp-BHh4VSTQ=VOzik5H34OcJaQ63wSgPgrZqJ5-_XvBSow+g@mail.gmail.com>
        <875z4zciwd.fsf@osv.gnss.ru>
        <CABPp-BGg9oBkG3ZaWztKMnQE4sREOK_L3so5fer5hbiAKxMaHg@mail.gmail.com>
Date:   Sat, 19 Dec 2020 00:45:39 +0300
In-Reply-To: <CABPp-BGg9oBkG3ZaWztKMnQE4sREOK_L3so5fer5hbiAKxMaHg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 08:37:01 -0800")
Message-ID: <87tusi7pq4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 18, 2020 at 6:01 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Move logic that handles implying -p on -c/--cc from
>> >> log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
>> >> belongs.
>> >
>> > A very minor point, but I'd probably drop the "where it belongs";
>> > while I think the new place makes sense for it, it reads to me like
>> > you're either relying on a consensus to move it or implying there was
>> > a mistake to not put it here previously, neither of which makes sense.
>>
>> Well, it was meant to be an excuse for not moving it there earlier in
>> the patch series indeed. I just overlooked this piece of code that
>> logically belongs to the diff-merges module. I think you need to
>> consider the state of the sources right before this patch to see the
>> point of phrasing it like this.
>>
>> That said, I'm fine removing this either.
>
> If it should have been moved there earlier, then you should amend the
> relevant previous commit instead of making a new one.  rebase -i is
> your friend and should be used, especially with long patch series.
> :-)

This is to be a separate commit anyway. I can move the commit itself
more closer to the beginning, but I don't see how it'd make things
any better.

By "earlier" above I mostly meant that I should have noticed and moved
it in the first issue or the patch series.

>
>> > Much more importantly, this patch doesn't do what you said in
>> > discussions on the previous round.  It'd be helpful if the commit
>> > message called out that you are just moving the logic for now and that
>> > a subsequent patch will tweak the logic to only trigger this for
>> > -c/--cc and not for --diff-merges=.* flags.
>>
>> I believe this patch is useful by itself, even without any future
>> improvements (that we actually discussed), if any, so I don't see the
>> point in describing what this patch doesn't do.
>>
>> OTOH, the commit message seems to be clear enough to expect this patch
>> to be pure refactoring, without any functional changes, no?
>
> I'm just pointing out that reading the patch triggers a "wait, you
> said you wanted to enable diffs for merges without diffs for regular
> commits" reaction and makes reviewers start diving into the code to
> check if they missed where that happened.  Sometimes they'll even
> respond to the commit asking about it...and then read a later patch
> and find the answer.  Perhaps I'm more attuned to this, because I've
> done this to reviewers a number of times and they have asked me to add
> a note in the earlier commit message to make it easier for other
> reviewers to follow and read the series.  You don't need to describe
> in full detail the subsequent changes that will come, just highlight
> that they are coming to give reviewers an aid.  For example, this
> could be as simple as:
>
> """
> Move logic that handles implying -p on -c/--cc from
> log_setup_revisions_tweak() to diff_merges_setup_revs().  A
> subsequent commit will tweak this logic further.
> """

I think I see what you mean, but I still don't like this, sorry, as:

First, this commit doesn't tweak the logic at all, so "further" doesn't
sound right.

Second, the purpose of this move is not to have subsequent commits that
will tweak this logic further in any particular way. One of the aims of
this commit is rather to make it more simple to have /any/ further
tweaks to the logic.

Third, if the "tweak" you mention is not accepted, I'd need not to only
get rid of the tweaking commit, but not to forget to edit the
description of this one, that is basically unrelated?

>
> (Note that 'git log --grep=subsequent' in git.git will find you
> several examples of where people have done this kind of thing.)

Yeah, I agree it's useful when commits are tightly coupled and thus the
purpose of single commit is unclear. I just don't think this one is such
a case.

Thanks,
-- Sergey
