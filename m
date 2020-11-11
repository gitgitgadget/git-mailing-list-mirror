Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1D8C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0CC20679
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNfvd6Ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKKVSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 16:18:46 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B8C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 13:18:46 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so3804455oih.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 13:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMXKqf2FybOv33BFE3YqBY4OOePlSIZKFy3vKLviBeI=;
        b=HNfvd6EfPK3qd5kRYpWEy4rDo5Jdu+U7wzoVhXWt0lISsSA1EWGV0GC65JPvQqRxKG
         R/2hVRFQ5paRyDibG6EdPLiJkUVH3nAmW/urBoMpp0nAziLcmY5DU3mtuQxl1+uZC8A1
         jq4zQxjWpyi1M4OBEvFzYlmiElJES8IyHorFoH89deH020n0nrS2VxfvF9JL8MphOqKl
         jiVbzs+AdSbeNK8PDXY1wv79mjvk8nDLwadwIpcXhzLXEERJamSCS1YyolX8WxSEayM0
         LBuSn0k/vF87M8L+bpEWvcVo681TPdAdzD6jvlMc7n6Z5WUs/3QBJYrg7xUAec5zKfD4
         W1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMXKqf2FybOv33BFE3YqBY4OOePlSIZKFy3vKLviBeI=;
        b=IPx0X04xLxFRH4/8X23yyNfdR269KkViEJKucFil0dojqWlQgCZoKQiU1mQhr14j/R
         a88P+cLOTVVs6QK9+ZfK9Hi0B9A2FSMsgm7vAa/4ur2XdQ/bTg+R6vtjFTAX1z+pVuYT
         uAmCjv3/qICyO31byaD7TsPtwmkSfPtHMdTveUdbvw8myOwLgdRWK9loOYxeQmqMoorU
         fNa3EW2U+FRddNehS50JUHHaX1Z0mpmr43G7FsXp6WvHbQmPNoSLQ7x6faMHuPW7+jEv
         VRqNDp3Wrd/mFkM7IlNYcS+LeNoqeT4XiqOyZ4MkQ4Njj0tYVToJXp5su/UZKKy1YDXT
         oYIg==
X-Gm-Message-State: AOAM532TG/it6FO/wIWRIfHCkt8Fc1JuQWLugIIVe8WH14fvDcdxvQjc
        b9X9uIgZrFUQ5KlL7nEISzRAKiyVK1+kPXCerWI=
X-Google-Smtp-Source: ABdhPJyE0iifyWih7Fl7c1vSsivv3w0MmkYdCRosBfEvztntcZEBLb1UtkJPzdELIib6UMVlRP6IQ7aDsgjBL6JV9HU=
X-Received: by 2002:aca:3756:: with SMTP id e83mr3450760oia.31.1605129525603;
 Wed, 11 Nov 2020 13:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <75170ee7-525e-31fc-f6bd-6dfac12b00c8@gmail.com>
 <CABPp-BF=+-ieP8fCxWWuvhe2dTTMKVGnYSTJuV6H9Z+zYs0SNg@mail.gmail.com> <e3fcaead-8bee-bcda-aee0-459ad9774f9e@gmail.com>
In-Reply-To: <e3fcaead-8bee-bcda-aee0-459ad9774f9e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 13:18:34 -0800
Message-ID: <CABPp-BE=XzueTJ18dZXXXGEkJ0b6R-TjrgK5SAjDo2oPzTLETA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Wed, Nov 11, 2020 at 12:48 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/11/2020 1:35 PM, Elijah Newren wrote:
> > On Wed, Nov 11, 2020 at 9:09 AM Derrick Stolee <stolee@gmail.com> wrote:
> >> For the series as a whole I'd love to see at least one test that
> >> demonstrates that this code does something, if even only for a very
> >> narrow case.
> >>
> >> There's a lot of code being moved here, and it would be nice to have
> >> even a very simple test case that can check that we didn't leave any
> >> important die("not implemented") calls lying around or worse accessing
> >> an uninitialized pointer or something.
> >
> > We absolutely left several die("not implemented") calls lying around.
> > The series was long enough at 20 patches; reviewers lose steam at 10
> > (at least both you and Jonathan have), so maybe I should have left
> > even more in there as an attempt to split up this series more.
> >
> > However, if you run the testsuite with GIT_TEST_MERGE_ALGORITHM=ort,
> > then this series drops the number of failures in the testsuite from
> > around 2200, down to 1500.  So, there's about 700 testcases for you.
>
> Sorry that I'm jumping in to the series-of-series in the middle, so
> I am unfamiliar with the previous progress and testing strategy. This

Not a problem at all.  Thanks much for jumping in and taking a look!
You always provide some good feedback and suggestions.

(Besides, those testcase changes have been spread over two and a half
years...hard to stay on top of all of them.)

> "number of test failures" metric is sufficient to demonstrate the
> progress provided in this series. Perhaps it was even in your v1 cover
> letter.

Um, oops; it's not.  I did mention there were still some "not
implemented" messages left, but didn't mention the testcase counts.
But even that mention is apparently in the v1 cover letter rather than
v2, and v2 wasn't sent in-reply-to v1, so it's harder to catch that.
Sorry about that; I'll include the testcase counts in the v3 cover
letter.
