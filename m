Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE4C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 05:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B06D61370
	for <git@archiver.kernel.org>; Wed, 12 May 2021 05:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhELFXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 01:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhELFXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 01:23:53 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED30C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:22:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so6130207otc.6
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=CEPfb+aaC/XpGSJqefBxWR5e5uN4qhf8ml1EIHbUgi4=;
        b=HRuD/J04wFAHuqBhuTRxWAQ2kfHZWxAII3uwUHPogSjNyWr3yuaYbqHQlCH786AouA
         mbYOC7hCpAnWkka5Cbh18ek2ZT5fJHIy4Gk2afyfAvJ13OjX33rP0R92MSZ2JjH8YuEf
         zL43dKoET81Dvfwb0KGDWW3ElAeID6tI4OL7kn0u9wptGCdpRXiW9C+h24hSP7cNYat8
         DhtaVlNc3g/NA8tV6IH/93MwdLyQgJkB6LXRtzX/3JT/rQsfiDeBtoydJ86lDjN6iF99
         e0xs6HmfHIlbQtDkgwkp32MPMBTSugImMtWvTcgCxQkVxHdXt9tXUV9Ojw5gJvkh+qP3
         aF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=CEPfb+aaC/XpGSJqefBxWR5e5uN4qhf8ml1EIHbUgi4=;
        b=cstd3/tOh6Vw9rCMe+Bfb7L8d2LE0uqYMEJ4yGnFG+gulnGwXgLAesImDKJ/jSbNNY
         fCcBK3QeG06MVhtU+TzCIMj66gKpc+4wGOyDGce4La76IGQ08HY73zhUnlVDhhoUe2RK
         X8b4tc3ZPWtNA4M6FVOeYZS2ncFu1oozFeNz8M/35HAGXe8nvL0D0WHyesFSNAIeki2p
         yl5CzRaSNl5P1qjd3BiGqLnQRJj6cfby1GlhZjAtWjDD8MVdyPyj0J+fIjmwNLh8gTDy
         gP1jde+Siricp8Zrw6+IqPzld/c/873j0mF8Voo+TEguJE/4nT9uPUE5Yw5N0NMfoU5c
         BgRQ==
X-Gm-Message-State: AOAM532CV+Zuhs7rQvowxFWY8WEDvL9/9hpm45KWn1ZIEaGHa4YzYeyP
        6qJ0CUTjEyREPC5m/FhVS3o=
X-Google-Smtp-Source: ABdhPJxgLTR7XTs1XuagpUHVz7AXsWlM4cdwRT/HWRp/vXqUOfGzFxldKD6giqr2ZYw+B9w+s2OeBA==
X-Received: by 2002:a05:6830:214f:: with SMTP id r15mr28641077otd.204.1620796964793;
        Tue, 11 May 2021 22:22:44 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r2sm4285176otq.28.2021.05.11.22.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 22:22:44 -0700 (PDT)
Date:   Wed, 12 May 2021 00:22:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609b66203c81_6d7da208f8@natae.notmuch>
In-Reply-To: <20210512041138.GO12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <609ad9473d535_6011e2082@natae.notmuch>
 <20210511195723.GL12700@kitsune.suse.cz>
 <609b47043a719_678ff208e@natae.notmuch>
 <20210512041138.GO12700@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Tue, May 11, 2021 at 10:09:56PM -0500, Felipe Contreras wrote:
> > Do **you** have any frequency data that supports the negative claim t=
hat
> > the word "impact" is not obscure?
> =

> I don't need that data.

> You are proposing a change so it is your duty to support your claim
> that the change is worthwhile.

I am not the one proposing the change, but it has been established that
at least two people find the change worthwhile, and many dictionaries
find "affect" less problematic than "impact".

You (and others) don't find the change worthline, fair enough.

But you also can't find anything wrong with the proposed change.

So let me try to explain the situation programatically:

 1. ($a > $b) * 0
 2. ($a =3D $b) * 3
 3. ($a < $b) * 2

Which one should we stay with? $a or $b?

-- =

Felipe Contreras=
