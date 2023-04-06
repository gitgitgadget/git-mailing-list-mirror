Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44126C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjDFIrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjDFIrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:47:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06A44B6
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:47:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t10so147376944edd.12
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680770823;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZECN8SgB4A2F2F/ndy+j5cKJb5Z+zQ/S0Oyi6S8I8H0=;
        b=PqYw+/udS5IHe6V4jeUyTdz9N+FFlTof/UKKaJWtLBY81Qn7XaG2c82h2DNYaTG07Y
         zjr20EihJBrlZa+O0r3HIjceNqNxsJPsq73+to6Kbw+f18eRax45qLbgwcC/zvfeTIJB
         8/iyxwOIeH/2QUes8C9ZRQGleggu0cbGFLoQS2HAwuCklV2iNwrz0LlGC5KAkFezniJI
         feG+GXu14+mCKqKXD1bpbYYjnXR6MZ6Il2KV4ERYdcVgYehxft2rZ0rnGyXEdO7IK9px
         qN6fC1lEthopqNQM51cPaNnCd5DrVHrPnE+elUA8Bi1442jMYEh9Wotxu/qd0HB/q1bb
         gxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770823;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZECN8SgB4A2F2F/ndy+j5cKJb5Z+zQ/S0Oyi6S8I8H0=;
        b=qbZ9bYXv/dXcjINuaGXdeLJaI1Zc8kQ3nDD4FY7jOV8kH6PCutyFh0nuQ+EavytT+l
         YfrCOMvY+M2jr60PScHpij5Vo+NZVbmQzlB9XN2bbSTH4nwzcqmT3Y0Ep0wix814Vvyh
         DN9YWvCIy42Fd1502HQxkM5OQ4Rh8Q6JESAJfSoTQsx2bTfpwxVs5GB18CTagnyvSox0
         hvi7f2iB0z+1rZFD/wg3zJynzADQXXkR/nK0pIOrdDQp46JSj531dB+zKrkuN+TchUHB
         UxWuBRKzfrZwa02rsQ71nN9CYchSZi5k/7tHal4B1vAx7Lo+DhpNZTsOhrc7eJR4LZ3Y
         onSg==
X-Gm-Message-State: AAQBX9fnuAWl+5ENy8HEcZWiW1Mu8MXTmYtidfFg/5DD6NFFyqg+tOOx
        n5uVA2A49ae7Z85z9ixClPZ+A6yS+O4=
X-Google-Smtp-Source: AKy350bE4G7ZTJZiQYvfM4ccBsUv/A8VXFzUqtqncbdB5tJlj7aYNcrbFSNx/CFYrmkzeZI4bTpWKQ==
X-Received: by 2002:a17:906:774a:b0:93e:3194:99cd with SMTP id o10-20020a170906774a00b0093e319499cdmr6067090ejn.12.1680770823528;
        Thu, 06 Apr 2023 01:47:03 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hb18-20020a170907161200b0093344ef3764sm516174ejc.57.2023.04.06.01.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:47:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkLGo-005PH7-1S;
        Thu, 06 Apr 2023 10:47:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] t2019: don't create unused files
Date:   Thu, 06 Apr 2023 10:44:06 +0200
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-7-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230403223338.468025-7-rybak.a.v@gmail.com>
Message-ID: <230406.86h6tttn21.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 04 2023, Andrei Rybak wrote:

> Tests in t2019-checkout-ambiguous-ref.sh redirect two invocations of
> "git checkout" to files "stdout" and "stderr".  Several assertions are
> made using file "stderr".  File "stdout", however, is unused.
>
> Don't redirect standard output of "git checkout" to file "stdout" in
> t2019-checkout-ambiguous-ref.sh to avoid creating unnecessary files.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t2019-checkout-ambiguous-ref.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
> index 2c8c926b4d..9540588664 100755
> --- a/t/t2019-checkout-ambiguous-ref.sh
> +++ b/t/t2019-checkout-ambiguous-ref.sh
> @@ -16,7 +16,7 @@ test_expect_success 'setup ambiguous refs' '
>  '
>  
>  test_expect_success 'checkout ambiguous ref succeeds' '
> -	git checkout ambiguity >stdout 2>stderr
> +	git checkout ambiguity 2>stderr
>  '

Ditto earlier comments that we should just fix this, if I make this
">out" and "test_must_be_empty out" this succeeds, shouldn't we just use
that?

>  test_expect_success 'checkout produces ambiguity warning' '

As an aside, we should really just combine these two tests.

> @@ -37,7 +37,7 @@ test_expect_success 'checkout reports switch to branch' '
>  '
>  
>  test_expect_success 'checkout vague ref succeeds' '
> -	git checkout vagueness >stdout 2>stderr &&
> +	git checkout vagueness 2>stderr &&
>  	test_set_prereq VAGUENESS_SUCCESS
>  '

