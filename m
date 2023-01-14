Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24664C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjANQN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjANQN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:13:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C983CE
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:13:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bj3so22055859pjb.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wG9iKoR1ds9as2l0T54yJ2tjl0RLphl5Qofu/sqa9Tc=;
        b=n6rAXseBfma1gfbtJaR+3zn8Sc0uN9NrhMeCMnyvppPT2Owcwn5PPYleP9oql0bqkQ
         uogATUrq14xJSVRv6Uv/N92VCENxdx2HW4+ro7bnXkAw5Hb1kXUryH1INcY0WSRZ5Nhe
         OzA50OvAzfiytUslOrrVnaUDougrf/xrjZid+jq0aTBFt9QUjkIXZW1pVJgW2FUD0IsT
         pKqi1hpYGciz/02YOCyXr4YxVDS1RlpCMWDTALaAMHTvwCWAnbxzXH10Ro4QIUgbstuj
         bA9goGhnTT9DVGt4s64X4KZRFqJzB6Zc5e+bf5eOO3aiMU/afDcQ0/JfC0EDiceNByDk
         xE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wG9iKoR1ds9as2l0T54yJ2tjl0RLphl5Qofu/sqa9Tc=;
        b=c1Zpd9bmQDPj35pd/t2lpY0IkOppa17D569xUrC0/icYjlNLCcRgicXlKBqID0iT54
         iSWjNQ6RZHM1LHc2unc3O20a/Tv9VnXKrmmV98qdFeKPrh20DHe2vShVC8zfaDViG+82
         VDpNrZSzDIxngVF/JjIyC7X6OrseEY8UjeXgXvV3FeDBxNxQfuaigrnKyNRczFhQsT/n
         QPKrQ0E5jT/adYnV1XI5v4xiHnLByEMiFAn/5TndxozZpRkRq27eexbjibxFrcbWatOc
         +pTZ7RJmK8WrPdK3j5OfvBPiprphRL5mqQC7T2tjS2zl9B1XXaeVen4+11/OL0/eunT+
         U74w==
X-Gm-Message-State: AFqh2koLCnhuG3aK5pUcBLpm1zBLxWLhzuRqE67DecdTykb1mhS9vkUq
        rnsNNicBqhvfSqjpNz6Cx3SgYqRdLs0=
X-Google-Smtp-Source: AMrXdXsD07qEYLQasT8FCK+XOyUQAYE/Hz7oc/3QKJBXFDgUivNagNsnTehE8BgrnZD1qyb3SgmICg==
X-Received: by 2002:a05:6a20:2a8b:b0:b6:892f:1e9d with SMTP id v11-20020a056a202a8b00b000b6892f1e9dmr12065064pzh.3.1673712806010;
        Sat, 14 Jan 2023 08:13:26 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y14-20020a63fa0e000000b004a7e39ff1e8sm13237270pgh.49.2023.01.14.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:13:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
References: <xmqqv8l9n5fj.fsf@gitster.g>
        <11dccdea-0e33-6669-9554-19f064df6010@ramsayjones.plus.com>
Date:   Sat, 14 Jan 2023 08:13:25 -0800
In-Reply-To: <11dccdea-0e33-6669-9554-19f064df6010@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 14 Jan 2023 14:29:27 +0000")
Message-ID: <xmqq1qnxm6vu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Yes, on 30-Dec-2022 I updated my cygwin installation, which updated
> the curl package(s) from v7.86.0 to v7.87.0, and caused my build
> to fail. I had a quick look at the new 'curl.h' header file and
> disabled the deprecation warnings to fix my build. I used vim to
> add the following to my config.mak:
>
>     CFLAGS += -DCURL_DISABLE_DEPRECATION
>
> .. and then promptly forgot about it for a couple of weeks! :)

Ahh, this is why I love to be working with this community, where I
can float a problem with a possible solution and fellow developers
respond with better solutions very quickly.

>> +DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations
>> +
>
> Rather than suppressing 'deprecated-declarations' globally, we could
> just add '-DCURL_DISABLE_DEPRECATION' to the compilation of http.c,
> http-push.c and remote-curl.c; similar to how we use target specific
> rules to pass '-DCURL_DISABLE_TYPECHECK' to sparse (only) to a similar
> set of files.

OK, or, assuming that non-curl including code will not be affected
with the macro, we can globally add -DCURL_DISABLE_DEPRECATION to
CFLAGS or DEVELOPER_CFLAGS.

I guess I can sit back and wait until a better version materializes
;-)?

Thanks.

