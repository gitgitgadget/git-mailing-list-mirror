Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B97207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967641AbdDZVGM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 17:06:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34265 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967638AbdDZVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 17:06:10 -0400
Received: by mail-pf0-f182.google.com with SMTP id c198so6020248pfc.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kpue+Hvo3GRe4Jsr14LtdHBEOit/xidm8q8UcftNQjc=;
        b=aPPMF2+RZLkLhp07Hj6dwJsTYZTg5An2vX0EEwUlyiWcoNHDSNO4eMlTuy4QRU/PkU
         8JX4qmpbWWjNO3q0oUIn78vGhaTZQZ30ADOn5RYevERKI1GS4YUnI0ti3SgrSALB96y9
         Ube12m6mCOwFVLT4326CAnQd3F/J5YzDePSh2eMiskIv60cFqOaGi7xmVEnytqg8g07S
         +4hHdT5YEvFX/8xvOKJvg9patdGcWSy1LIqf3s1uJCeE9Ji+IvdUEt+UFwIPyDdokFtv
         mVjVoYCQ3Xs1L4P1I64SiS/WbWFRPkNLKeJrZr5MmYHDiS6OYNq6v/Ud9BlCE9WXbi6V
         UaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kpue+Hvo3GRe4Jsr14LtdHBEOit/xidm8q8UcftNQjc=;
        b=hultic/lAg+73Cit5Jmg6a1zaihoYYPuxsUxaJgNKwq4oiasPPQAQ3sCdEThbruXJR
         Wy65oGmUrZTP3XqwovaB0g60ztYrgnrt4vPZbgrbziR73qMU0s8e34pU15pR1jjL5TVl
         2YW2qkZoNkAHFRUofMMnyiKkIEmCCRo8wd13ibkDfhGVlmaE7S52wJhlF+5IBtJIcoHk
         F023CeGiAu9mnXkTpUahA72t8hI91vSKZAVCUiaUMBCyQctBfemg66IYKc2JCGIBrOSx
         BjOfxPYttbRoSxv/oBZ14fa8YcZVQG/+/T7lybGMgozPu0NoYYzy1TKaUOVEp5XFfqat
         vs6w==
X-Gm-Message-State: AN3rC/62qkFx1fFVgY8naCR+FMK0RV/8fgXOCcFiGaeHGQwXICharNcN
        VjqgzQ0wcttosWPHhMFL07mOkrzGtiEQ
X-Received: by 10.99.126.23 with SMTP id z23mr1942505pgc.63.1493240770062;
 Wed, 26 Apr 2017 14:06:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 26 Apr 2017 14:06:09 -0700 (PDT)
In-Reply-To: <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Apr 2017 14:06:09 -0700
Message-ID: <CAGZ79kbQTbFEtg7N8kpnWDhPmuVyhc-=gey7ca0XobgOwE8Q3w@mail.gmail.com>
Subject: Re: [PATCH 06/26] get_mail_commit_oid(): avoid resource leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 1:19 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When we fail to read, or parse, the file, we still want to close the file
> descriptor and release the strbuf.
>
> Reported via Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/am.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 805f56cec2f..01b700e5e74 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1359,15 +1359,16 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
>         struct strbuf sb = STRBUF_INIT;
>         FILE *fp = xfopen(mail, "r");
>         const char *x;
> +       int ret = 0;
>
>         if (strbuf_getline_lf(&sb, fp))
> -               return -1;
> +               ret = -1;
>
> -       if (!skip_prefix(sb.buf, "From ", &x))
> -               return -1;
> +       if (!ret && !skip_prefix(sb.buf, "From ", &x))
> +               ret = -1;
>
> -       if (get_oid_hex(x, commit_id) < 0)
> -               return -1;
> +       if (!ret && get_oid_hex(x, commit_id) < 0)
> +               ret = -1;
>

In similar cases of fixing mem leaks, we'd put a label here
and make excessive use of goto, instead of setting ret to -1.
As "ret" and the commands are short, this is visually just as appealing.

Thanks,
Stefan
