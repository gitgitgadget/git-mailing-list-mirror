Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B7C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 19:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJLTCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJLTCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 15:02:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068F22BD0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:02:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m16so2667073edc.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oc8MkNUwzaOWnWVDHWLdoJa/tuEb6mUPpnjtN0Lp4gI=;
        b=RckTDe+b9SbBZKRXBpVCO9++q8641SWMTnz/XCNrAY+tLgmrVODVX72mUX5rU8k0VQ
         IC+UVUJ2eFIRe1witaW/9PYvzyX4Vbtjk4B2sezDoxhZJ2CusRZWcW0D6PoP0w1Q430y
         ahJ/GGzNLIS4ZStufB7tMaV0++QWvFi2mn/qyhJKHUwbSsibnBvrw7ymAIDodOp0qjnY
         7wMyi6bU2U7zK1O06QlTPXSIe2q/rUB5hHQshClfzQCq+DteLi/HvTTiIWpR9u0SqF/7
         6Z5EFHmTbKUYQdiI0LghYH6ecy1RvKXDwxrkObfD7RaoFTelhTqCcROKUBj1o2/HVe6R
         JCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oc8MkNUwzaOWnWVDHWLdoJa/tuEb6mUPpnjtN0Lp4gI=;
        b=uQJPGrlFRhT9X9LuEKSQibOoUaEAwpfl8elyZsUOPdCWpQwsES80DFFEbv1toZeQi9
         zofXNL/nZDNwrO29YXwN4ibPL2gWJb5Eg261cQs07ABl6sDT/8AlHa0Jba9W5qtIcvQm
         ZmL2ohvkJVJ1LjzXAEF3LUq/pohdqnTiFbrJ6ulW8HmWRhlK3D33+cpKRQDaZga0NgZ1
         z2e1AsGMnhPYBoc6IGD57xkd6A7s7ysNmjbMHpUR65yHXEIQfThBxJ57ngLFVw46A2zZ
         Hxj00oGChGFTIwXJZoiB2ykQ2u68GYN0OWBx0Wc4+9cwf7V8PAkLlDYbHJI6nnlYhJqY
         gdzg==
X-Gm-Message-State: ACrzQf0M5SOoaUAx7cjIx2CR29H/i5hEKuFil39lTlomlvKU1AvuhyaD
        yEfx0mQ6VTrx1la4gXEumNT1t73IT32geg==
X-Google-Smtp-Source: AMsMyM5JnROhyn1mRHTueTKnF2dHY5QUxBn1eDnJeNQ8KSZolYpJxszdunlma3GhhZDSpIwzeLEZBQ==
X-Received: by 2002:a05:6402:14ce:b0:45c:2c81:e144 with SMTP id f14-20020a05640214ce00b0045c2c81e144mr14442091edx.90.1665601354635;
        Wed, 12 Oct 2022 12:02:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky15-20020a170907778f00b0078ae0fb3d11sm1714924ejc.54.2022.10.12.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:02:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oigzv-004Hvl-0q;
        Wed, 12 Oct 2022 21:02:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 22/22] run-command.c: remove "pp->max_processes", add
 "const" to signal() handler
Date:   Wed, 12 Oct 2022 20:58:22 +0200
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <patch-v2-22.22-541f41566e7-20221012T084850Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <patch-v2-22.22-541f41566e7-20221012T084850Z-avarab@gmail.com>
Message-ID: <221012.86ilkon9vc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 12 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

There's a really stupid logic error here where...

> -static struct parallel_processes *pp_for_signal;
> +static void kill_children_signal(const struct parallel_processes_for_sig=
nal *pp_sig,
> +				 int signo)
> +{
> +	kill_children(pp_sig->pp, pp_sig->opts, signo);

...this pp_sig is always NULL...

> +}
> +
> +static struct parallel_processes_for_signal *pp_for_signal;
>=20=20
>  static void handle_children_on_signal(int signo)
>  {
> -	kill_children(pp_for_signal, signo);
> +	kill_children_signal(pp_for_signal, signo);
>  	sigchain_pop(signo);
>  	raise(signo);
>  }
>=20=20
>  static void pp_init(struct parallel_processes *pp,
> -		    const struct run_process_parallel_opts *opts)
> +		    const struct run_process_parallel_opts *opts,
> +		    struct parallel_processes_for_signal *pp_sig)
>  {
>  	const size_t n =3D opts->processes;
>=20=20
> @@ -1559,7 +1572,8 @@ static void pp_init(struct parallel_processes *pp,
>  		}
>  	}
>=20=20
> -	pp_for_signal =3D pp;

...because this removal has no corresponding addition...

> +	pp_sig->pp =3D pp;
> +	pp_sig->opts =3D opts;

...there's a missing:

	pp_for_signal =3D pp_sig;

Here, sorry!

Junio: If you do pick up this re-roll please just peel off this 22/22.
