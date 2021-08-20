Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FBFC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8460160ED3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhHTAKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHTAKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:10:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD4C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:09:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x1so2376547plg.10
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2NAQM/CQCLYTXANU9ireuhD2ivEaLSnx/yEP4rO+FNM=;
        b=o0NTlizoFblsYY1OkWC/Al2rp4eSzk68VC+eqVKsGTsoNERCrHR9tmE3KX9C9TT80y
         17Dg5FxUSykX5j8gG+RYZtQIhtvQO+MpGsJRrG/8hDeNsVDAqBlHr597r5BNSpDpvbK7
         Wnxhi6v4XCRQXyqXXc6PNcExddlYmX831I1B8gY1+LRv4EE+rtCYKTdzACP/co0Wk4pE
         ZO2lbwMGDKQBxV9wk15a+tnqGjjdBbQ2xQ8Nxo1T1y8S8HT3ooT2E7Eu3mrPzL8HziM9
         LsQw48tr2tfvYQ6JtFtctgHLZ+QNcVkRj4C019plVzzMObtG6cRemYEe0OVOXxBCoH7a
         GMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2NAQM/CQCLYTXANU9ireuhD2ivEaLSnx/yEP4rO+FNM=;
        b=FQM6gtAS8mKOy5jzEb3Or4Ns9MWnCuBvzGFiU5+gs38WP7KBiWa1QdYJeQ6QE/YvTX
         uBv/60sm9VGjfB95MzqPNE6Iqz0ipmcdSoWZLy0XXZqf+sCuKGr3xJndwsZT10wJWrpr
         gPATQM+WOyIWCtKM4Gy7oo+5mJWMOeh+t4AaV+KNilWt2tv4trtczVrhgRXid3Fk34kX
         usUiSUXkJTbDEJau6VdzozXyLnJe1EYTC5F7gUmRPaXA4gKO4XFjTIlb+U3Rue4M3ZcX
         N9IOddVDeV3CKVWOx9Nscxm6EC2WXMC7u9kIomAqEWqCMZLITU6w9FM3QCIxZkn9VheM
         Lflg==
X-Gm-Message-State: AOAM532M9bRzm3El1ihYAc6ohx/WGIf098dQKMEN3lAigMqDUXSIy03H
        QFrUjkkX6aiEiiBgtUadgm/cZYUzQ9w17SmJCAhyLA==
X-Google-Smtp-Source: ABdhPJzuJBCHO2HG/Y0oUD9RDO9JF1rrGvkANcGy1wPybhfPWmQVzahcIcOlTMk5iLhfpGSe4kydmA==
X-Received: by 2002:a17:902:e04e:b029:12c:def4:56a3 with SMTP id x14-20020a170902e04eb029012cdef456a3mr13911657plx.76.1629418175451;
        Thu, 19 Aug 2021 17:09:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id c12sm4346136pfl.56.2021.08.19.17.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:09:34 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:09:28 -0700
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
Subject: Re: [PATCH v4 05/36] hook.c: add a hook_exists() wrapper and use it
 in bugreport.c
Message-ID: <YR7yuCAaQScM6zvD@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-05.36-3514e0c0251-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-05.36-3514e0c0251-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:31PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Add a boolean version of the find_hook() function for those callers
> who are only interested in checking whether the hook exists, not what
> the path to it is.

Seems fine.

> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/bugreport.c | 2 +-
>  hook.c              | 5 +++++
>  hook.h              | 5 +++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 596f079a7f9..941c8d5e270 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -82,7 +82,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(hook); i++)
> -		if (find_hook(hook[i]))
> +		if (hook_exists(hook[i]))
>  			strbuf_addf(hook_info, "%s\n", hook[i]);
>  }
>  
> diff --git a/hook.c b/hook.c
> index c4dbef1d0ef..97cd799a320 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -35,3 +35,8 @@ const char *find_hook(const char *name)
>  	}
>  	return path.buf;
>  }
> +
> +int hook_exists(const char *name)
> +{
> +	return !!find_hook(name);

Later on I'll change this to refer to the output of list_hooks()
instead.

> +}
> diff --git a/hook.h b/hook.h
> index 68624f16059..4c547ac15e5 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -8,4 +8,9 @@
>   */
>  const char *find_hook(const char *name);
>  
> +/*
> + * A boolean version of find_hook()
> + */
> +int hook_exists(const char *hookname);
> +
>  #endif
> -- 
> 2.33.0.rc0.595.ge31e012651d
> 
