Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F7C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EC5611AD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 08:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhIJIKP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 10 Sep 2021 04:10:15 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:43739 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhIJIKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 04:10:13 -0400
Received: by mail-ej1-f45.google.com with SMTP id dc3so2522226ejb.10
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 01:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8eTeblFBsq8xNoGnxw14wnVnu5h9rlrKh2177wL8T7s=;
        b=okYTH92mCU3tApnDaJp/UHL+h688Bf02nGHUDYhVPdQcbF+yB3mRCVwUZ2IRBJefHd
         VWPv1CMUgYtiPyJtGzfPGJo5zZOv/ZTkGgJIs4c4lpkNEGMuw86UDdaAz0gBphajzV0O
         chp2Oa1bt5RkPhGyxY92LiLjmbOYAqk3wUc4DgkUGzGI0NSpFiug4ast8sFwVp/p0QIq
         UleZZ9Ix8hrJsEMb7MY8AdOLGOomtnOnD44G28H0ketutSAYdZPkl/9vnk1Atx7CRMsr
         qU+lT7482lCSz7nX1q1iOb1sFjjsA9cBknqIOuaSyilu98Wnl3b98H/hhewIdhUWHboB
         yuxA==
X-Gm-Message-State: AOAM532cir/giCYBUiLLQAfQeaY/epjZ73+QDvR0asm6r59E9AKdAlJX
        6ejorrRREmqEzlhwS4hBqw3F33kabT9wdmFDAC8aa8GWAcs=
X-Google-Smtp-Source: ABdhPJz1eubBaNykHAng/IZDj7kT7tjc9C3PzmivQAl2oP96fu9IkpthTTsHYE4upVH3Nks1vBrVe8qb9HwNojJ3nsk=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr8018582ejd.568.1631261341720;
 Fri, 10 Sep 2021 01:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <patch-5.6-bcc640d32a1-20210908T151949Z-avarab@gmail.com> <CAPig+cSK+wLPUDuGf1d41J_F5jQS+J=a=7kHQLV07-ZKZW9GsA@mail.gmail.com>
 <87bl52hn40.fsf@evledraar.gmail.com>
In-Reply-To: <87bl52hn40.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Sep 2021 04:08:50 -0400
Message-ID: <CAPig+cROO1VT9Umdtor9zc8eftyDTBg+ER2igZG+jxygM9gLJw@mail.gmail.com>
Subject: Re: [PATCH 5/6] help: correct logic error in combining --all and --config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 3:40 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Wed, Sep 08 2021, Eric Sunshine wrote:
> > I personally find it highly frustrating when a program merely dumps
> > the usage statement without any explanation of what exactly it doesn't
> > like about the command-line. Printing out a simple:
> >
> >     --all, --guides, --config are mutually exclusive
> >
> > message would go a long way toward reducing the frustration level.
>
> I'll make it emit something more helpful.
>
> More generally I've got quite a bit of parse_options() improvements
> queued up locally that I've been trying to trickle in at the rate I can
> get them through the list, review over at [1] would be much appreciated.
> https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com/

My review time is very limited these days (which is why most of my
review comments lately are superficial), but I set aside some time to
review that series for you[1]. Most of my review is subjective, but I
did identify one lurking bug (assuming I understand the code
correctly).

[1]: https://lore.kernel.org/git/f8560b11-ba56-0a52-8bb4-5b71f0657764@sunshineco.com/

> I wonder if we can do this automatically, we already have the
> builtin_help_usage, we could parse that in the general case and find
> that certain options are mutually exclusive per the examples there.
>
> We'd then discover what option we parsed when usage_with_options() was
> called, and automatically emit a useful message in these sorts of cases.
>
> Of course the usage strings might be incomplete or wrong, but part of
> the point would be to find those cases & a test mode to die() if a
> command was called with some option combinations not suggested as
> working according to its documented usage...

Perhaps, though I imagine it would have to employ some, um,
"interesting" heuristics, and be quite hit-and-miss at first, at least
until people get around to formalizing existing and new usage strings
with the specific goal of supporting that feature.

Speaking of heuristics and wishful thinking, when I read the cover
letter of your series which I just reviewed, I thought at first that
the end-goal would be to ignore whatever indentation the caller
provided following each embedded newline, and instead insert the
correct computed indentation automatically. This approach would
obviate the need for the [1/2] indentation cleanup patch. However,
doing so would require heuristics or at least manual help from the
caller to indicate the proper indentation width. I also thought
perhaps the intention of the series was to do the line-wrapping
automatically (ignoring any caller-provided embedded newlines), thus
ensuring that the lines were indented correctly _and_ fit the terminal
width properly regardless, but that's a somewhat more substantial
change.
