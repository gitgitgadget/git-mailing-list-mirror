Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DAAC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C060BD3
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDOTIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTIS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 15:08:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B9C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 12:07:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z1so29392091edb.8
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6tAuEe4RokD5iV3oUA7SYp7J1LHdfh2mjN6qQ+3P0aE=;
        b=iC9ohkgHcKSx6z7/dQCQfJRTWAqiKFtle2i8I/1re9QB29Nv+z6wtyzwQ13x8RCbxe
         BQ4ogsfelEBj9QvGkYIDtVW6+cVKgS5ll4b+q64vUARiFZdhKl5hikPGne052I7MSKU4
         UZs1Xe/UjyYteWnvyJtA38cC5lITsYCnKWtaiYXRih+bHQwD0UQR6P8Gd3YGdgXPfZXx
         apPSfsHRCHJ91GIvdiWN+YiwtDaFMg+jhTjzh+oRUKMZwoqAtY3wXrKnbX0+fctVIzrs
         FfyA2OmY+9HAcXG7qe17hxxPYZ7voYxoXbW7JfLr4TlCGl4it/qCdMYiOstX/cyH2rfa
         rJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6tAuEe4RokD5iV3oUA7SYp7J1LHdfh2mjN6qQ+3P0aE=;
        b=S/dZ5THpWmlbB11J/BePEcP9/tT31hFTAMgGvvVCP/yaiq5R5HmEtzd0pVxl3ZZaW6
         X+YYZ3nsSFXTtT1AMMQ6RoTwFqvRt+zXeTcjSdyQrpbT8VfarZc8PHqaetFzikS7NwPU
         2nfl+3QVRl12MsvHGlbmTy4kAHxynBBji8B6yhbfco+pW0q/jin68CrPgURxeJPhftK+
         mBBGJm4ov8dcUQzhvvhhc5Qq0CQNY5AqtzfXBsdj4hMOTfzrEUdzry6yiIGrgqHkISEO
         TxEehs/HTojCl1pQLsz0/kG4v7Ddpa8CSgU+e0AALpR+vQMdyO3G34Jxi+TwKlpdlx8D
         wP1g==
X-Gm-Message-State: AOAM532xftIN1fYKDaMjpwokrTHFIrYy3lmnkCufAL5tkNPX16UYEpkh
        AU1dtnZRMAzKQobPDpDBbTAm23WWUNk=
X-Google-Smtp-Source: ABdhPJym1T4CZ/SodAv7KFUMCCO1fHnjjfKC5vajtZ4gAzBJY+qnN8A2el41FrIR7mO3wlZQfNay+A==
X-Received: by 2002:a05:6402:176c:: with SMTP id da12mr5910901edb.325.1618513673688;
        Thu, 15 Apr 2021 12:07:53 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id t7sm2524226ejo.120.2021.04.15.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:07:53 -0700 (PDT)
Date:   Thu, 15 Apr 2021 21:07:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/16] test-lib: do not show advice about
 init.defaultBranch under --verbose
Message-ID: <20210415190751.GL2947267@szeder.dev>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-11.16-cdbff4df362-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-11.16-cdbff4df362-20210412T110456Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 01:09:00PM +0200, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 674b865a20d..c81726acb9e 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1259,7 +1259,6 @@ test_create_repo () {
>  	(
>  		cd "$repo" || error "Cannot setup test environment"
>  		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
> -			-c init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
>  			init \

This change got my hopes up that

  GIT_TEST_INSTALLED=/.../v1.6.0/bin ./t9999-foo.sh

will work again (it didn't yet support 'git init -c <...>'), but,
alas, already the next patch will turn this into 'git init ...
<trash-dir>', and v1.6.0 didn't support that, either, so it will
remain broken...  Oh, well.

>  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>  		error "cannot run git init -- have you built things yet?"
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a8869eee58f..0057dfa69d0 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -64,6 +64,11 @@ then
>  	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
>  fi
>  
> +# Explicitly set the default branch name for testing, to avoid the
> +# transitory "git init" warning under --verbose.
> +: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
>  ################################################################
>  # It appears that people try to run tests without building...
>  "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
> -- 
> 2.31.1.634.gb41287a30b0
> 
