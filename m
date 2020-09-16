Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1879DC2BB84
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD65208E4
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDlkZYTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgIPTvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgIPRhz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:37:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBDC0086BF
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 06:47:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so1630769pjb.4
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+j/DsGa0OXakGfVB/mEOcx6WQzh+Hk4nahaqoHGizvg=;
        b=ZDlkZYTd0FQiuylydqlVrKMlruNU6o+R8gmKXj+9LkyvQmmQOiF3NkN7Kv0lwVixSk
         E2gvLlgCZwdyCN0dsNkR4AtPNWWznVlhyvyjzOGE42Xo+oLzegnxZqL2kOkuZtdT8wzm
         dWIUhYoVzwSlI6wvv7QmlFcbAet1JB53C3euSX+AQcNkMZK+qKkpUtwXhmPgAUMj7mrP
         ddPEo3jOfwW06opcMRvCeo2JKnsU0v77Rc+fJ8oigQbApzIz5HChXF4otqUfPWq+BgtC
         h0YWTxoZAmodnZqQgsljxba04De3C9GUasKW/qQQWmMp7YrY0oEmiIzj0qTNGaKVHW76
         B9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+j/DsGa0OXakGfVB/mEOcx6WQzh+Hk4nahaqoHGizvg=;
        b=JvMZAfWxPoGFe4vvKdUpl2c2O9bzinv3V/fLlWgV8FdiTAzT+mEe2/hs6ZeTVnQHlk
         K6V64FmGrbAjmZrVjCH3sGV/63Gk8H+eIh0qGtNnKcPoJavBaVZjJ8UCyYNTbetCzM6U
         XFpva0ZqHMz7wevk3A40OGDpQ4QpGauD+xmW+SeYHi0qAbhICh9fiBxfxLr+LO0KZGYI
         ljlgCzpPomF4LBHljQnIFxJ1gmG2WMb//zYnu+hR5f+prqpMREAx8yPUXmwBpQDghX4T
         iwYXpf8NWAEMsI8Tz+UPGzZFbiUcU92dRZGc0O7hwYEcx2CNV50Rg+AfEX8tvg/qsrLj
         t9TA==
X-Gm-Message-State: AOAM530hTVjRv/tUxs00OcMcs37tSlXgWmzN3UKdDTbDabuHLP8KsnYb
        WMTpEIolrpbHUbwpfqTAhZs=
X-Google-Smtp-Source: ABdhPJx/saujDO3JaBnrXTglxieC23F68ygYcd3e0tgljMM5Vt224qq2HpRMV0/cGJYH94p9Np7Kkg==
X-Received: by 2002:a17:902:b718:b029:d0:92cc:a449 with SMTP id d24-20020a170902b718b02900d092cca449mr23725043pls.9.1600264053341;
        Wed, 16 Sep 2020 06:47:33 -0700 (PDT)
Received: from localhost ([2402:800:63a8:edfa:1ca8:8e9c:e6de:6bb2])
        by smtp.gmail.com with ESMTPSA id r3sm16977428pfh.88.2020.09.16.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:47:32 -0700 (PDT)
Date:   Wed, 16 Sep 2020 20:47:30 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 03/15] remote-mediawiki doc: bump recommended PHP version
 to 7.3
Message-ID: <20200916134730.GA10150@danh.dev>
References: <20200916102918.29805-1-avarab@gmail.com>
 <20200916102918.29805-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916102918.29805-4-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-16 12:29:06+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Change the version in the documentation to what's currently in Debian
> stable. Ideally we wouldn't have to keep changing this version, but if
> it's going to be hardcoded let's use something that works on a modern
> installation.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  contrib/mw-to-git/t/README | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
> index 2ee34be7e4..d9c85e2c63 100644
> --- a/contrib/mw-to-git/t/README
> +++ b/contrib/mw-to-git/t/README
> @@ -14,11 +14,11 @@ install the following packages (Debian/Ubuntu names, may need to be
>  adapted for another distribution):
>  
>  * lighttpd
> -* php5
> -* php5-cgi
> -* php5-cli
> -* php5-curl
> -* php5-sqlite
> +* php7.3
> +* php7.3-cgi
> +* php7.3-cli
> +* php7.3-curl
> +* php7.3-sqlite

Debian also provides meta package for those packages, built from
php-defaults [1]:

* php
* php-cgi
* php-cli
* php-curl
* php-sqlite3

They'll pull current php7.3-* packages as dependencies.

1: https://packages.debian.org/source/buster/php-defaults

-- 
Danh
