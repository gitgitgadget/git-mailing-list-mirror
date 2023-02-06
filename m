Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74BAC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBFWN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBFWN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:13:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294511E96
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:13:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id pj3so13036628pjb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXM7NizEUoCkcHFfIRGxjpFrNIZx47GPctlhuXeh4B0=;
        b=fH2Czw6y6C+TiSkBja2f3vGqY3WGHYeSMjWyjtM00qQIEqUhUhhYjtH8RB4BNNhjvG
         DlZrNSEXLF39Qubs69U7j7jUYbA/ECuSESgULSUvJZSU933amw1DqgA4/5UAvfhjbCy3
         4snEOgTodbIJcVzxawnfarKiz3UO/7B5ataF5vB8vUC8z9mh7N3JdAhxb19n+yTJ1QZ2
         8vrjsAqXqPODjJTUDLGojENOW8x7ox/gyQBfRoLSg+8J/VJ2Z80dQYa7s/G+ju2XZTUq
         7/6xUoCRN45s7gVT3CcQuyA7sR18cJWw6yM7RwKLc+Ef+e4AhiMe5g6D05vHoVjKohh6
         AfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rXM7NizEUoCkcHFfIRGxjpFrNIZx47GPctlhuXeh4B0=;
        b=dl/MYqfbgNckJo4PgYVYDdwaV70eTEj8XpktoUElpMn9rb+2gCY/9fBoAmEtDRZtzv
         69uRDg07N+ZvgbumjDKl7DuUDSd/1UlGe32NwzqUdomVQLjVQRNh7bWjkGPno77lxFl1
         r5i1R/zepKicHOgDBxUerbarqUKSIHt2SwoiX5dwFrtTWUHqOM8wmZzeokhb9zYnHN/m
         PzEjaYHXuIpY6VnqIgi4QTRMOf7kVljvVL1ZEvpoXAopDC6EeHfQugPxKREe/hIxGsne
         utC0BjixKSTDqKk4/EwBPXfYeO15oHPqIC+QZKcK+VJ729+Ov2K/CmaoF3rcJZuKJLZt
         VWGg==
X-Gm-Message-State: AO0yUKUuQvsZiXyA2niQIQ069s3LijD+Ti87uoXHwpsU6Ae5khBTRjzh
        fbycERV/Ssk0mO3B57Ws7lk=
X-Google-Smtp-Source: AK7set+6nrigut3M3XfSW+Di88+saKPqjqQ0oYqqB8/zg8NW5xNNgxPiEN7MTg09w9f52yWK7jQOeQ==
X-Received: by 2002:a17:902:f353:b0:199:1292:53b3 with SMTP id q19-20020a170902f35300b00199129253b3mr353916ple.24.1675721607123;
        Mon, 06 Feb 2023 14:13:27 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902e8c900b00192d9258532sm7393547plg.150.2023.02.06.14.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:13:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] [RFC] push: allow delete one level ref
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
        <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
        <966cb49c388b652861c773ad7430875bf7896c16.1675529298.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Feb 2023 14:13:26 -0800
In-Reply-To: <966cb49c388b652861c773ad7430875bf7896c16.1675529298.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 04 Feb 2023 16:48:17
        +0000")
Message-ID: <xmqqbkm64f3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 13ff9fae3ba..77088f5ba8d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1463,7 +1463,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  		find_shared_symref(worktrees, "HEAD", name);
>  
>  	/* only refs/... are allowed */
> -	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
> +	if (!starts_with(name, "refs/") ||
> +	    check_refname_format(name + 5, is_null_oid(new_oid) ?
> +				 REFNAME_ALLOW_ONELEVEL : 0)) {

I am somehow smelling that this is about "refs/stash" and it may be
a good thing to allow removing a leftover refs/stash remotely.  I am
not sure why we need to treat it differently while still blocking
update/modification.

Is it that we are actively discouraging one-level refs like
refs/stash, so removing is fine but once removed we do not allow
creating or updating?  It somewhat smells a hard to explain rule to
the users, at least to me.

> diff --git a/connect.c b/connect.c
> index 63e59641c0d..7a396ad72e9 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -30,7 +30,8 @@ static int check_ref(const char *name, unsigned int flags)
>  		return 0;
>  
>  	/* REF_NORMAL means that we don't want the magic fake tag refs */
> -	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
> +	if ((flags & REF_NORMAL) && check_refname_format(name,
> +							 REFNAME_ALLOW_ONELEVEL))
>  		return 0;

This side of the change does make sense.

Thanks.
