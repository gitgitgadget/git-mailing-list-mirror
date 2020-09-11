Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D252C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1893E221E3
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgIKUHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 16:07:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34520 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgIKUH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 16:07:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id q21so11394362edv.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 13:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0crxIq4ZIq8eEWrTWcVNVBvg7o/w5izjfjpcGz3lPg=;
        b=YSsWnB/2tB0Pggo5lJAhLoUHF2LXSjNV5ZY43Xf3bnO/q2X/xUofYMtFZJ6c+utFZz
         UFAZWsJ6u5DG3lKrcwwYjpu1QYSw03JFOVKGW9RpiZUl9vdsk/U4vlax1txUUpVLF7f/
         KSI0h///kPx95/Uw/fML3hPIJhEqFs2MCpQWrSVuB+VQrXGaQePqfq6XDJHm+WCQ3kvY
         pqi6VYN9qgXtaBzfccYELEbDhVQX9fFkIFblCsBgg0dqobku2PTlY19HkR+qjNsArosg
         MnEDZBW6WsE8njVq84xyJvmhpzRVQFtsquwrW/mvbkGoh7cFojgV/daMFw1Fu34+1hrA
         4tWA==
X-Gm-Message-State: AOAM530yGwcOko/E6l8TROw9rE7APleCsby741LZ1c4Kt0zN5aCsdg4f
        I7SXi0HVo0ApAiP+shqTG4qTD8wbnm7awLvylMxVNKhmCcc=
X-Google-Smtp-Source: ABdhPJwtdIx5m14ZhIOigz2dvNXwIKayJf9XMy9zYKeUdsAagt9d0F58mTGLMQ+s7qYpaJ8lHEqUX0eSflUw++Dx9WI=
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr318977edt.233.1599854847354;
 Fri, 11 Sep 2020 13:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
 <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com> <20200911195622.GB2697399@coredump.intra.peff.net>
In-Reply-To: <20200911195622.GB2697399@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 Sep 2020 16:07:16 -0400
Message-ID: <CAPig+cTNjkOSRbP6sQMAhr-etXMt7ejJo3Zm2gu=nvpF00CMvw@mail.gmail.com>
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed
 option pairs
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 3:56 PM Jeff King <peff@peff.net> wrote:
> And the beginning. :)
>
> It's matching the surrounding test, which are written in an older
> inconsistent style. I think it's OK to match them, but cleaning them
> would be welcome, too.
>
> While I'm looking at this hunk, two other things:
>
>  - do we really care about code 128, or just failure? test_must_fail
>    might be a better choice
>
>  - I didn't even know we had test_debug. ;) The last time somebody added
>    a call to it was in 2012. I think it's being used as intended here,
>    but I'm not sure that the clutter to the test is worth it (we have
>    other tools like "-i" to stop at the right spot and let you inspect
>    the broken state).
>
>  - the backslash escapes confused me for a moment. I guess they are
>    trying to hide the dashes from grep's option parser. That's OK,
>    though I'd have probably just started with "bare" since we're
>    matching a substring anyway. I think you could also use "-e" with
>    test_i18ngrep.

Thanks, you said everything I was going to say about this, thus saving
me some typing.

A couple more observations related to a few of the subsequent tests. This:

    template="$TRASH_DIRECTORY/template-with-config" &&

probably doesn't need $TRASH_DIRECTORY since that happens to be the
current working directory anyhow, so:

    template=template-with-config &&

should suffice (unless you had a problem doing it that way). Or you
could drop the variable altogether and use the literal name where you
need it.

Also, instead of:

    (cd clone-template-config && test "$(git config --local foo.bar)"
= "from_template")

would probably be written these days as:

    echo from_template >expect &&
    git -C clone-template-config config --local foo.bar >actual &&
    test_cmp expect actual
