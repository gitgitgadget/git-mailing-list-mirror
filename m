Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BFFC46467
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjARMRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjARMQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0F2C65A
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:39:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qx13so24151733ejb.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=daWkxe2enxI05yDpIfZrjma1g+qQFtQoNF2d8RaTKtI=;
        b=hlKEgNgLVIYJ6+BBLp6yOH8obaWx2f52hDqouyxYOMYjdVfRDdIiQxarQpItmuynqd
         xGqT1iMe7IMAlfR5A5Laqev8scIcw+v/ysEne0qk9L/PNXDeK5/a6pX4Skeo9vkCJ548
         DfYEiHHYIrhq3MSuTlkAqq6uTphyz2qtZpQAzI/rn6gmds3ouDnw0OxUXgEs2n9LiU9r
         IrqaiL9sbDPvcfqPFlk57es7wRkNOwQW9jYMWHToS0JwHjQcLpXQoma8FjujFLzKCTiP
         N1coyY6EdLVICHFTmN3ADG3J8JG1J7C3r65qHb9Itu9+0jpviNmJajV1dar1Wz21iVlG
         0uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daWkxe2enxI05yDpIfZrjma1g+qQFtQoNF2d8RaTKtI=;
        b=zQxERLFhAIJclE1Js0ktoDtUnnU1wSoLib0rt3YGzpa+agBoC01nM+lGwwbBsxrk8F
         x/twHJuRr4yrAvGUL/MB8plUqP2IPpnQJ3ott1ux4mLRTmYqIGoHGxs3+WL3gGRAPb+w
         YphEG2pqbMRKjMZF1qMvk+nsNViB705xSGwsLfFkjqb6vUv4W+oSd61j9vMJHKt2M7du
         bSedl8Td9pKt6GNP0mKHiWKKQFkR2ePewhVQ/dl/V/1zLnmvMjJgvHJBq/rK/AUMTb/K
         +tRjQz0HtNlj/7iVhNuYAAsfGnYOC7SPG6LX/Wzj41JQ1zzaUC4zOuGuAjPDj2Eq3VLV
         M32w==
X-Gm-Message-State: AFqh2kokyNNUv3XPNNCQVY3CSySwk5azRhtKhlPHsNe+iNn9joam8NfC
        SApuc3X17yyILs+5MNOJcn6MXqMiGLvydQ==
X-Google-Smtp-Source: AMrXdXvP//vh9+ynIwwo8F7LVYMyNLDQsljreUO3JuHcaB9utyd4GJnYSjeu+LKBT7DC7dl2sx0ZMw==
X-Received: by 2002:a17:907:a2cb:b0:871:dd2:4af0 with SMTP id re11-20020a170907a2cb00b008710dd24af0mr7035486ejc.26.1674041947347;
        Wed, 18 Jan 2023 03:39:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0087221268e49sm2692058ejr.186.2023.01.18.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:39:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI6mY-002oVo-1R;
        Wed, 18 Jan 2023 12:39:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v6 10/12] http: replace unsafe size_t multiplication
 with st_mult
Date:   Wed, 18 Jan 2023 12:38:34 +0100
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <cc9a220ed1f12aef2f4df940e71adc1fad917a6b.1674012618.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <cc9a220ed1f12aef2f4df940e71adc1fad917a6b.1674012618.git.gitgitgadget@gmail.com>
Message-ID: <230118.863588xeat.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Replace direct multiplication of two size_t parameters in curl response
> stream handling callback functions with `st_mult` to guard against
> overflows.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  http.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/http.c b/http.c
> index 8a5ba3f4776..a2a80318bb2 100644
> --- a/http.c
> +++ b/http.c
> @@ -146,7 +146,7 @@ static int http_schannel_use_ssl_cainfo;
>  
>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
> -	size_t size = eltsize * nmemb;
> +	size_t size = st_mult(eltsize, nmemb);
>  	struct buffer *buffer = buffer_;
>  
>  	if (size > buffer->buf.len - buffer->posn)
> @@ -176,7 +176,7 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
>  
>  size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
> -	size_t size = eltsize * nmemb;
> +	size_t size = st_mult(eltsize, nmemb);
>  	struct strbuf *buffer = buffer_;
>  
>  	strbuf_add(buffer, ptr, size);

This is a really worthwhile fix, but shouldn't this be split into its
own stand-alone patch? It applies on "master", and seems like something
that's a good idea outside of this "test-http-server" topic.
