Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B641C202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 20:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755225AbdKAUz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 16:55:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:51090 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdKAUzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 16:55:25 -0400
Received: by mail-io0-f196.google.com with SMTP id 97so9048233iok.7
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1AadeiGSuheuM0j4I1VulNx27d3j36WApCbpAc0Ibns=;
        b=sR4JRhfJGMMijD62+2tU/MZVcANYE+CZq4iQXVMX7en+uraf+XHsYyHluo8s8D/skJ
         cYRD6rCL8dvznLn8jGiNwCNDGBkSlo7PpfR09U2BTSC/8gG/mZt1Lx3EQRLKDQRqVVJo
         YVV5BAAPab6Rv3qUe2yqUnPElZDtTMDKrKrBa1+2UpFjEd0HQOeNO5hh/Cskh7ftiS7M
         6P7KvjZmzt5mLRjEcfXrHq0LnZj8Rbhch8bwC++1zXJ8IQSqoW7txoJY6wKUYFjv/nIW
         hK6WRvaqwWruGgJP54E+h6fi3P91dJaQNU+iux945ABnX2OrVePpnjRtIxLi/OEqcFGi
         TgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1AadeiGSuheuM0j4I1VulNx27d3j36WApCbpAc0Ibns=;
        b=LIVNmDukeuRje+a3c2t/sqV68e+vrryZjRPeNx6WMKgIMQUuXujphASpjoo7NXG8Xy
         pCKWz21yoQxhnFtdxlKhxFovGsaGKHXX7xzrL1iduOcTLwp7R6QJrXzo270afe/31adK
         2MhC6Bd0O87eHhAnCkLhv73xD56ptDgJTr/eahSMpV9y9cavTnWkXgoDLF0FA0nsFCdX
         R3LF4I85mcq4mo+gn3XWpSYJdt0mhohJpqyBEJHSAK7ojZ7PTGy0ltYdCGiARz7jSY5i
         +dOCP49jyOI0NPSh4PF1nvxNGutU+31fiPDQx7Ow7qOu4b1TJXpRmCwFZ7UtyK+TDZtt
         XoUg==
X-Gm-Message-State: AJaThX6zKovRwJFhsZRpzUoaq2gAryiKPCDH6orTsxnEqcaWd9g3JZ08
        xO2GbMAqmlt0KUCA3nx4Wfq43w==
X-Google-Smtp-Source: ABhQp+TNr4z1/BCFIkQhawotGfaZunQ6PbbCMMoj3jvgkhAKDJ657/nV0j8koVnDkWbHYvBS4+jzQg==
X-Received: by 10.107.28.131 with SMTP id c125mr1480467ioc.233.1509569724533;
        Wed, 01 Nov 2017 13:55:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6ccc:596b:d6bf:4bf5])
        by smtp.gmail.com with ESMTPSA id j71sm9042itj.2.2017.11.01.13.55.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 13:55:23 -0700 (PDT)
Date:   Wed, 1 Nov 2017 13:55:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] grep: take the read-lock when adding a submodule
Message-ID: <20171101205522.GA188245@google.com>
References: <CAN0heSpxJDxmSXu=P0stq+CsKVqjsvOnjDpOoMT9GdWxeZU2Pw@mail.gmail.com>
 <20171101204506.5481-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171101204506.5481-1-martin.agren@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/01, Martin Ågren wrote:
> With --recurse-submodules, we add each submodule that we encounter to
> the list of alternate object databases. With threading, our changes to
> the list are not protected against races. Indeed, ThreadSanitizer
> reports a race when we call `add_to_alternates_memory()` around the same
> time that another thread is reading in the list through
> `read_sha1_file()`.
> 
> Take the grep read-lock while adding the submodule. The lock is used to
> serialize uses of non-thread-safe parts of Git's API, including
> `read_sha1_file()`.
> 
> Helped-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> Many thanks to Brandon for showing how this should have been done.

Of course! Happy to help :)

And this looks good, thanks for fixing my mistake!

> 
>  builtin/grep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 2d65f27d0..5a6cfe6b4 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -431,7 +431,9 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
>  	 * store is no longer global and instead is a member of the repository
>  	 * object.
>  	 */
> +	grep_read_lock();
>  	add_to_alternates_memory(submodule.objectdir);
> +	grep_read_unlock();
>  
>  	if (oid) {
>  		struct object *object;
> -- 
> 2.15.0.415.gac1375d7e
> 

-- 
Brandon Williams
