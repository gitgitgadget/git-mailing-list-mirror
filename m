Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FC7C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 07:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjAaHaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 02:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAaHaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 02:30:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9AB2B0B7
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 23:30:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m2so38489547ejb.8
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 23:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L61b6dYBP5ovjV6guxACk3tujO9EPPclkXcAXLq5m0k=;
        b=vwADfXMMUaiN7N2rp1nvX/Wr5b+r7UFScCss2e3oieOSJ0EQlL0BnPXTe9GmMR59L0
         9s0NEVraFrcUiKA+TGBgJS/akilTeF69dtvCa2EaXAw6sIFq4fPCbI6Y9EmQw8DHK7pF
         RFS/fjVnmP8mv/YWMPP6pb6pnVd8AxhyuiWUTiwUTeSW7AnRK7NqVqYLS+l80meaf3Yb
         4ARIJ3y++J9OdqrAEF2M1v60AwfrACdgkoak7YFXpstvaek9XKvLlWH1IP31sNme7HZV
         1EZDBW8X87bjtfEKHQ0m+1Nh/SJFIAALI0GPWiQwu7SMHU1wZI67wA3LitLCX3BMu8Jz
         xa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L61b6dYBP5ovjV6guxACk3tujO9EPPclkXcAXLq5m0k=;
        b=LbZoQ9CahnjZ8Jp8pUg7pNaasg5rN9bb5SAE/v9JfoT0G/EV/ME8Wk7Jp3kGRTRAL+
         JBb+OObgzl1PcjkB9Z2pF7SAbW+H5xRa1qp/8tO5KnWCGnYGD2eIY+4E3qtjytSbc1Oc
         5/eQrldZZd9WI8R+GhhffrdjTgu0Omimq9oBewKr9ctWqJpiYN54ERxV8mry61OElEOE
         wZWqcTriqt/Ds2XhFc3Jw7/3YAbtnJ0boKPKYt3m2NETNUUw6tDmPBBagPd4/hshjIhs
         gES3Kr1F5vD2A0k7FyLM2ASkEqmLXBh0Ni1ZtYzg/HwYaN1zkTLDq/wE2XbqqD3Je+pE
         ILdg==
X-Gm-Message-State: AO0yUKVyF85BYF/PLTYCNRJ+8I5/AariNba0zkZQkmOmIDR50brNS9BV
        OW909Ey4AIXP+KPluLbY88fyPA==
X-Google-Smtp-Source: AK7set9QEAfHj0MdzxDlY7/uS+/2ZLmkIBgV1R70y6/rB5RpbPS++4TykgvEcdmsez9vfhmm0LWjkw==
X-Received: by 2002:a17:906:6592:b0:883:3299:91c8 with SMTP id x18-20020a170906659200b00883329991c8mr12045925ejn.55.1675150214306;
        Mon, 30 Jan 2023 23:30:14 -0800 (PST)
Received: from ?IPV6:2003:f6:af25:c200:dcc7:5696:ff63:6d6f? (p200300f6af25c200dcc75696ff636d6f.dip0.t-ipconnect.de. [2003:f6:af25:c200:dcc7:5696:ff63:6d6f])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090631c600b0088879b211easm2875813ejf.69.2023.01.30.23.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 23:30:13 -0800 (PST)
Message-ID: <580c2754-5bc3-760e-c85b-62b44baf7e13@grsecurity.net>
Date:   Tue, 31 Jan 2023 08:30:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
 <xmqq1qnfancf.fsf@gitster.g>
 <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
 <xmqqk0156z55.fsf@gitster.g>
 <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
 <xmqq357r4zvk.fsf@gitster.g> <xmqqlelj3hvk.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqqlelj3hvk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.01.23 21:08, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If we were to keep that "die", it is absolutely required, I would
>> think.  Users who got their Git with JIT-enabled pcre2 may be
>> viewing JIT merely as "a clever optimization the implementation is
>> allowed to use when able", without knowing and more importantly
>> without wanting to know how to disable it from within their
>> patterns.
>>
>> But can't we drop that die() if we took the v1 route?
> 
> Having said all that, I do not mind queuing v2 if the "use *NO_JIT
> to disable" is added to the message to help users who are forced to
> redo the query.
> 
> And in practice, it shouldn't make that much difference, because the
> only scenario (other than the SELinux-like situation where JIT is
> compiled in but does not work at all) that the difference may matter
> would happen when a non-trivial portion of the patterns users use
> are not workable with JIT, but if that were the case, we would have
> written JIT off as not mature enough and not yet usable long time
> ago.  So, in practice, patterns refused by JIT would be a very tiny
> minority to matter in real life, and "failing fast to inconvenience
> users" would not be too bad.

Exactly!

> So while I still think v1's simplicity is the right thing to have
> here, I think it is waste of our braincell to compare v1 vs v2.  As
> v2 gives smaller incremental behaviour change perceived by end
> users, if somebody really wanted to, I'd expect that a low-hanging
> fruit #leftoverbit on top of such a patch, after the dust settles,
> would be to
> 
>  (1) rename pcre2_jit_functional() to fall_back_to_interpreter() or
>      something,
> 
>  (2) add a configuration variable to tell fall_back_to_interpreter()
>      that any form of JIT error is allowed to fall back to
>      interpreter().
> 
> and such a patch will essentially give back the simplicity of v1 to
> folks who opt into the configuration.

Fair enough. But aside from the W|X memory allocation denial exception
is the likelihood to run into the limitations of PCRE2's JIT requiring
the interpreter fallback so little (as otherwise we'd see it in the past
already), I think, the demand for such a knob is basically nonexistent.

Thanks,
Mathias
