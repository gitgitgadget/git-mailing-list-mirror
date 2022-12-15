Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B119FC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 00:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiLOAN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLOAMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 19:12:47 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3495F61
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:09:06 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a9so5120257pld.7
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu8SNOhyI/pMF0uGOgkk3Oo6lDrirko2dtcF+SPWFIw=;
        b=SUgSuryBOeOV3UYGv6lLhxIOXxwDuSEubCmF7WUVV3tUmgsE5pCp6y4/wAkDNrBh9b
         A8WHi6L9zV28oajqRKNIc+7/d4Ko4ONr4ffkSg8P4QQRCmrc0Akklgt4tysiPdgh33YX
         mmx7L6WsiCw42kzKKWGfWd3S5j79B70nBI+viI3F4kprfL/WxppyQiSimTl8+ssxdzgF
         mdOwroc/Es75KY2m5LXkoiqBomki5hbfSCrtD57UX5PPQ1nVAlV3ywo8xy8rYeajv5yf
         88yDoMeZWXcCTk8Q8y5AUr6W2BgVY1vStOO1ayPbhEw6fgnY/acdKVBIjoXfGkXG6kTy
         9I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pu8SNOhyI/pMF0uGOgkk3Oo6lDrirko2dtcF+SPWFIw=;
        b=dU815fK/zBELb/pMpE3j30QKW8nLSKbMc7ipTD0zM85vSCHogzqpPNy5xjh/1xOY6q
         XXChuliWE6oEMKRchcHYUh0y0j8DDQj0mPMoz8q1Ru3T2OM8EokEV/Vc/61dH0Uoy3A6
         Sm4Rs5nB27lh9bdHNVvhb5z3v52giVTK5C+NyX+CuoMehf10oJma09vbyqYYN0qpfJIn
         aG8UfUhqt/VsDy/G2zdUoQGaME4GKLJvcp1OWi40FDB/36lj0ayhjbnFFJqkavsWo2Zl
         0BbJyXC1bRuYiHI7kR8zy0tDj+5RSiXmxGifVr24+niX8GDgkGmjRMxd5DrBofgVW0Nr
         c1hQ==
X-Gm-Message-State: ANoB5pnlik7o27/YyxncvrhDrz3TWGzwJQVhBxPcNAKZRRSDYwkigUb0
        fMxZsJP8n7rTguMPPqz+HZY=
X-Google-Smtp-Source: AA0mqf5OwANyNAnSQ+NcepdM9UYOjK6tAGqPfD7nd0L8Yd3fM4FCnnbrPZSezTk+eIv2Rdkz0FmRiQ==
X-Received: by 2002:a17:902:f283:b0:189:6c9a:7d8b with SMTP id k3-20020a170902f28300b001896c9a7d8bmr22218152plc.32.1671062946157;
        Wed, 14 Dec 2022 16:09:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b00189743ed3b6sm2429602plb.64.2022.12.14.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:09:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2] fsmonitor: eliminate call to deprecated
 FSEventStream function
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
        <pull.1436.v2.git.1671045153981.gitgitgadget@gmail.com>
Date:   Thu, 15 Dec 2022 09:09:05 +0900
In-Reply-To: <pull.1436.v2.git.1671045153981.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Wed, 14 Dec 2022 19:12:33
        +0000")
Message-ID: <xmqqtu1xttni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Replace the call to `FSEventStreamScheduleWithRunLoop()` function with
> the suggested `FSEventStreamSetDispatchQueue()` function.
>
> The MacOS version of the builtin FSMonitor feature uses the
> `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
> and process FSEvents from the system.  This routine has now been
> deprecated by Apple.  The MacOS 13 (Ventura) compiler tool chain now
> generates a warning when compiling calls to this function.  In
> DEVELOPER=1 mode, this now causes a compile error.

Thanks, will requeue.
