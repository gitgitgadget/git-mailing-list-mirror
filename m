Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DECEC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 21:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjC1VFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC1VFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 17:05:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D895
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 14:05:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u10so12933516plz.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680037504;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuczlPzGN6u8LsouRDNuHmW/xLFVwB7nGnIEvVtOuWg=;
        b=VbOf2udN/p0vteElL0KAq1tVw1UCjOGVe75LqLW3Kb2xhCtObWN14hL++OjlsR5NH9
         oNJxKXjaZUVzj4JUSscoa3dRR7Jasz49Jual2IuPNXjYota/FxaJbZx+/Y6w6sCIuGHF
         0AdpMPsx4TdFzTjvzFPrGzzV4w8zv6WhP/mVv07q6KciRq2S7xg47paYKwgUeRANUF2o
         R7w5aVf/2jyPXfdJ3WMXakjWNZWcttxJ5VEnBd5FXBOX2vJ/lVcw/jXJfT7ctA78pCXe
         TW+luDpGCGHzcaPD3PXrebtxVjs2zdo4M2y4I96kVbxq1Ip1/BHtpLGZ/tdogn3h7Atm
         aZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680037504;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AuczlPzGN6u8LsouRDNuHmW/xLFVwB7nGnIEvVtOuWg=;
        b=UVKe4kIYihR/6AOVW3am+pgdyy0KqVZxTftZs5395kRmGAuMb+i9EBcWhvNg+E9i4U
         8LZYpmvYKg9AV5QblUUa8YmlqdTtGjCPQe243aWBB2/A6X1tCXLCQ2y7EuTCk63VeVGU
         UkB6rP9AWZvdRNBgxm0689yf5ugPjkiDghanrEpaEoVqJ952OFcMMv83G7Ov1kHsVeOg
         0jHmY8yJIlzs7cPNl3Vi2aUoZzxsRwKcwB7eAufAXrjavx2KUJhW1qrpZiP/hDQOn2Vf
         XsRpB8c8sFMkjNmEMQ5HbgJEIPPeN24qo05QTm29TJ3lgSTbANQGBBGhf0B8bcAehz6E
         x9kQ==
X-Gm-Message-State: AAQBX9fX0tWFWHrNVkX/PkCoEiOMndLVz0J4aYV9Mnw3djvV98R1yGcw
        coe/OjSBhTpaZJML1Gug7Gk=
X-Google-Smtp-Source: AKy350ax1bVzw7Z75FPObMY5NwPyGZpBgvbJZVQiE7X5k8uDOtGZGFlkMrjAkSb87r1mAjQABmXz0g==
X-Received: by 2002:a17:902:d503:b0:1a1:b8ff:5552 with SMTP id b3-20020a170902d50300b001a1b8ff5552mr22446539plg.6.1680037504062;
        Tue, 28 Mar 2023 14:05:04 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ba8900b001a19b6ccdd4sm21571669pls.84.2023.03.28.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:05:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: win-test: unknown terminal "xterm-256color", was Re: [RFC PATCH
 6/6] ls-tree: introduce '--pattern' option
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
        <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
        <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
        <xmqqtu20qinx.fsf@gitster.g>
        <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de>
        <xmqqzg7ylye4.fsf@gitster.g>
        <20230328180859.GB18558@coredump.intra.peff.net>
        <xmqqbkkcfz9s.fsf@gitster.g>
        <20230328195942.GA1173031@coredump.intra.peff.net>
        <20230328204318.GA1274197@coredump.intra.peff.net>
Date:   Tue, 28 Mar 2023 14:05:03 -0700
In-Reply-To: <20230328204318.GA1274197@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Mar 2023 16:43:18 -0400")
Message-ID: <xmqqfs9oege8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> then I note two interesting things:
>
>   - the attempted colorization does nothing on ubuntu, because it's
>     already TERM=dumb

This is expected, I think.

>   - the colorization on windows works! But I thought it was exactly
>     these sorts of tputs that are causing the error messages.

Yeah, tput complains about unknown terminal as terminfo database is
not shipped.  But perhaps it falls back to bog-standard ANSI after
doing its complaining?  I dunno.

> ... I'm inclined to just leave it alone for now.

That's fine, too.

Thanks.

