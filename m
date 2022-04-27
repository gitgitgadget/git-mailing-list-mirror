Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E9C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 22:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiD0W3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiD0W24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 18:28:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B136E1F
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:25:43 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 16-20020a17090a0a9000b001d48f5547fbso1468840pjw.9
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EcfgSqBqkjqRDGDNTU6KlIMH4oyyDOB8PDyr4kgAnQ8=;
        b=KLv9bKHDiSnwrZuRRb4L4XylvI1vMBoNvk0lVNYmu6Zzy0ZtcDONWab3IzufbEQ5gf
         wsSlCnOa11qkrSKqUGLX3BQPVlzapu9wAKJKN8J8oFPR773Wihdmz5BkaOtRf47qfKYf
         W5RF67oFc7A4jCEic2HX9vCfd+FfR/X3AORFwJTlagwjONWIR0a8aeo2my5gT6xf+TiG
         sa8rYOLrm09r0YRUk9Fdhl3jZswlBoK+q/90LHIpy4UqAnC3p7+/r5JHhZTi+fYhyL7x
         ekXd87jbZCNSIWtm+iL1a2GDkTlapZfERIBAT+IQMlS1IsKDEHG/Q15J15PJvmk6CWQd
         AAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EcfgSqBqkjqRDGDNTU6KlIMH4oyyDOB8PDyr4kgAnQ8=;
        b=AK+45+C065lgbb3lOO/9Ow5i1FZryY31C643MRuNDc8PPgjJPfoB5ffb3eXxHohFns
         SKbjtM6dDAP5pBbDYWNBsy7ADrf6AI3i21xcTxYf/RusHXmw/e/5Zy6ksVT0yxeAWpML
         bzM7JChqhemDNbltCPYqX2IlR0gQZoe7Zr7iMGPurMuR5meKOU86ddyVf/ZYKVhuEvJX
         Jg1W3dgVHgKmvzA8NoiAMTPUTSCXFkyd2s5eSuF8vMldjf6S/QygaHWkUplnkoxIZg2g
         VF7e97evf/0mVHnza34oPf2TgOE4ccTszPEDZAjzeSoYb9hL5aYKp+6g5AFo72iipAJU
         KmGQ==
X-Gm-Message-State: AOAM533rvmapWzupnDfCQ6PkQ0PzPht1dvnfS88BqTyxu9zhn2DkvNZH
        BX/YAnjuH8FuNUOQM2TSIUUEzlXqbUcHqQ==
X-Google-Smtp-Source: ABdhPJy7HlJ+fP18mHSd5PGzETGjEWu6Ib3VVcF2exhNYOfTyY/G/i8GeE7xvWthKzWebrWA2B9hbZSyDZwgNw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP
 id t16-20020a17090ae51000b001d9ee239fa1mr149534pjy.0.1651098342527; Wed, 27
 Apr 2022 15:25:42 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:25:40 -0700
In-Reply-To: <xmqqtuagvq4n.fsf@gitster.g>
Message-Id: <kl6la6c6p3iz.fsf@chooglen-macbookpro.roam.corp.google.com>
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
