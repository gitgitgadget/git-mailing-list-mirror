Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FD2C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E213A20855
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzChR2xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgKRJao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 04:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKRJao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 04:30:44 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6FDC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:30:44 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so1227675edv.10
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NVtECt1ILCSgupz4SsrPG3aXJCDy2s4cyiAPgodmNRA=;
        b=fzChR2xi+zIAUktUzC13SjKyRRMr44FtWDGDUqQb63EqUymT90l9z8ywhAb0A8fsrq
         q5NgnD2G5OsfN6jB0gqW9nvE5PIyghHojqxjaeAoNVSxy9uJYuhv0fb8v1iIPenxUHxQ
         wC4eRzmwjd2JJoL655f4B81X6JPED/W6wqbEuqAZealTPk9VXW4SKNOvixdakB0MmmVq
         BQBN7SFK4cgIdps7M5L7xtQ0Sw3pqeL43PxYa8baEVi/yAn2SF1scm96CXvS5w8HWhmY
         Jh3ibuqFUHMjgB04gU6Hf5Tl1sEma2rnr6bNY1XWxSGAD5uViYmg7a+kHfbgMVh7Dgos
         JEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NVtECt1ILCSgupz4SsrPG3aXJCDy2s4cyiAPgodmNRA=;
        b=QpK8OyjsjPzPOtaWQe+q349pnf53FQSy+eiy+28v4KbJFbHGQ6apHclzNQB8/8MaA3
         eSxuVaDje9hI3/JsoOFAUYAOOS6RQlSTGQPIdZLEL5pcT73zmco7Zwpvv/1zxOjkIoY0
         AZNfpFUic8jhJcDHT2P0hDguPRutVK/BkLYQFmnyiR5AL4N8M6cuw4uSYVDRPD++l8mj
         pEUDu6yb2FtuNB4FKB7C59IwdS/MWjuxONVjYP1WdRdEypQLhJ9pfGpihn45RPEJRNfN
         YgDtyiEJzLSgOwOeSYF0xChhAjUOI0wkqeY98bL5tE/LYJnRy7t228xsf3WdGkYD4AUV
         2Y8w==
X-Gm-Message-State: AOAM530b/wmk8gqJ1ijP4FutSmbUwVEhS4BfUIbhncdr1EJrFdEe5W40
        zHaiPW54YBjWUa9sXxtcS7ZDjykDyXM=
X-Google-Smtp-Source: ABdhPJw89RhWC0P9h5F5/a6o3C5S89ThHswWlotz+TPbF2cBy2HSziVt9QV2GpBLhUu0+7SxfLXdaQ==
X-Received: by 2002:a50:f68b:: with SMTP id d11mr25621262edn.64.1605691842590;
        Wed, 18 Nov 2020 01:30:42 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u7sm12683960ejz.43.2020.11.18.01.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:30:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201118091219.3341585-1-felipe.contreras@gmail.com>
Date:   Wed, 18 Nov 2020 10:30:40 +0100
Message-ID: <87wnyjdnb3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 18 2020, Felipe Contreras wrote:

> Users might change the behavior when running "git fetch" so that the
> remote's HEAD symbolic ref is updated at certain point.
>
> For example after running "git remote add" the remote HEAD is not
> set like it is with "git clone".
>
> Setting "fetch.updatehead = missing" would probably be a sensible
> default that everyone would want, but for now the default behavior is to
> never update HEAD, so there shouldn't be any functional changes.
>
> For the next major version of Git, we might want to change this default.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> This is just a RFC, the tests are missing.

I haven't taken much time to re-think through the patch/implications of
this, but I remember running into this and going through some pre-patch
investigation at some point.

It's really annoying in some cases that "clone" isn't creating the same
state as "remote". IIRC I was doing some heuristics to figure out the
remote branch name etc.

Isn't this something we can just change without an option? There were a
bunch of cases in clone/fetch that were different for no different
reasons, IIRC I patched one or two of those in the past. But I haven't
gone through the history of the feature and checked if it was
intentional.
