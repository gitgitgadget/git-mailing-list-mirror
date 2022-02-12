Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492C9C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiBLOnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:43:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOnU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:43:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F7214
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:43:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g7so4529337edb.5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZhEqmPMCNaR9RwNm0aHprjjbnp0jmD+1ADlEd2pJFF8=;
        b=SQkgqv3BsFEf7UqMAXoEensg01J9R0RTaMlbOR9+58SU0h182VUk/v7Mn0+L2xD8hc
         3NqUQt/uk1fqSlAN3sR/v9x1m3/FcZhB5lctl9DfPSYh/p0/iLU+zlFOGa6ZclsfmhQO
         rD3+LpxIWekrl6jqWlX33+MNcjHNeGM/F7NWmjaZo+HNdZsMTajB5vnW/+EqpPX22wlO
         JIkkMo0HzKglVeypRcID0BJB2Xmw1Nztt6mpWS/HlzN6/5o8fXfho6fD7Z2raC4dHHrd
         yNV/QlFdEvfpTdDcgAu+dNL/f64cqENxta38EIA1bTWJPKhfTvpTHhJ2UXunLiOSxxur
         bEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZhEqmPMCNaR9RwNm0aHprjjbnp0jmD+1ADlEd2pJFF8=;
        b=MKPspAIAr2mMerlFJL+g7CVxAAVdHlyB9+/HTLy6f9XW3D4BfNvbTfnKGg4yGlhBzp
         0D5i0DeTFw/WzQHwUVPDNY0IyMU9yPih+yYlPWOh8tsJ0OTNGSMnhAhGdbCKvAvNDbf6
         lnn7CYX2R0JSmztboIAiGeOpgggX5A2UnnNonLhm4WMCJj0sHXPDlhsxKLgEKOORF3LE
         vyZ+vNST2AC0EwYK9ZkhIo/iJFL74wZQhnDeuKPlycyFKKpAdOw7tOwz5TlNErLakhZy
         I8jgLuLeLugetnVOdyw9khuU6ShRH/pc7BmKq2MYA69mTMqPLjR7QoRWrMdN8yJltPFj
         8sBQ==
X-Gm-Message-State: AOAM530FuGz7ajWvQFdBfBnsdEp+/oZ1Irs47Vg1Irn78NqgjmE/rmCb
        btdBgZ1uTaaSwvxwGseewBwOf15a8/liAQ==
X-Google-Smtp-Source: ABdhPJw0mcEjjdx4Lm32R0arDrNAcz/oTeiqHij1xfoiqBVQKADz9CRVSsjNO+SAeN7H78BUQ8YwLQ==
X-Received: by 2002:a05:6402:4392:: with SMTP id o18mr6956693edc.338.1644676995075;
        Sat, 12 Feb 2022 06:43:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lo24sm6112558ejb.141.2022.02.12.06.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:43:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItcH-000S13-Uw;
        Sat, 12 Feb 2022 15:43:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 18/20] fixup! submodule--helper run-update-procedure:
 remove --suboid
Date:   Sat, 12 Feb 2022 15:41:45 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-19-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-19-chooglen@google.com>
Message-ID: <220212.86h794xi0u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  builtin/submodule--helper.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b895e88a64..98d8910930 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2886,14 +2886,11 @@ static int update_submodule(struct update_data *update_data)
>  					    update_data->sm_path, update_data->update_default,
>  					    &update_data->update_strategy);
>  
> -	/* NEEDSWORK: fix the style issues e.g. braces */
> -	if (update_data->just_cloned) {
> +	if (update_data->just_cloned)
>  		oidcpy(&update_data->suboid, null_oid());
> -	} else {
> -		if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
> -			die(_("Unable to find current revision in submodule path '%s'"),
> -			    update_data->displaypath);
> -	}
> +	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
> +		die(_("Unable to find current revision in submodule path '%s'"),
> +			update_data->displaypath);
>  
>  	if (update_data->remote) {
>  		char *remote_name = get_default_remote_submodule(update_data->sm_path);

This fixup looks good, let's apply this fix-up to the relevant preceding
commit.
