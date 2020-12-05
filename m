Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D7C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 02:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D5922DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 02:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgLEC1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 21:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgLEC1p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 21:27:45 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDCC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 18:26:59 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so7823297edt.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 18:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=QzE4Z1AUpw7nJLJX+xki1TSsoqo3owyr3FbKd/uuNhE=;
        b=bpEyhOGUy+957JDFhk3MxtP+yv8XAsJp6QqGLyabd5/WwvvENt6pQfAxQYdtp2TESn
         MPfBSfmAcWUbrj3aRJ1pPPc0cUyw2hq8eLhyJCamUCsRCCb2Vf/Z3L8t0HuBhrho3MJr
         WbBdNkwEUYWFdWNVS8g2bibFA+8Aci0EGRnyUK4hrJIh/iMZ0w5Hb0qNhg3k+DAiwaKa
         /T/NfwlHl/i9Tg1sjsfIbX1tdXKRXI7KwIy+jJqkmY4HhCb8cBqIvO37xSO6ygutJkOh
         yWa+O3T4GTY8LbUAF3X4SwqybZyuqVPNvjYl9bNc9yQruZ5CQ+40CX5UkiNWSBlMRq3S
         dLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=QzE4Z1AUpw7nJLJX+xki1TSsoqo3owyr3FbKd/uuNhE=;
        b=TL8hUkU72mGm+oYAI0oGLwHadNzfqrHpPx2y+hoI1ACSRv8a7E4LdvlpTaaghKvM0d
         ejsVYiHTk43YHl13/ZtUzlvio11SfmoBlgSuxupua2nfWVdtlFOHQgIg2uXp93WmewM1
         aXmLlSi7THA8X7vxkrMtZRkrFouMbfYTGKhgIZHIIuBY6j2at/HqATrF37w6rBobdE0q
         Igqa2wuFhL1ugg9K8SOSMukkFBzT7LFCEy0Hkr8gVHpgd6wV8G/1CFTTGQuEy4OSezbx
         Q0xkX4iHya/zuDR0/uoYou0TH6GpWD6qqJV/MzbeYBYiDY+LsULR4zZfWgtxuzBcdyK2
         iTFA==
X-Gm-Message-State: AOAM531Q2JweULA1FOU/JTGR4kBrjbmB8RylJTvbAqefVnLkGF5mtHX6
        x4s7tT1kdzHXsRWhaZ7Q4mk=
X-Google-Smtp-Source: ABdhPJx4ec01AF0hlnwlTKclFqteKkdIicAgHddDR56hd9s22PUFt7saV80vPNIvoqonlUdARW43kw==
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr10517971edp.342.1607135218372;
        Fri, 04 Dec 2020 18:26:58 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id mc25sm4287269ejb.58.2020.12.04.18.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 18:26:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 7/9] commit-graph: drop count_distinct_commits() function
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
Date:   Sat, 05 Dec 2020 03:26:56 +0100
Message-ID: <87sg8lxa1b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 04 2020, Jeff King wrote:

> When writing a commit graph, we collect a list of object ids in an
> array, which we'll eventually copy into an array of "struct commit"
> pointers. Before we do that, though, we count the number of distinct
> commit entries. There's a subtle bug in this step, though.
> [...]
> -	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
> -	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
> [...]
> +	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);

One thing your commit messag doesn't note is the removal of this
TODO. Theoretically we still have the issue I noted in 890226ccb57
(commit-graph write: add itermediate progress, 2019-01-19), in practice
I think it's fine to just forever remove this TODO.

I tried now on a really big repo and couldn't even get the progress bar
you removed to appear, or the one you moved the QSORT() to.

Maybe I need to go even bigger, but more likely I overdid things a bit
when I added all these progress bars to commit-graph.c at the time.
