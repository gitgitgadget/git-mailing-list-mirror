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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D861C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B64A61205
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGDIb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDIb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 04:31:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB6C061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 01:28:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l24so19515855edr.11
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HuncHYoN5Dd7Q3WUKPVLKKxjVUxaArfCx7pbMfZBHwc=;
        b=h/vHf1b8i10KIlMSMJ2urIMW8Mnh6d6HCuElvqBvL49mfdBKQxufe2tNICjohAs76M
         3yU0C0UB9f9tOsO52tYmvkX0jxwGgBsnct1uU5Q+kITN5rnn49j7O+k2KvRBfBHZoElU
         8XDUn6pcmdtd3kOJzhCkk8lWLwIwOyKDrBiXdzPdIb8zkil4QDb0wMAh07EY4yUPkuza
         /3rAWtoJyPSImaTqLLgYB1WQj+ZUAuF/vv4l8cpS8yeLi17l8hQIXDUvUty6JcOEIfHh
         C9AIxH0GvYGZxuFy1qa8pUFd0j1vchfpvMQMY5eM0dDKl4PzjMzGgO6z7P6pBqNIF6dA
         YOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HuncHYoN5Dd7Q3WUKPVLKKxjVUxaArfCx7pbMfZBHwc=;
        b=K1m5euxMiHSp//2ACkKmSf+o8i6aebAr4eNp+HitTVLqubZVa1xe7zNA/CmtDYm34S
         xiXsgC8dlRq+0jUZhHb3Dg8sCdPUDBZcIgYe7vwW82pA6ahFi/KUibVbYcF7367TOOrW
         unIzOgnlhFtQ5LX1oUvoiMYxYp+kGmM72/38l4AQx3PifdnQSqqcmLVzacphLHAxgZTk
         L5JETeD+Z6RzTy+Ms0gTA5dP4UWwzUYcg8mldo0ZRlL7CFVLM/46mSSJkaUvQ/OSil0w
         GnyxThymR+WL9xxMq8NTbHuppv2sgv3YlmluhJdONF0b0j+/8uZKD7u1h/eAjEZ2pDqy
         Tg5A==
X-Gm-Message-State: AOAM531xwI2ZBecXo43LmdQKTJPYtt+v2ChM9APHuJiLd9Wq1TNk6AT2
        gLBzNTs+NzasQ+iOrYYlGbs=
X-Google-Smtp-Source: ABdhPJxYe+O2GgJR3msjVtYQywzianBAHLSmzAPopIIfObBxyCcVgoEZbkK8yXFvK4b4PnC19H/Y/g==
X-Received: by 2002:a05:6402:58:: with SMTP id f24mr9731905edu.234.1625387328742;
        Sun, 04 Jul 2021 01:28:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k3sm3663811edv.2.2021.07.04.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 01:28:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH 5/6] ci(vs-build): build with NO_GETTEXT
Date:   Sun, 04 Jul 2021 10:27:01 +0200
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
 <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com>
Message-ID: <87bl7i8ou8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, Dennis Ameling via GitGitGadget wrote:

> From: Dennis Ameling <dennis@dennisameling.com>
>
> We already build Git for Windows with `NO_GETTEXT` when compiling with
> GCC. Let's do the same with Visual C, too.
>
> Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 0f7516c9ef..3b40c677ab 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -159,7 +159,7 @@ jobs:
>        shell: bash
>        run: |
>          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
> -        -DMSGFMT_EXE=C:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
> +        -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
>      - name: MSBuild
>        run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
>      - name: bundle artifact tar

To a first approximation isn't the point of CI to test a diversity of
setups? So "we already do X in job A, let's do it X in job B" seems like
the opposite of a self-justifying rationale, surely our default approach
would be to do things differently?

Perhaps this change makes sense, just commenting on the explanation in
the commit message. I think it should cover:

 * Why: Is it being done for speed, hard to install libintl or whatever?

 * Coverage: Before we tested on this platform with this knob, do we
   have another CI job that covers what we'll lose in coverage here, if
   not is it OK because it's tested in some other way etc?
