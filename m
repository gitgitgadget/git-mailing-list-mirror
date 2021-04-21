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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF1C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F206E613F0
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhDUGKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhDUGKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:10:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC9C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:09:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id x12so40987056ejc.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rJZ+dXIOqMiydemXnAg45cxj6YT7EaL83Cs3b3FHxxU=;
        b=QBON47143+FTVbbwaSLs8agBAyx7KZUcY4dvns7fdVMCEtJmf2G4gSWeYpIu9SJo32
         GsnQqUiq+GJ1/HbTj6EYKeTHTjqt7WA2m5qRUEo4pHLLxDihd7aopcWEfDpyFljWhnzs
         6xtcW7aPkDEH1A69hRYiGSMfGpyUzXUEuKv/biXTFLAyW0cdKAvAfBzCgOn7Ks/UInQl
         nv6QMqjzcJh6uStsCTRsP4uabgbu1+3Ru98+WpwYh4STvCQq9ioBMxrqbqh9D1HMO7Wx
         ySiC0HC9pHDHYLPCSGNzjAwGvde2OWhLuZysvgcidn/eum9r9KOhpUTi2qcmFfjkBnMj
         kNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rJZ+dXIOqMiydemXnAg45cxj6YT7EaL83Cs3b3FHxxU=;
        b=IYqZmrW7gxriIM/nfxfOHZlrx+FTcPP34hvIfWjpeHXqMrv8zzFLJ3DFFM9k7y8Os+
         +j+6jQx9UmusBSLjFifKS7Exxp/K4QOo5i6Y6sHon3IBi6VBli6cTuOEImdcbs9eq4HU
         M+jAJDsZTU7l4QF/i4mZJdGhC0zS9S3tirE+MVT5a6gtGl+xfPPZ+4QOeg2DmH8E5rBm
         4IdHkZE/ATbkDnA13pjwiIyzmUPhCvsHPvT1GxXISqeQ2r/H1BOVTfQvtZcqsviMhrpI
         keucS55VHHHaUUGZHYYH3dtzy76Pu6z8q3PUAGsF0rG97adC/1gCW9Onp/lw1yYf95eY
         iWag==
X-Gm-Message-State: AOAM530V1DNB6jbG3ahADadHZiGDF7temVSMdq75BHycNstWeptbR24Z
        JL1m7GTGQGk8iHyCb/BUDizgij+Miyc3vQ==
X-Google-Smtp-Source: ABdhPJw11WgW7o34X48YYO7n0FWQLaLoMAz8titXQ8B9rlU7BIU3Myi7QiTelq5UBuP8uFpm5Egc9A==
X-Received: by 2002:a17:907:72cc:: with SMTP id du12mr18720250ejc.436.1618985369243;
        Tue, 20 Apr 2021 23:09:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c19sm1746246edu.20.2021.04.20.23.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 23:09:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 08:09:28 +0200
Message-ID: <871rb45ftz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1401-symbolic-ref.sh | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index a4ebb0b65fec..fd5980d3fb40 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -7,18 +7,13 @@ test_description='basic symbolic-ref tests'
>  # the git repo, meaning that further tests will operate on
>  # the surrounding git repo instead of the trash directory.
>  reset_to_sane() {
> -	echo ref: refs/heads/foo >.git/HEAD
> +	git --git-dir .git symbolic-ref HEAD refs/heads/foo

Isn't that "--git-dir .git" entirely redundant?

>  }
>  
> -test_expect_success 'symbolic-ref writes HEAD' '
> -	git symbolic-ref HEAD refs/heads/foo &&
> -	echo ref: refs/heads/foo >expect &&
> -	test_cmp expect .git/HEAD
> -'
> -
> -test_expect_success 'symbolic-ref reads HEAD' '
> -	echo refs/heads/foo >expect &&
> -	git symbolic-ref HEAD >actual &&
> +test_expect_success 'symbolic-ref read/write roundtrip' '
> +	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
> +	echo refs/heads/read-write-roundtrip > expect &&

I see SZEDER covered some nits already :)
