Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47667211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfALCgt (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:36:49 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50407 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfALCgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:36:49 -0500
Received: by mail-wm1-f50.google.com with SMTP id n190so4079303wmd.0
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3yRqMzQLxs+S4igI1fMXABTgd2xT/neHKvWc93+6VXI=;
        b=uFesO+szBT83E2CcVF9A9JFgqwB4va+759B1qOQMHRibet6acFngEltVDLsquDORiF
         AijEcIfag1BHaKPMj8LzKd1K6Y8IjQL9h4qf58Pw4f3lGNvaw6tyy/eW1NSXUd3N0asM
         0qDCSfDyTJRjNkVGjfVpbm6R+RrhZDEXH4z1PgZ4gMmUq204ROzqJ9jCiF/983uk9mWw
         1YAKZFOIVmZnyMXiug3YCjVIYRl39vFTgcI05XqSE18yVVEgq5ns4QBvptXlffNDiw+f
         YYgK8eCgSatdx7Rj12zA+GVfNfoCOYMrCZAIWF4L03YHGCikFbLC4AgxJ77lsJF6UD+B
         Ndxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3yRqMzQLxs+S4igI1fMXABTgd2xT/neHKvWc93+6VXI=;
        b=P1UVGfcnnyEuau8Er2KTLvAMSZzc5Dh/w8pVYkCr2iVXkJu2lIOelDNqqvqj5V6jvN
         xyLuGiHrywYqMhuSFmUIYSe4WMTXXXDmMzVzr0XOQrR/xxoKwRzmIH2DLAWO2IZ0BgCr
         W8IaHglcmcwWG5N8OfiFQe2OX7QZXXT1H66p3SEO+y3alLSPr+TBrowVlsHqieKKL8YV
         NUJFMjgsGLjG6aztQc4PK884yBqMV0c18+VC1uHgYk3MWXOOURXmvkIGpAjiq2S7wTgH
         o597JupUEZGUtWhLhfPPytvjtUPg+qy2prg3C2eptwmZU7PspHcfBdw+SSA2ioarBbZ8
         IAWQ==
X-Gm-Message-State: AJcUukfPuKxe/z5NPr6/GEF9OfQLDaQ+R0BVAneyYZF6wCbfULdNMThI
        1dI2WOxU1o54yA1uj9pI/kA=
X-Google-Smtp-Source: ALg8bN5MRIrTTeTQqJZ1spNQXUVA1/hS/YIqovAsebKRX8QpVLKQtqfeQQjUDwN4ApXhURZnvuOA3Q==
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr3965444wme.64.1547260606721;
        Fri, 11 Jan 2019 18:36:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x81sm22215370wmg.17.2019.01.11.18.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 18:36:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: check config validity before creating rewrite struct
References: <20190111193011.GA19839@sigill.intra.peff.net>
Date:   Fri, 11 Jan 2019 18:36:41 -0800
In-Reply-To: <20190111193011.GA19839@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Jan 2019 14:30:11 -0500")
Message-ID: <xmqq5zuuy53a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This was a minor cleanup I mentioned in:
>
>   https://public-inbox.org/git/20181122173109.GI28192@sigill.intra.peff.net/
>
> but didn't get picked up.

Yeah, that does sound vaguely familiar ;-)  Thanks, will queue.

>
>  remote.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 670dd44813..9cc3b07d21 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -337,14 +337,14 @@ static int handle_config(const char *key, const char *value, void *cb)
>  		if (!name)
>  			return 0;
>  		if (!strcmp(subkey, "insteadof")) {
> -			rewrite = make_rewrite(&rewrites, name, namelen);
>  			if (!value)
>  				return config_error_nonbool(key);
> +			rewrite = make_rewrite(&rewrites, name, namelen);
>  			add_instead_of(rewrite, xstrdup(value));
>  		} else if (!strcmp(subkey, "pushinsteadof")) {
> -			rewrite = make_rewrite(&rewrites_push, name, namelen);
>  			if (!value)
>  				return config_error_nonbool(key);
> +			rewrite = make_rewrite(&rewrites_push, name, namelen);
>  			add_instead_of(rewrite, xstrdup(value));
>  		}
>  	}
