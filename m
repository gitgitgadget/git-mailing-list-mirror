Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D182027C
	for <e@80x24.org>; Tue, 30 May 2017 19:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdE3TNU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 15:13:20 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33055 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdE3TNT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 15:13:19 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so80717790pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uDvqK5yKHvj3FEdzgPvDV2o1WBFHodzoJwskZ7roHVc=;
        b=nXFKG8bkqM6mlyEWc+vc6ax3l8J0GUu2aRA+AOmPb63Njfn7vihOLbEfkQh0DwJHB9
         yhK1baHxBeh506+MoizRe1y8ujd6qoVvcsxigE4bVhsqSDMeomaclgasDixxhK32SGgH
         l7TvTbJ13SWn7oBehpDn8zNg8lig6JE1PQp6cn36JUHWtBz6LsdhJwGoAO0xK5snQWG9
         d44qz2swWsKBU+kSifepJl+qMAJXrogUY/Fk66SvCcIMbtlQ+/vGLP0GUIXWQPW4yuFg
         f3yC5RxfOewKv29FsViPuoFw83+lMQABu+vacg4lOAJgtamnMWxKUaLbu8jYPg3TKwwx
         oJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uDvqK5yKHvj3FEdzgPvDV2o1WBFHodzoJwskZ7roHVc=;
        b=NWoQi8cVfUj9YEYIhQs1+OnOGkoEc5VFGN7tlp6uLuQYkZwCE23Cbc0ekHU6E1clYB
         mukkipT5aMwrAskXQuTWS1p7b+2havSKAp0/mmBESq9ApwGqorWjM9bKmEN2MHqPLIxY
         aeoJJNLT3ezO93lewACw5tQIIZlrwnEGHhQL6ShEBjAGPrWHDATb77GDxdUM2vf8yGYn
         /qfUv30Ge28OzLbgRoiGXcKtdyEW+Ek0fEj2h2SuXGIWHLtigSgB3N+QtCWy6zwpGDyJ
         3LTJX+0jhRV85kCXv3q/FdL8MafN8IuvrcfACuQkm1nqxNPMI2uXS8zNGzKRU8u+CM3R
         op4Q==
X-Gm-Message-State: AODbwcC/m7MAGadEROtPlLtm1QJLiHnnGACffHfzCUu7puovb9QQg+Go
        MThqcpHYuEnlVerM4yPQIQ0Czi9H+dGU
X-Received: by 10.98.236.150 with SMTP id e22mr25350984pfm.48.1496171598950;
 Tue, 30 May 2017 12:13:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 12:13:18 -0700 (PDT)
In-Reply-To: <20170526033510.1793-14-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com> <20170526033510.1793-14-gitster@pobox.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 12:13:18 -0700
Message-ID: <CAGZ79kZC4WM=aXPO9Rk1GQ7+XKUhoWUZefjM6Trk-11QcrhBYA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] is_missing_file_error(): work around EINVAL on Windows
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When asked to open/fopen a path, e.g. "a/b:/c", which does not exist
> on the filesystem, Windows (correctly) fails to open it but sets
> EINVAL to errno

errno to EINVAL (as of now it sounds as if it is a EINVAL = errno,
which makes no sense to me)

> because the pathname has characters that cannot be
> stored in its filesystem.
>
> As this is an expected failure, teach is_missing_file_error() helper
> about this case.
>
> This is RFC,

cc'd people knowledgeable of Windows.

> as there may be a case where we get EINVAL from
> open/fopen for reasons other than "the filesystem does not like this
> pathname" that may be worth reporting to the user, and this change
> is sweeping such an error under the rug.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  wrapper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/wrapper.c b/wrapper.c
> index f1c87ec7ea..74aa3b7803 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -434,6 +434,10 @@ static void warn_on_inaccessible(const char *path)
>   * see if the errno indicates a missing file that we can safely ignore.
>   */
>  static int is_missing_file_error(int errno_) {
> +#ifdef GIT_WINDOWS_NATIVE
> +       if (errno_ == EINVAL)
> +               return 1;
> +#endif
>         return (errno_ == ENOENT || errno_ == ENOTDIR);
>  }
>
> --
> 2.13.0-491-g71cfeddc25
>
