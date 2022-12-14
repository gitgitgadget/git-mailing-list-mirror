Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FCDC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLNXLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLNXLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:11:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B9261A
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:11:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id fy4so8644371pjb.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLMrplptkFsrUo8q2FgQW/IEMprvs8i8urfDhlnosWw=;
        b=alIFmocQMF0iyZuEO195Fnx5MDM2tAojN4w6WFsLQfSNKb/XGv6yJ5FvtnE3W5M0II
         2p/ZlGia8dxTCDvVIMwW6Gj3VNT5Y25ELDr57wm9DVU7bZKEbNzrGCQlKV/aUoj1oaLF
         BWnvwGsBqw1qjG72U8GwJVgDyd2Bzx27P+sINulKEh66eTdJshZyI0EegROGYj4xNoYJ
         sPsZKypT4drw4k68LW2EkUPWGToiDgEcbuloHeT9yFlUFta7RodgndZsyAC5J7yOi4+A
         sRHiZt7jj78R5NNY+Z3hMz/sUHd/qvIMwjr9YW5mLDZglpsWZ6BNl4XQK1qsw4pdwXDZ
         x+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gLMrplptkFsrUo8q2FgQW/IEMprvs8i8urfDhlnosWw=;
        b=bqaI6f3MiW+Ut6elO1rQ6GIbxq5rvQIRk86p6ZEYnw08uB3KzVxCj6X25WdhXrFOiq
         IPPa0OJgh/qPq4hAzl8Vodd4PUEn8ZRDbiunycha6pho8i6Ax2HiBrHY40InPub+TELP
         UudNmJUiJtUeVkdKfsa//nQoXtcQR+OO6pvGGvKCdjkEw6f/EsayhOnIoqUqfFBKgR2b
         XIRp4Sun8+AfAZxhe/A0rVHR1/bw5rtTsmEFnnmsrv6ppdpXlppQd1CpH+62rk7Sf7UJ
         /4c8VIU0q68gYN7H17V1erWc47d35B8Ift2KYgB/wKVOg2/VoS5NGeuxFcex2USTIwxB
         TGXQ==
X-Gm-Message-State: ANoB5pnUkjX9SsS1u6X6cT4DrtsoHK6LojfQDyApNVkXMW7OQqKZLTDn
        qcNJm+eLCKE68A7NNVqRBAE=
X-Google-Smtp-Source: AA0mqf7P97Ejr59SiP23WxMC1jSt3fHXpydCEhycZLQ8bXxd/aNSAQsX1cb2J2xK3X9sIGM7A3wR/w==
X-Received: by 2002:a17:902:cec4:b0:189:eec5:ff71 with SMTP id d4-20020a170902cec400b00189eec5ff71mr40491103plg.44.1671059463277;
        Wed, 14 Dec 2022 15:11:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b00189240585a7sm2370287plf.173.2022.12.14.15.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:11:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Git List <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH] git-p4: preserve utf8 BOM when importing from p4 to git
References: <CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=LtovZvWw55y6eQqoRpaA@mail.gmail.com>
        <CAPMMpoi=6x5VbSh=Lkbi7WJKudGpQS2U_GnJk8GJi+ArJNp2EA@mail.gmail.com>
Date:   Thu, 15 Dec 2022 08:11:02 +0900
In-Reply-To: <CAPMMpoi=6x5VbSh=Lkbi7WJKudGpQS2U_GnJk8GJi+ArJNp2EA@mail.gmail.com>
        (Tao Klerks's message of "Wed, 14 Dec 2022 19:24:04 +0100")
Message-ID: <xmqq1qp1wph5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> Again, I'm not attempting to defend the breakage - just outlining why
> I don't see how "using the Perforce variable P4CHARSET" would solve
> anything.
>
>> This new behavior has made it impossible for
>> me to submit changes to files of type "utf8"!  Any attempt fails with
>> "patch does not apply" and the erroneously added BOM is the cause.
>
> I will try to understand the "unicode enabled server" behavior today
> or tomorrow and see what options might make sense.
>
>> I propose rolling back the patch that introduced this behavior,
>
> Junio is the expert here and has noted it's a little late for that. I
> obviously defer to his expertise as to git's release and backout
> strategy.
>
> I would like to have a go at understanding what the options are (how
> we can get correct and functional behavior for all users), before
> proposing a specific course of action.

It sounds like, if your conjecture turns out to be correct in that
those P4 users who interact unicode enabled servers would have
P4CHARSET and others don't, we may not need an extra configuration
but pay attention to the P4CHARSET variable (or lack of it) and
switch the behaviour.

Thanks for a well reasoned response.
