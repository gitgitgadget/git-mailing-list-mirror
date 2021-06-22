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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F990C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D166134F
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhFVQyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFVQyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:54:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7CC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:51:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ho18so35559303ejc.8
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JD/pUrA7HzmnFp4XfMkoYUtMqltl2QXQLj0ZPGoznWM=;
        b=LGKNQEReWNrio9dAqSyXsn+Z2fk8UaTtaRMcsGqjgID0wjJhXaTzETdJzfDncSBhg1
         TWguHNBketABp26LnQJyi1BrYn0Zr47heSw9ClYZW4tG8sLTlBb8jXT9dJyr8z5A4wiv
         pvZ3IbNW3AdM7IQ8UcURLrEQkMb8vNhB+HNl6oaPza6RGbQSHMKvLQaRgVlKGCg3QFZK
         y9cPTZXgbKs5cUwQWUT15+MC8Zq1DM7np1Bk0ejrD5eLXmobYvG3JpWAk3gOR83/aE6s
         oT/Nrb1R/ibRJTFr60kAWJ+mmX/3iz5Id10HnutUvR7pB4CnaH4Hud5Blnvn7g5rtnyx
         et7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JD/pUrA7HzmnFp4XfMkoYUtMqltl2QXQLj0ZPGoznWM=;
        b=CxUDB0DIsZCJAxLvbCXMkI39BsvrhUEFmVZdPAf6NhR2FDGN9v+abISLw2rkSUEZmv
         vOgZ4b9RIYYXLoj1Pj/LGx4i+ka+evZ4hMXOKff8xamhtWBN64RVjRkRZdDXm7tZS+Z4
         mzZ+yGcJ/ZvH7BZw1bN1D9lgXMIfLpsJ+HJe69u5oLFwmHDr6i8d+S8OFKeUI2pzCTWp
         pnJxMb1fr0BDWNCkmdodPYVTcmzgxOq6RZdmr1DnQYL/u5ZAkVgurgcyd2vXtKxZ908k
         4LCP2zwSuBm9vHoJAQ4rz2TP9psSCLjXgei57yY845tg3uG/g2LHC/PbUQcDEDFd9b9X
         bMxQ==
X-Gm-Message-State: AOAM533smOQcf2CttMOnUJr7uTPSEg1XvmN9yqO0FVphdyhJFWSyW54w
        h1jZBe/Z56lBawimPHvMp7w=
X-Google-Smtp-Source: ABdhPJywyE3dXh1oCGCdzCSI54A69LkdM8gb/J7gO0xOKoNxkUN/GGASxPGsGPNus/UwGqbt5xK5bA==
X-Received: by 2002:a17:906:b0c8:: with SMTP id bk8mr5047535ejb.412.1624380703797;
        Tue, 22 Jun 2021 09:51:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u12sm12698908edv.43.2021.06.22.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:51:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] test-lib-functions: test_create_repo learns --bare
Date:   Tue, 22 Jun 2021 18:48:22 +0200
References: <20210617124331.17888-1-zhiyou.jx@alibaba-inc.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210617124331.17888-1-zhiyou.jx@alibaba-inc.com>
Message-ID: <878s313krl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Jiang Xin wrote:

> "test_create_repo" learns --bare option to create bare repository.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/test-lib-functions.sh | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b823c14027..f6d1afe295 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1216,8 +1216,21 @@ test_atexit () {
>  }
>  
>  # Most tests can use the created repository, but some may need to create more.
> -# Usage: test_create_repo <directory>
> +# Usage: test_create_repo [--bare] <directory>
>  test_create_repo () {
> +	bare= &&
> +	while test $# -gt 0
> +	do
> +		case "$1" in
> +		--bare)
> +			bare=yes
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done &&
>  	test "$#" = 1 ||
>  	BUG "not 1 parameter to test-create-repo"
>  	repo="$1"
> @@ -1226,10 +1239,13 @@ test_create_repo () {
>  		cd "$repo" || error "Cannot setup test environment"
>  		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
>  			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
> -			init \
> +			init ${bare:+--bare} \
>  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>  		error "cannot run git init -- have you built things yet?"
> -		mv .git/hooks .git/hooks-disabled
> +		if test -z "$bare"
> +		then
> +			mv .git/hooks .git/hooks-disabled
> +		fi
>  	) || exit
>  }

It looks like you authored this before, but sent this after f0d4d398e28
(test-lib: split up and deprecate test_create_repo(), 2021-05-10) was
merged down.

Your 2/2 here looks like it's not needed after my 97c8aac9c5f (test-lib:
do not show advice about init.defaultBranch under --verbose, 2021-05-10)
either.
