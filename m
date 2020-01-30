Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D5C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50206206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AoYx4lTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA3Mbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:31:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:53433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgA3Mbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 07:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580387505;
        bh=IZcuzDXRYTanEWGy5DR5Ww/KkmAWpmZh5auPdgpnS+E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AoYx4lTx1SFsNjuCUDJ0hyoggoPo9xrMpa9wS0kTEZqww8J7EzKtSp9xmxAQubRaG
         AfXJ86Pq7sWd3AAY4mZGwrqFFWxh01CwFQSlmJJY2QrLQ6L70C0NB73gQ/pHy5CnZW
         0xBaS4mSEloD6rHxhK0g5FzxfXdtRJppEUC6bFbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1irfKf12g0-00C8Ya; Thu, 30
 Jan 2020 13:31:45 +0100
Date:   Thu, 30 Jan 2020 13:31:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 05/11] bisect--helper: introduce new `decide_next()`
 function
In-Reply-To: <20200128144026.53128-6-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301330070.46@tvgsbejvaqbjf.bet>
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-6-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b8O8aIiZoEhm5fQk3f25rmzctJrDypUVcta7BV7XxSgglg2mBXu
 LeUrcJaISHc/1EpXVbz/dqKkAbD61CxeJI0DQzYduSQct2YlPmR8ZoUJdfYoz74NYzGjXhO
 K1P/yUnDBY9DZt0ZesZUpdg7AH5xrn+QTtZsV2aiXPI1koCIlrqAuPctGj22Xb5QGqDC2Pl
 U5YE8Gpcfv8W5CIjeDXMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yOFavKCzpPk=:cKN9CwkZ9u6UWb8Pw6cvZN
 z9ZnaxKgor9MFKrneK+DvHwzLIgrgZt3JxbuTHz1LpwOmmsSguYbGejLpMFqfgopT4uss7+Ii
 yK1ohfde23Xhc3YYV07BYyKWtMB6mgF1b4GYrQWL4Wha+BCCSJWhL/UBgOM4xH6fyIiA0GJuI
 cmrET6GjX8vA201uNgPOG4/sghVj+oDBOBf4ipfYV2NBNTroYuzjurpgx1tBAwJPjAJSZbZwK
 CsPjlGUu3aY/CN1qMdapUUwJAlkZQe15Ug1G98JsiTxjV6WBk3rpOqfcW8fzKs3T+BUuBL37o
 x9j/N27gSCo/3F1JK4njeUBT9U9GeTBv8K6TMryBApqhBzZBn9LhRlEXvEJhDfISlz5Gs+M7W
 zveQzoG2qBww02qrM3/qNHdKYK2sNuE2YrMecbS6AYSau/MzLvzesz+SGWcuTGTolP819GeIi
 34JjGM0wOOeTxH/sJqhlOp3C3W/9XnAdLQ31tobUJ4XmNeNZp1EMtaf0HafIUSyw/esdnCNDk
 JeBrFBEEvx6owRq9Zf8qZgEOXQFCCBH14voXIMbv41puFIr/nhPuTQFQojgmEStv2sOYvTBmr
 l4JyMwIDuZ1bXhmYYm+11qB44iR8m26NAEh1lOwnge0WIOdXaJBFrcTjQOLqZlGnJgnzFbezC
 edJ3zi/qls/P+ynLjsopVs+ODU9yuRfvAoVM5B4qkSPIC1tCDI9TXveI/yITOvzSmNdcMAFqj
 j27kOfu+00pnrtTwYp4/netIyfKjiFcr05stu2jVZhcF8tFHW9Cm51+UVfrYasaj4/rS6Qwb3
 QTVfttZ7QP1hp4IA5Cwh+nz898FimJnFpdQ+9zFWvsIWOMqLXKr6UWGbRaYADoUmDEPzEZ34t
 JGro+/wxnmvN3S/brhsQW4z4Wxzsy7Sk9jdwwKt1D5SsEeJYckC7uh/2V7OBR/jQsxzL556X2
 2vwVxdmTieAfEshrYFIE11tif8kwhe+hmTEeuoRA8B5ZrGRJc92e1dW/CYDcbsrEJUuT9pNbN
 3O9tzRXcfReWfry7/DmQDxwvKrgWSxze5D54XzewHpSNfLyhryIo5Ipc0YuQGygPSIWGByE09
 og2Ir5XjORWUr8mZz1XMc4nO5XEnek3xqcaxELlODOYwvRXmYZwMAUfDBvaUlHdo7/BHDCWiV
 8DL7zl6psSclnka4dCHLU2fnOCEMv0ildciQWTf0jc7WozFS77f2SZ0SXyMJcwpuhmq+X6wAL
 qgJCj85El6S961BVa
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Tue, 28 Jan 2020, Miriam Rubio wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 21de5c096c..826fcba2ed 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -291,26 +291,14 @@ static const char need_bisect_start_warning[] =3D
>  	   "You then need to give me at least one %s and %s revision.\n"
>  	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
>
> -static int bisect_next_check(const struct bisect_terms *terms,
> -			     const char *current_term)
> +static int decide_next(const struct bisect_terms *terms,
> +		       const char *current_term, int missing_good,
> +		       int missing_bad)
>  {
> -	int missing_good =3D 1, missing_bad =3D 1, res =3D 0;
> -	const char *bad_ref =3D xstrfmt("refs/bisect/%s", terms->term_bad);
> -	const char *good_glob =3D xstrfmt("%s-*", terms->term_good);
> -
> -	if (ref_exists(bad_ref))
> -		missing_bad =3D 0;
> -
> -	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> -			     (void *) &missing_good);
> -
>  	if (!missing_good && !missing_bad)
> -		goto finish;
> -
> -	if (!current_term) {
> -		res =3D -1;
> -		goto finish;
> -	}
> +		return 0;
> +	if (!current_term)
> +		return -1;
>  [...]
> +
> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> +	int missing_good =3D 1, missing_bad =3D 1;
> +	const char *bad_ref =3D xstrfmt("refs/bisect/%s", terms->term_bad);
> +	const char *good_glob =3D xstrfmt("%s-*", terms->term_good);
> +
> +	if (ref_exists(bad_ref))
> +		missing_bad =3D 0;
> +
> +	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> +			     (void *) &missing_good);
> +
>  	free((void *) good_glob);
>  	free((void *) bad_ref);

I know this is not something you introduced, but while you are already in
the neighborhood, why not fix the types of `bad_ref` and `good_glob`? The
`xstrfmt()` function returns `char *` for a reason: so that you do not
have to cast it when `free()`ing the memory.

Thanks,
Dscho

> -	return res;
> +
> +	return decide_next(terms, current_term, missing_good, missing_bad);
>  }
>
>  static int get_terms(struct bisect_terms *terms)
> --
> 2.21.1 (Apple Git-122.3)
>
>
