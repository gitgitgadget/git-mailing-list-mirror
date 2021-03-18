Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62668C43381
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3225E64F70
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 16:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhCRQpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhCRQpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 12:45:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2BC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 09:45:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r17so1814159pgi.0
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iKQVnYLYaljUyl3ZRqLrKtYES+s+pL/WpGpO++dbjVo=;
        b=doh+Gds2IjJ57wIEC6gUZjqQLi1vJcDiTjaUIzGSOcfONmcSftgEbLdc6vmxBZH7oA
         6L4lNmL1P27MpPE4bI0aptNM3Zw201IujOY5LOlQrq/xP1YZ7rIWdLwP3RehYjPDd0kC
         K3vc7C7KDWICLRwViw0A4YC6r2ljc0AayQcZB1cgMoRu8mO5PuCU+8tG1dkF6WGL3MAs
         iHK+VZHQFtefCVosqkc+uNT1f1ZTIZSrEKoMp+lkEv1GGt4HgXDzofROe1nHJJNIcyZm
         ZSyn1nrj2Zld3j4wWmf9QTbOxJNYvzoUpC58lDzjWnWOpsNZnJvoL71UiI5Rq4e9pqW0
         h3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iKQVnYLYaljUyl3ZRqLrKtYES+s+pL/WpGpO++dbjVo=;
        b=CTYCNpjjx1DHGlkxAmn/1LLt0KwtB4Y3d/rRm97DYLHEVMhfiSJPKpCfqutD6l/gbm
         +GsQ9rOiulBIJFeZGfq0H7p5duBMR/496LZ/bzUOhOtj/xfLMihDqxIKUax5xhX4kuiD
         0Mw7pIesRMuMNdix/gdApO+JhicO/gnG+396pmsQdlrM4y5SAcq4BYQVf5H/JeF8bx4F
         k6DZQhgaLx+L63H0CppWjtpnJOaCHmazj1KW72NkUnw0+iyiuu791qeFHZbOqA3IKTfM
         F5uyPrbRFUEWVUP4DslXmcG+xBF2mU6nSASRM3Cchh4SlBNlQlxZhoDXm2AJpYzjjzWI
         PJAg==
X-Gm-Message-State: AOAM533zpu3okHDnxzSZFouzJQtGi0JWJEQVbH/7M+4jnSvrpZA4eczV
        ZJMhplNT3WBHP472xastQhDtsrfBb98=
X-Google-Smtp-Source: ABdhPJwmEhYgsb19iI6LqjalP8IDO3UGRcCtgsXYqhQKagrgQyqhcqVgazlxun/GUWhEoIoXWPh6Iw==
X-Received: by 2002:aa7:92d9:0:b029:1bb:b6de:c872 with SMTP id k25-20020aa792d90000b02901bbb6dec872mr4850208pfa.68.1616085920291;
        Thu, 18 Mar 2021 09:45:20 -0700 (PDT)
Received: from localhost ([2402:800:63b8:c037:a704:f99b:eeaa:7066])
        by smtp.gmail.com with ESMTPSA id q25sm2771654pff.104.2021.03.18.09.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:45:19 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:45:18 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
Message-ID: <YFODnm4JKfqRn37H@danh.dev>
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
 <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-03-18 11:15:55+0000, ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Beacuse `git commit --trailer="Signed-off-by: \

s/Beacuse/Because/

And I think, it's easier to read if we write the command in its own
(indented) line.

> $(git config user.name) <$(git config user.email)>"`
> is difficult for users to add their own identities,
> so teach interpret-trailers a new option `--own-identity`
> which allow those trailers with no value add the user’s own
> identity. This will help the use of `commit --trailer` as
> easy as `--signoff`.

Perhap, saying that we're optionalise <value> in --trailer, by
substitute user's identity if missing instead?

> @@ -131,6 +144,7 @@ OPTIONS
>  	when you know your input contains just the commit message itself
>  	(and not an email or the output of `git format-patch`).
>  
> +

I think it's better to not add this line change

>  CONFIGURATION VARIABLES
>  -----------------------
>  
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 84748eafc01b..be7f502a58d7 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c

-- 
Danh
