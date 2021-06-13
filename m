Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12328C48BE8
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 23:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CDB6136E
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 23:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhFMXqB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 13 Jun 2021 19:46:01 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37692 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhFMXqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 19:46:01 -0400
Received: by mail-ed1-f50.google.com with SMTP id b11so44109557edy.4
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 16:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4bGSz7vlzwAkjUvzv+YzlDzDQaJBppfTMiaxfSEu10U=;
        b=Hys3tTZTssRqq/Lk7bTtNjSk2OUyQ2WVC377ywYsuUrAjrWMnvCBCIknqjnA55bzcH
         F53zaLuQIxip7KJJvgovSDWpKiZ6wfHIxA9XOvz77eYAhXz1k7QRmig7yhqgPuaejOjh
         tIJD8cu67U+7v3DkcoOUfQU6Ggi8cPpo/kKJz5qsxevlhXPOC3N84It43SxeYJN5WbU8
         0x4aSIiIR/L80lA+YyPxp23jgn2j0eGOFktwlTAnc6MC0P11PaejhT5fZsrOX59SH2cV
         MnW3RFFAoEI5hqxI1Guo1CMgVeWWwryrFh9wkrWPEzbqt7h+/H7LSvIaloSBiAQw76Hj
         aqPw==
X-Gm-Message-State: AOAM531ZuEKgHHg/OEfI5NICth/DfZG4kXA3LotVYl2LBW4nSN8lFW2O
        zxWA3NdJqDA++PkMevY860fl8YsvyDqzIrjHe3s=
X-Google-Smtp-Source: ABdhPJwcJMnAFLIPXih/VsQZTSBwR1BvSxB4ynEMBmpbL9bEOV+bO0adr5TaaWtZfYYBSZzFQAt1LQoWSaKI41Cdu/c=
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr14100058edb.181.1623627825167;
 Sun, 13 Jun 2021 16:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210612042755.28342-1-congdanhqx@gmail.com> <20210612042755.28342-2-congdanhqx@gmail.com>
 <87bl8928q9.fsf@evledraar.gmail.com> <3ab4f29e-987a-c7de-0cca-a64c3bf4be47@gmail.com>
In-Reply-To: <3ab4f29e-987a-c7de-0cca-a64c3bf4be47@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Jun 2021 19:43:34 -0400
Message-ID: <CAPig+cRFjBXpm_WwSGBYu75z8TabCDZodYi=wKgTamB1a3aGmg@mail.gmail.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 2:18 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 13/06/2021 14:28, Ævar Arnfjörð Bjarmason wrote:
> > On Sat, Jun 12 2021, Đoàn Trần Công Danh wrote:
> >> +       { test "x$1" = "x!" && test $# = 1 ; }
> >> [...]
> >> +    if test "x$1" = "x!"
> >
> > We don't use this test idiom in other places, it's OK to just use "$1" =
> > "!". I think we're past whatever portability concern made that popular
> > in some older shell code in the wild.
>
> Slightly off topic but if anyone is interested in the history of this
> test idiom and why it is no longer needed there is a good article at
> https://www.vidarholen.net/contents/blog/?p=1035

Thanks for the link to the article; it was an interesting read.
However, the article does seem to say that such idioms and care may
still be warranted. In particular, the epilog gives an example which
is still relevant on macOS today. (Indeed, I just tried it and it does
error out as the article states.) Even discounting macOS, it also
talks about such bugs existing as late as 2015, which isn't long ago
by any stretch. (And, as someone whose primary -- indeed only --
development machine is ten years old, some of the other bugs it
mentions -- which existed as recently as ten years ago -- don't seem
all that long ago either.)

At any rate, for those of us who are old-timers, the `"x$foo"` idiom
is habit and only costs a couple extra characters, so I for one have
no problem with its presence in the proposed patch.
