Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62CC433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926512311A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392155AbhALREa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbhALREa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:04:30 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7BC061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:03:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id by27so2892002edb.10
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ycASNWGgAXHBqkDpEhJdHCn+zb90NWfNUsOvXHMmUVU=;
        b=dow9Sxjd4XyYXb6UXrhxb+ZDt6e2wnVxHbH5vQ6BLl9d8bzcOmN7BEwP79sv775M/k
         uXuZmRnDqr3M+HfyaS9RY9jxGtAqVcNUrC65exBy4iClKe+CkuzsEJenBc9aC63Gb5HG
         IdnRv6h2T+4HD9wfOLobZdmcuecGPMLcU/6Xj9x0H+bKupSKhTPWYrnHAcKlyf6XQgES
         iwwmZsLlji13PATcX3CwgiL9jfAh2yTJqwi+RtLniJKS3rv42Vote1EqA/fpN7F/zFW2
         mrnvSV51vIdZgZNxinWzF7odRnIo30PLVeY5bPlQaSssipc1hnGAp4kWetP9cuCSwO9m
         F46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ycASNWGgAXHBqkDpEhJdHCn+zb90NWfNUsOvXHMmUVU=;
        b=aeq+UU8CqydXdbYaZFh26VHUcaW0Zryut5kcPTRgVNEru1lQ4kWgy58nerPxjNIBFf
         FVtS6NS4Vpa+ZcGqONQPIEQqbDZijV7On9Gw0L21mIOJUE5GMBOjAZDAdLHSxJHkfdAF
         exPPI6hoCcpjDGOdphHQmXETF4+B0dwxmimvInqK5FWz+0rvFLfX7S7PCqXKxWyli10w
         ef4xlSSZbtA7imicwiUWnRvcPmV0ZgcWuCn3dt9CKewom9pmcG6IqaTiy+MM+E7/9C+a
         gwcTFEUs1V7QHGP1h2Pe2VtfqtPEOG3kfSWHq8+vmLb8Xe3V53yPVMJbLTboNQI+vPuh
         xqmg==
X-Gm-Message-State: AOAM533P5htz/IQQW0bPG3+7MkOGv/xlsx/RXdn69ivnIN813lsdLI50
        fsERkGylWhN/APcCHgRcFbo=
X-Google-Smtp-Source: ABdhPJxhY8XhGy+CiIL56nc0gotw9seadhFClYb8RwXwbFaK5vi3trcekTR/CiNDoaryaL2Xb8xfQA==
X-Received: by 2002:a50:d553:: with SMTP id f19mr60247edj.323.1610471027223;
        Tue, 12 Jan 2021 09:03:47 -0800 (PST)
Received: from szeder.dev (84-236-109-1.pool.digikabel.hu. [84.236.109.1])
        by smtp.gmail.com with ESMTPSA id r18sm1705442edx.41.2021.01.12.09.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 09:03:46 -0800 (PST)
Date:   Tue, 12 Jan 2021 18:03:44 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] commit: ignore additional signatures when parsing
 signed commits
Message-ID: <20210112170344.GX8396@szeder.dev>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
 <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <20210111035840.2437737-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111035840.2437737-2-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 03:58:36AM +0000, brian m. carlson wrote:
> diff --git a/commit.c b/commit.c
> index f128f18a9b..93faaad764 100644
> --- a/commit.c
> +++ b/commit.c

> @@ -1082,23 +1087,27 @@ int remove_signature(struct strbuf *buf)
>  	const char *line = buf->buf;
>  	const char *tail = buf->buf + buf->len;
>  	int in_signature = 0;
> -	const char *sig_start = NULL;
> -	const char *sig_end = NULL;
> +	struct sigbuf {
> +		const char *start;
> +		const char *end;
> +	} sigs[2] = { 0 }, *sigp = &sigs[0];

Various Clang versions issue the following warning about this
initialization:

    CC commit.o
commit.c:1105:16: error: suggest braces around initialization of subobject
      [-Werror,-Wmissing-braces]
        } sigs[2] = { 0 }, *sigp = &sigs[0];
                      ^
                      {}
1 error generated.

