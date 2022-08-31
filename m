Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC801ECAAD8
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiHaUTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaUTC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:19:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D2F14F3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:19:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 72so15505161pfx.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=rzVk8IWTXhC+asqgnQBMpNMfKxzQP5bx55GQTUU6cFU=;
        b=aX/rsxjCxNLbFwoBTObI0x4QnFwMtC2c6I7dnn2Rcb0QgYru/bRNCYLF9NYvZkYd/R
         brBrETjZdkcmEqJKJb/BUId0Q0O5H8jZHZ0DOoruKaeLWpuqPXymq7wvj4Fl7Dib0gtX
         NdT7eE1bjQZTsyaRekXQgcnv8sFlDh2RUKCZ7uy3zWh5Ekl2Ei+SspDzqUAVRjoG97A/
         N9g8IYuh0MXfrwmic8OwjWHPD8/qSeRuZRnUDBHONtrz7bF2OCu8mmghkFw5vlff5ecn
         s4URbhiREEKVtEK3YIBqhEXl+x4HJ+In9+KCaFN3C49n4ftdV7zkALEonS+5DDKz1vI6
         PLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=rzVk8IWTXhC+asqgnQBMpNMfKxzQP5bx55GQTUU6cFU=;
        b=uZie2kqG99LPz0D6uczpvf68xg2U+M0cbK+57AYuv3frGpsqXv5oQx/XqjGdz2aCwB
         ac4qg+dTrebfrxQwhiLxbKkMY03pNjZohDvP9TjXdfv/eKgM7VmBG3P5f+J5IgOi46Tw
         jAacNgLe7jAofhV8Jg4dapMGLFhqyhJ/+pd0DuX92UCVpHfZ0ZGCILEZPtlB23E3PVTu
         y7QiLqdVkRFP00epf57fY8rpATzVA9rEpgxGpFeCpqT2ldvO02rnu7DL/QKX5Ib4blOI
         Y93vks6EtdIk5uxtFDjjj60uNI8k4ymFhEqrluu2PGt/+2Dsh4HDHYRsKVwF3Aee+pr3
         WEAQ==
X-Gm-Message-State: ACgBeo2I2CuuY+eU6AkSk1BuLF3vQBRxNrgo0KlDPqr5Bn0kGQLdRgdg
        eieM6dfrWpbOhr8hUM1iijc=
X-Google-Smtp-Source: AA6agR6BhWSfFMLpI4vjiu41DKP3EK91610WePAGCyvaYdGNeQsHuu9twRA7qVX6a2rMS03NLXX0/Q==
X-Received: by 2002:a05:6a00:1943:b0:536:2bef:2f93 with SMTP id s3-20020a056a00194300b005362bef2f93mr26989422pfk.34.1661977141156;
        Wed, 31 Aug 2022 13:19:01 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902aa9100b0017272667a56sm11845198plr.196.2022.08.31.13.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:19:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 5/5] add -p: ignore dirty submodules
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
        <cfa6914aee0d3ef84d726b97699f438fd4b254d9.1661785916.git.gitgitgadget@gmail.com>
        <c205f8e2-62f9-d4b2-0ccf-51dcabc12224@gmail.com>
        <op19530n-27qo-r35s-r1q7-18s3259ps78o@tzk.qr>
Date:   Wed, 31 Aug 2022 13:19:00 -0700
In-Reply-To: <op19530n-27qo-r35s-r1q7-18s3259ps78o@tzk.qr> (Johannes
        Schindelin's message of "Wed, 31 Aug 2022 22:05:23 +0200 (CEST)")
Message-ID: <xmqqr10wdv4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And it is that doubling of work that I tried to avoid when implementing
> the built-in version. The bug came about because the full diff call wasn't
> using the `--ignore-submodules=dirty` option, and that's what I missed.
>
> This is maybe more interesting a story for the cover letter, to be able to
> understand how this bug was introduced, and maybe to offer an opportunity
> for others (in addition to myself) to learn from my mistake.

Yup, the moral of the story is premature optimization bites because
we are not always careful ;-)

Anyhow, I am getting an impression that the behaviour of the next
iteration would be much closer to the original, which is excellent.

We have seen too many "ah, this is broken and here is a fix that is
appropriate in the context of how the new C version does it", not
"ok, let's make the whole thing behave more like what we used to
have".

Thanks.
