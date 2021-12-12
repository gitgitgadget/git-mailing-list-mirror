Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B19C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 18:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhLLSvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 13:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhLLSvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 13:51:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE0C061714
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 10:51:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r25so45091307edq.7
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qkSAEkCcg1tPSCPf7oZyV+B4s3M4WBgHYmHXlnPah1E=;
        b=qauFzXr1NVJEmEAwEsZQzxQOiNb/dirO9sSIFZaeJU4Z8D5s0lEqLYQRXQNnpbnHAR
         sBmojnmQO+3anGzmOesxPZHqa/NrGUEzTzCwCAGaK45H2yS0RmPXPBaTx1ZhAnIHXO5d
         +1TPXPkh8pqODotuID7Ag3qF7UgEDA2eG1rAFQ8WyDrRDuctTQiVWcOgjkiqd5p1iS2l
         8FRkUkQnHeH+AjNaWCQqHL9YszVx7LopmioeH9JT+Uf4OUvbhFszC9eJ1RPJ+3A+kVem
         G+LbEenWEydRuNOfJIUFex4ATwtjXxd8tGA7hVtBe+8+lXP2/SvPadNi2HSSv5ELzu7b
         c4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qkSAEkCcg1tPSCPf7oZyV+B4s3M4WBgHYmHXlnPah1E=;
        b=BNkLw85tDnDZjXBxhEFPJJIeEDTiB0ULxMzTKfQvKGm6wKTXtYJkTiFKPZCZ4fuQFn
         k7quFMI6MkHMdD6cpaf65gWo8tG5FKyTTEnbDE0VxuD48YQ+zoXtcBb0qK9zPXrmwRBi
         c+ojZr7LRDgmRrhd+w5TN1rJ1VeO41KwS4bG4hxtQwHMz8p1RxQvZ7Hn+BtEfj83qWU0
         kObGIlGAUYRBdowT+vk84ke6oVglf6j4RfHARO6tcmokabE0kxWLLcEU6xgwNroswAsn
         GoQu1zfWcLNEDr9dpGoCBbRtDqXAUXIPQD0agRMlzBqr9bmQdHNLT17cF+UuYELs+kC8
         ikVQ==
X-Gm-Message-State: AOAM531N9HB5ojw0qrUB8la3xpOVL/qkVI2UuUJGLoPBP/TUyeS1W4Xf
        uMqM/uQGS+N8s4Q68UQ/XgoO4cgwcL0=
X-Google-Smtp-Source: ABdhPJwISyEYkn63xH1PSUui/GDOq2nvDRfXUd/lX9VF2Ac6lmyHC4TLUtjkl/nRdFltQIB7D6m9ew==
X-Received: by 2002:aa7:d80d:: with SMTP id v13mr57356997edq.7.1639335060090;
        Sun, 12 Dec 2021 10:51:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ga26sm4682379ejc.11.2021.12.12.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:50:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwTw3-000Zxd-8D;
        Sun, 12 Dec 2021 19:50:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: ab/only-single-progress-at-once (was: What's cooking in git.git
 (Dec 2021, #03; Fri, 10))
Date:   Sun, 12 Dec 2021 19:41:38 +0100
References: <xmqqilvvluoa.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqilvvluoa.fsf@gitster.g>
Message-ID: <211212.86sfuxac8c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Junio C Hamano wrote:

> * ab/only-single-progress-at-once (2021-11-03) 8 commits
>  - progress.c: add & assert a "global_progress" variable
>  - various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop commands on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leaks in "test-progress" helper
>
>  Further tweaks on progress API.
>
>  Needs review.
>  The last three rounds has seen little reaction, even though earlier
>  round saw a lot of responses. The latest round needs a serious
>  review or at least Acks from past commentors.
>  source: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>

I think less in "needs review" and more in needing a tiebreaker and/or
reply to my [1]. I.e. the ongoing discussion SZEDER and I have had about
the relative danger of adding this BUG() to this part of the code.

I think the best thing to do is just to merge it to "next".

Maybe I'm wrong about the BUG() not triggering in a way that someone
will spot if we expose this more widely.

But we've been having some version of that discussion for the past few
months without any any new specifics about *how* it might be raised,
just (I think it's fair to say) general paranoia that it might happen
somehow/somewhere.

Which is fair enough, but I'd think a good way forward with it would be
to give it wider exposure during this cycle. If it's triggered somehow
it's trivial to amend/revert the tip commit to remove the assertion.

If we merge it down I promise I'll (and try to remember to, putting it
in my calendar if so...) start some discussion before the next release
about whether we'll want to cut the release with that BUG(), which if we
don't trigger it by then we'll probably feel confident about keeping.

Does that sound like a good way forward? Otherwise the "one alternative
way forward[...]" mentioned in [1] is something we could do.

1. https://lore.kernel.org/git/211203.868rx2t0hv.gmgdl@evledraar.gmail.com/
