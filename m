Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF0CC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0167060FE8
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhHTAGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTAGP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:06:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B73C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:05:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u15so4895574plg.13
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XBtWj99NKGklyb2Z1Ds2bR7s73eAR/NFN+iRU5tWNoE=;
        b=Euqh7aWe+xIMcariycrkCF3BDB819AhhrJDkMX6BnSWPCRMFAvw5nSO8UqAxdl9N02
         KiVxX1OLtDwvO04s370ru/k1tWjDh7mwaCRe8/zbl7phiiG4WSGQ7zxLBLe2VU9xkrDw
         FqZuq/hdVQPy0dhQ4rVWXI0Lom8hqz3OJdvgClESRHdyRQWlvnwBzbEImK/CkeKQqpZd
         cUJW8FZWO/zXOE5SiNlIKJzJ7UziGzLvR8kmJ9vD2EJYmrA7aEVhzm6d7oIvug+aeTUk
         6OFjKIlnGOsulS37uJXdP2Nu/XiV8r3WFnFkASp6bNVp+Dm39/r+M8klgi+rIRlN9XmH
         z/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XBtWj99NKGklyb2Z1Ds2bR7s73eAR/NFN+iRU5tWNoE=;
        b=h94XebMbjIQy7ShaO96AI4PEcnmPLLOEUTX8kpk3PScrONMzerfDpFQNbvKpk+ytze
         ssqCVDkR9F+JiFtkgFgM+Bt/1b+Dj6MYFTNew6TthLy/Wr6B0t0Jrr/k/9TN0hUCimAa
         +NJaoE5mfLl1cc6t8+eAnm/YaBcyDuxA4F0PQivLOGrvKBLVbLUlY7L4D14kJHa9G2+/
         54AhHfwYuU8F71IlYfNWUMrNb5Z/2rg+De26b4RaiYB7IsDUTXyh/zZ6q/XtigXsAin3
         IuaPpazHVSA0aBtvN8kAlyKdAZY2weWT08KlcNmqfRKvPMWR+64EDH381Td7RBfe3ayj
         kZrA==
X-Gm-Message-State: AOAM530H/vSDChW/HzXCNns5db0VVJhJPRsE18OvnAORzxUinQ2dyfH7
        i02A8QB6iZ8gTH2RvXCaWN4rlg==
X-Google-Smtp-Source: ABdhPJyazT/RgEkvupmUgZNI1VSZ5RfdaE5K8WTnoStOjWjiw9KKYINy+wbqQJvn/QoPc0g0Ril+tw==
X-Received: by 2002:a17:90b:3608:: with SMTP id ml8mr1556203pjb.22.1629417937986;
        Thu, 19 Aug 2021 17:05:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id a190sm2433633pfa.49.2021.08.19.17.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:05:37 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:05:29 -0700
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
Subject: Re: [PATCH v4 03/36] Makefile: remove an out-of-date comment
Message-ID: <YR7xyey0nWAImrqB@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-03.36-644b31fe281-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-03.36-644b31fe281-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:29PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> This comment added in dfea575017 (Makefile: lazily compute header
> dependencies, 2010-01-26) has been out of date since
> 92b88eba9f (Makefile: use `git ls-files` to list header files, if
> possible, 2019-03-04), when we did exactly what it tells us not to do
> and added $(GENERATED_H) to $(OBJECTS) dependencies.
> 
> The rest of it was also somewhere between inaccurate and outdated,
> since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
> it's not followed by a list of header files, that got moved earlier in
> the file into LIB_H in 60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H
> into LIB_H, 2012-07-06).
> 
> Let's just remove it entirely, to the extent that we have anything
> useful to say here the comment on the
> "USE_COMPUTED_HEADER_DEPENDENCIES" variable a few lines above this
> change does the job for us.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Makefile | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 89bf0dd7332..0a540dcd34e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2519,13 +2519,6 @@ ifneq ($(dep_files_present),)
>  include $(dep_files_present)
>  endif
>  else
> -# Dependencies on header files, for platforms that do not support
> -# the gcc -MMD option.
> -#
> -# Dependencies on automatically generated headers such as command-list.h
> -# should _not_ be included here, since they are necessary even when
> -# building an object for the first time.
> -
>  $(OBJECTS): $(LIB_H) $(GENERATED_H)
>  endif
>  
> -- 
> 2.33.0.rc0.595.ge31e012651d
> 
