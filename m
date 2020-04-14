Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E72C2BB85
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5605A206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GA9iUJU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440859AbgDNPp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440855AbgDNPpP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 11:45:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C653DC061A0E
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:45:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g32so49043pgb.6
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pnuX+nYG0EAdbQOmmqD550RiYxPwCqV/tRjvk+TlmNo=;
        b=GA9iUJU4Q55jwt0K2bS5JNmIc2XxKFcMM84014ZpRWSTI54OmzX8+5liTfOiut/vs2
         NrcwL+2qcYZgyXFfkPQdFRk6StD0qi9RsyVzxaq8KCZ3f+J38wvBdBpXKCSZwfIZwSQs
         5kNEG9zO2dxFwYmTjm6xTjKYOLxAomDM6TkQnjIxziYcd3G/c37r/ScAaCVSQF1lLsng
         fmxe/fw+cK409ESGKBw1AT00IioC9g/e9qla/M9RnA4IsMh6TbtwIAvHac5zX0K9/FxM
         tVVstWRCzLKhszRtPDBHzJQ7L1LCavaZ2bkqcqpkhMx4NNbqh7w2jMh38oyeGVH/nLZt
         8WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnuX+nYG0EAdbQOmmqD550RiYxPwCqV/tRjvk+TlmNo=;
        b=qD2VjWvqJyaeh5xgBg7kaN0/N0aazIPcByCHAjOugmmXHfgpIswJBAzvEKo+ni3BdZ
         /nvOHQlcaUgKIUlLoqzOBlxo5Ox+5hY/02IK+rSP1tuFiywd05BZ1+rPy/nbvAlzzTZ/
         pYC/Lljpyjz9X5ZyoZMaHU3K5wu/JU6VG4XtCuohqeHyIpvCBatSHg2y7gFYo4kf6KrY
         tNP7At6S/oAZkX7tG9YV5s71UptkcWuFTDuF3VYmvGKur4I1deQYPloLf+D+qiORxn1D
         eUjw+Zm+wXJNxUbdIFDaIO+6opUtCv0Rft9ucUNcqMX8n7YB4jjLvXsJddws6JArbKQk
         pW4w==
X-Gm-Message-State: AGi0PuYxGLT4dha10GESj0wH9nkjWKacmSrFluVjCey+HH/1xHyLZO0N
        yf6/e/RL+9SZUqhTM5UKNl6L1Q==
X-Google-Smtp-Source: APiQypIFu/NS7Y507uSd12JcWTSwawAIDaak2cG88SuiwXJ/pEgO5Ds064reUmoEJs/bcOWko2VErg==
X-Received: by 2002:a63:da47:: with SMTP id l7mr23608783pgj.315.1586879115064;
        Tue, 14 Apr 2020 08:45:15 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g72sm11406456pfb.196.2020.04.14.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:45:14 -0700 (PDT)
Date:   Tue, 14 Apr 2020 09:45:13 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] log: add log.excludeDecoration config option
Message-ID: <20200414154513.GB93424@syl.local>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
 <20200413154945.GA59601@syl.local>
 <0b9e3156-1101-0f19-91eb-36af541519aa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b9e3156-1101-0f19-91eb-36af541519aa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 11:10:33AM -0400, Derrick Stolee wrote:
> >>  log.follow::
> >>  	If `true`, `git log` will act as if the `--follow` option was used when
> >>  	a single <path> is given.  This has the same limitations as `--follow`,
> >> diff --git a/builtin/log.c b/builtin/log.c
> >> index 83a4a6188e2..d7d1d5b7143 100644
> >> --- a/builtin/log.c
> >> +++ b/builtin/log.c
> >> @@ -236,7 +236,21 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
> >>  	}
> >>
> >>  	if (decoration_style) {
> >> +		const struct string_list *config_exclude =
> >> +			repo_config_get_value_multi(the_repository,
> >> +						    "log.excludeDecoration");
> >> +
> >> +		if (config_exclude) {
> >> +			struct string_list_item *item;
> >> +			for (item = config_exclude->items;
> >> +			     item && item < config_exclude->items + config_exclude->nr;
> >> +			     item++)
> >
> > Any reason not to use the 'for_each_string_list_item' macro in
> > 'string-list.h' for this?
>
> The reason is I forgot about it.

Heh, in fairness I forgot about it, too :). I thought that this code
looked familiar, but it was only luck that I had 'string-list.h' open at
the time I was reading this.

I don't think that it really matters much each way, but if you're
already re-rolling...

> Thanks,
> -Stolee

Thanks,
Taylor
