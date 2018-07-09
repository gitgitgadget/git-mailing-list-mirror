Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702201F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeGISSP (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:18:15 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55553 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeGISSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 14:18:14 -0400
Received: by mail-wm0-f42.google.com with SMTP id v128-v6so4514540wme.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W8SYF2qFfEKlRLFFqJJLJZDZZNUM6HGc27UEpTwJQD0=;
        b=qqhhKb8xm0E65Usx2IhCD0fnQnoabum2/DoVH1Ov6WDiFMk9p28AoGwnXCYlLNpSv9
         ThphjFWA7s3bgT6axGzwpzTRQtS4OK/2J3QzSIOXIwo2UMQsSZMMNerVu/a7a+bbeYl2
         AwjRt8SVEKVmLctEVFoW43vfRXsrqbA+OoPO2JJnuh6YNrDtoRnNFebSMiu0eVLtEEc5
         MBKvI/vjVefVcODVyj3MKRhJ/o8es9bR1Rfq4UReAsLslNUiPnpYnoICMpnxam25V1W1
         09r6+1qAchLLIc3V+qRSpaZZmBNURNgNzVWQBrLHIfTi9jl2IcY9qXo4OFAtHcsiLyZ7
         uF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W8SYF2qFfEKlRLFFqJJLJZDZZNUM6HGc27UEpTwJQD0=;
        b=cQG2VPystOB458TsabpNtJTTNccOvDOslLo0BhAnVOiwtnOSZkWpLqExAt4nh2yVGB
         3S+jHwdV/9/ml0dYUbzmPGaoxxLEaOxG4p7sSrbHo2l/bm11WGsGlxshitXZhSjHfhsG
         xlaepZFoo5B13ohNQNi4Ol0/Dn/VQ7vqyYDZhK2kb6bNZwCZWOP6CXeuF7dQfG5asMza
         vGjsPrr+eKGOjqvmZPb7yWlFcb5JgBhS0yrevf8+F45KEyWRwrMfNPKdPFVNcw9RsE6I
         9am6X9t9n1DZxx9jgvjPtejBhkqDPbP7YWhljX+Ns4pyQranaVnZMm3j4BJOyMrKu86g
         aOwA==
X-Gm-Message-State: APt69E0WRQ1v4rYY2rihwxKtff4PMg8+6JYweDihFx5Z4uansB8jupbg
        6WIVSBKLfcoA7FxhGErbDLajMVfo
X-Google-Smtp-Source: AAOMgpcWssyty7q8j/jcPmj8NG4wkcU4Xd2K57qBdi7GZGYCfmmqUqErzjCvbOD0AO2y/CDCxihlzA==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr13604385wmf.93.1531160293246;
        Mon, 09 Jul 2018 11:18:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z5-v6sm9479454wrv.2.2018.07.09.11.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 11:18:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] utf8.c: avoid char overflow
References: <20180708144342.11922-1-dev+git@drbeat.li>
        <20180708144342.11922-7-dev+git@drbeat.li>
        <nycvar.QRO.7.76.6.1807091513130.75@tvgsbejvaqbjf.bet>
        <0ceeb342fec1d0868b81cd64941df53c@drbeat.li>
        <xmqqd0vwfjxt.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 09 Jul 2018 11:18:12 -0700
In-Reply-To: <xmqqd0vwfjxt.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 09 Jul 2018 09:33:18 -0700")
Message-ID: <xmqqd0vwe0ij.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Beat Bolli <dev+git@drbeat.li> writes:
>
>>>> -static const char utf16_be_bom[] = {0xFE, 0xFF};
>>>> -static const char utf16_le_bom[] = {0xFF, 0xFE};
>>>> -static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>>>> -static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
>>>> +static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
>>>> +static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
>>>> +static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>>>> +static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
>>>
>>> An alternative approach that might be easier to read (and avoids the
>>> confusion arising from our use of (signed) chars for strings pretty
>>> much
>>> everywhere):
>>>
>>> #define FE ((char)0xfe)
>>> #define FF ((char)0xff)
>>>
>>> ...
>>
>> I have tried this first (without the macros, though), and thought
>> it looked really ugly. That's why I chose this solution. The usage
>> is pretty local and close to function has_bom_prefix().
>
> I found that what you posted was already OK, as has_bom_prefix()
> appears only locally in this file and that is the only thing that
> cares about these foo_bom[] constants.  Casting the elements in
> these arrays to (char) type is also fine and not all that ugly,
> I think, and between the two (but without the macro) I have no
> strong preference.  I wonder if writing them as '\376' and '\377'
> as old timers would helps the compiler, though.

Heh, I should have read the remainder of my mailbox to learn that
you came to the same conclusion in response to Dscho's comment
before saying the above.  Hex is OK as all our compilers would be
capable of gloking '\xff' (there is a rather unusual '\x20' already
in builtin/clone.c).

Thanks.


