Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE359C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 05:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiCGFiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 00:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCGFiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 00:38:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA75EBF5
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 21:37:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h13so6145748ede.5
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 21:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAaE8G8sC0HyFcp5/yJ2v4vyp/vh7GjaT4Zg3wUZecM=;
        b=yNmfbDoOXXvPrVcZNR0c70pg6e98o8VgY4C2Jw6RMfGszSS5bm7CS4MJdylFbiBbzt
         WOml2ZZXLGSGKygXErrYjx0DSbTUnbsc1sMnY701j1FMnkir7BCVvtwPiPKXql6VhjWA
         OHnEiz3GM0czojj/vdxrBOdUIMSmKjwNC+Up7E5lgZCTOyD+KPrL0vhJhmcmOGycGoZ4
         co1mvVQv71VVgmHlVlpfXActXY+2dGJjlwhXcJNW90wTZqIo5duDB6cAsmz30kGt8BU1
         BU4SEBYqw9pHPcFDBah6xkhSslfcC52n0zqRy3nlv5IzxHbUrKpkDe9fRHR1P3VPaXqI
         kQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAaE8G8sC0HyFcp5/yJ2v4vyp/vh7GjaT4Zg3wUZecM=;
        b=VRxHbqX3h+wvN4h6Rd46SsADbKMJ8FhypLtR4a10IHShF38DuWg4lHikNhr80yUg5Z
         pDFmkxeuxTf0KaPxc//TbQYDc5Zok4L961yh1xhM//ZPfkL/uZr4JKEfg5k1ROmHJOMM
         vFZKbCHYa2id6dmeNAC3qmK2LlKvi6xh/eRIUIvIXWM/xKwbxxB8HNqa3ZVLizAhy3Pk
         oFl+9NvIYMjBKAt+vnST+31UrbbOZf8Y+m5mYaKkAyJIqkc1or7nkseUGyX9mqEDqsRS
         e0G0kUoqVJR8GH60ARqNsk3iKRw/ec+vkTyYuSuISMDdt0CvOLxGcrtimxtTZxqlv7ZP
         E6Lg==
X-Gm-Message-State: AOAM530q2161RAl/Hye1nl45X+GOKFkqv00saY7x1vOpOmCM68T1eQpo
        e/nM6vwOEm7Na0bzZAdo5WgX4xCGA0g3GxdHwj15w2RE9I8=
X-Google-Smtp-Source: ABdhPJx9NZZb5RIdzvwadezAluZOwPacQXZ0iizft0Dwa0f/A+jIrIMAFMclOHGauGtjkryo2RqhAOljVSQgIU1ZPrY=
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id
 l19-20020aa7cad3000000b00410b188a49amr9599972edt.416.1646631434252; Sun, 06
 Mar 2022 21:37:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
 <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com> <CAPMMpogoVzHBh8j4GZG-tRpAxap4wY+hAray5V_QUcaNpf7dEQ@mail.gmail.com>
 <xmqqv8wqvj54.fsf@gitster.g>
In-Reply-To: <xmqqv8wqvj54.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 7 Mar 2022 06:37:02 +0100
Message-ID: <CAPMMpojOrnSRQgA51+O7wfc3tGFO8w9mtejw8i8h1MoA5WvS5Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Reduce explicit sleep calls in t7063 untracked
 cache tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eek, my apologies. I will remember to check that!

On Sun, Mar 6, 2022 at 10:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > I see that in the latest "what's coming" update, this patch series is
> > listed as expecting reroll, but as far as I can see there have been no
> > comments since I sent this V3 out.
>
> I see <v2> reference on the source: line for that topic in the
> "What's cooking" report you are referring to, so I suspect I have
> been too busy and haven't got around to replacing it with <v3>,
> perhaps?
>
