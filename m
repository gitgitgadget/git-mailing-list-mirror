Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C71211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfALCoJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:44:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37219 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbfALCoI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:44:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so4071153wmd.2
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z/h/3bX720r8dLMcMeMKh/tuMeMs85c4bc2niQ9oUuE=;
        b=utHLH3kqqKd19bqGS74NzJkVNEt4Ma2/YXZz9IA1hFOCC5y+B1iAIT9+XmB6XlwMuV
         NiT094193mytGqi5e/p3dhymjox6GOYgpV1vIk0QPv8XXJ6fWsOjNre9b7ll7SF6D0k4
         z2rfuBEDJWygfXuX9Xlpvs2SFaN/yqeZQyL240O7ysm0+/+/mKGKKx84vVVFchmgiEWd
         v5i3b8XQ8tnEF9oQq80etxTYCy86/7oSJWVAEOPYXz4rEH0YAoDmM9R57N000MPdPyoE
         loCo6qk9/OKPorEUbsHEzwc53uc+LsYCn/5uXDL0J0MTBq2ZAcwaWJsY0Mz5ntVkTsqV
         nDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z/h/3bX720r8dLMcMeMKh/tuMeMs85c4bc2niQ9oUuE=;
        b=DnmGi2oRNf1vC+tUBiy8Z047JuJqG0GH+LmVBhLrKdyBgRiDCjnaUuOzF3xlYjYV1K
         TypnAajklhSTZ7vWBTdMKKXFmUD8HF3Z39bpWMW6wA9cAGqLZDioOQAetoXLp/1wDx/x
         iRfSV+o5fw5WidtGDnT1KXV0Z4LRQFt1tFrGn62nFnJqvrZQjq8v0vosw19zefF/H/hO
         VDHrenPTc1GyYelr8j23KQYNv2yioJRIvBzTO6kgXcg4ZdpXnf5KWwcGYu9MVjZ+sM77
         wNJAbOLqu0FJOkyqMiDd6G5qw5aOY4Toj/zSgDeum0hRx0ib53Vfo71FbZm3FPRdqF3K
         /ftQ==
X-Gm-Message-State: AJcUukeRKAon4log7z9aEdgGGJOs215+ZgB6ylLyAb/SrEkvyOPxI6ab
        bnDdw5WYqWOgWBUq5HoCj41GWM9y
X-Google-Smtp-Source: ALg8bN6LyBDSq9tcTUzAgz4WEDbHausppV5k+dcq8eYIKaeuiXRsNufbH/Zl3W7TZj8eu8xDTg+OEw==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr3962765wmt.99.1547261046909;
        Fri, 11 Jan 2019 18:44:06 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k7sm61612621wrl.51.2019.01.11.18.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 18:44:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Karsten Blees <blees@dcon.de>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] diff: ensure correct lifetime of external_diff_cmd
References: <20190109221007.21624-1-kgybels@infogroep.be>
        <20190111202608.10576-1-kgybels@infogroep.be>
Date:   Fri, 11 Jan 2019 18:44:05 -0800
In-Reply-To: <20190111202608.10576-1-kgybels@infogroep.be> (Kim Gybels's
        message of "Fri, 11 Jan 2019 21:26:08 +0100")
Message-ID: <xmqq1s5iy4qy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Gybels <kgybels@infogroep.be> writes:

> According to getenv(3)'s notes:
>
>     The implementation of getenv() is not required to be reentrant.  The
>     string pointed to by the return value of getenv() may be statically
>     allocated, and can be modified by a subsequent call to getenv(),
>     putenv(3), setenv(3), or unsetenv(3).
> ...
> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> ---

Thanks, looking good.

Will queue.

>
> Uses xstrdup_or_null as suggested by Eric Sunshine.
>
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index dc9965e836..5634992bbc 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -487,11 +487,11 @@ static const char *external_diff(void)
>  	static const char *external_diff_cmd = NULL;
>  	static int done_preparing = 0;
>  
>  	if (done_preparing)
>  		return external_diff_cmd;
> -	external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
> +	external_diff_cmd = xstrdup_or_null(getenv("GIT_EXTERNAL_DIFF"));
>  	if (!external_diff_cmd)
>  		external_diff_cmd = external_diff_cmd_cfg;
>  	done_preparing = 1;
>  	return external_diff_cmd;
>  }
