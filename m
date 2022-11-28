Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B67C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 04:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiK1ELN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 23:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiK1ELK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 23:11:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BD6C4
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 20:11:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so12749494pjk.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 20:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=c3l6YR4PyCMPNbMnTbWMDodOqU4qH+agKF4ZkIk408A=;
        b=HCSSXyTslPUih779bF1MHSqpQIMMoibfHZgU4c3Krnyyfl1AkAs8FICqF4w4kcpSih
         ql1SblJMon7WKWtt/LsZFmakOj/btkWBKR/J1Drw5h19LjHm/FjfhNUflMLOfcPIXCN2
         MZhJl7EHs61UY+r52NcCnrfgjxNytBxRCcKIwUJrGn9pGnie9yo/UhQpq3NhN9dvRxCf
         aFOgYjcsNnlonJdbXrxW3HelButnOn4lbt4XcwekhmlKnIoM/5wXXtHffkhBIFmxarzC
         xDDjpKE8VqhHKHElQkVhrJuTP8x4XmU/qI/jrgXKpeieB04EMts/HA0sfiJRF5akhpkj
         EsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3l6YR4PyCMPNbMnTbWMDodOqU4qH+agKF4ZkIk408A=;
        b=3tKdhjYKihiHcCyb5tH8ieDOrTvJmJHu8ddA1J3qJBSBc65+e6KDsudiXkorKL9sr1
         tbqhRLbjlxfMxpdqUbtJs7YMhRiSSQ2wN+4h2YfZzXzNL+QrCTuirtmZgvsrFZKC8WfF
         G5f1MZUG3JMx2BsSMqlaSBpbL2AxVYzYRVrDc/ghHRbMb/urbq18EqD7J8Pbkc7g0kbC
         wSRXPtP1C1JbfogVGEzWHVYezujB1+oFwRBJGUr6TyUJPLTFRldZbKJHADW6GBqxQ9ID
         W7U/0kYrV3aSc4RSMTStlTYpSzNH7Qyl+AxrfyFrBWL3J69y9Blj3Skr2LWZRdrys1/t
         WNRA==
X-Gm-Message-State: ANoB5pkoRaqpmcBRec0aP2FFJd9tr8xJoGnfaFfaSbjnzzZZkl4NVo7v
        VLcte4d9xOWavGCSi5xuHGqrSwnoZo1vGA==
X-Google-Smtp-Source: AA0mqf4G1FB4rg9nychMNX66QBCAHctA4ZqStWg52PdelsuAjxptpgkWYy2kyHpMRU9Dpk32iQz2Fw==
X-Received: by 2002:a17:902:e80f:b0:188:f571:cea2 with SMTP id u15-20020a170902e80f00b00188f571cea2mr33146817plg.146.1669608665515;
        Sun, 27 Nov 2022 20:11:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y1-20020aa79421000000b005751f455e0esm1597019pfo.120.2022.11.27.20.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 20:11:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v1 2/4] t1301: use test_when_finished for cleanup
References: <20221127145130.16155-1-worldhello.net@gmail.com>
        <20221127145130.16155-2-worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 13:11:04 +0900
Message-ID: <xmqq8rjv90rr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t1301-shared-repo.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 7578e75d77..1225abbb6d 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -25,6 +25,7 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
>  for u in 002 022
>  do
>  	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
> +		test_when_finished "rm -rf sub" &&
>  		mkdir sub && (
>  			cd sub &&
>  			umask $u &&
> @@ -42,7 +43,6 @@ do
>  			;;
>  		esac
>  	'
> -	rm -rf sub
>  done

This is indeed "we used to clean-up outside the test, but instead
let's use test_when_finished for that".


> @@ -132,6 +132,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
>  '
>  
>  test_expect_success POSIXPERM 'forced modes' '
> +	test_when_finished "rm -rf new" &&
>  	mkdir -p templates/hooks &&
>  	echo update-server-info >templates/hooks/post-update &&
>  	chmod +x templates/hooks/post-update &&

But strictly speaking this is different.  We used to leave "new"
after we are done, now we do clean up.  Which is definitely an
improvement in any way ;-)

> @@ -174,6 +175,7 @@ test_expect_success POSIXPERM 'forced modes' '
>  '
>  
>  test_expect_success POSIXPERM 'remote init does not use config from cwd' '
> +	test_when_finished "rm -rf child.git" &&
>  	git config core.sharedrepository 0666 &&
>  	umask 0022 &&
>  	git init --bare child.git &&
> @@ -193,7 +195,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (local)' '
>  '
>  
>  test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)' '
> -	rm -rf child.git &&
> +	test_when_finished "rm -rf child.git" &&
>  	umask 0022 &&
>  	git init --bare --shared=0666 child.git &&
>  	test_path_is_missing child.git/foo &&
> @@ -204,7 +206,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
>  '
>  
>  test_expect_success POSIXPERM 'template can set core.sharedrepository' '
> -	rm -rf child.git &&
> +	test_when_finished "rm -rf child.git" &&
>  	umask 0022 &&
>  	git config core.sharedrepository 0666 &&
>  	cp .git/config templates/config &&

These child.git test repositories used to follow "initialize what we
are going to use to a known state before we use" pattern, which is
not wrong per-se, but now we use "clean up the cruft we make after
we are done" pattern, which may arguably be better, simply because
the test that makes cruft should know what cruft it created better
than whatever comes later that may not know.

OK.
