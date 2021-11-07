Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD6C433EF
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 01:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3899A61527
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 01:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhKGByF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 6 Nov 2021 21:54:05 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:37390 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhKGByE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 21:54:04 -0400
Received: by mail-ed1-f47.google.com with SMTP id f8so47645057edy.4
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 18:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l657dDspq4HLGlU9IuZAaTUkTcoSSmsd5JYn3RFNX3o=;
        b=gXR0zcFAxYPS2PomsTr70bM6yuYB6pO0qfzhYCKerJ1oZE+q8LEalZoG4yG05ZfJNu
         JmU1b7ylUmOjX27GfXEoGa07+5SzrJ+VE5dGFkgqLLTfL7g6BOalwYuQtZHREkbJV+lp
         I28URgSkWe88QClDCKnf+zLpks0PcUJkOvKRcWqnebkxHrbV8m1oj0EIo9aBUewwtpF6
         mLc55ayJwFBUf98vyyo+/k+WIvuRT9QBqC0fnQYsSqAX2IvyO2VgyqpzSTu4qTFveXkx
         /vfMjQfuC05rz9nE0GLsOVnHmLZdcV+PTuZH4Xhm9GLAigKINLK6CD+mMqzkP92zA9ZV
         v5KA==
X-Gm-Message-State: AOAM530OHfe9YKR8cJfBNNzno4hQ3SmEzT4hylmaLoSLad5e6TCSovtv
        h/wQD9Bw7siJynzEqudgBzWnt/fuqa5E60tANisxIrJ6Y+0=
X-Google-Smtp-Source: ABdhPJxKUtj62Orqyh3EU3GKcZCgGkZ8vRlp25M/ttUdajkJYjnKB77BsLJ+5coDlQkh9uijNpmCLCBnCniW5rgiDlk=
X-Received: by 2002:a05:6402:50d0:: with SMTP id h16mr17765288edb.70.1636249881977;
 Sat, 06 Nov 2021 18:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <patch-05.16-d8e14cb723d-20211106T205717Z-avarab@gmail.com>
In-Reply-To: <patch-05.16-d8e14cb723d-20211106T205717Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Nov 2021 21:51:11 -0400
Message-ID: <CAPig+cT5PbT0k7AdZSc_4WA4=hpvsCyUxNXc_PzE41ok_V5XMQ@mail.gmail.com>
Subject: Re: [PATCH 05/16] Makefile: correct "GIT-PERL-{DEFINES,HEADER}"
 dependency graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 6, 2021 at 5:03 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Fix several small issues with the dependency graph of the generated
> "GIT-PERL-DEFINES" and "GIT-PERL-HEADER" files:
>
> 1. Folllow-up my 4070c9e09fc (Makefile: don't re-define PERL_DEFINES,
>    2021-05-05) and move the rest of the assignments to PERL_DEFINES to
>    one place, and change it from depending on "localedir_relative_SQ"
>    instead of "localedir".
>
>    The former is what we'll actually use, and while it's unlikely to
>    matter in practice (we'd just skip re-building these under
>    RUNTIME_PREFIX if the relative path was the same) it makes it
>    clearer what's going on here by bringing us to a 1=1 mapping of
>    these variables and what's subsequently used in the
>    "GIT-PERL-DEFINES", "GIT-PERL-HEADER" and "perl/build/lib/%.pm"
>    rules below.
>
> 2. We don't need the substitution of " " for ":" added in
>    07d90eadb50 (Makefile: add Perl runtime prefix support, 2018-04-10),
>    let's drop it. This doesn't matter for the correctness of these files,
>    but makes it clear  that (unlike GIT-BUILD-OPTIONS) they are not

Too many spaces between "clear" and "that".

Is the last sentence of this paragraph incomplete?

> 3. Don't have "GIT-PERL-HEADER" depend on the "Makefile". That was a
>    lazy way to over-declare the dependencies added in
>    f6a0ad4be71 (Makefile: generate Perl header from template file,
>    2018-04-10), now that our dependency graph is correct we can be
>    confident in dropping it.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
