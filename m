Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B6CC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 13:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349735AbhLAN5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 08:57:35 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:35675 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349716AbhLANyU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 08:54:20 -0500
Received: by mail-pf1-f177.google.com with SMTP id p13so16826584pfw.2
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 05:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvoV7flETWvMvWJFKk/gdbyEDtFy5MK10SSYcXwtes8=;
        b=31AVmfxew8rD/lJJiLlWjBNfXMwO3WgGyTXTbhzgec1X398OZKueiI+nSFf4eMtbdm
         kaYE3NTNvmne6p3d3MvpofLv50+fLXZP68BECALjH5cQvPvCTRdpbS1m7Cf7Bt/JRuk/
         FoRiS/kasrU94uqDa3ohrv3Ut9l+HZrsXHHzOg6SmZnYtvwScdVfbCVAL6ntNpkTEqy4
         6di/zpqFui+9Szp6XcG0rrAk40oXaNp3yscdZxt4oHu5apqgXoQUg7VqNNy1sHVT+BgF
         Elihrm9yQrCySgKP+rDHXpj1QmK6gkAr0Mdt1JliW2P540jiPNzdi3Hsx1LWsg5wloix
         cYJQ==
X-Gm-Message-State: AOAM530YGn3P2er73VdvqoOxXKVDfKu+Qd8ws0hsEU7m+2mY0fXepOur
        qgbsWGzORMFFzm7A6Zi3PkvLDNZ/gHp2BgPpJ2M=
X-Google-Smtp-Source: ABdhPJzczh/O6MKVfjkiFYerUPXxhMs6wfKPd2oiNfI5Ex5Gx7bw+7NDUOAtATx7ANKCIkDrwjP+lgj/1KptlB9dt9M=
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id
 j9-20020a056a00234900b004a80d87e8admr6408325pfj.15.1638366658197; Wed, 01 Dec
 2021 05:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20211201053214.2902-1-sunshine@sunshineco.com> <20211201083301.ozrhi2brjk4zx5ll@fs>
In-Reply-To: <20211201083301.ozrhi2brjk4zx5ll@fs>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 08:50:47 -0500
Message-ID: <CAPig+cRFqO5wcZTPrpTuiBP72+6enJs+---mjT2AFAQq5ztt_w@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 3:33 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> On 01.12.2021 00:32, Eric Sunshine wrote:
> >+ We make a distinction between a command's primary output and output
> >+ which is merely chatty feedback (for instance, status messages,
> >+ running transcript, or progress display), as well as error messages.
> >+ Roughly speaking, a command's primary output is that which one might
> >+ want to capture to a file or send down a pipe; its chatty output
> >+ should not interfere with those use-cases.
> >+
> >+ As such, primary output should be sent to the standard output stream
> >+ (stdout), and chatty output should be sent to the standard error
> >+ stream (stderr). Examples of commands which produce primary output
> >+ include `git log`, `git show`, and `git branch --list` which generate
> >+ output on the stdout stream.
> >+
> >+ Not all commands have primary output; this is often true of commands
> >+ whose main function is to perform an action. Some action commands are
> >+ silent, whereas others are chatty. An example of a chatty action
> >+ commands is `git clone` with its "Cloning into '<path>'..." and
> >+ "Checking connectivity..." status messages which it sends to the
> >+ stderr stream.
> >+
> >+ Error messages are always sent to the stderr stream.
>
> This is not necessarily true in the context of the tests.
> We just spoke about this in:
> https://lore.kernel.org/git/211130.86wnkpd6ou.gmgdl@evledraar.gmail.com/T/#u
>
> I don't think it necessary to bloat this explanation with the test details.
> But mentioning it as an exception would be good.

Yep, I tried to be clear about that by repeatedly stating that
_command_ output should follow this guideline, where "command" means
"Git command". I strongly considered writing "Git command" to be
perfectly clear, but figured reviewers would insist that it was
redundant to mention "Git".

However, I can certainly change these to say "Git command" if you
think it would make the intent clearer, and can update the final point
to say:

    Error messages from Git commands should always
    be sent to the stderr stream.
