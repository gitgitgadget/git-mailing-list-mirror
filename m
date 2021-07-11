Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F6DC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB25D61107
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhGKRLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhGKRLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 13:11:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8582BC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 10:08:48 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso15868456oty.12
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sILOiqs+VADI34G508ybotp4S3eCxA7gLbpnbEmj2ys=;
        b=uDUFjZkCJMjgsDPW7brn7wMz0h40JfLze/JqviDLNe6gY4pakLUisQprgxXN1/UZrQ
         hv57Gk7Ov31MOLv6frk9+ed5ZMuS9P+hHO1NgOLe0k2KzxVaUjOnOwClsaQN6k0oBmo5
         GlvyyLD6lTituuN8SNpwSw3Nl/FkgnPYESTHcCvQlVvniFJqdSEfv8UsWFneEIcVmWIC
         2QaKOQGB6oF5EZ1KMXnXM+pKR3KAR9ihAmPsuxQNsseSiNjnp7C4u3rvN3NBJhMinHG3
         fhYEtLEWDkLZHP71tT0UG3AUhNJli+b9KTlY4mpM3DGuKRkQNu1DOn8BQuRsbYLlYMGC
         iaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sILOiqs+VADI34G508ybotp4S3eCxA7gLbpnbEmj2ys=;
        b=cjTnMFRXyYiKhAwgaYdM3ztjkf09Jq5w1u5Ivq8R63qVThDMpKJWxwW68YET12tCSg
         vYp6xgA/nGouosxO6sTKiaBNqAEvwc4y3Ch43nY9fwN17bXBy+RO5/BNrmy2I+5HI6Qf
         /Mzbq+w5UduWe/g2XGiizs0To32bIcqtkOgXQl5JqPQMmAFiH9ULICsAQdm+cGG2EXi5
         p5EVGfEWPWPBbKypU+olgWI2SzjB2N4c43I06L1hDZYf4RvbZp8VDDaVgjUqj+dWaVPP
         HIfepVGX0ouyE8lARwqe5YzKaIhOEDzjSlGk2D18ueC8moDSweARmJDEFgVYfYTfzyw5
         BSYw==
X-Gm-Message-State: AOAM533Q/pXrKV3dL7tWXHycG3VsWThK1hF7qR9jVBt7RJ//1Knz+5Vx
        311dRfrsovpLkp4wV3EtJQM=
X-Google-Smtp-Source: ABdhPJy81BQAGL2qQdNRgURWLvtptSgu/s40aH/9Rcok8r5jmoUKDVcF5Zm5Z1Nh3DflAjFjdYMexw==
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr36113959ote.144.1626023327923;
        Sun, 11 Jul 2021 10:08:47 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id g20sm2088982oos.13.2021.07.11.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:08:47 -0700 (PDT)
Date:   Sun, 11 Jul 2021 12:08:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, avarab@gmail.com, gitster@pobox.com,
        felipe.contreras@gmail.com, newren@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Message-ID: <60eb259e1a75d_974bf20895@natae.notmuch>
In-Reply-To: <20210711012604.947321-1-alexhenrie24@gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
Subject: RE: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> The warning about pulling without specifying how to reconcile divergent
> branches says that after setting pull.rebase to true, --ff-only can
> still be passed on the command line to require a fast-forward. Make that
> actually work.

I don't know where that is being said, but it's wrong: --ff-only is
meant for merge only.

> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1046,9 +1046,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
>  
> -	if (rebase_unspecified && !opt_ff && !can_ff) {
> -		if (opt_verbosity >= 0)
> -			show_advice_pull_non_ff();
> +	if (!can_ff) {
> +		if (opt_ff) {
> +			if (!strcmp(opt_ff, "--ff-only"))
> +				die_ff_impossible();

As I've mentioned multiple times already, this is wrong.

The advice clearly says:

  You can also pass --rebase, --no-rebase, or --ff-only on the command
  line to override the configured default per invocation.

With your patch now this is even less true:

  git -c pull.ff=only pull --rebase

> +		} else {
> +			if (rebase_unspecified && opt_verbosity >= 0)
> +				show_advice_pull_non_ff();
> +		}
>  	}
>  
>  	if (opt_rebase) {
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 52e8ccc933..b5a09a60f9 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -183,6 +183,30 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
>  	test_must_fail git pull . c3
>  '

Can you add this test [1] so I don't have to explain the same thing over
and over?

  test_expect_success 'pull allows non-fast-forward with "only" in pull.ff if --rebase' '
    git reset --hard c1 &&
    test_config pull.ff only &&
    git pull --rebase . c3
  '

Cheers.

> +test_expect_success 'pull prevents non-fast-forward with pull.ff=only and pull.rebase=true' '
> +	git reset --hard c1 &&
> +	test_config pull.ff only &&
> +	test_config pull.rebase true &&
> +	test_must_fail git pull . c3
> +'
> +
> +test_expect_success 'pull prevents non-fast-forward with pull.ff=only and pull.rebase=false' '
> +	git reset --hard c1 &&
> +	test_config pull.ff only &&
> +	test_config pull.rebase false &&
> +	test_must_fail git pull . c3
> +'
> +
> +test_expect_success 'pull prevents non-fast-forward with --rebase --ff-only' '
> +	git reset --hard c1 &&
> +	test_must_fail git pull --rebase --ff-only . c3
> +'
> +
> +test_expect_success 'pull prevents non-fast-forward with --no-rebase --ff-only' '
> +	git reset --hard c1 &&
> +	test_must_fail git pull --no-rebase --ff-only . c3
> +'
> +
>  test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
>  	git reset --hard c1 &&
>  	git config pull.twohead ours &&
> -- 

[1] https://lore.kernel.org/git/20210711170703.651081-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
