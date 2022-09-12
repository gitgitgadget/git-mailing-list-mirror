Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562DCC6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 23:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiILXR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiILXR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 19:17:26 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59094D4E4
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 16:17:24 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 198so10076551ybc.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 16:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RNrJKIFUFT3kICGQ/MbOs043T3DlqVnEBJwsx7vml9c=;
        b=nozG4QJoIW5HDvYZsCRaj1ZEe3/VS6X2lHoIBFnxKqox2oJZaMnnzqIN0NYPS7M4cQ
         CM6itrwP9yTLfpsXrmNxIQPF+vLmkSc5BBZr3zssiOtfjHyMh8elafeoGWn3wTabETMp
         cND9h1JMcTdV2eLH8P8bOgbUEk+MxxMNQ6ccV9bWUZxequfHomcgMo9ZuPPP3kgV3TTj
         j0MQMZRArM7nl+0OylO5AX9L8x+3eD4RNFHpj0JC5eCIwBjlyfRyUGSlZMIZARct1rfF
         7aaC/knE4R9dHgXAgI8XxMgXVdZ8T7BXg+3MqmeK60KzLtnmILUDoBQnlYJXfPv5VE33
         ayZw==
X-Gm-Message-State: ACgBeo1oJ1e+A/syITdY8cuwVlhMG++yLILTe/Qhv1EzPaChUckOjvn5
        e2cgPfOh2WWUHjYSFuv0ZnH3uzjlhw9WfRZfOTY=
X-Google-Smtp-Source: AA6agR6ET+VBWTZ/rA66Ncy0PFfzgxjLj5N/Ko0Jx8GT1+8EsBdIEvqsLNySC+Rv7hvVbUVqlLWzc+rsaaot3rxIwUQ=
X-Received: by 2002:a25:86d1:0:b0:6ae:e2fc:9f90 with SMTP id
 y17-20020a2586d1000000b006aee2fc9f90mr9246284ybm.475.1663024643785; Mon, 12
 Sep 2022 16:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <Yx1x5lme2SGBjfia@coredump.intra.peff.net> <CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com>
 <Yx4pg2t6JXR+lsd4@coredump.intra.peff.net>
In-Reply-To: <Yx4pg2t6JXR+lsd4@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Sep 2022 19:17:12 -0400
Message-ID: <CAPig+cTmosgapa=iUir3-J9k3138DvecHkmX+0QeHJROeTCeeA@mail.gmail.com>
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

On Sun, Sep 11, 2022 at 2:31 PM Jeff King <peff@peff.net> wrote:
> On Sun, Sep 11, 2022 at 03:01:41AM -0400, Eric Sunshine wrote:
> > > I wonder if color output for "# chainlint" and "?!" annotations would
> > > help, too. It looks like that may be tricky, though, because the
> > > annotations re-parsed internally in some cases.
> >
> > I had the exact same thought about coloring the "# chainlint:" lines
> > and "?!FOO?!" annotations, and how helpful that could be to anyone
> > (not just newcomers). Aside from not having much free time these days,
> > a big reason I didn't tackle it was because doing so properly probably
> > means relying upon some third-party Perl module, and I intentionally
> > wanted to keep the linter independent of add-on modules. Even without
> > a "coloring" module of some sort, if Perl had a standard `curses`
> > module (which it doesn't), then it would have been easy enough to ask
> > `curses` for the proper color codes and apply them as needed. I'm
> > old-school, so it doesn't appeal to me, but an alternative would be to
> > assume it's safe to use ANSI color codes, but even that may have to be
> > done carefully (i.e. checking TERM and accepting only some whitelisted
> > entries, and worrying about about Windows consoles).
>
> We're pretty happy to just use ANSI in the rest of Git, but there is a
> complication on Windows. See compat/winansi.c where we decode those
> internally into SetConsoleTextAttribute() calls.
>
> I think we can live with it as-is for now and see how people react. If
> lots of people are getting confused by the output, then that motivates
> finding a solution. If not, then it's probably not worth the time.

Well, you nerd-sniped me anyhow. The result is at [1]. Following the
example of t/test-lib.sh, it uses `tput` if available to avoid
hardcoding color codes, and `tput` is invoked lazily, only if it
detects problems in the tests, so a normal (non-problematic) run
doesn't incur the overhead of shelling out to `tput`.

My first attempt just assumed ANSI color codes, but then I discovered
the precedence set by t/test-lib.sh of using `tput`, so I went with
that (since I'm old-school). The ANSI-only version was, of course,
much simpler.

[1]: https://lore.kernel.org/git/pull.1324.git.git.1663023888412.gitgitgadget@gmail.com/
