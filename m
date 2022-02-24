Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD4C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiBXJGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiBXJGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:06:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82646189AA6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:05:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vz16so2982055ejb.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZxHr4CFtMpq3MLCewaOkzaWLkHMdx1V30yRngdu0PAI=;
        b=S9KAjqRxg1GByP7WIqJWxiDXHa1P0naWQltRZ9JQj6On1yuvUy9S8lB8p51ApC8Ye4
         C5Vxd3TdJ/V0z8pG6z+uTuRw7XfDjrilwdxXg9ARoHWTith3kHGf/LcHNJNRvq2Khy3L
         E4TGfNBbC5J1nQs8fjWwYZWLjhdiwYuJrCJTS2UvtmDYsdTW76GPg4vPpfaoZcGyXYUI
         6K+eXK2YYM9ThGpBXzPd2l4/FuaXqA9NyB39XDK+KwqDUNrYmxvhciGEpQr/7BptvvPx
         WkGoBnX5iU1hHaqhi2qSjnF05yg2a/gjtZamOmKttx7+G0WuaxLuqDbbph22nvpD/6u1
         ifkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZxHr4CFtMpq3MLCewaOkzaWLkHMdx1V30yRngdu0PAI=;
        b=1iDfFrlwxFSTtDUHHpVnOfyThweQNNFHdrodztQZQsGum0XddLRFqoaxQUxKXw4qSV
         S+xyBBAmiOOoDNdmax0qW8+gcV4K5szAvbBS8OU1ameZ8RjJBszCG+45lqaPFW7Q+T0C
         NCR64EJmw8fCxhedI8AUM6+yu2q0BfRjXJNZmFnpn1F86wc5SMCk6bP6RkcEmWydHrXL
         btX0m3HYZz243U0WpxhWBCzPi+lXH0gFpekz0iK1QDm7d/rCVj2pirSQL55ITHtw+7PG
         w6EatmlBbd5kG94DxGMd2mlGFwiKxYAgjIThcdFAC+YEF7vh44UQfYdHqW1lNWLR73lG
         LzOA==
X-Gm-Message-State: AOAM530MWUA2QnEYcsziS+Xc86Auiqjyl9a7IAukTFY6bosOXEPFAPr8
        r+EY1A+3m3zX02H5ZUOoF0pBv+Wc974=
X-Google-Smtp-Source: ABdhPJwUh+JetE+BT+MZcCVXeDocEuDd2h0517iX8wjUvG2aFPX5YEnMlSmsKopH/5Kk7q2dO1oduA==
X-Received: by 2002:a17:906:1e91:b0:6ae:99d9:93b1 with SMTP id e17-20020a1709061e9100b006ae99d993b1mr1420539ejj.111.1645693539837;
        Thu, 24 Feb 2022 01:05:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l19sm1015273edb.87.2022.02.24.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:05:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNA4A-000Cpi-HM;
        Thu, 24 Feb 2022 10:05:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH 2/2] t0030-t0050: avoid pipes with Git on LHS
Date:   Thu, 24 Feb 2022 09:59:45 +0100
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <20220224054720.23996-3-shivam828787@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220224054720.23996-3-shivam828787@gmail.com>
Message-ID: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Shubham Mishra wrote:

> Pipes ignore error codes of LHS command and thus we should not use
> them with Git in tests. As an alternative, use a 'tmp' file to write
> the Git output so we can test the exit code.
>
> Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
> ---
>  t/t0030-stripspace.sh | 81 ++++++++++++++++++++++++++++---------------
>  t/t0050-filesystem.sh |  3 +-
>  2 files changed, 56 insertions(+), 28 deletions(-)
>
> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index ae1ca380c1..4d0af9bf98 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -225,32 +225,48 @@ test_expect_success \
>  
>  test_expect_success \
>      'text without newline at end should end with newline' '
> -    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
> +    printf "$ttt" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$ttt" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$ttt$ttt" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$ttt$ttt$ttt" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0
>  '

You're modifying some tests here that are using some old coding style,
so maybe it's better to adjust it while we're at it?

