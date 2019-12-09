Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B328BC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F0D20663
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI0GtSWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIVcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:32:22 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40177 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVcW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:32:22 -0500
Received: by mail-pj1-f68.google.com with SMTP id s35so6425695pjb.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AH1LkrRG3f9A3buh+eDxXfhfItmOTfIh69rqsT7FqI4=;
        b=dI0GtSWYmYPvWRb3Tu53dkBdziZWvoPGb0yurOKA0uzRhL6AgZvnrh7x32YJ3DwwOZ
         bCsoRzNqfbdUX4/iKqeOkfEG7g9TgLa+ApzUTRL8Yx8LHRNb4jqiWtnHLauEygNIoYc7
         nHHvSDhbAYTojtnC6pfQe+TyNG4z5S8pMKwOPwZewL6kY5UakYXp9fhX52/Um1ANKfZe
         a96DRYTcOscXJEKuSL6gAA/g65/uZOqUiadYbycw78WNPd7BgJxof/hBOUnSKAmtKWYT
         UWNZf/lWEbBHbtYEmaBZDHnSJehBWbafUId9w03I+LpomTtLp7CH+nlbZRYLg1JVye/4
         pj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AH1LkrRG3f9A3buh+eDxXfhfItmOTfIh69rqsT7FqI4=;
        b=nqPzeYyZ1aJjUUOEWUplMu6cf/bjnQ/U8VgNOjThwfT9KbU9PHfKhnbtCZJNXOvU/H
         jo86PAttY+ex48d7rdXXFcGDTQvtaQ3Ouq21gx79vL+Pmg0e+/kDs+D8QM7l/urLOEvk
         nS4Eo+kAlipqHslvcwm0oWWgDjUHg7qm2K2oqdHteWpRUa1FXFKOQk1R5DC5IXxU/HmV
         jH0tUj1C55KDyIZVlG44ENLbMs7mfFEb9KDwiZ7OmkxuCIxPtGphWbzg+R1Pv5JermOj
         RmdrOmGpavqeJDZ/rTVpX8R8w42GUToQDR7UcuIWUuMFiONdhfG1jqbtCXGUsDkurySM
         ojYQ==
X-Gm-Message-State: APjAAAWrf7yilEIg51vBOpHEgT6EkiwblvzLB4Tt6Wu+sdwOCuQAWM5V
        LbGk+E+Mzcgtv+AnI6ARx+M=
X-Google-Smtp-Source: APXvYqwiH2e2k75jrQchNvUFjVnuU5VCfOusyA95u2NvvaFsifgs9QbEqCFHlMT8L0e1VA9FYXYjIw==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr31983174plt.156.1575927141757;
        Mon, 09 Dec 2019 13:32:21 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id n26sm480109pgd.46.2019.12.09.13.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:32:21 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:32:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] Revert "dir.c: make 'git-status --ignored' work
 within leading directories"
Message-ID: <20191209213246.GA41680@generichostname>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <bfaf7592ee611f7e9f6fbcf7b1e4ae32f8307548.1575924465.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfaf7592ee611f7e9f6fbcf7b1e4ae32f8307548.1575924465.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, Dec 09, 2019 at 08:47:39PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index 0c394cf995..ded7f97181 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -43,11 +43,14 @@ test_expect_success 'status untracked directory with --ignored -u' '
>  	test_cmp expected actual
>  '
>  cat >expected <<\EOF
> -?? untracked/uncommitted
> +?? untracked/
>  !! untracked/ignored
>  EOF
>  
> -test_expect_success 'status prefixed untracked directory with --ignored' '
> +test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
> +	git status --porcelain --ignored | grep untracked/ >actual &&

Can we break this pipe up into two invocations so that we don't have a
git command in the upstream of a pipe?

Thanks,

Denton

P.S. Perhaps in the future, we (I) could try to extend chainlint so that
it catches this and git commands in non-assignment command
substitutions... I think that would be pretty nice.

> +	test_cmp expected actual &&
> +
>  	git status --porcelain --ignored untracked/ >actual &&
>  	test_cmp expected actual
>  '
> -- 
> gitgitgadget
> 
