Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36999C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 21:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18539613B8
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 21:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFKVHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 17:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhFKVHr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 17:07:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BADC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 14:05:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so4435127oth.9
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=y6lxIJmfjVPR9NS7IEDwvQi8CIxSTJsD//0iCtZSoRA=;
        b=NCn0UNx53OZG1WWZKA3NImUPNG6+KOQ/yjYpNBiBE2jgMNUJ7nRSIWgnVhVjUIiAYg
         r2go2vWw/idgGKItkOub6IQShRYNxHO0hFfiLRz29geLERbieGzsRsFD1uBQPOCEPj3s
         20tRUFvsyb2lVI+fr6T6x9JPlb4y5+YJ6U3hL/t19oiHMNgcnciWr1a402bcKKjpT9ip
         HAV6rfXbZwem0C555qQE/+HBksk/sdOnlNFluvaLaLodXxi7SP4liFoWmZQbD/HoUwAQ
         a5JalJePEeeNbmHgCSGkXNivPrtIOPHFbf21FLADmVEItoqaIlRvPj+WeKtn4Lf42Sxm
         u0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=y6lxIJmfjVPR9NS7IEDwvQi8CIxSTJsD//0iCtZSoRA=;
        b=sXKu0Xe0sZB0kEkdOGkuBeBZHf1pebKug3IuwXGe1AfVPtOKBjeSc4Qh0MTFvp9wDa
         pvi6NQXMkVGvXOtr7ieU0Wom6KgzMI4KyP2bZqyivl3fd+LaBi/DUIwPtebKfaDJKpRg
         Z5IbCwuKjk4nZ/HIut5cX1SbWLuvc2hiRN/epAmTH1Lj18ZG1nQPHyGXqFPOeKQr8fUg
         bmbyqNCaKXJ/2VnkbjwkweqyUv00P4KtzCU4fLLzxYLleH+pCLc/Jod1M5pZVuTLI1EU
         QR9NmR/9lV+Fdp3dBzsxi8x2wE5tLCQ2LkaG69SKGVgYyd0/fQAdnwJ8CDtBzp3QnSmL
         4YAw==
X-Gm-Message-State: AOAM530WzpehZ6r20s2BpI32zbWvOj4JRkAM04abRD/HqxuaG1+EFaCx
        j66TfmLz7RTKvYVDWCyJvsI=
X-Google-Smtp-Source: ABdhPJy+zr4RmYhZmdGIlsAXGoyrnQIPI3rRqJLLnIWbNqT2XUoECWzD2NRGcU3iNx3383E3Ll02Uw==
X-Received: by 2002:a9d:872:: with SMTP id 105mr4650912oty.365.1623445547100;
        Fri, 11 Jun 2021 14:05:47 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n127sm1378620oif.55.2021.06.11.14.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 14:05:46 -0700 (PDT)
Date:   Fri, 11 Jun 2021 16:05:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60c3d0296f869_8d0f208ec@natae.notmuch>
In-Reply-To: <20210611190235.1970106-1-newren@gmail.com>
References: <60c3a41bd25e3_8d0f2089e@natae.notmuch>
 <20210611190235.1970106-1-newren@gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, Jun 11, 2021 at 10:57 AM Felipe Contreras <felipe.contreras@gmail.com> wrote:

> > Or just use the base of the virtual merge:
> > 
> >   <<<<<<< HEAD
> >   D
> >   ||||||| merged common ancestors
> >   1
> >   =======
> >   C
> >   >>>>>>> C
> 
> I think that implementing this choice would look like this (again, not
> compiled or tested and I'm not familiar with xdiff so take it with a
> big grain of salt):
> 
> 
> diff --git a/ll-merge.c b/ll-merge.c
> index 095a4d820e..dbc7f76951 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -130,6 +130,8 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>  	memset(&xmp, 0, sizeof(xmp));
>  	xmp.level = XDL_MERGE_ZEALOUS;
>  	xmp.favor = opts->variant;
> +	if (git_xmerge_style >= 0 && opts->virtual_ancestor)
> +		xmp.favor = XDL_MERGE_FAVOR_BASE;

The only time git_xmerge_style isn't >= 0 is when no merge style has
been configured by the user.

I don't see why this:

  git -c merge.conflictstyle=merge merge

Should have a different behavior than this:

  git merge

In fact, I don't see why any style should change that desired behavior.
If you said there's issues with the "merge" style too, perhaps the above
will help for those cases too.

> > We don't have to use diff3 all the way.
> 
> Right, thus my mention in the other email to consider adding a
> XDL_MERGE_FAVOR_BASE -- which you then also mention here in your third
> option, and which I've now given at least a partial patch for.  Not
> sure if it's a crazy idea or a great idea, since I don't do very many
> criss-cross merges myself.

I thought you meant as a separate configurable flag, not something done
by default.

Now that I understand what you meant I think it could be a great idea.

Cheers.

-- 
Felipe Contreras
