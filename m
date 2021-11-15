Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F34C433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D284F61BE1
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349553AbhKOXrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351239AbhKOXmg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:42:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF128C0432EB
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:42:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so22185040eda.12
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jUYmgP+hLKdTmnsDO/koSfKrsOZyXlmv3OS7S5Ee/w4=;
        b=PC5V+RIKyMoVkJoC3DdiAdJcTPiwnU8XxJDp9SpuT3PH6pwJrx07GtHhGaJS3lKLn4
         GeINpvCB2wrA3AC+RHeymIB5iQyH6qkkYHqazrfGsQaqH5AEBFUSNxP0mRiIceYDOfHc
         jCR4Sm9BfcEG4P4rTPka9NiiGIe7eEB1q2di0gHmFd8Z2OeY+cPjVuvzh2ZYhubMWAbE
         T8VnIvpzJLBOD3LumbrT9rhp+hnDgasj0S98Np3QgUKRBqOzfU5rxV5lreif9K0eMT9M
         /D9UjRlQNpVL7EyE8DMUOTcb+on3lQ9eglIpilPGRSel7UvPgBI1i0fZCFiVo2KTIj4M
         eNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jUYmgP+hLKdTmnsDO/koSfKrsOZyXlmv3OS7S5Ee/w4=;
        b=uQqqIphp84RzQCXkmHPcqnp7Vq51mfx7hJPlG60thmIbYfXxWlhBhfBTdTpnRFb8c/
         SMr1gUu8samQWpB3RrX0li59FyDYc1KO+KsqEmVuNslq9NeN1N8rUqQlt22SF1blICmO
         yX5WL4mYTtBzY7Ocvpbp4BMjl9dRGxddfuvET5sCgHmnkygWKlr2LotSnN7CzgJhVirY
         YE9DAEiLxGWR9+yk8C/cl9WnUfSbxR5alNb4kHxIoVItDqE+I9yeb8jx6VG2p6Plprk6
         +AxVGr2Urn8wZnatZllV+jvoxJAF6VMbzABXov1yUZqkMqStWcLoJRf4LfrraRRiazMk
         /qZA==
X-Gm-Message-State: AOAM530PCUxkdltayoxx2TcEjlzBnKWHVaF+ELjQ47VXh/CIQZvzPDaa
        XE0bklvGQeh3IY7/5CA/484=
X-Google-Smtp-Source: ABdhPJy1Pe7zgKXpjImNxDXODxPV4BYexmLoxl9dzQLyxkyzO97S52+3P3Te9S2EL3PEgTwzT4nnjA==
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr3330685edb.325.1637016155452;
        Mon, 15 Nov 2021 14:42:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nc30sm7521564ejc.35.2021.11.15.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:42:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmkgM-001GpK-HW;
        Mon, 15 Nov 2021 23:42:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Hamza Mahfooz <someguy@effective-light.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Date:   Mon, 15 Nov 2021 23:41:27 +0100
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <877dd9i1zj.fsf@igel.home>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <877dd9i1zj.fsf@igel.home>
Message-ID: <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Andreas Schwab wrote:

> This breaks 'PCRE v2: grep ASCII from invalid UTF-8 data'.

What PCREv2 version are you using? I wonder if it's got to do with the
10.36 boundary, as noted in 95ca1f987ed (grep/pcre2: better support
invalid UTF-8 haystacks, 2021-01-24). One of the two tests matching your
description tests for that bug.

I can't remember much of the details of the bug, and it seems PCREv2's
bug tracker went private, or at least I can't view
https://bugs.exim.org/show_bug.cgi?id=2642 anymore.
