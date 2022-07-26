Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1569C04A68
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 13:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiGZN5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiGZN4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 09:56:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FDF2BB20
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:56:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id oy13so26321199ejb.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6VMoSC6q8/DG0pL90AD8rcfqI88oNIHgPN26HjB+0KE=;
        b=J3bGId/JsR6bk4mq6VkwEfI4tyZH84FdGGLgwZ484EHQVKSTtFHjrIgbQNPlZ1NBwD
         FU9E6i3wKuf3KWpiCPumDxLQL9BuOLC3eyMrpo3DGRuqZjxsICai6Zv1zrJB8gJLwoub
         aXQk+q93njBmXzOKx1pdwSoEMtDZSqJ7XUXqeEjO5ZOR9M0UB/7NAwAQzXqodISej1hR
         upq8hwtJZeaCzi8whUvp5qWbjTZJDTd3HkJY6vX47fAe4A+heBOd2kOau2Bnk02ETi0E
         j02xqobO8bztFXmHj1TjhLrCbylkAgNqGua/BXHtcxarEczgdrjehtGMtp0RB/2qTV1G
         Q5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6VMoSC6q8/DG0pL90AD8rcfqI88oNIHgPN26HjB+0KE=;
        b=6o0e3KET7mMOfR9zIt69a+Jsl1ESV4qL/pDq93vOtZG4LgbIth2qCmQO3YlbnWki9y
         iZ2MblBZMQUymxJP632SHYRGme9JFY3Ytt1/zJ5QttkN9ou3k/4XV4PHM66Z32CsxH9g
         YRGcLRblIsyDnBUVEZo81LBwf5FFNjvMdnIHtc1jnzeJwTXUj6twg6qkvwLWHZUcAUMo
         0+ivTl/DJUT8nDzjzTMoVKqd02jdrKyVVJSxVH4H1VEEe0W43cX/cndVlayVfkOozOhA
         xdUzlByHpZmnVPdMS5PRKQyourZjeDzqaJLJtPJDUmLCMw3NzqmRThfXl70cpJo7iEtI
         7jrQ==
X-Gm-Message-State: AJIora9PGyRymfjSjPWDHdPLHSMTGJKDR8GI1onH7Uf984nYSz4wCfzU
        s5EV4byfxCtlUVxwXhWseXkys/3fKwxSaw==
X-Google-Smtp-Source: AGRyM1thSk8ykNQg4JEBe0abuUNW1ymxbkTjNwU0ZsbdkgbpsZrzPlubCVxAp3syv2hL3GgIlfmWCg==
X-Received: by 2002:a17:907:c0d:b0:72b:d0b0:2b55 with SMTP id ga13-20020a1709070c0d00b0072bd0b02b55mr14440064ejc.110.1658843788555;
        Tue, 26 Jul 2022 06:56:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e16-20020a1709061e9000b0072b4da1ed9asm6420258ejj.225.2022.07.26.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:56:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGL2w-0068dN-Iq;
        Tue, 26 Jul 2022 15:56:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v5 5/6] p5310-pack-bitmaps.sh: enable
 `pack.writeReverseIndex`
Date:   Tue, 26 Jul 2022 15:54:04 +0200
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <e7ef420f321b3936185b2729460b1c28f5384438.1658342304.git.gitgitgadget@gmail.com>
 <Yt9A4Lh5MzHigeVe@nand.local>
 <220726.86bktcny14.gmgdl@evledraar.gmail.com>
 <733f2432-00ab-f0c2-269f-90af02b2105c@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <733f2432-00ab-f0c2-269f-90af02b2105c@github.com>
Message-ID: <220726.8635eonfjp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Derrick Stolee wrote:

> On 7/26/2022 3:15 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Rather than comparing HEAD to your current tree it's generally better
>> to do something like:
>>=20
>> 	GIT_PERF_MAKE_OPTS=3D'-j3' ./run HEAD~ HEAD [...]
>
> Using the 'run' script fixes the perf test in the worktree and tests
> different versions of the 'git' executable.
>
> That doesn't work when the change is in the performance test itself.

Thanks, I'm clearly wrong about that. I didn't look enough at the
context.

But then we're losing the perf test coverage for the case where we don't
have the *.rev files. Isn't it better to run both with & without *.rev,
perhaps by splitting up the test file? We could make it a function in
perf/lib-bitmap.sh that we call both with & without the wanted *.rev
repack config.

I suspect that's also subtly broken, in that t/perf assumes that it can
re-use the repo for a given <rev>, but this is modifying that repo, so
if you run e.g. test Y after this Y, that Y will unexpectedly get a
repack'd repo ...

But we could just start the test with a git clone . "$TEST_NAME" or
whatever, then repack that with whatever options we want...

