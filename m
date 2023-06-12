Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0135C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbjFLSB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjFLSBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 14:01:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251CE4E
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 11:01:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3d41e0d75so8086005ad.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592913; x=1689184913;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO4zvZ5GLCXargLS2vqxhEXGLTJhVLnyjWgs+M2klrw=;
        b=T61ylbtXFjalkxAkO7pMMCp3JIvLw1Vzk0Eu5MkE8yr7K+RI79GXVWJKecDeQrEMsK
         GkS3lUAuheDqQs4l/R+ySLwgvPcinOZp4F3F6obsN773sMb/lhBa2DsL9gq9cBxOIg4E
         MBC+7GpFrWF4QbsmmB6DDo3LiYn+X6mEPUacWl2fUkbVTFLALMmhIzdJzuxiNZzx0Krd
         LjG95gbxBjBHV0CzHj0Xps5idatw2/jn4DrU6EZCzBWemfwTuornO9raaC+uh4WGGyP6
         v7hRxINQwsni21GM8VCjWJPN3sf6KNqq+OmRa66nihMSxah9ayGOlGQnC6iumm6h/z0Z
         sh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592913; x=1689184913;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RO4zvZ5GLCXargLS2vqxhEXGLTJhVLnyjWgs+M2klrw=;
        b=Pp/NgD4xYg9o/R7CTGqBG0tql18a+R/S6zXD+neZKmq5YjDcKsIi8x+c0LiC3yWkz5
         ZYsFte4ADLikojSf87MjdBt+igwgUmkt9ZyBths4C6LqOgZczx/XRCk9aD7K8MMsMMno
         J6BUqTs1/Tio4omFo97MwwMg17daPWCHWBXV6P9Ytaxj6g+KYva7mEZ3Qmy8KPxgHSzk
         BBPDo5dvdpBsFwqzo4NV5irk4m4SCsiMK2QRWIHfG7xwdJFM3obs6+pGLCbE3AUKV+Vz
         Khq/RicjCzP7r8TdJgMmLOTQKLRCB8lm32Ykb+doorNTgyf31VtP/WBfXyUU2FojbfKF
         8Nmw==
X-Gm-Message-State: AC+VfDw9n9KkPqbId3dGgywZEsKqFlZEqgFf1ZgUIr0Z7PlCUO1Gt8TR
        OVYsb1tuuDGttE9k2B3J9A0=
X-Google-Smtp-Source: ACHHUZ5MESEGSbl2WYH/iUAyKt9r1BBTkiEqh1Q1NBn6+nz8gJNQdZyo0W2WYVWVwXIuyCsvr6ZWhA==
X-Received: by 2002:a17:903:2304:b0:1b0:236e:e5ed with SMTP id d4-20020a170903230400b001b0236ee5edmr8899647plh.14.1686592913025;
        Mon, 12 Jun 2023 11:01:53 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902988d00b001ac937171e4sm8474181plp.254.2023.06.12.11.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:01:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 1/2] t1800: loosen matching of error message for bad
 shebang
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
        <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
        <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
        <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
        <013501d98cee$e58dc980$b0a95c80$@nexbridge.com>
        <013601d98cf2$392153c0$ab63fb40$@nexbridge.com>
        <f5519f93-bca7-ecbc-9da3-b25ce8aef618@web.de>
        <28d808e4-77b4-d91e-8a86-c21287019b56@web.de>
        <xmqqwn0h4ek3.fsf@gitster.g>
        <14e1be60-3765-0ba5-00f5-2848bb57bf53@web.de>
Date:   Mon, 12 Jun 2023 11:01:52 -0700
In-Reply-To: <14e1be60-3765-0ba5-00f5-2848bb57bf53@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 10 Jun 2023 16:51:12 +0200")
Message-ID: <xmqqv8fsa7an.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> +	# TODO: We should emit the same (or at least a more similar)
> +	# error on MINGW (essentially Git for Windows) and all other
> +	# platforms.. See the OS-specific code in start_command()
> +	grep -E "^(error|fatal): cannot (exec|run|spawn) .*bad-hooks/test-hook" err

Looking great.  Thanks.
