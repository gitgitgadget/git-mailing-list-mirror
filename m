Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41941F803
	for <e@80x24.org>; Mon,  7 Jan 2019 22:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfAGWYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 17:24:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35864 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGWYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 17:24:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so2120789wrp.3
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FutSLc1ukbZlaBT9zXBXRneuUj2S4uueaWB8sEC8ebo=;
        b=JoN7AxBqmn6THbFy3AKKc8h3cnx2QRVB7atHnqEt5gZ0kuzs8L3bJq/v/v6hYXfh1s
         faYKQ0Geo+84TwpER3a9h9S9kOKO6PG//2mA4GCdMEO02iAJxniUu0SQEHSiVzAjUwdV
         c7/VEbSJxfrjUk6naKCJENMOcw0yLY44NUWV23xFsZoQBwOFmdJ9zRVZOazdKVR2yVoB
         Dp3/swyoxm8GR/aDvk/qg/NS6fnyVGfHwXDaw/luZyNX0lCgNLJ3BtGGfN13yY6XCJgP
         Bp+Um3hvl/BaTRF93jEYE+JF2w7C/6KqUBqQElh2J6Zh+ISPFlzrOZKwkSMuzjaCrobZ
         P35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FutSLc1ukbZlaBT9zXBXRneuUj2S4uueaWB8sEC8ebo=;
        b=o8F1HL9plBOl6xSDg9w0t9dPhu2qJLLeN2G2q25sKVLmgNOmECVPUbjh77q02GkqLR
         rFp40l7OSQ1qJFT30vBnfWHmCnET/eXUJLo7QirPLEt3yY4SwF6HiiBct6LED4QuufHq
         2BnZK13t0j5+1teeNx4z0HwX1XMU92u4f4MalZiZ6WIkc6K+KqV2QxweK045ydinYbGl
         7Tt8/69PYjmcQggUvLDTLTVeBYZbgooy/ePq2QD49ga0Z/PhaWIRI8HfrME2a77WJOKr
         Z1UpjGIjrPH8seXOBmQatLqGM8hghQ1bJfac+naH4dJWDf1rByyy8PmR0jTAqIDMqmKg
         s6oQ==
X-Gm-Message-State: AJcUukcJ7CoOKH7/9m0KFSUJ0luoQCDxfFrE7NvBKAjA0kjf7+05cfoB
        139I72lcnxlv6cNT8eTopSI=
X-Google-Smtp-Source: ALg8bN7Bp6l65mt6Pc1thlsVtSWO36QPVPaUxpc6Ui94NB1JwGVUoWvQW1IWlKdfiFQqu6X7dnXTpQ==
X-Received: by 2002:adf:9123:: with SMTP id j32mr56454690wrj.122.1546899875244;
        Mon, 07 Jan 2019 14:24:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f2sm45909859wru.14.2019.01.07.14.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 14:24:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Peter Osterlund <peterosterlund2@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] git-p4: fix problem when p4 login is not necessary
References: <alpine.LFD.2.21.1901072148380.20807@fractal.localdomain>
        <CAE5ih7-qFrYXfsWr6MebSFBtDERLKGf0zb73yaV6Eit4PJHcJA@mail.gmail.com>
Date:   Mon, 07 Jan 2019 14:24:34 -0800
In-Reply-To: <CAE5ih7-qFrYXfsWr6MebSFBtDERLKGf0zb73yaV6Eit4PJHcJA@mail.gmail.com>
        (Luke Diamand's message of "Mon, 7 Jan 2019 22:05:32 +0000")
Message-ID: <xmqqlg3w6r8d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On Mon, 7 Jan 2019 at 20:51, Peter Osterlund <peterosterlund2@gmail.com> wrote:
>>
>> In a perforce setup where login is not required, communication fails
>> because p4_check_access does not understand the response from the p4
>> client. Fixed by detecting and ignoring the "info" response.
>
> This is caused by my earlier change in this area. I think this fix
> looks good, thanks.
> Ack.
>
>>
>> Signed-off-by: Peter Osterlund <peterosterlund2@gmail.com>
>> ---
>>   git-p4.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 1998c3e141..3e12774f96 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -332,6 +332,8 @@ def p4_check_access(min_expiration=1):
>>               die_bad_access("p4 error: {0}".format(data))
>>           else:
>>               die_bad_access("unknown error")
>> +    elif code == "info":
>> +        return
>>       else:
>>           die_bad_access("unknown error code {0}".format(code))
>>
>>
>> --
>> Peter Osterlund - peterosterlund2@gmail.com
>> http://hem.bredband.net/petero2b

The patch was whitespace damaged, but for a two-liner like this, I
can type it myself instead, so no need to resend.

Thanks, both.
