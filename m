Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A9C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiGHVx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiGHVx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 17:53:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0576D215
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 14:53:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz17so123171ejc.9
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qPpRqYk0mJOX9O1JqjAym1XPxBGAH3Nabpw07fd9AhI=;
        b=Yr1p7MN9m3XSr77vA4A0bBoNz9CPCJ3d5VCKnQ1c5Q//X1FjIYIXiQlbVAGl5DUAWD
         tUsfbRNnfBN08RDnTmW8Rh04EtR2s7EH40wMJ+ndg7bJVJhvdQ9j8VOyHaA1py1wpOHf
         xqid8tVGMX+EagOhI1Hn9I70PBPQqckL0ZTxSn8RKNPKLqQVIXOY1fMecdO2v66AP6GZ
         9NHcIV+ann/ZcgbAFs7VbXjW1jkAW46hfj+84NapN0jp4gXeiITTIOtT72k/mIa/PMoI
         YbGDiaqylBFSAgqvHBLi/0raWKgjzFRqe+5zNueCao9jGp6IySz++HFir8kLhE/1SqJr
         uC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qPpRqYk0mJOX9O1JqjAym1XPxBGAH3Nabpw07fd9AhI=;
        b=BfNvLTsRxqIIksU47ioNbwFIgXmPBqA2fsicEV9A+6fbPTxveMNdr03qIPYDkU1R/T
         Rs8STiUDV9lRK2I4EtkH4JDQakISgsFdp7KQr4Ojf8NbD1RPCfTj4mioDQO8MskevRh6
         r+iKiq5stLplJ0pEGgwSHJCEpFq5oIMWiTvzZmKY7mcGqWUO9RLtvCQ3XAyaNZLfmfae
         +v5zlO1WSzq4TZsgcv63vmCz+xoFqPGvMyIkDiKGSVlS1yAkLL9x5G+4abG1wQcYlVrD
         NiJkJadZmO1DNmZVlhjfs4EzaM7kFouCG9egWWL667GemhwI1mcV6oor0SWmY8GUPiUB
         LGGg==
X-Gm-Message-State: AJIora+7X42nYpS8zTTR4ndfdrossizGwLYUCdYgCleU7HWy9h9EafEO
        Dc3w1a1Sp7Nprt7qW1enQAs=
X-Google-Smtp-Source: AGRyM1tGDExoa5scvWM2GCB+/lZjAKhfgRgYlfqayp5OGWOYroAIMWjIYcCSgHoA5oj1nD/2MyWQEg==
X-Received: by 2002:a17:907:16a6:b0:726:574d:d31f with SMTP id hc38-20020a17090716a600b00726574dd31fmr5453872ejc.514.1657317205567;
        Fri, 08 Jul 2022 14:53:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0072ae8fb13e6sm3484946ejf.126.2022.07.08.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:53:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9vud-0002jE-Vb;
        Fri, 08 Jul 2022 23:53:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: remove xdl_malloc() wrapper, use malloc(),
 not xmalloc()
Date:   Fri, 08 Jul 2022 23:47:58 +0200
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
 <YsiHGliw2dYmGcDY@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YsiHGliw2dYmGcDY@coredump.intra.peff.net>
Message-ID: <220708.864jzr9sq4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 08 2022, Jeff King wrote:

> On Fri, Jul 08, 2022 at 04:20:18PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> As noted in 36c83197249 (xdiff: use xmalloc/xrealloc, 2019-04-11) the
>> reason we have xdl_malloc() in the first place was to make the xdiff
>> code safer, it was not handling some allocation failures correctly at
>> the time.
>>=20
>> But as noted in that commit doing this was intended as a stopgap, as
>> various code in xdiff/* did not correctly handle allocation failures,
>> and would have segfaulted if malloc() returned NULL.
>>=20
>> But since then and after preceding commits we can be confident that
>> malloc() failures are handled correctly. All of these users of
>> xdl_malloc() are checking their return values, and we're returning
>> -1 (or similar ) to the top-level in case of failures.
>
> This is also losing the other parts mentioned in 36c83197249:
> respecting GIT_ALLOC_LIMIT and any memory reclamation strategies.
>
> I think you'd want an xmalloc_gently() instead of a raw malloc().

...

> For the same reason, I suspect it's better to leave this with a layer of
> preprocessor indirection. Even if we chose to use malloc() here, libgit2
> might not, and having the macro makes it easier to share the code.

I think
https://lore.kernel.org/git/220708.86czef9t6y.gmgdl@evledraar.gmail.com/
in the related side-thread shows a workable way to do that.

But I didn't think about the GIT_ALLOC_LIMIT, so if we want that still
we'd need to have this code routed to not just malloc() but an
"xmalloc_gently()" as you suggest.

But we also have a few other uses of malloc() in the codebase. I wonder
if the right thing here isn't to just use malloc(), but to have
git-compat-util.h override malloc() (similar to how we we override
e.g. exit() now...), which would also catch those.

Or we could just say that it's not worth the complexity, and xdiff won't
respect GIT_ALLOC_LIMIT .. :(
