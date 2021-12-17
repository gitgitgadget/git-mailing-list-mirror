Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F66C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhLQEu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhLQEu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:50:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C117FC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:50:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e3so3272102edu.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VWUPqYzDaGyZoajOollIwlLEjDhi5TXE2fdw8zujYgo=;
        b=GFpui0P1bo5S//yOWtcjGxEuJefqlIKLXLEd0sBZnes2aSB5QgIPZmqfyNKZWVPSps
         U5WXVus42ZlgEK71Hj2dsx4V2wF9wlMX9YhlS7AbTdk+Onh5myUaoSWG+uB2MJjj+SyU
         HtrXCqAQK7q9rs3ZkUEEp/MVgUhL4CxodrQYIdRtH+iHYh+chvmIFf6KyePzmQExFTlC
         c4NxHYu8zbFqyfqibRMr5b99bzqXxQB+EUbAKb6WY0u/bZQdkMB9oYeDGSYM8/vMQO4o
         60asWWyXvlRKd2MFp5/ZiUPLw/fHKPMQg86r5ig9LKqHyCUbCE+GyGx3OXTorWYTqIIk
         LzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VWUPqYzDaGyZoajOollIwlLEjDhi5TXE2fdw8zujYgo=;
        b=zoxq9x2CPv7g9mvL3AJvSXlD4kQdHe8Eio55dWmDiv+5Hv48RLz/1nsXOL+RIMBW6Y
         p9gKoUnyOzjOjOJuLEjuBDPRnUNphesji+Hk2vxvgu88rMi2HGNIA9ZrqoRlegSYMAzn
         uLpXnJ5/FQgcIuKQaQA3/l/hYx+pl2P/xb2t7YJpytyaqIxLmMUodwIqXvRKVgD/uyhS
         4CVVFbYSR/Fu6XGVY/WdIhkXJspoKGnAjuCKL3M/g4RTJMJFaYX8UEuSNr9avozLssK3
         A2ZEvRVfTCyyH+cMEz3I83FDUKKdLA/RTUOIR99qkLgqqjf3LYdrMwXBE1BSisjhBzEG
         vSGA==
X-Gm-Message-State: AOAM530ny2DEJnC2ysaoZJ7qRim4cdLyeoIYqs9HytgCEh0zQOBaweyj
        mf/z1USMnn7CXkBwKx+jmXdHD12nXWznSQ==
X-Google-Smtp-Source: ABdhPJwp9q70lSwweuJX8EgAM/y3pieN3RjEebBiKkdqZVqCJJLI/lLFKxYFW39ssvyUbr+XTbsP1Q==
X-Received: by 2002:a17:906:990c:: with SMTP id zl12mr1110330ejb.370.1639716655251;
        Thu, 16 Dec 2021 20:50:55 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn8sm2406212ejc.23.2021.12.16.20.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:50:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1my5Co-000jJB-BU;
        Fri, 17 Dec 2021 05:50:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4204 is not sanitizer clean at all
Date:   Fri, 17 Dec 2021 05:39:04 +0100
References: <20211213220327.16042-1-jerry@skydio.com>
 <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
 <xmqqtuf86t7z.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqtuf86t7z.fsf_-_@gitster.g>
Message-ID: <211217.861r2bal75.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Junio C Hamano wrote:

> Earlier we marked that this patch-id test is leak-sanitizer clean,
> but if we read the test script carefully, it is merely because we
> have too many invocations of commands in the "git log" family on the
> upstream side of the pipe, hiding breakages from them.
>
> Split the pipeline so that breakages from these commands can be
> caught (not limited to aborts due to leak-sanitizer) and unmark
> the script as not passing the test with leak-sanitizer in effect.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  A quick grep tells me that tests 3302, 3303, 3305, 4020 and 6236
>  all use "git log" and still are marked as passing tests with
>  leak-sanitizer in effect.  I've taken a deep look at none of them,
>  but I suspect they share the same kind of breakage.

This change looks good to me.

FWIW this is not a mistake on my part, but something I'm perfectly aware
of. I don't consider it to be "brekage".

We have plenty of place in the test suite where we hide exit codes on
the LHS of a pipe, or where we call a function that doesn't &&-chain its
git invocations.

In those cases we can and usually will "succeed" under LSAN, because it
allows the program to emit its full output, and will abort() at the very
end.

I have an unsubmitted logging mode (using LSAN_OPTIONS=log_path=<path>)
where I log every one of these to test-results/*, there's a lot more of
these.

But in the meantime I think the best way forward is to gradually mark
the tests that pass with LSAN as passing, to ensure that we at least
don't have regressions in the meantime. Before this we'd at least check
the "git checkout" etc. for leaks.

If I made fixing all broken &&-chains or git on the LHS of a pipe a
prerequisite for marking as passing under under LSAN I'd end up with
something that's approximately the size of [1] and more (i.e. Eric's
upcoming patches to do that).

I don't see why we'd consider perfect the enemy of the good in these
cases. Yes we won't catch the successful exit of every single git
invocation, but our tests aren't doing that now, LSAN or not. But until
that's fixed we'll at least catch some, which helps our overall memory
leak regression coverage.

More importantly it makes it a lot easier to reason about future memory
leak patches, as we'll be able to get to a 1=1 mapping of tests that
pass, and those that are marked being known to pass. I'm using that
locally to fake-fail those that start passing unexpectedly that aren't
on the list, which then helps to inform the addition of "this test now
passes with no leaks".

1. https://lore.kernel.org/git/20211213063059.19424-1-sunshine@sunshineco.com/
