Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50E6C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9143B64FB3
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhCLIaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 03:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhCLIaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 03:30:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206DAC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:30:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id bx7so6739300edb.12
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7UYBRaBempeDAQTMSRKCPrwWIkAj/ajqfyebqtld/0g=;
        b=cKJVookyh1MHIaVJgvcN7cyLZgY6YKKJrMoffk4FqA5LvQq0Q+eshtTqqmYCuoPP6F
         IJSMZx41PXaLyR7n5ZmJVwx+ekjSbShuWFIsnxMYYK0wVc06BhqfBnEJwGo4evJ61G1g
         fxsEufccjK4KYalOtzFaRe2nH5OTWeLMJGOUyzb/YesFuo0vpnwOX2RfpUL5COIccfkd
         2o3SrGw0OIzj6Jm5ZQH1ffOKsRVzFV7ESJiSjDE4lCQOSyufDLSZZNIDrsGsJ3BLRruB
         U4OEhDSGeMgq8uQZY2+Bar+IMxmJ81IUdpmZQsGkSQpGGjK6HhLK9bunE90joUM2DMF4
         Zw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7UYBRaBempeDAQTMSRKCPrwWIkAj/ajqfyebqtld/0g=;
        b=mnyAVhrRAZB++U57qXMvMrTVLYTruXIcsnfL528I4nXrurDXeDU4ekqc0YyyiNt4Uu
         7GBLslU+laSVnvDmBLxrRynFsGTUjOfJDZ2leq9fLPLMYY0c4GiJSBbC6dnLwk7gjT0V
         sMG1RHvtZPolfqRauBzeg3sda5yU0DwZJeK7rKgW4XLc45DH3sL8Ac6jOWE2lRoIcIho
         NnuYIXy0XcjxGn3rv7joZN7igFi7DkmTwnHNI/YW5TMYGYPBJiSGCEDs946bs5fX0LMx
         22Ds6UTrK64SLJCv6Ll1wN0qc8oJK0JOfH/fsq3tk1a787vpesNm5lgvfRGKRNLJcLy1
         FjLg==
X-Gm-Message-State: AOAM531OI8WQTkSdcmZfHIIsd3zlnFhBRJOcJKbcVSRN/AMiivC4sZ8z
        NRbEQ3akGO09BdxIgVgzw3vu7LQjya4Kaw==
X-Google-Smtp-Source: ABdhPJzff/+AYXDBZjotbtNjHOCX/uaEEqGr8Woupv+mW/JX6AQ0Pb8nSdnMlxkEnIv3Pk18qA0IqQ==
X-Received: by 2002:a05:6402:b41:: with SMTP id bx1mr13052932edb.69.1615537805670;
        Fri, 12 Mar 2021 00:30:05 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q20sm2410797ejs.41.2021.03.12.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:30:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 04/37] hook: include hookdir hook in list
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-5-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-5-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 09:30:04 +0100
Message-ID: <87lfashj03.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> Historically, hooks are declared by placing an executable into
> $GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
> from the config are more featureful than hooks placed in the $HOOKDIR,
> those hooks should not stop working for users who already have them.
> Let's list them to the user, but instead of displaying a config scope
> (e.g. "global: blah") we can prefix them with "hookdir:".
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>
> Notes:
>     Since v7, fix some nits from Jonathan Tan. The largest is to move reference to
>     "hookdir annotation" from this commit to the next one which introduces the
>     hook.runHookDir option.
>
>  builtin/hook.c                | 11 +++++++++--
>  hook.c                        | 17 +++++++++++++++++
>  hook.h                        |  1 +
>  t/t1360-config-based-hooks.sh | 19 +++++++++++++++++++
>  4 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/hook.c b/builtin/hook.c
> index bb64cd77ca..c8fbfbb39d 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -40,10 +40,15 @@ static int list(int argc, const char **argv, const char *prefix)
>  
>  	list_for_each(pos, head) {
>  		struct hook *item = list_entry(pos, struct hook, list);
> -		if (item)
> +		item = list_entry(pos, struct hook, list);
> +		if (item) {
> +			/* Don't translate 'hookdir' - it matches the config */

Let's prefix comments for translators with /* TRANSLATORS: .., see the
coding style doc. That's what they'll see, and this is useful to them.

Better yet have a note here about the first argument being 'system',
'local' etc., which I had to source spelunge for, and translators won't
have any idea about unless the magic parameter is documented.

> +setup_hookdir () {
> +	mkdir .git/hooks
> +	write_script .git/hooks/pre-commit <<-EOF
> +	echo \"Legacy Hook\"

Nit, "'s not needed, but it also seems nothing uses this, so if it's
just a pass-through script either "exit 0", or actually check if it's
run or something?

> [...]
> +test_expect_success 'git hook list shows hooks from the hookdir' '
> +	setup_hookdir &&
> +
> +	cat >expected <<-EOF &&
> +	hookdir: $(pwd)/.git/hooks/pre-commit
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'

Ah, so it's just checking if it exists...
