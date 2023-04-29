Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C54BC77B7C
	for <git@archiver.kernel.org>; Sat, 29 Apr 2023 17:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjD2RfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD2RfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 13:35:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635A0199B
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 10:35:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-953343581a4so150075466b.3
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682789701; x=1685381701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkat19OGt28Oi92ID9T5P09oAjj1TehdWU0WzIj7I24=;
        b=rALv3CWtyqqSyp/IKMoV2V8iGTkKuQ5QciuqmzUvJqGKK7rtsXP+BXe2pikeLMkfvW
         /YslN82Y2CxMUPZgpqgcx3nHn8n6ENdPTANT9bPIFdiL6zZoFRHcrAUsnyIO2+gCCZvL
         hDLPBuamqvtpc8H1bp15w4tPcrALvyOPZDvbIdLjBQg4gJk6DKnvf6WdOjnWnf0UGxI6
         D3qXaIxzFffdEZP/weRFnHHAvJNLN7mZFsdeE3Me3rTB31MlPne2GKg4xmUwBWwyzgVc
         HKGdkWXCEqxgzHmw69Cl7L7FF5SYoeZQKO4fCfYS7kbn+L4gVZMOTaOmqsJCDZlOFrpX
         +KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682789701; x=1685381701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkat19OGt28Oi92ID9T5P09oAjj1TehdWU0WzIj7I24=;
        b=WTbFht2yROQUR67XJU8sx7x2/ZQwAIGZBdZ4wo+w+wPhtz5bxx3mq34od8Ab3creM4
         5Xow40Ai/wJDuGKFvpvhXWoY1eh4sNaV09eF0LLPoE4jfRmXfFEtq2XvzmM2EUP6CPW/
         GugznUkv/+Lax10J66YEjGh6ko2CLH0oQg2eUaCRvUnxWO6VTPcO7FQS8YxibtlFzheb
         tvyVN0/Y8bv7UsuBmRGsDEWyX0UddNRKeLBIXK8DG55+88FFZ26GBQjRWJBKTA/oORwE
         LndvHwUM+erT12Cwa866+k36YpO5KsA7DDNtr7mjX+4shqAHOdUsxilru7e0qPFBSXVX
         Oi1A==
X-Gm-Message-State: AC+VfDw3ClocLMQLbfD3DMRMEkJwCrw846PUULt4ISq53equRKXCZxDI
        jS4OaOur05DiDkHDU/x1ltYLeOkBThI=
X-Google-Smtp-Source: ACHHUZ4CpqtPmtfZqVdRfkGOX/IBLXs7f+gXzDWt5cMFLLDcK6K6RXoagE3Dko9OwizI0aIWEXVuyQ==
X-Received: by 2002:a17:907:8a01:b0:8e1:12b6:a8fc with SMTP id sc1-20020a1709078a0100b008e112b6a8fcmr8426635ejc.4.1682789700626;
        Sat, 29 Apr 2023 10:35:00 -0700 (PDT)
Received: from localhost (84-236-109-252.pool.digikabel.hu. [84.236.109.252])
        by smtp.gmail.com with ESMTPSA id gx11-20020a1709068a4b00b0094f225c0cd3sm12669336ejc.86.2023.04.29.10.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 10:35:00 -0700 (PDT)
Date:   Sat, 29 Apr 2023 19:34:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/8] fetch: split out tests for output format
Message-ID: <20230429173448.GD3271@szeder.dev>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
 <0d0d50d14c557f8313747e7d0e104c2c0819dab9.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d0d50d14c557f8313747e7d0e104c2c0819dab9.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 01:13:08PM +0200, Patrick Steinhardt wrote:
> We're about to introduce a new porcelain mode for the output of
> git-fetch(1). As part of that we'll be introducing a set of new tests
> that only relate to the output of this command.
> 
> Split out tests that exercise the output format of git-fetch(1) so that
> it becomes easier to verify this functionality as a standalone unit. As
> the tests assume that the default branch is called "main" we set up the
> corresponding GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment variable
> accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t5510-fetch.sh        | 53 ----------------------------------
>  t/t5574-fetch-output.sh | 63 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 53 deletions(-)
>  create mode 100755 t/t5574-fetch-output.sh


> diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> new file mode 100755
> index 0000000000..f91b654d38
> --- /dev/null
> +++ b/t/t5574-fetch-output.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +
> +test_description='git fetch output format'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'fetch aligned output' '
> +	git clone . full-output &&
> +	test_commit looooooooooooong-tag &&
> +	(
> +		cd full-output &&
> +		git -c fetch.output=full fetch origin >actual 2>&1 &&

Why is that 2>&1 redirection used here?
If the output the test case is interested in goes to the command's
standard output, then it's unnecessary.  However, if it goes to
standard error, then why is standard output redirected as well?

I understand that this patch just moves existing test cases around
as-is, so this is not something you introduced, but I point it out
here, because later patches of this series add several new test cases
following this anti-pattern.

Since this series creates a new test script, perhaps this might be the
right time to clean this up.

> +		grep -e "->" actual | cut -c 22- >../actual
> +	) &&
> +	cat >expect <<-\EOF &&
> +	main                 -> origin/main
> +	looooooooooooong-tag -> looooooooooooong-tag
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'fetch compact output' '
> +	git clone . compact &&
> +	test_commit extraaa &&
> +	(
> +		cd compact &&
> +		git -c fetch.output=compact fetch origin >actual 2>&1 &&
> +		grep -e "->" actual | cut -c 22- >../actual
> +	) &&
> +	cat >expect <<-\EOF &&
> +	main       -> origin/*
> +	extraaa    -> *
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--no-show-forced-updates' '
> +	mkdir forced-updates &&
> +	(
> +		cd forced-updates &&
> +		git init &&
> +		test_commit 1 &&
> +		test_commit 2
> +	) &&
> +	git clone forced-updates forced-update-clone &&
> +	git clone forced-updates no-forced-update-clone &&
> +	git -C forced-updates reset --hard HEAD~1 &&
> +	(
> +		cd forced-update-clone &&
> +		git fetch --show-forced-updates origin 2>output &&

Oh, look, there are some good examples to follow here as well :)

> +		test_i18ngrep "(forced update)" output
> +	) &&
> +	(
> +		cd no-forced-update-clone &&
> +		git fetch --no-show-forced-updates origin 2>output &&
> +		test_i18ngrep ! "(forced update)" output
> +	)
> +'
> +
> +test_done
> -- 
> 2.40.1
> 


