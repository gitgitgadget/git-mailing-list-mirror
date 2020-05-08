Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CEC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 06:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5568021582
	for <git@archiver.kernel.org>; Fri,  8 May 2020 06:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAnCNctA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHGa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 02:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgEHGaZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 02:30:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A263AC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 23:30:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j2so153559qtr.12
        for <git@vger.kernel.org>; Thu, 07 May 2020 23:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jPiP/xl+C739FZ3LLyWqxvOCaoq/EBCCVKhnFlPZmKM=;
        b=UAnCNctAcHCAruNRF8NbxpsWVZxEvObiidhXVDyzCu4mdeTMTxvhOZj16goLDsl1b4
         DWHSTuOwPpxJEp5gXzzFUmYIw101U8nRKpscsOt4l7qpjO4iOevq1PRldMx0bfyUhTDu
         DSVQHCvgGlGkU+2ZOsZiBoeY3ITF1G1P19cEoVKWg/1yxU2qRvXiC+DrMS99KHIy6lvk
         cklv4wCIct/+0ujOsQx1sCsjZjtuYLuoNywyg9qqUXZcBeeBLQySlh+zrrwgkXWZgA2P
         zc7S3EWfuQ/ZEuckFL+AcwwalkrQgDTG4wb3CA6UFeFajYxYuuneVznQFNFEi06lceDK
         fDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPiP/xl+C739FZ3LLyWqxvOCaoq/EBCCVKhnFlPZmKM=;
        b=M4vfLinjQSa5kUcUlGIwDZHYL0IMEvij0mmd9C8iMV6S2SNP4nWQKSEVs9OqNaSjya
         ZG5MNmsV/qSk2YIxthYoKZiMfBI9pIvQSWZyfqyHZD9sbnrrjcCp/IsCib6fRQ3Hc52V
         PJDY5LhCq3QtmFsX8qMOlSYbRPRHzkuOUzD5BvmQZhWKDRW0beDBRMtX+nY2HWVWvdaD
         1UVFVNQ90u5QUVsAo/+hSapRLr1gk+OokwSDzmuaxxq/6gQJZtfEMl1Desu11ldsJnap
         Wwi1pNASRJGbIJ7PLYq/bwSLmmK2B8xH/v0pN9VzZNaH2re/e2HU+326aoJsBvEAcwjY
         jDwQ==
X-Gm-Message-State: AGi0Pub+jSpE4itvK50d1IJYeT/gMQegWWsS9jJhsTsiuHJ4OpF4yVzt
        xZxEbjqduR5IQYpT8UdE4/fTI2Fw
X-Google-Smtp-Source: APiQypIMH84lyoUHa2bph3syY8w3VfeZKgJM08pYC3SX6C9GH6hFYBAWxtLy/1wdAmjtSI5s3BfeTg==
X-Received: by 2002:ac8:27b4:: with SMTP id w49mr1358490qtw.111.1588919424811;
        Thu, 07 May 2020 23:30:24 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id n13sm759901qtf.15.2020.05.07.23.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:30:24 -0700 (PDT)
Date:   Fri, 8 May 2020 02:30:22 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v5] submodule: port subcommand 'set-url' from shell to C
Message-ID: <20200508063022.GA18557@generichostname>
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
 <20200508062136.15257-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508062136.15257-1-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

It looks good to me except for one tiny nit:

On Fri, May 08, 2020 at 11:51:36AM +0530, Shourya Shukla wrote:
> Convert submodule subcommand 'set-url' to a builtin. Port 'set-url' to
> 'submodule--helper.c' and call the latter via 'git-submodule.sh'.
> 
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  builtin/submodule--helper.c | 37 +++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 22 +---------------------
>  2 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1a4b391c88..8bc7b4cfa6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2246,6 +2246,42 @@ static int module_config(int argc, const char **argv, const char *prefix)
>  	usage_with_options(git_submodule_helper_usage, module_config_options);
>  }
>  
> +static int module_set_url(int argc, const char **argv, const char *prefix)
> +{
> +	int quiet = 0;
> +	const char *newurl;
> +	const char *path;
> +	char* config_name;

The asterisk should be stuck with the name, not the type, similar to how
you wrote it above.

> +
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
> +		OPT_END()
> +	};
> +	const char *const usage[] = {
> +		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	path = argv[0];
> +	newurl = argv[1];
> +
> +	if (argc != 2 || !path || !newurl) {
> +		usage_with_options(usage, options);
> +		return 1;
> +	}
> +
> +	config_name = xstrfmt("submodule.%s.url", path);
> +
> +	config_set_in_gitmodules_file_gently(config_name, newurl);
> +	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
> +
> +	free(config_name);
> +
> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
