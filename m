Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D338EC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B393161056
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhHTATs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbhHTATl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:19:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C9C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:19:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so12644491pjr.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0XEW25HwDvenepBV4Jm+RajVUef/3BkCMeYQfTnjMu4=;
        b=fL6R1hDBUFe8Oge2UkkMB1HK5uiADyp8d0jkxLqwpWqbqqlsimtNnzCYw2kFUsR7P0
         v9xjQqf9+weJcvvjnC0GD5SLn4QG02VbKupgAWasTDt3eE7b0+Dj/8K3TjP48nB6x+Pa
         KynI8NQpZLMSmhHPlaNuEDBfh9+zrYJaDgk2LddsTAFCtIpOTKXWoRH04/kviA4zQ+Gz
         ry/NGMfxpoO2CAWzMJBhR4FJ3tvYu5LhFeWhRR/ZcV0LnCO7cY9M24NSozrTkFqRc3Ce
         5Z87HFsuq8R7oRr8U2w5o5SsytBW0x6WAao/sW83phHF6CB7e1jU553LiHIIu1SOW1+k
         lUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0XEW25HwDvenepBV4Jm+RajVUef/3BkCMeYQfTnjMu4=;
        b=bysLJtt/t7zSb1LSmOy+G+uYcOh3tvpnQsI8j7PCv4/vo+trqduWRcy1akiM6JGRIH
         EYsJAzd8DFkAHznMKIddlqvYfVEIN1FSW+dDBxz/6IFZRJJOO5E/FM6Pklyx+nkWqNnG
         7C5VsoktPtVnF9SnFBxyVmDFJ4FMnQWL7TwceK+d0JwHtydWOaAtEIpTHR24nVJ508sW
         Yw1m6YvC/tWldSCY25WrI8XsAV0d9Jad8t4kxxvKM922v5unB9TOCbk0F95EyLroV8Ib
         TGo48BJLZ5sx+qvTGmJelc7JYcAw9hSEyK9uVYSOovvYjTsrUv9FTpk3ivbhqcy8tT4t
         PANQ==
X-Gm-Message-State: AOAM533b2T+H6znUk6Pgtp34uWA+u8S7fLW646oRmxZJFGBvOgJJaemo
        zNpLtpad1mw+w/lr5XvP7E1FoQAyUhOjr0MVaYA6lA==
X-Google-Smtp-Source: ABdhPJxtWNoqI8qOtFRroAAUMaziRNsMxP+nVHCtTDpDO6PUYww8AHBsAKsaRjD6uEkFN1xV/NpFLw==
X-Received: by 2002:a17:90a:4481:: with SMTP id t1mr1565792pjg.109.1629418744234;
        Thu, 19 Aug 2021 17:19:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id t15sm5559681pgi.80.2021.08.19.17.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:19:03 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:18:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 29/36] hook tests: use a modern style for "pre-push"
 tests
Message-ID: <YR7071AlYm4vsvxG@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-29.36-2c961be94b4-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-29.36-2c961be94b4-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:55PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Indent the here-docs and use "test_cmp" instead of "diff" in tests
> added in ec55559f937 (push: Add support for pre-push hooks,
> 2013-01-13). Let's also use the more typical "expect" instead of
> "expected" to be consistent with the rest of the test file.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5571-pre-push-hook.sh | 71 ++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
> index d2857a6fbc0..6d0d5b854ea 100755
> --- a/t/t5571-pre-push-hook.sh
> +++ b/t/t5571-pre-push-hook.sh
> @@ -61,15 +61,15 @@ echo "$2" >>actual
>  cat >>actual
>  EOF
>  
> -cat >expected <<EOF
> -parent1
> -repo1
> -refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
> -EOF
> -
>  test_expect_success 'push with hook' '
> +	cat >expected <<-EOF &&
> +	parent1
> +	repo1
> +	refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
> +	EOF
> +
>  	git push parent1 main:foreign &&
> -	diff expected actual
> +	test_cmp expected actual

Your commit message tells me you're getting rid of 'expected', but here
it is. Should that just be 'expect'?

Otherwise it looks fine.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
