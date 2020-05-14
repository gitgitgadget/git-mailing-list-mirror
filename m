Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D5C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F236D2054F
	for <git@archiver.kernel.org>; Thu, 14 May 2020 10:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs7Ad8QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgENKPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgENKPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 06:15:39 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E6C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 03:15:39 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l1so2362798qtp.6
        for <git@vger.kernel.org>; Thu, 14 May 2020 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qNQ2SMLW8KqyBcTD+QmIGos1GmzglhQzgB+nE8CnZAc=;
        b=hs7Ad8QARRbD2BWLZQt117C26Wl8T35R7Q8W8z32Ne25cIwm1+WrG8LkyehPDqRaqQ
         EMEqwbneOlUvYkHOKKJa2R3N2nCCtyKhLT6VCD1jpIY+yJGw0bJh1Y8oxCYjy6YFtSOl
         NZglculNZxrnzduNtRgjscYYNc+XzPtUsSbORZO/CwHWZyHnJ1REII5Ev6AcfAw5km+o
         gsbPmpFblXXtxKsGIcDx0YYyvmN1ZHWnUJTprFfp4ncxdHOZNYp3/PnpMq1ewqRKJtyR
         fLq80THSo9vihO50EjuJXP7EOfbsNPvC6bLByUcB6//FBrR2BMAf9/Cv+gR37HLpFT2a
         BUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNQ2SMLW8KqyBcTD+QmIGos1GmzglhQzgB+nE8CnZAc=;
        b=lBdeES5mu+K40g4eRmqJoFkZk9UE8ZkoxxdAo9mDvJIjFJ6zIJiiQ5bOWO+IIPYzJ4
         exHADvf19U9EERojMHrrqVhHm5/83Q7tg9Ve381Vbjr+erF30soKY8UKHZxabaODq7sH
         VgIKtbZ+QC96mRm5qPQv1BlVhs3Yu/+VwSO/MOGiXYjCCY2UKPjLJJ8l/nZPHAfKLESz
         5oofu9QBHkKl75sCqqXdAg1WRDQFQw79SWRWCbL3tXzQNSFO94tXZEgo2h/KuL0zGgw6
         u0avcPOo6vfOmrwzPR9IGOSw0qK2QXGLQiBwUieyfXHibtVAd3Mr3IX0EJNgt0a2JHUz
         qCWw==
X-Gm-Message-State: AOAM533knLkHLiIpgMjt6efW/HlKbHUC0g2poC9WZOD2nI0+8Ca607Bv
        VONNdGf0M9bhxX/nHoIZ9vg=
X-Google-Smtp-Source: ABdhPJwIJHqchyVKNEyN0YbOtviZdoKtmCiKgrpDOrh72AN/FILMJzS1KmEE6UD5Rv5MbO53mW3cQw==
X-Received: by 2002:ac8:4cd1:: with SMTP id l17mr3642141qtv.20.1589451338765;
        Thu, 14 May 2020 03:15:38 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id i59sm2224136qtb.58.2020.05.14.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 03:15:37 -0700 (PDT)
Date:   Thu, 14 May 2020 06:15:34 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] submodule: Add 'quiet' option in subcommand
 'set-branch'
Message-ID: <20200514101534.GB28018@generichostname>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <20200513201737.55778-2-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513201737.55778-2-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

I'm not really sure if we should have this patch at all since I don't
think that set-branch should be printing anything at all.

But I'll give some comments anyway. Hopefully they'll be enlightening.

On Thu, May 14, 2020 at 01:47:37AM +0530, Shourya Shukla wrote:
> The subcommand 'set-branch' had the 'quiet' option which was
> introduced in b57e8119e6 by Denton Liu but was never utilised due to

We typically refer to commits by the "reference" format. You can get
that as follows:

	$ git show --pretty=ref -s b57e8119e6
	b57e8119e6 (submodule: teach set-branch subcommand, 2019-02-08)

In addition, I don't think it's necessary to mention me by name in this
case.

> not setting of the 'GIT_QUIET' variable. Add functionality to
> utilise the 'quiet' function.
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> There was an existence of the `quiet` option in the shell version of
> 'set-branch' but it was not used anywhere. I decided to add a utility
> of the option here by setting GIT_QUIET to 1 in case of a `quiet` as
> well as ensure proper functioning in the C version regarding the same.
> The if-statement is inspired from what Junio suggested me in my previous
> conversion of 'set-url'.
> 
>  builtin/submodule--helper.c | 6 ++++--
>  git-submodule.sh            | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5a8815b76e..36b69df5c4 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2321,7 +2321,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
>  		config_name = xstrfmt("submodule.%s.branch", path);
>  		config_set_in_gitmodules_file_gently(config_name, newbranch);
>  
> -		printf(_("Default tracking branch set to '%s' successfully\n"), newbranch);
> +		if (!(quiet ? OPT_QUIET : 0))

This is needlessly complicated... Can't this just be written as

	if (!quiet)

> +			printf(_("Default tracking branch set to '%s' successfully\n"), newbranch);
>  		free(config_name);
>  	}
>  
> @@ -2334,7 +2335,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
>  		config_name = xstrfmt("submodule.%s.branch", path);
>  		config_set_in_gitmodules_file_gently(config_name, NULL);
>  
> -		printf(_("Default tracking branch set to 'master' successfully\n"));
> +		if (!(quiet ? OPT_QUIET : 0))
> +			printf(_("Default tracking branch set to 'master' successfully\n"));
>  		free(config_name);
>  	}
>  
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2438ef576e..0cdc77ace6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -725,7 +725,7 @@ cmd_set_branch() {
>  	do
>  		case "$1" in
>  		-q|--quiet)
> -			# we don't do anything with this but we need to accept it
> +			GIT_QUIET=1
>  			;;
>  		-d|--default)
>  			default=1
> -- 
> 2.26.2
> 
