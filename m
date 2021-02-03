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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4231C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE6464E07
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhBCUBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhBCUBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 15:01:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468B7C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 12:00:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so859456wml.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FE3OHPHHAOp7amJnJRIc7J9/eeDCPsDC1iNtQPdi0dg=;
        b=NNwTLDolwPr2TQPFbCJ2ovY7eLDUxozR9emahlk6bMj0x5e3eHEExx3z5zISon0blV
         eVdZmDTAS3xsyGd7m2efF+LW3efB8kq8WfkNv1WkHwD43rVlm1vC1eR/2ERe9rl54h4I
         fZmIFl9jOUsJuFI51ERufcS2MpSfWqhrIMZ5/i5PMqAOdPsixrZcmOmrufv8Qt+fOlUQ
         oYtr0Q3/j1uEBq++OCUY3ezSFbK0MTo2UTKn7JLn9FLoCsCTTe33YWxFFWgcHSJhF2yp
         AhIuVLAOI+jSkxqpOZHfpK6BONY3XWDNRqHABXAU6zZId5XcNN5qfcTUTjN7c0vc2XIN
         nBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FE3OHPHHAOp7amJnJRIc7J9/eeDCPsDC1iNtQPdi0dg=;
        b=DX6a/FaMbAU6nozCPP7LVLHDqE0GrgUDKRxpl7Y/qaIVpCm7nZSq4hJLcKjxDin0bB
         qJJv4Bnkmuw2+HPd8lgZckVuTHrVFPxjnXJF9Dd7BudxoGtIE7EPYMStwCBc1LzlZH3k
         EIa56QoRPpUL77Du2iAtMDMviNag0ud7JuEEDcrPqzCzwP+1GJP7Ky2TsjAuv/CXJgEB
         0LOZdkdNtVgKM1N75JrUA6E2MM58G9S4ZMT9KAn17mDX9Ai1UZRH/TdSwLJX04SQ/wqB
         8HeCVRJszGjntGmcUki/xV9oLJliDl15bSdYxoClguIbWxNcpbeh27PSN1FqE2xQ/4a9
         dh9w==
X-Gm-Message-State: AOAM533Or6wtU6pqU8v+BBXp/RmfUuhx+VlgIP0oCD7klUdIApy1g71j
        JOtnvg0XuwgEw0xoJUyGXZriVm60V08=
X-Google-Smtp-Source: ABdhPJwBd0twCTvzNN1vzSkgx9Eagy4GK4rsfRH63QZpzgMGYh6Fka0SYsOoq27pvlmFvHOOhGuqBw==
X-Received: by 2002:a7b:c3ca:: with SMTP id t10mr3482885wmj.138.1612382450113;
        Wed, 03 Feb 2021 12:00:50 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id f14sm3839531wmc.32.2021.02.03.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:00:49 -0800 (PST)
Date:   Wed, 3 Feb 2021 21:00:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Paul Jolly <paul@myitcv.io>,
        git@vger.kernel.org
Subject: Re: Bash completion suggests tags for git branch -D
Message-ID: <20210203200047.GB1036595@szeder.dev>
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
 <YBkVFTOP6K1//i6m@coredump.intra.peff.net>
 <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
 <xmqqpn1igznk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn1igznk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 09:14:39AM -0800, Junio C Hamano wrote:
> From: Jeff King <peff@peff.net>
> Date: Tue Feb 2 04:02:13 2021 -0500
> Subject: [PATCH] completion: treat "branch -D" the same way as "branch -d"
> 
> Paul Jolly noticed that the former offers not just branches but tags
> as completion candidates.  Mimic how "branch -d" limits its suggestion
> to branch names.

Uh-oh.  This is a bug from my second ever commit in Git! ;)

'-M' should be handled the same.

> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 4b1f4264a6..b54113e2f9 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1447,7 +1447,7 @@ _git_branch ()
>  	while [ $c -lt $cword ]; do
>  		i="${words[c]}"
>  		case "$i" in
> -		-d|--delete|-m|--move)	only_local_ref="y" ;;
> +		-d|--delete|-D|-m|--move)	only_local_ref="y" ;;
>  		-r|--remotes)		has_r="y" ;;
>  		esac
>  		((c++))
> -- 
> 2.30.0-586-g047f30a795
> 
