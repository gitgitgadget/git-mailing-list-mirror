Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA6C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB9B61212
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhKEIfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhKEIfT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 04:35:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378AC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 01:32:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c8so13755887ede.13
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ejG68WPA9jfZZ6WaT5r37Ua+7musaPb4n+7venn88tc=;
        b=jI6rIcrbpuO8eGxbu3bv3DvraKKW5Q0XjNr+v9EcP57jmPW4pGWBkiUVWdLxqu2+6F
         nXAhDqOIZhaDAw33Rv8Zhi3SGdIKYGzZJwB0CXkIblnFZpHBmSGlFPRlJ1Wf1FkQx/Ge
         FlIPZNAKwXYh2jtSiz87FAT++0dJKPhO0B6ZyBRcxsMSkCPQ43NDOqQjx3izzzSrAbnU
         d8/IGqz4AX/VberlEjkBx6Hb+Yf+qZr5jKLnKzKI98OQ9O06hha2FQUQAZ1kl6v5f0Ar
         JttG5gFW4Gk+sFmjD/jZxIwzjPcqO91UuBMgYgwRgmTIIpTC6pfUJcpejaecNt8UbTfQ
         cmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ejG68WPA9jfZZ6WaT5r37Ua+7musaPb4n+7venn88tc=;
        b=oohdTzqvn0R4vfi02ty/z44ePFmtw4aws2mqM5JqwBCO4As9UVjBrG3RswFdHJiGLi
         WPTGDugWQCd/8rYkzp/HiCyM/05wf9yDQTeZJ11dtSif3I7DWmNF74atbnSwX9qnXzu9
         ZBYvEa1mScdWLxqB+Pex4zhil7bvpq4sVTBEMcoFXfXIIloCsILk/nT4Z7DYJWhjOdQr
         0EXxWb+QM/MmzWhwo5UUWDWGkJLSlMuj6JUy3oR5tSShOJr6/FTDbpBAjDnGZFCcV3nW
         MvSZeArKFmUeTSj1mVtXDH3XdhC7mpCtSjiGnInDSMqh3zucj3jD+o3mf+6htxDBPiHd
         az+Q==
X-Gm-Message-State: AOAM533Kkop30IJwoUJeZSq00aZI2aMCy49tmxkceJoFY9zez1YoFfki
        +sGS9snV5txKQBsNOhzM1qM=
X-Google-Smtp-Source: ABdhPJxGwpVJUg/IBsClwuAhM/ZocSpzqUGdaIf6YXRVA0lKutVIqPnTrs2UFqCtK4jXlhEy3SHGjw==
X-Received: by 2002:a17:906:9b8d:: with SMTP id dd13mr58941725ejc.531.1636101157251;
        Fri, 05 Nov 2021 01:32:37 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k23sm4105669edv.22.2021.11.05.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 01:32:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miueJ-000Gek-GE;
        Fri, 05 Nov 2021 09:32:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vipul Kumar <kumar+git@onenetbeyond.org>
Cc:     git@vger.kernel.org
Subject: Re: List all commits of a specified file in oldest to newest order
Date:   Fri, 05 Nov 2021 09:13:54 +0100
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
Message-ID: <211105.86a6ijhujg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 05 2021, Vipul Kumar wrote:

> I want to list all commits (including renames) of a specified file in
> oldest to newest order. But when I run "git log --follow --reverse -- 
> <path/to/the/file>" command, I'm getting a single commit, which points
> to the "rename of the file". This behavior is weird to me because I 
> expected to get list of all commit in oldest to newest order, whereas
> "git log --follow -- <path/to/the/file>" command works as expected.

This is a known caveat of how the history traversal works, but from a
quick glance I couldn't see any explicit documentation for it, aside
from this terse mention in git-log(1):

     "[-M can be used] for following files across renames while
     traversing history, see --follow.".

The key thing being the "traversal", i.e. as we walk history we'll
encounter a tree entry where b.txt was deleted, and see that it was
moved from a.txt.

However, if we walk history from the beginning we have no idea of the
relationship of a->b.txt, since we didn't encounter that commit yet,
that's only something we see while walking the history.

Perhaps we should have some option like --buffer-then-reverse, which
wouldn't change the walking order, but would only change the output, but
we don't.

This caveat doesn't only apply to reverse, try to apply a move of b.txt
on top of your history:

    b.txt -> c.txt

And now do:

    git log [--follow] -- b.txt

What should we output there? If we're arguing that we should first
traverse the history to "look forward" that'll also apply to a
non-reverse walk, since we're asking to follow b.txt.

But we haven't encountered the b->c.txt relationship yet (well, we run
into the rename commit, but once you add a c->d.txt on top...). So maybe
instead of --buffer-then-reverse we'd need a hypothetical --two-pass,
which would also impact options other than --reverse whose behavior
relies on traversal order.

Take all the above as an explanation for how it works now, not some
defense of this being user-friendly. I've also often been annoyed at
this behavior.

For small sets you can feed your into an alias like:

    git show $(git -P log --pretty=format:"%h" --pretty=tformat:%H --follow -- b.txt | tac)

As a poor man's --buffer-then-reverse.
