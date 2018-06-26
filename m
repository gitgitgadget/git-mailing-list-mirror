Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1184F1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeFZUqb (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:46:31 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46092 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeFZUqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:46:30 -0400
Received: by mail-yb0-f194.google.com with SMTP id s14-v6so7126487ybp.13
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/TISwrM79MFVE5SDYgBPJAfsVh3OoTj0RGu+t4DUhM=;
        b=L3xxalLzEERBIiSuXfbN4KHzzlzkxzoiAweKPUy3kXUWFMOvIPAsh+i83ztP8IDX8U
         P5PiP22QCofqtzBTxbQUwdatwdyklnVTxtFIKnHW3xVlkKvvgioFYeUwIdsc9VbbJRhA
         5uFSY0yO8/jRMBGGFtegZGUM++wHDgtiK+B3XrR3MJO8bBEEbjGBWVdgysnEfbHEOlOZ
         rwAeNTyyjCuzTNwmdEFN8M7lztOYKdLPtNDSY0fTDFS7GZIwZW26jfDwefDm1cwy1AC+
         XgM/Irk9je4iqBX158eEuNHQzJ3EmaH854v79typLti3fAecR1Wl11hqf9ZfJNoCKD82
         7Qlg==
X-Gm-Message-State: APt69E33k5hqzVex5+bJXkMKAZ6PHQsOV4rnPmBYRaXiLblR0U3ATfpA
        nkYqxqtbZpEU+Z0RDa/cJydMFTA7Ccg1VUAdscQ=
X-Google-Smtp-Source: ADUXVKJHkRaRS/t7celhIAiD1XVP67hN+f7E5ohBrPDPUYgy4sYz3gBCuYNfHLjURuGjGYy3pAHQFjSUuuB+jEOxXZc=
X-Received: by 2002:a25:ac5b:: with SMTP id r27-v6mr1644966ybd.497.1530045989363;
 Tue, 26 Jun 2018 13:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com> <20180626201708.GA2341@sigill.intra.peff.net>
In-Reply-To: <20180626201708.GA2341@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 16:46:18 -0400
Message-ID: <CAPig+cRvgsu-6f+mzjGVDWTVhFrhLY5MsNxEQBJYckKDpeaMAg@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 4:17 PM Jeff King <peff@peff.net> wrote:
> On Tue, Jun 26, 2018 at 03:52:54PM -0400, Eric Sunshine wrote:
> > So, this isn't a new problem introduced by this series, though this
> > series may exacerbate it.
>
> Whereas once you start collapsing subshells into the main logic chain,
> there's a very high chance that the subshell is doing a "cd", since
> that's typically the main reason for the subshell in the first place.
> And with the current --chain-lint logic, that subshell is either
> executed or not executed as a unit.
>
> Obviously that's a bit of a hand-waving argument. If you've fixed all of
> the existing cases without accidentally deleting your home directory,
> then maybe it's not so likely to be a problem after all.

Indeed, it could be that the "rm -fr" worry is tending toward the
hypothetical. Seasoned developers tend to be pretty careful and
usually avoid indiscriminately loose "rm -fr" invocations, so I'm
somewhat less worried about them. I do share the concern, though, that
newcomers crafting or extending tests could shoot themselves in the
foot with this. However, newcomers are also the ones most likely to
use the "cd foo && bar && cd .." idiom, so they are already at risk.

(As for not blasting my home directory when fixing all the existing
tests, I did run into a few cases where one or two "foreign" files
were deposited into the "t/" directory, but nothing was deleted or
overwritten.)

> I'm not sure if there's a good solution, though. Even if you retained
> the subshells and instead did a chain-lint inside each subshell, like
> this:
>
>   (exit 117) &&
>   one &&
>   (
>         (exit 117) &&
>         cd foo
>         two
>   ) &&
>   three

I thought of that too, but the inner (exit 117) doesn't even get
invoked unless there is &&-chain breakage somewhere above that point
(for instance, if "one" lacks "&&"), so the inner (exit 117) doesn't
participate in the linting process at all.

> that doesn't really help. The fundamental issue is that we may skip the
> "cd" inside the subshell. Whether it's in a subshell or not, that's
> dangerous. True, we don't run "three" in this case, which is slightly
> better. But it didn't expect to be in a different directory anyway. It's
> running "two" that is dangerous.

Just thinking aloud...

Aside from "rm -fr", there are numerous ways to clobber files
unexpectedly when the "cd" is skipped:

    echo x >../git.c
    cp x ../git.c
    mv x ../git.c
    ln [-s] x ../git.c
    /bin/rm ../git.c
    some-cmd -o ../git.c

Some of these dangers can be de-thoothed during the linting phase by
defining do-nothing shell functions:

    cp () { :; }
    mv () { :; }
    ln () { :; }

That, at least, makes the scariest case ("rm") much less so.
