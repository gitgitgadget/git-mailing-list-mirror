Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC859C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5144206FA
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/8HGNsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgGaQRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaQRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:17:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC692C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:17:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so17944145wrc.7
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dnzdE++EkXhJVlfctRmGqFG+TDETO2shDOqXkZxqncs=;
        b=X/8HGNsV3VKXGy13pYXTGYeSaN/RnIXNqCgcfAqpxWIeQNlgYKlLtTZTF8nIgfvPEN
         3k6f0jMku6VRsAYZskQaFOaF8jfJrg8j6Lly6ioBsyOcj+WWX536u72d87XMzJsxWIj2
         n3ZXQ71McuN7MeqjdJBMCUEd9PP+i+i267kB+f4Cdpeo4/xl0k+GW19tJ4pcQFbPmVWt
         6Tcx4Tr1NE4eWM9m/DkR/89J7nqZxkBu6hBulhkEc/13w2QhH12grLq5r36Be5AFx3xT
         tnkGTMa/fIWWgDWX5c17V1BcDKYb3OGVOCZfzyQQrO4msjdEYNKp4UrmOkKC+Y0hdPHS
         rLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dnzdE++EkXhJVlfctRmGqFG+TDETO2shDOqXkZxqncs=;
        b=SmHZ93mrOwi82NuVZWEPX3Uwu3FjVW/9xCtVct8Y/7prKo1ahfgI7MGCeMjI2TXFs9
         LRrOirl9Rz14Pe0knGLXLtuPGS+8Xj/Bla52y8V1p6rXlF2D1BtJXxMNc11aJnBRwdxj
         UKjGNn2xRiPg2DelVhtUIVwMd9TEMJj7tlRuSuGCm6oaLu9gBt7XpDXK5/o+lypMeVju
         dO3tBH/qZ6G8KCUJdKKO+9mEL7JvKIrmxXPBR1oZ8JtoTGUkWs+i6Emjk639Wo8rftp6
         /g5Fi8izyPs0HAIrH6EKsvifIqhU54DqFdae7m5r5OF2i07yrJLoXWA4wMJ8zPNoEzpk
         g/SA==
X-Gm-Message-State: AOAM533zdYtV+hi7ZYYAwDTvDropvptqYSl6htg6AStUGd+SLBPPsD92
        PR3QtOKyWridoDyoOwNKAnZPKyA0
X-Google-Smtp-Source: ABdhPJyR7x6o6suEEPKyI/7f7pGktuBLzYYAGulduWlZokLvOvK1WobsZHblz7UO1eJIquOpldpcSA==
X-Received: by 2002:a5d:54ca:: with SMTP id x10mr4085571wrv.36.1596212233788;
        Fri, 31 Jul 2020 09:17:13 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.gmail.com with ESMTPSA id f12sm13505236wrj.48.2020.07.31.09.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 09:17:13 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] stash: remove the second index in
 restore_untracked()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200630151558.20975-1-alban.gruin@gmail.com>
 <20200630151558.20975-6-alban.gruin@gmail.com>
 <CAP8UFD0QR6cS4XxzLoQBsDAP3sDz4yXkkT1_Vgs_hVdWC+QRvg@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <3418c670-31cb-4b98-37b1-5e2233a2c856@gmail.com>
Date:   Fri, 31 Jul 2020 18:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0QR6cS4XxzLoQBsDAP3sDz4yXkkT1_Vgs_hVdWC+QRvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Le 31/07/2020 à 15:45, Christian Couder a écrit :
> On Tue, Jun 30, 2020 at 5:16 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>>
>> This removes the second index used in restore_untracked().
>>
>> The call to `read-tree' is replaced by reset_tree() with the appropriate
>> parameters (no update, no reset).  The environment of `checkout-index'
>> is no longer modified, and the cache is discarded when it exists.
> 
> Do you mean "when it exits" or "when it exists"? It could be confusing
> as you use "exit" not "exist" in 2 previous commits.
> 

I mean "when it exits", as in the previous commits.

Alban

