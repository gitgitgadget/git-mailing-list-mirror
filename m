Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70F1C2BBCA
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 23:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B1822573
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 23:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgLOXIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 18:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgLOXHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 18:07:46 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F03C0613D3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:07:06 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id w1so25406667ejf.11
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=to8oowKGIwd7Q8ayZGQHM7NyA9w5uaQxP6CeKwgkZsQ=;
        b=NVDQt8LssusxY/0tWhmXCA60sOloaWjPAhG8PCKA2NMRQ0tnJvMrlyTjZLzRPcEdY0
         lhHhW30Q88ky0Apmdier9vI+ZUyxHgL+RYSXXJ59nQpIXK0v8zxu4o0aWJIDX8qETQH6
         GzbwzOwyDZTOvFD6itOpIAlVIm9fmOCxjhTyd4NNgybEx4k6e0K5XPBLqBQYAi3+vX0l
         GpmFQntVe8S9u/hSO52JCab5Yfkbk8YkDzD00RJJ6LTKaexAun5t+dC3KqVtVb9pDNHv
         EC/oKH3SrmIaL8B0Y7JSApR8gMPobSBuqSeRZDX+Q9qrcQw/h8DxNdtCALO26mlqxQ+N
         7ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=to8oowKGIwd7Q8ayZGQHM7NyA9w5uaQxP6CeKwgkZsQ=;
        b=Q/VGjfS+V7iRJZtR30wvBvD9GfU6t3rjq0DY0Yw3ebFTcdnJfnVS4JMt1/sI9Ib7hx
         yMs6++vLzg7eqsxfAnH3wyDrtPSyLBQINrjP8uJ8KVrZrENTmuvye1bL5n5Vxvfh0//r
         WXG0iKmNN22sj6Yp7Aypo3DdO4PKXiHCa1Jy3E3qM342/Je+jN5pkxh9MEhfnwIFzZ9Z
         C6fz+LkkhfyUq/8Oosk18ucMZh3CacG2B8PAmLddOyEBKS0MM/YevcIi8q/uP5B/W731
         B0vMSO3Mt2EqXTafC7YoWJYUIDp+hIF/0ij56LmjSVqZjDKt3C6Y5MpxVC+yLX9WeUsB
         M0YA==
X-Gm-Message-State: AOAM530/UrRZlgVLJDN9FzUUQruHeIawPicmY2ehCMHXbvpnaBM8jwi5
        MQISX3iQGzqa6Abo0x3AEkc=
X-Google-Smtp-Source: ABdhPJxll39CC7jlXSh2gg3MbohURuPH4aF7xFqvprrR6HV3KOXXHUYCp2vxJQ/2FFZuvHIXTBqiaQ==
X-Received: by 2002:a17:906:d81:: with SMTP id m1mr17620138eji.550.1608073625128;
        Tue, 15 Dec 2020 15:07:05 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id t12sm19423210edy.49.2020.12.15.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:07:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] refs: warn on non-pseudoref looking .git/<file>
 refs
References: <20201210125321.19456-2-avarab@gmail.com>
 <20201214191700.16405-3-avarab@gmail.com>
 <xmqqczzcatyr.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqczzcatyr.fsf@gitster.c.googlers.com>
Date:   Wed, 16 Dec 2020 00:07:03 +0100
Message-ID: <873606wtwo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 14 2020, Junio C Hamano wrote:

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Modified-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Huh?

I think I was using that to test my %(trailers) patches & didn't
notice. Sorry.

As for the rest of the feedback thanks & I'll address it.

I'm planning to re-roll this but given that we're in the rc window & the
time I have to re-roll this in the coming week(s) let's put this series
on hold/eject it (in case you were planning to put it into "seen") until
we start post-v2.30 work.
