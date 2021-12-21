Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8231FC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbhLUSRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbhLUSRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:17:25 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA41C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:17:25 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s70-20020a627749000000b004bb258dce21so27366pfc.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A65QUWUFFkpb/htmOCzWQGV6V453D1avrUJ2kx30gO8=;
        b=ictXW8520pv27nx6cdvVWEAZ4gYOzAjP7Ah45BJFwNmdmWoqhn0Mcw/tvGxes9/5y4
         6tdcHM/rlhGk8p+q9pGQzn4eizU6AV3OR7A2cW+JzNdN4OKLBmDtBtjCFKm7OKnhBV6e
         wk6rmgxYCTpdgR/Ldc2hI9o32IIFBlwODHJY/gLTgmE7w+a0J0C0gkI9+HRT3KKiCHOM
         77EchmVqd5Yrv4xRAwx2RpLAakRt2b4Eu9VgkQ9ec5fCKadjuK5FsdueUnEqGZpx9WRv
         wOhIIwLBEiXiISZZ2X0w+yKGERyG0QOnqyMDD0AhRzIJm91/b/Rwxxr/+FZb3iSC9QzB
         xlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A65QUWUFFkpb/htmOCzWQGV6V453D1avrUJ2kx30gO8=;
        b=ZonlgkF7qpetbSR5cNjv6zHIr/M4kd8NQyGiNFiqgfJj9x8OJszE/4A2gqDkg2rMGK
         /XREjV1ON2KtjxB3FZLuABk5W6WBN4zSbGJgbJJN+hJ/I9b2prdneWvS1PLdq7LTalMW
         8iVnpJjy9PbTAvt65E5WKA3Xf03G8rLENJAAulRKoOujA1SIuRJ2W62YaxFbykDk3Rcr
         1h6bth0dp4EWAqF0lWH5n9g8kSRKRBo51QLP+Kq4Zmv65YL1XUp02ADXzcw5iPWFb3gC
         NKmqPi6iIaBEwvdf97Qw7OcvbPpf+nwV9FyWFhROwLQZy9xaLHn2WZQww9WqLfT6nD02
         LhWw==
X-Gm-Message-State: AOAM530zWSfeC6kvrAVYVcoxua2cqmWHf6xpYIj4Vq2FGbUS3oHiC5sa
        NVbJXGZpfW654DLHHhJQq69r7aR2N8VsyQ==
X-Google-Smtp-Source: ABdhPJx7/ftxZFv/BKieNtrIV5svR8Of8F9V9oPJDNgBfuV9yDaSqa3W1k0A1W0SwFQjXAHJj8EtNfplu/3Ifw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1903:b0:47c:34c1:c6b6 with SMTP
 id y3-20020a056a00190300b0047c34c1c6b6mr4443483pfi.17.1640110644563; Tue, 21
 Dec 2021 10:17:24 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:17:22 -0800
In-Reply-To: <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
Message-Id: <kl6l5yrhzutp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com> <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
Subject: Re: [PATCH v8 2/3] branch: add flags and config to inherit tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 4b0ef35913..a049276439 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
>  
> +test_expect_success 'tracking info copied with --track=inherit' '
> +	git branch --track=inherit foo2 my1 &&
> +	test_cmp_config local branch.foo2.remote &&
> +	test_cmp_config refs/heads/main branch.foo2.merge
> +'
> +
> +test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
> +	test_unconfig branch.autoSetupMerge &&
> +	# default config does not copy tracking info
> +	git branch foo-no-inherit my1 &&
> +	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
> +	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
> +	# with autoSetupMerge=inherit, we copy tracking info from my1
> +	test_config branch.autoSetupMerge inherit &&
> +	git branch foo3 my1 &&
> +	test_cmp_config local branch.foo3.remote &&
> +	test_cmp_config refs/heads/main branch.foo3.merge &&
> +	# no tracking info to inherit from main
> +	git branch main2 main &&
> +	test_cmp_config "" --default "" branch.main2.remote &&
> +	test_cmp_config "" --default "" branch.main2.merge
> +'
> +
> +test_expect_success '--track overrides branch.autoSetupMerge' '
> +	test_config branch.autoSetupMerge inherit &&
> +	git branch --track=direct foo4 my1 &&
> +	test_cmp_config . branch.foo4.remote &&
> +	test_cmp_config refs/heads/my1 branch.foo4.merge &&
> +	git branch --no-track foo5 my1 &&
> +	test_cmp_config "" --default "" branch.foo5.remote &&
> +	test_cmp_config "" --default "" branch.foo5.merge
> +'
> +
>  test_done
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 7f6e23a4bb..4fdf88ba46 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -657,4 +657,21 @@ test_expect_success 'custom merge driver with checkout -m' '
>  	test_cmp expect arm
>  '
>  
> +test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
> +	git reset --hard main &&
> +	# default config does not copy tracking info
> +	git checkout -b foo-no-inherit koala/bear &&
> +	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
> +	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
> +	# with autoSetupMerge=inherit, we copy tracking info from koala/bear
> +	test_config branch.autoSetupMerge inherit &&
> +	git checkout -b foo koala/bear &&
> +	test_cmp_config origin branch.foo.remote &&
> +	test_cmp_config refs/heads/koala/bear branch.foo.merge &&
> +	# no tracking info to inherit from main
> +	git checkout -b main2 main &&
> +	test_cmp_config "" --default "" branch.main2.remote &&
> +	test_cmp_config "" --default "" branch.main2.merge
> +'
> +
>  test_done
> -- 
> 2.34.1.307.g9b7440fafd-goog

As a suggestion, I don't think we have tests for multiple branch.*.merge
entries and it would be nice to have some (though I don't think it's
absolutely essential).
