Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9CDC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 15:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbhK2QAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 11:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbhK2P6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 10:58:35 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9185C061D5E
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:05:58 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so25606770otl.8
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L7E+hyF2eGa9ytqT4KEljlJIlxzMxQ7OVP9FZqeiMbM=;
        b=QnDMSMMYuEQxwptwv21x3UaYO/ZmW7S5+bGWCtFKgZG1It43fCu0O3uDXD1mlrivrQ
         s36Dv94dmwfHcdDMuGJi2SUkOF6OvgBZIuew5CQX+w4VoS0r4dNCVHkSS4fMGpfGE3ak
         jRhy+zYtjp7z2o3kCDebWxlVuP0VrUpMqb2nteCyF2eViPNlp/wj1RXa0YB3UM0DFJbO
         U7GVeDj2knlbrxzgUCyXgCnyqnUYmeW0V7oEysG2AdQ5NDyR0PjnoymXb3LqXtZHX3Mn
         NeNQlGMIqyRez2RuGlpT87lZaQb7Y/WcWDT+PjtQcK+pCFZxlBXF+Wfv4QcPrscLxHpj
         guYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L7E+hyF2eGa9ytqT4KEljlJIlxzMxQ7OVP9FZqeiMbM=;
        b=0woMiOzS3S/mrqcR5hDcN7UlxznJ2HV7yxi7quNC12E5ZUs7gRF/L8xSTt4tw+hnV7
         zMpVgr9mGTHMH9/J/nVrCuAobYp0yKaJi7y3ojgiyPaoCIX/BJJzRgN9RFxgIeM7UnPA
         tKHOstcQ9dTh+3HlXl2pU7inY1Ol5b7SCEgdkPvcddHO9bFU4Ut+HIByDCqnGRltxdkZ
         JJ3ObHC6NYyR1jWC3CtdrN4/RDZOrNblvl4CHHmB+yCKOpqgNgKjKgJubf4TY2AJVwAi
         kaP7KNnwijO4LiLOZSrqSRduGOMTVtteUKvOH3uud820oajf9Kkvrd6LagIgvPhy2r8Z
         JXvg==
X-Gm-Message-State: AOAM531dt0b4VHXHe7YYo5GqUYIQvM6rq/hYVX+qULVHdGiX5jWK1l5p
        oe86vOxnR1RlHfXlNj1ZsffddDqtEQE=
X-Google-Smtp-Source: ABdhPJyfuzhoZdyrBDdrJR/dyQKA3GFqz0ee5TfVIgtTxl8nocM2fuxGfnQyv2F+GMV7PO5rHRgyxQ==
X-Received: by 2002:a9d:f63:: with SMTP id 90mr45097372ott.268.1638194758013;
        Mon, 29 Nov 2021 06:05:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id r25sm2379282ote.73.2021.11.29.06.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 06:05:57 -0800 (PST)
Message-ID: <48fced3c-1fcb-d5cd-cec0-b9e58be40259@gmail.com>
Date:   Mon, 29 Nov 2021 09:05:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25/2021 3:39 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

> @@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
>  
>  	trace_command_performance(argv);
>  
> +	startup_info->original_cwd = xgetcwd();
> +

I see this initial assignment in cmd_main()...

> +static void setup_original_cwd(void)
> +{
> +	struct strbuf tmp = STRBUF_INIT;
> +	const char *worktree = NULL;
> +	int offset = -1;
> +
> +	/*
> +	 * startup_info->original_cwd wass set early on in cmd_main(), unless
> +	 * we're an auxiliary tool like git-remote-http or test-tool.
> +	 */
> +	if (!startup_info->original_cwd)
> +		return;

...which is assumed to be run before this method was called...

> @@ -1330,6 +1378,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
>  	}
>  
> +	setup_original_cwd();

...here in setup_git_directory_gently().

Why do we need that assignment in cmd_main()? Could we instead
let setup_original_cwd() do the initial assignment? Or is it
possible that a chdir has happened already before this point?

Thanks,
-Stolee
