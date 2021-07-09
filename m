Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68987C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444F3613C1
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGIR1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 13:27:12 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42634 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 13:27:12 -0400
Received: by mail-qk1-f182.google.com with SMTP id e14so10034236qkl.9
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 10:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZhlj6B4JOMmlGp/+qzJoFFrS6J9YZcBk0XfRDBgvos=;
        b=Y7qvoEQ45SICgPvnaWhqzKDSRgiME9dyLLObL4RCXPdqC9dg8laAIeWkWYLChXNrng
         ZuxU73HfkW4kDnhNO3xewZVtfsvokdVYsvzgORzVG7nrPzCEtlXTHEpxPt2vpKtB/LOE
         ekcI+TMVcdBr1dRCMhNunnmtb5VI+GGfuKMsrYy/XeCKtdWwTsN7o+xD5M3CDPCCc94N
         Go2sFwZ2tFNvm3F8lTsI25b2ivQy+NwXQ2hkPNPSlukcd43WJjkS8PUu9F+19QBgIYkR
         5N4wNSgeSKH7YuB8DuhEb1OI41YrGLjXDtt1Bc13MJL5wV149orrrmfTcD/K7sap8Qxk
         yHiw==
X-Gm-Message-State: AOAM532sW/8kbVCdWE82fOI9wiEH/RpmgzZvKZrG8Gi9lg53rbczOwJT
        nKpvYpBeyBpUNA35zdLZSWzoToYklwytwA==
X-Google-Smtp-Source: ABdhPJyc340VRAh3cgb0Wps7b2YWxb9utDyF0IK/KVIxUpN2tTnDSwwFAXDmnQFHMdPkaokwVtbVpg==
X-Received: by 2002:a37:9e44:: with SMTP id h65mr21649829qke.431.1625851466922;
        Fri, 09 Jul 2021 10:24:26 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id o29sm2524702qtt.39.2021.07.09.10.24.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 10:24:26 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id 14so10089357qkh.0
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 10:24:26 -0700 (PDT)
X-Received: by 2002:a37:8581:: with SMTP id h123mr38810827qkd.316.1625851466463;
 Fri, 09 Jul 2021 10:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210706210317.706313-1-me@avishay.dev> <20210706210317.706313-3-me@avishay.dev>
 <xmqqbl7fgkvu.fsf@gitster.g> <CAJ-0Osy2RLiZmi9m=W=rpK6Bh5uXk-psO-BTb18a8COrsQANUw@mail.gmail.com>
 <xmqqo8bb769a.fsf@gitster.g>
In-Reply-To: <xmqqo8bb769a.fsf@gitster.g>
From:   Avishay Matayev <me@avishay.dev>
Date:   Fri, 9 Jul 2021 20:24:15 +0300
X-Gmail-Original-Message-ID: <CAJ-0Osx4A0NaY9f5Z-6_H2rfW-XwyDmW_7+OxKFt7WJaWOixSQ@mail.gmail.com>
Message-ID: <CAJ-0Osx4A0NaY9f5Z-6_H2rfW-XwyDmW_7+OxKFt7WJaWOixSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Allow isatty to be overriden with GIT_FORCE_TTY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, code@tpope.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 9 Jul 2021 at 20:21, Junio C Hamano <gitster@pobox.com> wrote:
>
> Avishay Matayev <me@avishay.dev> writes:
>
> > On Wed, 7 Jul 2021 at 01:03, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Avishay Matayev <me@avishay.dev> writes:
> >>
> >> > There are several behaviors where git will not attempt to do an action if a
> >> > tty is not present, for example - `git_pager` (pager.c) will instruct git
> >> > to not use the GIT_PAGER environment variable if stdout is not a pty.
> >>
> >> In general, I am negative on this approach, even though I agree that
> >> the issue you are trying to solve is worth solving.  "Force pretend
> >> that we are talking to a TTY" exposes too much of the internal
> >> logic in the implementation to the end users.
> >>
> >> Often we use isatty() as an approximation for "are we being
> >> interactive?", and I wouldn't have as much problem as I have with
> >> the "FORCE_TTY" to an approach to give users a knob to tell us "do
> >> not use your logic to guess---I am telling you that we are
> >> interactive, so behave as such".
> > I'm not sure that I understand your view on this patch.
> > `git_isatty()` does exactly that, it gives the users that knob, doesn't it?
> >
> > If you don't find the approach in this patch good enough, what exactly
> > do you suggest?
>
> Start with not tying this feature with the word "TTY", probably.
Well then, what are other indicators of 'interactivity' besides "TTY"?
