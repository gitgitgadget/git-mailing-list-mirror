Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0AAC55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D772076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHa35hoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVXi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDVXi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 19:38:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6FFC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:38:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r4so1919592pgg.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sXFazspWIUnTnYqejPlR16DztEawxu4A9u5gKDf57D8=;
        b=lHa35hoQCVDq0iJATYiRhzjZrjQ/VcJ7KeEi9RYsKWvUy0POw//6IRwF545W7CtSCx
         Z4OVHkczYaAS7QEzjpbxiS04WYO7HGRIXdmVo/Pg8Cs5C1+upb+GUKsRoW/Js9cedsmf
         bFWZdc6vikNTOZoba8eslFzdiQ498QhBQNERdvP8Sw7vP1lINKzfuCOPbxP9vhuD4PCV
         kZnnqqto8xX6Z8UozgcKncUCTw6ryutjD77odF3SJVijuCAKX87J/xjfmknPAJkIa1Vt
         6IibbTmdO704bvbJaiP66KIYRraITNryB32vfVPLaa4wfdKtik6ka6nlkSC96yFx7Tgl
         8T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXFazspWIUnTnYqejPlR16DztEawxu4A9u5gKDf57D8=;
        b=Pwwx+TJ2mhg2H2m7jERrL1WCqLZYdMhMOS+9355eOFWRDmcSpqdWpiF4KPMCPSV5ZI
         U5HoEd6SM9Ye6sRnxlUEATlvgdxmRR0iWdK3vkcFyqj/knUbrzSybQsipFu7Un7/GInF
         25ZicwucRZ2yTTbQEWEX8vMl57YtctN29GT3k3nLRRGR9LrXZrVa4l1Z9v9TXC260NWW
         Es+7HDBmlLqo/hUjY/mLzX/592yHCVtZb4uskJkCf+hq2YXbanitg0FzbrXy8w4Kuyzi
         06wlSfpdUEoC2eQkCoRx+iVf4RRtCkETxLg8H4tBEM+s7nh0bx3tSkEfddZpRIlssI8E
         Lmcw==
X-Gm-Message-State: AGi0Pub4B6kX1sMTxsz4O/VxnwFlFiDOyEVCcs0k0A0Ql2egFI9cNCg9
        c9zmsT3cBHu6vmMvtOhlmUY=
X-Google-Smtp-Source: APiQypK9BGk8AqNXktW6szkVvHx1FD9GVVRNOfaG4PkmWvQ0CaUZKrHkiuz1dT1bUuKz8gcqWhLIlw==
X-Received: by 2002:a63:fe54:: with SMTP id x20mr1333114pgj.195.1587598737177;
        Wed, 22 Apr 2020 16:38:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id mq18sm351287pjb.6.2020.04.22.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:38:56 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:38:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a
 non-strict mode
Message-ID: <20200422233854.GE140314@google.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> There was one call site, though, that really needed that leniency: when
> parsing config settings a la `credential.dev.azure.com.useHTTPPath`.

Thanks for tackling this.

Can the commit message say a little more about the semantics and when
someone would use this?

Is it a shortcut for

	[credential "http://dev.azure.com"]
		useHttpPath = true

	[credential "https://dev.azure.com"]
		useHttpPath = true

?

> In preparation for fixing that regression, let's add a parameter called
> `strict` to the `credential_from_url()` function and convert the
> existing callers to enforce that strict mode.

I suspect this would be easier to read squashed with patch 3.  That
would also mean that the functionality and test coverage come at the
same time.

[...]
> diff --git a/credential.c b/credential.c
> index 64a841eddca..c73260ac40f 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -344,7 +344,7 @@ static int check_url_component(const char *url, int quiet,
>  }
>  
>  int credential_from_url_gently(struct credential *c, const char *url,
> -			       int quiet)
> +			       int strict, int quiet)

The collection of flags makes me wonder whether it's time to use a
single "flags" parameter with flags that are |ed together.  That way,
call sites are easier to read without requiring cross-reference
assistance to see which option each boolean parameter represents.

Alternatively, could the non-strict form be a separate public function
that uses the same static helper that takes two boolean args?  That is,
something like

	int credential_from_url_gently(struct credential *c, const char *url,
				       int quiet)
	{
		return parse_credential_url(c, url, 1, quiet);
	}

	int credential_from_url_nonstrict(struct credential *c, const char *url,
					  int quiet)
	{
		return parse_credential_url(c, url, 0, quiet);
	}

[...]
> @@ -357,12 +357,12 @@ int credential_from_url_gently(struct credential *c, const char *url,
>  	 *   (3) proto://<user>:<pass>@<host>/...
>  	 */
>  	proto_end = strstr(url, "://");
> -	if (!proto_end || proto_end == url) {
> +	if (strict && (!proto_end || proto_end == url)) {
>  		if (!quiet)
>  			warning(_("url has no scheme: %s"), url);
>  		return -1;
>  	}

When !strict, this means we are not requiring a protocol.  No other
difference appears to be intended.

[...]
> @@ -382,8 +382,10 @@ int credential_from_url_gently(struct credential *c, const char *url,
>  		host = at + 1;
>  	}
>  
> -	c->protocol = xmemdupz(url, proto_end - url);
> -	c->host = url_decode_mem(host, slash - host);
> +	if (proto_end && proto_end - url > 0)
> +		c->protocol = xmemdupz(url, proto_end - url);

What should happen when the protocol isn't present?  Does this mean
callers will need to be audited to make sure they handle NULL?

> +	if (slash - url > 0)
> +		c->host = url_decode_mem(host, slash - host);

What should happen the URL starts with a slash?

Thanks,
Jonathan
