Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABBC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 14:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D71020702
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 14:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbv/T1Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgGAOR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgGAOR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 10:17:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE2DC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 07:17:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so7947103pjq.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BWoi2X5NQsKN0eLIiNNz0qh7y/vB9p09oOKPl5OAueU=;
        b=Wbv/T1TdNP6rRVKFztfhqfqyzv4Df8Y75YnRKuriGVLUcnSNd4uuweayMKOW0KDpB2
         NA2/T/BCFtY/wCqQsvlteP3cr8d8ZwsOLF5CLThM4ijxNqFeA7Js4L9CfUBysGXXaYCl
         iOf2o7RigYip1I2L/avvXptdL3DHwfPi2VPztna/Fd5IIvuMnkxV5aEonaIWtQEAZ3iN
         3OpVZ/LGaECJhmxYrL19F2jr3l6XXK8N9fU8XUL74wqurLz5XK8b8QUcp+OH3K8+uyXr
         sG7erD8mEp/X2SbjOAuMhvmGWxLMYIGU3PgVutjYa6OB0m6itpomYoFXeFEWWmhOD++7
         6KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWoi2X5NQsKN0eLIiNNz0qh7y/vB9p09oOKPl5OAueU=;
        b=mlrfNn/BMr4yXqqmoCW6PdjuBlyrGTTd7lmmtDVvDfK/MeCtcU6WofI5ujzbNFqPg3
         PX5HsRyue7S84UxbIaLwKzN+8V8u9yNSopi3EIZuKTtpoQjJiFP5iXotnhUasSMUiGWy
         Ato2k8/cE9RcvVYnRGsPCDwtHDssWPGSAHa5A59kFf/zFDuOG5WiMxRecuowzvPTXgnH
         XFELr9+IjagwxEIN+B4M0iLWWKAJNjLmrPAZDlOOPm4mA4iUU4nmh7GWvEejC+vRsvdr
         /8B3SD5hi/aCcW9M05WlovrR4/I1W3WJsL10UQfFp0ZfTBrpS8AQNTFgK7MDSszXIwfF
         G7GQ==
X-Gm-Message-State: AOAM53277fxWXR0+tpM5ocpFv0XwyOkNSQwK9hfLwtO3WPL+97vuaFsp
        53k6G/qvkkgCKZzH3d2E11M=
X-Google-Smtp-Source: ABdhPJzJ9bZg5BT176Butu11WlfImt9kw+F2LohwbS9cvysDfYU9WVLFqQGrbj9Vg4xXrPBllZ0pxg==
X-Received: by 2002:a17:90b:405:: with SMTP id v5mr2983666pjz.226.1593613078642;
        Wed, 01 Jul 2020 07:17:58 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id 144sm6240904pfb.31.2020.07.01.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 07:17:57 -0700 (PDT)
Date:   Wed, 1 Jul 2020 21:17:55 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v5] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200701141755.GB1966@danh.dev>
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
 <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-01 07:06:46+0000, sunlin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Lin Sun <lin.sun@zoom.us>
> 
> Make the mergetool used with "meld" backend behave similarly to
> how "vimdiff" behavior by telling it to auto-merge parts without
> conflicts and highlight the parts with conflicts when configuring
> `mergetool.meld.hasAutoMerge` with `true`, or `auto` for
> automatically detecting the option.
> 
> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> ---
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 09ed31dbfa..9a74bd98dc 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -30,6 +30,14 @@ mergetool.meld.hasOutput::
>  	to `true` tells Git to unconditionally use the `--output` option,
>  	and `false` avoids using `--output`.
>  
> +mergetool.meld.hasAutoMerge::
> +	Older versions of `meld` do not support the `--auto-merge` option.
> +	Setting `mergetool.meld.hasOutput` to `true` tells Git to

s/hasOutput/hasAutoMerge/

Bikeshed opinion: I don't know if hasAutoMerge is a good name :)

