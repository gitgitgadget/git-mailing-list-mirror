Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF1C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825E32082E
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSq3L9xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0NJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:09:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36499 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgC0NJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 09:09:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id l23so9617952otf.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qt46VzMRpo5A0sphuWZ8sMXidTmZJUNwxUgtVNg5NRU=;
        b=JSq3L9xlqQ2q54W/GNPqkSdhzflvKZOI3+jQHVOREr3ezLRRBLer0hnmGAuk9HaT4P
         kcxys2zKXhWh79oMax0IHghHs2TRbSWVCRfJ1zshlqcupEzurpZ1Mlc73wTIyF9BjugB
         V0jo8Z5ZTUUtQ6FJnD8lYgHyTunU93evoBuIgWDwfNUvjUxHIewR1CNHEpMRmNI099Xr
         IgN93ZhsoTfI85tcFRwdftIej9ktKOyiiJjmlZ4om+YoDhPRqLr0eFl77GbbjnRZXUzH
         J+PZ0EyHj5iOL5ew9JJ51WqMYic90DJZcJcsnHGGEV/iaD/C9ZgdFGWl4aXLy3y5oMXz
         f/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qt46VzMRpo5A0sphuWZ8sMXidTmZJUNwxUgtVNg5NRU=;
        b=OR0+xeWk28WNeRHOYXuPbzlw/WKqZJ6V4LkmqN9QPdlHrT2XUMZPbpaJkkRPp+XIUB
         gEC7pSIunLDK12k7X9GFJd2jKn8zjLvzQtIbrKQMIa32VPxwc/usn1oGlUTGNHoyvrei
         IqRIy7ImLVvSGw8pj2NF5ErAJdzP6kPmVwWFI4V6oBzQ9am5mYgZN6CEtwYAWJRKNvc8
         VRVVbwxxQD6jo6ThqmH7OB0yB1dgyoCGgHi2nPxY4qkqaL6XUFolVpzuv1ohuUb/TGuJ
         2n6hNU8sdHRkQnD30LyIPCP06wFL1My/VONjGXixdwNi1BwWVZtbKC1GAIFlu4qgS9fd
         Huuw==
X-Gm-Message-State: ANhLgQ2Gh1V/2ixIlPH9GOl3itVsKOpbrQDzMG0bAo62zaS03lIwzxDg
        2fJsUJDI91YI3cit1x0f2m4=
X-Google-Smtp-Source: ADFU+vvIVJL6bmrxeCi5Kvr9RYgzaXWBYJDe00Hx5XBpkTFbBfFgdT8LNXW/9taCuZ4hqq9LAwvNXA==
X-Received: by 2002:a4a:b91a:: with SMTP id x26mr9191208ooo.2.1585314563427;
        Fri, 27 Mar 2020 06:09:23 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j20sm1658272oie.17.2020.03.27.06.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 06:09:22 -0700 (PDT)
Subject: Re: [PATCH v4 1/7] t7063: more thorough status checking
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
 <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
 <752403e339bae098104f41c541c2b0e684586c1f.1585258061.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ffec2a50-e746-370c-1957-3615950bb6fb@gmail.com>
Date:   Fri, 27 Mar 2020 09:09:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <752403e339bae098104f41c541c2b0e684586c1f.1585258061.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2020 5:27 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> It turns out the t7063 has some testcases that even without using the
> untracked cache cover situations that nothing else in the testsuite
> handles.  Checking the results of
>   git status --porcelain
> both with and without the untracked cache, and comparing both against
> our expected results helped uncover a critical bug in some dir.c
> restructuring.
> 
> Unfortunately, it's not easy to run status and tell it to ignore the
> untracked cache; the only knob we have it to instruct it to *delete*
> (and ignore) the untracked cache.
> 
> Create a simple helper that will create a clone of the index that is
> missing the untracked cache bits, and use it to compare that the results
> with the untracked cache match the results we get without the untracked
> cache.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7063-status-untracked-cache.sh | 52 +++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index 190ae149cf3..156d06c34e8 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -30,6 +30,30 @@ status_is_clean() {
>  	test_must_be_empty ../status.actual
>  }
>  
> +# Ignore_Untracked_Cache, abbreviated to 3 letters because then people can
> +# compare commands side-by-side, e.g.
> +#    iuc status --porcelain >expect &&
> +#    git status --porcelain >actual &&
> +#    test_cmp expect actual
> +iuc() {
> +	git ls-files -s >../current-index-entries
> +	git ls-files -t | grep ^S | sed -e s/^S.// >../current-sparse-entries
> +
> +	GIT_INDEX_FILE=.git/tmp_index
> +	export GIT_INDEX_FILE
> +	git update-index --index-info <../current-index-entries
> +	git update-index --skip-worktree $(cat ../current-sparse-entries)
> +
> +	git -c core.untrackedCache=false "$@"
> +	ret=$?
> +
> +	rm ../current-index-entries
> +	rm $GIT_INDEX_FILE
> +	unset GIT_INDEX_FILE
> +
> +	return $ret
> +}

This is a clever way to get around the untracked cache deletion.

Thanks for adding these extra comparisons! It really does help guarantee
that we are doing the right thing in each case.

-Stolee

