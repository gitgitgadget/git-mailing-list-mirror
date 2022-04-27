Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CCC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 22:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiD0W0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiD0W0A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 18:26:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6B2B252
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:22:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id u1-20020a17090a2b8100b001d9325a862fso1470228pjd.6
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EcfgSqBqkjqRDGDNTU6KlIMH4oyyDOB8PDyr4kgAnQ8=;
        b=btCC27YKKA3KqZjHAxO3PvjMG+7INuSGex7nBX4zrukxi/Mm5UmStUSYL75ViwD8az
         VEY3UQZN1P9GCNdgLHa6ZI8qi3XtjZdTyFxHOVempC1M9Fs5ewodlQNV9CqqTFbZpuBI
         JPumkkDsTpP1TZJOFaoqAn1OcQSUlzLtY/oLWYBQ6cbzLKuhUwhbrJ75nUARtdYNDwle
         JQmmzUVNGHh7eOqwUiwubxgKBoecbK1Oo8y6eczH3OlPcT5hO2C1AirxdZJZ4gphkDO6
         qW9TZmJXEOVXeOvzGv5M54dhparxqsOpAo+eF3GOPK4btRzMhnA/uk4DO2pydLW1zfxn
         gEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EcfgSqBqkjqRDGDNTU6KlIMH4oyyDOB8PDyr4kgAnQ8=;
        b=LPuMZJIEKGnrsk4cexXZksUY3vUhbGgaSP/G1TbSWg4ZnX5E4rARx0Rr1FfXloFCfx
         TkIWE5wnKgHDyNtz7H111YSDmpZbWPW/ZpXeu6g2wAACpsVMTy7cmaZDbuUwhZlCEM06
         XM0segdIAAJQ6Zbc4/ByKbzUI6wtKrbNzu4ezLkVHGARoL1fydDvOBR+W1VYLmRk2hz6
         f8xhZ3uI9EdVd0RISx4F6bGB2iyzFjySjyTnbF3/NjrD24dTEveqSa2+fznEmhp7yIrM
         W9ig7PyD+fOC1wOplfijpHiUTQvNpuysSzoN/FybEPgu44AOwSs6MhG4FguKaNOe/RLR
         JWWQ==
X-Gm-Message-State: AOAM531KnDn3+QDNl53tSPDnSVBgcUMdpioVUp3KJ9PKUz2Pku0fD4Eo
        yzrVb42Ui6b7DLLmZ7OVELp1txbFE1BIPw==
X-Google-Smtp-Source: ABdhPJzw3vQEfLQzZzXVKyNOgiHrVzLZ3Y7pjl+shVC8WFHjEc+IU/5OmbOviQDdrhWMnlJDTiGxII8KFhSrog==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:bb8f:b0:1d9:650e:10f5 with SMTP
 id v15-20020a17090abb8f00b001d9650e10f5mr21578006pjr.148.1651098167192; Wed,
 27 Apr 2022 15:22:47 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:22:44 -0700
In-Reply-To: <xmqqtuagvq4n.fsf@gitster.g>
Message-Id: <kl6lczh2p3nv.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
 <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
 <xmqq35i1vx3y.fsf@gitster.g> <xmqqtuagvq4n.fsf@gitster.g>
Subject: Re: [PATCH v2] submodule--helper: fix initialization of warn_if_uninitialized
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Is this a fix we can protect from future breakge by adding a test or
>> tweaking an existing test?  It is kind of surprising if we did not
>> have any test that runs "git submodule update" in a superproject
>> with initialized and uninitialized submodule(s) and make sure only
>> the initialized ones are updated.  It may be the matter of examining
>> the warning output that is currently ignored in such a test, if
>> there is one.
>
> Here is a quick-and-dirty one I came up with.  The superproject
> "super" has a handful of submodules ("submodule" and "rebasing"
> being two of them), so the new tests clone the superproject and
> initializes only one submodule.  Then we see how "submodule update"
> with pathspec works with these two submodules (one initialied and
> the other not).  In another test, we see how "submodule update"
> without pathspec works.
>
> I'll queue this on top of your fix for now tentatively.  If nobody
> finds flaws in them, I'll just squash it in soonish before merging
> the whole thing for the maintenance track.
>
> Thanks.

Thanks for adding the tests!

>  t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git c/t/t7406-submodule-update.sh w/t/t7406-submodule-update.sh
> index 000e055811..43f779d751 100755
> --- c/t/t7406-submodule-update.sh
> +++ w/t/t7406-submodule-update.sh
> @@ -670,6 +670,39 @@ test_expect_success 'submodule update --init skips submodule with update=none' '
>  	)
>  '
>  
> +test_expect_success 'submodule update with pathspec warns against uninitialized ones' '
> +	test_when_finished "rm -fr selective" &&
> +	git clone super selective &&
> +	(
> +		cd selective &&
> +		git submodule init submodule &&
> +
> +		git submodule update submodule 2>err &&
> +		! grep "Submodule path .* not initialized" err &&
> +
> +		git submodule update rebasing 2>err &&
> +		grep "Submodule path .rebasing. not initialized" err &&
> +
> +		test_path_exists submodule/.git &&
> +		test_path_is_missing rebasing/.git
> +	)
> +
> +'
> +
> +test_expect_success 'submodule update without pathspec updates only initialized ones' '
> +	test_when_finished "rm -fr selective" &&
> +	git clone super selective &&
> +	(
> +		cd selective &&
> +		git submodule init submodule &&
> +		git submodule update 2>err &&
> +		test_path_exists submodule/.git &&
> +		test_path_is_missing rebasing/.git &&
> +		! grep "Submodule path .* not initialized" err
> +	)
> +
> +'
> +
>  test_expect_success 'submodule update continues after checkout error' '
>  	(cd super &&
>  	 git reset --hard HEAD &&

So we test that we only issue the warning when a pathspec is given, and
that we ignore uninitialized submodules when no pathspec is given. I
think this covers all of the cases, so this looks good, thanks!
