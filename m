Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F9EC636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBQV20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBQV2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:28:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94064B1E
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:27:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id f8so2915379plr.10
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wmpa//irOHbWtAKXXVEZbLO2C4QQVG0iCbO9LoBik0E=;
        b=UaxXK69/i/6CxfY9bW/P6V8mpp0YXRXnel9dcKQYLxT2B8gU6a6SEETvy+QRzXK2C6
         nrbXuBzkPjPkMPQFuyWT8ZEKkLmrRUcbyIR/tO4rhHDjSj2bZFAxrc6yBnUmJNPtVzEd
         rMzzN6upo6CvbaTWqnl7d9kjAXHzYmqF1oFKhqu9IPS4Rl68xbn8FeFYdNnND2uPlsSM
         o62FnhPPKr5hLfCBESdICQIt+Y6BHEXeEL67BL+4xIfQznKmzFlfpzKUuyEVu0Wwfum0
         xVpvsUhG5S01T0hlKdMEu6zcdc3Jy8kihDLfG90XAlvOJ35nPiewg277imCai9o4vrKy
         t0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wmpa//irOHbWtAKXXVEZbLO2C4QQVG0iCbO9LoBik0E=;
        b=kF7+B5j89ZLmuFL/hcwPIbZTRZW6S2Rbbb3Ylqg0hR6oE/KhsfkVXeEtvAXZ1p3X+M
         bup3PN2nY+Gr2U/7g4LMsZ2f0aR8xI6IOr0BEsHe6e1B3fH1RTc2qJvZAUEm76Q62pFP
         sYy4RdFV3iNhwGCz6hK3WOzL7iBL6ZdTqL8bDABoTD1epG9SGhJscpeSgfMz92y3+nKj
         be+KsCiO8Dih4rRbRlq2cxiNx2X+lT8Kc15IZeFGCD46M0N8upMknkaQOcSkXpBEjPHK
         g7FgNYCFRc6E0SW3w9wBejYivhTNCTotoFL5keRqnHsHuivKB+ulVY8aA2/46k4T3EP5
         r1ig==
X-Gm-Message-State: AO0yUKWvaI9If9jKkIdayt5etKXoT25YpFLDf2TUpWvfbaYBq1tBX3QK
        rK+IVoveILTQWNkhNWS7iLtBvctuWs4=
X-Google-Smtp-Source: AK7set86GnjSrNephpcAyeCwlCAOUwB2MGow+Jrvarn7IO2SpddeFLbHxpOjGFTCsdB9mnXef54bPg==
X-Received: by 2002:a17:90a:190e:b0:234:384f:79c with SMTP id 14-20020a17090a190e00b00234384f079cmr2804288pjg.33.1676669261424;
        Fri, 17 Feb 2023 13:27:41 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090ad0c400b00233e860f69esm768697pjw.56.2023.02.17.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:27:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/2] diff: consolidate diff algorithm option parsing
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
        <816c47aa414586e99aa762604396bd8be4fb11f4.1676665285.git.gitgitgadget@gmail.com>
Date:   Fri, 17 Feb 2023 13:27:40 -0800
In-Reply-To: <816c47aa414586e99aa762604396bd8be4fb11f4.1676665285.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 17 Feb 2023 20:21:24
        +0000")
Message-ID: <xmqq3574m183.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> A subsequent commit will need the ability to tell if the diff algorithm
> was set through the command line through setting a new member of
> diff_options. While this logic can be added to the
> diff_opt_diff_algorithm() callback, the `--minimal` and `--histogram`
> options are handled via OPT_BIT without a callback.
>
> Remedy this by consolidating the options parsing logic for --minimal and
> --histogram into one callback. This way we can modify `diff_options` in
> that function.
>
> As an additional refactor, the logic that sets the diff algorithm in
> diff_opt_diff_algorithm() can be refactored into a helper that will
> allow multiple callsites to set the diff algorithm.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  diff.c | 57 +++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 14 deletions(-)

Nicely done.  Much easier to follow.  Will queue.  Thanks.
