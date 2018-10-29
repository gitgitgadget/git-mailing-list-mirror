Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A801F453
	for <e@80x24.org>; Mon, 29 Oct 2018 04:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeJ2MsS (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 08:48:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45626 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeJ2MsS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 08:48:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so7707775qtj.12
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 21:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHAvh/sfHNTGzeIdaDaHLScFOQpF2lxJtxOhxqWOVjo=;
        b=UatoDEICZAoXWPA3hz23AmclWBt/78AyqTG4BrG2/15dpDkcGD6CEEGe07BlhFKvz+
         hYH2j6J0LwSyAZSQHHzPWzHi1R3urP1AFMSRjaEzPIRsgMwEmfRb4mB+Z2U3UG7beSHA
         x1QjW0og7Z/hxgK/JCf3xWPfZmg254IEkEWEl4T3uMc3t2oqYAZiWL3V7fkWiCN0y0E/
         PKOk0u79XKpLIJFUwn3MaEGwBAZlJk4+9JoXH5tsAIBmNqe7atg2HSD4Cl3Kba+/Mz5w
         Ibt7pugNmJS+8+3FZY7G7+Jvc8dzN6oDQxUDFWKC14v31+Keh/Z1lj64+0+gemFGBqOd
         j6Qw==
X-Gm-Message-State: AGRZ1gKUjMRQdtO1xXVuHtNXR2HJTYs2Cc2ge75hE2S7uuO9B/hkBjcB
        65YX6ZW4Inythy072v/pGkUUzJsZPwQZBPpV6Sc=
X-Google-Smtp-Source: AJdET5dVbGiUYSisB89F1RkhoxijaEH2qcmNkkq97B2VtnPB4FOMUurMK8zzasucsrLkBQVqcxlmqVvA34nIuSyCWak=
X-Received: by 2002:ac8:3693:: with SMTP id a19-v6mr11234805qtc.236.1540785683976;
 Sun, 28 Oct 2018 21:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
 <20181025055142.38077-1-nbelakovski@gmail.com> <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
 <CAC05386cSUhBm4TLD5NUeb5Ut9GT5=h-1MvqDnFpuc+UdZFmwg@mail.gmail.com>
 <CAPig+cT1XYt60PsRGJ0FUa_qCn1vPjdXHygsWzYZYg2Ey=yqkg@mail.gmail.com> <CAC05387mfDhJ5_=LyzxZZX09MoY1hsmSB1gseNeLCmMOUx2O4A@mail.gmail.com>
In-Reply-To: <CAC05387mfDhJ5_=LyzxZZX09MoY1hsmSB1gseNeLCmMOUx2O4A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Oct 2018 00:01:11 -0400
Message-ID: <CAPig+cTTsbz1pygq6G281V+fR2VVMuchvy1Q1H-KEvJpjJ9ejg@mail.gmail.com>
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to
 be more sensible
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 9:11 PM Nickolai Belakovski
<nbelakovski@gmail.com> wrote:
> On Sun, Oct 28, 2018 at 4:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Aside from that, it doesn't seem like worktree needs any changes for
> > the ref-filter atom you have in mind. (Don't interpret this
> > observation as me being averse to changes to the API; I'm open to
> > improvements, but haven't seen anything yet indicating a bug or
> > showing that the API is more difficult than it ought to be.)
>
> You're right that these changes are not necessary in order to make a
> worktree atom.
> If there's no interest in this patch I'll withdraw it.

Withdrawing this patch seems reasonable.

> I had found it really surprising that lock_reason was not populated
> when I was accessing it while working on the worktree atom. When
> digging into it, the "internal use" comment told me nothing, both
> because there's no convention (that I'm aware of) within C to mark
> fields as such and because it fails to direct the reader to
> is_worktree_locked.
>
> How about this, I can make a patch that changes the comment next to
> lock_reason to say "/* private - use is_worktree_locked */" (choosing
> the word "private" since it's a reserved keyword in C++ and other
> languages for implementation details that are meant to be
> inaccessible) and a comment next to lock_reason_valid that just says
> "/* private */"?

A patch clarifying the "private" state of 'lock_reason' and
'lock_reason_valid' and pointing the reader at is_worktree_locked()
would be welcome.

One extra point: It might be a good idea to mention in the
documentation of is_worktree_locked() that, in addition to returning
NULL or non-NULL indicating not-locked or locked, the returned
lock-reason might very well be empty ("") when no reason was given by
the locker.

> I would also suggest renaming is_worktree_locked to
> worktree_lock_reason, the former makes me think the function is
> returning a boolean, whereas the latter more clearly conveys that a
> more detailed piece of information is being returned.

I think the "boolean"-sounding name was intentional since most
(current) callers only care about that; so, the following reads very
naturally for such callers:

    if (is_worktree_locked(wt))
        die(_("worktree locked; aborting"));

That said, I wouldn't necessarily oppose renaming the function, but I
also don't think it's particularly important to do so.
