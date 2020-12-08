Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF891C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A405207AA
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgLHVKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgLHVKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:10:10 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F392C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 13:09:30 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id dk8so16194119edb.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 13:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g6N+GnW/6d9i+kQvmPMYh22P48E5BV4Ii/LzrVJHlUg=;
        b=fwgKJuHZjt//BMkJOrta6QLKjPvrgMsMwRBbZVOjDeXTpZcqbSMrEI9WWv90xGw1qS
         Tctvg31IJAZEw/UcH5mj/no1Kfvbx+m0x3rS47ZuR/7aTenfPsY/cncfjxYLGUKdgoGV
         uG43g4DmcFZ0yfwV0ooelhzwkFKM3KpwE5GjIz+f6I9H1PfgC7mhncPhk8KS+eNatorc
         H/KEh7YKRa1BmpiY8uNSo6MI/bRkmV3SDaRFGzd+hn3YAqcYar5MTy6zypnblz+bxN5O
         1/jjdbfCKtNym6yjGtnNJIFCyISxVtIOvIxkpWkT09nrjHp9B+UDKpJ5HvjRuoMkCEjl
         2kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g6N+GnW/6d9i+kQvmPMYh22P48E5BV4Ii/LzrVJHlUg=;
        b=DFIkiidwAhunGIc84glh0JC14PREnJLaOjsl5YkAQha795yPslsnVDax87uHK3pxSL
         zE10crzhs8ktX1sOvn6Z6UU/g6a7sN92nkJFM8a9E+ih9k+GFDfbmLfSAihktXz8oPAG
         jF2H50tanrBab6rO/vFGOxtEWUAMixT6snEUcbhR3V3Y/b4ewang9ewOm8O+gYFk3qg6
         rk1kFgngtxsjXM3sDVIYseHR76gAq2C1n6cdSM3Zp7tgZHADxJw0cWK7MSnv3jEOuwJJ
         mDGwRlSE6QrLDp7z2/x4xDoJwx1xyE2xMWrC+g+NjSyWyWruqaC3eCX/L3TxAe73uyWU
         JvFA==
X-Gm-Message-State: AOAM532aXf3CGdBVoXiMyDHR7s3lc82LaFJpP9sk9U/juoP+T7qoylzy
        y9yK29/C4vc/Y81KmJG4SP0=
X-Google-Smtp-Source: ABdhPJz8JsMRyP1UxD8/3efhxF7iFB91yoiUSND9gnT7nPHmAmwGGXg8oqKhJG9Rk7uWpfGtWfutIg==
X-Received: by 2002:aa7:dd17:: with SMTP id i23mr26038646edv.14.1607461768780;
        Tue, 08 Dec 2020 13:09:28 -0800 (PST)
Received: from szeder.dev (78-131-14-139.pool.digikabel.hu. [78.131.14.139])
        by smtp.gmail.com with ESMTPSA id qu21sm16653915ejb.95.2020.12.08.13.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 13:09:27 -0800 (PST)
Date:   Tue, 8 Dec 2020 22:09:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 15/17] hook: provide stdin by string_list or callback
Message-ID: <20201208210925.GI8396@szeder.dev>
References: <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201205014607.1464119-16-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201205014607.1464119-16-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 05:46:05PM -0800, Emily Shaffer wrote:
> diff --git a/hook.c b/hook.c
> index f0c052d847..fbb49f241d 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -9,6 +9,8 @@ void free_hook(struct hook *ptr)
>  {
>  	if (ptr) {
>  		strbuf_release(&ptr->command);
> +		if (ptr->feed_pipe_cb_data)

Coccinelle suggests to drop this condition, because free() can handle
a NULL pointer just fine.

> +			free(ptr->feed_pipe_cb_data);
>  		free(ptr);
>  	}
>  }
