Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA25C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D786E20707
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RosT/xG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438272AbgE2BBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 21:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438243AbgE2BBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 21:01:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197BC08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:01:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so474379pga.6
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnujOOgcbKGuc4BWH3tNo/i8/LcwdSQz06cQpAE6ivo=;
        b=RosT/xG9eLfRwuiN3A8araDjC1eeljAIiOu3VITNSuX2x3zFbFcGSziRa1kdBWjOcR
         3lWN4uWkIoU5MSbjR1Ec0opE/hZsZWlMUnXI4fdXWpn7zCt1buWml5qTSyc5EQoOJtqD
         o8Vd8bwzmW3HeQnerF0C8HYbnty1AKnE7fgaIXnWb7ikdjfi73syGGIOonMkRGqYkRo3
         awJYGiTwqNtjCA4FMQsecfmQOfOVgddmQnAvU6xJJAm8cCC36scSpJFFo1NXLSMnW2GO
         Tc2iB/B+QxKtikynWDKtoa0Ib6VJNsMZ1JFyoYzhgApuqHf3ANL70+hEwaM2duq9+5rr
         5GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnujOOgcbKGuc4BWH3tNo/i8/LcwdSQz06cQpAE6ivo=;
        b=l80D2prODVfszZ9mTNpNKz6PjAbBXjSqwbWzxpfcWSJqLDtgWGYfHjUYNJWg5U29re
         8awrMKK5/QW2CYcoT31csK8d8Sx7QzUytiUrH4X3sZJxr3H7Y//eKCa8tsYDdzbDX1Hm
         uhjnAckMjJJR+Tx8S7e3BSgz6GeTCq0vQb6k1NhjRDEOtrhemcAK2EXldQ5w82GSl/6H
         hEivAGaZD08U77cMjgg4hrko0oZJqFpiCV6rv2r1ubUu02pRgFxo6mEEPkBom9A1Pj0T
         PpiKU3dobvTkwuTt52U0twL5kEqq2yr32ttu32BAP+RYENUEhZLAVLPIeHCB4v1obA2Z
         wDVQ==
X-Gm-Message-State: AOAM530ySqDnPOcnEXw9zCgrKPT1xzTkaJEewgHD8XODAUjViZc32ugb
        BiVEFgW/DIlr7lg8md8+k08=
X-Google-Smtp-Source: ABdhPJyH+80IYkXPVBiMdAp/QfpVkVruIM8JseEof3XklKtTZh0KWnwAZyNEMOpSQ37MxeH59c+NBQ==
X-Received: by 2002:a65:4489:: with SMTP id l9mr5843194pgq.223.1590714082941;
        Thu, 28 May 2020 18:01:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c24sm5671070pfo.124.2020.05.28.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 18:01:21 -0700 (PDT)
Date:   Thu, 28 May 2020 18:01:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, iankaz@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4] fetch: allow adding a filter after initial clone.
Message-ID: <20200529010119.GE114915@google.com>
References: <20200528025359.20931-2-delphij@google.com>
 <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com>
 <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com>
 <20200529000432.146618-1-delphij@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529000432.146618-1-delphij@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Jonathan Tan, partial clone expert)
Xin Li wrote:

> Subject: fetch: allow adding a filter after initial clone.

nit: should be no period at the end of the subject line

> Signed-off-by: Xin Li <delphij@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Let's see whether I still stand by that. ;-)

[...]
> --- a/setup.c
> +++ b/setup.c
> @@ -13,6 +13,9 @@ static int work_tree_config_is_bogus;
>  static struct startup_info the_startup_info;
>  struct startup_info *startup_info = &the_startup_info;
>  
> +static int verify_repository_format_eligibility(const struct repository_format *,
> +    struct strbuf *, int);

Odd wrapping, but after Junio's suggestion this goes away.

[...]
> +		warning("unable to upgrade repository format from %d to %d: %s",
> +		    repo_fmt.version, target_version, err.buf);

Same wrapping nit: this should use a tab to line up right after the
parenthesis (Git uses 8-space tabs).

[...]
> --- a/t/t1090-sparse-checkout-scope.sh
> +++ b/t/t1090-sparse-checkout-scope.sh
> @@ -63,7 +63,6 @@ test_expect_success 'in partial clone, sparse checkout only fetches needed blobs
>  	git -C server commit -m message &&
>  
>  	test_config -C client core.sparsecheckout 1 &&
> -	test_config -C client extensions.partialclone origin &&

Nice.

>  	echo "!/*" >client/.git/info/sparse-checkout &&
>  	echo "/a" >>client/.git/info/sparse-checkout &&
>  	git -C client fetch --filter=blob:none origin &&
> diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
> index 286121d8de..9536d10919 100755
> --- a/t/t2404-worktree-config.sh
> +++ b/t/t2404-worktree-config.sh
> @@ -23,8 +23,10 @@ test_expect_success 'config --worktree without extension' '
>  '
>  
>  test_expect_success 'enable worktreeConfig extension' '
> +	git config core.repositoryformatversion 1 &&
>  	git config extensions.worktreeConfig true &&

Yes, makes sense.  Does this patch need it, or could this go in a
separate patch?

> -	test_cmp_config true extensions.worktreeConfig
> +	test_cmp_config true extensions.worktreeConfig &&
> +	test_cmp_config 1 core.repositoryformatversion

This (both the existing code and the modified version) is strange: we
just set the config, so why are we checking it?

[...]
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -999,7 +999,6 @@ fetch_filter_blob_limit_zero () {
>  	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
>  
>  	git clone "$URL" client &&
> -	test_config -C client extensions.partialclone origin &&
>  

Nice.

[...]
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -348,7 +348,6 @@ test_expect_success 'partial fetch' '
>  	rm -rf client "$(pwd)/trace" &&
>  	git init client &&
>  	SERVER="file://$(pwd)/server" &&
> -	test_config -C client extensions.partialClone "$SERVER" &&
>  
>  	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
>  		fetch --filter=blob:none "$SERVER" master:refs/heads/other &&

This test is a bit unusual, since it's fetching by URL instead of from
a remote.  Looks like it comes from

	commit ba95710a3bdcb2a80495b1d93a0e482dd69905e1
	Author: Jonathan Tan <jonathantanmy@google.com>
	Date:   Thu May 3 16:46:56 2018 -0700

	    {fetch,upload}-pack: support filter in protocol v2

Jonathan, thoughts about this one?  Is making it set
extensions.partialClone implicitly like the change above a good
change?

With the nits above and the bits Junio described addressed, this would
indeed be
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
