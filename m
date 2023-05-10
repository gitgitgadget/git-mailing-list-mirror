Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA249C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 04:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjEJD7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjEJD7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 23:59:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419B6188
        for <git@vger.kernel.org>; Tue,  9 May 2023 20:56:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64389a44895so5478111b3a.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 20:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683690992; x=1686282992;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qCNp/Ir07L2M7Hy0r1iMXCYwSQ5C+BqMg3jn+JdWZMY=;
        b=aKv2H+vU7PtU4IKv9F6mPP5DtVJ0b/ERFjRvFCN9xK3g9DKyrycPvcw+ZvzArGO1TL
         tAtwg1CsXsurc9CaNRIoFz4EvTmbVs6w+XxVv2Ryot8+foX/mXvCWBZeUE8UQ6QPX62N
         OnNxb91kapXvVb/E3VGrZU9jOKuXY4r+mYDzkuHESq2E6XlWgueIlVBb42eu+mSXIymE
         g1RPRaF/BYcZdJ9OiT1AZrAb4VX2sEVQUBfdmfDH+Faguw7NSUgtA24qMPOweUbi/OPg
         BOQDRJcJVVrh3rzAQ580YBSVE+ihENPk3LNn4ZYk3jcWvfh/m164CV6eK+TKJx/EM8Xb
         ATTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683690992; x=1686282992;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCNp/Ir07L2M7Hy0r1iMXCYwSQ5C+BqMg3jn+JdWZMY=;
        b=RynkMUJm1M5b7mPqZPnmvIS2CZD2HRD5ovDO+nYCrcMSTyfDwY8D3CCicnt03BTD7B
         M5EEXiQze6RhbXDzrzBbFRE77I5cEkJQ+v7RAeoU+D7tkPy+FLqpkpE0PuL+RpB/WfDB
         4kRXkmxhBEIYEJzGs+OETwGGdnI2lDoZCnaLB14opr8RtaNegRGwVJBKVTBMP3LDwrhE
         YNlFGeYo2ERwwzAcM4vxXSzwyq2/1qEgewKH3k6t9TRfIjAU8B2CnAjIZKrXXAGnslxn
         igfZeHo8koHV9sN7SdV0MRf0m62EkvMx934Kz1BnrOS4Bj53mJJjmLUclqX4clEGTEDC
         MctA==
X-Gm-Message-State: AC+VfDyJvZfG3zeuxhFoW0c//A/jrmLveXs7afiHjBtJ31AO8PA2k2lI
        C3yeWrh5e1NajYglfOrkCFI=
X-Google-Smtp-Source: ACHHUZ5OFyz7tWZlgxwOKvbrc1XWmvl/x89IWDzDACCuDOGz3yi0GClYj05pXKum8wihnLBY6p11Ng==
X-Received: by 2002:a05:6a00:a8a:b0:63f:158a:6e7b with SMTP id b10-20020a056a000a8a00b0063f158a6e7bmr23599901pfl.6.1683690992067;
        Tue, 09 May 2023 20:56:32 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b0063b8ce0e860sm2571608pff.21.2023.05.09.20.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:56:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] test: rev-parse-upstream: add missing cmp
References: <20230509000246.1760327-1-felipe.contreras@gmail.com>
Date:   Tue, 09 May 2023 20:56:31 -0700
Message-ID: <xmqqpm78zvo0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It seems pretty clear 5236fce6b4 (t1507: stop losing return codes of git
> commands, 2019-12-20) missed a test_cmp.
>
> Cc: Denton Liu <liu.denton@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t1507-rev-parse-upstream.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
> index d94c72c672..cb9ef7e329 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -97,7 +97,8 @@ test_expect_success 'my-side@{u} resolves to correct commit' '
>  	commit_subject my-side >actual &&
>  	test_cmp expect actual &&
>  	echo 5 >expect &&
> -	commit_subject my-side@{u} >actual
> +	commit_subject my-side@{u} >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'not-tracking@{u} fails' '

Good eyes.

a93cbe8d (t1507: assert output of rev-parse, 2023-03-18) and wanted
to do the same to this script, and the series that contains the
commit wanted to do the same to many other test scripts, but it
seems to have missed this one.

Will queue (on top of a93cbe8d, naturally).

Thanks.
