Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4082C209FD
	for <e@80x24.org>; Sun,  4 Jun 2017 00:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdFDAvF (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 20:51:05 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33766 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFDAvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 20:51:04 -0400
Received: by mail-pg0-f44.google.com with SMTP id f185so6367413pgc.0
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WSDJnekNi0mGDrWR7FVNiGqzoCVAHq9n/PFW+90gOUg=;
        b=mZVmgOw/n4m4ysWjRuSn5dJPJ4dAGwMbIl4cF24L7k8C/qTDqjANfh4PXHZ20Dq5CZ
         fT43Q+L6KAzfR/SjgS0Vho0MAkTpeV2/cOlqxRsiTwDRpJLxAoYSluKaQVEmWEQ03UC5
         V0gH+rs50BpV4Ane4XaWNexI8MlmlefLp0x/hShoTpCn1OAxuj2u3n85a4c6Gr/1M8pI
         5ihy+G0DheUQxtOg0Ana25wjBFqZN7+HyJCE3ogYmzlrqgQxzTJQwFWawTo7+CTCInHB
         vwjVmSWt79crnW0L/+NWMDAr5mUE6DDGUh7ZXJ6Sg83LoxOLf9n2SOVpR9n63qXlNGEy
         VxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WSDJnekNi0mGDrWR7FVNiGqzoCVAHq9n/PFW+90gOUg=;
        b=ayzJTwC4tLtVq66F3XwiJsKHPsR2OZUqh13wIbgXLdnnHGMSC0oefA9/CPphn17SVZ
         oi2b4VkhnHpys3yX1bmBM2tLPz0DOYu4YAtZdYu2qv6pWgdahVrPBC3qAwRsloBc0hK2
         CNqfC/8/gyHJx3TsaVWP9D4C7QBHkYXS7ba1q/1Bul6g0ttDpXO/NGon32cuKu5zHwQK
         OTWgU2XuHYpZXAbm1X2A4rt4EXrzo7uMyKO9Rgq06bwNF3tjEUPpPyxS9BYSfFgRPuQ0
         S/VfKc6n8Z9+debG6SZHchFyKiwGcXUYirjOeJmPismcSztaS5VVm/SnKoWZ5F01QX1L
         mfOQ==
X-Gm-Message-State: AODbwcDqsX8ji3Onp+WnnpPPynfTRHTjAruXovyUhoa8UMBrf6MH9HxA
        +tNmm6IOAkYHBw==
X-Received: by 10.84.135.129 with SMTP id 1mr7239831plj.57.1496537464177;
        Sat, 03 Jun 2017 17:51:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:e94b:f1cf:5772:ec43])
        by smtp.gmail.com with ESMTPSA id 138sm27072349pgg.67.2017.06.03.17.51.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 17:51:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
References: <20170602103330.25663-1-avarab@gmail.com>
        <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
        <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
        <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
        <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 04 Jun 2017 09:51:02 +0900
In-Reply-To: <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 04 Jun 2017 09:00:28 +0900")
Message-ID: <xmqq60gcwp6x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps run "fsck" and "status" immediately after copying to make
> sure they succeed, or something like that?

Hmph, this is me half-being silly, as this "copying an existing one"
is meant for testing Git with a large repository, and having to run
fsck may add meaningful overhead in addition to the actual copying
in the set-up procedure.  I do not offhand think of a good solution.
