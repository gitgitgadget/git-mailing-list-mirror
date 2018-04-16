Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FEBE1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeDPWoA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:44:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44491 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPWn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:43:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id u46so30260594wrc.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xTy/tehblWpoXPuFjsWPqxtyAP9RgR3yaL5tA6vOCNQ=;
        b=cWo3YrTNWXdfDOt+M1zFZ0M8I4dQBJewLuOa0msSOZzFyP2LOWcqEuIlDygUUXKb4C
         7oAg0GWzc0URf01ub1XFOiRx0F+nCD58kFFAqCIJX2MtLj2nskmKkccrX0Ca8YAyrpZ3
         5Bb6Fs1KRf0a3jFMIm/kvjxQ0arTnjs9XJ+/OBZES1nytWAX2B7Y9LGtdSnqwSfuYrM/
         Zg0PQSSPU03dcUt6MUye19gez8ASs1/UAg35B+/wyiDjVFB1mE2mB1Byvd+/WSqGym1B
         odDK3LWGvJOoMS6ODiq83G36/8oxkRHqu1BXpOExjJHrokTYAiiNDedX9/9Fr3d9boKf
         5+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xTy/tehblWpoXPuFjsWPqxtyAP9RgR3yaL5tA6vOCNQ=;
        b=Q2mOVCsE5D+d+eVg5tXjLkrbut8zc6UMdxHeUAw3hcE+KTYSKbh1IALU4KE8seKS2r
         6Mlw33+g8K8jueQUFFrh26m04VplLFIBo+79Da3ViqxoR0sIcI+uINWJhLRgXN7awz+n
         qPZTq6UKgm/pBp0OGoDZDlc3n34cYwKHeaah6TiOTaGhbY5ry57Ukh4Wm23HUeix+cpr
         b0Mo/jCZr8dnNxar1CSYO0rgiJdHeXAkzy5HIhLNUo3fhUO5FM7BjVrgFHUopdaW8+zW
         cGGFr0SPipcH0yU665qymu4WONEh8od+avsauQ4MYMwl2MCy/FFq8SHpXf/SKDrrUV1v
         yX4Q==
X-Gm-Message-State: ALQs6tB/6VUkPh3x40PnTCvMmPcFZfZURrH4npP+TFfqzGhIbndrFZtH
        GgjT4FZmGUEuZOEjG8EQD7s=
X-Google-Smtp-Source: AIpwx4/ns3EaWLbiY2Zpl7osPFAx9zV/QbS+mOt3SwGPuTwcJPB/0XDcqEhIq/7qMsFn0xM1uVYJvQ==
X-Received: by 10.28.231.12 with SMTP id e12mr66947wmh.111.1523918637978;
        Mon, 16 Apr 2018 15:43:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f7sm15977370wrf.95.2018.04.16.15.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 15:43:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
        <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
        <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
        <xmqq7ep7ybw2.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjm=jyetT9ucNbOYxQ19BGYr8nWzAi+WUnsHPuRTrSG9SA@mail.gmail.com>
        <CANQwDwf8sBFuKBXG6Yt5CH9+E2doqB6rB-_oQ4U7vjTOYBfu_g@mail.gmail.com>
Date:   Tue, 17 Apr 2018 07:43:56 +0900
In-Reply-To: <CANQwDwf8sBFuKBXG6Yt5CH9+E2doqB6rB-_oQ4U7vjTOYBfu_g@mail.gmail.com>
        ("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Mon, 16 Apr 2018
 15:29:19 +0200")
Message-ID: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> On 16 April 2018 at 15:15, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>> No.  'sed' would only need need help when its input comes from a buggy
>> 'set' builtin of a particular version of Bash from a particular vendor.
>>
>> As far as I can test this in Travis CI's OSX builds, ZSH doesn't seem to
>> be affected, neither the version Apple ships by default nor the version
>> installed via homebrew.
>
> That's nice - this means that the patch fixes all of the issue.
> The above information should be, in my opinion, included
> in the commit message, though.

Yeah, I tend to agree.  Thanks.
