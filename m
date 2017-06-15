Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7D3720401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbdFOVkq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:40:46 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36259 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFOVkp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:40:45 -0400
Received: by mail-pg0-f54.google.com with SMTP id a70so11930740pge.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hfI12wCS2hl/oW37GSkpfk022FjvzjqkTK3OZmGApHY=;
        b=W/miIn6654l4M6Ag8kvARCoLVfRQ4U2QFDamJPNJu2C9WGujy5CLueFiPCf0Axj9eo
         W84ycau2uYtfgbw8c69OFiaUMDybZOu1Elrd9NJcxgShTEt3oKdONlr5AfqQPmeHvxbO
         VVHM0Nzmd9od9OxGcuBkOHy18ubMKC3+1Wg/UfkJZEcXA1/Z4GXSkrZgcET3WdECQaC/
         LcSIACbDOgC7Giyh14vvPTJFqmNToC1Rf2aQXh6K37rLeGsoryDMS5S4ELwoclqDSgbU
         HuBTGA9m/LCIw5q+apZ/ZLYErk39W3bT0gtI8VrHN3UND3O3hd5CF14hJncnFJMYewmk
         murg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hfI12wCS2hl/oW37GSkpfk022FjvzjqkTK3OZmGApHY=;
        b=LAovP9PCST57QZqDKwZaMxMahro7XUmCOOM+3x8wscCu/KWGbuhkqi4nw/rINPyI7H
         vwNnlx8pgtMr5+VgqNMBX+MgQkpIrNotMZo2mrxhGQWF2OE1yoowo/CkNyauL/Izmwkd
         WmxQ5dvoXzRcyJ+SsILE7vxf5KxsHUTek6Y99euhp0HCHjsgs8Icq/5iqSmPvRUS21d2
         YaxktkAkEFedA9L1FVFFhoexYBL8EfxBYLzgcDDUtTZdDotkjPYPYthqrvSAjEgKcK0b
         Q5ggbXZ8UGgh4lfbFhRtr1BwIT3MjsCXmV7SDOlj4fehqyYVvAsqqj9ZXnDcUobCTZaX
         upwA==
X-Gm-Message-State: AKS2vOzvDweysrCKNmHaXknsKHa2ODl21DIDWjQLvgLP4f6RL8DVPHKB
        7rWsAwxGVxSq6g==
X-Received: by 10.99.124.91 with SMTP id l27mr7665642pgn.122.1497562845096;
        Thu, 15 Jun 2017 14:40:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id q6sm376296pfi.129.2017.06.15.14.40.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 14:40:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Ulrich Mueller <ulm@gentoo.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] date: use localtime() for "-local" time formats
References: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
        <20170615135216.2jfsrjpicku6zxv3@sigill.intra.peff.net>
        <b79d1c3d-e43e-a82b-2d33-2283cb0aa5ef@web.de>
Date:   Thu, 15 Jun 2017 14:40:43 -0700
In-Reply-To: <b79d1c3d-e43e-a82b-2d33-2283cb0aa5ef@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 15 Jun 2017 18:12:31 +0200")
Message-ID: <xmqqinjxylno.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 15.06.2017 um 15:52 schrieb Jeff King:
>> But for the special case of the "-local" formats, we can
>> just skip the adjustment and use localtime() instead of
>> gmtime(). This makes --date=format-local:%Z work correctly,
>> showing the local timezone instead of an empty string.
>
> Documentation/rev-list-options.txt should be updated to mention that %Z
> is passed to strftime in the local case, no?
>
>> The new test checks the result for "UTC", our default
>> test-lib value for $TZ. Using something like EST5 might be
>> more interesting, but the actual zone string is
>> system-dependent (for instance, on my system it expands to
>> just EST). Hopefully "UTC" is vanilla enough that every
>> system treats it the same.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I don't have a Windows system to test this on, but from the output Dscho
>> provided earlier, I believe this should pass.
>
> The first patch applies with some fuzz on master of Git for Windows, the
> second one applies cleanly.  A "typedef unsigned long timestamp_t;" is
> required to compile it; such a fixup won't be needed for long, I guess.
> t0006 succeeds.

This time, I'll do s/timestamp_t/unsigned long/ while queuing ;-)
Of course, it needs to be converted back to timestamp_t when the
topic is merged to a more recent integration branch that knows about
the type.

Thanks.
