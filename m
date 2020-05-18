Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E438BC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF3A2070A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgERKYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:24:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60632 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgERKYY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:24:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49QZr65SJNz1qxj1;
        Mon, 18 May 2020 12:24:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49QZr651f8z1qrKd;
        Mon, 18 May 2020 12:24:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FfBx7jPvKola; Mon, 18 May 2020 12:24:22 +0200 (CEST)
X-Auth-Info: HW8mpTlWWbvQlcK+FkaFXOEBBW0523xZzC7bk+1F0Ewe+qObi48nBJeAHEN1vhAy
Received: from igel.home (ppp-46-244-178-90.dynamic.mnet-online.de [46.244.178.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 18 May 2020 12:24:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 544242C01E5; Mon, 18 May 2020 12:24:00 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Darren Tucker <dtucker@dtucker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/7] Define LLONG_MAX/MIN etc if not already defined.
References: <20200518100356.29292-1-dtucker@dtucker.net>
        <20200518100356.29292-5-dtucker@dtucker.net>
X-Yow:  TAILFINS!!  ...click...
Date:   Mon, 18 May 2020 12:24:00 +0200
In-Reply-To: <20200518100356.29292-5-dtucker@dtucker.net> (Darren Tucker's
        message of "Mon, 18 May 2020 20:03:54 +1000")
Message-ID: <87a725r16n.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 18 2020, Darren Tucker wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8ba576e81e..aa221eba1b 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -127,6 +127,22 @@
>  /* Approximation of the length of the decimal representation of this type. */
>  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
>  
> +#ifndef SIZE_MAX
> +#define SIZE_MAX ((size_t)maximum_signed_value_of_type(size_t))

size_t is an unsigned type.

> +#endif
> +
> +#ifndef LLONG_MIN
> +#define LLONG_MIN ((long long)minimum_signed_value_of_type(long long))
> +#endif
> +
> +#ifndef LLONG_MAX
> +#define LLONG_MAX ((long long)maximum_signed_value_of_type(long long))
> +#endif
> +
> +#ifndef ULLONG_MAX
> +#define ULLONG_MAX ((unsigned long long)maximum_unsigned_value_of_type(unsigned long long))
> +#endif

These definitions won't work in the preprocessor.  The are no current
uses of these macros in preprocessor directives, but that needs to be
kept in mind.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
