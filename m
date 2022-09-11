Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED9C6FA83
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 07:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIKHB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 03:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiIKHBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 03:01:55 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993E4764D
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 00:01:53 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3450990b0aeso65300177b3.12
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 00:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CapxCC+ncEuMAH0OVj7Ztgc7RzPQ1Z4zQuzNM7p9tFk=;
        b=5mmqDhwzUM+4WVQD8t/8N+aSgl9nYm5y7Khka8fMKdWaLBaPbKW+/D2hPoGgxJFj/0
         MaDWZtgEbc8CUJ8bbR7xUtP5QEh/zvHe70kghdhkTn7M3mEBlmk9o+PBEg65sfdwxqS4
         31ZhLcC6jcQ5nT7XkFUYmJbLRJJVOM+1of7YdJWmlGDLyVtoNy4Cotyt3Y95HYVchriJ
         XsakJhUULiZDFScaREAqZoiYVHOj32GeWN8yPop7HXc3rNMcaPln0qhEvS9RmUjpTpHf
         lfhHLL9qKw0jfPV5HgqOIJ0tUGmmzEIFQCCwF7HAzieaomGbNNMT0AuYNGf/sW4ccKra
         LsBA==
X-Gm-Message-State: ACgBeo3p/hCnEDlZra5YfEH2vpAefT+Xy47j3hw3wjv+MVNBW3Sd+PhW
        7MvxbVuCblX4rfOzuPf2Supy+GEdUc+3A1CdG1o=
X-Google-Smtp-Source: AA6agR79SwGmOl8595OrAnJsdyz3eG+FjIxoTr/R7gy2OibHPHsq3fmyymt9t4v5FQ8Sn2AB56PsT2Bu18mlL2hucGI=
X-Received: by 2002:a81:6504:0:b0:349:289e:3494 with SMTP id
 z4-20020a816504000000b00349289e3494mr1762369ywb.210.1662879712714; Sun, 11
 Sep 2022 00:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com> <Yx1x5lme2SGBjfia@coredump.intra.peff.net>
In-Reply-To: <Yx1x5lme2SGBjfia@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Sep 2022 03:01:41 -0400
Message-ID: <CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] make test "linting" more comprehensive
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2022 at 1:28 AM Jeff King <peff@peff.net> wrote:
> On Thu, Sep 01, 2022 at 12:29:38AM +0000, Eric Sunshine via GitGitGadget wrote:
> > A while back, Peff successfully nerd-sniped[1] me into tackling a
> > long-brewing idea I had about (possibly) improving "chainlint" performance
>
> I gave this a read-through, and it looks sensible overall. I have to
> admit that I did not carefully check all of your regexes. Given the
> relatively low stakes of the code (as an internal build-time tool only)
> and the set of tests accompanying it, I'm willing to assume it's good
> enough until we see counter-examples.

Thanks for the feedback.

> I posted some timings and thoughts on the use of threads elsewhere. But
> in the end the timings are close enough that I don't care that much
> either way.

I ran my eye over that message quickly and have been meaning to dig
into it and give it a proper response but haven't yet found the time.

> I'd also note that I got some first-hand experience with the script as I
> merged it with all of my other long-brewing topics, and it found a half
> dozen spots, mostly LOOP annotations. At least one was a real "oops,
> we'd miss a bug in Git here" spot. Several were "we'd probably notice
> the problem because the loop output wouldn't be as expected". One was a
> "we're on the left-hand of a pipe, so the exit code doesn't matter
> anyway" case, but I am more than happy to fix those if it lets us be
> linter-clean.

Indeed, I'm not super happy about the linter complaining about cases
which obviously can't have an impact on the test's outcome, but (as
mentioned elsewhere in the thread), finally convinced myself that the
relatively low number of these was outweighed by the quite large
number of cases caught by the linter which could have let real
problems slip though. Perhaps some day the linter can be made smarter
about these cases.

> The output took me a minute to adjust to, just because it feels pretty
> jumbled when there are several cases. Mostly this is because the
> script eats indentation. So it's hard to see the "# chainlint:" comment
> starts, let alone the ?! annotations. Here's an example:
> [...snip...]
> It wasn't too bad once I got the hang of it, but I wonder if a user
> writing a single test for the first time may get a bit overwhelmed.  I
> assume that the indentation is removed as part of the normalization (I
> notice extra whitespace around "<", too). That might be hard to address.

The script implements a proper parser and lexer, and the lexer is
tokenizing the input (throwing away whitespace in the process), thus
by the time the parser notices something to complain about with a
"?!FOO?!" annotation, the original whitespace is long gone, and it
just emits the token stream with "?!FOO?!" inserted at the correct
place. In retrospect, the way this perhaps should have been done would
have been for the parser to instruct the lexer to emit a "?!FOO?!"
annotation at the appropriate point in the input stream. But even that
might get a bit hairy since there are cases in which the parser
back-patches by removing some "?!AMP?!" annotations when it has
decided that it doesn't need to complain about &&-chain breakage. I'm
sure it's fixable, but don't know how important it is at this point.

> I wonder if color output for "# chainlint" and "?!" annotations would
> help, too. It looks like that may be tricky, though, because the
> annotations re-parsed internally in some cases.

I had the exact same thought about coloring the "# chainlint:" lines
and "?!FOO?!" annotations, and how helpful that could be to anyone
(not just newcomers). Aside from not having much free time these days,
a big reason I didn't tackle it was because doing so properly probably
means relying upon some third-party Perl module, and I intentionally
wanted to keep the linter independent of add-on modules. Even without
a "coloring" module of some sort, if Perl had a standard `curses`
module (which it doesn't), then it would have been easy enough to ask
`curses` for the proper color codes and apply them as needed. I'm
old-school, so it doesn't appeal to me, but an alternative would be to
assume it's safe to use ANSI color codes, but even that may have to be
done carefully (i.e. checking TERM and accepting only some whitelisted
entries, and worrying about about Windows consoles).
