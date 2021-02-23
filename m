Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01CDC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F4964E4B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBWHdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhBWHdE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 02:33:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4AC06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:32:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id f8so9305089plg.5
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdcjXEd3o5pa6fQsD6fMbt7l+mOm8goIbVo/WYuKwu4=;
        b=JwHBzPkJO7jqLhmAT5gH4Ei9MIJA/7QoSp/dDTB9m0tcdEhyA4HMSYAx1NQymQ3Bbz
         Xs+wb9togVOl6jStDpk09JTdT7+Qq6k8Vk6UmrfrJYeZbXKk2VR/SuHay+xwcghUrXyv
         ygRaRlaFcriGhA5k8u05mCZruFqwuQNLbEl93mP6Kl6QHf2tq+04A/tvgfm+72iqwo7y
         dy/xrvTBmiJZnJdNKgHOSeXVBmfOVdtjWe+amWBRwpItI36iWuDcdHgUT+UlrJSsU+ov
         6INvVIqrR1IOdXo7VqjAq0WDO+y9BtRxLlvV+suBbL0qcmLqsaciO5QmUI1+3p2LVkmw
         v7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdcjXEd3o5pa6fQsD6fMbt7l+mOm8goIbVo/WYuKwu4=;
        b=X3qAhXX6vKNQKrsr89ECXoGJZCsUhjXVC64KviZXRLu7jL1isNJWJjgKU+G7xCO5Em
         fXboGShptJmETlwsLRs2hlburvAdVFHtFoTtSkD5NqCwO0idkWi3UoBzXPySMwK4dN3z
         ykADuclRrynKmyOaazfoF+l62BhvjJXfh3WbOi7u3SDOz49rwyebWtrqMpPn4c0y37Dy
         yw/OQ6HoapUJFIVBdZwdLl2TEEtuFgc3HD8uTfruJcWSSXEkNKGe6MinRj4Io1t+wFZ/
         E0VC51qLS3po/v92c0HR8QumGqOm0JQvGB3+EfUUp/SpU4EypooHH4NZgDDXLQ9diSGu
         2K+w==
X-Gm-Message-State: AOAM530MDSlz7bZPOdYLN92AG51XOreV8uz6VbBjdsB71+FgOMt/1vYm
        z7ojU9zxYXctg7yLfzmye7KoJpEsaRQ=
X-Google-Smtp-Source: ABdhPJxPNTqb1bu36EcHgaVzc+HaZSOA61LlyOSatYft/wR8iH9zUG3z/Bn/bPqo7JO7AwdMI+oJQw==
X-Received: by 2002:a17:902:f20c:b029:e3:cfa7:e2ff with SMTP id m12-20020a170902f20cb02900e3cfa7e2ffmr17147682plc.78.1614065543332;
        Mon, 22 Feb 2021 23:32:23 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id oa10sm1751828pjb.45.2021.02.22.23.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:32:22 -0800 (PST)
Date:   Mon, 22 Feb 2021 23:32:20 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3] rebase: add a config option for --no-fork-point
Message-ID: <YDSvhEBh8YeCblpa@generichostname>
References: <20210223071840.44267-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223071840.44267-1-alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Tue, Feb 23, 2021 at 12:18:40AM -0700, Alex Henrie wrote:
> @@ -77,4 +81,35 @@ test_expect_success 'git rebase --fork-point with ambigous refname' '
>  	test_must_fail git rebase --fork-point --onto D one
>  '
>  
> +test_expect_success '--fork-point and --root both given' '
> +	test_must_fail git rebase --fork-point --root 2>err &&
> +	test_i18ngrep "cannot combine" err
> +'
> +
> +test_expect_success 'rebase.forkPoint set to false' '
> +	test_config rebase.forkPoint false &&
> +	do_test_rebase "G F C E D B A"
> +'
> +
> +test_expect_success 'rebase.forkPoint set to false and then to true' '
> +	test_config_global rebase.forkPoint false &&
> +	test_config rebase.forkPoint true &&
> +	do_test_rebase "G F E D B A"
> +'

I don't think this test is quite necessary. In other parts of the code,
we've already tested that local configs have priority over global
configs. We can assume that config machinery works so we don't need to
test it here.

Thanks,
Denton

> +
> +test_expect_success 'rebase.forkPoint set to false and command line says --fork-point' '
> +	test_config rebase.forkPoint false &&
> +	do_test_rebase "G F E D B A" --fork-point
> +'
> +
> +test_expect_success 'rebase.forkPoint set to true and command line says --no-fork-point' '
> +	test_config rebase.forkPoint true &&
> +	do_test_rebase "G F C E D B A" --no-fork-point
> +'
> +
> +test_expect_success 'rebase.forkPoint set to true and --root given' '
> +	test_config rebase.forkPoint true &&
> +	git rebase --root
> +'
> +
>  test_done
> -- 
> 2.30.1
> 
