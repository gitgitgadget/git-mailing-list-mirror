Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1661F403
	for <e@80x24.org>; Fri, 15 Jun 2018 19:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966139AbeFOTmP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 15:42:15 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:56011 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964930AbeFOTmO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 15:42:14 -0400
Received: by mail-wm0-f47.google.com with SMTP id v16-v6so5159564wmh.5
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=A5DAmopoj2luw2s/zgt0rjntttZHtYH5MdKKr2gb6f8=;
        b=BO5HViHUBf1llKb1N3Ecs+H3IYghY14JVQK3aMfmTccfytGJtkM4Zc3LeD+nqbC9+/
         auvs2NiaBRy/xBoLtILJqOP0pgCyRA6JXHU5EnQGHMfKEFa4mMGucIuegfcENH8appgP
         XQw9GddzVQBRKwpLTGAPABICrhN7hx7pbsxfhUSRogag3Bffx3FS/2h2EaX23KhsNKJX
         svGHv5kalSg96BC9EYVrLkTjvqZaHXcA+xmHxS/jAvvxUWAz9vnEhQeagQBQrct8JiCU
         v5DLxZY0Qwtur+raHD1/wWpqOhvgYOatBbXpvnQcqSlP5O+af9/qMiX5v3g3IYnxV+9K
         omWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=A5DAmopoj2luw2s/zgt0rjntttZHtYH5MdKKr2gb6f8=;
        b=SIUGlFA+pRfA3M4wMOlYXZ8fw7mUefuswcM9qDPlB2Dqo9kZ6ymgSelOu4qCqM7FTT
         gUzNIMXT0+CUpHFfUByAjLaD1djDkziNOk8jRmPuIGmdyPFSb28Bkn1OKE0qmLNGQV//
         64JaVWtTfTPauV+O3sPcCuy7ZTOvsf5IBZEOX5YsHXqtK9SU2gBt/u/l52LBdUTEi6c4
         tmRuQA5Vu2agZOXm/vyGjviotTY7DsuYP/ezGmU/FzNxdozQYEXQQtTD1A+dH0nymbdG
         rrscGzP9NRiZhMdBb40ren68DkQMj7G/l4HJjQoSIjBfMKhBKYwomzvOFqCi0t3bsYq0
         3F7Q==
X-Gm-Message-State: APt69E0em5ZhKZIKmlS437rvXLhEc7f9jJ6RHVAcs0aVkIizz9TS0jE3
        EVc0IH7zAjpLxeEDLuvAqiM=
X-Google-Smtp-Source: ADUXVKKEpk9zOkmRxewbO5OYy1L1WoOgLoHUVPlDotx6+/kFXMS8GJniICFXzIkDXxW4wtJRFdrwlA==
X-Received: by 2002:a1c:8647:: with SMTP id i68-v6mr2241544wmd.28.1529091732711;
        Fri, 15 Jun 2018 12:42:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n71-v6sm3090126wmi.14.2018.06.15.12.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:42:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Luat Nguyen <root@l4w.io>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
References: <20180615032850.GA23241@sigill.intra.peff.net>
        <20180615033112.GA20390@sigill.intra.peff.net>
        <20180615091432.7155-1-szeder.dev@gmail.com>
        <xmqq602k2f9o.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjnZXfaNskiba9VsFWwwOx_kvGxZDY_AiyQv8L6gCPX4Fw@mail.gmail.com>
        <20180615172121.GA3067@sigill.intra.peff.net>
Date:   Fri, 15 Jun 2018 12:42:10 -0700
In-Reply-To: <20180615172121.GA3067@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 15 Jun 2018 13:21:22 -0400")
Message-ID: <xmqqwouzzvjh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 15, 2018 at 07:10:28PM +0200, SZEDER Gábor wrote:
>
>> > I said "yuck" because the original does not work if there happen to
>> > be more than (or for that matter, less than) one '.bitmap' file
>> > there.  But at least as long as there is one, it should work ;-)
>> 
>> Well, the test starts with 'git repack -ad', so there can be only one
>> bitmap file.  (Unless something is broken, of course, but the second
>> test would catch that much earlier.)
>
> Right. I almost put "head -1" in there, but we know that we just created
> a single bitmap. And my thought was that if we don't, the test would
> blow up horribly, which is exactly what you want.

Yes, and "file=$(ls gl*b) &&" breaks if there is no matching file
(iow, I said 'for that matter, less than' which was incorrect), so
the original is OK in practice.

Thanks.
