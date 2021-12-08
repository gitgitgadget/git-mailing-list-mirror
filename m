Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76538C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhLHMyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhLHMyy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:54:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B93C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:51:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r25so7985522edq.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5dxXYK1jqdPAz6ggl/aI0MQuuVd4zhmX6EypEmrfH9A=;
        b=ntV76uerX/iibGNCIx4/L+dGrxu6FkrCQDCQ6m/QhCWR3gbLssKnKFftSe4R8c4Gy/
         AqehwccR5ImwXlaoXz61CEDig0Hgp9ie0kHQXaFmVlMaaqUjhe5a1bVq6sUy2bgPE6PJ
         Hk/lgy/YRM+0vtqLMIXFyhDea3VaPw5N76t3lmwiWUUEN7FC6OHuanWbcZQUFI9Ej/4Q
         G/MAXJVkHJjfftpXPnzgHss8J624GRhSyoA/iJDV2cc/JIe3hDSunpoSW7DuuCx9OV75
         xEC8DoDoxm41o67tA6sESskKuyHMaPc94vUIN+aSObotnamqkWlK3TD25yGQmXwmzYQ0
         fWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5dxXYK1jqdPAz6ggl/aI0MQuuVd4zhmX6EypEmrfH9A=;
        b=Y8QW7luasGMeoP2+kWPtofGLeoWO7PCEXAoNfvAwBW1UI50Ekk+We5uX2g0gF9l044
         wAZ3xDbKBO5B5QLQvNUVEgqYhtpeUA80VuHNmjdPIBTPt4Pg4ttkexzAbzcfnANrTp5O
         7t4qrdJ0ujZ3QDuPO+fFICFYPljFEG3JDJXCDD7u2cTwT/KHVVaai+q9oaRjhnVVwYWs
         nr1p21IBIUQuDWpxmsazY3ztF5pa0AJgY6mWMVYNziPGMGd53eUnw6fOoR8aV4W3VeBp
         xVH0QOUpWCGiKx/djJLLY/VI3FO7sgfxP+AYd9jSN7S2wi1CDACfVFX3xpQDQloALjXL
         UgHA==
X-Gm-Message-State: AOAM532QWmHthYy+rdev1+PC4+Ir4+AVGObGBB19cyPM8t7KSAO1HKS7
        z6GxGBjZrPzXBHIpTtJeK+g=
X-Google-Smtp-Source: ABdhPJxzE0B+PZnc3lLkXbsgL18SrifkfEzoS5IyqfXEkIKO8XATUGMGfK+h0MosR3tGcU7DN8afug==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr7326957ejc.219.1638967879319;
        Wed, 08 Dec 2021 04:51:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j17sm2056463edj.0.2021.12.08.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:51:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muwPm-001QKf-CL;
        Wed, 08 Dec 2021 13:51:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: errno oversight
Date:   Wed, 08 Dec 2021 13:47:51 +0100
References: <CAFQ2z_NHXKss4LVBAFVpE7LFXt2OeOz9P9wi-z8riwHXWDb28w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAFQ2z_NHXKss4LVBAFVpE7LFXt2OeOz9P9wi-z8riwHXWDb28w@mail.gmail.com>
Message-ID: <211208.86sfv3l0op.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, Han-Wen Nienhuys wrote:

> In refs.c in origin/next and origin/seen, we have the following fragment:

It's in "master".

>                    if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
>                                       &read_flags, failure_errno)) {
>                         *flags |= read_flags;
>                         if (errno)
>                                 *failure_errno = errno;
>
> overwriting failure_errno looks like an oversight?

This is from my ef18119dec8 (refs API: add a version of
refs_resolve_ref_unsafe() with "errno", 2021-10-16).

I don't see the bug here, overwriting *failure_errno is the point of
that variable. We're keeping the right errno value right after a
failure, and passing it up to our caller.
