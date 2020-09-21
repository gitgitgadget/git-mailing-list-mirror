Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3240FC4363A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD08F2193E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aesQFPjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgIUSB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 14:01:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D3C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 11:01:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so13743806wrn.6
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7lE0G/KBfDXQ0z1YzERVJoNun+rAClDRT90wsbhTbkk=;
        b=aesQFPjkJ4WEK7fa88dtxofSMYIeo0RwySDIBtnpsTQU1Z7lmF2QY3dz50jVMNuoez
         D90LWMj4wSTuT6D84m+CoKGYu2BkwoLUbeM5yFuEx14O8ZmPz2SE4+bqvInHCcfktJZw
         Y89aVSNDnz8p+9+mu1tVT4FJj0pjybloVyD1HIWegxFVn1D7019hk/eHyrJw3QEUaxJ4
         z0qUSEdOabvMvNZwZyv2vOed3Zd8gISp2Dz79CxxXR+X4UqBU0S7Y0jAYLbfoXdbyWMk
         Q3VdIwjM3glSbOXC3JsWWfhBVdC6gxtSGlDul9zJJAUztxFNpo50C2Y424MiTecR6RUl
         Cd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7lE0G/KBfDXQ0z1YzERVJoNun+rAClDRT90wsbhTbkk=;
        b=Goax4rsRPgETzphmP6/6f5DC56wcKPxZZELQljXzspFbh+qgvU2KHzTzH+J+bjjU2w
         316To5afrZFKoJ4wL7GznkCXr1EnWpVCEBdgWgfqpCwvgOi+G2NwgjWbI8mMGvuXmbLB
         vL1drYYWcJ/ueNehwtNNqsXGd2Z9OzqEt0T9JFmFsAHkZOISV/wiDp2cE0u7m2qI7u/C
         MdXYBv2lViBr0IKVRhYA8IK5g3aEQxweYls0okKqHSH/jLFnU7/+yvOgQQCCe5MR7+3f
         k74yJbq/NpEaJUTAf29eTdSXIez+B1FaeglHX5H9mvqXJyUUq7AQqsx4TDb0vMCQC1Ao
         ffcg==
X-Gm-Message-State: AOAM532jF8P0hSFwMiNiE+mp1HZU87AVFRVozrH+ckB2LMJhaArvGmfE
        i673JXQqT0DXg+0G8/nuUsE=
X-Google-Smtp-Source: ABdhPJyNXnHSC2Yjx+1CQJiM7/BASFePb1w+verm0J1p43/dHEUDTnTIMNlbBdMiyIArpC6cOfWefQ==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr999605wrv.185.1600711285900;
        Mon, 21 Sep 2020 11:01:25 -0700 (PDT)
Received: from [192.168.1.201] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.googlemail.com with ESMTPSA id n14sm477271wmi.33.2020.09.21.11.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:01:24 -0700 (PDT)
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
 <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
 <CAP8UFD1i-zOPx6xrEFUVH1of8hzdHxO_jTOZ3fEjSXa_TONdvw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e9c18655-2618-90af-6d84-16ae9f575f87@gmail.com>
Date:   Mon, 21 Sep 2020 19:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1i-zOPx6xrEFUVH1of8hzdHxO_jTOZ3fEjSXa_TONdvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/09/2020 18:04, Christian Couder wrote:
> On Mon, Sep 21, 2020 at 3:33 PM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
>> If one notices a typo in the last commit ...
> 
> In the title "commit: add an option the reword HEAD", I would suggest
> s/the/to/ :-)

Well spotted Christian, Thanks

Phillip