> +	unconditionally use the `--auto-merge` option, and `false` avoids using
> +	`--auto-merge`, and `auto` detect whether `meld` supports `--auto-merge`
> +	by inspecting the output of `meld --help`, otherwise, follow meld's
> +	default behavior.
> +
>  mergetool.keepBackup::
>  	After performing a merge, the original file with conflict markers
>  	can be saved as a file with a `.orig` extension.  If this variable
> diff --git a/mergetools/meld b/mergetools/meld
> index 7a08470f88..9ee835b1e5 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -3,34 +3,74 @@ diff_cmd () {
>  }
>  
>  merge_cmd () {
> -	if test -z "${meld_has_output_option:+set}"
> +	check_meld_for_features
> +
> +	option_auto_merge=
> +	if test "$meld_has_auto_merge_option" = true
>  	then
> -		check_meld_for_output_version
> +		option_auto_merge="--auto-merge"
>  	fi
>  
>  	if test "$meld_has_output_option" = true
>  	then
> -		"$merge_tool_path" --output="$MERGED" \
> +		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
>  			"$LOCAL" "$BASE" "$REMOTE"
>  	else
> -		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
>  	fi
>  }
>  
> -# Check whether we should use 'meld --output <file>'
> -check_meld_for_output_version () {
> -	meld_path="$(git config mergetool.meld.path)"
> -	meld_path="${meld_path:-meld}"
> +# Get meld help message
> +get_meld_help_msg () {
> +	meld_path="$(git config mergetool.meld.path || echo meld)"
> +	$meld_path --help 2>&1
> +}

I'm actually prefer this change in 2 separated patches to reduce noise.
But given that mergetool/meld doesn't attract much attention, I don't know.

>  
> -	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +# Check the features and set flags
> +check_meld_for_features () {
> +	# Check whether we should use 'meld --output <file>'
> +	if test -z "${meld_has_output_option:+set}"
>  	then
> -		: use configured value
> -	elif "$meld_path" --help 2>&1 |
> -		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
> +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +		if test "$meld_has_output_option" = true -o \
> +			"$meld_has_output_option" = false

The coding guideline seems to not like "test -o".
I think it's acceptable in this case since we control its input.
The output is comming out of "git config --bool" anyway,
so meld_has_output_option must be either "", "true", or "false"

I think we're better to do this instead:

	if test -n "$meld_has_output_option"
	then
		: use configured output
	else
		: messing with help
	fi

> +		then
> +			: use configured value
> +		else
> +			# treat meld_has_output_option as "auto"
> +			if test -z "$meld_help_msg"
> +			then
> +				meld_help_msg="$(get_meld_help_msg)"
> +			fi

If I were writing this patch, I probably changed get_meld_help_msg to

	init_meld_help_msg () {
		if test -z "$meld_help_msg"
		then
			meld_path="$(git config mergetool.meld.path || echo meld)"
			meld_help_msg=$($meld_path --help 2>&1)
		fi
	}

And call init_meld_help_msg unconditionally here,
(and in --auto-merge arm below, maybe other arms in the future).

I'm writing without much thought into this,
please take my word with a grain of salt :)

> +}


> +
> +			case "$meld_help_msg" in
> +				*"--output="* | *"[OPTION"???"]"*)

I think Git project prefer aligning case arm with case,
IOW, move left 1 TAB.

> +					# old ones mention --output and new ones just say OPTION...
> +					meld_has_output_option=true ;;

It's nice to see this update, good.
The comment is no longer correct, though.
The version 3.20.2 has --output but not OPTIONS.

It's not introduced by your change, but I think it's better to say:

	# All versions that has [OPTIONS???] supports --output

> +				*)
> +					meld_has_output_option=false ;;
> +			esac
> +		fi
> +	fi
> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "${meld_has_auto_merge_option:+set}"
>  	then
> -		: old ones mention --output and new ones just say OPTION...
> -		meld_has_output_option=true
> -	else
> -		meld_has_output_option=false
> +		meld_has_auto_merge_option=$(git config mergetool.meld.hasAutoMerge)
> +		if test "$meld_has_auto_merge_option" = auto

Since we don't canonicallise to bool output of
mergetool.meld.hasAutoMerge, I think we would need:

	case "$meld_has_auto_merge_option" in
	[Tt]rue|[Yy]es|[Oo]n)
		meld_has_auto_merge_option=true ;;
	auto)
		: this shenanigan ;;
	esac

But, that's a bit messy. Let's see other's opinions.

> +		then
> +			# testing the "--auto-merge" option only if config is "auto"
> +			if test -z "$meld_help_msg"
> +			then
> +					meld_help_msg="$(get_meld_help_msg)"
> +			fi
> +
> +			case "$meld_help_msg" in
> +				*"--auto-merge"*)
> +					: old ones mention --output and new ones just say OPTION...

This comment doesn't apply here.

> +					meld_has_auto_merge_option=true ;;
> +				*)
> +					meld_has_auto_merge_option=false ;;
> +			esac
> +		fi
>  	fi
>  }
> 
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
> -- 
> gitgitgadget

-- 
Danh
