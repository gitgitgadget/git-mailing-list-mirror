Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7AAC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B9164E13
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 17:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhA3RPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 12:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhA3RPj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 12:15:39 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3888C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 09:14:59 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a12so12008836qkh.10
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8v+7lSZzjuUf3jALSh7l1bgT1mZQawazu20Kc5XZZYc=;
        b=WfGRrAZJg2BmZ7569lr78Mo9t3kX9l9kBFWmHwC8U4QmDAnznrENLmS1+pwT+kAi5z
         c7504am9sMWs3IAiiuUDB0+IGacetNWueF3RMBdxe9Awx78+UF8nxHrnuR4ORlZ9ZIty
         CXPs2VgaUeRmbC+AYOiO3hWMEu2aZqqY14OWw/LEeNOi8O2NWrttIK0UIMnZx6FOLTcf
         Nk9mIiLjBRsP0XTInRlsWxj+V/2d4ygauXqawArt90VClMJ+eaMTudK24/tDtchc09lo
         7CiM87k2mfsOtCIYumjc9uEcx1xHy5+74U6J4cDkUNOwZme2bTMqYvK2gnouloS9jI8D
         Dx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8v+7lSZzjuUf3jALSh7l1bgT1mZQawazu20Kc5XZZYc=;
        b=lsLkcB8m9hW1k8RzecLH6MnC8Gz+T6LkvhGJu0l7/ze8tJuRwI61aXhXgUKwVRASX5
         fAqPMgFzCf0mGgOBHpID39Kx7N04uJKWodk8xrODLd05njtQuf8+57nCsLZokFiOwqM3
         fEMY8YIsobW6hR7TfBPRp0NJgXbhOsV/vkB5O7+Y9jNZGKObtJHDC8AUa4DoAVGHVsGs
         dLo4et6wW8rxLWlUcT5iJm2pOxw5PxpyUxTgEs2QUJjc/dH1c/HhO94Me0NlbC1Olrhp
         M/8bmt4AB/wWDWdSWgBFNgjf2TaMy4jl7HDsaGynrJeM6jr0eXTol44txQ2jywOMnxSS
         x4zg==
X-Gm-Message-State: AOAM533Sj2Zc2DZ9/lcRTowrSxhREOckoEnGAMDz+ya+TyERqlu0rdVT
        nmZaWWGFrkYJdj3eJ3YN2IJIMWKA1CvZwQ==
X-Google-Smtp-Source: ABdhPJzTen994smFzWb/HPkK217MVLfJQ1b4mYB6fn+V5kp0FjxqnRiUWejd6isLCESPeylm6STU8Q==
X-Received: by 2002:a37:5b05:: with SMTP id p5mr9272499qkb.277.1612026898416;
        Sat, 30 Jan 2021 09:14:58 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q70sm9130465qka.107.2021.01.30.09.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 09:14:57 -0800 (PST)
Subject: Re: [PATCH] annotate-tests: quote variable expansions containing path
 names
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <cec4f442-03ea-e846-2613-f390b1e4d31b@kdbg.org>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <762b6a24-15ef-7578-6064-eb82832699a4@gmail.com>
Date:   Sat, 30 Jan 2021 12:14:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cec4f442-03ea-e846-2613-f390b1e4d31b@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 2021-01-30 à 11:22, Johannes Sixt a écrit :
> The test case added by 9466e3809d ("blame: enable funcname blaming with
> userdiff driver", 2020-11-01) forgot to quote variable expansions. This
> causes failures when the current directory contains blanks.

Woops, sorry for that.

> 
> On variable 

s/On/One/

> that the test case introduces will not have IFS characters
> and could remain without quotes, but let's quote all expansions for
> consistency, not just the one that has the path name.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>   t/annotate-tests.sh | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index ee5d2d4cf8..29ce89090d 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -483,12 +483,12 @@ test_expect_success 'setup -L :funcname with userdiff driver' '
>   	echo "fortran-* diff=fortran" >.gitattributes &&
>   	fortran_file=fortran-external-function &&
>   	orig_file="$TEST_DIRECTORY/t4018/$fortran_file" &&
> -	cp $orig_file . &&
> -	git add $fortran_file &&
> +	cp "$orig_file" . &&
> +	git add "$fortran_file" &&
>   	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
>   	git commit -m "add fortran file" &&
> -	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >$fortran_file &&
> -	git add $fortran_file &&
> +	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >"$fortran_file" &&
> +	git add "$fortran_file" &&
>   	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
>   	git commit -m "change fortran file"
>   '
> 

The patch obviously looks good:

Acked-by: Philippe Blain <levraiphilippeblain@gmail.com>

Apart from that, maybe we could set up one of the CI jobs to
clone git.git into a path with spaces, to try to avoid these
kind of errors in the future ?

Thanks,

Philippe.
