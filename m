Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A601C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 07:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJHHHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 03:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJHHHn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 03:07:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FAB3B1D
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 00:07:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso5690679wmq.4
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6SOc7jPcH57yw3LqPMdh0PirJ3oew+Jd31MYP8qm88=;
        b=Eq7QXXwOeHw97LDGmz4kmpUvuRr56t8cp09O9sclM/2lHg+KrSiq6dRTytIobmsTeu
         XiM7IfU0pClySDZs4iWKp0Nz2jYNv4zY0qowU2Mjkv4tSquSRQS5eDEfygBkaBFyM8Z2
         YAtbjcLT+BAsMK7AYDBpfoXTQ+JvibMdAI4VVhwUlIsrKt67Cogt8gMZuWnq5j1gLfWa
         ZvWOQuH9OXqrsv7Pgd7WsAw7kzjgllPxJL+rsswMIKhMgqXkANAWVe3dECm36c31R/lp
         FSDXQkDEkYgx633aka1HPIET3TzGyEh2ePj9IZN18wQMibfqZ6yNJq51fPzISE/K/S+H
         910A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6SOc7jPcH57yw3LqPMdh0PirJ3oew+Jd31MYP8qm88=;
        b=sWLI3Tg1wJnkAnrAGOiay3X4iOr6iiM0cPzuH1dGVq0Qi1HCF/0tF0mbqH6E/DLOtW
         k5gLDLTTViSQxO1Ngf2veGj4Ic2hbF6qmbKbqPKPNHwg52+mGeOQ6UumEz1QjCFPFxlH
         KK00qP01/35rwRcZMSUZnpyLCu0KKW5K0RvKdJcA+mToT+8TjE2PPhxACjNcZV2oytsS
         ZU9+Rs7+SWmDBRwgQSfL8Z+CUTCqhrulGQwDUBiSLEHAUcnXSSX29oFOK9AAbx+55+QH
         SDCTCXfpTNpk5++rOJdp70j1kWsefwD+iePsEIThElvs8SVSpEUoZwj0JUfO93VoYxuV
         nBAQ==
X-Gm-Message-State: ACrzQf0WdA5KjulTnd5kITzJyHUispGg/HIbtr5tZDsRKwVMh3wD8ynv
        JCV4RxiFcKQj+ihy5xrQ/dQ=
X-Google-Smtp-Source: AMsMyM5ztWqGKmi4elxifuT7ORvCQFdrDrSMdGCA/qxjX9n1cZkuJQcBfhBRMcXAq2ZaOARzB9vq3A==
X-Received: by 2002:a05:600c:1c1b:b0:3c1:c06e:441b with SMTP id j27-20020a05600c1c1b00b003c1c06e441bmr5357060wms.59.1665212860459;
        Sat, 08 Oct 2022 00:07:40 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d5192000000b00228dbf15072sm3777877wrv.62.2022.10.08.00.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 00:07:40 -0700 (PDT)
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
Date:   Sat, 8 Oct 2022 09:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/10/22 5:17, Eric Sunshine wrote:
> On Fri, Oct 7, 2022 at 9:36 PM Rubén Justo <rjusto@gmail.com> wrote:
>> branch command with options "edit-description", "set-upstream-to" and
>> "unset-upstream" expects a branch name.  Since ae5a6c3684 (checkout:
>> implement "@{-N}" shortcut name for N-th last branch, 2009-01-17) a
>> branch can be specified using shortcuts like @{-1}.  Those shortcuts
>> need to be resolved when considering the arguments.
>> [...]
>> Signed-off-by: Rubén Justo <rjusto@gmail.com>
>> ---
>> diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
>> @@ -133,4 +133,28 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
>> +test_expect_success 'edit-description via @{-1}' '
>> +       git checkout -b desc-branch &&
>> +       git checkout -b non-desc-branch &&
>> +       write_script editor <<-\EOF &&
>> +               echo "Branch description" >"$1"
>> +       EOF
>> +       EDITOR=./editor git branch --edit-description @{-1} &&
>> +       test_must_fail git config branch.non-desc-branch.description &&
>> +       git config branch.desc-branch.description >actual &&
>> +       echo "Branch description\n" >expect &&
> 
> Is the intention here with the embedded "\n" that `echo` should emit
> two newlines? If so, interpreting "\n" specially is not POSIX behavior
> for `echo`, thus we probably don't want to rely upon it.
> 

Oops. Thank you! I'll reroll back to using "git stripspace".

>> +       test_cmp expect actual
