Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5E5C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E3E61090
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhE0MxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 08:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbhE0Mw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 08:52:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC8FC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:51:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b17so773859ede.0
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7EzJnJq4Oh1xftyZARCwFV+R6f9tetOZoSbM0F9uIZI=;
        b=KcyUCndv71yHmXfeeRh9G5XIF8iMIlvFJXC7ER3H2D3ehG1B0QX/KnbMdhYTpIKjYU
         DgN2dPOFCztxIvdtqhQEWKq3EVMADfb7jrCVRtUxTihC7K526MG+l213hqtYco3hcz5O
         5tT8JrT1jYx+80gpCVVC2bnfFAqdsPnthVvhGS1UJ8TVtkX6z3edfmHc0uXjOqv3x75A
         67bUU1KLngMENKrQy/HZuaT4qHAvqc2rjN1OXBsQz+W2Azj5nZYMTN2peQFsCVhBmWfz
         Iaj63yLK9wxW5+IdIhEh6COQrukyRoUhjybceXRP4ng7Vn74P3m+qKGcnNbaMv9pG4BG
         5/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7EzJnJq4Oh1xftyZARCwFV+R6f9tetOZoSbM0F9uIZI=;
        b=nUZ40FOrvoX9oJ0+7d4wsD4swLeG4dIcCF6Y/dITK9DzwNgp47SMUQvTM1qrb97JDE
         B6zV9PJM/Xn4V11n9ymJDwogYDwhFQj50DRp1HgpbNvfai81qSmAQj4ALCQaTQE7S5b+
         CHvnQZycoMRqSDnO+XVR8q36AEPGfxRxi0WigF9HHibqN0NbUxIozGZa2DHvdk9hMwVF
         cYHL3ESxT+/eZeA9RdVaXF0YLxh/wBSrwWo+07vGtXHm4Ba37RpsPlvTlWh/Lg9CpBvY
         H+Kpg54wOujaaYvIJehqPQ7JAv/e5NdF3d0grH8mEX9EmXo/ujVzbY0IHdcaQbnU0+C/
         lJsQ==
X-Gm-Message-State: AOAM532wirCC7ZkUPEE6Grrd0Hp3Prm8qSZMPD3TM6AlwYF5Ba7B4tzM
        LjcE8kbHyFdGR5rmLHZwWHYQHjaIC4IpPg==
X-Google-Smtp-Source: ABdhPJwRGLgFvQqQb3Oiyp/wgYG+/EEje4QJb+nguR7RTCceJs6xFt+s9Jw4fPr/vU0sh6f+gsyqRg==
X-Received: by 2002:a50:ec91:: with SMTP id e17mr3996868edr.228.1622119885039;
        Thu, 27 May 2021 05:51:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y15sm954977ejc.48.2021.05.27.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:51:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Date:   Thu, 27 May 2021 14:51:07 +0200
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
Message-ID: <87r1hsl4qb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Matheus Tavares wrote:

> t2080 makes a few copies of a test repository and later performs a
> branch switch on each one of the copies to verify that parallel checkout
> and sequential checkout produce the same results. However, the
> repository is copied with `cp -R` which, on some systems, defaults to
> following symlinks on the directory hierarchy and copying their target
> files instead of copying the symlinks themselves. AIX is one example of
> system where this happens. Because the symlinks are not preserved, the
> copied repositories have paths that do not match what is in the index,
> causing git to abort the checkout operation that we want to test. This
> makes the test fail on these systems.
>
> Fix this by copying the repository with the POSIX flag '-P', which
> forces cp to copy the symlinks instead of following them. Note that we
> already use this flag for other cp invocations in our test suite (see
> t7001). With this change, t2080 now passes on AIX.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/t2080-parallel-checkout-basics.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-check=
out-basics.sh
> index 7087818550..3e0f8c675f 100755
> --- a/t/t2080-parallel-checkout-basics.sh
> +++ b/t/t2080-parallel-checkout-basics.sh
> @@ -114,7 +114,7 @@ do
>=20=20
>  	test_expect_success "$mode checkout" '
>  		repo=3Dvarious_$mode &&
> -		cp -R various $repo &&
> +		cp -R -P various $repo &&
>=20=20
>  		# The just copied files have more recent timestamps than their
>  		# associated index entries. So refresh the cached timestamps

Thanks for the quick fix, I can confirm that this makes the test pass on
AIX 7.2.
