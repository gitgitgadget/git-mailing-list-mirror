Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDECC433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiAJSFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiAJSFx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:05:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A460CC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:05:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m4so15429730edb.10
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=img2nez0gKHKhEyKLMm0bdVYbbjmGAFin10B6vJEx2Q=;
        b=ltZGNoI6yFFgOuoUFtAav6DwCQwGG10/LjBrLW6FvaJA9Z4vKljLX8NUfOqpwCRzcC
         dJal3qDzSM690sfpZonlq4t7uhwCdr31RY9Dw2a+h7uAnjRW41k8IS5x5Enu65v72ebf
         bp05ZYl5+YUEdbRomDWZyw7RqTRyy5p6i5F51ZGnZmzGbPw/LguXn3N+q4gcPfI1i++G
         gusG05dp2OuNz9tF20SFVsTWfAcMcBJK6B0eaKhWpsxTwjCHANCLKrE+ig/LhY0YZ/SF
         jDTbQsKVnzLBiTLaCiPVuhoaMLojgF8RiPIk/Ue+0bKkgeaeAYsT6CQZntSTjlaidQrC
         Jymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=img2nez0gKHKhEyKLMm0bdVYbbjmGAFin10B6vJEx2Q=;
        b=RuqA4x0ivx2KZuuUxg7azRJAVwkJ5rBplu0GvSZhKDtb8IVHb5OWuAay58J4cSgfiy
         guw8u4xcN+RzQIfVkSEkOsvvlQO/kIgz/y4RLuHONku1HdYttRHrs2S2ph9qx7xYPJGA
         t42McULigdON034Nq7oMTuI+Kdpm1jAiMHvlJMaqrS/R8QXIJq1gb6kT9ffTmiUdVk3a
         2GLnrxa7zVB0ibnCaNieNduOX93Y6kgeUiz/B9DCS9+BreuzqIVneMVXfHcwjp6jyZO2
         VlhCgzY4L5CAqEM5bLOBEroxF8UKHyDRNmolf3zFD2WdWHNfepQ1tN2iwyMvrhf55ZZ5
         uOcQ==
X-Gm-Message-State: AOAM532CfvRzjNVgvKb7kFh3Co9gPZmiMcqgC3KAHITNBGpibMPAlWuT
        lKvt596iJ/s6O3qVqPR5jL0=
X-Google-Smtp-Source: ABdhPJyhTDZTTfLzgCCEIkt98cFn6K9ROQTTs44AcH7qOVNLbQsex/VrhCvkyN9uUZc4p15zc0FeBQ==
X-Received: by 2002:a05:6402:2706:: with SMTP id y6mr816113edd.308.1641837951122;
        Mon, 10 Jan 2022 10:05:51 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q20sm3894628edt.13.2022.01.10.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:05:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n6z3F-000OAC-GE;
        Mon, 10 Jan 2022 19:05:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Teng Long <dyroneteng@gmail.com>, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Date:   Mon, 10 Jan 2022 19:02:47 +0100
References: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet>
 <20220110082254.54400-1-dyroneteng@gmail.com>
 <nycvar.QRO.7.76.6.2201101346090.339@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2201101346090.339@tvgsbejvaqbjf.bet>
Message-ID: <220110.86ee5fzcsi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 10 2022, Johannes Schindelin wrote:

> Hi Teng,
>
> On Mon, 10 Jan 2022, Teng Long wrote:
>
>> [...] about the using "strbuf_addf(line, "%7s" , "-");" or
>> "strbuf_addstr(line, "      -");". [...]
>>
>> Why I prefer more of the former that is because, for the single line,
>> it's more readable I think.
>
> I strongly disagree. Using a format requires the reader to interpret a
> `printf()` format, to remember (if they ever knew) the rules about padding
> with `%<number>s` formats, and then to satisfy themselves that the result
> is correct.
>
> That's quite the cognitive load you put on the reader for something as
> trivial as "      -".
>
> Not a fan,
> Johannes

I think you can argue that, but saying that this series must change that
existing "%7s" format just because it happened to trip over an existin
coccinelle rule as code was changed from printf() to strbuf_addf() is
going overboard. 

Also, the ls-tree output has existing alignment issues, and the
documentation says:

    "right-justified with minimum width of 7 characters"

So I'd think we'd want to keep the %7s, and in some future change change
that format to be dynamic so we'd align things properly if some fields
were longer than 7 characters.
