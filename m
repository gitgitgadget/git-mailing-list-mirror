Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4A4C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 10:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiK1KEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 05:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiK1KD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 05:03:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7A1A208
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 02:03:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so9669622pjj.4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 02:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9rJHklcMiQ/LLELdUphyeJ3/xCtbM8/qCPY7J+FUE4=;
        b=aGZdB7vb1/h0WPrM072DINxIyzULrCjF3mSq4PCfajT4SRjDefdZojlzJqN0sLP64B
         mTcjgBN8EAJdqaISbpBIMu+qBT3/4EDx2naDFvMSmdb0bZHvzwSu/uBWMEW+Jn6emQYP
         vab3wy1zKfNyyXUPvyCKmMxg5eb3R4OWo3SdqHhcZDmSXKZw5Yu2rkFzaQlTb/ThawTF
         61fpj4stOKAuOuyDGOuxfNsg9m+zj6AU9Vm9EvXxSckvCY6Nms4hmX0AihD3pbFcRffJ
         Z5X4H017ZwzdjMH2zhH8VWN50tJSZ9Ss+fG6HkycihsY+/MUwWQvTvnLpoi+ISEBIV0I
         KNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9rJHklcMiQ/LLELdUphyeJ3/xCtbM8/qCPY7J+FUE4=;
        b=N0fRzD7pRBNRrFbgWIOn7kjQvbmVtHTU1rB7ZsTMG8V3FaR1FBJxZXBpvADKkZjxUO
         7QkZm9K+XvG37mk0wbE0SWbD3TQBmtcxj0YfzLnmVzy2nXLaE8E8PHV4//iaTcjl61wo
         HCFuZKKlqrQsXJf0sxmlyYOc1C6ZCxhSERP1uw0nWUS1Y4VPr8G7wPWMW2HBNfyfV02v
         BxD+viDXkdyYeNR6K6/0imfsj/LLdJxvTMiizwL/5LY9MpqnJhKGxlOJVJGKSPqebALD
         wQtYqPdPRJ+DRpMQ6MegU0EVSjiO2BJDvErhbps1YjPAALI/seu4SxNoc9t1ofMIKrOK
         Lx2A==
X-Gm-Message-State: ANoB5pk0s7Xv0yXK1LJJjXu0Lgc9g4l91O8vd+q+mQAMbtTSX8H5o4TD
        Qcesj88kQsXKHLNyzuWR4Lw=
X-Google-Smtp-Source: AA0mqf49Z2e9Lltv/Va70OboOkdLblFhPLPgBpLoSJdCfJL69+0cdCKGDFDZK2mTcyDjBF79HFbOgQ==
X-Received: by 2002:a17:902:e550:b0:184:dc59:cc9f with SMTP id n16-20020a170902e55000b00184dc59cc9fmr33711815plf.89.1669629836723;
        Mon, 28 Nov 2022 02:03:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090322c200b0017f73dc1549sm8417614plg.263.2022.11.28.02.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:03:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
        <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
        <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de>
Date:   Mon, 28 Nov 2022 19:03:55 +0900
In-Reply-To: <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 20 Nov 2022 11:13:48 +0100")
Message-ID: <xmqqv8mz5ras.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>
> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
> 2022-03-28) avoided leaking rev_info allocations in many cases by
> calling repo_init_revisions() only when the .filter member was actually
> needed, but then still leaking it.  That was fixed later by 2108fe4a19
> (revisions API users: add straightforward release_revisions(),
> 2022-04-13), making the reverted commit unnecessary.

Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
way.

https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#step:5:3917

Does anybody want to help looking into it?

Thanks.
