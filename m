Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A174EECAA24
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 16:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbiHYQtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243391AbiHYQtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 12:49:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DEBBE4F4
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:47:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t5so1751369pjs.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=LE29NvtmuvnJWa6frv6wXjafamy7Cy/dgHKQ+tuKtkk=;
        b=OG/GPgrjo6NI6gVJ69zh+Z0WiSR/+xs8+qHWVTSU1mjPSOc0pydlfkI5D+VBIJ3XzS
         aWeQq+ETr8C0gC+B7eiIGC0sp+dRTepqpsTTE5K80ZGHE0dsV4kKmzKE188MLvelUerP
         ZHlU4NAVo70udQKx6P494sczyLWMK88MaTeSgicUxVgMJXgYCl9N0OTsc5Xosub7IM0K
         WFKUqeuP5G/x/NSMArEgnblhyFWKn1+hkUNpM9jlSbg2XeGVwCGKjMd0viQ2uZ2HNKTQ
         NCtW6ZOLttn+quctWfJp4tB8Iyl/mmM3ezn4vT48QRHp5tSmb0yfDLKA1VoUkoJGzHZO
         0h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=LE29NvtmuvnJWa6frv6wXjafamy7Cy/dgHKQ+tuKtkk=;
        b=MCzXKaM5KwRdI3gRcCWr+JyoqdbRphdiGhz2VH+GBxQc2ZjbBtG9VAEiH/PsqBoOTb
         o1R1BDtf2Tj/uRzyLfxJnV4Y8ShtFx5ufU5L6kfSi+muCsZISy/Be9vvYAPv9XaNJmu4
         0kkT4M9y0dS0WkqLqUAY/DtkxRKa7Gv34y7C51K1AXCqdwf86TNohuT4mtRXeFOVYIzj
         YtDtGd9MlpH89lBbgyvSXju0T4jiTuoVij3I0v0uzI3s0GPJQuBKtOdyjI7GfC7t4pl2
         ELFBZKfUYDFxTjOB1ynARvnaZQtMXbyGkFdWZG5t7V7lEW40JI2iWpqCYxXV9GK2ju7S
         STqQ==
X-Gm-Message-State: ACgBeo2/xvMOh9PVv+dBg24i8aGXa2++hWIbphItypNKMCuBpPgnhTvy
        fMy7AQAhkyzWY3IVjdvbPJo=
X-Google-Smtp-Source: AA6agR5VmHJpih7trq+v9Pc3fEXD0qLCYUoPlu7aJcTXVU6sl2TlXAgM5IhVuYtBV/EYegrHmbxQug==
X-Received: by 2002:a17:902:8505:b0:171:3df7:dea1 with SMTP id bj5-20020a170902850500b001713df7dea1mr2640plb.110.1661446026015;
        Thu, 25 Aug 2022 09:47:06 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001726b585d4bsm15229072plh.202.2022.08.25.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:47:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/3] pass subcommand "prefix" arguments to parse_options()
References: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
        <YwdTJOVo46PrIHMc@coredump.intra.peff.net>
Date:   Thu, 25 Aug 2022 09:47:05 -0700
In-Reply-To: <YwdTJOVo46PrIHMc@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 25 Aug 2022 06:47:00 -0400")
Message-ID: <xmqq8rnc2rue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, there is a good use for it: they should pass it to their own
> parse_options() functions, where it may be used to adjust the value of
> any filename options.

Oh, absolutely.  Not passing prefix if they use OPT_FILENAME would
be a bug.

> I'd emphasize that this wasn't broken by bf0a6b65fc; it has been broken
> all along, because the sub-function never got to see the prefix. It is
> that commit which is actually enabling us to fix it (and which also
> brought attention to the problem because it triggers -Wunused-parameter!)

Yeah.  I like that analysis.  With the commit, we pass prefix
through the callgraph, and now we can fix it ;-)

Thanks.
