Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1010C433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D7961959
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCUMo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCUMnz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 08:43:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92ACC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:43:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so16077614eds.4
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5s7f2XFzM8RFuLLJF/YcG5Jn7EQCHhHTzFdo1ku/V2Y=;
        b=Ym87oQBFri3VDO20C/RP7FNYvYJMBhab8sbIV4v8Wkt1mBT8essl7z7mrZRkJmpXxo
         MA6LoAZhgqN8QXB2Wc20gBemFGCrd376QT9D6wfL9ObhmBonZsXxAFzxXzihoqdn/VKw
         r+Ke/NcLo0gYcENiFi5MKka0RKt3F7+GEGH3MOk5BWAjRVhQ+wnSrjopP+qptGahzaUw
         4b2Fk9f2guRWRHXKkhWWvreSms5Ksp4wKDttbIOHByfQxOTUCI2Xf0I4bkKXnDloG/mi
         9oEBXPz9bQSNDR+XLN9yjEpYfVpceLIQcIR3haaYui2yd8mBPDtoajtxeHfJk8VELvEb
         2hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5s7f2XFzM8RFuLLJF/YcG5Jn7EQCHhHTzFdo1ku/V2Y=;
        b=Gg1rkpYnVq4PjiR0XvR6xJ+4GOdcEUI27f15CAkJ8Jgblr8p430kWvjk/0rhtsgN17
         cBayARxcxloGzIxIfETkAQNLwjOP/E4XQxufFiR12vA7IuxQEQVsnCFYm1W/l8XZcPUH
         W3sQdAZyF+SD5v8WHIPF6qKPtBqwk2rFcvVGNFooEawfdjSqY+Z5JWMKJnkHH6qUHXW5
         JXgcowxOlEp7ifUiKC6xCAMPLR54YxaQPkb++dh/pU44YXfK0NXi0EvOI8oKKr/qBOsW
         XLt14J6lgKpl+Zoe+TX4APeSZQlzQkwVZAIejGDuufxj41qLVdwhYNgtU+S3UkGaTtXc
         GFLg==
X-Gm-Message-State: AOAM530HSUZhtMYGu2ZCvZ1xptf5RpNtEl3FARGL99IwQkbcwKEB8X2s
        +XAnhKivi6xFAfCMOcNMTRY=
X-Google-Smtp-Source: ABdhPJxL2uSnWpMxAY5dVAIbkdgKjitcSFGX84f3yHm2M8XBVlNEs4bMyraSvXX3r8Mknu4WJv3TpQ==
X-Received: by 2002:a05:6402:2695:: with SMTP id w21mr20477866edd.99.1616330632649;
        Sun, 21 Mar 2021 05:43:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id de17sm6975667ejc.16.2021.03.21.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:43:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kleber =?utf-8?Q?Tarc=C3=ADsio?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Kleber =?utf-8?Q?Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>
Subject: Re: [PATCH] fix null pointer dereference
References: <pull.983.git.git.1616323936790.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.983.git.git.1616323936790.gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 13:43:51 +0100
Message-ID: <87tup4r81k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 21 2021, Kleber Tarc=C3=ADsio via GitGitGadget wrote:

> From: =3D?UTF-8?q?Kleber=3D20Tarc=3DC3=3DADsio?=3D <klebertarcisio@yahoo.=
com.br>
>
> The malloc function can return null when the memory allocation fails. Thi=
s commit adds a condition to handle these cases properly. https://cwe.mitre=
.org/data/definitions/476.html
>
> Signed-off-by: Kleber Tarc=C3=ADsio <klebertarcisio@yahoo.com.br>
> ---
>     Avoiding null pointer dereference
>=20=20=20=20=20
>     This pull request aims to fix null pointer dereference.
>=20=20=20=20=20
>     Null pointer dereference
>     [https://cwe.mitre.org/data/definitions/476.html]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-983=
%2Fklebertarcisio%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-983/kl=
ebertarcisio/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/983
>
>  builtin/submodule--helper.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, from my brief grepping of the remaining code in git.git there is
no other malloc() that doesn't have its return value checked
appropriately.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9d505a6329c8..92349d715a78 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1215,6 +1215,8 @@ static void submodule_summary_callback(struct diff_=
queue_struct *q,
>  		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
>  			continue;
>  		temp =3D (struct module_cb*)malloc(sizeof(struct module_cb));
> +		if (!temp)=20
> +			die(_("out of memory"));
>  		temp->mod_src =3D p->one->mode;
>  		temp->mod_dst =3D p->two->mode;
>  		temp->oid_src =3D p->one->oid;

When we just want to die if we can't allocate memory we should use the
xmalloc() wrapper instead.
