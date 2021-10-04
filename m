Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECDAC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DE96121F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhJDN4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbhJDN43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9037BC061250
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:46:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k26so14546828pfi.5
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zTRvmHgzLka2TrVM7TVKTAc1KFh9dacfgm/5aNWMquk=;
        b=o2KopnRAu/V8si9rctLho3U8pPAX1lve8sfWR0S/mp54UoNvNcuxNakBVbBrZFF+9i
         aFIgxe0HeckXn4hZBLMjEyKj7dJLI/NVXEu2RLq6gShxRwcRDg9wwf4VKQXb8+zoFOPe
         2cba7pE9NvS2G0mTnu2A3oN/TEVNTTqgTVWTlUIlSyVPMyWnx04jsqfryqmcO9RBAcvt
         UEW9hnEk9ChPayVdhIZuRvq3GtuC5qDZ6Y9BfzUDKPupt7SYLivpzCsI9lUrqwXWq9/w
         9nZXardGkL8pRv/B7b2kVsUlnV94d2jC5WleTAoXESid3cQp64tuFGhl/cBpEVAj05dy
         S1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zTRvmHgzLka2TrVM7TVKTAc1KFh9dacfgm/5aNWMquk=;
        b=h2UJkJPOP70xq1ravgabrND3RY0OYBlhZnfnHT7k7JNg/ha7KjwBIbusX8tOMsU3AN
         KvIButKIjTt/890p70+a6PBJ52nlTRlYkFISvwZng7zfmUmCaPuqKKsy+egLgOCw3VwN
         GZliJQDNVflb0sRy7Ek3KuRUXtVeDyjypk1rbmQRzxkS7N57kDtuCP63mjJMsDWIo+X4
         ChwxE2WAdHJeNXZ3FG/r0mUq4ZFHGcAa/mVyPvB/8wyBDH1VhPNxJRoiHMAJhPczMPDK
         RhmZL3yi7NaSm/ol+XnLtHij9MXyJ81VRWcgm44LYfVharkXgAfYEf5HfGMTWM3NmaJi
         3XNw==
X-Gm-Message-State: AOAM533DzkAn9iZkhe38y7tFQ3xAWGB36KNZoFhtUvgP9x8ptTmE+Nk8
        xyS9QyDru+kqliA6M1g2ECYiBHI6+PTLzn35fls=
X-Google-Smtp-Source: ABdhPJzs9pejhc+gbxvS1KYdoSOeF9SmUl58oyQPUctM2LjNAwKTQ1r3B2SRiENI2N5kodW5/n9vwPJ7sNzjGYVI/nk=
X-Received: by 2002:a62:7c04:0:b0:44b:e071:2089 with SMTP id
 x4-20020a627c04000000b0044be0712089mr24951873pfc.80.1633355163008; Mon, 04
 Oct 2021 06:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-06.10-2b243d91696-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-06.10-2b243d91696-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BFpyyJ-e8p5fbmCvyaEsfUow=RP45Nw0ckiwNEvVC4zrg@mail.gmail.com>
Subject: Re: [PATCH 06/10] dir.c: get rid of lazy initialization
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Remove the "Lazy initialization" in prep_exclude() left behind by
> aceb9429b37 (prep_exclude: remove the artificial PATH_MAX limit,
> 2014-07-14).
>
> Now that every caller who sets up a "struct dir_struct" is using the
> DIR_INIT macro we can rely on it to have done the initialization. As
> noted in an analysis of the previous control flow[1] an earlier
> passing of of "dir->basebuf.buf" to strncmp() wasn't buggy, as we'd
> only reach that code on subsequent invocations of prep_exclude(),
> i.e. after this strbuf_init() had been run. But keeping track of that
> makes for hard-to-read code. Let's just rely on the initialization
> instead.

Having read through the link previously, this all makes sense to me,
but I'm not sure if this paragraph motivates the change without that
context.  Maybe another reader can comment.

> This does change the behavior of this code in that it won't be
> pre-growing the strbuf to a size of PATH_MAX. I think that's OK.
>
> That we were using PATH_MAX at all is just a relic from this being a
> fixed buffer from way back in f87f9497486 (git-ls-files: --exclude
> mechanism updates., 2005-07-24).
>
> Pre-allocating PATH_MAX was the opposite of an optimization in this
> case. I logged all "basebuf.buf" values when running the test suite,
> and by far the most common one (around 80%) is "", which we now won't
> allocate at all for, and just use the "strbuf_slopbuf".
>
> The second most common one was "a/", followed by other common cases of
> short relative paths. So using the default "struct strbuf" growth
> pattern is a much better allocation optimization in this case.
>
> 1. https://lore.kernel.org/git/87sfxhohsj.fsf@evledraar.gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  dir.c | 8 --------
>  dir.h | 4 +++-
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 39fce3bcba7..efc87c2e405 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1550,14 +1550,6 @@ static void prep_exclude(struct dir_struct *dir,
>         if (dir->pattern)
>                 return;
>
> -       /*
> -        * Lazy initialization. All call sites currently just
> -        * memset(dir, 0, sizeof(*dir)) before use. Changing all of
> -        * them seems lots of work for little benefit.
> -        */
> -       if (!dir->basebuf.buf)
> -               strbuf_init(&dir->basebuf, PATH_MAX);
> -
>         /* Read from the parent directories and push them down. */
>         current =3D stk ? stk->baselen : -1;
>         strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
> diff --git a/dir.h b/dir.h
> index ff3b4a7f602..e3757c6099e 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -342,7 +342,9 @@ struct dir_struct {
>         unsigned visited_directories;
>  };
>
> -#define DIR_INIT { 0 }
> +#define DIR_INIT { \
> +       .basebuf =3D STRBUF_INIT, \
> +}
>
>  struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp);
>
> --
> 2.33.0.1404.g83021034c5d

Wahoo!  Nice code cleanup.
