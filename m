Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4CC3F6B0
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 14:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiHPOXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiHPOXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 10:23:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E3663BA
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 07:23:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so12834276wrh.3
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=eDWBAMtc1P1GO+LtKfYCGUZizXno1IuYJ7jzkuCVOxI=;
        b=LuqfBoNBgmpRV6zea5OC0iF7D44WD/hkwJtS5B+bpKJxeFbzSbHg/alkcJgdf/dQyw
         5cUJkY6Mcqmn/VhRL3Me2FnORxyRKjKWPT7d9pX85TXDv8Pm32R5U5laekaLVM1WAy5k
         PdRdrlLOhVX5LHvA58IqE2DZlkl3JtZxJVdgTVrmux9n2NjdrGDokO2TBnfgtOED1Nku
         yhVwk+Yb5Kxka86Vn69H1K/u5bSgct84QoLp/5wBhSWn+XFc0hK6qzzk/bcfUAwEeCZ5
         myKCBRjdG46pfcMxFogmbHWHcjQ+AM0EehOAt6vtAXut/eJoNThls/+Do36pDwGdNKiv
         U1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=eDWBAMtc1P1GO+LtKfYCGUZizXno1IuYJ7jzkuCVOxI=;
        b=c2iDqjHBpnWUa35vsYwHX5Gc3nHpHfuBe424OIdT2jhAhP2ZQ5fwWYPJQBjMvEBx/V
         tTHbdVLtsWTXrqVRm3aLuZ2Rbwb+9bP6FMYYZsXGTA38UHbOeEl4/cLlLgP1Du+0bEEO
         DaE71fQ1WdgjZwLIW4TyU5hdP0W95KzVcPhKoXagnhy7dUENnhUdf9BRBEmk5LAWYfFK
         WuSeJK7mCRRzEjZBxnm3m6eB6S+Lw679tBYup/BUuu/aUUxPU/kPekSua2n/nN8XyPgg
         /oig53RouauFlEYIUzwhBuRHShX/dETmNrhnc5irqpOx4kZPmpq49oF5QeUFEU61ePQr
         aC6A==
X-Gm-Message-State: ACgBeo1maRIQRcZGZkFl3vemAL/QlB4JRxaWWFfDiy01Ig6rIA83nIaG
        FpOGAci1ueEBnxp4hMmSpJk=
X-Google-Smtp-Source: AA6agR5rAC/Spxm0+9PHJ3JTEKjTiYqtKyR1WzVyWhwU5Z3zG2v1gRuuKDZWNpUq5QuxvbmpZ4mNhg==
X-Received: by 2002:a05:6000:790:b0:220:732c:9ee0 with SMTP id bu16-20020a056000079000b00220732c9ee0mr11481615wrb.183.1660659789531;
        Tue, 16 Aug 2022 07:23:09 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0021e74ef5ae8sm10981450wra.21.2022.08.16.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 07:23:08 -0700 (PDT)
Message-ID: <9f8d808a-880c-fdd2-e915-d01c3f116cdc@gmail.com>
Date:   Tue, 16 Aug 2022 15:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com>
 <ec8204d5-9d0d-9850-f930-6fc1a8efacc5@gmail.com>
 <p1nn7o5q-9r34-n27o-s8r6-50277p3rp604@tzk.qr>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <p1nn7o5q-9r34-n27o-s8r6-50277p3rp604@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 16/08/2022 11:00, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 11 Aug 2022, Phillip Wood wrote:
> 
>> On 10/08/2022 16:02, Johannes Schindelin via GitGitGadget wrote:
>>
>>> diff --git a/add-patch.c b/add-patch.c
>>> index 509ca04456b..3524555e2b0 100644
>>> --- a/add-patch.c
>>> +++ b/add-patch.c
>>> @@ -1547,7 +1547,7 @@ soft_increment:
>>>       strbuf_remove(&s->answer, 0, 1);
>>>       strbuf_trim(&s->answer);
>>
>> Unrelated to this change but why don't we just call strbuf_reset() here?
> 
> This part of the code is used when the `g` command (to "go to hunk") was
> issued by the user. And that `g` command allows for a number to be
> specified, e.g. `g1` to go to the first hunk.
> 
> The `strbuf_remove(&s->answer, 0, 1)` removes the `g` from the command.
> 
> The `strbuf_trim(&s->answer)` allows for whitespace between the `g` and
> the number, e.g. `g 1` should also go to the first hunk.
> 
> If we called `strbuf_reset()` here, we would remove the number completely.

Oh so if the user is not using interactive.singleKey then they can skip 
the prompt which displays the hunks and asks which one they want to jump 
to by guessing the number of the hunk they want and typing "g <n>".

Thanks

Phillip

> Ciao,
> Dscho
