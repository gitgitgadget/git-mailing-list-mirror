Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA461F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935315AbeFMV4i (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:56:38 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44224 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeFMV4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:56:38 -0400
Received: by mail-wr0-f179.google.com with SMTP id x4-v6so4261227wro.11
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MaBlsn5hNzUpFCfdCHGj+A5BXhOc0sRtGAURkWU6wh4=;
        b=qdvB2byXKsiMlPqw4TSPsQ2zxnWPZ2kxDvV8/0/aG3l2+qn4zZ4ZKyKqh3emWlzfaR
         a5LyVpMsfT2VwJaCYefe/4xYCy7e3IHTsXGz0XOVmV3Acd8cCYtRpG8z2B+YmNox40E7
         kM1jaszS93UNQ34Iz2EFDte7Gm0ys/oCR1F6tteHX4+Aajj7iehPyYmN9drCGH+Ifu5g
         DlKfs77iS9jQt7fcAdUGLiBiwQk8pCIximW+XRdDldWhB0tnjM9thazXKTsogYTMuvFM
         T/0JWcC1EYa2ilDYDgc9DZ3IbvLVFOFokV/kAux7x4EBtqpWTv1nlVFhvd/H4JxVBOba
         GiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MaBlsn5hNzUpFCfdCHGj+A5BXhOc0sRtGAURkWU6wh4=;
        b=dSCPRcbgInZB1tLYzpO3BnEbwdIeuhw1RyvKkpug8fXMLiBAqFZhWsYUYJompdEbhJ
         LkAC2dtUTpn3rEHZaiLsx3WBeBZKEl/dqw2puwkaQRtPWKFy+mQhED6LrdlgjtjkbfVE
         Cnf4dZ9BnONovPazXER/ydWxtbD6r8jIOGMHuqyo9euPGEe6c7JrvaL6jUHLaJItKtBq
         PCoVHIGr+sX1OYyjUAPqIOGq2BM/20QdgZwom9C2GyWMbT5ymBQZ6TnNlTaCerWBv/dW
         o5fSaFYf77Ape4st4BWxS2mNtry82oE8wipjPBOJQ9QwqP5Tb8yZiYyl/vna4ZDydHF5
         O8Sg==
X-Gm-Message-State: APt69E28o1dyDCumraqLuGqNLzKsYbc1Nn1KKd5r9CoctnRPkgUK7m5j
        ViMstt/scfTARxgGcBZyCMo=
X-Google-Smtp-Source: ADUXVKKgRUDa9WB5fYRqmA0WfsQeiQcchnBJX6iGzY7XWB5vVNKLW5l7F3iUyK7hc0uoPYlQi8qqYA==
X-Received: by 2002:adf:d250:: with SMTP id o16-v6mr5272763wri.59.1528926996537;
        Wed, 13 Jun 2018 14:56:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i4-v6sm4243169wrq.28.2018.06.13.14.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 14:56:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Linton <lintonrjeremy@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] packfile: Correct zlib buffer handling
References: <20180613142207.14385-1-lintonrjeremy@gmail.com>
        <CAPig+cQ1s7QFjEFrOHMYZR8qja5yTjV5D3ksUXXqFL61YthA3g@mail.gmail.com>
        <xmqqtvq65y7e.fsf@gitster-ct.c.googlers.com>
        <CAEFTgix0pasg38cb2_qrN+iPgVuq-BX9b7q+qC5Ep9iFbS=Szg@mail.gmail.com>
Date:   Wed, 13 Jun 2018 14:56:35 -0700
In-Reply-To: <CAEFTgix0pasg38cb2_qrN+iPgVuq-BX9b7q+qC5Ep9iFbS=Szg@mail.gmail.com>
        (Jeremy Linton's message of "Wed, 13 Jun 2018 16:48:12 -0500")
Message-ID: <xmqqk1r25p0s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Linton <lintonrjeremy@gmail.com> writes:

>> Here is what I tentatively came up with.
>>
>> -- >8 --
>> From: Jeremy Linton <lintonrjeremy@gmail.com>
>> Date: Wed, 13 Jun 2018 09:22:07 -0500
>> Subject: [PATCH] packfile: correct zlib buffer handling
>>
>> The buffer being passed to zlib includes a NUL terminator that git
>> ...
>> +
>>         return buffer;
>>  }
>>
>> --
>> 2.18.0-rc1-1-g6f333ff2fb
>
> This is all fine with me, the original comment was an attempt to
> indicate that the original null may not have been there anymore too..
>
> Shall I resubmit it as above, or can it be picked up like this?

If you are happy with what you saw above, I can just make it no
longer "tentative" and use it as-is, which would save time for both
of us ;-)

Thanks.
