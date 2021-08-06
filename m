Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D8C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 10:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD1860F38
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 10:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244824AbhHFKHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhHFKHO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 06:07:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BC1C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 03:06:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso13111714pjb.5
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=jZQrO5b5x8URsATDuv+O1q6P3iUfjlD5eDdNKY8kEPU=;
        b=tUfGYXtTivrHF9GzdBvgz+22eur3BW8soMsijwrIO6HOVJZwdN+w4yuMcXV5lq/4pU
         tgJZuX9z6hXzsBhyYMSm3kVULkXPI+khM4nUNZ2+kGmLLDDa3GPCjx7c6RCX3JEiR3Gi
         R2s/gz1DtthU6MC+wO3V33L6ZV6Tgfm3kCjFBC+nz+VkZf1GIOC4BQO7DvEw7JGuA4NB
         sgRysTsXELyfqCOaSI5Auxv6qunpMzpfU1/P7MubHPL1Vxb1/XcuEQTayCuq4BNVgjYo
         Ctc67xX3ezmTvBd+2pDq1rBoWc+Tz6iO1BnOmJYkwCwtdgIDfcBy7DJfexJPMIPns97V
         L10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=jZQrO5b5x8URsATDuv+O1q6P3iUfjlD5eDdNKY8kEPU=;
        b=tSm9KEsHV8BBk94jkl44GxTSlAdO0a8/HCpc7KtVg6M/9XZU2t6j4orHyqAeg7vJ6z
         qE8mVaBRIpvNSpBTxdKpeonORgTrkzJyNwoaRSyAvFFFIVoFln77h9G29gWD7jtTuO77
         jApLMdmqhfYv4EH6pLUaTawy5WZNam+8/vnJUm8f1ByFkcOgcHJn+br65cbzm/jpTf/F
         zf8fVd1p/hbn6X7JWidVba8HuR9uEuvFvtyifRdBd4NZGu+Vg712fpaBDBMqdABywrTw
         AKyxeRK3LS5neUz0jvTU6fcpKA8MITRzhIqqZCOTxJplItNOM/4PMMdGGKPf4HH4EG5x
         6l4g==
X-Gm-Message-State: AOAM530ZEH1z6vUN4GZJTS+B0+UAEcVrua6+OmrTxUOfYGv6hn5FPCUR
        enViZB4Xqj5v+RuDvatpo6Q=
X-Google-Smtp-Source: ABdhPJxuE6pFtB0PThBu+Q1cwvz4twwQnr+W8X/x/xLuIvNptqdafMHmfycOxfogvxfM0TC6nhKhRw==
X-Received: by 2002:aa7:9436:0:b029:30b:30ba:5942 with SMTP id y22-20020aa794360000b029030b30ba5942mr4013240pfo.47.1628244417780;
        Fri, 06 Aug 2021 03:06:57 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id s36sm11930728pgk.64.2021.08.06.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 03:06:57 -0700 (PDT)
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805071917.29500-3-raykar.ath@gmail.com> <YQyIJpq/r0O7zhb1@danh.dev>
 <CAP8UFD0hnkO+LMo2OTAiqPoi20V25806-zL97DA5qPz+3tgKnA@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH 2/8] submodule--helper: remove repeated code in
 sync_submodule()
In-reply-to: <CAP8UFD0hnkO+LMo2OTAiqPoi20V25806-zL97DA5qPz+3tgKnA@mail.gmail.com>
Message-ID: <m25ywivqdg.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 15:36:51 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Aug 6, 2021 at 2:54 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh=
 <congdanhqx@gmail.com> wrote:
>
>> While previous patch is definitely a refactoring, this patch add small
>> overhead to the system, the new code will query (then free())
>> git_config_get_string() and/or xgetcwd() one more time in the second
>> compute_submodule_clone_url()
>>
>> I think the abstraction overhead is not that big, though.
>
> Yeah, Junio made basically the same comment. So it would be nice if
> the commit message could mention we are adding a very small overhead
> in exchange for code simplification (10 lines removed).

Okay, that makes sense.
