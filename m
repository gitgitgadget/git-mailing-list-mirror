Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22BDC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 01:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F27360D42
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 01:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhJKBwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 21:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhJKBwU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 21:52:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E1C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 18:50:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d9so37384209edh.5
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 18:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qnqiby3wft0ls5Io19dHQ3DwpQsZ5FiqtOpPtta+SVk=;
        b=okIlnWCP4qy1ii+jIj4igkRVyFkECghseS5WSjoB00PpGRjzZew1go7u84eWmdh5Ip
         hz4VQVOa6xKXJdGMYhvNMslZh7vljU2xZ4bdD2y6EEOOzfXfqJ6IcNh37waGjJR6coVe
         7dJ21uzkXe6lCsRWDAcF5Rkqaic97ekTf0bocapcK4LcDC0+7TN6TBBSnxk8nCHr0Zg6
         /tSnLX9uT1/2mKydUSnIzRujgwDO/xFwYCw5I6qHRLQlJO/7vT5J0hjebFf11oD0SnZU
         OAX0ZHy36LA1NFzeMPnJ3YTzlDbwXzHxH09M3Vq7BDIIJKk3hNsCHemkpbyaKBWVIYL1
         Q0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qnqiby3wft0ls5Io19dHQ3DwpQsZ5FiqtOpPtta+SVk=;
        b=QWZWccEFLku42iPpekXoMaHLyw7qLfRngcAP+YmAR5zRyGuC7jbWWI3AfQjayyMWRL
         QA2oK8i6kcNCetAG8arxBNxT0vR0lVGSFvj7M7rfOteMBGrWF2UWuY4iyP50a2ba258p
         yCjA70LNXsieWdMG/6wmokBI3Yq4P44zAL/tFUSgpRYmyBK0o/aM7f865silWosNl9zD
         Bn1dAFttVFN0BgeNsoO7X5ShpSGEu4SLLrZ3IfY09n+YYHhf+wzvJZmtkbQGrAdfprOf
         iUisaSZNK0HtPqgyiIQSqcktWq5y1F28UUB/25NWisGNzLRFA1IulVOMaHe2Jzt6uP0O
         Tn7g==
X-Gm-Message-State: AOAM531QtUKURfc14DqQkOBEz8J1FjqjQWk90KIeU0m/7Vluzc0zvNFi
        T+KCNw8KV+FMbhA/lzxFm6U=
X-Google-Smtp-Source: ABdhPJyA0sSCHoYt82Y/KHH/2dS7S40D3snwHBjhampT2eqBv+xv0+NzvL9NX/c9wmuQAxcSt1BlTg==
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr21187160ejj.157.1633917019307;
        Sun, 10 Oct 2021 18:50:19 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g2sm3320099edq.81.2021.10.10.18.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 18:50:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when
 emitting errors
Date:   Mon, 11 Oct 2021 03:49:39 +0200
References: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
 <20211010214209.GE571180@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211010214209.GE571180@szeder.dev>
Message-ID: <87o87wl485.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 10 2021, SZEDER G=C3=A1bor wrote:

> On Fri, Sep 24, 2021 at 12:08:20PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Change the error shown when a http.pinnedPubKey doesn't match to point
>> the http.pinnedPubKey variable=20
>
> I'm not sure what this means.  Between the repeated
> 'http.pinnedPubKey' config variable name and the "doesn't match to
> point the ..." part I can't decipher it.

It should be "point to the" (but this grammar error is already in
"next").
