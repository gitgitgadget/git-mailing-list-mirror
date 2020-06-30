Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB82C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D0920702
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBA9/+5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgF3UwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3UwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 16:52:16 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B606BC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 13:52:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so20008739qkg.12
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5wgofCch1hUAlMaCnPbFuN5dTNza/Rr1XlvqGQwRDJY=;
        b=rBA9/+5ofTRm8aZoaVsPuY+hfHVw00lSH06WfcHP5cpR+CxRWkfaHOKBod38ryTb6x
         hNOl4u6d+u/MGwI2UwH4sM0NTUw++gb5F5qgBItAJUpLmHHCS8fk3L/U8r8jVQxcaKr0
         DMNKkPduqFmK1eRQx2RcMsTzl89EuIZ+BeT6STwolI02ST6sPrNWz5G0jWFn6yHcN69U
         TDoDugsLkACw20Y3n97F3TlsQrFemkJcCbsw9Ix+ttzTCS/Tb3n6w0TJsGdzaGdk8FnH
         RtRAwlQY6/3+vUj1S78TbpGNGyNFsdUsORgH2W5UWSnlFXt0vmptayIg0eQcwe0r4tQi
         PqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wgofCch1hUAlMaCnPbFuN5dTNza/Rr1XlvqGQwRDJY=;
        b=fsS7rlnGiuqXsBmlAqAdi8Xhr0LmF+VOutf35vfDar/FKkQnunPY/zhfqj2n7NQWN+
         7yCleq4zO6XoKf/GFN9Jp6XRqT/w6yOQfcMXpxZS11I6HQCoRs8qimONHqjFrZdaF+/H
         c6e5qhikoogLFoNq2UNHBSqjFMfIC0RR3Cjf57HuYO4HI8U+oG7TcPhHg9y4qrdIwX3X
         zCbZA0KZ8nYNTRGVeSe0RFKIhZ+UubxW3alk36OE9stcbiq/O0AHuP4xIfygUWuLHZ0d
         c4EuGHqez8gdDam3TGwqqT9pUbmnkzsCxexk4+yO7qZyyB3obXnhhsoQFGAyWRa2ktBk
         rHyA==
X-Gm-Message-State: AOAM530K/tsffWhhg4crL8DatPi+dohhAkH0b9OU8T32h04xcqUIxca8
        0RHss3eZPE+JVSVKt9faNNo=
X-Google-Smtp-Source: ABdhPJxiAR4j+3KaIzrNsMKO5GkJoRFn+vIk17D5JSVN6dhyCavUK+sSHVAxQmobEvKynUQ7Opw/6g==
X-Received: by 2002:a37:7242:: with SMTP id n63mr6611395qkc.143.1593550335763;
        Tue, 30 Jun 2020 13:52:15 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s8sm4019644qtc.17.2020.06.30.13.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 13:52:15 -0700 (PDT)
Subject: Re: [PATCH 1/3] commit-graph: pass a 'struct repository *' in more
 places
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1593536481.git.me@ttaylorr.com>
 <4ea9933b50fe0bc2738ab0e0dc52a4f17c4a2cb4.1593536481.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <00a3658e-323c-0719-5f26-4689e2a90374@gmail.com>
Date:   Tue, 30 Jun 2020 16:52:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <4ea9933b50fe0bc2738ab0e0dc52a4f17c4a2cb4.1593536481.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/30/2020 1:17 PM, Taylor Blau wrote:
> In a future commit, some commit-graph internals will want access to
> 'r->settings', but we only have the 'struct object_directory *'
> corresponding to that repository.

It is good to use "struct repository *" more.

> Add an additional parameter to pass the repository around in more
> places. In the next patch, we will remove the object directory (and
> instead reference it with 'r->odb').

And this is a good reason why we need the repository here: we will
need the settings AND odb.

> diff --git a/commit-graph.h b/commit-graph.h
> index 3ba0da1e5f..03d848e168 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -76,10 +76,12 @@ struct commit_graph {
>  };
>  
>  struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
> +						 struct repository *r,
>  						 struct object_directory *odb);

I suppose my only nit is that the struct repository pointer is
not always the first parameter. I understand that you have grouped
it where the 'odb' parameter is here, so perhaps that is fine.

Feel free to ignore this nit.

Thanks,
-Stolee
