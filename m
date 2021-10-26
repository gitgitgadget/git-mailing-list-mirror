Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A357C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 11:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB33B60232
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhJZLXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbhJZLXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 07:23:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97103C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 04:20:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g205-20020a1c20d6000000b0032cc6bbd505so2141562wmg.5
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3r6NWPaGKNNdzs5QI5FE+l8dnY2lN5QIexGjoK8RTdw=;
        b=DAXHRP7D+aJHqgOdQm18QCgvd8Ex4voSlsD4QwabXWE2kEl4qFj+ZViZ/BUA+ukdYH
         4ydLqzKwVVvPUStx1LT5M4f2TweuGirkc5o3JXhkwSi5QoWzZR0PHdvJ1J3LJNzPfonq
         GCXrOvcGqqPgnGsd04lwK2KL9arD6EU4jlg9uugo/rb8SR2UcYwxXyBHNFhClcL5NQh8
         ejU8GJXX5mTdhGTl8oJCWyYAUooLBXbsLe8a9Zdtd14LEPan04+GSyeGudga6eL8MkeI
         UcAsfX4+Edrs3DYDN7bI4uPSURNZ4Iec6w/eicF2AE1k9vZVg9LGXn6RWyGaofNE5TzW
         7DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3r6NWPaGKNNdzs5QI5FE+l8dnY2lN5QIexGjoK8RTdw=;
        b=kr7otlrSFnmmrDBlakM2CnwOiIS2S+RSRtK/1Wxj7J9v2MW/iXkq0URFIOFfjHxLuA
         m+cEfenYL+As+bJnSSpXWE3qgn7G7JLEUS6UJgbGKMtf62KZa0XlRrrNvqelgTIQKAlf
         I75kqbNuNUty0lTwnzTpvan/3o7Aw8BYC7Txag4SKqtBfiEMOBPnVI7DQZ32pNK7SRdf
         k8qAQlz7YIv1HhiTD/u1CCS+f0k4xOosK1WDtvSeCACJbQ9qF6K6DI2/hd7UWUOZTiEw
         DbbS8mvp9Vjjdn7MjjdJcFV5erJrhP5EUId6+gp020+YgDKqFNXyt63dNy2eQY4Mqtkj
         hiBQ==
X-Gm-Message-State: AOAM530M6jUitkCDbmo+twyXeiSqL8n2dxmKxTvtwk+4IOzfYSmYpUWz
        /gt0fpKgMYOmWZIib/0nVsc=
X-Google-Smtp-Source: ABdhPJy5Zjpa5AaDGU87kaIJN8DLRlaV0C86TE6r9Cmxcb2Dda/OUsV1VTmTVKsoHS7MkjvYqPlfGg==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr25875403wmq.54.1635247253969;
        Tue, 26 Oct 2021 04:20:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v185sm306839wme.35.2021.10.26.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:20:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfKVh-001mA7-3a;
        Tue, 26 Oct 2021 13:20:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: pre-v2.34.0-rc0 regressions: 'git log' has a noisy iconv() warning
 (was: What's cooking in git.git (Oct 2021, #06; Mon, 25))
Date:   Tue, 26 Oct 2021 13:15:00 +0200
References: <xmqq5ytkzbt7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq5ytkzbt7.fsf@gitster.g>
Message-ID: <211026.86y26gyqui.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Junio C Hamano wrote:

> The fifteenth batch of topics are in 'master'.  I expect that this
> is more-or-less what we can expect in the -rc0, unless there is a
> hotfix to what's already merged.

I suggested a way forward for these iconv warnings that will be new in
2.34.0 at [1], poked'd a few days ago at [2].

Jeff: What do you think? Per [1] I think it's best to drop it entirely
for now, or split out just the "completely unknown encoding" problem
from "can't decode this particular thing".

You also had a patch in [3] that wasn't picked up, which would warn
about this once.

If we *are* going to warn that seems like the worst of both in some
sense, i.e. we'll no longer give users anything like "in this huge
commit stream, we couldn't search in commit XYZ", instead we just warn
on whatever happens to be the first commit, and you'll have no idea if
subsequent matches were completed or not.

1. https://lore.kernel.org/git/871r4umfnm.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/211023.86sfwsis1i.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/YWEBmJk0aENR5Yeo@coredump.intra.peff.net/
