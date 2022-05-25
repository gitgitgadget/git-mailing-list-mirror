Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD301C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 00:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbiEYALn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 20:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiEYALm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 20:11:42 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0301F2A729
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:11:41 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s188so19531545oie.4
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eHyOfEhOPiCEZmE4Fbdtc5b6XbRklxXxSXr778omi0M=;
        b=pobELaMBVYbK3A6D7vrjWhcHJjSSzN2NC71MibBvZiHKqvx7cJK5b/0qs/wQKnrqzo
         zdNIIM8rYr6Z3243qZowptHOvMwU5IUnNIzJPB7UE7/z4YiEWp2K2Dc9YaGVJLw4NGQv
         h5LFjgC2AtyQfLlTNnt92quFCsPf35wNXpacBWvSkGXe6xyjqj2CsenXRoBY/6Po0mYR
         dZTtHCpJBCABbHh6oXKr1U3i9h6+ddijT2wsFVOMT05Sr/EiqID0uSZ3BH+VveveoHnn
         c9VL+T3HlsY2w+98CbWW7i4WDadCmy4bnGazFOwGNKhfNvBMT5uB3W3fCA8QCYKtlzYh
         5zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHyOfEhOPiCEZmE4Fbdtc5b6XbRklxXxSXr778omi0M=;
        b=Ybbx88p/Juyim1GzHVV6jIVYZZ0VXJncSrYlNZP6ZburvwsNeZaozqxBYfReyGd39A
         SZVsiWH4w6oNmmahsZIsrggt5g2StiVPuvgDDQfYcIv1HvwzDqPBthaX/Ch8RYuLLhuU
         Qxti2TZO7NUOHCVnXSD6S4rG/fIPs00FpbYIE2mRKnM2wBhXVvkegWE4/wmUUM3PB2kd
         RP8SeOwC5OdtNRlsUYZ07CEB7X4EECXccb8B2jE5FwInrg5yf1wSfgAhm0Fq9KVddV3E
         U8EHIDPR/LsrvsZlns+k1/WRbdE/pgl6rPiX0ufrclN/VoCoxExiQ9+iXrPY//Mbc34J
         43fA==
X-Gm-Message-State: AOAM531BBLZrwqmaDz2wmxJCIX9chDtxuZPnvmG96Fc7nUqcU3vbqFu0
        zdjofT49hFReaaJOhwxZ7iyIwg==
X-Google-Smtp-Source: ABdhPJxWmquGX2AlNwP7evxcUuB0ncCyUmRSlZv3ZrizlgUY1viO7eBYNa4hsqjtUAoBAUpKvHg1DA==
X-Received: by 2002:a05:6808:1b24:b0:32a:effb:efaa with SMTP id bx36-20020a0568081b2400b0032aeffbefaamr3640630oib.141.1653437500279;
        Tue, 24 May 2022 17:11:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 184-20020aca05c1000000b0032698578409sm5726118oif.38.2022.05.24.17.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 17:11:39 -0700 (PDT)
Date:   Tue, 24 May 2022 20:11:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 2/4] builtin/pack-objects.c: avoid redundant NULL check
Message-ID: <Yo10OTRmytLM21o9@nand.local>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <2719d33f328e03239cdb2f5cca2fef9a4e9cbb93.1653418457.git.me@ttaylorr.com>
 <xmqq8rqqfvwa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rqqfvwa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 02:44:37PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Before calling `for_each_object_in_pack()`, the caller
> > `read_packs_list_from_stdin()` loops through each of the `include_packs`
> > and checks that its `->util` pointer (which is used to store the `struct
> > packed_git *` itself) is non-NULL.
> >
> > This check is redundant, because `read_packs_list_from_stdin()` already
> > checks that the included packs are non-NULL earlier on in the same
> > function (and it does not add any new entries in between).
> >
> > Remove this check, since it is not doing anything in the meantime.
>
> Will it start doing something soon in a later step?
>
> Oh, did you mean that after the earlier for_each_string_list_item()
> iteration over include_packs that died on an item with a NULL .util
> member, the code did not do anything to cause this second iteration
> over the same list to suddenly start seeing an item with NULL .util?
>
> I am puzzled by the mention of "in the meantime".

The latter, sorry for the confusion.

> The patch itself looks correct, of course.

Thanks.


Taylor
