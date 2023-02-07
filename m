Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FCC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBGW1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBGW13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:27:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7651A487
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:27:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v13so18079163eda.11
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYtx+4690wMpFWAytyGH68kkcAC0pTG/X/KDt8qSx9M=;
        b=EMTvs6XnKzFZx9h5WsxEk01jGGz0cHedmCwg7JxulKuLR7yCr7IXWOAaX3xqJ5bgpo
         Bf2mURaQ6OCwQIDrIKYxORi/mcg3WSZYAFnGFoxz9JFUwAiYBL8HAuHjZDJCUp90BtwQ
         sng616eEevnvGSeDFhOk7i6KTL7vpbIvsVJura8gDs/ZQg5NQXTJ5Ga/kZH0NcLCE+UT
         +3JmIzAk4e4ma0wWqoGPQ+CZN9c41LEyVYBM/mySzjA2HOPC5Ht0Zh8G7xgb6q+oRw95
         ar4ldtRVXEnbc0a40o+uMlo1Q2KZGoPq174mEpoplkkygQAz6HyTESntNBbo2kYmDDGK
         CC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYtx+4690wMpFWAytyGH68kkcAC0pTG/X/KDt8qSx9M=;
        b=1pWqKeb0zyU9NzV4QMePqDTEhkc5YZR+lEHaIn3QPYDQ4weUjMxe7YtTVBgaAJfYR7
         GNnAcw+m0bTa+GwOzRPaP1pW4l08JAJ/Fxs0s3LB7FMq7Ij5XvWFeOCCpQOKokp9+y/S
         +VmLCcIR1/r8Ml+vfFGIn4slRgEBTmt2odkXqBxNDNXKjjDBFKGSUIMTMtnBufTCkvoF
         Gh0XwAmluhc6jbZoafBr1W8q9A3ePczxjUfr2nNmHCWs8h3RrP4skYqtqoQWJwqIWTk5
         uJG1v0dOZeOCODsVwGt1SjxryNCO1yo6k+oc7AazeTD59rQEfKHaqSMBSTOUvp0Kf4xm
         qXLw==
X-Gm-Message-State: AO0yUKXyW11HOZUcjIMZeNwKdEaPyOGjbiFL2GG7brG2163SpFBdoQtO
        xbelc5iGNy6Qo1ggmSubkWA5S0ZgC1XxvxfY/nQEBnMrlkmnQw==
X-Google-Smtp-Source: AK7set8+K3/ZPsqtabpNMUE06NnwGB7mkV3Nxrn2q+wmmWskfSzcQ1gvFLPr1Jy2VoGRGHitzSXAaVEcRkZrz2vu7rE=
X-Received: by 2002:a50:9e0b:0:b0:4aa:a4df:23fc with SMTP id
 z11-20020a509e0b000000b004aaa4df23fcmr1106619ede.1.1675808845628; Tue, 07 Feb
 2023 14:27:25 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net> <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
 <Y9098dyaTtiNk506@coredump.intra.peff.net> <CANgJU+UJ-p54MDmQWYTEsdh_ss-q8TUEcqHFm568Lpfsy2dU+w@mail.gmail.com>
 <CALnO6CC2w5LUAjXVw7CWKAVobjFMc7M7jm7HuuGT1SO0q5cYbA@mail.gmail.com> <Y+KXC5b0qUg2/nxt@coredump.intra.peff.net>
In-Reply-To: <Y+KXC5b0qUg2/nxt@coredump.intra.peff.net>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Tue, 7 Feb 2023 17:27:14 -0500
Message-ID: <CALnO6CCzp0brmCjbNmOKe9E1bcxLzGNrqpfK_JrU=+LXt-DUyQ@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CC'ing Jonathan Nieder

On Tue, Feb 7, 2023 at 1:23 PM Jeff King <peff@peff.net> wrote:
>
> On Sun, Feb 05, 2023 at 02:51:05PM -0500, D. Ben Knoble wrote:
>
> > Any thoughts on some sort of stop-gap measure to fix --word-diff while
> > Git decides how to handle the regex engine incompatibilities? How
> > important is the sequence of bytes at the end of --word-diff regexes
> > in userdiff.c?
>
> It comes from 664d44ee7f (userdiff: simplify word-diff safeguard,
> 2011-01-11). So presumably we'd want to figure out a way to accomplish
> the same thing in a portable way. I'm not sure that's possible, though,
> without making assumptions about the regex engine.

If "use the safeguard portably" implies "make assumptions about the
regex engine," that sounds like an argument for Git to ship its own
engine with exactly the necessary features. If that implementation
includes proper locale and UTF-8 support alongside support for the
high-byte character classes, I think we would be all set=E2=80=A6

OTOH, perhaps there is a way to express the safeguard character
classes portably?

Jonathan, can you provide more context for the safeguard? I've read
this message several times

> git's diff-words support has a detail that can be a little dangerous:
> any text not matched by a given language's tokenization pattern is
> treated as whitespace and changes in such text would go unnoticed.
> Therefore each of the built-in regexes allows a special token type
> consisting of a single non-whitespace character [^[:space:]].
>
> To make sure UTF-8 sequences remain human readable, the builtin
> regexes also have a special token type for runs of bytes with the high
> bit set.  In English, non-ASCII characters are usually isolated so
> this is analogous to the [^[:space:]] pattern, except it matches a
> single _multibyte_ character despite use of the C locale.
>
> Unfortunately it is easy to make typos or forget entirely to include
> these catch-all token types when adding support for new languages (see
> v1.7.3.5~16, userdiff: fix typo in ruby and python word regexes,
> 2010-12-18).  Avoid this by including them automatically within the
> PATTERNS and IPATTERN macros.
>
> While at it, change the UTF-8 sequence token type to match exactly one
> non-ASCII multi-byte character, rather than an arbitrary run of them.

and I can hardly make heads or tails of it.

--=20
D. Ben Knoble
