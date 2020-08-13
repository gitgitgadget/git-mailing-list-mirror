Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA9C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 08:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8502078D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 08:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLjkb9/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgHMIHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMIHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 04:07:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B0C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 01:07:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k18so2413729pfp.7
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PxeTOdbTYze8ZLUId6mCJ1bZEBD+1mr7os1iqwyRJwk=;
        b=OLjkb9/yL0koQ5Qhf0590DF9hF/c8nZxH8gmzD0hXsY4Ht94ab3Xa3AnqQ8SEGX2Nw
         cKvQvJVE8zDme5nGTGKdP7Ee9IJ8LzedS8hkQK+TqutABW3RwaUnw+c//5o4rhMzpqYM
         PzUfCsbywq/4/fsNxqK7bphJyHgp9/X3Oaj2j6e5zYDkicis9s5gqJ2MZDQOIIuKturD
         7bQCGeR8AfbyfA9I2gv7W1uXDOmPHnNL90w52LZXd2wivg2vEOTTMPYGJ+Q9rvyE3n1C
         TuYVqzw3Y5A3CXldzRQ7EG8tyfyamO9UYnw0iGMhem5vPI2gI6vqUsu1XoVKK3SrLb1g
         riKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PxeTOdbTYze8ZLUId6mCJ1bZEBD+1mr7os1iqwyRJwk=;
        b=L6Ceh/hsp6OcYm7FIBo04ogLn0QSWNVWtGwvoxlw5xJNRY59KbqexmIxx8zDizzeCi
         7vVh3sTgg4ICmuCHBZMSMJWPQRquXXuDncMEOmvNDrIz+w9K0sYd7fDZIevxR9xkH0uH
         75o0SkowYN7I4b2iskSSJuKS92lSfPQ3ld2vAgpizVI+bAn59FDobfBgOalrNIpq7bNT
         BxwPUBdM1+O2PH6KDFKPngpL2PM1yHJzq5simpbBcA3qQ1seK+E0xXeFOm9P34n8+JEt
         mXkUw/y4CTes+jlyslycF5B92cYyBye/RlqP6oYyHBvw3WcE+ZuZAH4oRM0EPOcnGUy8
         53Ag==
X-Gm-Message-State: AOAM531vFT8itNxOn5oZiDEl0xYJAEagPHS/Sz/OumQ+Vsu6fpZGeryT
        5k1GwgDiHjBayJo7znyKZsw=
X-Google-Smtp-Source: ABdhPJzAHxu8lNx+LwhR+ZeaVgDuigo0SzGTH9FMH/7zR+aRX8xV4oiBe/mM8oTmHnHymUKMCz0crQ==
X-Received: by 2002:a63:ec04:: with SMTP id j4mr2629035pgh.393.1597306020947;
        Thu, 13 Aug 2020 01:07:00 -0700 (PDT)
Received: from lwitch-pc ([49.207.138.197])
        by smtp.gmail.com with ESMTPSA id c4sm4837032pfo.163.2020.08.13.01.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 01:07:00 -0700 (PDT)
Message-ID: <c70f7bb5d1289f5318da7b99e41cf5828a451174.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] t7401: modernize style
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, liu.denton@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Date:   Thu, 13 Aug 2020 13:36:49 +0530
In-Reply-To: <20200812192737.13971-2-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
         <20200812192737.13971-1-shouryashukla.oo@gmail.com>
         <20200812192737.13971-2-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2020-08-13 at 00:57 +0530, Shourya Shukla wrote:
>
> [...]
>
> Using a Git command in the upstream of a pipe might result in us
> losing its exit code. So, convert such usages so that they write to
> a file and read from them.
> 

While that is a good enough reason to avoid using pipes in places where
we look for the exit code of a command like within test_expect_success,
I'm not sure if that reason holds for the places that the patch
changes.

> [...]
>
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-
> summary.sh
> index 9bc841d085..8ee78bcb69 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -16,12 +16,13 @@ add_file () {
>  	owd=$(pwd)
>  	cd "$sm"
>  	for name; do
> -		echo "$name" > "$name" &&
> +		echo "$name" >"$name" &&
>  		git add "$name" &&
>  		test_tick &&
>  		git commit -m "Add $name"
>  	done >/dev/null
> -	git rev-parse --verify HEAD | cut -c1-7
> +	git rev-parse --verify HEAD >out &&
> +	cut -c1-7 out

In any case, I believe we can avoid the 'cut' altogether in both places
by doing something like this instead:

   git rev-parse --short=7 HEAD

My quick check shows the test script is happy with this change.

>  	cd "$owd"
>  }
>  commit_file () {
> @@ -125,7 +126,8 @@ commit_file sm1 &&
>  head3=$(
>  	cd sm1 &&
>  	git reset --hard HEAD~2 >/dev/null &&
> -	git rev-parse --verify HEAD | cut -c1-7
> +	git rev-parse --verify HEAD >out &&
> +	cut -c1-7 out
>  )
>  
>  test_expect_success 'modified submodule(backward)' "

-- 
Sivaraam


