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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93317C433E2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A01B61972
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhC1Kbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 06:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhC1KbB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 06:31:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C95C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:31:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so11082544eds.7
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0uU8s78KuPNKCzxD1QqYx/XOhg9u04GsJH7Eu0Ykxo=;
        b=MEB5JCjc0CUr0sHIH3SXOuDx9gSmiQgMBhXVe8Qc9b+NiNjr92PIpnb8Lj6WwZCpPY
         EAil0u53lT+ljFff/IcmUL+hJk+s8pwuD5mHx7pnFqJGsj3958Yagdyr16wXTYj+aWlo
         USXNNYDwXu74+iPjyGw9sJPibNx7osYdYUcVYod6lQhQCN46hZfo63GFx7+VkVTpgWzu
         +1Hf75+iuxsvs8vou6JQVw7QTqNUshmzM0Ugl1KtjxhDPz+HYze3QBXN19NSvn/AV6rK
         ewQ9DkD6RWiDaOwhcawDi8KoN+450TK8NI5A+CKlK8sLSQAodK2DJ1Ti4g5ePyEM3ylv
         WETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0uU8s78KuPNKCzxD1QqYx/XOhg9u04GsJH7Eu0Ykxo=;
        b=aqZlgbz98Eyv7/syfM9YccGITEQOqsgl8XOxdlQCPcZL4FWlmJQ8Q8pN0khEK13fso
         hgwKta1L3fdtnZbzyUUpfpMGne97wY5sbThf/NFuoyRMHoOJtdrvEixJ0QOdTaLob3DB
         1XzbcrYyG6PPMtrTBpWqc/YX/7v/TXczWmVeimvNjXz3+Gd4ph/xC8+7xYD8PfuS0UFm
         RB98Z80GOw2Ff0pvITey9UYVt2DKo1HlHLOapLpi6PZqVI2I3Gy95EO7vwbw0v/WR/VO
         /Xjm8BpXkOseGs7yf9BeElvWaEchS9NUk5C6rZzvbE9U3wQfxBjVZqDB1X7H4JeSc08T
         luaQ==
X-Gm-Message-State: AOAM532fyCpob/7fCwnmPVKrvCO2PEgAJsSsGVU0EiDmNO6dFFvzmTt7
        A+N6QrX6n/aqzf1xxFkL46c=
X-Google-Smtp-Source: ABdhPJzGF4RPE1zT+9ri5YwJ32zkMfftJS1mUTD3moyHfMY7MfWW/fuKQzuQPaUdMYCmC5yo2mR38A==
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr23772766edx.273.1616927459471;
        Sun, 28 Mar 2021 03:30:59 -0700 (PDT)
Received: from szeder.dev (84-236-109-92.pool.digikabel.hu. [84.236.109.92])
        by smtp.gmail.com with ESMTPSA id v8sm7050882edc.30.2021.03.28.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 03:30:59 -0700 (PDT)
Date:   Sun, 28 Mar 2021 12:30:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] git-completion.bash: extract from else in
 _git_stash()
Message-ID: <20210328103057.GE2271@szeder.dev>
References: <cover.1615855962.git.liu.denton@gmail.com>
 <cover.1616574955.git.liu.denton@gmail.com>
 <430d5acf972f39aa8cfc9b266dd658aabcf1babb.1616574955.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <430d5acf972f39aa8cfc9b266dd658aabcf1babb.1616574955.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 01:36:28AM -0700, Denton Liu wrote:
> To save a level of indentation, perform an early return in the "if" arm
> so we can move the "else" code out of the block.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 73 +++++++++++++-------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index a2f1b5e916..8d4d8cc0fe 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3035,44 +3035,45 @@ _git_stash ()

That "if arm" mentioned in the commit message outside the patch
context looks like this:

        if [ -z "$subcommand" ]; then
                case "$cur" in
                [ handle the cases when there is no subcommand]

So we could simplify this further dropping that "if" completely, and
unify the two case blocks from the if and else branches like this:

        case "$subcommand,$cur" in
        [ handle the cases without a subcommand ]
        ,--*)  [ ... ]
        [ ... ]
        [ handle the casese with a subcommand, just like you did in
          this patch ]
        esac

I think this would also make the thid patch a bit simpler.

>  			fi
>  			;;
>  		esac
> -	else
> -		case "$subcommand,$cur" in
> -		push,--*)
> -			__gitcomp "$save_opts --message"
> -			;;
> -		save,--*)
> -			__gitcomp "$save_opts"
> -			;;
> -		apply,--*|pop,--*)
> -			__gitcomp "--index --quiet"
> -			;;
> -		drop,--*)
> -			__gitcomp "--quiet"
> -			;;
> -		list,--*)
> -			__gitcomp "--name-status --oneline --patch-with-stat"
> -			;;
> -		show,--*)
> -			__gitcomp "$__git_diff_common_options"
> -			;;
> -		branch,--*)
> -			;;
> -		branch,*)
> -			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
> -				__git_complete_refs
> -			else
> -				__gitcomp_nl "$(__git stash list \
> -						| sed -n -e 's/:.*//p')"
> -			fi
> -			;;
> -		show,*|apply,*|drop,*|pop,*)
> +		return
> +	fi
> +
> +	case "$subcommand,$cur" in
> +	push,--*)
> +		__gitcomp "$save_opts --message"
> +		;;
> +	save,--*)
> +		__gitcomp "$save_opts"
> +		;;
> +	apply,--*|pop,--*)
> +		__gitcomp "--index --quiet"
> +		;;
> +	drop,--*)
> +		__gitcomp "--quiet"
> +		;;
> +	list,--*)
> +		__gitcomp "--name-status --oneline --patch-with-stat"
> +		;;
> +	show,--*)
> +		__gitcomp "$__git_diff_common_options"
> +		;;
> +	branch,--*)
> +		;;
> +	branch,*)
> +		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
> +			__git_complete_refs
> +		else
>  			__gitcomp_nl "$(__git stash list \
>  					| sed -n -e 's/:.*//p')"
> -			;;
> -		*)
> -			;;
> -		esac
> -	fi
> +		fi
> +		;;
> +	show,*|apply,*|drop,*|pop,*)
> +		__gitcomp_nl "$(__git stash list \
> +				| sed -n -e 's/:.*//p')"
> +		;;
> +	*)
> +		;;
> +	esac
>  }
>  
>  _git_submodule ()
> -- 
> 2.31.0.rc2.261.g7f71774620
> 
