Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B10C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2632222E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 14:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTUYM2Nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgKQOZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgKQOZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 09:25:00 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048CDC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 06:25:00 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so22618200edt.9
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 06:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Lk0H9ACYtWHwsw9yOzdxjTa7KHba5lBo73FXwAJIu0g=;
        b=qTUYM2Nwk/axj1w9Ih5RfIo0hHO6Hr/JozXK+TFQjQOxo100VTuVt3bss2tNLIaTHa
         TDtpHlzBV52vLOLKzFnOPlyX4iI/Rj3DzrRC7jUj/wEF7jfUkZBWtQdG2EGkQAcfmheB
         IqhYpy2GvPjzA4DmxU8hJ+HQkfrkzyk1W1NqbUbTizm1W6YfSWuMNUdanIqICNQSsdls
         R8pWvzLMvVGPT/Wg/UitZ7tgza2BVIHVM/fhf1aZd7egZFLN/hiuOgnZMLGSTWyACtCI
         GmxajhejvWPBeUzMYik2ZQKhJCa+O8MsMjNu6tvo7pgp+V/YTKBp4YOcZ8NT6pY8gu4b
         qj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Lk0H9ACYtWHwsw9yOzdxjTa7KHba5lBo73FXwAJIu0g=;
        b=iWfrBFjxynOd8bpRPQ2hPQzAu/fbZukPtiFpqaQTH8N0mmmekNKtcywEL6JDgm2O8s
         cFlW8eprp+x5wcDN5vyn5fhMVoIhFk8DJOExA6doCD4D/q/3iiPuGBaUoGf8qFXSomUt
         45lxKdxDcoyC/DG1Oipc3tAU2E0G31uGHu5cz1H42MRb3TPzS4AmbWYTpC+yfUhxRMSz
         fd71WIgneIV43wHCL9UDl1t7inhpiAD5pB43qQ4FvIzovavOWNjgOZciHk5SDVjRXEJq
         EjP0h3RBOHlnG5XCHckmxgh/Nw3uoJRQgzSDibv2t4rTu9chEwiDcR/fBIfPoQ0hDy7f
         jhOw==
X-Gm-Message-State: AOAM533AVVMDas5WhSa7qC64ssJMHn/AiIDAWwRW2E0fUb28Rcn1tZOL
        Cn3+fhJUlVKuesCX8MjEdn8=
X-Google-Smtp-Source: ABdhPJzo2ISv6yP9U+R4nNAXP4CwzUsCYXKSyYBo28cPZ34+sRYQBE7svKoC9TK/9vyxUNj/KVkBrw==
X-Received: by 2002:aa7:d502:: with SMTP id y2mr21306694edq.120.1605623098672;
        Tue, 17 Nov 2020 06:24:58 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id k17sm11314531ejj.1.2020.11.17.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:24:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/3] parse-remote: remove this now-unused library
References: <20201112203155.3342586-1-gitster@pobox.com> <20201114122132.4344-4-avarab@gmail.com> <xmqq4klp80ff.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <xmqq4klp80ff.fsf@gitster.c.googlers.com>
Date:   Tue, 17 Nov 2020 15:24:57 +0100
Message-ID: <87zh3gdps6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 16 2020, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The previous two commits removed the last use of a function in this
>> library, but most of it had been dead code for a while[1][2]. Only the
>> "get_default_remote" function was still being used.
>
> Yup.  ... still being used, but now it is gone.
>
>> Even though we had a manual page for this library it was never
>> intended (or I expect, actually) used outside of git.git. Let's just
>> remove it, if anyone still cares about a function here they can pull
>> them into their own project[3].
>>
>> 1. Last use of error_on_missing_default_upstream():
>>    d03ebd411c ("rebase: remove the rebase.useBuiltin setting",
>>    2019-03-18)
>>
>> 2. Last use of get_remote_merge_branch(): 49eb8d39c7 ("Remove
>>    contrib/examples/*", 2018-03-25)
>>
>> 3. https://lore.kernel.org/git/87a6vmhdka.fsf@evledraar.gmail.com/
>
> I am not sure why we even need reference [3] here.=20=20
>
> Isn't it another mailing list article where you express your opinion
> "they can dig our old version and copy it to their project", which
> is the same statement you are making in this proposed log message?
>
> Are we saying "we said the same thing on the list before, which is
> stronger truth than the claim in this proposed log message"?

I was aiming for answering the question of "why didn't he just move it
to contrib/?" by adding an (it seems too much of an indirect) reference
to contrib/examples/, without going into that whole saga again in the
commit message itself.
