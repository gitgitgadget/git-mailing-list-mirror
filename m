Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D98C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850936135D
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFBT7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:59:37 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:44950 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBT7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 15:59:36 -0400
Received: by mail-qk1-f175.google.com with SMTP id h20so3635566qko.11
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ofF3FfmXiNX+Nj6jmfuhRHs7rAv8VbtKmdk4mgVQcis=;
        b=Fm/hjhqaXFzACqZpXnQV3UYyeuUqSXBZ7A9+XVZHpwcteyxu6GgIhhlglpEXJwkB0b
         XweLFwO/OeuIgI2D4ysGa70IJnFmv3lAOG2aT/pdExG1IjN8OiBGrFRcAHoZMkjY65Jh
         Fyrrtx7zqHa8rsRgtcmSMUHTp/+wempr5Rhrwz9aTXhvnvKlHIBw61E8qbCrYuzmZqwr
         poDOJfFggTKKNPkW2fX6KZzWoYYzbjpJxGE55VBUGmHLHwb+rVUc6ioocH+1pVguepdF
         gJmhaKN5K2EzG7/CT5JTWG1JtRg3fI5HkLzofZ0xAKriAZWSWaX7MH0ysAzEV35n3H9K
         Je8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ofF3FfmXiNX+Nj6jmfuhRHs7rAv8VbtKmdk4mgVQcis=;
        b=e4MnltSEww875vEQYSr32SrORHYRwYeCBXT4D5Yor8xMFoayY1dvAd6whsC+d8HuMb
         WcWYo25cjdl6nSLts8xKb77TtqUtTJtfApz9Q181uFjoc3JboZOuEFxatLjkWKgNpGts
         Ixe65iEkTACSCwlFlJR1bLwj2AA5SytCU/1GovtSCqsXEwmUkO1KkJhIUsdooDJyVxso
         Ped8fIPzoXTZmLlSxw2bDYvUIE1l1ZQHf1i6zt9TDz95tFT05niiVhPvEaAsh6p3jrhy
         XNQdA+dTVAEHoaijxyPcVX3+HZ/yFPAV/t3ahS38SslOiS3mOqy3fIhvWqSGd9XXcL8J
         5J+w==
X-Gm-Message-State: AOAM530Px8tJahQ1lcSEVuOLJRSO36LLhEbt3swd2+GcEK/0G4AVvZhD
        MqPhXppdRch6/4OYhD1EEyLTlOpj8nG4zQ==
X-Google-Smtp-Source: ABdhPJzPjSGG/ufYjpe7OjCDeL/zAkRl0AEZIt+RG0zTEUoWRiosgZdX6KFgOLMcSjX/RWn2l8epyg==
X-Received: by 2002:a37:de04:: with SMTP id h4mr29075862qkj.458.1622663799730;
        Wed, 02 Jun 2021 12:56:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id h10sm536401qka.26.2021.06.02.12.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:56:39 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Wed, 2 Jun 2021 15:56:38 -0400
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: use user-specific utf-8 locale for testing
Message-ID: <YLfiYXxQqXL7RyHC@nand.local>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114646.17463-1-congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 06:46:46PM +0700, Đoàn Trần Công Danh wrote:
> Despite being required by POSIX, locale(1) is unavailable in some
> systems, e.g. Linux with musl libc.  Some of those systems support
> utf-8 locale out of the box.

Hmmph. I would have imagined that locale was available everywhere, but
unfortunately not.

> diff --git a/Makefile b/Makefile
> index c3565fc0f8..4b2c24e5ea 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -398,6 +398,9 @@ all::
>  # with a different indexfile format version.  If it isn't set the index
>  # file format used is index-v[23].
>  #
> +# Define GIT_TEST_UTF8_LOCALE to prefered utf-8 locale for testing.
> +# If it isn't set, use the first utf-8 locale returned by "locale -a".

s/prefered/preferred

> +#
>  # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
>  #
>  # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
> @@ -2801,6 +2804,9 @@ ifdef GIT_TEST_CMP
>  endif
>  ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
>  	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
> +endif
> +ifdef GIT_TEST_UTF8_LOCALE
> +	@echo GIT_TEST_UTF8_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_UTF8_LOCALE)))'\' >>$@+
>  endif
>  	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
>  ifdef GIT_PERF_REPEAT_COUNT
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 547eb3c31a..df319593f7 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -121,12 +121,15 @@ start_svnserve () {
>  		 --listen-host 127.0.0.1 &
>  }
>
> -prepare_a_utf8_locale () {
> -	a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
> -	p
> -	q
> -}')
> -	if test -n "$a_utf8_locale"
> +prepare_utf8_locale () {
> +	if test -z "$GIT_TEST_UTF8_LOCALE"
> +	then
> +		GIT_TEST_UTF8_LOCALE=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
> +		p
> +		q
> +	}')
> +	fi

OK, so we bind GIT_TEST_UTF8_LOCALE to the value of $a_utf8_locale in
the pre-image, unless the user said otherwise.

> +	if test -n "$GIT_TEST_UTF8_LOCALE"

...Then we go on to handle things like before, except we read from
"$GIT_TEST_UTF8_LOCALE" instead of "$a_utf8_locale". Makes sense to me.

>  	then
>  		test_set_prereq UTF8
>  	else
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 1d3fdcc997..d5563ec35f 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -4,21 +4,13 @@
>  #
>
>  test_description='git svn basic tests'
> -GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
>
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./lib-git-svn.sh
>
> -case "$GIT_SVN_LC_ALL" in
> -*.UTF-8)
> -	test_set_prereq UTF8
> -	;;
> -*)
> -	say "# UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
> -	;;
> -esac
> +prepare_utf8_locale

This change (and the omitted ones below in later hunks) look like it
isn't changing any behavior (and just running the same code behind the
prepare_utf8_locale function instead of inlining it).

They all look right to me, but it may be helpful to either point it out
in the commit message and/or prepare the separately. I'd probably err on
the side of the former.

That said, this patch looks good to me with minor touch-ups (my only
nits are the above and the spelling mistake in the Makefile).

Thanks,
Taylor
