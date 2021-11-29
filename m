Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F410C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhK2XBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbhK2XAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19CDC04CBD0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:57:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so76044030edd.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AOJcdl53EneCloLZ1vA3yQhFFIKsVRKrqRS8Ng7MwHA=;
        b=e3iD/SSE6V0SyDmt3Kddq+OREUaJXSnBh8gsCZbDYaINQQYhavhwvzzmvKo33gpCCK
         xThjCURvlscwA26ojYmMjmQrP5VqJ3LDB5SWhr9j0L14PlsePjncqikwkn3hwtjLVROi
         BD/8mmhcqAi+HUvvNF41Hw58q5QLiOTJXGgf75mUa34COBkAo99P+7vGarWQ1evt566I
         lZIjjNQ2QmJvmhYprr6rEjqH+R3UVN81c+7LckZYg9A7K0zhM+mVYV9o9aJzJ0R7i5GX
         h6WQhj1L24PBqE/iGyyGXxsDdXyzGk3zeIS8iK6N/uUygMAlVEZzXtroJkanDPf5pK7d
         wXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOJcdl53EneCloLZ1vA3yQhFFIKsVRKrqRS8Ng7MwHA=;
        b=AJ6qxYOXVJ/XTRrvlUFCzMaT7iRlUNbQgNL7eS77Zf62IiZtKdarqCE3E68gBXntMh
         /jINkMRjThjiX2iayiexxL8HEXICj+uGtj/Cqb2jU3cezG6WmurCQ2rDeCCIuc6y6My8
         sYOX9Hb0Tn3RSFg1hwkh1smv+44M9YpTZnGyfkm21UYf7psM37+P/S1XS4VTBJ0yOhfS
         KQQzlVdVit/oB/0hi7k82btqXxkS0XzSdyJ+oNuLOrZ7mN0CvhNxll0N3hKVvPfME6X5
         XWz7CWfGXVvwmWvcGLjQcPbFEmcaykMTCSubyTLM1y8NwsxhCaArK+hi/epVjuEDUzel
         XOvw==
X-Gm-Message-State: AOAM530SSAC/g1lYs+r9DvXF/2O1+Yhj6vE4/LXY6twag/J1TnTm9Wif
        4jiwpKOPvpC8dUlbNvQjdcKzsV3iPIGxiTK0jUY=
X-Google-Smtp-Source: ABdhPJzyKjr1qNECS1P8QAvcck6dBb5jGhwxU5Oz8udeFGWRp3AgqUeTYfa5tQBbRj3dneCvE2DX6ut+/58qq49r/cE=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr63150359ejf.341.1638212254262;
 Mon, 29 Nov 2021 10:57:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
 <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com> <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
 <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com> <xmqqo8623jyw.fsf@gitster.g>
In-Reply-To: <xmqqo8623jyw.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 10:57:22 -0800
Message-ID: <CABPp-BHJq6L_1dG_YELrgO9M0w6qS2Jg3gDtpVWonj9i9wUR4Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] am: support --empty=<option> to handle empty patches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbikgdmlhIEdpdEdpdEdhZGdldA==?= 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 10:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> +--empty=(die|drop|keep)::
> >> +       By default, or when the option is set to 'die', the command
> >> +       errors out on an input e-mail message that lacks a patch. When
> >> +       this option is set to 'drop', skip such an e-mail message instead.
> >> +       When this option is set to 'keep', create an empty commit,
> >> +       recording the contents of the e-mail message as its log.
> >
> > What does 'errors out' mean?  Is the am operation aborted, and the
> > user return to the pre-am state?  Or is the am operation interrupted,
> > with the user being asked to choose whether to keep or drop the patch?
>
> I think it is the same as how "git am" without this sees a piece of
> e-mail without any patch in it.  It exits with non-zero status, but
> keeps the contents of .git/rebase-apply directory intact so that the
> user can decide what the next action should be.  "the command stops
> with non-zero status and gives control back to the user" might be a
> better explanation.
>
> As to the name of the option's value, I think 'die' is a much better
> word than 'ask' for this behaviour.  It is not like we retain
> control, give "do you want to do X or Y?"  prompt and do either X or
> Y ourselves, which is what I expect out of 'ask'.  If we just exit
> with non-zero value and give the control back to the user, then we
> are not asking.

Well, I still think 'die' implies aborting the entire overall `am`
operation, and is thus a confusing term.  To me, 'stop' or 'interrupt'
would be better if you want a one-word term and don't like 'ask'.

If you don't like the term 'ask' here, perhaps we should also change
rebase?  rebase --empty has 'ask' as a choice for
stopping/interrupting the rebase operation and letting the user decide
how to handle it.  (There is a very subtly different context for
rebase's --empty=ask, namely in that it is only triggered for patches
that were not originally empty but become so do the the new base the
patches are being applied upon already having the changes from the
patch in question, but that doesn't seem like a big enough difference
to suggest it should have a different name.)


There's another bit to my query on the semantics, though.  The second
half of my critique was that the current form of the series does not
inform the user how to handle the situation when `git-am` stops.  It
only tells the user how to drop the patch.  (If there's only one
option, why doesn't git just take it automatically?)  I think it
should also tell the user how to keep the patch.  Now, if both options
are presented to the user when the operation stops, would that qualify
as the user having been 'asked' what to do?
