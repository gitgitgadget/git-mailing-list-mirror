Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5A3C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 10:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLPKR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPKRY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 05:17:24 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7931EF1
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:17:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id w37so1449571pga.5
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNFdaoYg7eJbnkBBIrxczwHGRLFGac6RdF2e0dOda6E=;
        b=qvGWzx00FdXun2s5hNXQaIxsW4GdJao4/ObwWTf3QHWum56u06UUfA9G6Sk2btmG2O
         O4XGTYCYNvvri/hEXreqZYqRV4NSOOPgnJj+lg/TpvOlUWRiKMePCedtxMUmXsSwF0ZA
         b2fxipm3YxMi3a6l4t0VTS5nkZUOPO9MIbzUj2T8+21UsPXxp0DCCtJgLNdofQ9Ni516
         Cbg4tHR1NpcV9zJYqxU8zrJVYTdxAlZFDfVxjSdGK1uJw6yFwy5m2mt4mGkSlLMw53vS
         fP/jtt0cKr0//uh2kvRFEIB72L4hyPQ4qb8xBOaFjGG4E3/NcCDS76d3+wo8LbC2tR2N
         vL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hNFdaoYg7eJbnkBBIrxczwHGRLFGac6RdF2e0dOda6E=;
        b=s0mq2RRUGsW2ze6bL3hxDRNYpFqOBJ4ZCfrY6MMeCtfsel03HXduRr+4QixqnpE0SF
         DSZMYsLFAo4oBa5gTxbNKw0WW46/L6/GnuWGx20e/CGpBPThnUDs1Xfv23im1u+eN196
         zf/q/tDW2GASuyqQznRYuBubcWgoNrAfmj89DRkSslxwJxgcJURlRZTt8iLRm/lZD+fK
         9yWFCUwcktE6u9virjuNKbmrhRBKB6WcNafaMrqvPQ/d6tXy1i6j3Rg6ilT2h9w8LSH/
         5c3dItzvUmdiqAVCSC2xNF80uMd02ffGJQJRl7TB/KJAn95BmFuPX7KQrDgJElgzCrRo
         dfDg==
X-Gm-Message-State: AFqh2kpVRj466nafElBG1eUExaGF+qpRgmyX21P/yR4AIlrhCXkw8crA
        jb8yv1HvPzNzBVUVZwke8h4=
X-Google-Smtp-Source: AMrXdXvme7o2u2M3HfR/Fetfxw+mYGC5DezPJc5JChv3SF75RdZAiWmZEkc9GH+f9BtweJ5qDPT9Yw==
X-Received: by 2002:aa7:870f:0:b0:57e:c08b:b7b9 with SMTP id b15-20020aa7870f000000b0057ec08bb7b9mr3262396pfo.10.1671185842487;
        Fri, 16 Dec 2022 02:17:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z29-20020aa79e5d000000b0057524960947sm1153146pfq.39.2022.12.16.02.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 02:17:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Nemmaier, Christoph'" <christoph.nemmaier@cpp.canon>,
        <git@vger.kernel.org>
Subject: Re: PROBLEM: "git pull -v" fails with exit code denoting a
 submodule syntax error
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
        <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
Date:   Fri, 16 Dec 2022 19:17:21 +0900
In-Reply-To: <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 16 Dec 2022 03:42:19
        -0500")
Message-ID: <xmqqcz8jmz4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On December 16, 2022 3:28 AM, Nemmaier, Christoph wrote:
>>I expected "git pull -v" to simply work and exit correctly without
>>telling me the syntax of "git submodule".
>> ...
>
> Hi Christoph,
>
> I have gone back to git 2.36.0 and cannot find support for the -v
> submodule command parameter. At what version did this last work
> for you? Do you have a git alias in effect that might be adding
> -v?

I suspect it is the same issue as the one that triggered

  https://lore.kernel.org/git/f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de/

which came out recently?
