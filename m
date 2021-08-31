Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC848C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B906660FF2
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhHaOWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHaOWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:22:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC2BC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:21:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so27995247wrr.9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Bj5sLiqeHirfJMB/j37chlQ8AkprSanTS3cQRgjoCz4=;
        b=liW2DW6ouV9C+xbXR0e/xk8BMyVOmGTXl+ntgSes5EH5HpQFfqfcM2uVVcNe1/cuhw
         DX1LrSqbyOkuSCl14HJZrFiYm0vtQjEPBh8yEcm7LnKnO+jzqrWYrDVuVvjKeF+JZW/e
         2Q3KuZ9aRvwsNaE6waxR8smXivVWnrD3CSyAnNS4ssPXoxVURksPYzqJ6VBhfOQgEd0Z
         cfLPn45gr0tE4y3L3R/j3qSOyG42O8OiNBb4/bCFQSH23TKIT0HhEinM7e1nEvHCf/4q
         qJZGc5e2p8Jr42y1EB0owkFywsJsoAeuIj8pu1Imm+hC6j3fGF+o1BWy1wtrrnfa0keI
         dslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Bj5sLiqeHirfJMB/j37chlQ8AkprSanTS3cQRgjoCz4=;
        b=K3dTuDHISM1GfB2InR/TeOXm1RiYtjfciUUk6/QNQkHVHNN6SOvbC2hcO8mPy9pWQM
         3xgqjPWf8qok8ADWzDx0aqfBKi6x7eKyYL0IE+3rrUpd/mtf2HXrOteM9x9SDTWED+hL
         M9C4cg+69nDLULuIG4W+2+fgVKgRWIdKopRn2ygHiWC+fvsuROlQlFlfC3XvKFNpC2t2
         48+BZPHidVSXxW7wOFKQNdqbcq/y03QQ+kjxKIQd4qgUvzV78Nz9wzwGxNOAzyH0Jb90
         9im1Zzinx+ly8i2p6cakKuLI7e4Py/XCR1tAthoYVFyeDRjaplc7A3wCXObf8f7PmYFZ
         BRAg==
X-Gm-Message-State: AOAM531fk62rgDXaoXGoVhnV6EZwzkxCh5IGbRibiMMa3Knc4hk6rEU1
        E7qjQLORdIeiPO9Q9owprOs3DmU9C8zGYA==
X-Google-Smtp-Source: ABdhPJw6iHKbZ/AC+OZMxweVGvxhczH3pmcuj+9cjLlANCGx7Spjio3tzqILgwEwwI8eZjj+NoowTw==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr32473680wrz.343.1630419710777;
        Tue, 31 Aug 2021 07:21:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y1sm2720267wmq.43.2021.08.31.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:21:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stef Bon <stefbon@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
Date:   Tue, 31 Aug 2021 16:01:58 +0200
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
        <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
        <CANXojczR1hMrzz7t0P6AkqL3kjdk+NzBKyCQnm-9cWFbULifow@mail.gmail.com>
        <YS3VLh8SFvpDZy84@coredump.intra.peff.net>
        <CANXojcxF8V2RR=xMLrwcpwa=R8fvhsn2Wj=pnthXNnvxX7YLxQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CANXojcxF8V2RR=xMLrwcpwa=R8fvhsn2Wj=pnthXNnvxX7YLxQ@mail.gmail.com>
Message-ID: <87v93lwv7m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Stef Bon wrote:

> Op di 31 aug. 2021 om 09:07 schreef Jeff King <peff@peff.net>:
>>
>> On Tue, Aug 31, 2021 at 08:38:39AM +0200, Stef Bon wrote:
>>
>
>> You might also set GIT_TRACE_PACKET=1 in your environment and try
>> running some Git commands. They will show you what's being said on the
>> wire, up until the packfile is sent (decoding the packfile itself is a
>> whole other story).
>>
>
> Yes that will give me the insight I need.
> I will come back when it comes to decoding the packfile.

Aside from the "here's how you can do it", you haven't said why you'd
like to do such "online" browsing of the repository.

I'd think that even for something that e.g. implements a file browser
with magic git-remote support (think GNOME VFS-like), what you'd want to
do in the background would be to do a "clone", although a clone with
some combination of --single-branch, --no-tags, and perhaps --depth and
the filters discussed upthread.

It will take the same time to get the pack, but once you do you can use
libgit2, git's plumbing etc. to do really fast browsing/wildcarding
etc. of the entries locally.

So is there a real performance or other use-case for wanting to do this,
or does it just come down a lack of nice a "one-shot" API for "list
remote files?".

In any case, on the topic of clever things you can (ab)use to do this,
some remotes support running "git archive" for you. Notably GitHub
doesn't, but GitLab does. Please don't take this as an endorsement to
run this command "in production"

    $ time (git archive --format=tar  --remote=git@gitlab.com:git-vcs/git.git --prefix=t/t4018/ HEAD:t/t4018 | tar -tf- | head -n 3)
    t/t4018/
    t/t4018/README
    t/t4018/bash-arithmetic-function

    real    0m1.545s

I idly wonder if there's a want/need for a file listing API whether
doing so via the tar/zip format wouldn't be a more viable & widely
supported thing than expecting everyone to come up with their own git
packfile decoders. I.e. if we just supported some option to create
all-empty dummy files via "git archive" this could be even better as a
dummy file listing API. Right now this (ab)use of it requires
e.g. sending ~10MB of t/'s content just to list everything in the t/
directory.

