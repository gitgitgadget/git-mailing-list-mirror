Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71501C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 18:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B45B20870
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 18:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5TET4Is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbgGASTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732172AbgGASTv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 14:19:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21EC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 11:19:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so959223pls.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HiQ4/F4fT0TdeWXaE8WKPlzshbfxvBJJ6RKEQP0wQRw=;
        b=B5TET4Is5HFgn0MJBqhOIWCdcLVPUHZ2CScHc+cLib/D3yi7UopNpQ0HWpUQiH/Wmq
         8Yrrq/0/uLv7HzD+diomBE3bsRtfUyBApvR/um1D8Tz298uzocUmc/iCj3y7RQk4JXtt
         t48YRIO5rUbhp17KtcL7v9yuCptF7sY2h/W4oNILza5ae79insOahWktpGqoJ6Ox/Sim
         L9ibT+/rBC/knaeCZkigwUfyTDNlLrqq/pi4tOLW+bUKWT4+DsF1+SSZlu7bUdEoL6+n
         wEQWzf3B/qseNw/pS26E2DCWe7Di5RvCjEDKDw3/fbh6ZcSX9mWcHJrEPN6t9VZND+M7
         OSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HiQ4/F4fT0TdeWXaE8WKPlzshbfxvBJJ6RKEQP0wQRw=;
        b=tZJH+dN0kbAgM6eq9OvcJGAmyX41R8lYMWvppegh/VyoetCeDBS9xl+o8fw+b8eziX
         lk4GmduwRWc22juwaq1YYOkJJK3/PpcTS/CkSGmx1EuMZ6jcwkrP2S5fHUc+csSt9ngH
         a4vPC9G5W2Vx0OX4TGlnHLEYL3JVqiS99XT5dSJ9OW/y5cgdurzqLkrPlHzJjEPM4ooe
         6TiQkNN3yL5b+/oHxcQAEPHuSf/fXQVr0TGaIZuBWgj7kbVtj8rJ4Q4M8BMr2621wJxZ
         F8g/DoopT/3vwiW6/xyEGhw18rtQI9KrGkPh1eO3z2oBGAWDGVyvUEZYctsng485cNT/
         wF7g==
X-Gm-Message-State: AOAM531YSa7KHG0sECTR8IfVhS7dC8QETgHO8A9lzMCEzjUPawJS2BcQ
        OysEUFD6fVAKMwVZcx9HJck=
X-Google-Smtp-Source: ABdhPJxI5jzHP37CUnZFBuZrIsufBhundQ5worDoqA4A/Kz4rLe/f+0shvsXH/Mbgi/6DiXmTnMYZQ==
X-Received: by 2002:a17:90b:2350:: with SMTP id ms16mr1794441pjb.127.1593627591164;
        Wed, 01 Jul 2020 11:19:51 -0700 (PDT)
Received: from gmail.com (108-81-23-119.lightspeed.irvnca.sbcglobal.net. [108.81.23.119])
        by smtp.gmail.com with ESMTPSA id l9sm5349309pjy.2.2020.07.01.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 11:19:50 -0700 (PDT)
Date:   Wed, 1 Jul 2020 11:19:47 -0700
From:   David Aguilar <davvid@gmail.com>
To:     lin.sun@zoom.us
Cc:     'sunlin via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh' 
        <congdanhqx@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH v5] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200701181947.GA16794@gmail.com>
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
 <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
 <1514701d64f78$970ba180$c522e480$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1514701d64f78$970ba180$c522e480$@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 03:23:56PM +0800, lin.sun@zoom.us wrote:
> Hi Danh,
> 
> The [PATH v5] is changed to following the comments from you, Junio, David. 
> Please review this newer version. Thank you.
> The raw files is https://github.com/git/git/blob/344817d57970e3ac0910cdd8ad47bf97334ab2a6/mergetools/meld
> 
> Regards
> Lin
> -----Original Message-----
> From: sunlin via GitGitGadget <gitgitgadget@gmail.com> 
> Sent: Wednesday, July 1, 2020 15:07
> To: git@vger.kernel.org
> Cc: sunlin <sunlin7@yahoo.com>; Lin Sun <lin.sun@zoom.us>
> Subject: [PATCH v5] Enable auto-merge for meld to follow the vim-diff beharior
> 
> From: Lin Sun <lin.sun@zoom.us>
> 
> Make the mergetool used with "meld" backend behave similarly to how "vimdiff" behavior by telling it to auto-merge parts without conflicts and highlight the parts with conflicts when configuring `mergetool.meld.hasAutoMerge` with `true`, or `auto` for automatically detecting the option.

