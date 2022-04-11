Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90433C433FE
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 11:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbiDKLNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346007AbiDKLM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 07:12:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B26E10
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:09:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d10so17960688edj.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GIsXq4oeN5Z77BFr2fAyBxSRHVloW0mR5QelimpcSDw=;
        b=RIfBWZ6kpp/SH/g+s0CGg1DthuaSNDqv0Gruj/H2LcVVKto4xtgRCut1Y3FPX46z5B
         sKeWb+MRpBooEILFsuiUwHlh+8jYX2tFgOB/oqPQgT3+rFv5b+32kCYBo0r784RyGF9r
         2e/iOvLCUIE0nQeoYzGdwj5ohL6p7dkmDjRmr90TY6ZZwAuupYxNKzGmu2xC2hL87LQq
         iulr+/4mjEfChnuPs52z/ytGARdxpJ0DkOrgruLfQ2AN3LT8XZQazbSK6+We1jkjivZp
         NR2FXKAXf90kV1a1+09SxJtyR25FlR8nLTWGmLg4dZdhkUUI5v5NTGZOwIhg9+bolYDp
         1fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GIsXq4oeN5Z77BFr2fAyBxSRHVloW0mR5QelimpcSDw=;
        b=JVOjw+wEqzXaI0oXlH7T/LMWHQj4M/uDCjbMu61BxBjdT/w4F2kyI7SRfdTeTrbx8A
         MPw4Z2ODQ6/ll+XsuHw3yXQTmjU0lMIlXhj6VgThHdJOfyGhyG1L4gQOOxHJLEkf0SVU
         mxL+niAoyybWMyVAaLCcXWisH23wAAnbuTItkYAiKh8t+/2J/c02Xa0p8gcdgfIwIbYN
         ExWWbPzHicxW+gIQZ5zj5tELXAssRCdF2UMTjY/ACA8uLCIxhUimQyTW0jIlwaMMVYEl
         ks42t58kHUEUdF8PirXs89uKAUYNRC+DIQNbk1L2z8gkNfIA6F2Xtpa0WNTxwS7rHo0/
         7VOg==
X-Gm-Message-State: AOAM533bsYAh5RsdzT58z61cYpgPJe1uBU9E3a93x89NYHbtCgwU7Cbg
        mlePEY9iBDPA/DWIEbr/RlU=
X-Google-Smtp-Source: ABdhPJwXue8o9PHTlCijhneyoNiZexgi79ZAjfZCAfxp0nxeior42FFL+guSC06YNI2bx6bj6getoQ==
X-Received: by 2002:a05:6402:5252:b0:41d:8556:419b with SMTP id t18-20020a056402525200b0041d8556419bmr1295353edd.151.1649675378266;
        Mon, 11 Apr 2022 04:09:38 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j4-20020a509d44000000b0041cdc7ffda4sm10400520edk.59.2022.04.11.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:09:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ndrvN-000eRU-BU;
        Mon, 11 Apr 2022 13:09:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu
Subject: Re: [RFC PATCH 6/6] test-dir-iterator: handle EACCES errno by
 dir-iterator
Date:   Mon, 11 Apr 2022 13:04:48 +0200
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-7-kioplato@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220410111852.2097418-7-kioplato@gmail.com>
Message-ID: <220411.86wnfvj2q6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 10 2022, Plato Kiorpelidis wrote:

> Handle EACCES errno returned by dir_iterator_begin() by printing the
> "EACCES" string instead of printing "ESOMETHINGELSE".
>
> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>  t/helper/test-dir-iterator.c | 8 +++++---
>  t/t0066-dir-iterator.sh      | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index c92616bd69..fd07429f90 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -7,9 +7,11 @@
>  static const char *error_name(int error_number)
>  {
>  	switch (error_number) {
> -	case ENOENT: return "ENOENT";
> -	case ENOTDIR: return "ENOTDIR";
> -	default: return "ESOMETHINGELSE";
> +		case ENOENT: return "ENOENT";
> +		case ENOTDIR: return "ENOTDIR";
> +		case EACCES: return "EACCES";
> +
> +		default: return "ESOMETHINGELSE";
>  	}
>  }

Please stick with the git coding style, see
Documentation/CodingGuidelines.

It's forgivable to "fix style while at it" to some extent, but in this
case it's both moving away from our normal style (by indenting case
labels), and in doing so making the diff larger/worse.

This should be a one-line addition of your new EACCES case.

I haven't read through the rest yet, but please self-review those
patches with a keen eye to diff size & seeing if there's similar
issues. E.g. are they the same lines changed under "git show -w", if not
are you sure you're correct in making the style change?

> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> index 974bb13092..4bf6456735 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -861,7 +861,7 @@ test_expect_success POSIXPERM,SANITY \
>  
>  
>  	cat >expected-no-permissions-out <<-EOF &&
> -	dir_iterator_begin failure: ESOMETHINGELSE
> +	dir_iterator_begin failure: EACCES
>  	EOF
>  
>  	test_must_fail test-tool dir-iterator ./dir12 >actual-out &&

I see this is changing the ESOMETHINGELSE added in your 3/6, if you make
this patch come first then presumably we won't have that churn.

And if we don't have a test that's relying on ESOMETHINGELSE (maybe we
do, but don't test_cmp it, I haven't checked) shouldn't this "default"
case just be:

    BUG("unknown errno %d: %s", errno_number, strerror(errno_number))

I.e. if we have OK coverage here we'd presumably fail the test case
itself anyway, so shouldn't we fail here too?
