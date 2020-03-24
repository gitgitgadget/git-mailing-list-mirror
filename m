Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B3FC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153292076F
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neb56Imx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCXSeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:34:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34912 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCXSeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 14:34:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20so21949475edj.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/55Cn3EPQP120bXMb4LE78NUWtsDx5IvPib0Xvm2ko=;
        b=neb56Imx40Wx8DZ8swJLMDUWnh9uaQZWCpjjWfHGsYJwV1aG9jFTzXjuXMPwRWU+MU
         Y64rXoPjgcGL/zBXQaE/QdZ40Foe8Ag9iiaLLmM410CEsnmn5P43OuT/RB2aZC5BscE0
         U5ssFWdniFTgZC/7o1ED89aKtX4BenSNgcBi/B7VfMUtXH+MgeAq7MUhHZwtcA7/FyFg
         Hu9qo1Xz1CvptwKg2zjq/wPVw0Y7sovFT0DONb4y04hiP7RRa8pkMT4jri14o4Ebz9fG
         yHqVvICLtxPxhr5KEHN05uzVMIlSA+T1KXKn6n/tmtBk9c5xjnHE9ZuT5QzRnUJrNZos
         LAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/55Cn3EPQP120bXMb4LE78NUWtsDx5IvPib0Xvm2ko=;
        b=jgt+yxgZMm5MuxC4PPEDoPNcRGQwNAvaD05gs8kOKrt1cHWO5aBxGvKNS217Q+25iG
         iczLpk7xuLA6NcvJX8n9FgWNM8orgB6MR8tIBbjyDYDQItBOmuhIokdeeje+2CYHERQR
         u89SJwi/pdqgePP70YP9fjrrWnkc3pm+oeHiUToo/IwuJKmdCBQQeJyLKcOYqVayhFki
         H4SpHlbCXTmsSLT8jmkJ86bbrkf6eYDJgtDmHqI7VD3+t/kAaCsj9i6JA9NWKTn4kxVe
         1ZZe0eOQzE0aPZ4lQockQn4/JXc+7gEOtJC2gHDB2zN9+IKypxP9wv5EpR2afunh1Hrg
         eVRw==
X-Gm-Message-State: ANhLgQ0qetY1CcX70lQuXHtS294457Inpacww9Y6JxoZvjRPYPM1cegA
        T7ATYw9JY6hiPf+tMV9A7LNrZ2WAAr96jbbqHVQ=
X-Google-Smtp-Source: ADFU+vv6S6fvlNk5HL7jtmN7niRvq1rB52Op4gjhlJNQDzuGfDbNWhOo9ScubfU5kMuMSfvcShy9WpbraJT43y6h88I=
X-Received: by 2002:a50:eb4c:: with SMTP id z12mr28214022edp.387.1585074853870;
 Tue, 24 Mar 2020 11:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com> <20200324093502.32394-1-shanthanu.s.rai9@gmail.com>
In-Reply-To: <20200324093502.32394-1-shanthanu.s.rai9@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Mar 2020 19:34:02 +0100
Message-ID: <CAP8UFD2Uu-dPJcZB--T7k0tMuXc0iVeqnMUn3Y_x+3iaFf9xFQ@mail.gmail.com>
Subject: Re: [PATCH v2] t9116: avoid using pipes
To:     Shanthanu <shanthanu.s.rai9@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 10:36 AM Shanthanu <shanthanu.s.rai9@gmail.com> wrote:
>
> Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) recommends to
> avoid using pipes, since the exit code of upstream in the pipe is
> ignored. Hence, redirect the output to a file and parse that file.
>
> Commit de26f02db1 (t9001, t9116: avoid pipes, 2020-02-14) noted that
> this also allows easy debugging in case the test fails, since the file
> will be left on disk and can be manually inspected.
>
> Signed-off-by: Shanthanu <shanthanu.s.rai9@gmail.com>

We usually ask for a legal name in a format similar to "<Firstname>
<MaybeMiddleNameInitial> <Lastname>" where <MaybeMiddleNameInitial>
can be omitted. The name should also match what is in the "From:"
field of the emails you send.

> ---
>  t/t9116-git-svn-log.sh | 53 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
> index 0a9f1ef366..56d68e4aed 100755
> --- a/t/t9116-git-svn-log.sh
> +++ b/t/t9116-git-svn-log.sh
> @@ -61,12 +61,16 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
>
>  test_expect_success 'test ascending revision range' "
>         git reset --hard origin/trunk &&
> -       git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
> +       git svn log -r 1:4 >out &&
> +       grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
> +       test_cmp expected-range-r1-r2-r4 actual
>         "

It seems that the code that your patch changes is repeated a lot in
this test script. I wonder if it would be better to write a shell
function to avoid those repetitions.