Please word-wrap commit messages to 72 chars or less.


> 
> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> ---
>  Documentation/config/mergetool.txt |  8 ++++
>  mergetools/meld                    | 72 +++++++++++++++++++++++-------
>  2 files changed, 64 insertions(+), 16 deletions(-)
> 
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
> +	unconditionally use the `--auto-merge` option, and `false` avoids using
> +	`--auto-merge`, and `auto` detect whether `meld` supports `--auto-merge`
> +	by inspecting the output of `meld --help`, otherwise, follow meld's
> +	default behavior.
> +

Now that we've decided that "false" should be the default behavior, the
naming of this option don't make sense.  "hasAutoMerge" doesn't
really convey what this option does anymore.  I would suggest calling it
"mergetool.meld.automerge".

Perhaps something like this?

mergetool.meld.automerge::
	Older versions of `meld` do not support the `--auto-merge`
	option.  Setting `mergetool.meld.automerge` to `true` tells Git
	to unconditionally use the `--auto-merge` option with `meld`.
	Setting this value to `auto` makes git detect whether
	`--auto-merge` is supported and will only use `--auto-merge`
	when available.  A value of `false` avoids using `--auto-merge`
	altogether, and is the default value.

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

This comment seems redundant when the function is called
get_meld_help_msg().


> +	meld_path="$(git config mergetool.meld.path || echo meld)"
> +	$meld_path --help 2>&1
> +}
>  
> -	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +# Check the features and set flags
> +check_meld_for_features () {

Ditto for this comment.


> +	# Check whether we should use 'meld --output <file>'
> +	if test -z "${meld_has_output_option:+set}"
>  	then
> -		: use configured value
> -	elif "$meld_path" --help 2>&1 |
> -		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
> +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +		if test "$meld_has_output_option" = true -o \
> +			"$meld_has_output_option" = false

Documentation/CodingGuidelines mentions:

 - We do not write our "test" command with "-a" and "-o" and use "&&"
   or "||" to concatenate multiple "test" commands instead, because
   the use of "-a/-o" is often error-prone.  E.g.

This would be written as:

	if test "$meld_has_output_option" = true ||
		test "$meld_has_output_option" = false
	then
		...
	fi

Instead of two checks, would it be better to instead just check:
	if test -n "$meld_has_output_option"
?
git config --bool will only ever produce true/false, so we really only
need to check that it's a non-empty value, perhaps?


> +			case "$meld_help_msg" in
> +				*"--output="* | *"[OPTION"???"]"*)
> +					# old ones mention --output and new ones just say OPTION...
> +					meld_has_output_option=true ;;
> +				*)
> +					meld_has_output_option=false ;;
> +			esac

We typically avoid the extra indentation level for the case labels.
eg. this would be written like this (with ";;" on its own line):

	case "$meld_help_msg" in
	*--output=*|*"[OPTION"???"]"*)
		# old ones mention --output and new ones just say OPTION...
		meld_has_output_option=true
		;;
	*)
		meld_has_output_option=false
		;;
	esac


Also, if you're matching [OPTION ...] would it work to just use
a single-quoted value in the case label?  eg: *'[OPTION...]'* ?


> +	if test -z "${meld_has_auto_merge_option:+set}"
>  	then
> -		: old ones mention --output and new ones just say OPTION...
> -		meld_has_output_option=true
> -	else
> -		meld_has_output_option=false
> +		meld_has_auto_merge_option=$(git config mergetool.meld.hasAutoMerge)
> +		if test "$meld_has_auto_merge_option" = auto
> +		then
> +			# testing the "--auto-merge" option only if config is "auto"
> +			if test -z "$meld_help_msg"
> +			then
> +					meld_help_msg="$(get_meld_help_msg)"

This can just be:

	meld_help_msg=$(get_meld_help_msg)

and can do without the surrounding " " double quotes.



> +			case "$meld_help_msg" in
> +				*"--auto-merge"*)
> +					: old ones mention --output and new ones just say OPTION...
> +					meld_has_auto_merge_option=true ;;
> +				*)
> +					meld_has_auto_merge_option=false ;;
> +			esac

As above -- unindent the case statements, and put the ";;" case
statement terminators on their own line.

cheers,
-- 
David
