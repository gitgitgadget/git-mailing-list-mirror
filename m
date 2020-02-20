Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F0C5ACC4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C9D21D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7VrGcHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBTCtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:49:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40171 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgBTCtH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 21:49:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so939782plp.7
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 18:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RDr2Q/JPkFc/px47aK3MImG7tyw5NNSeweh7j51SL28=;
        b=s7VrGcHrsVdy58NMo0RNwoCPkU4ExcxsUo+sYuualfp72NC4NQHhFZZLmb8D2rWZ08
         iwYYeRiyJ4hY295lPG7yZfsfHj83SD/8kf3Ar5CjlRM4vyLAgiRNsaaMix21eMmZr2Xi
         izKX4zG0KAkiO0ek+dsqMIIpv6v6KBILqo0AC3BsynTvTx/cIj/1R8/TbAvcPTqGYXCg
         8Wi+oTaUVlt9GSkhtE/ZdE/PkBkG/PcMelP00aNq+zomsxhao6ZgXIHR4EN7usTaKF0x
         sj1M5H8snUGrqxgfNAiTm6Qaz1CbgkY8oL7dp+SAajp3KrkvDMSF3HatmDw/BaOeUoJW
         2YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RDr2Q/JPkFc/px47aK3MImG7tyw5NNSeweh7j51SL28=;
        b=gElhO63qUz7T4OkN5f7Xg1ourY8f79Sb/MtW84nYoXg1jceLZsO1715Q7S1xgl5aQp
         cjSNDOhcxlWtjGSAZLziaaq6rcKRtfJcRGzbKtUh36w/HzSA3k6zclQdT4zTQ/AYBkkm
         34nd4gxrHyAAAAKuyyAiwNZL5GgNmcuBIcgMxqlvUsAWp9/r18Wd4BcPfDBUWdupPgw9
         ts2QB8E28inYCD12nrSTVNwbZzMGirhL2AeuL4fCEQXE5Jx33WeFaI5P9Jyz2y6ow+bz
         VdvYTZcvBLl6Xrjt24AZBtSTUkna125+HA/X0t8tPh2s4vGHORRjyYRjkMybbpMWAeFM
         YoKA==
X-Gm-Message-State: APjAAAXTH6p2Y3h/ycOTIQpsOt0KkRYHBGkU9mBNppbi7+82SQNiRaOq
        a/WFEkARwoClwd4WZvCAbdE=
X-Google-Smtp-Source: APXvYqxOfQZM+ul9IosZ44agnFoirz1aqYMF/Z1R1t0dK0Cr11nkq0FyLcI4EG0xZEpBQTTghJcnpA==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr29764761plo.62.1582166946823;
        Wed, 19 Feb 2020 18:49:06 -0800 (PST)
Received: from localhost ([2402:800:6374:7754:86a8:b650:771:4d56])
        by smtp.gmail.com with ESMTPSA id x12sm1012619pfr.47.2020.02.19.18.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:49:05 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:49:03 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 06/15] bugreport: add compiler info
Message-ID: <20200220024903.GC8390@danh.dev>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-7-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20200220015858.181086-7-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-19 17:58:49-0800, Emily Shaffer <emilyshaffer@google.com> wrote:
> diff --git a/compat/compiler.h b/compat/compiler.h
> new file mode 100644
> index 0000000000..ef41177233
> --- /dev/null
> +++ b/compat/compiler.h
> @@ -0,0 +1,27 @@
> +#ifndef COMPILER_H
> +#define COMPILER_H
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +#ifdef __GLIBC__
> +#include <gnu/libc-version.h>
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> +#ifdef __GNUC__
> +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> +#endif

I think we're better having

- get_compiler_info placed under #ifdef __GNUC__ gate,
- get_libc_info under #ifdef __GLIBC

Then have a function to merge those information together.
Correct me if I were wrong, as it is now,
this is only useful for Linux people with glibc.

Anyway, clang also defines __GNUC__ and __GNUC_MINOR__,
IIRC, FreeBSD people started to move to use clang instead of gcc
as their default compiler.

Gentoo forks are also known to use clang to compile their ports.


--=20
Danh

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTY0nhpo2VPuqOAxvIvwMbAAtddTgUCXk3znwAKCRAvwMbAAtdd
Th/kAP9gNHZgTNUz2kx/BlZK5TI6vsq0hspyi29+aTBmQgsIsAEAkXN3ZJpkUW+v
iA9xGxyU/lUZwz22NRk9PiRgc43eZwA=
=vs+Y
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
