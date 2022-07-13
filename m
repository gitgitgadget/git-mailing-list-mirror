Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D1C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 01:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiGMBOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 21:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGMBOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 21:14:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7439B9B
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:14:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m16so12220102edb.11
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=afVCcPMLWGeV4d9g985zx4qY/hmnZ26msCuOFwp/Y8k=;
        b=EVgDgBrzSQ8+JtOWGS9ZuIsvp3m+QPhPd5DNFhO1soiAros5F9fuhBVHkDQrN/LhyO
         eye7x6akUVmOnlhOuLAI+op8itRQVCyi64rna4Iq0Lgchk3DdMkcECcf3VKfQ0Lnq2NY
         4VsquOVwQ/n6vQPTvNDVc2VVYu0+4v7cPkB5k4bq5EYz5uFFgbnaJPtSHcQYHTIa7VPJ
         AHY26VcZFTJ3a6Z+DzWFvDMK8i1z3JVCpvQvExOHoKsA4uuSG6UDA5HMQhVwiOcmRpe/
         0Fxi3B2efuNNPbjvoD6hgt08O5Pcw7xRr4BrFrTpX/3zdE6Md9aNbdezCi26IuXGVxOg
         f+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=afVCcPMLWGeV4d9g985zx4qY/hmnZ26msCuOFwp/Y8k=;
        b=BLVSjAq9kc1gsbvR04WgQvin7zvjHVLji+tzq5xyN4Hi5HL0reUmSejkHQGtYWFRM7
         /lUdrOTg9B3olKSUwOq7gR2txOfhzZbbL+f7ypU+hTKQ2/NkvBwCn7hlirZYj80N17qU
         JEshggYmWFZo1eWj236PbqofbvmNsC7lF0Ik71Zuo4bXR7qdmgLbmtSs9kIFW6e2jCap
         fNwk1m5GlBD1ehdTHwocnVphI8ASknY6HWDu/EAkE9zuhES3S01sXn+Z/tV1nR6GSH55
         t+KSQt8K0AinjrzCRx5HZb86SvTenAYaD3c/mLm0cDoNY3n9WoZEaaf7a2Uptxc5wgIy
         03dw==
X-Gm-Message-State: AJIora+HKxRaMbt68xTCRZr/aJgO4XSLzyHj7DBCfvblKWd7wEeEncHf
        uz2g9avxp8+NS3g/SWqf0wI64dFuT1N+xA==
X-Google-Smtp-Source: AGRyM1ueL0xvhoNwRsMzmqohgMnap1PbHoqOdrkY9BowT4mc16g+GHgvwmw6fCwQGgh4eUGYKslqCw==
X-Received: by 2002:a05:6402:2742:b0:43a:bd75:5e82 with SMTP id z2-20020a056402274200b0043abd755e82mr1309075edd.274.1657674841600;
        Tue, 12 Jul 2022 18:14:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p13-20020aa7d30d000000b0043575ae2051sm6820896edq.62.2022.07.12.18.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:14:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBQwx-001cRi-Q4;
        Wed, 13 Jul 2022 03:13:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 1/7] git docs: split "User-facing file formats" off
 from "Guides"
Date:   Wed, 13 Jul 2022 03:09:59 +0200
References: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
 <patch-v3-1.7-929d9192828-20220712T195419Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <patch-v3-1.7-929d9192828-20220712T195419Z-avarab@gmail.com>
Message-ID: <220713.86r12p4xwo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 12 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> @@ -47,8 +48,12 @@ static const char *drop_prefix(const char *name, uint3=
2_t category)
>=20=20
>  	if (skip_prefix(name, "git-", &new_name))
>  		return new_name;
> -	if (category =3D=3D CAT_guide && skip_prefix(name, "git", &new_name))
> +	switch (category) {
> +	case CAT_guide:
> +	case CAT_userformats:
> +		skip_prefix(name, "git", &new_name);
>  		return new_name;
> +	}
>  	return name;
>=20=20
>  }

I noticed after submission that -fanalyzer complaints about this, since
according to it (and probably also coverity etc.) we could return a NULL
"new_name" there, i.e. if the "skip_prefix" doesn't succeed.

I'll guard this in the inevitable re-roll, but FWIW this isn't a logic
error now, it's just that the compiler can't see that.

All of these categories (and the one added in 2/7) have strings that
start with "git", so we'll never have a NULL "new_name" here, we always
skip that prefix.

Of course that depends on the relevant categories in command-list.txt
having git* names, but we know that's the case, and that'll probably
never change. So I'll just have this BUG() out if the constraint is
violated.
