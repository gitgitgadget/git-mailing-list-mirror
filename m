Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64957C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 17:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKJRaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJRaN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 12:30:13 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A625F2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:30:12 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id x7so1372853ilg.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJCi0f893B+VZn6MqhIs2o4nFAkC2H3jx50FuqpGwaE=;
        b=ad5rCv37DUFvm7Evpa1W0DWQ9kX+2amNAb7wtguoDZxyYcFzrEybGGOLjJFrkYoN2e
         /Df2fEgqbt4Ipvhv0O1iHC+WTcdl9/T5YET/vMw7x1Imy+yWmegPXkZDutR1DNkejl/i
         RrPu1We6/lRWju0k/RcOp6JEOLOkq+uB40sfvCwISTO4wbdBDgQYVjwvjsw9aFm8d2aA
         Y0GMv29RakTHXNza668bgzVps2hCCmCuA+x0KA1EDUqMDL29xttW9fogxDJexQ0PONzF
         E2NyNCzXQte5ChYydVGY0cNakQCbL3ZU2FvojrOr3sjNkq/LVl1hdOBWQd09LNW+inoR
         +3JQ==
X-Gm-Message-State: ANoB5pnJHDsKPMdEssKd1o2WOZH9wRSl73tfe/kzh2q0VFrbbLDdg+cQ
        4yker+R5veRXRyPw9/DqKXEnckKQ1FqWQBeM4is=
X-Google-Smtp-Source: AA0mqf7+jP6OaBKDliWgzoToxvd2Hm892P4+G7l286bW+5jv9hEpYnmWNzuRczrv2faGxUk959/fuip4ljWEQ76Ek1A=
X-Received: by 2002:a05:6e02:4c6:b0:302:37ff:ae27 with SMTP id
 f6-20020a056e0204c600b0030237ffae27mr414993ils.249.1668101411994; Thu, 10 Nov
 2022 09:30:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
 <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com> <CAPig+cTGG-y6myEYOVeF8W9QBdCjhqeghsepi-2R9V-v7=YwZA@mail.gmail.com>
 <CANaDLWK9ZhtqdpJJCNvOJ24x0jtUzZjZE5WKdzBPnePA4eGqTg@mail.gmail.com>
In-Reply-To: <CANaDLWK9ZhtqdpJJCNvOJ24x0jtUzZjZE5WKdzBPnePA4eGqTg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Nov 2022 12:30:00 -0500
Message-ID: <CAPig+cTFRV=Np2oV5QJDpmwOwBaTVnjmAqcz-Ny7hCi6PexQUA@mail.gmail.com>
Subject: Re: [PATCH v4] status: long status advice adapted to recent capabilities
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 12:02 PM Rudy Rigot <rudy.rigot@gmail.com> wrote:
> > the <<- operator allows you to indent the here-doc body
> > (with TABs, not spaces), so you can align the body with the rest of
> > the code
>
> Unfortunately, that's how I had done it first, but since some of those
> lines are blank, the test code had lines just made of "<tab><tab>" and
> nothing else, which made the check-whitespace check fail. I considered
> replacing empty line with something on the fly with sed (like just an
> "x" character for instance), but this felt hacky and brittle (in the
> unlikely case where an actual "x" would find itself genuinely lost in
> the middle of that output, the test would mistakenly pass). I went
> with the solution I'm presenting here because the readability
> downsides of missing that indentation felt less bad. Definitely
> willing to be convinced though.

Okay, I see what you're getting at. Fortunately, there is a simple
solution as long as those lines are truly blank as emitted by `git
status`: just leave the blank lines completely blank in the here-doc
body (don't bother inserting a TAB on the blank line). This should
product the exact output you want:

    cat >../expected <<-\EOF &&
    On branch test

    No commits yet
    ...
    EOF

Although it should not be needed here, the `sed` approach is generally
fine, and we use it often enough in tests, though usually with a more
uncommon letter such as "Q". See, for instance, the q_to_nul(),
q_to_tab(), etc. functions in t/test-lib-functions.sh.

> > I presume the reason you're escaping the "trash" directory is because
> > you don't want these untracked "actual" and "expected" files to
> > pollute the `git status` output you're testing?
>
> You are presuming right! The test was being flappy in CI runs before I
> changed this, which I found used as a solution in other
> git-status-related tests currently in the codebase. I'm not familiar
> with the trash directory approach, but I'll figure it out.

Each test script is run in a temporary "trash" directory which gets
thrown away when the script finishes. We want tests to constrain
themselves to the trash directory so they don't inadvertently destroy
a user's files outside the directory.

I see what you mean about some existing status-related tests using
files such as "../actual" and "../expect". It's not at all obvious in
a lot of those cases but they are safe[*] because those tests have
already cd'd into a subdirectory of the "trash" directory, thus
"../actual" is referring to the "trash" directory itself, hence the
tests do constrain themselves to "trash".

Anyhow, I suspect that crafting a custom .gitignore file in the test
setup should satisfy this particular case and allow "actual" and
"expected" to reside in the "trash" directory itself without mucking
up `git status` output.

[*] Unfortunately, some of those scripts are poorly structured because
they `cd` around between tests, which can leave CWD in an unexpected
state if some test fails and subsequent tests expect CWD to be
somewhere other than where it was left by the failed test. These days,
we only allow tests to `cd` within a subshell so that CWD is restored
automatically whether the test itself succeeds or fails. So, this is
safe:

    test_expect_success 'title' '
        do something &&
        mkdir foo &&
        (
            cd foo &&
            do something else >../actual &&
        )
        grep foo actual
    '
