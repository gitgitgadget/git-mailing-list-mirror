Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E9C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8442076C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxuqJhAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgJ2Bap (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgJ2B3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 21:29:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A137C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 18:29:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p15so1700976ioh.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 18:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1qKFFrlsdgMXeD6JRHR6f/xVn1rRaLtfgowyoWU6bAY=;
        b=VxuqJhAeVTpjMLU1pZwaJ5QT/pEeINQepddVungEpuRf44p4wanosnoZeFivc8dfUc
         bkng7wTyOILfCfY+DaVMy6sNxqJ03+QwdsE0j6YOSxSabLJwUlULrf8Y4VFqXcRkkre0
         F0WtUbDtUjhAvQu0GclMVvn4Z8KAqj9N0Ak9TBRLlUC40HfrliyqoeIW7mvi/xOYu8bU
         kEhytqpREKpjw6CO058P+pB6bUGCKiAsFthgnjy7lEsxHB9E5Uk88brDJ20tbFFO7KcU
         HncwMIBevp/is9K4lJjQiXJnxOiTjvU4MFHCaBVQtLaHg6ikzaKEfKmyOn619lj+9zF0
         8Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1qKFFrlsdgMXeD6JRHR6f/xVn1rRaLtfgowyoWU6bAY=;
        b=aHiQjxIEUzTV56Qw1vG7mzb+fgWOwxmXYCL3w5BPN/jxbK6K6nFj9Eil248OtJ2zPJ
         xV8ktKJ2wlbzL8e77VlkXYKvwoKQszqBFVPbobNfuHKyoW2MOAkWqPfrOpEb3i7bc/mf
         Z9TLjluWW0pWveaL6Z/qZmnfLVibV2hgGUXtchlMjn/UAl2Q5dpnJnkPVSENBIAh+1wW
         J/ejZuDU6d8hoUhdLo/snMwgqJ/GiJSR4zmdwRr+HkP12q0gHY4NaRKR0ZyFgrxdl5qG
         lc20EhAFW12lpliJyhFsx0cFkT7yhSKz6C3ZcbIXKBQDQ2+rFqmMBqTtmzRcpA22gzHk
         eJtQ==
X-Gm-Message-State: AOAM532Jyn62lLOahwwLRkgOSe5NBL5nWtjtxvq8JyuRouonz/UlqORU
        EBf91EGDLGKbL0G8FSFbWUo=
X-Google-Smtp-Source: ABdhPJx1t+mrxZFpgr25xRUcwUjFNWV/WoN9K95MN+zshLlfUUG6Wuqh1CvXQZ8qDKj0x2Uhnga6Pw==
X-Received: by 2002:a02:7348:: with SMTP id a8mr1655273jae.76.1603934952470;
        Wed, 28 Oct 2020 18:29:12 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id z9sm951951ilm.21.2020.10.28.18.29.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 28 Oct 2020 18:29:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 1/2] ref-filter: handle CRLF at end-of-line more gracefully
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq1rhi9jzl.fsf@gitster.c.googlers.com>
Date:   Wed, 28 Oct 2020 21:29:07 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47BFCD45-B3C2-4AF6-BE09-DA5E1BFAF5E6@gmail.com>
References: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <pull.576.v4.git.1603335680.gitgitgadget@gmail.com> <03b2d7d78a15d15130a68ed1e6092072aa0807cd.1603335680.git.gitgitgadget@gmail.com> <xmqq8sbxlq62.fsf@gitster.c.googlers.com> <FFAF7079-C759-43F3-96AA-CAF3B73B55B4@gmail.com> <xmqq1rhi9jzl.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 28 oct. 2020 =C3=A0 16:24, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>=20
>>> Having said all that.
>>>=20
>>> Here is how I explained the topic in the "What's cooking" report.
>>>=20
>>>    A commit and tag object may have CR at the end of each and
>>>    every line (you can create such an object with hash-object or
>>>    using --cleanup=3Dverbatim to decline the default clean-up
>>>    action), but it would make it impossible to have a blank line
>>>    to separate the title from the body of the message.  Be lenient
>>>    and accept a line with lone CR on it as a blank line, too.
>>=20
>> Just for the sake of searchability, I think it would be good to have=20=

>> CRLF spelled out in this topic description (since I gather this is =
what=20
>> ends up in the release notes). But I don't feel that strongly
>> about that.
>>=20
>>> Let's not call this change a "bug fix".  The phrase you used in your
>>> title, "more gracefully", is a very good one.
>>=20
>> It was your suggestion ;)=20
>>=20
>>> In the meantime, I've squashed your "oops forgot ||return 1" change
>>> into [PATCH 2/2].
>>=20
>> Thanks for squashing it in.
>=20
> Squashing in the "oops forgot || return 1" was the only thing I did.
> I did not rewrite (and will not do so myself) the proposed log
> message 1/2, which needs to happen before the topic can hit 'next'.

Ah! I thought you meant "Let's not call it a bug fix in the release =
notes".
I'll send a new version to not mention "bug" in the log messages.

Thanks,

Philippe.=
