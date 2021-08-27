Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F33C4320A
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551E2608FB
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbhH0KrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhH0KrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 06:47:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0AEC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 03:46:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fs6so4245196pjb.4
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eOAo929v1vqslybN6GOy+A7eCiZS5SOymYo7amwRKh4=;
        b=EBKi3rFou/om/SBz/L2cr1StTQQY38QJJEgWyV1j9NjIK9RK3D0KvZ1s8RfUxlgQer
         8cALV2svi+GcwD217xr6v4oPsQKqcNqraMlGY1pzzcdA9upDIm3W0F3Urtr68ETz/fYE
         2JEQkpGru03bAPFr8/y1okYpszaaGhCnh60qPEtWc4lWtj6eNuanapKk0uNetdVGCDXA
         mcziGH0vBY1nmFsIGZdOST1VZJSjQfkxW1SqLdugPpUMYb62bMdnH5PbcQ63isbLvNeG
         lFMbJdIp7IokEqceq4K3LUxpko7lB7rFp8ZuHZnbeXUZwIRFrnPvs/8YhbF0608RuCo2
         Yuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOAo929v1vqslybN6GOy+A7eCiZS5SOymYo7amwRKh4=;
        b=JJUc8NSjbU5cjVj7MUwlv0H31zsZMRD0asVrDrJjMvgUwYJJvr/fxwicUARN/r+wdW
         BeKzijxf2xh0VEazBhgEGX/79a4Ss/ptCztwW4Ptur4U0qC30oyHEpm/1KqY5RtPSh3L
         fg4ym7qCibK+ye5wkMJFpnXNuL+S0HvbS7LeSMts9yxvc2HnqB2drvtstNroHwy8/C/s
         yBY/CoSHeeB20EiLKBghDYBW/AUdT8aq221YkYS3JKSSAUH30S3N/JM8VgXDbACO1Xr9
         cLI23vFlSfgeqtaah9wrjctnnSuZKmGWaZnOPZpMnkkd+514bvD8KboGyalwxBNJxKkI
         kK9Q==
X-Gm-Message-State: AOAM531YR8Gom8C8LjrHM3v/2aoy38iympFy7qJv5qTTil6EHm9fxbXa
        b5S/jyy7VGmjl+zkljVEuVxZPXGAxaA=
X-Google-Smtp-Source: ABdhPJxt0Jib0lUW3zU70rtdSl8vis9V1mNbNNk5uPCXrB/PUMqlzOK4cu5vfDQGeyJCW5utOeyP9g==
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr9984816pju.205.1630061186402;
        Fri, 27 Aug 2021 03:46:26 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id 141sm6683026pgf.46.2021.08.27.03.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 03:46:26 -0700 (PDT)
Subject: Re: [PATCH] pretty-options.txt: describe supported encoding
To:     Christopher Yeleighton via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christopher Yeleighton <giecrilj@stegny.2a.pl>,
        Christopher Yeleighton <ne01026@shark.2a.pl>
References: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0877bb5d-da4b-125d-7beb-c3138903f468@gmail.com>
Date:   Fri, 27 Aug 2021 17:46:22 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/08/21 04.34, Christopher Yeleighton via GitGitGadget wrote:
> From: Christopher Yeleighton <ne01026@shark.2a.pl>
> 
> Please fix the manual for git log.  It should say what encoding is recognised
> (namely if supported by iconv(1), except that POSIX character maps of
> iconv(1p) are not supported), and that an unrecognised encoding is ignored.
> 
> Signed-off-by:  <ne01026@shark.2a.pl>
> ---

The commit message should be:
"git log recognizes only system encodings supported by iconv(1), but not 
POSIX character maps used by iconv(1p). Document it.".

>   	The commit objects record the encoding used for the log message
>   	in their encoding header; this option can be used to tell the
>   	command to re-code the commit log message in the encoding
> -	preferred by the user.  For non plumbing commands this
> -	defaults to UTF-8. Note that if an object claims to be encoded
> -	in `X` and we are outputting in `X`, we will output the object
> +	preferred by the user.
> +	The encoding must be a system encoding supported by iconv(1),
> +	otherwise this option will be ignored.
> +	POSIX character maps used by iconv(1p) are not supported.
> +	For non-plumbing commands this defaults to UTF-8.
> +	Note that if an object claims to be encoded in `X`
> +	and we are outputting in `X`, we shall output the object
>   	verbatim; this means that invalid sequences in the original
>   	commit may be copied to the output.
>   

I think POSIX character maps and encoding are the same, what are their 
differences? Reading iconv(1p) [1] doesn't give definition of the former.

[1]: https://man7.org/linux/man-pages/man1/iconv.1p.html

-- 
An old man doll... just what I always wanted! - Clara
