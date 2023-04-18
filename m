Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A7C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjDRSh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjDRSh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 14:37:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC283F7
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:37:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52079a12451so13264a12.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681843045; x=1684435045;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58hzGBkAsAvKX6oLjgu2uu/Q6sGAfgn8f9WGNontVhc=;
        b=It+ecZj2uBPpcOnLLkqdI1kqgWTCicDzHRlWJzkqn8dIFK1GjyuE1V1DaPPGOj/x0/
         iCI1f1HvD9iC/6eDAi8MEEdied5ylcN7AxJ7kvDL3UnVYBV25DRHxAHoo4Sm8oMAkDdg
         Q2+PNHJW5bdyurwNCwuLRrp0rPu1XmvxxwiG4s6Y+OjFZ70AFWHnBDu6PYrl4UNA+xbe
         qAW3s4ZAL3h+YI+Ug6kTLNfOYuwgnX2qy/aZqAjLwodHoWl+r23fkpEKiEXBAdDn6i2A
         2ArJ4mP+AIgRxEauyddtlNE7z5/DRu5FAnVJtpW27bUaQkbugnFsBKzmLBDB1T8Kj+rj
         ivwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843045; x=1684435045;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58hzGBkAsAvKX6oLjgu2uu/Q6sGAfgn8f9WGNontVhc=;
        b=hD91qSnsExZ0GYFBjztxremHYcz/c3UHXHRI6Z92gKUU/UPdjhDZEeMToj6gzNbzam
         0BySwSICRknmDprgXMqY5Ht8K0bkxUQmJv0WmKwiEI6H8w8UvMx+Eu5CJ6rDJ0awNhbb
         oDBRYUf8YIsws8FLw7ifypw84JfoNwhIZsJYtuG2w9ofmrqPC8WQ71TIfIVXYXOy0VnK
         jA234XeffaNetEffy/eL2EnznPbNQXjzL5UL0Iz3RrEvv3mJCvj9XyAWiPZnKl2Dijat
         IIYla/97lxOE/RA1BKfnMaJoFyIyg4VYXFPpunZAD08Gwr5j8q0XkPrQcIFyFIwTYATO
         xcXw==
X-Gm-Message-State: AAQBX9fCBU8QqPYqgvpplMBVwEW3aHbck1iyTAwuXkAh4ARt7dSZ2bKl
        082lzFGTKBPRChau2I6er2M=
X-Google-Smtp-Source: AKy350YnrGrt/YT0QLJvP5R0k7b3ZPCZ05svzOb8BYNNKDk1/vpvqHZfeNSBI97Rkq4v4V5AOPH+fA==
X-Received: by 2002:a17:90a:9802:b0:247:160d:3a8e with SMTP id z2-20020a17090a980200b00247160d3a8emr495759pjo.22.1681843044844;
        Tue, 18 Apr 2023 11:37:24 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902724300b001a217a7a11csm9884835pll.131.2023.04.18.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:37:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v2 1/3] t1300: drop duplicate test
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
        <20230418175034.982433-1-rybak.a.v@gmail.com>
        <20230418175034.982433-2-rybak.a.v@gmail.com>
Date:   Tue, 18 Apr 2023 11:37:24 -0700
In-Reply-To: <20230418175034.982433-2-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Tue, 18 Apr 2023 19:50:32 +0200")
Message-ID: <xmqqfs8xdokb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> There are two almost identical tests called 'git config ignores pairs
> with zero count' in file t1300-config.sh.  Drop the first of these and
> keep the one that contains more assertions.

Good eyes.  I can see that the other one catches the error output
from the identical command and makes sure it exits silently.

Will queue.  Thanks.


> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t1300-config.sh | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 2575279ab8..696dca17c6 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1458,13 +1458,6 @@ test_expect_success 'git config ignores pairs without count' '
>  	test_must_be_empty error
>  '
>  
> -test_expect_success 'git config ignores pairs with zero count' '
> -	test_must_fail env \
> -		GIT_CONFIG_COUNT=0 \
> -		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
> -		git config pair.one
> -'
> -
>  test_expect_success 'git config ignores pairs exceeding count' '
>  	GIT_CONFIG_COUNT=1 \
>  		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
