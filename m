Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F76C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFB322CAD
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbhASXKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbhASXJr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:09:47 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F62C0617A1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:08:34 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 143so23629367qke.10
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FcXWdMusJ4h++TLVhKTKrfUsLnHPQ4o3KCNapQw+Gf8=;
        b=VIr8ApV4qcHLemxAZaaFQkOqUnIfojcNCNEaARXZmJc3MtPBrtfihTtKg0T/uzihwY
         5/+SY7oRNQ1DD5SMtaIRYwiBE7qa0KXNerZh7ZigR+66d0SC0IWUia2Ox//vqWxQ0J+z
         4PR1OEo8jK0Y9n8lDvUJJuHhbNgpvy9BNSS/58KG48+Z4f4szGYtWagmFE8G99xLXHs+
         18xi+AgbJklXob5l0oAKUNa9r0pDANxn1Xf4s38vTyn3dSCpdC5FV42Q+j23Cp1vV13K
         n5zFG24IX0KItagVWTt4HARwn2Hzc9dFseUPrLuOi3h1fRcX2C5MXLeIfgaqlzt67U+b
         qKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FcXWdMusJ4h++TLVhKTKrfUsLnHPQ4o3KCNapQw+Gf8=;
        b=YhNi5l2KAut6Qdb3tvvZqrzNFpVvyMYoYUnvf+WZKoT5eiPm03Vp2y3kSC+fHfogTG
         kYrfLCMNL4eJTND6FR6JjMlE86jar84SRyY6ENm/l3rju8l2zh6SvBtlXMA/isB3YrzF
         uCtl0sEHLuD6rHjfDcwTmCMoaq0ksbUyv+L6FQnGDfsCOnGInL8hlbh068+GB8l3bX1K
         tHY5d31UrYj/CNxVtfQBO4vv4fZaiWi7IfeHgZ46+hd5WAkKZ8xo3lAGuMuuF5ai598Y
         4IhWUFPsOzdENcE9acUunT7cGQUmq40mflAVOObztZMTuR+gL7R/2Vm4neIPW3JuIV/+
         kHUA==
X-Gm-Message-State: AOAM530PE6SmS7psTL9f3VJTD2uVqKIoNkn5F4o05ymyNmtPSTnYu2on
        VP6Hyggwlvx7YcOtTRCS1IqLLqewFWJB8g==
X-Google-Smtp-Source: ABdhPJxI7eMtI60SLGthsAEcT2HqYzBTNDeK1SvLsvhNGupIQt2u2gbaTLppaL0XolZyv9H8AC9Rxw==
X-Received: by 2002:a05:620a:2104:: with SMTP id l4mr6572708qkl.35.1611097714234;
        Tue, 19 Jan 2021 15:08:34 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id c12sm66117qtq.76.2021.01.19.15.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:08:33 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:08:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAdmb3EfNVHYavNk@nand.local>
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119143348.27535-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 03:33:48PM +0100, Jacob Vosmaer wrote:
> In git-pack-objects, we iterate over all the tags if the --include-tag
> option is passed on the command line. For some reason this uses
> for_each_ref which is expensive if the repo has many refs. We should
> use a prefix iterator instead.

OK, makes sense to me.

> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 2a00358f34..2b32bc93bd 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3740,7 +3740,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	}
>  	cleanup_preferred_base();
>  	if (include_tag && nr_result)
> -		for_each_ref(add_ref_tag, NULL);
> +		for_each_fullref_in("refs/tags/", add_ref_tag, NULL, 0);

Makes sense. I was curious why it wasn't this way from the beginning in
f0a24aa56e (git-pack-objects: Automatically pack annotated tags if
object was packed, 2008-03-03).

The patch doesn't say, but presumably it was because there wasn't any
speed-up to be had iterating only a subset of references back then if
they were packed (did packed refs even exist in 2008? unsure). In any
case, builtin/pack-objects.c:add_ref_tag() discards anything that
doesn't start with "refs/tags/", so I think your change is doing the
right thing here.

That said, you could shorten this to use 'for_each_tag_ref()' instead
(which compiles to the exact same thing).

It probably wouldn't be a bad time to drop the extra prefix check in
add_ref_tag().

Thanks,
Taylor
