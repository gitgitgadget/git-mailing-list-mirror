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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62416C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47608611C0
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 10:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGKhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 06:37:09 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:41503 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGKhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 06:37:08 -0400
Received: by mail-ej1-f50.google.com with SMTP id ho18so14844252ejc.8
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s33QJjIg6pKX70W5vefNnXsMPb9VZNQOtyucwQVFtdU=;
        b=ud0FBsjXwU5hvrfPK1GSKugkKDeJDu2YIAPJ+is3CoJaF8WdezLsyqvGh/4ssGvALI
         nEXHYgLdy1eq18Rdwb5I9ZawWE2WjokSwzTD9DazYb+FA0ng+w6Lu/t7nopUBliP63Id
         E3/jJr2D+OxGHlbLh3C8l0Z51KAbpg5JRO5zzQ0lZGQ1iRBPf8Oav01euTar5sFqt79U
         Y5X77UqPJekoK9rxvVk46NGTW73I4yu+mk7zT8gH7RCEgkVgjdD753cv+UazX98q1y4m
         zrodwgFQeOZcUMfLTIo98UizQR+vcpfZyDvaYJtfPaRBlhxUhzY9GkeeAmI656IBfh6q
         g1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s33QJjIg6pKX70W5vefNnXsMPb9VZNQOtyucwQVFtdU=;
        b=b1TQS3uZCUJeG00SnfNFr5OzAuXiGZMEbWdDX2yR1hf2ReKNn2V2eCscPKFlevvbQn
         nBQQQOA1zVyHrIom2IcKRO0qnp/U9axPu1fiLw1yPP9L0uIqRZJPdQ9Kkcjg7wHkU9Ck
         i56ZOeEJ9EwELmz7Sg35HVA7nEuUdVvXtdBe/v2qO4jdTRhJVZ8qKaPowiAxAwBWy5hM
         IWe+CeMhAGfDSsXA/05k+xuQWBpCV3/J6O6hELh/ExhEvDC6Ca9R7CeWNRfRC8jE6w44
         c8DFFq8eFfrGPMq83SfPQJfNVUBs54Qe1U0D8kVEnghEOTkogOsCOou7lZ9HRhVSLnSp
         M3rQ==
X-Gm-Message-State: AOAM532jLnzyPxiajYAfYPYXx2RALLu0X447AshKbo887HCHjQc2YXX9
        Ka44qsIWJUBbS5jdnlRxCZ7+RTUYxD55wQ==
X-Google-Smtp-Source: ABdhPJz+NO6RyRZbZtyEUfr9uKgqVr0NsmWRXFwWBdMKwMi/5zPlJJPQ/oY8PAYvin+ZaTGJjjlzDg==
X-Received: by 2002:a17:906:edb3:: with SMTP id sa19mr16983116ejb.75.1623062050356;
        Mon, 07 Jun 2021 03:34:10 -0700 (PDT)
Received: from [10.8.18.15] ([212.102.57.9])
        by smtp.gmail.com with ESMTPSA id r19sm7503809eds.75.2021.06.07.03.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 03:34:09 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH] rerere: enable by default
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfsxvxjj2.fsf@gitster.g>
Message-ID: <720154c0-eedb-db92-1b61-1df2e22fb128@gmail.com>
Date:   Mon, 7 Jun 2021 12:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqfsxvxjj2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06/2021 14:30, Junio C Hamano wrote:
> By default, the rerere machinery has been disabled since a bug in
> the machinery could screw up the end user's data at the most
> stressful time during the end user's workday (i.e. during conflict
> resolution).
> 
> It however has been in wide use without causing much trouble (other
> than, obviously, replaying a broken conflict resolution that was
> recorded earlier when the user made a mismerge), and it is about
> time to enable it by default.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/config/rerere.txt |  5 ++---
>   rerere.c                        | 12 +++---------
>   t/t2030-unresolve-info.sh       |  3 +++
>   3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/config/rerere.txt b/Documentation/config/rerere.txt
> index 40abdf6a6b..45e97fc0fa 100644
> --- a/Documentation/config/rerere.txt
> +++ b/Documentation/config/rerere.txt
> @@ -7,6 +7,5 @@ rerere.enabled::
>   	Activate recording of resolved conflicts, so that identical
>   	conflict hunks can be resolved automatically, should they be
>   	encountered again.  By default, linkgit:git-rerere[1] is
> -	enabled if there is an `rr-cache` directory under the
> -	`$GIT_DIR`, e.g. if "rerere" was previously used in the
> -	repository.
> +	enabled, but this configuration can be set to 'false' to

At the moment, backticks are used more often than single quotes
for formatting of boolean values in documentation:

     $ git grep -oE "\`(false|true)\`" -- Documentation/*.txt Documentation/config/*.txt | wc -l
     121
     $ git grep -oE "'(false|true)'" -- Documentation/*.txt Documentation/config/*.txt | wc -l
     53

> +	turn it off.
