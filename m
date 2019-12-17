Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7FAC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 15:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA4B24650
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 15:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp4pSIM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfLQPdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:33:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35021 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfLQPds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 10:33:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so3923756qto.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 07:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eW9zoeoSNNRN7I8lx9ljpfHtvFh1LpiHJCTTxHMGjS0=;
        b=gp4pSIM8ocyv1y4bSrTg9x+ae1JX5q8tMEpMr7nWvTXuPmyyscx1bfeL0YEtnJ6tBT
         owB5A7dwRfbICp/TjU2STnRobSu40wrrIKTiHwLiMJYGD9lnGlcYcgN67++MXYJduXhF
         RzhEh1+hD7QefpcWbF4Q/o/aRILxoMiVRxjDxpH1UD++W+PqfXqJEqgW1f6boldRIL+4
         wJxA9pGpRqe3UlVpkiLR0FEMCFfUNec/85Ra+d63uUewzUb5uJPaFNDpG+MXUPt9T3Hc
         AZnJg261xIrjT8uXtbOAq+E0iJyreASeTc12fJ2mr4iKk52NzX7QktDV+aBsiqj3yGyZ
         dCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eW9zoeoSNNRN7I8lx9ljpfHtvFh1LpiHJCTTxHMGjS0=;
        b=Xi4GDHoNkkvKFMr/soZrNqE/V764D1IVUojHx+8jKajLToyux309OVX5AEAtb8GYyR
         Wgf91NvNCIQbBUcfCy2LeJLvwmakNPuu7BY2eVmjvRncBsACfUPeOX+Qyc0vzRubC6CR
         8i7hlQEm7vmU7U0emfbxuD1o5nzZ0J5rc6UxVAZ+7ZZ7+UaQfEN6qNCUtLym3PCj0aVG
         tdEuy1qTohrZdadMM+WLSLc8BOxDZVPuBiq0F+US3JcdDyi92uAKyTzey6t3+7VH7X3r
         5GVpA4+kFDa9bGeC+D8zTCNHuslYywjuVO9GgHqPtYfFPNWRH0EHBxcfNoWq98FlKNa8
         b2Mg==
X-Gm-Message-State: APjAAAXPjq27taUTNCmZjsDtN0loSQVoLvzP+Z4mrbDO/StJH1LgmrMR
        65axKgU4J2OVVY2Wrp7wm8XF3O/X5JE=
X-Google-Smtp-Source: APXvYqzQV24ZF/tbEtgwKsYJcf24yFX3MAfzP2ZVDcm1aXqzz3orCt/BS5oboI0o8a3P0QKoZVnnIw==
X-Received: by 2002:ac8:3751:: with SMTP id p17mr5128699qtb.9.1576596827639;
        Tue, 17 Dec 2019 07:33:47 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:69bf:641a:5651:1a45? ([2001:4898:a800:1012:1af3:641a:5651:1a45])
        by smtp.gmail.com with ESMTPSA id t73sm7200188qke.71.2019.12.17.07.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:33:46 -0800 (PST)
Subject: Re: [PATCH 1/2] Documentation/git-log: document accepted line-log
 diff formats
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
 <0ed04a8629a64d15062e13c1f1739b01436a897b.1576559263.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ba68e03a-18ff-0fb4-e64a-002b6d6c4d4a@gmail.com>
Date:   Tue, 17 Dec 2019 10:33:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <0ed04a8629a64d15062e13c1f1739b01436a897b.1576559263.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17/2019 12:07 AM, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> Currently the line-log functionality (git log -L) only supports
> displaying patch output (`-p`, its default behavior) and suppressing it
> (`-s`). A check was added in the code to that effect in 5314efaea (line-log:
> detect unsupported formats, 2019-03-10) but the documentation was not
> updated.
> 
> Explicitly mention that `-L` implies `-p`, that patch output can be
> suppressed using `-s`, and that all other diff formats are not allowed.
> 
> Additionnally, mention that the ':<funcname>' form implies `--function-context`.

s/Additionnally/Additionally/

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/git-log.txt | 6 +++++-
>  Documentation/gitk.txt    | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index b406bc4c48..1c52bf184d 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -77,7 +77,11 @@ produced by `--stat`, etc.
>  	not give any pathspec limiters.  This is currently limited to
>  	a walk starting from a single revision, i.e., you may only
>  	give zero or one positive revision arguments.
> -	You can specify this option more than once.
> +	You can specify this option more than once. Implies `--patch`.
> +	If ``:<funcname>'' is given, implies `--function-context`.
> +	Patch output can be suppressed using `-s`, but other diff formats

I would prefer the longer "--no-patch" over "-s", especially because you
follow with several options in this style.

> +	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
> +	`--name-only`, `--name-status`, `--check`) are not currently implemented.
>  +
>  include::line-range-format.txt[]
>  
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index 1eabb0aaf3..91993b9d4c 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -106,7 +106,11 @@ linkgit:git-rev-list[1] for a complete list.
>  	not give any pathspec limiters.  This is currently limited to
>  	a walk starting from a single revision, i.e., you may only
>  	give zero or one positive revision arguments.
> -	You can specify this option more than once.
> +	You can specify this option more than once. Implies `--patch`.
> +	If ``:<funcname>'' is given, implies `--function-context`.
> +	Patch output can be suppressed using `-s`, but other diff formats

(same)

> +	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
> +	`--name-only`, `--name-status`, `--check`) are not currently implemented.

Thanks,
-Stolee

