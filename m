Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C8C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 13:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJENPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJENPa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 09:15:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A979624
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 06:15:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so35395767eja.6
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8JYNga8seyP+EsudE/9dDh2Mx1x4J3/JQdxaiHFWho=;
        b=c5Ded9czuHHjiCO1zmlyJJqwGOFpw9iU6b0quUp93ESUgYzjkyNgrY8jVzZlZhLgiN
         kbfF3EzuqNXHmZhMUPwo2ZGir/V+ptj5pu2uMQctrUazFh0cGxURPafP0/2GIpiDUO0j
         wwWCo0It2rLt/26VS+c8eLJHSl3qYdrFYzRYeIlGQJQSBcMwmWWnXu9yIplDp8THDiuv
         vs3ea0ZBPbuwnD18zRBUHHlByoqw2ncvCv+nsj+HJlGPhsX61Rb/QfUaykpdoM2s389B
         W43bkHMJ+ywonJetPRDwt1q0magZPjLXNNhS+MWk1wJI7DynS6aD0h9QYTNqdphHgrMl
         CJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8JYNga8seyP+EsudE/9dDh2Mx1x4J3/JQdxaiHFWho=;
        b=3LTysfZpYogVN/4CjJE6vLUQxEnPwCp4A2w0LSKKzd+G7oivYUwStnK8fLv7CoTBPt
         G2B1AjYe/ojIOtpbzZrYAdAj1oTAqtrVYW/4yVlqsFfagOojsWZBKafV1n+4aHERFC9c
         Adcxc8ISqMMCtyiKJT6DUe3JEUVsKRsO7Lz5flqAcW5qHFEF6Jv3El4MJaHuZ4pbbuJ2
         I0Qo02xlXcALClJ5XrqrnFmOd6sLBnpLDuXB0Z3apoun6rvWl3eF7Kx7cVjlxgYKKX5i
         xa4VqXFCqdgxjTf82QH2JsxDk557E3HpSdTbpn35YXNE0uhTgX8zcdihMYV3iVRzHwRU
         1izQ==
X-Gm-Message-State: ACrzQf336+efhOAmSuj1eDxw05zR4i0qbPChjmCbyPjjMFV4XPpxQ0n4
        G/hTZ8dhQCjFur7FEHsCNBh7lzZ1fiIT1Q==
X-Google-Smtp-Source: AMsMyM7gRmqBV9opWiq979rig9y562XQDB0WeUp1OgCvSlcKrbYNUGa7agvBoYdBqGdKRwG8z6jaqg==
X-Received: by 2002:a17:907:762f:b0:78d:22d2:b396 with SMTP id jy15-20020a170907762f00b0078d22d2b396mr4144597ejc.684.1664975725903;
        Wed, 05 Oct 2022 06:15:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lb20-20020a170907785400b0078907275a44sm7405118ejc.42.2022.10.05.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:15:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1og4F9-002YX0-1a;
        Wed, 05 Oct 2022 15:15:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeremy Lin <jeremy.lin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: fix build on gcc 4.4.x and earlier
Date:   Wed, 05 Oct 2022 15:14:51 +0200
References: <20221005090650.3172-1-jeremy.lin@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221005090650.3172-1-jeremy.lin@gmail.com>
Message-ID: <221005.86pmf6s978.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 05 2022, Jeremy Lin wrote:

> Commit 9ff7eb8c88 uses the `deprecated` attribute to display a warning
> message when something that is supposed to be unused is actually used.
> However, `deprecated` only supports messages starting in gcc 4.5.0, so
> earlier versions of gcc end up bailing out with a message like
>
>   error: wrong number of arguments specified for =E2=80=98deprecated=E2=
=80=99 attribute
>
> This commit removes the use of the `deprecated` attribute for gcc 4.4.x
> and earlier. As this is just a diagnostic feature for developers, and
> presumably very few people are developing on such old systems anyway,
> this change shouldn't really impact anyone.
>
> Signed-off-by: Jeremy Lin <jeremy.lin@gmail.com>
> ---
>  git-compat-util.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b90b64718e..9e2969edd6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -190,8 +190,13 @@ struct strbuf;
>  #define _SGI_SOURCE 1
>=20=20
>  #if defined(__GNUC__)
> -#define UNUSED __attribute__((unused)) \
> +/* The `deprecated` attribute only accepts a message starting in gcc 4.5=
.0. */
> +# if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) >=
=3D 40500
> +#  define UNUSED __attribute__((unused)) \
>  	__attribute__((deprecated ("parameter declared as UNUSED")))
> +# else
> +#  define UNUSED __attribute__((unused))
> +# endif
>  #else
>  #define UNUSED
>  #endif

There's an earlier discussion & patch at
https://lore.kernel.org/git/20221003212318.3092010-1-asedeno@google.com/
