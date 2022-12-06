Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95F9C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 00:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiLFAKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLFAKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 19:10:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987401A835
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 16:10:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso16496019pjt.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 16:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qewRICd4PhgcyTfbslNfQq3T3eKfBGT9XExHJAnWQ6Q=;
        b=gLQir2xquTB5AMC+DwbDQ82iD1eyusNmo5Y9lxl1wXrhg8+lBaKuYzNkyh2/sZBvLY
         O2YHBcHY+wRnLTER1C1MNK3i8NZADexmEW09ysIAMVMKlzKyY9vCyINt4L7P2UZcMQiG
         rIEybYolQf4dvxO72/KrD7LVbKbT28Wospp+v70QclPyWgUZAwpFOTCpnYOGv2Bz41nW
         GlsDQOmsje7Y0d681sjob5UbDrcLoirrzJ4dVn84vRtYFreqgHWd6BwCuivzU/bieY/R
         /O5ixP7f7j5L0o/uTw86E9g3NPP887x6jNbqmSHUR6GVlpYoHVqxnsOf9X5HAoPBn3zT
         +7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qewRICd4PhgcyTfbslNfQq3T3eKfBGT9XExHJAnWQ6Q=;
        b=XhXcZ2xw66rviYcGo7fIdB1asnev4jFb9hxD/KpXBYjC9bUfIyq9jVvkbioigFVFmV
         xaIYTHUrplMvWn1cd3iPTTeT0qphruMZnvAhEribFKX7IdkyTer9viEcWRm5KSWDk5sG
         6tiS+33WsVsEDH3ZKq58Fj3QBMbt4pipqYRlsBd9Z/yuhO/kh3J1M5fgdd1iVXqcGdj3
         hccQZ4MIfpUp7anQ8PRjnzLOwXcPUHN8dzMIYV8pW1L2VUQZCF08w3XAaApCwmSqQzUD
         x1+7/YEwzQQ+qzvHbWu6LBA0JTfkXCfrIyfb5OpsOAt8DvQxBiAyr1m75eSxdouQ5foO
         sN6A==
X-Gm-Message-State: ANoB5pn9ciqv9+eUs1yd2Wf+qwOJt/vIFwS9I8omtQvzeMsnXLpV/ESU
        OuHoYpWTGbHxy/4j1D3YntmMAtQjvsTwIw==
X-Google-Smtp-Source: AA0mqf6AUwI+DLInsoNqGPjOaq0X0+IBACwfrDfdecFv90MIKnwtIYlcdbjlKJDmjMpVqX0+Zodojw==
X-Received: by 2002:a17:90a:5102:b0:219:4734:fdeb with SMTP id t2-20020a17090a510200b002194734fdebmr38302241pjh.226.1670285451989;
        Mon, 05 Dec 2022 16:10:51 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 135-20020a62148d000000b00528a097aeffsm10359046pfu.118.2022.12.05.16.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:10:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
References: <20221205190019.52829-1-cgzones@googlemail.com>
        <Y453yiYAifv/oV5n@nand.local>
Date:   Tue, 06 Dec 2022 09:10:51 +0900
In-Reply-To: <Y453yiYAifv/oV5n@nand.local> (Taylor Blau's message of "Mon, 5
        Dec 2022 17:59:28 -0500")
Message-ID: <xmqq7cz5pf1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> So it appears that the old version is ever-so-slightly faster than the
> new one. But it's so noisy, and the regression is so small that it's
> hard to notice it at all.
>
> So I wouldn't strongly oppose the patch based on those numbers, but in
> principle it seems flawed.

Thanks for writing and reviewing.

As long as we were touching the function, I suspect that
the logic should become more like

    if (fd #0 is not open)
	open /dev/null read-only and give it to fd #0
    if (fd #1 is not open)
	open /dev/null write-only and give it to fd #1
    if (fd #2 is not open)
	open /dev/null write-only and give it to fd #2

with opening of /dev/null optimized not to happen when not needed.
