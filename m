Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB895C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9866F20658
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8YYrtrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCSXNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:13:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36476 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgCSXNg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 19:13:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so2254427pfe.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wNXR/rNM8OwqAvud9Kdb09phdfIZ7lM14yMqx1gzj0U=;
        b=m8YYrtrCBVPlOnEoEdHlX/I+SC1eqQ+uSDTvTnSMI2OOMgWb78m3gG+MA5wFlboTUP
         86SWLRvx1e4WZ4QDkmhEmOLT8j7b3I3cRG76i0l6GIHH8tHohxJYZOkUC/JFZsbeNbpg
         xqEIMQa000tlxtk5cglHM52uz7PRt4K8PEXKcrnD3qqeHxGlfefMXwKDlOr7zwCgwCPV
         LXOQrSlVKWjqYmmcVR81RxVsF7Jcc6uN5IAps/WrciQc9osw6H5pjJCYGEhqW3nwphq6
         rQaCwUzrCamHUxxbeHobjo0VeT2e9dOtiujakoViYP3K31hznv9dzauhVF+2B5UQR9Nm
         RA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNXR/rNM8OwqAvud9Kdb09phdfIZ7lM14yMqx1gzj0U=;
        b=IPZoQJiLguC8UB+mQj4/ksj/7wsRUJX8FYdkuVivZGdywcZ98d6o2iP71gTZ3px6w7
         nrllbyS4DgOc5uRfJFs5eCznUINPiXCLqIU2VDazrAwR6+rUQjf4gIFoAZO/s+8Kaucr
         xEufkGdBgGUhNq2cbRf9CpXGYZ3PpiYZljIhPSRnSJamjpT37sHn4Fg227ufel59pHTM
         Hy/1L6CI3YLu9q17WaUX0/F+yl8dy3kLXOwQ9UbeqJJU5AyjekGyUnOZi/O9ZC2OPyaD
         ZG/QPXPdS70pFKFoWBUP/j02wpo8wQGu9W+JOu8Z3MK60HwLl5HPntkPb5RJMR13huxl
         EZsg==
X-Gm-Message-State: ANhLgQ0wlgUk9p2JikiN4XxdbB1dzU7Ntexxsfv3uYZwi1KQUBIA4Vo+
        +3iUpX3p3TB1MO7K8z30rKA=
X-Google-Smtp-Source: ADFU+vudT944Eh5ZNScJvl7as9MlVAUd/xG802yzoyytWAAj+D5Be7sBkXSx+U6GkOCbmgmN/8rhIg==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr6077602pgj.274.1584659615220;
        Thu, 19 Mar 2020 16:13:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c15sm3189006pgk.66.2020.03.19.16.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:13:34 -0700 (PDT)
Date:   Thu, 19 Mar 2020 16:13:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] config: set pack.useSparse=true by default
Message-ID: <20200319231332.GB129493@google.com>
References: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> The pack.useSparse config option was introduced by 3d036eb0
> (pack-objects: create pack.useSparse setting, 2019-01-19) and was
> first available in v2.21.0. When enabled, the pack-objects process
> during 'git push' will use a sparse tree walk when deciding which
> trees and blobs to send to the remote. The algorithm was introduced
> by d5d2e93 (revision: implement sparse algorithm, 2019-01-16) and
> has been in production use by VFS for Git since around that time.
> The features.experimental config option also enabled pack.useSparse,
> so hopefully that has also increased exposure.
>
> It is worth noting that pack.useSparse has a possibility of
> sending more objects across a push, but requires a special
> arrangement of exact _copies_ across directories. There is a test
> in t5322-pack-objects-sparse.sh that demonstrates this possibility.
>
> Since the downside is unlikely but the upside is significant, set
> the default value of pack.useSparse to true. Remove it from the
> set of options implied by features.experimental.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/feature.txt | 3 ---
>  Documentation/config/pack.txt    | 4 ++--
>  repo-settings.c                  | 3 ++-
>  3 files changed, 4 insertions(+), 6 deletions(-)

Makes sense.  Thanks for writing it.

Should this have a test?

[...]
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -45,6 +45,8 @@ void prepare_repo_settings(struct repository *r)
>  
>  	if (!repo_config_get_bool(r, "pack.usesparse", &value))
>  		r->settings.pack_use_sparse = value;
> +	UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
> +
>  	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
>  		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
>  		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
> @@ -52,7 +54,6 @@ void prepare_repo_settings(struct repository *r)
>  	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
>  		r->settings.fetch_write_commit_graph = value;
>  	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
> -		UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
>  		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
>  		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
>  	}
> 

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
