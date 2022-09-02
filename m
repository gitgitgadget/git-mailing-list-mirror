Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044FDC54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 06:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiIBGrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiIBGre (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 02:47:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD23BC82C
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 23:47:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s7so1073645wro.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 23:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=UHubGs2+59MMPfWeghzQgNPHTZ5F4ViTEqdYNdJMCuI=;
        b=VQhvVXd2PwHA9U3TOJ2BxQcftvtmhyDK56HZ+Guad3GvhyJe3lw+Egj/g/g2itchWC
         nGw7NYVHFUcqhg3Bm1Dmt8SL6qyq8sxip/uE615C91n9o74npUd1URXaB3pJm0RPkCrv
         K3fwh0gW80sm3/MRltm50V0mLY2tZ9cWKT0FnZVhA+OgRusc2STvKBhxDkoJPwnNabzO
         9mrMcnOt/UZmbRNp5ZbaU/XxMy6/6tOR5Gd9zP4bDVuTe2fwMWzkb7F1lP1qPeasGKf0
         JMA7P2eR1htWeQo1oh4DJp0LCQ2xB59YUzSAmU51xRRZZX8YtsjVLlk6ZUwk7S1eAiB7
         pywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UHubGs2+59MMPfWeghzQgNPHTZ5F4ViTEqdYNdJMCuI=;
        b=V+GultiUaYmc3Ck4f8Hzm6njW2o93HksYFN8RObMC48UlSEuu3wMjxZHGIVDRtwNvH
         gX9ZP0fHOSoecKSwUyMQxFyrATFf/cLcmeRUW8pBSRcp12XjXLR3p3bYZN7Zm1BVQlnI
         /OkMfOROYkCMFOoXoZEq/ckwMde8lbkMP1OdG5a6X+Gz0tg79vD9PVFU5tnA/9d1mERE
         PF5fm+w9+d7Zsi9tMfDJmj1EGbRRVvBgfyqmgqsSpgbRtjm1kNO8FZ6XZBehDfzPp4cn
         /PDV80UBsfJONBX/7U6LnTyCTmx893fH55KbxezWqgVrWWlzBG7CKFR0JNu1V0B8y+H1
         of5Q==
X-Gm-Message-State: ACgBeo3p7q+uI6+J5j2ZigURJy1bLBdTp1/npvw2Fpv/9G5U9R7oaxAC
        UjB0B+T603WExgrLacwAp9g=
X-Google-Smtp-Source: AA6agR5MTZXJLwo29zvIFY1Gshr5eIVQ2CTS/B+yanQGUBfZhekf6Gm8K3nt16s7L0HaJtKXafWjZA==
X-Received: by 2002:a5d:4707:0:b0:226:f89a:ca3e with SMTP id y7-20020a5d4707000000b00226f89aca3emr3361388wrq.454.1662101250812;
        Thu, 01 Sep 2022 23:47:30 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id p28-20020a05600c1d9c00b003a5b788993csm1170345wms.42.2022.09.01.23.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 23:47:30 -0700 (PDT)
Date:   Fri, 2 Sep 2022 08:47:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, ingy@ingy.net
Subject: Re: [PATCH] rev-parse: Detect missing opt-spec
Message-ID: <20220902064727.GA3606@szeder.dev>
References: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
 <20220902050621.94381-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902050621.94381-1-oystwa@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2022 at 07:06:21AM +0200, Øystein Walle wrote:
> If a line in parseopts's input starts with one of the flag characters it
> is erroneously parsed as a opt-spec where the short name of the option
> is the flag character itself and the long name is after the end of the
> string. This makes Git want to allocate SIZE_MAX bytes of memory at this
> line:
> 
>     o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> 
> Since s and sb.buf are equal the second argument is -2 (except unsigned)
> and xmemdupz allocates len + 1 bytes, ie. -1 meaning SIZE_MAX.

I suspect (but didn't actually check) that this bug was added in
2d893dff4c (rev-parse --parseopt: allow [*=?!] in argument hints,
2015-07-14).

> Avoid this by checking whether a flag character was found in the zeroth
> position.
> 
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
>  builtin/rev-parse.c           | 3 +++
>  t/t1502-rev-parse-parseopt.sh | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index b259d8990a..04958cf9a9 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -479,6 +479,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>  		if (!s)
>  			s = help;
>  
> +		if (s == sb.buf)
> +			die(_("Missing opt-spec before option flags"));
> +
>  		if (s - sb.buf == 1) /* short option only */
>  			o->short_name = *sb.buf;
>  		else if (sb.buf[1] != ',') /* long option only */
> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
> index 284fe18e72..15bc240027 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -306,6 +306,13 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'test --parseopt invalid opt-spec' '
> +	test_write_lines x -- "=, x" >spec &&
> +	echo "fatal: Missing opt-spec before option flags" >expect &&
> +	test_must_fail git rev-parse --parseopt -- >out <spec >actual 2>&1 &&

When checking an error message please don't look for it on standard
output; i.e. the redirection at the end should be '2>actual', or
perheps even better '2>err'.

> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'test --parseopt help output: multi-line blurb after empty line' '
>  	sed -e "s/^|//" >spec <<-\EOF &&
>  	|cmd [--some-option]
> @@ -337,3 +344,5 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
>  '
>  
>  test_done
> +
> +test_done
> -- 
> 2.34.1
> 
