Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77997C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 09:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9736100A
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 09:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhFTJj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhFTJj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 05:39:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E58C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 02:37:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h12so11369820pfe.2
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CReD4wQDMfl8tJaZ3JDNuUBUtffvE9kCHzSDvhdIp3I=;
        b=ZCU4bWpclYnpSNeNig4nLzn/rOyOkLSFXtWGwerDaQRgWVfdsYBpu8iESMcE/vitw/
         cdL8EMaOdkbtoj9L+mp+xj9LYd9NQ/siz4odojST3YTNYrcWEk5ol/zndI2CEn1KU137
         y4aDShJYO7/LZfPXX21Q1zrOcslnWAHVg/HNfz9i7D7qunkm39cZgSOf3MVJ/pDlzPnV
         hQPxMsI3Jk1KFY+F1qN4ra8ohr9dlgxdT4kULSALmIDZdSuBLBVDHN6SLfHDow0C6zVV
         FTcGdvDzV3IW/IQhllLDjttL6UZG261LPGuIhDm4/1UFceo72Nr2IRVHbTALP2ECF1Nk
         hbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CReD4wQDMfl8tJaZ3JDNuUBUtffvE9kCHzSDvhdIp3I=;
        b=X1GsAfRGXgCa9Fia5F/UmkASMc1kWQB6iJyJpT1IOHH03zNW8e72Veggl/qkcjotEj
         Kv0Q0y/xrvDJjdBp3kdyfIf1UtO3PphrBNcfMm2saWsnEGoo/a63FJTP+6kkYQ9g6W6D
         gM6cMQcyG95MchOt0bzkpYhGI4/jlhJMkgvimrrXbajali6+y5gPUEiUhhry/bQo1GyS
         mgWwpnIrGJfiwdFsxfWjk2lkLyh8d5cOMlHOvnGMifRnO1dzE5FK8RMrpp+H2hDAtkQx
         cEob3tkgeLEtDl5tsU55AbXwm7qyMHf/NfxJjZ0wbzhFl0544HIcmGxJq88/hZw3sccd
         9A6A==
X-Gm-Message-State: AOAM532mMDQtVnAKXX5Dq+WvkzIp7jdsc7jwFKunKF5yiA+1xHtyGDdh
        xZ79QnPRLtQFnDAEUsrA2GI=
X-Google-Smtp-Source: ABdhPJyPN+leT0HBB/wQYBq0A5v8ypx9vpZ/zdCyDKtXWRyT2QwBFvBwcYC63XnsyPver3BDuJGDJA==
X-Received: by 2002:a63:5442:: with SMTP id e2mr18692848pgm.365.1624181864219;
        Sun, 20 Jun 2021 02:37:44 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id a25sm12375016pff.54.2021.06.20.02.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 02:37:43 -0700 (PDT)
Subject: Re: [PATCH v2] blame: correct name of config option in docs
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Cc:     Barret Rhoden <brho@google.com>
References: <20210618221104.42260-1-rybak.a.v@gmail.com>
 <20210619112912.76136-1-rybak.a.v@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <744f5e3e-808e-3ea1-9f3a-892c3936dcbd@gmail.com>
Date:   Sun, 20 Jun 2021 16:37:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210619112912.76136-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/21 18.29, Andrei Rybak wrote:
> As can be seen in files "Documentation/blame-options.txt" and
> "builtin/blame.c", the name of this configuration option is
> "blame.markUnblamableLines".
> 
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
> 
> Thanks to Bagas Sanjaya for review.  Changes since v1:
> 
>    - tweaked commit message
> 
> Range-diff:
> 
> 1:  e32c298ee8 ! 1:  6ea64765e7 blame: fix typo in documentation
>      @@ Metadata
>       Author: Andrei Rybak <rybak.a.v@gmail.com>
>       
>        ## Commit message ##
>      -    blame: fix typo in documentation
>      +    blame: correct name of config option in docs
>       
>           As can be seen in files "Documentation/blame-options.txt" and
>      -    "builtin/blame.c", the name of this configuration variable is
>      +    "builtin/blame.c", the name of this configuration option is
>           "blame.markUnblamableLines".
>       
>           Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> 
>   Documentation/config/blame.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
> index 9468e8599c..4d047c1790 100644
> --- a/Documentation/config/blame.txt
> +++ b/Documentation/config/blame.txt
> @@ -27,7 +27,7 @@ blame.ignoreRevsFile::
>   	file names will reset the list of ignored revisions.  This option will
>   	be handled before the command line option `--ignore-revs-file`.
>   
> -blame.markUnblamables::
> +blame.markUnblamableLines::
>   	Mark lines that were changed by an ignored revision that we could not
>   	attribute to another commit with a '*' in the output of
>   	linkgit:git-blame[1].
> 

Looks OK, thanks for contributing.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
