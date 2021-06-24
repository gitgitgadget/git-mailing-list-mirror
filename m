Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53281C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAA3613AD
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhFXXqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXqI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:46:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3BC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:43:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so10949160edc.7
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=S/uccIngiYJDCQHzVySdvmpKTT93d834JkXFY80ESbU=;
        b=qy/BVUVr9YxCy5kwgGd9sLcWEGCEYlO5b+5wfwscilP2CJkZAIm7eTuOWEtHfJm5Gj
         gS3gPfKR0nNrZoQPyXW0YbyD9Ds45idsuRZWAC0Vd4UvO9se83JawYza/YrKnHCxLm0U
         zcwnGZrbA+1XklH4sf++LsUBo7Edlla0G9+jUUZc9aVtzWSQpNigrirw8z9zfr5RlOC8
         5eM+STWpRvkdyQHrhMeU1jBFx3yZVy1qjIIKTJZq2ablxWEfYD6HKT1GaFS2UyyLDiTC
         nF/clFaxykesB5eI4+opnyHfjSt+qoLt0VseCmoKhkZk+LqPLFIBWx6hMLVVjMONP5Bb
         KYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=S/uccIngiYJDCQHzVySdvmpKTT93d834JkXFY80ESbU=;
        b=RmCiSNSHIAcE16PCcShlu+vK2WiGWfOyRrauGAPZSKmL8Ilt2/PNAtzHvwyN/qqwJu
         twSYITAfcb/5QgFX/4d/G6D6zwe3x2EI731/670XQVM/vvAZ1RZKeD8lXhNrVVX0L7XW
         g939+vordAsOnINuu+9fD+3E2EDj1nV4cCWWqnPO0Kzwf/mewL6dbPnfIynimPfrb1g+
         ZoDfVcZqraPaEf5yjR5S2sAml45slrxRKsAFOOrJ8/StJgDrNsKSeyGQAKuAANBafeDP
         +PdidG4qUdj0I2uEXAAzutzKcznk8YEvAebT7FednPKn+hic70ORFqFk52JauAt7oEz1
         D4AA==
X-Gm-Message-State: AOAM530wZfaKUf9uahPbtLjetbkcEdRnEdk0OiZdNVMjoWy/LS6u4HgK
        lZLeUi9CjSZHZZPVYiV3sZo=
X-Google-Smtp-Source: ABdhPJxfxuQiBhcIX2MIGc7MiQUsPz84d6hm1WrhU47IZ9VQUJBV4/26e1rYpONNKEhBdCEEoEGtlg==
X-Received: by 2002:a05:6402:31a5:: with SMTP id dj5mr10652073edb.229.1624578226300;
        Thu, 24 Jun 2021 16:43:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e22sm2772784edu.35.2021.06.24.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:43:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Date:   Fri, 25 Jun 2021 01:43:05 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
Message-ID: <875yy2zv4e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> When writing a new multi-pack index, write_midx_internal() attempts to
> load any existing one to fill in some pieces of information. But it uses
> load_multi_pack_index(), which ignores the configuration
> "core.multiPackIndex", which indicates whether or not Git is allowed to
> read an existing multi-pack-index.
>
> Replace this with a routine that does respect that setting, to avoid
> reading multi-pack-index files when told not to.
>
> This avoids a problem that would arise in subsequent patches due to the
> combination of 'git repack' reopening the object store in-process and
> the multi-pack index code not checking whether a pack already exists in
> the object store when calling add_pack_to_midx().
>
> This would ultimately lead to a cycle being created along the
> 'packed_git' struct's '->next' pointer. That is obviously bad, but it
> has hard-to-debug downstream effects like saying a bitmap can't be
> loaded for a pack because one already exists (for the same pack).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 40eb7974ba..759007d5a8 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -908,8 +908,18 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  
>  	if (m)
>  		ctx.m = m;
> -	else
> -		ctx.m = load_multi_pack_index(object_dir, 1);
> +	else {

Style nit: leaves the initial "if" braceless now that the "else" gained
braces.
