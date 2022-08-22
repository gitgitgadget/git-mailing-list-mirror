Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14906C32774
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiHVPBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiHVPAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:00:55 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DA275D7
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:00:54 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m17so8295933qvv.7
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jZNORGyk5rivYdiOMFa3H830z3rdC4OGji0GUurRRJk=;
        b=lOsln0UxCpBVZKs4y4CaKS/uz2YSuJ/GRRRcm0qEaPOVtVkdTVNWHI5Y46skJ6gi92
         ubjms+qNhnFyE4E70w/rvGj4gMDmd8carjKCk+W/itIDW6OK0ISMvU7CwYEbyQ+Vb4hb
         6VC4IDIVE1gtKJxBeHR8xytD5Ciwxw7aq4Jjgmbr+rKCL0wKx0d1EIrGXHI0slWCv/7W
         3O63m047CJtBYNBXzmKmFZVVuyt3hcE1TYLozsoxEJB+wqgkxVR5InsfqIxgbZcw3pJD
         KfjI8lRgp/kP4h1b1764mHrnaiX0UaoK0EwS3QYF6EIABoHASSpYePwRSg+/zGvU1xRx
         YDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jZNORGyk5rivYdiOMFa3H830z3rdC4OGji0GUurRRJk=;
        b=PK5kbcDdbf+QlzQta3z6HuHIAeyqr9H0ykQogL6xhsZv5e/yebHMTOpl2sUkNGI12f
         s9RQqUoa1FZ3VLX5RiJ3XN0ucDSXi4AnMoDRDs2Lr6cZK7FGz61pfHMXCwmCrQjyCzwX
         /JzBM4+a/bBBnW3DSnOXSdyylBVBXrEpZU0dcdpB+6AIw13oDkKzNVhh4U5jqyIMsz4m
         R87/mepq0H8rwNsn/tPXHMh3iyoVHr3xECPh2x+X0vwFu4YmOh5QRbr6LrEVGRpMlCDL
         Q+D1g61uz3Ili7Z8oYPAYZDVJRNvq4LmgQh935r8287eaze6+22MJ1zFi8kqCR+YGxBn
         ZXug==
X-Gm-Message-State: ACgBeo2UweWaSjnrmVsSK38oz8o+idqTTJwkAfI/h7rMVT5FaYvY3v8t
        FH9dljIgH7KYmFmVF4+lNVtO0k/1dWltsns8pRk=
X-Google-Smtp-Source: AA6agR40Af/Ac/m2poguMZyBNMCmJitT17mb+nsVIE7AzL9tVtBQb0b0SDD1XrVJp9Xom/74xLaoWYwXCUzixU0WPhU=
X-Received: by 2002:a05:6214:62a:b0:476:858d:b2c8 with SMTP id
 a10-20020a056214062a00b00476858db2c8mr15512466qvx.65.1661180453359; Mon, 22
 Aug 2022 08:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
 <5657a05e7635ecadbb8d2e41ad97fe19f3633fdd.1661056709.git.gitgitgadget@gmail.com>
 <xmqqwnb1fp5n.fsf@gitster.g>
In-Reply-To: <xmqqwnb1fp5n.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Aug 2022 08:00:00 -0700
Message-ID: <CABPp-BHy-Xs0S1-9kL7X4mi6JNfd420-vpVsswXNuXsc5C7AtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge: avoid searching for strategies with fewer than
 0 conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2022 at 11:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > builtin/merge.c has a loop over the specified strategies, where if
> > they all fail with conflicts, it picks the one with the least number
> > of conflicts.
> >
> > In the codepath that finds a successful merge, if an automatic commit
> > was wanted, the code breaks out of the above loop, which makes sense.
> > However, if the user requested there be no automatic commit, the loop
> > would continue looking for a "better" strategy.  Since it had just
> > found a strategy with 0 conflicts though, and it is not possible to
> > have fewer than 0 conflicts, the continuing search is guaranteed to be
> > futile.
>
> Let's imagine "git merge -s ours -s ort X", both of which resolve
> the merge cleanly but differently.
>
> The "best_cnt" thing tries to find the last strategy with the lowest
> score from evaluate_result(), so strictly speaking I think this
> changes the behaviour.  Am I mistaken?

Yes, you are.

Though, to be fair, my commit message is wrong too.

I'll explain below...

> When two strategies 'ours' and 'ort' resolved a given merge cleanly
> (but differently), we would have taken the result from 'ort' in the
> original code, but now we stop at seeing that 'ours' resolved the
> merge cleanly and use its result.
>
> >                       cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;
> >                       if (best_cnt <= 0 || cnt <= best_cnt) {

No, the original code would not have taken 'ort'.  You have overlooked
the part of the code immediately above these two lines:

    if (ret < 2) {
        if (!ret) {
            if (option_commit) {
                /* Automerge succeeded. */
                automerge_was_ok = 1;
                break;
            }
        merge_was_ok = 1;
        }

In particular, the "break" is key.  If the first strategy succeeds
(and the user did not specify --no-commit), then the loop will hit
that break statement and bail out of the loop, preventing any other
merge strategy from being tried.  In contrast, if the user did specify
--no-commit and the previous strategy succeeded, then we will continue
the loop.  That seems rather inconsistent, since --no-commit should
not affect the choice of strategy.

However, I missed two things in my reading.  You are correct that I
missed the "<=" as opposed to "<" when I wrote my commit message,
though that turns out to not matter much due to the second thing.  The
second thing I missed was part of the code at the beginning of the
loop:

    for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {

In particular, that "!merge_was_ok" check means that the code would
bail early whenever ret was 0, regardless of whether --no-commit was
passed.  So, my code turns out to not only leave behavior alone, but
also doesn't count as an optimization either -- it's simply a
half-baked cleanup.  If I also get rid of the now-redundant
"!merge_was_ok" check in the for loop and fix my commit message, then
I think it'd be a fully-baked code cleanup.

I'll submit an update.
