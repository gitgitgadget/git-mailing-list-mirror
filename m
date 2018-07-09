Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33D01F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 16:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbeGIQdV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 12:33:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33078 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQdU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 12:33:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so11402923wma.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mV/rQCLA/TWSRFK/shPjTkCZANlF5+0tcM5Mq3jVpgE=;
        b=LCOX0RCeIhxVijgWRj5tb/pA/ba2TxpdyU4uEs43bBUR8mBjCVdUR5AWzoLOPjOwMh
         mT5b6vKgL6xMGboQiJHZVyneCeEOXZS+t9JW35R8bzs/MCVfWTMyLynF5UsymAiSQ/IA
         BW0aLDH22AmPWs9Ffi+WdhPRR/8iH1LR8HhO9k/NM6S8G2yVTEUBTN+X1gr3a7a3q0El
         RbWRz9c/yX0KAkEogFdUBIleDQuIS7ssdW7bVe3GN4tTk9Mf9ss+Jy2pfVe5/1Vh3PQP
         tsDOWf9mb+bMU4xVgdF197iXG7FEoPrB1OKJCCyhuMwADRVQNxVLt/t8BAHsaymvWkYf
         9Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mV/rQCLA/TWSRFK/shPjTkCZANlF5+0tcM5Mq3jVpgE=;
        b=jCzxtjhSsKPlfZQGHoBNs7Caab44JmrdEWm1ofzUFZILexnMDTRL8GrG69mkjXgAh2
         DUpeGxQ36iOPJVQdEHxNBKu853pgB5hJwhurBAC62kWzW7dj0jvj6ASqHfSxk0zVEFiX
         QTg6W0ORXXdCkkXAXrTqTgmfcL5++eYIH//PVWOOer8mRBBGJyV0FTcqo7qr60RBXSIh
         +yocQkQXQf/DsM/bNlJSGPMLA+INmALQf8Ef7/wNkLOAfIg1I/nEolfybt7wwo2F/ZSS
         qtRitp3CsZI8aIlvelUz946IIJoHvMPhKIhUbATdv2JVJLdwogTOPrpIRM275kQ7Gmt/
         ocIg==
X-Gm-Message-State: APt69E3uylvCAjtjyd6YAPiazr5qLayOi/VFAVdeYF/+rZxa2n3xygwN
        wZxcoPwRla4rXuJbYvlRBMg=
X-Google-Smtp-Source: AAOMgpftYRlQO7alQJtEfOfGqqdmwEZs32zJjPS2UDiKjnKCjigCA+tWhFlZDLZyEJhJuQ/fvIT9BQ==
X-Received: by 2002:a1c:6902:: with SMTP id e2-v6mr14090724wmc.95.1531153999322;
        Mon, 09 Jul 2018 09:33:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f190-v6sm32749223wmd.0.2018.07.09.09.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:33:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] utf8.c: avoid char overflow
References: <20180708144342.11922-1-dev+git@drbeat.li>
        <20180708144342.11922-7-dev+git@drbeat.li>
        <nycvar.QRO.7.76.6.1807091513130.75@tvgsbejvaqbjf.bet>
        <0ceeb342fec1d0868b81cd64941df53c@drbeat.li>
Date:   Mon, 09 Jul 2018 09:33:18 -0700
In-Reply-To: <0ceeb342fec1d0868b81cd64941df53c@drbeat.li> (Beat Bolli's
        message of "Mon, 09 Jul 2018 16:48:28 +0200")
Message-ID: <xmqqd0vwfjxt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

>>> -static const char utf16_be_bom[] = {0xFE, 0xFF};
>>> -static const char utf16_le_bom[] = {0xFF, 0xFE};
>>> -static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>>> -static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
>>> +static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
>>> +static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
>>> +static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>>> +static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
>>
>> An alternative approach that might be easier to read (and avoids the
>> confusion arising from our use of (signed) chars for strings pretty
>> much
>> everywhere):
>>
>> #define FE ((char)0xfe)
>> #define FF ((char)0xff)
>>
>> ...
>
> I have tried this first (without the macros, though), and thought
> it looked really ugly. That's why I chose this solution. The usage
> is pretty local and close to function has_bom_prefix().

I found that what you posted was already OK, as has_bom_prefix()
appears only locally in this file and that is the only thing that
cares about these foo_bom[] constants.  Casting the elements in
these arrays to (char) type is also fine and not all that ugly,
I think, and between the two (but without the macro) I have no
strong preference.  I wonder if writing them as '\376' and '\377'
as old timers would helps the compiler, though.

