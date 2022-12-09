Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8029C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 14:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLIOSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLIORr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 09:17:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24686765A
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 06:17:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so11751926ejb.13
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 06:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4SKPBbmFuxaJICFheg+7X8EQjeLSQUgkyVYaK1Un5ak=;
        b=PakjZePXzu1a34IhFlwRwuMUTrHyKJUFiZPavUJwaryLV307YFjAoqIv3jbgbs5jtk
         eE1R+KFwUzm9gkFJbL0NmjNPqGCqMnrUtxwGWkdYj0LlrfjoUYpZIbkrpmGc5Fx8Zm7U
         zaeoZDmNfRg9dlF0ZUXg0BGAUB9M+yrAjqLZaFivsixGgnHdu3i8ThO88Xt3Jg7PJztR
         CDjzVrdoh5d0d1NVmowxg5/GuNwUVFUb+Z6heQRoXKz20LsJOIdyHCyUgKy/FkwJFo1G
         E4x0Ly7DS+22UP9wOAJ5WdWQg1bO4hhYml4Ru8hzQuIsWsGmaCC3cHyoiY6cCIqcP9jN
         2vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SKPBbmFuxaJICFheg+7X8EQjeLSQUgkyVYaK1Un5ak=;
        b=ys3U8p9JqnpikpHXY9EEoooFSGqOdW965QaE3zzq56VanKmuJQcEkfeWpeCqwEqJaM
         uS3NImQg84e52kuhWssCsKG3EV71r4J/OkRyugL8QEjuP1Gw7dpnqpJIEp+wFz/s4fvm
         PVn5slQj/3Vg794+UH929q50fiwdVJWErvZ5A+PelyJ4ht3mo2hSDiY7w3sh7m/JHZg5
         jsT6OC6rz5xBpe+4JD5gghj4ppDWv8LbUg079KSx7Vi7HYkxDIERiIQACuwUyM+PmMmD
         ZIR1e5oaDVqNxJ6IZTl5e8DwEN7UHrGhCIPAs3xpIru/hLGmrCr1PA4xW9ReNKcbpi1w
         1QDw==
X-Gm-Message-State: ANoB5pl3fZ56RQvLi1hL/xiv+NkAfJfnREG9YwoiufBKLzcYGH6LvKV8
        HryzDuwADTuaD5VxiGmtYmw=
X-Google-Smtp-Source: AA0mqf5mAKGXHsGueAkNs+LkAT0ibrqYtljjhGi7m7m2WmmxLzeBEAaohhHzNRIGOhWbP2YefK3VeQ==
X-Received: by 2002:a17:906:4ad1:b0:7c0:d0ba:e81f with SMTP id u17-20020a1709064ad100b007c0d0bae81fmr5970141ejt.1.1670595448617;
        Fri, 09 Dec 2022 06:17:28 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f30-20020a170906739e00b0078d22b0bcf2sm598260ejl.168.2022.12.09.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:17:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3eBq-0058BR-26;
        Fri, 09 Dec 2022 15:17:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v3 4/4] commit: don't lazy-fetch commits
Date:   Fri, 09 Dec 2022 15:14:47 +0100
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670532905.git.jonathantanmy@google.com>
 <5924a5120bc8e0bf529fc1cde5c23724550f72a4.1670532905.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5924a5120bc8e0bf529fc1cde5c23724550f72a4.1670532905.git.jonathantanmy@google.com>
Message-ID: <221209.86359o7jbd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Jonathan Tan wrote:


> diff --git a/commit.c b/commit.c
> index 572301b80a..a02723f06b 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -508,6 +508,17 @@ int repo_parse_commit_internal(struct repository *r,
>  	enum object_type type;
>  	void *buffer;
>  	unsigned long size;
> +	struct object_info oi = {
> +		.typep = &type,
> +		.sizep = &size,
> +		.contentp = &buffer,
> +	};
> +	/*
> +	 * Git does not support partial clones that exclude commits, so set
> +	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
> +	 */
> +	int flags = OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
> +		OBJECT_INFO_DIE_IF_CORRUPT;
>  	int ret;
>  
>  	if (!item)
> @@ -516,8 +527,8 @@ int repo_parse_commit_internal(struct repository *r,
>  		return 0;
>  	if (use_commit_graph && parse_commit_in_graph(r, item))
>  		return 0;
> -	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
> -	if (!buffer)
> +
> +	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)

Style: you're adding another \n here, usually we'd prefer it, but here
the function already has all these checks bundled together without a \n,
and this "if" is followed by one without it.

But then again those two "if"'s have to do with populating the "oi" and
then reading out the "type", so it's probably fine & OK.
