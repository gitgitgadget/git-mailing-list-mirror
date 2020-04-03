Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795FFC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 08:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4673C20721
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 08:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCvRK9qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbgDCIXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:23:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50505 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgDCIXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 04:23:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id t128so6253507wma.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7fi7bJW8oty14uoLTevbUSoXhhxm03Uq92Ea/2J6gMM=;
        b=jCvRK9qfDl57kLyAD0iOqZCPKoQDuRPBoV0MLMUOgPKHr5vB6fP7Vlvm0RXjwLg8N8
         +FVflfIPTFIUos+HhMSITx2olVWWpJfu8ERwXy29Sb4q+wYRPAWQyBVfligBGdvGs1Ai
         VQhBTWDx6yC5JW6/3glGYAqqR0H1SnrHSLNFNFAhOB5mr+b/GZxh69UhjnhfwtwHhYbl
         fk3+xI2pXzQKV0nPbUszypIkQGB0ARrPzdPi9HpC7jUN1G8ur5izfk/zvvsqblHejqoI
         NsbYhp9lVRUMFrTGSDWJNGqNKeos6zYF2bZwwmus9oxmlqwjShJ/0L1qgCCPt3lODBkM
         z1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7fi7bJW8oty14uoLTevbUSoXhhxm03Uq92Ea/2J6gMM=;
        b=ZLf/dPkpQT4pvzgeV2AG+PYhFckdo5j9PLfwN3i72lXFJrOukQRUe/jMRSOvfXKvpQ
         /xhP0tNtbo/2LVB8p+3Nitl8vxSjfjec3wrNVqdRYnC2bpsInYuk/5VUXkWCt2PjZmk7
         Z383CD+znHFCE7vB0UStNFQRbr/QJ5AMHBo2cU6ytW2zTH0SzZSo1oorz/VqwL168pEW
         kgqYxocPT4KOZf9kiPbkBtxEnQ3a5dAVByF+Ll+189LCIl/Kz/TB9mYRr2qxjJnPcnKy
         OrBg6+ScNkX63nkan3Zd/ybFwaPYjOWln7RsM/Ic9/ui1Jc6g377BKmJt/5X92PMkZlg
         /MhQ==
X-Gm-Message-State: AGi0PuZa+jfCKVJGgQtRgjVUHY1L0fs78hXPkQq+AZCDAOJyXBdpCO6O
        3BsbPP5kb6+hFFi71ijPnXQ=
X-Google-Smtp-Source: APiQypJYMhCZ+Ob/EVRJ1bMg9UntUAt1IWAMegmmtr6f1s3EzdX+H9/FEGMFPvdI1Hi9AuPsCSPFkA==
X-Received: by 2002:a1c:2489:: with SMTP id k131mr7736040wmk.86.1585902177835;
        Fri, 03 Apr 2020 01:22:57 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id 132sm8374566wmc.47.2020.04.03.01.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 01:22:57 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:22:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ci/lib-docker: preserve required environment
 variables
Message-ID: <20200403082254.GJ2224@szeder.dev>
References: <cover.1585474409.git.congdanhqx@gmail.com>
 <cover.1585832270.git.congdanhqx@gmail.com>
 <b7b079f559a17b6d6cef037afd6ce023df8f90b0.1585832270.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7b079f559a17b6d6cef037afd6ce023df8f90b0.1585832270.git.congdanhqx@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 02, 2020 at 08:04:01PM +0700, Đoàn Trần Công Danh wrote:
> We're using "su -m" to preserve environment variables in the shell run
> by "su". But, that options will be ignored while "-l" (aka "--login") is
> specified.

This is not true.  See any previous runs of the 32 bit Linux job,
which worked as expected, because none of these environment variables
were cleared.

> Since we don't have interest in all environment variables,
> pass only those necessary variables to the inner script.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  ci/run-linux32-build.sh | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index e3a193adbc..7f985615c2 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -51,10 +51,17 @@ else
>  fi
>  
>  # Build and test
> -linux32 --32bit i386 su -m -l $CI_USER -c '
> +linux32 --32bit i386 su -m -l $CI_USER -c "
>  	set -ex
> +	export DEVELOPER='$DEVELOPER'
> +	export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET'
> +	export GIT_PROVE_OPTS='$GIT_PROVE_OPTS'
> +	export GIT_TEST_OPTS='$GIT_TEST_OPTS'
> +	export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB'
> +	export MAKEFLAGS='$MAKEFLAGS'
> +	export cache_dir='$cache_dir'
>  	cd /usr/src/git
> -	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
> +	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
>  	make
>  	make test
> -'
> +"
> -- 
> 2.26.0.334.g6536db25bb
> 
