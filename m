Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1559C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52FF6140E
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhEXU1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 16:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhEXU1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 16:27:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CAAC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:26:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so11853576pjv.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oBD2eS/6GVa/GHaLk5IRWnFUVRJeuq44GaT8O5ISPhs=;
        b=fP7++yi4pKOCJtMk95nao2VehQpdiNfmp8Ex8kGKwUHtbt+3WGzq2A/59xvEzZNsxd
         0V2IQ0PzwT36VAo0p+6GSKI/HzGkD1+laDxXExnZePkcRFP5865IkVvh7FA/6Wu5BprL
         0rvktTPrcRnYOAR/9udSX1gfFmTDKSK+vao5NW3NVJaGkSIiErcCVrXYnjPLqykR9QSS
         1WFlZV924STAZzFWW5Gn/12b9uHtFkDKXMZcJUeqvjT31ylPmuVhOmMZyr1FnFdxNdjl
         /JpKhocC4a5JRkq007vYFSJ+XhHsN89+Nd5az/Rh+XkTAd6OESPescO38bfcVBJjjI2U
         PmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBD2eS/6GVa/GHaLk5IRWnFUVRJeuq44GaT8O5ISPhs=;
        b=m+P7esgKHSNU21T8f65XkaRQ3Vc9EsaE03VbRqm9g3U1F2YVqFgKyFDpzxhORKhS4T
         RV4Yoo0Pqlr06vo7judbiUsL+bDG7pbQV/heY4pB3xCAlg63n2m5kMXn2xyq2n1Nh9gK
         Ui9/HD/lEp4BtEOz0bYtSqiD2AQnP3UPKOjCwWZqSbnmYx9g4h5qMhtqAyBhXV8EnjvJ
         ednBQ74uFlp+hIELfsmU7GcWrgcg7TtR1D2GC+jVyyYBsJxNyT+xJLiEW0tB88UfKdoV
         eToQUFebajFHNxnqS3P0WfRi375UeB3IFNClfCf2N8E8pyY6j61EtU9S/W3nBDpiqGVA
         b59A==
X-Gm-Message-State: AOAM530u8v3ltHq7T762RKtOMRLEwU0oMpz/jvdR+bSylZhV+2ndPQzg
        prXkuvlYGZSUqw4cJlXy56I=
X-Google-Smtp-Source: ABdhPJxcv6V7QNeex5uFxg89yLfXZbausyPLJ4MPA+hKXu8Dxb2deMtkQDrpul925IOyxH7/7+xvZQ==
X-Received: by 2002:a17:90a:7442:: with SMTP id o2mr980198pjk.44.1621887969158;
        Mon, 24 May 2021 13:26:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ae43:6046:39d1:c30a])
        by smtp.gmail.com with ESMTPSA id o4sm10944583pjf.9.2021.05.24.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 13:26:08 -0700 (PDT)
Date:   Mon, 24 May 2021 13:26:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t9001-send-email.sh: fix expected absolute paths on
 Windows
Message-ID: <YKwL3t8bKIh6LPsE@google.com>
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Sixt wrote:

> Git for Windows is a native Windows program that works with native
> absolute paths in the drive letter style C:\dir. The auxiliary
> infrastructure is based on MSYS2, which uses POSIX style /C/dir.
[nice explanation snipped]
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  When I say "the configuration is transformed to /C/dir style", I am
>  actually hand-waving: I can observe that a transformation must
>  happen somewhere, but I actually do not know where the conversion
>  really happens. "The MSYS2 layer" is my best qualified guess.

Thanks.  The explanation is appreciated --- it helps avoid the feeling
of randomness involved.  Hopefully some day our test setup will allow
doing everything at the "native Windows program" level (well, I can
hope).

[...]
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -539,15 +539,14 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
> +	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual

Ideally we wouldn't have to check the exact output at all.  Is there a
reason we care about the absolute path being echoed on error?

[...]
>  test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
> -	hooks_path="$(pwd)/my-hooks" &&
> -	test_config core.hooksPath "$hooks_path" &&
> +	test_config core.hooksPath "$(pwd)/my-hooks" &&
>  	test_when_finished "rm my-hooks.ran" &&
>  	test_must_fail git send-email \
>  		--from="Example <nobody@example.com>" \
> @@ -558,7 +557,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
> +	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual

Likewise.

That said, the patch as is is
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
