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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5A2C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF4D6128A
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFXXmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXmb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:42:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023DC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:40:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n20so10927008edv.8
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bjgHgPbgM/4Pjcr9Ftul2al2NDaI5NiUkjB4q3ebEJM=;
        b=oH/GEcghJHVnXDPEiP9R6l6R7NjWZMUqaFx9z5NaDFlNSrJ9Nz4FyPH7a8iQXTmIkH
         sFbYsCA7UA8VIeyj4qPpYKYGFiTK4tslMBI64wrvdyVsF2qL+VBhrfaZYt8OvaR1bKzT
         vzmSbsiCsa1F8sxhp1KdHqA9z7ei3XHYGxrMgkNkgMMnjpv7i83KbQtQ9VxsZn8iLo/o
         tF9hgVLf2arrVWKovRUmpPipvqFRAmBp12NbTd53uGMk5lGBMKF9Aqa8PSgd+DrUjbr6
         vYsx4H7sHzO/Lalenw5+hghE18g572pmdF+PChbEpyI4xLTvQjm+Niw7bEhd+m4lsyYq
         +F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bjgHgPbgM/4Pjcr9Ftul2al2NDaI5NiUkjB4q3ebEJM=;
        b=QuGiqQoBKrRn50cSrUpK6O4Q705J/VjwQLMiFCiwpDgTU2PoxQ7qveBEgV55c/+OX8
         2rifnCOmYQpR/PvzlGxcKqUp11L5DrLzRuNcLOPzU77HD1QOy9jYJECbk6Xkbu0WxQJp
         w+4C9WCePAe7DAwxomeZrqO1gYhsHJlJcYalOvMtsidnHXriGy5NzzIOSIsNpclc0zoE
         dTdV7+JkGpwkNE2VGJqGLcSrSs/PKjnH8hrk2U/mKgR0Ik8IaNrRudLi/wBtEJOQHb+L
         u4k0Fp74N3Fp0OBtTrA7wONix6AF12U9FwYVAtjr9EVE9nheufcZkpfbU7ptYgVHkAq4
         ezVw==
X-Gm-Message-State: AOAM53358krlEntGUit91x5hlU7hZb7HQsCotTCumLPeBNeAiIFBpE4q
        Xjfh9T7U1ogMO5+WJ9bhFJM=
X-Google-Smtp-Source: ABdhPJxw9p2PGRZ/aQXUPB1mQF3ykGieOpJ1fvDzCrXHmW/nY0QyQKXDOe8gzZJUhG5DyqvZBZzFXA==
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr10586179edz.36.1624578009747;
        Thu, 24 Jun 2021 16:40:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jx17sm1823647ejc.60.2021.06.24.16.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:40:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Date:   Fri, 25 Jun 2021 01:35:48 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
Message-ID: <87bl7uzvaf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> Even though the 'TECH_DOCS' variable was introduced all the way back in
> 5e00439f0a (Documentation: build html for all files in technical and
> howto, 2012-10-23), the 'bitmap-format' document was never added to that
> list when it was created.
>
> Prepare for changes to this file by including it in the list of
> technical documentation that 'make doc' will build by default.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f5605b7767..7d7b778b28 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -90,6 +90,7 @@ SP_ARTICLES += $(API_DOCS)
>  TECH_DOCS += MyFirstContribution
>  TECH_DOCS += MyFirstObjectWalk
>  TECH_DOCS += SubmittingPatches
> +TECH_DOCS += technical/bitmap-format
>  TECH_DOCS += technical/hash-function-transition
>  TECH_DOCS += technical/http-protocol
>  TECH_DOCS += technical/index-format

As a mostly aside I've got a local series queued up to move all of these
"format" docs to e.g. gitformat-bitmap(5), i.e. to make them first-class
manpages, so other pages can link to them. Right now we mostly don't,
but when our manpages do they link to the generated HTML, which e.g. I
don't have installed by default.

So since you're linking to it: Does anyone prefer this state of a
affairs, and isn't it mainly useful for built docs such as
https://git-scm.com/docs/git-multi-pack-index.

But there's still (but maybe later in this series) a link to
bitmap-format anywhere from another manual page (but there is for
e.g. technical/pack-format.html).
