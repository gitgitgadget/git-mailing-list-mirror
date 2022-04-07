Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E0C43217
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 14:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiDGOfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbiDGOfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:19 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C41AF520
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 07:33:19 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id r13so11273577ejd.5
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TawOFc8STCk+tK8hPCBTJerZ9tBv8PBpKVveYT2Ur8c=;
        b=peD5FtUrnRc6B0MAZw++xuua+xaAn/ZFmFmoUrvcN8PXdwfvA6ggssbMtZqAe8cDzo
         tf2hgmw4LhbSiHT6nt76o4WG8N+1w1xNXUsRX/EHd33fsyoi9ttyWkr6nExwOunviI9a
         s/Ee27cJU1JaEa7O6aNCek3fYSmVQc8Bo07qasxeHBZVmumB7DU7X/xyAQ+N2DjHPsGc
         UwNMFMouwmmqGXeiOodt/G1jYx8THgqyS7QRzdNOKrnL2Tutne6n/HadypcO45xPW9vI
         eOZiOaSlZxr5WxUDI3vK+Lz5noUT0LWjiTs3PkeeLZKLABdlUy/kVIKDj5v81hTKLBpi
         CE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TawOFc8STCk+tK8hPCBTJerZ9tBv8PBpKVveYT2Ur8c=;
        b=ez0BiYKEUR95usFhFac3z9iLaa9b3L3oij2QmKiYU4MAISzJJpcdxLS3hdXg83oxTj
         aoShV7oz9wurWzujSbHcSPNEOoIZa08aZp5pbq+FCvO2+nTEHiJgeiQcwy7Y4EyCo9WI
         IhgyJoy04boeu3ZhbXNboCiV62vf8CfNzvxZdQo4UnfzGFGL+0uVIxsPSpsVTSLoJTA0
         X1rDMN4AEb1ch4qM/B4XGy3NpORl7szcwZAIJ88xuLOqB/YLWKlF6DdUeeb22OS2AO2z
         aEZycI0o/XGr+x8GHc0VGtU4VN989kjM4+UMjgEUUHxO3iJ+LdX7krcD9EnZwfrcRTgO
         mKAg==
X-Gm-Message-State: AOAM533TCsS4ORJKK3GtizuFY7hFTPX7Sgg2PZUtQDqyZ1KBGAmqQJV8
        PcZ4U7v/2DgWkHKjrqK1+wnM19bK9WU=
X-Google-Smtp-Source: ABdhPJzuoOwPr8ruW2wrca9gwzGC2nGYVFYrn1EUczoBb11PStx5+Bx3lI/faCvHb+IfKFdXqD32LA==
X-Received: by 2002:a17:907:1687:b0:6df:877e:c81d with SMTP id hc7-20020a170907168700b006df877ec81dmr13235431ejc.306.1649341937398;
        Thu, 07 Apr 2022 07:32:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b006da8fa9526esm7781553eje.178.2022.04.07.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncTBI-0011vY-8f;
        Thu, 07 Apr 2022 16:32:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
Date:   Thu, 07 Apr 2022 16:14:31 +0200
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220406232231.47714-1-chooglen@google.com>
 <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
 <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com>
Message-ID: <220407.86lewhc6bz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, Derrick Stolee wrote:

> A more complete protection here would be:
>
>  1. Warn when finding a bare repo as a tree (this patch).
>
>  2. Suppress warnings on trusted repos, scoped to a specific set of known
>     trees _or_ based on some set of known commits (in case the known trees
>     are too large).
>
>  3. Prevent writing a bare repo to the worktree, unless the user provided
>     an opt-in to that behavior.
>
> Since your patch is moving in the right direction here, I don't think
> steps (2) and (3) are required to move forward with your patch. However,
> it is a good opportunity to discuss the full repercussions of this issue.

Isn't a gentler solution here to:

 1. In setup.c, we detect a repo
 2. Walk up a directory
 3. Do we find a repo?
 4. Does that repo "contain" the first one?
    If yes: die on setup
    If no: it's OK

It also seems to me that there's pretty much perfect overlap between
this and the long-discussed topic of marking a submodule with config
v.s. detecting it on the fly.

Since we're already discussing breaking long-standing repos in the wild
here I think it's good to take a step back and think of a potential more
narrow solution.

There's nothing wrong with having tracked content per-se, it's just that
we ourselves have other code that'll shoot itself in the foot in certain
scenarios, like this one.

But for a newer git that needs to run this fsck check it'll already need
to detect that something "looks like a repo", but if it can do that and
setup.c can walk up from the parent directory & find a repository we can
combine the two.

Of course we'll probably still want an opt-in fsck check for hosting
providers who'll want to protect older clients, but as long as the two
are separated that'll only need to last as long as such clients are
potentially there in the wild.
