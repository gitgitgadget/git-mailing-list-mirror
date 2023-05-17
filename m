Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C57C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 18:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjEQSMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjEQSMS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 14:12:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502C7DA4
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:12:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643990c5373so1046650b3a.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684347137; x=1686939137;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3bTznjZ8inbaGLygxhrszdivyWAfh7fLaHyfm7iCGM=;
        b=Etgeftu3cOAzIhDS/8Ws54JfAMvFm2ylw4TBn5x2o78dDmN1OmncNF5uX6loJjPuZm
         dNgucvNd5LunOpTnO/S9D+Xt9k6huVwrPjJRBqhzpCOnDCY5SH2aZd+lX7bH6ItdaPWP
         qCm0vtCego9Xwuk3HyzQpr8VoOV2Zmk3fpvmdLCljjrxtJINZjndTvNq5I1GwtwV56cf
         sMPSwi00+a8HjxNfmI5PUGHKVuvtvnvjJJLv9a7X5dwcEITOzRqfl96Vtnwuqyppj9+Q
         F+Rlcn2lpf7gcrYSZeZfVeApE2ggwfF5K1R71RxhMYp7edLJ+LjEahUdZY37RUnfPRSp
         DERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347137; x=1686939137;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e3bTznjZ8inbaGLygxhrszdivyWAfh7fLaHyfm7iCGM=;
        b=Y1koFmaMzjeodNCm6wJt1Ny/ldhq5U5WqP6Ab7YsmNgj8PZgpFzcxMPY/GyJwsuF+U
         L42hsYV/Fvc3rJ7JA/9T5oy9DxzW5rkiHQJxDf3GRtwfGuqyyQ1jhcqj0JWBpCsVeTi2
         yWnEwkMMz66qgM+31qgRNgHFXn5kXW9GUb7EuIY58krRqocSAbcYKIaXNNDPXy56X+df
         WNL35W8T6h/NQNjRI5FhljsJLIx0oVuANk/jKptkQA/UtjWsT+8FHneL61ok6aRWmSfj
         BF+DaHpJQcVgkfjP8v7v1IsHu1Mi0pTjd7icrFV6aRmjymlD/fjCbadjn47kPrLT0d3Y
         Fhzw==
X-Gm-Message-State: AC+VfDw3WeMpf62ZjR45aXFC8auFOnRDDeCEhYE4W0sfL3ZzAr5G2hih
        jyL3VApf7KGPvyFQp6K4gV4=
X-Google-Smtp-Source: ACHHUZ7lxAarvhLnGNj+GkGpck9uxWHsbmnxAqMT7Sd4uMH5B6q48G00s3VOya5jvwRFELI22iXVuA==
X-Received: by 2002:a05:6a20:729f:b0:101:5743:fd01 with SMTP id o31-20020a056a20729f00b001015743fd01mr38891795pzk.25.1684347136951;
        Wed, 17 May 2023 11:12:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a384e00b00250d670306esm1963726pjf.35.2023.05.17.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:12:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'Christian Hesse'" <list@eworm.de>, <git@vger.kernel.org>,
        "'Christian Hesse'" <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
        <ZGT/eK6+IKlCM6Sg@nand.local> <xmqqcz2yrjbe.fsf@gitster.g>
        <xmqq8rdmrixc.fsf@gitster.g> <ZGUVvjG+xou3w8YW@nand.local>
        <016701d988ea$4e4ffcd0$eaeff670$@nexbridge.com>
Date:   Wed, 17 May 2023 11:12:16 -0700
In-Reply-To: <016701d988ea$4e4ffcd0$eaeff670$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 17 May 2023 14:06:24
        -0400")
Message-ID: <xmqqttwaq133.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>>Oof, yes, you are right:
>>
>>    diff -u \
>>      <(gcc -I . -E imap-send.c) \
>>      <(gcc -DNO_CURL=1 -I . -E imap-send.c)
>>
>>How *should* we test this?
>
> I hope not by using gcc, which is not currently a
> dependency. Using the C preprocessor directly might help in a more
> general sense, but you probably will need a knob for some
> compilers to work.

I am not going to suggest trying all permutations of CPP macros to
make sure we cover all the #ifdef'ed sections, but -E to show CPP
output is pretty common feature not limited to "gcc", so if we were
to do that, we'd very likely use the usual $(CC) Makefile macro to
invoke such a test.
