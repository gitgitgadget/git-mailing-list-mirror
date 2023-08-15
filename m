Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2DBC0015E
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 09:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjHOJXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjHOJWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 05:22:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA531FF9
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:20:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so76652131fa.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692091244; x=1692696044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MzMbgTqNo4BVuO7AwH/fbYvsRFSNbUg32b5XIcoP1zY=;
        b=A4RU+yJ9xJBpT8jjL95rvj9akVb1M+1MeSNN8BNk8aD9rkRooAl6dgGQVwdxymGczE
         tIIGhd8PBxOzSaMdc3NoBfgNo0rEWieVxWiO8GRcdBaJO91wWIOGVT77yrds8mGhX+eL
         MsU8jq0rSey1NSARkzwCKvUr4OZcd7sL/k7OkrYOkgO71pJWNak6Na22QbCx5xpCS/jD
         GSTuTbwSuhHIA47mjgxByCIEbr9R6KLUlowf4xXCB4y+GauZMxi41H0waRIq53dzY4Zx
         yE/gBCCRVyKlOrQad0J9v9AJ4PDvv77RBXHyCeowerMjsJwwq807S5Sbm6rVIn7LqU5L
         aqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091244; x=1692696044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzMbgTqNo4BVuO7AwH/fbYvsRFSNbUg32b5XIcoP1zY=;
        b=cYf1vyKZb0geDu6Fdv2bZg95zTsbzWuUhgctyg5RUbdQrVCU3WL+wHrPb6A3KCwe1f
         y8JlrvsCHKdgwOdbIQ5et17je0GIgDPu7meKuLY1+RojxgVCabcKMlfR5ComIFgWGgGs
         FMgbaupvKCkHPUgOLPlGfHX8YrTuJ48ercpT+NDELUZUEmGQPLAezoQxYUmVpttjwjip
         w6TsqvVhcit4tmXfw/+sTHM19OaISZjAUKZyLrv3N2oA8ZHxtduAhUDE53ZsyVxJf7au
         jEn9LV4He1PmAZPeoEiGjuO9fxwtcinz/jEkVnOTMwoZx0MMdBB1aorl/yez81ZX3JEA
         MVvQ==
X-Gm-Message-State: AOJu0YzuNumC7+3nmatRehc3ANpjXLwGvV39nHpboMPuVN3TlOsH1HlW
        mTsr6W7fYhZAVEiEqEletgs=
X-Google-Smtp-Source: AGHT+IEJr4XBj1LRzkRrY2hbSJZ+qhd0ABkmK81l0Up0isBOAEnMFuLDD3Get96qeNF3mKC0xVB1lQ==
X-Received: by 2002:a2e:7e0f:0:b0:2b9:5fd2:763a with SMTP id z15-20020a2e7e0f000000b002b95fd2763amr8082432ljc.35.1692091243821;
        Tue, 15 Aug 2023 02:20:43 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k5-20020a7bc405000000b003fbdbd0a7desm19934561wmi.27.2023.08.15.02.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 02:20:43 -0700 (PDT)
Message-ID: <56d0838d-12a5-8a8a-3c3e-7d473f2977e8@gmail.com>
Date:   Tue, 15 Aug 2023 10:20:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 0/7] Introduce Git Standard Library
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, jonathantanmy@google.com, linusa@google.com,
        vdye@github.com
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230810163346.274132-1-calvinwan@google.com>
 <kl6lmsyy8sfj.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lmsyy8sfj.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2023 23:05, Glen Choo wrote:
> Calvin Wan <calvinwan@google.com> writes:
> 
>> Calvin Wan (7):
>>    hex-ll: split out functionality from hex
>>    object: move function to object.c
>>    config: correct bad boolean env value error message
>>    parse: create new library for parsing strings and env values
>>    date: push pager.h dependency up
>>    git-std-lib: introduce git standard library
>>    git-std-lib: add test file to call git-std-lib.a functions
> 
> This doesn't seem to apply to 'master'. Do you have a base commit that
> reviewers could apply the patches to?

I don't know what they are based on, but I did manage to apply them to 
master by using "am -3" and resolving the conflicts. The result is at 
https://github.com/phillipwood/git/tree/cw/git-std-lib/rfc-v2 if anyone 
is interested.

Best Wishes

Phillip

