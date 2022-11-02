Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06821C4321E
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 00:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKBAmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 20:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKBAmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 20:42:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D217409
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 17:42:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w10so11494980qvr.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 17:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2t8+MuuWKjdHxe6zeG0FQd0wBex6rC4kpzgqRUHB18=;
        b=LHH+vzOwHQ2HfJhpc9NgJiuDPgDJuhaDN4oWfEMdMOHhS5Fd2J0elX3fKRvbfqr3Yy
         ZyQ3YO9IkTcSENrfwv5fzxgEwagLH3Off+1L7pY+btZGL6zAQj2g7RgpFL3RzBwTlKSW
         tsarEN/U0fIR/RKXkYmkHa0MitJdL5jQBb1xSONaKPxqasCKXa8hkIl9qJ0Mqf3xcIzK
         qUFJYn/BBNXp1jNwFDpoaBKLuQQHBdJx4YfLCpVDqxNXTWaQQXqcO2l5cnXReL/3lsoX
         TY8iUB6mFgTgDMcYmsQiXPske3rYwT3XyKhqdeYXUAdzSD7a4t/j4G1wVg9Nas8+QOWo
         nyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2t8+MuuWKjdHxe6zeG0FQd0wBex6rC4kpzgqRUHB18=;
        b=OLA+L+Rw47E04gt7S2cmy3Tg5ai9yfLNgpOj008odDewR8rOMi8PgMQekajveF3FXr
         5xPHk7MD1+nwGQiIhHGnQjmCPZeUbGeVmHpI07Ir+psdetydMekf//99aA6tYAD0cWJ3
         tJiY2OJyKhaEo80n1QhxN06TPdb1uy87zutTrjI4PQi60W8Y5t5GsB4aZpYSYCvTVkQt
         garaidhSSmc9q/Jr9EgHM5gLkdvKZ2s+LnV3p/sXZCk+dL9BlXQ5RSkTRgQ3d6ElGsKT
         /Lm5ICBTh9Q0xpZKwiRhVnvHEmGQlm/mMon46Az4pRnamRvB1abgRSq62BpKhRPsMqro
         iB+g==
X-Gm-Message-State: ACrzQf3fcXnJ4u9s5EADtq7ieqfLKKsMLff1ux0jpsE+Cn/BVzAWukJi
        +lk5Xgq6ua4d4J7T80VR6MbMLLKJlUo=
X-Google-Smtp-Source: AMsMyM7JB/sO3hWhYzhQj3ba53LB6HyaR2JXSDk/T8b4zp1gDIfJVB/nwrxev+qfRfrA7RUAxKsxAQ==
X-Received: by 2002:ad4:4ea2:0:b0:4b7:e8a3:e043 with SMTP id ed2-20020ad44ea2000000b004b7e8a3e043mr18603502qvb.34.1667349727691;
        Tue, 01 Nov 2022 17:42:07 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b006ef0350db8asm7703087qkn.128.2022.11.01.17.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 17:42:07 -0700 (PDT)
Subject: Re: Git Bug Report: out of memory using git tag
To:     Jeff King <peff@peff.net>, Martin Englund <martin@englund.nu>
Cc:     git@vger.kernel.org
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <baac9c67-3f12-18f3-38ff-cd7e450a4da8@gmail.com>
Date:   Tue, 1 Nov 2022 20:42:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 2022-11-01 à 08:22, Jeff King a écrit :
> On Fri, Oct 28, 2022 at 03:29:33PM -0700, Martin Englund wrote:
> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> I created a signed tag (git tag -s) using a ssh-agent key and then ran
>> git tag -l --format '%(contents:body)' v0.6.1
>>
>> What did you expect to happen? (Expected behavior)
>> I get the output
>>
>> What happened instead? (Actual behavior)
>> fatal: Out of memory, malloc failed (tried to allocate
>> 18446744073709551266 bytes)
> 
> Thanks for the report. This looks like pointer or size_t arithmetic that
> has gone negative. Here's a minimal reproduction:
> 
>   {
>     echo subject
>     echo "-----BEGIN PGP SIGNATURE-----"
>   } | git tag -F - foo
>   git tag -l --format='%(contents:body)' foo
> 
> The issue isn't unique to pgp signatures; the problem is in the parsing
> done by ref-filter's find_subpos(), so any signature type exhibits the
> problem. At the end of that function we do:
> 
>       *nonsiglen = sigstart - buf;
> 
> but "buf" has moved beyond "sigstart". Presumably because it uses
> strstr() to look for end-of-line in buf. Since there isn't one before
> the signature begins, we go to the end of the signature.
> 
> The bug bisects to 9f75ce3d8f (ref-filter: handle CRLF at end-of-line
> more gracefully, 2020-10-29). Before then, I think our loop was careful
> about moving past the start of the signature. Author cc'd.
> 

Thanks for letting me know, and for the simple reproducer, that's very useful.
I'll try to find time to fix that this week, but can't promise anything.

Phil.
