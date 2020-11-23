Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE9C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A2206D8
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AINB0v0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbgKWWoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbgKWWoD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:44:03 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A768DC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:44:02 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so9618639plt.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzGR7mQunS9chsi+r4Uz7BwxCo3hNdgS6X5ZadLoJsQ=;
        b=AINB0v0V8BoTFMzKR3SDWNRDRlA74o4tRvX1s6DLLj4lH6sZO24tTUq7ZeZadEOPXr
         6VlpYV3BKFNAJGbPCc1q5lJmcCPWyUEp1ErLLBWPWSu0xAC1JrHaWpQxzyEwb9fKrrmj
         E3lbJJOmRXcUCyBs6nblLMhyad4RxKi1DlwCgOrnqehwamM+xiPwH1IVbfM6aseiUStk
         +9en8ZErz3qi2zNB0pVO5XOxbTA08mwBq60l55Hu7x6TSulcvXIjkCBiOXU6s5pUN4nX
         vpLxv6a15cXMGrXVSSOrZy38IMzDyHFaMsdUwRdavkdDQ7gTPjBb0pGErLQcO2OYrzz4
         Kwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzGR7mQunS9chsi+r4Uz7BwxCo3hNdgS6X5ZadLoJsQ=;
        b=BlyBnWGIjTECipNsL243Fn4KCyTsJhGVTZ/zgarBTZXtwMnK3RlBd+XuB+gvRP50jX
         9XcFh+AHWpMV3zny9NhoZEVjQppPzBNstea82QpHs9FBb1rvmYaM6tFdOS6aD4AdVpGq
         9nEidy/KgHxhNDj4zZs8SJdq6M3CAKHKGeZt4aj3q7guzpMHkAzyXcdKwUca+kUgo4aw
         mBrE0Y43P8lybms9h7vBR9vJlIZeqSLaB+3Xlfb5jaij/KvLLVguUjKNdHDG0M2sdSzQ
         015KZesqY0Wx+2aQZ/A+PF5ofZxxc7oLh4nYcdJ3M0OsSHReLTlZwSGsjkookGwzdy8W
         OfuQ==
X-Gm-Message-State: AOAM531FIRTBz3pirAEVolkdtRJFeI8GJSZQdan1bLSA6uJs0n2QROIx
        j7fG9yJb32y91Yew2q1HoEwQkQ==
X-Google-Smtp-Source: ABdhPJw+im6GVkMKaQJ4hFYH08zG/GS2fooSCCJYc8Ht0ofQeoIag6PTRer6dKQtRU5oPAChXI55Mw==
X-Received: by 2002:a17:902:6ac1:b029:da:1ac0:fcd4 with SMTP id i1-20020a1709026ac1b02900da1ac0fcd4mr318837plt.19.1606171442082;
        Mon, 23 Nov 2020 14:44:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id j143sm9019928pfd.20.2020.11.23.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:44:01 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:43:57 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/7] config: implement --fixed-value with --get*
Message-ID: <20201123224357.GF499823@google.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <8e0111c7b4b2c766c61df30c4ae93bd2d724de06.1606147507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0111c7b4b2c766c61df30c4ae93bd2d724de06.1606147507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:05:06PM +0000, Derrick Stolee via GitGitGadget wrote:
> 

Allowing myself a sensible chuckle at the commit subject using glob
syntax on a series about regex matching. ;)

> 
> The config builtin does its own regex matching of values for the --get,
> --get-all, and --get-regexp modes. Plumb the existing 'flags' parameter
> to the get_value() method so we can initialize the value_regex argument
> as a fixed string instead of a regex pattern.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/config.c  | 15 ++++++++++-----
>  t/t1300-config.sh | 22 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index 3e49e04411..d3772b5efe 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
>  	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
>  		return 0;
> +	if (fixed_value && strcmp(value_regex, (value_?value_:"")))
> +		return 0;
Ooh, I can see you're matching style, but the combination of the
spaceless ternary and the trailing underscore is making me so itchy ;)

>  	if (regexp != NULL &&
>  	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
>  		return 0;
> @@ -298,7 +301,7 @@ static int collect_config(const char *key_, const char *value_, void *cb)
>  	return format_config(&values->items[values->nr++], key_, value_);
>  }
>  
> -static int get_value(const char *key_, const char *regex_)
> +static int get_value(const char *key_, const char *regex_, int flags)
Very reasonable, and I appreciate passing 'flags' instead of passing
'fixed' here. Room for growth :)

[snip] a bunch of straightforward plumbing-through.

> +test_expect_success '--get and --get-all with --fixed-value' '
> +	GLOB="a+b*c?d[e]f.g" &&
> +	rm -f config &&
Again this tells me that your other tests want 'test_when_finished'
instead.

> +	git config --file=config fixed.test bogus &&
> +	git config --file=config --add fixed.test "$GLOB" &&
> +
> +	git config --file=config --get fixed.test bogus &&
> +	test_must_fail git config --file=config --get fixed.test "$GLOB" &&
> +	git config --file=config --get --fixed-value fixed.test "$GLOB" &&
> +	test_must_fail git config --file=config --get --fixed-value fixed.test non-existent &&
> +
> +	git config --file=config --get-all fixed.test bogus &&
> +	test_must_fail git config --file=config --get-all fixed.test "$GLOB" &&
> +	git config --file=config --get-all --fixed-value fixed.test "$GLOB" &&
> +	test_must_fail git config --file=config --get-all --fixed-value fixed.test non-existent &&
> +
> +	git config --file=config --get-regexp fixed+ bogus &&
> +	test_must_fail git config --file=config --get-regexp fixed+ "$GLOB" &&
> +	git config --file=config --get-regexp --fixed-value fixed+ "$GLOB" &&
> +	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
> +'

Otherwise the test seems fine to me, although I wouldn't yell if it grew
some comments :)

With the exception of the 'test_when_finished', which might not even
match style (I didn't look):

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
