Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFDDC433E1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 05:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FCD61999
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 05:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC3FmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 01:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC3FmA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 01:42:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87277C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 22:42:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h25so10925970pgm.3
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 22:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m2ztZ8Qjkfm3FTttel3x5OSx3sOMYf/F5UYeoUvAxM=;
        b=WlQSQQvrIEqr3Y5dTV+5I8FLDsibwM93PvEDkZLuXpU7nH9pnEA7TbmRtaLcUH+5IZ
         m5tna+Q5kaHu+F3QwXSxyGylgEfdxbnwmkfYamrEmAPRmGNiGl5lHNGxia+D1rEuoYQh
         hkI89t2LuO4cOpClcy0t3kgl16Ryfoy8P98YuYDGQudB9Ooxfqce8Vgz6+Lty68IZ+/j
         biHihQO0crtJhrP7Se+LeFPp4Iw49fWcuzRBWB/x6y6CRGMqOCtojocNe3GlzVqQLQiq
         ZlyJ1Dcv/uOhoTZ6DLs5R8pEiggw9/wTMecFuL0frSwDXKZXb39GZ0A25Hhv/GX5zXAr
         Rmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m2ztZ8Qjkfm3FTttel3x5OSx3sOMYf/F5UYeoUvAxM=;
        b=XZej85CgiGoWDkpCHNXTTI6g3yJ6fNscUlIpYDqx0Dg1AaSL/JYE6jvNZHkgEaoI8r
         exTjGiQeJD6HNW/vEdwNQwUmbA24Ai8A4htQCQrUWV9N7cydSmpARvDNbzQrDyndLedw
         lODMrXcIdSG5kratczLDHBCLSWPodDvLc7vluL3e4BwHmasNJhkZjRahYym8OjkKZuAc
         4J462Yjd2X8oaxxuIZjJQ1NRvKP6+omLUraxP3wGMoJ2g7XpaHAjkYAGYOWihO4dmBcW
         ClQiDybECcNdFR/koiO/SYZMHzTsM7zlMjhBhVf5vAqEpGTuhxnt4GByOscdxEZrQ5m+
         ORUQ==
X-Gm-Message-State: AOAM531bBBTCUyr0NFXjL5Ix+vcAZT00jTvqOQZAdXiJz4EAHAdfrPJc
        tYesHMiKI/rgkDWPNo5fo/+4OrNjSyruLyQmYibcQ6XPbcw=
X-Google-Smtp-Source: ABdhPJz53Rez7BG/vEKP3xH1S4Ku7tZrLi1WoNhVsCJ9B/0EFHQRveqoijVUifNDlrrFADnCxv+zoNTYmxQvCbwL3Vk=
X-Received: by 2002:a62:3201:0:b029:211:3dcc:c9ca with SMTP id
 y1-20020a6232010000b02902113dccc9camr28469004pfy.46.1617082920034; Mon, 29
 Mar 2021 22:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210329210928.561586-1-me@ikke.info>
In-Reply-To: <20210329210928.561586-1-me@ikke.info>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 30 Mar 2021 07:41:48 +0200
Message-ID: <CAN0heSrSNJhy33Wi9Yq8kfnkJEyvQoadyj8joLqHtV+SYPs1sw@mail.gmail.com>
Subject: Re: [PATCH] maintenance: specify explicit stdin for crontab
To:     Kevin Daudt <me@ikke.info>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 29 Mar 2021 at 23:23, Kevin Daudt <me@ikke.info> wrote:
>
> There are multiple crontab implementations that require stdin for
> editing a crontab to be explicitly specified as '-'.

[...]

> --- a/t/helper/test-crontab.c
> +++ b/t/helper/test-crontab.c
> @@ -17,7 +17,7 @@ int cmd__crontab(int argc, const char **argv)
>                 if (!from)
>                         return 0;
>                 to = stdout;
> -       } else if (argc == 2) {
> +       } else if ((argc == 3 && !strcmp(argv[2], "-")) || argc == 2) {
>                 from = stdin;
>                 to = fopen(argv[1], "w");

Would it make sense to make this

  } else if (argc == 3 && !strcmp(argv[2], "-")) {

in order to make this test-tool as picky as possible and to only accept
the kind of usage we want to (well, need to) use? The tests as they
stand would still pass, which I think argues for us not really needing
that "argc == 2".

This would be followed by

  } else
          return error("unknown arguments");

which wouldn't be super helpful if you forgot the "-", but helpful
enough for an internal test-tool, I guess.

Speaking of usage and hints, there's "Usage: ..." in a comment at the
top of this file. It should probably be updated either way.

Martin
