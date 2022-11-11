Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FA4C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiKKWqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiKKWqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:46:01 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2C5C74B
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:46:01 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id b2so4553559iof.12
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQDWCv4dsqlW5tJUnT2Obd7pzLSbD+I33wakEpmUuss=;
        b=vmT8Z9pC16yDSlHUb+EbAF2nnG1tPOqguGTj16kdNoXIAUiarHnl7a7cXZ8HFBwGNc
         GfoqjBz0itLdkQJHaGKCLQhvN39jlnPACOW7iDFt3GR5kx7owHnU9mBRjQQctj3VSr0z
         BULw7rSsXettAbHNze+nKdHps240i5AFC/LplPPSLJev0Q/q8Ig/zhtvXsvAvGAWS5X1
         anLqpXSSqxwb88Cej2DvYeMjyZMOK7rYzbw3K/eVxv73afUhlIhtq3RBmXzXZEV2ymNg
         zzC5XJB5VwQx2ax/f4ctsbCC7P8IftRkbr4vi2lPxVe+7Dscrht02+lwcED/+WE1Gws6
         giQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQDWCv4dsqlW5tJUnT2Obd7pzLSbD+I33wakEpmUuss=;
        b=NaEErvbN/Ym/8IxR/kLojOuD0xwrY38IPDmmC7rMfYyEGg/R+DKLXDBPnTAfePUy+O
         sB7DoOCaAlZ5RpVOyQ+lpyxNw2X9drlfLkMcNH1O/DxuDm30/xaUcaHpJMFdBEtLwUw2
         ioVLqRgBlPMEGf4BRoskloa4NLuABL0qYT1K80G30UPFkV/xDgRih0LfMKN9PL0e2F8i
         UBSZdl9kjTwVwXo+zclB0wLi11V0GhJ9CJm8zWvvtt0/ux+zPMvxf2WnWZholV6GsuUC
         G39cOk75jkouOKJjAFP0VEDgClItxUnuZrtqcSI5bw4tirAH4ki7epl3t5EngBUfpVod
         2gXA==
X-Gm-Message-State: ANoB5pmRzhkI3ABj/h+wek6cKqWWb9SF3z2bvXTo6nkdmq0w2CNRTPQa
        hMfV0LFTwAVFNjifR9maEd3FeWGQMFGvjw==
X-Google-Smtp-Source: AA0mqf5u5auv1hMmzdiBUQIVNoJmGVAMJ2kWxKV7khlJLVojwPDDJTtA5uYEY/cbBWL32Ur5i4ohUg==
X-Received: by 2002:a02:3f23:0:b0:363:e6b8:2bac with SMTP id d35-20020a023f23000000b00363e6b82bacmr1701229jaa.229.1668206760691;
        Fri, 11 Nov 2022 14:46:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d89d1000000b006cce295dde1sm1209179iot.10.2022.11.11.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:46:00 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:45:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, me@ttaylor.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] maintenance: improve error reporting for unregister
Message-ID: <Y27Qpz7jWafy3FCI@nand.local>
References: <20221110225310.7488-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221110225310.7488-1-ronan@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 03:53:10PM -0700, Ronan Pigott wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 1709355bce5a..56b107e7f0b9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1550,19 +1550,24 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>
> -	if (!config_file) {
> +	struct config_set cs;

This declaration should go at the beginning of the function.

> +	if (config_file) {
> +		git_configset_init(&cs);
> +		git_configset_add_file(&cs, config_file);
> +		list = git_configset_get_value_multi(&cs, key);

And these assignments conflict with 'ab/config-multi-and-nonbool', but
that is a problem for me to figure out, not you.

Thanks,
Taylor
