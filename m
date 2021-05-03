Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D31FC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B50961363
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhECN6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhECN6r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 09:58:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C6C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 06:57:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so6352849edu.10
        for <git@vger.kernel.org>; Mon, 03 May 2021 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=e1ILmmIOJgl6rlCck6XmbegRvu6cZ4bAQOxlvIV67WI=;
        b=AACRKhEIA6p57hR+ooOXp9PFx4r11Jn24FNxpjTSemyWZjR/EFsN8rlVmnMIWKs4nQ
         Op+MaDSbCRYc/wdkMJ1amz84NGRj6aMrfzrbg0nCsqNBNnpf8w9i4Uf6Wv/JScukByBy
         hD9blx6mfPHucu5ySH10ug9Wy5f/NLSHc77KF/Rl9iJ2Cz7Y3g68MoGp025qvg3get4W
         tBVUjdrUu/JvhDfqB4yLYB/dQ6L52QYnOvYovxXYGZM5jBfj7FtmMP6JfeNWEHN3wlb4
         9gtdF1luydb45aoxAKEtNWYb5yQLIuV+Y8d8iuwRyyKiCY3FsNMO4f9NagYSyuZt91xD
         KA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=e1ILmmIOJgl6rlCck6XmbegRvu6cZ4bAQOxlvIV67WI=;
        b=EPrLdf1iZWM74jw9hDr2DAm1ytUI5ynU2VwGL70xa3HKlK55ucok22AVBkeOmXo5N2
         SYGaR9kcQ4L81mSn6/AZzO+n7qsgp6Syb5HUNPo9jVPlnyqwSPneKrcrohMjnDOa302H
         J+DGSErMkOr2H500wxrGB6u5LImmjG9pf84D4AFDaJ4YsNEF6Q1wew87vFhyXlyjRA1H
         QhlN7zm6ijRdxCvFmNY+H/nChJy0rHlT0cwhEXYlDI7DMyS8L0t2q2K9x/A+haXPD20r
         uu5usqyOJQRtpwb2xI41w4wquP/A8q994Z7pSZs8EFgVymaWI/2k1/i5zk+tN6Cit6ci
         QF9A==
X-Gm-Message-State: AOAM532pxava0gVu5o+nQ+QrMGukNSRJekQlMrw7r8Ta2N0Gbw8XP0zx
        tVsXAR+D8LYSL6vpPzJ9Dd8=
X-Google-Smtp-Source: ABdhPJydDa0aqaSyVC1lAZE6jcD5nX6zVVpoD3M4mjQ8FlNEA/gdFS/Q07wHzZv2vYN+cYLhH/Zx9w==
X-Received: by 2002:a05:6402:138f:: with SMTP id b15mr20170875edv.121.1620050271014;
        Mon, 03 May 2021 06:57:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ck4sm11505779edb.56.2021.05.03.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 06:57:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Carpenter <dc@ammonit.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: http.sslVersion only specifies minimum TLS version, later
 versions are allowed
Date:   Mon, 03 May 2021 15:55:31 +0200
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com>
Message-ID: <87pmy7x6le.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 03 2021, Daniel Carpenter wrote:

> When I run: "GIT_SSL_VERSION=tlsv1.2 GIT_CURL_VERBOSE=T git clone https://github.com/git/git.git"
>
> I see: "SSL connection using TLS1.3 / ECDHE_RSA_AES_128_GCM_SHA256", but I was expecting to see "TLS1.2".
>
> This happens because the "sslversions" array (
> https://github.com/git/git/blob/7e391989789db82983665667013a46eabc6fc570/http.c#L58
> ) uses "CURL_SSLVERSION_TLSv1_2" which only specifies TLS 1.2 or later
> ( https://curl.se/libcurl/c/CURLOPT_SSLVERSION.html ).
>
> I think configuring "tlsv1.2" should imply "CURL_SSLVERSION_TLSv1_2 |
> CURL_SSLVERSION_MAX_TLSv1_2", to force that specific version (and the
> same for "tlsv1.0", "tlsv1.1", "tlsv1.3").
>
> For background: I noticed this because of this issue with debian
> buster https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=987188 . The
> new libcurl backport enables TLS 1.3 support with gnutls, but it
> doesn't work for certain operations, so buster applications using a
> backported libcurl need to explicitly disable TLS 1.3 .

I think you're right per the documentation, but I wonder if the current
behavior isn't more useful for most users. I.e. are there really users
who want exactly 1.2 and not 1.3, 1.4 etc. in the future that aren't
dealing with an issue like what you're encountering?

I.e. the "better security in the future by default" seems like a
better/more common case than "pin to this forever" in this case, no?

We should of course have a way to pin it, but given the current behavior
I wonder if we shouldn't just change the documentation, and introduce
support for e.g. "=tlsv1.1" etc, or a http.pinSSLVersion=tls1.1 or
something...

