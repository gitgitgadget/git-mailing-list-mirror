Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C782C678D4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCAVgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCAVgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 16:36:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D515632524
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 13:36:03 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so656014pjg.4
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 13:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzjRjp0fouA+qtiHmDAtaja6BgpJZyWe+IP3opo6Pus=;
        b=EMlcpYJvI4+tGDS6zG2UduGC3+qIETmpi0TaJdbtY20ENJ+nbb++WJi0gRxQgyxj/L
         Cd70/V+A3e4/tn2d19Z+sh/v1H68vKdlBx8L883JO4PLePdtNt+kD6d6SycfHIYrDp+f
         vPddpm6v3IAvNK7aQpsfjsda80afB/3zUuQ4mMNn2++wbHYzwo+T2Xiir55vfXIeNGGx
         18jWcIrlLxXnF05btBtLOmMeRV5Oo05YHOzDftGb/qTxlMmkz0FNo981W+LmAvtdq+cc
         u49Ln21x0BHqBrBEgX76jL9GsW65Vr9tGUKd4PqfNWhgOFSkgI4uNPPaTvxuvjBfDRbu
         zB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzjRjp0fouA+qtiHmDAtaja6BgpJZyWe+IP3opo6Pus=;
        b=K4CDWhxKT2jMxGVBG53paEiKuUM+u3WAp978qLqd+0Yx2Ephxf4j/wExdMqkR4BFJv
         W81dk8Ax/sWtlpTjLBZjvd1U0PoD/buMsVGgzoA5jMKGJvsG/iwHq9KXnGpSXNkK84BU
         CkgYuU3el/Ougvu+T2oQzMzp7thKyT59Ch3M54RuPbfJ/IPf9pQpfPcwfUWy6rVnstAJ
         O97UGDAspUn9AT+TXOz+Hsrnjx+YVV25gr8A6gLgkMbaMJmZE6XDc090oHx1ykZc19QD
         xNfALYK0CfzyQzHx9LT9tGA/pLUdx9n5JM8N52U9p2eKwRebSNDozOmlvqpoh2RqDo9t
         6WeQ==
X-Gm-Message-State: AO0yUKWhlzB/l0dkwZWxba+KW71ujptMuHwz8tGzuieMOv+QWrDvaVi/
        Sh4IqRsDPK0hceN7nH8zG8c=
X-Google-Smtp-Source: AK7set/x3fGidX3jId6FNVWxyssuf7IvSB7/vkUCo2+V78BEjHJI5X+jD4r7uvxvKG771EFLHkEupA==
X-Received: by 2002:a17:902:a511:b0:19c:eb50:88b9 with SMTP id s17-20020a170902a51100b0019ceb5088b9mr7186976plq.29.1677706563182;
        Wed, 01 Mar 2023 13:36:03 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b00199536fbc6fsm8885361pld.280.2023.03.01.13.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:36:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: t3206-range-diff failures on non x86 arches
References: <xmqqilfknzen.fsf@gitster.g> <Y/+paI8WGSmEbv/w@pobox.com>
        <xmqqv8jkmea1.fsf@gitster.g> <Y/+zwrMBvoggqaL5@pobox.com>
        <Y/++KovrW+08XRQc@pobox.com>
Date:   Wed, 01 Mar 2023 13:36:02 -0800
In-Reply-To: <Y/++KovrW+08XRQc@pobox.com> (Todd Zullinger's message of "Wed, 1
        Mar 2023 16:05:46 -0500")
Message-ID: <xmqq8rggm9x9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> I wrote:
>> Junio C Hamano wrote:
>>>> On Fedora, rc1 fails most tests in t3206-range-diff.sh on 3
>>>> of the 5 supported architectures: aarch64, ppc64le, and
>>>> s390x.  These tests succeed on i686 and x86_64.  They passed
>>>> on all arches with rc0.
>>> 
>>> Sounds like something d9165bef (range-diff: avoid compiler warning
>>> when char is unsigned, 2023-02-28) may fix.  Can you try merging it
>>> to rc1 yourself and see how the result does?
>> 
>> Oh, indeed it does.  Thanks for the pointer.  I'm running
>> a build with that now.
>
> Confirmed.  That fixes the tests.  Thanks!

Will merge that fix by Réne down to 'master'.

Thanks for promptly reporting the problem and its fix.
