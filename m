Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11171C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 23:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBWXhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 18:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBWXhH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 18:37:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A95BB80
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:37:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso953663pjb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j6T+4PO053fjpK2nl2IducfqbHtbFVEA2UFUYV1m98c=;
        b=NYjNavFszMOh6NCbZadO9wNeE1Ab4EoQ9sJBQXK7BQdFISKEzYtnJDEpJ0oEavm7Du
         fz/v4kETGct+7ZTYd9LtHUpNrMZssgS8gK6VuacjXACc36E2U9Mk1n01uPbIoUHwcHtM
         Unz+ERdi1haWev+uULuhLZWgE5Tvpnan43VUgIRWSuUrZbuK3GtkUdiU1aqXRdAiaP7J
         tJeHmOCwGSS7Pz0W/rN+v47D8fJ4LKDk0kE6FFLdxVtgSa/VBLqrD8m3rjEkFjwoGkQf
         UIgvqRh848SRWuHBaQfAvPew71kryeBOEJceybrcIE7dCAoB4HzpTIH8Smd0DJDpcTyT
         tasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6T+4PO053fjpK2nl2IducfqbHtbFVEA2UFUYV1m98c=;
        b=eWkD7TsjAsNU2HY0RDpoN63Wd6Ea+xl+K05UWQ5fngUsajrLUYU3w7LWX7S3T+lnMA
         MylO4ciybctiCDoCoTBy4zkjkolqFPsVphtt+DEb0WOUXW+qU9ve9lkNx1SYu/xVUsen
         xzjLO1iczZp1Hnu7E4Mdy4RJZRrVID4hYD7Qwgd1uXMz4i2WPybp2BBN7dn98jPkWQDx
         qfLUcrrsHSt8WCKRPAA2IWTRb4i0RRtmEeJWX9T0ixyqOw6j+dkFFr5SiApRIcRAVViN
         ueBTLG8HJlThWUu5gWR3mYfzc7VaYOsWQTSclYw7P0pPbDTICAznEAsLBNJkjy9FjxNu
         YWFA==
X-Gm-Message-State: AO0yUKUHemQ/v4fHyV9GCZx+F8IJTXnFkrTVtGkwsPlrjreP5Sh27P/c
        bevdBInM+8j+kcl2Bnzj8qs=
X-Google-Smtp-Source: AK7set8tgnA6Hjc/PQzHZTYezaJzToUV1zKECdsX6onbocUN+G7DpJA9npdoxB7XqKL9XFzr6qbsqA==
X-Received: by 2002:a05:6a20:3d22:b0:bc:96bd:d701 with SMTP id y34-20020a056a203d2200b000bc96bdd701mr17190529pzi.13.1677195422644;
        Thu, 23 Feb 2023 15:37:02 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c17-20020aa781d1000000b005a8aab9ae7esm2103590pfn.216.2023.02.23.15.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:37:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/16] t/lib-httpd: enable HTTP/2 "h2" protocol, not
 just h2c
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
        <Y/dIxHI9iB5KGOR5@coredump.intra.peff.net>
Date:   Thu, 23 Feb 2023 15:37:01 -0800
Message-ID: <xmqqfsaw3qea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 73c49a4474 (t: run t5551 tests with both HTTP and HTTP/2,
> 2022-11-11) added Apache config to enable HTTP/2. However, it only
> enabled the "h2c" protocol, which allows cleartext HTTP/2 (generally
> based on an upgrade header during an HTTP/1.1 request). This is what
> t5559 is generally testing, since by default we don't set up SSL/TLS.
>
> However, it should be possible to run t5559 with LIB_HTTPD_SSL set. In
> that case, Apache will advertise support for HTTP/2 via ALPN during the
> TLS handshake. But we need to tell it support "h2" (the non-cleartext
> version) to do so. Without that, then curl does not even try to do the
> HTTP/1.1 upgrade (presumably because after seeing that we did TLS but
> didn't get the ALPN indicator, it assumes it would be fruitless).

Wow, that is tricky.  Nicely found and fixed.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-httpd/apache.conf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 51a4fbcf62..693b75e0ae 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -31,7 +31,7 @@ ErrorLog error.log
>  
>  <IfDefine HTTP2>
>  LoadModule http2_module modules/mod_http2.so
> -Protocols h2c
> +Protocols h2 h2c
>  </IfDefine>
>  
>  <IfModule !mod_auth_basic.c>
