Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A88C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiB1JoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiB1JoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:44:05 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325581B782
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:43:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qk11so23588800ejb.2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UuxhGGijTPOL/cpuYlk1U94LcOLnO7AkeluUqftjWU=;
        b=gZZP3k2WhD//nzRBfwSJKldryXkoCiLxIzuSa5ViMNY49Dp5iuotV9bSJKMqmTrx5T
         yhoO9hFtQL7ymxV0momfIUyvLGrm0nKMJlpT9gr/dpcL+v6vkz7s5EBKL6XRJzsAs0o4
         EPUTIuS8YXrPFz8J+sKL7kQaw59xzNgs727uPXjT6fGkkLJm2hrYQmyuXENAjaRCS5Q5
         T4TiuNwFNVcxN8sE1jFn9il0CjWynCagf1tOeRktXi5wMdnyWyVCEASy7rg0YI0j2dQf
         jyd4RXDWTq7jID1dJWCf4txEoHr/cFr/dzhCsLkqAWPjdCZ1LE+ZwAjV/hLYbFa3X5td
         +NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UuxhGGijTPOL/cpuYlk1U94LcOLnO7AkeluUqftjWU=;
        b=SjE4SZpvKq3A7iMoDyLNxoOLHXE19c0ojx4DhF2uBy8EZBulGY0R9+X48/pJeDeKE7
         pldUh0BtOhKEVqRjUB9aj+OQz39UpwFz2nmWWkSPnpKQxRvXHBDgdyk2VuyNlZ0Kod3E
         YM6pWnLjQ2r51YWzVpuvxscViuG0hQhRGsW4GW0Hegc0/0FSXqGMc50ZUURMXMgFcvwI
         JQ/BEz/vYvhGL+GEIOLMZ3vuLd0Nr6E6ow5VU1tX3ZCyW7VYGJwVs6xODv5pwbZxRNS7
         joH7yj8V4QJKv5Hr9wKOcFgfNCIX0IPPE+aIgERIv4oXPwtzJbajy3iz+WvhEtx62NsY
         IIew==
X-Gm-Message-State: AOAM532PWpHdgswb5bwR+DxS0gNehWSBC5G7qsrbtf7sGS1+HKh0wAPm
        WG6QTv/FZUjullr1dLKjRyczfAL0Bd2UwzSmDPTH6Q==
X-Google-Smtp-Source: ABdhPJy35Ceas2Q4hICsqJs7gjm3IkZWQO6JMHxYBy8BBNTPDQQaUh29hkoQMbCn4IBZFFcWlIoA6UUwE163lRPZ068=
X-Received: by 2002:a17:906:dd3:b0:698:3e07:dcee with SMTP id
 p19-20020a1709060dd300b006983e07dceemr14589374eji.487.1646041399762; Mon, 28
 Feb 2022 01:43:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <6cba1d950b013410ecc6ffc15bfcba02c51d6de2.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <6cba1d950b013410ecc6ffc15bfcba02c51d6de2.1644612979.git.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 28 Feb 2022 10:43:07 +0100
Message-ID: <CAPMMpogycjDdoFR2kzLypb48LSQW_vU=yaeaMKdM1Thd+J3DUg@mail.gmail.com>
Subject: Re: [PATCH v5 23/30] t/helper/test-chmtime: skip directories on Windows
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Random follow-up on this: in message/patch
76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com
I propose a fix to this issue. If accepted, that fix (and related
changes to rely
more heavily on chmtime in t7063) will cause *this* change to cause test
failures.

If that patch is accepted, this commit will simply need to be dropped
as far as I understand.



On Fri, Feb 11, 2022 at 9:57 PM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach `test-tool.exe chmtime` to ignore errors when setting the mtime
> on a directory on Windows.
>
> NEEDSWORK: The Windows version of `utime()` (aka `mingw_utime()`) does
> not properly handle directories because it uses `_wopen()`.  It should
> be converted to using `CreateFileW()` and backup semantics at a minimum.
> Since I'm already in the middle of a large patch series, I did not want
> to destabilize other callers of `utime()` right now.  The problem has
> only been observed in the t/perf/p7519 test when the test repo contains
> an empty directory on disk.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/helper/test-chmtime.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
> index 524b55ca496..dc28890a183 100644
> --- a/t/helper/test-chmtime.c
> +++ b/t/helper/test-chmtime.c
> @@ -134,6 +134,21 @@ int cmd__chmtime(int argc, const char **argv)
>                 }
>
>                 if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
> +#ifdef GIT_WINDOWS_NATIVE
> +                       if (S_ISDIR(sb.st_mode)) {
> +                               /*
> +                                * NEEDSWORK: The Windows version of `utime()`
> +                                * (aka `mingw_utime()`) does not correctly
> +                                * handle directory arguments, since it uses
> +                                * `_wopen()`.  Ignore it for now since this
> +                                * is just a test.
> +                                */
> +                               fprintf(stderr,
> +                                       ("Failed to modify time on directory %s. "
> +                                        "Skipping\n"), argv[i]);
> +                               continue;
> +                       }
> +#endif
>                         fprintf(stderr, "Failed to modify time on %s: %s\n",
>                                 argv[i], strerror(errno));
>                         return 1;
> --
> gitgitgadget
>
