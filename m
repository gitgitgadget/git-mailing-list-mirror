Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45969C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 18:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDRSj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDRSj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 14:39:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D92783F7
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:39:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v21-20020a17090a459500b0024776162815so101276pjg.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681843195; x=1684435195;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiK1ghVS/EGIKhXS/nGl7Bdu1gLAtCE3XGC1MbnZXaA=;
        b=QfRebvM1gE7TYdzAKWfo5jqw53DNbVbETJLMuZKhAC1kqzcEOkXqta2LdTXPF0Tl0y
         IFReu3nZOoIRFMrabI7ybWqXbVbBvlMRi8svwA9R/LWTHteEKyy5uKYr9X+g2OEm3mvu
         l8JJBCU9cycV0lTeqcMKgn/883gX5Z2Qp3e6Kh+cZZx6IR6nhGlmM39SA59u/NNz43D8
         g1AktV+ePSjvSTD3RfrIqZu5dz0bGu0T045LkyhhSUCbXdr9V1IgkWpXE3DBR3vOtmwe
         j2tJ325wxx0AMSzz4VkLy0GLX1oNqd/XOqSNBuMSDkfceItkkeYAYsRo6rd9mAKhsqJM
         kC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843195; x=1684435195;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oiK1ghVS/EGIKhXS/nGl7Bdu1gLAtCE3XGC1MbnZXaA=;
        b=Zu4+gkn53hiwxo7Cc2xW9lqDvc1vZ48rUGJEfDMaTBbZKtMqQ0h5b3ZKUvWwhqVt1y
         ricsivUnqAGkjE1yBhvVGiMK0ClZ9PkbU6H0N+u2Xp4RYEo4MvAlQQqQpvEgmApWOW8c
         mTXKs1nICw5ZHf84gjN3BAN7KP4MfZYVb7N3ne3U4hxr3ILqhBDbkWeMXNz0jo2rzQ/+
         8iKVXzX7VSPPu5jqeUDTlXGRZKumCLH2oJlYyd9N/K/ydO/ZbIZZk0bAsHFa6kamTHHp
         2RLwwrYvd7nVWJyTwWgI61ffFmcIlVhmzzoR89jh8O1WWCH1h+M/ybD94jlYSLdeKWpP
         8M7Q==
X-Gm-Message-State: AAQBX9dswtZgkFTqdX6EpIpYBMbtMjxhCnk0lRFnOGI6B1+WTwZHcYSA
        RfAOosk5rBe2AEqcErLzaz0=
X-Google-Smtp-Source: AKy350Y09kWn3O857+lv0gG4N/Q8qtKOR3hdO20Oend5Fp+UnkbLLqOhEDVjXYZM38PuYIl8XMoCRQ==
X-Received: by 2002:a05:6a20:4392:b0:ef:9e64:5be9 with SMTP id i18-20020a056a20439200b000ef9e645be9mr522659pzl.44.1681843195368;
        Tue, 18 Apr 2023 11:39:55 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id t8-20020aa79388000000b0063b6bc2be16sm7910491pfe.141.2023.04.18.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:39:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v2 2/3] t1300: check stderr for "ignores pairs" tests
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
        <20230418175034.982433-1-rybak.a.v@gmail.com>
        <20230418175034.982433-3-rybak.a.v@gmail.com>
Date:   Tue, 18 Apr 2023 11:39:54 -0700
In-Reply-To: <20230418175034.982433-3-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Tue, 18 Apr 2023 19:50:33 +0200")
Message-ID: <xmqqa5z5dog5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Tests "git config ignores pairs ..." in t1300-config.sh validate that
> "git config" ignores various kinds of supplied pairs of environment
> variables GIT_CONFIG_KEY_* GIT_CONFIG_VALUE_* depending on
> GIT_CONFIG_COUNT.  By "ignores" here we mean that "git config" abides by
> the value of environment variable GIT_CONFIG_COUNT and doesn't use
> key-value pairs outside of the supplied GIT_CONFIG_COUNT when trying to
> produce a value for config key "pair.one".

Correct.

>  	GIT_CONFIG_COUNT=1 \
>  		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
>  		GIT_CONFIG_KEY_1="pair.two" GIT_CONFIG_VALUE_1="value" \
> -		git config --get-regexp "pair.*" >actual &&
> +		git config --get-regexp "pair.*" >actual 2>error &&
>  	cat >expect <<-EOF &&
>  	pair.one value
>  	EOF
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +	test_must_be_empty error
>  '

Looks good.

>  test_expect_success 'git config ignores pairs with zero count' '
>  	test_must_fail env \
>  		GIT_CONFIG_COUNT=0 GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
> -		git config pair.one >error &&
> +		git config pair.one 2>error &&
>  	test_must_be_empty error
>  '

Looks good too.

>  test_expect_success 'git config ignores pairs with empty count' '
>  	test_must_fail env \
>  		GIT_CONFIG_COUNT= GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
> -		git config pair.one >error &&
> +		git config pair.one 2>error &&
>  	test_must_be_empty error
>  '

Looks good too.

Will queue.  Thanks.
