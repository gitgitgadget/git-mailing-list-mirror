Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A57C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8089861242
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhGLVTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhGLVTo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 17:19:44 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D09C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 14:16:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20402416otl.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MrU7IGKboKKt2qPsViIheFjoY5U0rqNcUowEaKQXE4U=;
        b=GZZMqOALG+cvwOJ50tAvo6aUd+e9GamWTlCzbKYpT5XE1JTkjYz03VMA2FPYIGDIu3
         j62n5D0zT7Y5DT/T5PO/m2Q5M6h1+Xi81acYWRB2doG/6zEnVA+sQojrrdsOP0EpfLlr
         YHhdAVa4T/8mSUlDgZ9TOPTNQawsOm9Y5NgVEHO/k1jRtrZaZaRfiQ3mMqeEOlwn/Qrm
         6XjYRFwQ+MLFz2IFKAwLAiZaAufTpS+b5OXrZZwwh7G8OdtCCwQ+o5mXt7+xIsIFznum
         3kV0Ni1SwMWpV8EapEhlu+ZOwCDiRPAOVl1FtAGQixQyVeBUW6+cJkb8bjcEcYve6xl4
         ojow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MrU7IGKboKKt2qPsViIheFjoY5U0rqNcUowEaKQXE4U=;
        b=c19N3/L90uAnXLpRJIKwWNE8U9+zJDf72FKBU/X9hHAdPBKB6ir/x5qmH4zJU3Fb6M
         N55bjUYJGnMHeAsLz86icfGOsEqnlAe4IxyW5Htd1fu6NdtMCcBL1rSjqbYlm16Dd1AY
         WIDlS97h+KKr7nMAvIGbKUwnY6NIU2nDnhq4A4mybh2AERXrfAIpVeNciLuyl9pZB2tm
         HSnQri5lrIFeKRs9b9hE4qXR9dVrzvQ7xbxcvW3XVmoXmoqNpehRt7sx0dzgA9h9TTmA
         l7gzDL/UZs5GM+EmMPTSVN0+/qcX0zAakezw6lYiii2YsYWowAZPS9Urg6LwE7DPMVa4
         Ux3Q==
X-Gm-Message-State: AOAM530ZJhzdbKgjV52+LJISvjteVWUcdjU+qfSV8C7zYZbaYoOjjx9+
        JaHJLmZ78FTRBCYEGEh2X5Q=
X-Google-Smtp-Source: ABdhPJz5gMf+4JmWEdNFCT1wrGEZmcGA/M0u4cEgBxU0TYT+Bq9W6SCpqhv62Ce2P3kc87I19FIzOg==
X-Received: by 2002:a05:6830:54a:: with SMTP id l10mr786920otb.194.1626124614808;
        Mon, 12 Jul 2021 14:16:54 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id d10sm2622038oth.60.2021.07.12.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 14:16:54 -0700 (PDT)
Date:   Mon, 12 Jul 2021 16:16:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Message-ID: <60ecb144df896_a68ed20864@natae.notmuch>
In-Reply-To: <ddba5667-346d-de64-ac6a-a27d78bc266d@gigacodes.de>
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
 <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <87y2ab30yr.fsf@evledraar.gmail.com>
 <ddba5667-346d-de64-ac6a-a27d78bc266d@gigacodes.de>
Subject: Re: [PATCH v2] Add commit, tag & push signing/verification via SSH
 keys using ssh-keygen
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer wrote:
> On 12.07.21 18:55, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> > I think this patch is *way* past the point of benefitting from being
> > split into a patch series. It grew from ~200 lines added to ~1k.
> Sure, I can easily split the patch into seperate commits. But do i =

> create a v3 patch from this or issue a new pull request?
> The diff between v2 & v3 would be quite useless otherwise wouldn't it?

The interdiff might be quite useless, but not the rangediff. Either way
both of those are merely tools to visualize changes between versions,
ultimately what really matters is the final commits themselves.

Moreover, not all reviewers have seen every version, so for example if
you properly split this patch, I might join the review process at v3,
and I don't really care what was in v2, therefore I wouldn't look at the
rangediff.

> And maybe another beginner contribution question:
> =

> When i make changes to a patchset do i put new changes from the review =

> on top as new commits or do i edit the existing commits?

Edit existing commits.

> If so what is the workflow you normally use for this? fixup commits? I =

> know about those but haven't worked with them before.

`git rebase --interactive` is what I use, and I think that's what most
people use.

This allows you to easily edit commits and add specific changes to
specific commits.

Once you are familiar with this process it's easier to understand fixup
commits, but I'd say rebasing comes first.

Cheers.

-- =

Felipe Contreras=
