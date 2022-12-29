Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2497C4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 07:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiL2HNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 02:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2HND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 02:13:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE3A477
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 23:13:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso22183059pjt.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 23:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBp/nibF7JoB1kNzrvPC3+DisjfWCt1DnU1xBZD4axo=;
        b=IdyJ5fxqJ5gCF5LGSKyO16+NBssSZpCJWA3oyUUSUa1p+H6k/l+56DFB4Uc23TN/D6
         TVH0i4Nb7T0q3+h+N6rfxYdQzoB6YeSlk6PsR8sHPUV3BzzmbUA6e5xuwlnwpWjqVtwI
         ZfiYaxhsqnNdy9kT8UqGZwfWcudhTghfFbXMYHxI9gMbli0W2EzyfO/k+jdAz9KSDjLx
         P43qpLJUolf1VFNevjOK4nrxaM15jg0Rl4h7csNHvuTP4buLe/ET4Ryl/XYC5nNzMXBR
         krb8JAy+c+VzYlcizMnWHGE0hkHHgrq81P24ACrIgc6gQwX8gopmwIJsacO0gzX0q/ym
         gHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBp/nibF7JoB1kNzrvPC3+DisjfWCt1DnU1xBZD4axo=;
        b=RWniGYDGa5qVtC10tuNGIQ9tjmRLZayhlZKQbXPC2FZygGo4Zn7vk8FSNwoGcWNm5Y
         S4h16SS7ICZky8Y1LwqNZDMmAwFR4T/VVficNOi1VdSyi/Yd+EY5RpwoH5tfh0W/12bN
         1HScHZzr4XX0Gv75kDbdYct9GB1hZIl6HKWGtCKmyuBmuYGhzoM6agjGaP8FxLKdJdgK
         Upn3w8dzbdanlL0tPEA690tz8d9fnASOGzryNVxGe6x0g0lZxVCTGdWZlILv7uf5epAE
         M+GgCUjmZGPNujLFbVhkbtTZVdhoYr8g7/mIWXi1KMtbQPbEE6T7E03FZseqTcr2wOjI
         SY2Q==
X-Gm-Message-State: AFqh2konFHK6QSIB09VZu6tbt1+ouQi8jKETDoSv3KiAdg3Y+7fJcSTQ
        xoKPxJ8yICeLaNWFz7RkyrSQsFm/E9kxEA==
X-Google-Smtp-Source: AMrXdXus/JMT2Vu7ehXZjpgZyyZQyRgeLhwonFzdy00gWpXjp1KSOm0uVnIN7Ma8A1vmWtQcS3MDQA==
X-Received: by 2002:a05:6a20:6aa8:b0:b3:87f8:8387 with SMTP id bi40-20020a056a206aa800b000b387f88387mr7526287pzb.50.1672297979995;
        Wed, 28 Dec 2022 23:12:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 12-20020a62170c000000b005769436a23dsm11366088pfx.218.2022.12.28.23.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:12:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 09/20] name-rev: don't xstrdup() an already dup'd string
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
        <patch-09.20-77fcdeb9284-20221228T175512Z-avarab@gmail.com>
        <dbc7c55d-d546-d004-ef44-62bd7349d5c9@web.de>
Date:   Thu, 29 Dec 2022 16:12:59 +0900
Message-ID: <xmqqv8lun0n8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> -	tip_table.table[tip_table.nr].refname = xstrdup(refname);
>> +	tip_table.table[tip_table.nr].refname = shorten_unambiguous ? refname :
>> +		xstrdup(refname);
>
> Hmm, this works based on knowledge about the inner workings of
> name_ref_abbrev(), which provides the refname.  Could be cleaned up by
> inlining that short function, or by moving the xstrdup() call there.

Yeah, name_ref_abbrev() returns sometimes an allocated and some
other times a borrowed piece of memory, which is a poor design that
ignores memory ownership issues.  Luckily the function being touched
is the sole caller of it, and I agree with you that inlining may give
us a better fix.

