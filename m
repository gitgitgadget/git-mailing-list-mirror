Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232CC433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E03204EC
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSOpuzV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgGGPb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgGGPb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 11:31:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD039C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 08:31:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so18676764pjc.4
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+uiDY6vErWx5pxstQmpdgHXRhP+uxnn+5WZrSX6SRiQ=;
        b=tSOpuzV2SMzkhGUKlZwkVO9gD0cTf2ZEWB+bal+VUMwurjvHmFWjxv+0lE30iXQS9A
         mafweaWme5yWYYVYfF8P+Y70BJtRDBkabHZOG7gCqA+PoLvXLNGgKclPB0eQEEIAes47
         gIM6s1Um+fumewLnJJqGlErxuebrKICdPaWDVmliIJeYUdck+KPeLVyK/+M8bZgqOAMh
         9uPPl0J0ecgLInuRfXSuy2OQuWOLg37csJQxMNGOHDphD+hclZcbeNHg0ZAj9y1ci3OX
         Vlu5z1zmAK6bMt/etG9VsojRByF73DjVWZujGYNyygYXeOKiOQzG1iXBGwXp2psZRH4K
         Bbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+uiDY6vErWx5pxstQmpdgHXRhP+uxnn+5WZrSX6SRiQ=;
        b=ClZOLs5lNp7eG2ZWsCi7iqh3Gm7/WdmMncSC/Eu3z85Ek68W37h5Mc28cE+eQ/34hO
         b+M7Dm+x31yBE9nYvlgxHEnFZc6mVCPj80TP6EvACOc7tOiPrHF9u1ipUouFogBR3tfq
         zsFmcj12ef5+KN6mQuDrSqIEIBODUCLe6PH0KBppjPNOEYee3whurTBcaBd4N2BAB5K3
         uF6GyqFmjuW3tYHCYNJpCZr6EN5mNG4bY8HgEO2NV7zaEg6HO74zv/eqou3L5+HLP7Ym
         c9T6UG39SPhaMIQcYQjITcAzhk7DXufeYW8qFCSvK1bCzmuF3f12bK6GPiG/W/rv/ktI
         Qn3g==
X-Gm-Message-State: AOAM533iiESWZyEOxChU43MLhai2scIhpnlb0IKTZpGQ6K5oxB/wy+IW
        xArLGGi4Cv+1RK8+zGBdrH8=
X-Google-Smtp-Source: ABdhPJy9zoeXNJPDlyhDq+v5a1LGiAdkWhuifO4zxzvTnZmz+tOx3VOP0K5Ovxu3uy4HF+MJCFj61A==
X-Received: by 2002:a17:90a:ad8e:: with SMTP id s14mr5214358pjq.36.1594135918351;
        Tue, 07 Jul 2020 08:31:58 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id p10sm1320332pgn.6.2020.07.07.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:31:57 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:31:55 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v11] Support auto-merge for meld to follow the vim-diff
 behavior
Message-ID: <20200707153155.GC7003@danh.dev>
References: <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com>
 <pull.781.v11.git.git.1594106024078.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.781.v11.git.git.1594106024078.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-07 07:13:43+0000, sunlin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> -# Check whether we should use 'meld --output <file>'
> -check_meld_for_output_version () {
> -	meld_path="$(git config mergetool.meld.path)"
> -	meld_path="${meld_path:-meld}"
> +# Get meld help message
> +init_meld_help_msg () {
> +	if test -z "$meld_help_msg"
> +	then
> +		meld_path="$(git config mergetool.meld.path || echo meld)"
> +		meld_help_msg=$($meld_path --help 2>&1)

I haven't thought about this until now.
`$meld_path` should be quoted.

	meld_help_msg="$("$meld_path" --help 2>&1)"

Either that or our Windows friends will complain soon:

	C:/Program Files/Meld/meld --help

(I don't know where meld will be installed by default in Window exactly,
above command is just a guess)

> +	fi
> +}
>  
> -	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +# Check the features and set flags
> +check_meld_for_features () {
> +	# Check whether we should use 'meld --output <file>'
> +	if test -z "$meld_has_output_option"
>  	then
> -		: use configured value
> -	elif "$meld_path" --help 2>&1 |
> -		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
> +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +		case "$meld_has_output_option" in
> +		true|false)
> +			: use configured value
> +			;;
> +		*)
> +			: empty or invalid configured value, detecting "--output" automatically
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--output="* | *'[OPTION...]'*)
> +				# All version that has [OPTION...] supports --output

Good comments :)

> +				meld_has_output_option=true
> +				;;
> +			*)
> +				meld_has_output_option=false
> +				;;
> +			esac
> +			;;
> +		esac
> +	fi
> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "$meld_use_auto_merge_option"
>  	then
> -		: old ones mention --output and new ones just say OPTION...
> -		meld_has_output_option=true
> -	else
> -		meld_has_output_option=false
> +		if meld_use_auto_merge_option=$( \
> +			git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
> +		then
> +			: use configured value
> +		else
> +			meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
> +			if test "$meld_use_auto_merge_option" = "auto"
> +			then
> +				# testing the "--auto-merge" option only if config is "auto"
> +				init_meld_help_msg
> +
> +				case "$meld_help_msg" in
> +				*"--auto-merge"* | *'[OPTION...]'*)
> +					meld_use_auto_merge_option=true
> +					;;
> +				*)
> +					meld_use_auto_merge_option=false
> +					;;
> +				esac
> +			else
> +				meld_use_auto_merge_option=false

If I read other emails correctly (which I usually don't),
I think we would want to bail out in this case.

> +			fi
> +		fi
>  	fi
>  }
> 
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
> -- 
> gitgitgadget

-- 
Danh
