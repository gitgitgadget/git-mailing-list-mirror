Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E2C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 01:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiCIBCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCIBCL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:11 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294E269A5F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 16:40:17 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id p17so567671plo.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 16:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fcY4eZ1+9zJLhCvSJV5RFMU3T4RE2EdC/Um9Nwd9oMo=;
        b=teBPkgCMotvP8lQs38yx9cZ/hlOOKv3NLCBkltrYEq6tgjJXj2+P3l5Fncry/cfOtT
         EcgOzfreBDc26rdsmgm8HJ7B+rf3wTszzSiY5uwT4G675EsUwyU69EYSeVcfcctM9hc4
         YE+KVFj4tekoez8ZfBoocdlmNqu67X+7wA6Hfr3it8dVHIVyUDajOplwcsBgpm3oJ65Z
         tXNlEuw9yXkW0aVh8iSJg3pcwozf5rMp8RS57ly8KiNkbVvQUFg3zEp5hOmTUC/S9Qlp
         /5lxktYg02JaOi88CU9jV5BXBQR6RwYpRSvFtAGXsUB0grIjec3mIYBBoljt4mQZi59F
         4d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcY4eZ1+9zJLhCvSJV5RFMU3T4RE2EdC/Um9Nwd9oMo=;
        b=jaT393xJnCZpvr2THX92CdrxbtCFh0nOn18I+jUYJY1UPTQrKP3VIxLvge19HnWRta
         wqIHAM3FjpswIwyQWUg+fD3UeUJy3hSyferC+N0b6aiEMej+bkMSVaTvTG/qg3FDr768
         LjFf7yoAHhbGA4p9j8F58nq+OD0ozTVkitp2cHXZYj3jXaq4Yw9ycarVglmI2hENNQFK
         CKwtmIDtWGU4/3811y+Yd6dN/if0QuFJVm8uaP0t1rOvsbCKADvTv5A984YB8DuzmDnG
         QG9ButjcsvD0oJVGkPSfdmFoSJgYf5qzyJfUcuovmkOIVLtIsRnSOxQRyXwIhdBMiSsG
         WtcA==
X-Gm-Message-State: AOAM532SzSLddQE6e3w4KnArwm7/QgdJcMZBHtq+JCshpIi1HZ0rX0tt
        mB47WD9fWunT5rYIF/z5jmJQusgWY1/6Yg==
X-Google-Smtp-Source: ABdhPJxmnY94AnnqUNDGuUyXbwnrVuYOsAufEst81h6vbE/++uRJ92TDK845vDRyGc360C9VQRRfcg==
X-Received: by 2002:a17:902:d507:b0:151:f3dd:dd50 with SMTP id b7-20020a170902d50700b00151f3dddd50mr10555767plg.35.1646786336806;
        Tue, 08 Mar 2022 16:38:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:7bb4:8168:2ecc:faea])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm261614pfu.150.2022.03.08.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 16:38:55 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:38:51 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 3/3] rev-parse: short-circuit superproject worktree
 when config unset
Message-ID: <Yif3G5zxP9kj/Lkc@google.com>
References: <20220203215914.683922-1-emilyshaffer@google.com>
 <20220301002613.1459916-1-emilyshaffer@google.com>
 <20220301002613.1459916-4-emilyshaffer@google.com>
 <xmqq7d9eup7k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7d9eup7k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 11:06:07PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > diff --git a/submodule.c b/submodule.c
> > index 741104af8a..463e7f0c48 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -2237,6 +2237,7 @@ int get_superproject_working_tree(struct strbuf *buf)
> >  	struct strbuf sb = STRBUF_INIT;
> >  	struct strbuf one_up = STRBUF_INIT;
> >  	const char *cwd = xgetcwd();
> > +	int has_superproject_cfg = 0;
> >  	int ret = 0;
> >  	const char *subpath;
> >  	int code;
> > @@ -2250,6 +2251,17 @@ int get_superproject_working_tree(struct strbuf *buf)
> >  		 */
> >  		return 0;
> >  
> > +	if (git_config_get_bool("submodule.hassuperproject", &has_superproject_cfg)
> > +	    || !has_superproject_cfg) {
> 
> git_config_get_bool() returns 0 when it successfully finds the
> variable, so the above says "If submodule.hasSuperproject is not set
> at all, or if it is set to false, then..."
> 
> > +		/*
> > +		 * If we don't have a superproject, then we're probably not a
> > +		 * submodule. If this is failing and shouldn't be, investigate
> > +		 * why the config was never set.
> > +		 */
> > +		error(_("Asked to find a superproject, but submodule.hasSuperproject != true"));
> > +		return 0;
> 
> But given that this thing is new, I am not sure if that is a
> sensible guard to use here.  Shouldn't we say 
> 
>  - If submodule.hasSuperproject is EXPLICITLY set to false then ...

Ah, interesting. I think that makes sense. I wrote this patch hoping to
get an additional check for completeness of the previous patch (that is
- if I can rely on that value for this other operation, and all the
tests still pass without me touching them, then I seem to have wired
the new config through everywhere) and I think it's served that purpose;
for the real world, that's a little more dangerous, so I think relying
on explicit false makes sense. Will do.

> 
> instead?  I.e.
> 
> 	if (!git_config_get_bool("submodule.hassuperproject", &value) &&
> 	    !value) {
> 		error(_("asked to ..."));
> 		return 0;
> 	}
> 
