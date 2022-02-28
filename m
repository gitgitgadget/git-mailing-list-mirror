Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B581DC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 05:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiB1FeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 00:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiB1FeE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 00:34:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD641F82
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 21:33:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s14so15979612edw.0
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 21:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xE63rorayhzGY2LHpJrb+inwYGWNLyNS2786iOIZ9Z4=;
        b=Gg1/g+DAVB7pqPSFaPveMO4qX4IqK1xadqTz4GEEzt7G0b94Cl1RNpGGnEZayiIFfO
         vUU0Q7/LfqhppZomUyiSo4RHIUGxbm+Zztl8rnftO/33aeAupeXSf2EsxfpmHhs2+eHu
         JnnLVF1rKmTntUbv7NZLYsLgE44mFO9PCC9CxudwSS//KGIHEfsknnupfyQYrD1lJHL9
         IAQjZtHq4qWx0caEsmkDXV9xvdH5s3mZjCR13LtqrffImFKtr2TaV+Oqlhl5pdXssXlE
         kSBDxM/wXgEfUnsoHNcN8hvt0dEDhCMbDq9OR/RAj+Zwlp3GxpDCxPr35WeT3It2h9l9
         7wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xE63rorayhzGY2LHpJrb+inwYGWNLyNS2786iOIZ9Z4=;
        b=3mxmIPmix3ttiBsE/pN1+3r5pbD0aDj4RGT5Uheyr9XScxFvoMe6Nz0HvKk3bhcESU
         FKabIjk8hRDP2HZEGmQcM87ioGXpSOLJFsGf18b1uAfN33unO27RCAWFiYUZlQsnv0VY
         M4jWX40Gfqt5g8nh68fmoZ5t4C8zbIrHNUYMx7KZwB2Ok7UEX7pWs8G/LCa6D3hkfKmV
         3PvjfL61uavADSTF9VDRyx2g70V/LUVDa6iHPiMERfo6HoAqrXU69umSUIuSn4y0nIgp
         CeCWniCNMstm9ya6/kSQLM7fcJxLf725hb2nb8On8+3Tgj6jQDRDXKXPRkpx3yOay8rX
         wgHQ==
X-Gm-Message-State: AOAM530rU9C666fIAGbJ1Us5ASKkLXqrReWNCJRfT14s+bvBqOC1y1KB
        WmvH5Yxg3kEOI0v7Wv5mCYw=
X-Google-Smtp-Source: ABdhPJxcsCpB2HxYx/peWVqRJkqNW0kOHcM9blRIVCckWQX5SiKDgnJ8UUOWwsbYa5MP00DuDBqsJw==
X-Received: by 2002:a05:6402:90b:b0:412:a7cc:f5f9 with SMTP id g11-20020a056402090b00b00412a7ccf5f9mr17487294edz.136.1646026401392;
        Sun, 27 Feb 2022 21:33:21 -0800 (PST)
Received: from gmail.com (91.141.32.73.wireless.dyn.drei.com. [91.141.32.73])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm4003609ejc.62.2022.02.27.21.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 21:33:20 -0800 (PST)
Date:   Mon, 28 Feb 2022 06:33:15 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] rerere-train: two fixes to the use of "git show -s"
Message-ID: <20220228053315.czkke7hfiav4qh3s@gmail.com>
References: <xmqqsfsjuw8m.fsf@gitster.g>
 <20220227220924.2144325-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227220924.2144325-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 27, 2022 at 02:09:24PM -0800, Junio C Hamano wrote:
> The script uses "git show -s" to display the title of the merge
> commit being studied, without explicitly disabling the pager, which
> is not a safe thing to do in a script.
> 
> For example, when the pager is set to "less" with "-SF" options (-S
> tells the pager not to fold lines but allow horizontal scrolling to
> show the overly long lines, -F tells the pager not to wait if the
> output in its entirety is shown on a single page), and the title of
> the merge commit is longer than the width of the terminal, the pager
> will wait until the end-user tells it to quit after showing the
> single line.
> 
> Explicitly disable the pager with this "git show" invocation to fix
> this.
> 
> The command uses the "--pretty=format:..." format, which adds LF in
> between each pair of commits it outputs, which means that the label
> for the merge being learned from will be followed by the next
> message on the same line.  "--pretty=tformat:..." is what we should
> instead, which adds LF after each commit, or a more modern way to
> spell it, i.e. "--format=...".  This existing breakage becomes
> easier to see, now we no longer use the pager.

Sounds good (definitely better than two separate commits).

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Relative to the initial version, the "--no-merges" change has

it was "--merges", not "--no-merges"

>    been removed because the end user can still give --merges from
>    the command line and the filtering of merges done by the script
>    is still needed for correctness.

You probably mean that the user can pass "--no-merges HEAD"
but that would just make the effective command

	git rev-list --merges --no-merges HEAD

which outputs nothing. I don't think `git rev-list --merges "$@"` will
ever output non-merge commits, so the filtering should not be necessary.

> 
>  contrib/rerere-train.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
> index 75125d6ae0..26b724c8c6 100755
> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -86,7 +86,7 @@ do
>  	fi
>  	if test -s "$GIT_DIR/MERGE_RR"
>  	then
> -		git show -s --pretty=format:"Learning from %h %s" "$commit"
> +		git --no-pager show -s --format="Learning from %h %s" "$commit"
>  		git rerere
>  		git checkout -q $commit -- .
>  		git rerere
> -- 
> 2.35.1-354-g715d08a9e5
> 