Also I think this would be a lot nicer with test_stdout_line_count and a
helper to deal with that pritnf, e.g.:
	
	diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
	index ae1ca380c1a..d48a3579511 100755
	--- a/t/t0030-stripspace.sh
	+++ b/t/t0030-stripspace.sh
	@@ -223,12 +223,15 @@ test_expect_success \
	     test_cmp expect actual
	 '
	 
	-test_expect_success \
	-    'text without newline at end should end with newline' '
	-    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
	-    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
	-    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
	-    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
	+printf_git_stripspace () {
	+	printf "$1" | git stripspace
	+}
	+
	+test_expect_success 'text without newline at end should end with newline' '
	+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt" &&
	+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt" &&
	+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt" &&
	+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$ttt"
	 '
	 
	 # text plus spaces at the end:

>  # text plus spaces at the end:
>  
>  test_expect_success \
>      'text plus spaces without newline at end should end with newline' '
> -    test $(printf "$ttt$sss" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
> -    test $(printf "$ttt$sss$sss$sss" | git stripspace | wc -l) -gt 0
> +    printf "$ttt$sss" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$ttt$sss" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$sss$sss" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0 &&
> +    printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
> +    test $(wc -l <tmp) -gt 0
>  '

ditto.

>  test_expect_success \
>      'text plus spaces without newline at end should not show spaces' '
> -    ! (printf "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
> +    printf "$ttt$sss" | git stripspace >tmp &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    printf "$ttt$ttt$sss" | git stripspace &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    printf "$ttt$ttt$ttt$sss" | git stripspace &&
> +    ! (grep "  " tmp >/dev/nul) &&
> +    printf "$ttt$sss$sss" | git stripspace &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    printf "$ttt$ttt$sss$sss" | git stripspace &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    printf "$ttt$sss$sss$sss" | git stripspace &&
> +    ! (grep "  " tmp >/dev/null)
>  '

This is not on you, but generally we don't pipe "grep" to >/dev/null,
and just let the --verbose option do its work.

With/without that change you no longer need the () subshell here.

>  test_expect_success \
> @@ -282,12 +298,18 @@ test_expect_success \
>  
>  test_expect_success \
>      'text plus spaces at end should not show spaces' '
> -    ! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
> +    echo "$ttt$sss" | git stripspace >tmp &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    echo "$ttt$ttt$sss" | git stripspace >tmp &&
> +    ! (grep "  " tmp>/dev/null) &&
> +    echo "$ttt$ttt$ttt$sss" &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    echo "$ttt$sss$sss" | git stripspace >tmp &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
> +    ! (grep "  " tmp >/dev/null) &&
> +    echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
> +    ! (grep "  " tmp >/dev/null)
>  '
>  
>  test_expect_success \
> @@ -339,11 +361,16 @@ test_expect_success \
>  
>  test_expect_success \
>      'spaces without newline at end should not show spaces' '
> -    ! (printf "" | git stripspace | grep " " >/dev/null) &&
> -    ! (printf "$sss" | git stripspace | grep " " >/dev/null) &&
> -    ! (printf "$sss$sss" | git stripspace | grep " " >/dev/null) &&
> -    ! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
> -    ! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
> +    printf "" | git stripspace >tmp &&
> +    ! ( grep " " tmp >/dev/null) &&
> +    printf "$sss" | git stripspace >tmp &&
> +    ! ( grep " " tmp >/dev/null) &&
> +    printf "$sss$sss" | git stripspace >tmp &&
> +    ! (grep " " tmp >/dev/null) &&
> +    printf "$sss$sss$sss" | git stripspace >tmp &&
> +    ! (grep " " tmp >/dev/null) &&
> +    printf "$sss$sss$sss$sss" | git stripspace >tmp &&
> +    ! (grep " " tmp >/dev/null)
>  '

ditto for these.

>  test_expect_success \
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index afc343cf9b..5c9dc90d0b 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -104,7 +104,8 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
>  	rm camelcase &&
>  	echo 1 >CamelCase &&
>  	git add CamelCase &&
> -	camel=$(git ls-files | grep -i camelcase) &&
> +	git ls-files >tmp &&
> +	camel=$(grep -i camelcase tmp) &&
>  	test $(echo "$camel" | wc -l) = 1 &&
>  	test "z$(git cat-file blob :$camel)" = z1
>  '

