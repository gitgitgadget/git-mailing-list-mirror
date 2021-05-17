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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9572C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E796112F
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhEQQwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhEQQwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:52:42 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007E2C061349
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:49:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id o59so3450580qva.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6AhOkeGrQI5xQZikJsG+8Q31g1tWZQMfqVNXVvKd8oI=;
        b=WQtei7AgUwB8aSGzt4j6jyJe7WUhNWebj5AZjl2SoQUgXQgSHSY0U5UwyQiegobWiK
         TuCxOr/sefNqLxV+ZNxueWsOoSoDhqCKHAVfsnvikgkKRT0HM7fxPe1GYB8+2d+IM1RL
         ZPjC/jcDehTyjzFlg9Ml+ZY2IH/B29xs4bSFv3LY7qIZtRdku5yWZKC9Afpui2FQux2G
         eL+h4CAUgwlfDa79rgX9egfm5PGBT6h1jmAH3ly54CIGY/rexWjQJLpuHxNP5iX7qMXH
         T5yubC1RZu5jmoCiaBAZtBS8Bnh8zfm2vuNCdvY/YSObjMZ1BQxydg0wpTzrVT+4N1F8
         ln0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6AhOkeGrQI5xQZikJsG+8Q31g1tWZQMfqVNXVvKd8oI=;
        b=snqYBsNXGsuS8xuNZmoye3VY+tAS6xPLGDFq/dnUEtADC3Ul6sBaW+LP+vWwvgjTO0
         DvRorJ1G04SY5CU33ESuQ4IFtiJZ2ddxh1c35PpSgZ4TE8dJKmDXfDgEVgXP99iMtKf2
         8aACywCU3REZt2+IgQVPgydBjZ/7t/OJvWZFkibUhHpdHWkvlJ3PLKbbF+u79OSBM9tR
         4L16f/gQNGsQDaJOGiokgv/sI1vcyl51gj0G84rU0N5Bj+lw8+gmULObunJzzg09a8O6
         45TFJSHSUSj1VGv3sUmv6LKDYYRW+jA3dzVJzu9x72sAZV8PAXNHo6Q3cdwgeorRctVz
         DbTQ==
X-Gm-Message-State: AOAM5333TafwiIW94b5xUElHkiBHTa1BdjeNbWqG+Cm0ROrZBaFwm+ju
        bh7lfWsI4lVptWAHsdIFLEo=
X-Google-Smtp-Source: ABdhPJxJ2GP0bHse+5hU45E2rRWm0p0u44Tb2dyciy6fog1dXRv4g5GKOgquRy1WjbuEbOMK0IE0qQ==
X-Received: by 2002:a05:6214:d87:: with SMTP id e7mr532507qve.53.1621270196991;
        Mon, 17 May 2021 09:49:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id o12sm10889750qtg.14.2021.05.17.09.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 09:49:56 -0700 (PDT)
Subject: Re: [PATCH] merge: don't translate literal commands
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, judge.packham@gmail.com, gitster@pobox.com
References: <20210515200111.19912-1-alexhenrie24@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <77314c35-281c-38af-c993-32a0c092b1cc@gmail.com>
Date:   Mon, 17 May 2021 12:49:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515200111.19912-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2021 4:01 PM, Alex Henrie wrote:
> These strings have not been modified in any translation, nor should they
> be.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/merge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index eddb8ae70d..a8a843b1f5 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -56,8 +56,8 @@ struct strategy {
>  
>  static const char * const builtin_merge_usage[] = {
>  	N_("git merge [<options>] [<commit>...]"),
> -	N_("git merge --abort"),
> -	N_("git merge --continue"),
> +	"git merge --abort",
> +	"git merge --continue",

I just commented on your other patch wondering if there
were other examples that needed update. I think these
would be better suited to be grouped as a patch series
that describes the effort to remove unnecessary translation
as a unified whole.

Thanks,
-Stolee
