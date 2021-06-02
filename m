Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD0C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89F3613EC
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFBV3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFBV3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 17:29:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62C8C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 14:28:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso3770939otu.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wxonV3wt+bR4lbLfVRrU/YbhbCVY+7kUprtBptpf3qY=;
        b=frRz3FS9e0wiv3RNt37DbdnKdHObRXt6vbwALDiWbBoAByaZgXjx1TVgHbp+++EjPi
         KZBR7F15HakTZlTqpEwh6D0CuWb6xrdPG7hjE9U8KMMhla40hBb+8VymejED+hMjSxQq
         uFEobuVGslvCa2KTh5kYmxrjsgf6cW448TvRftmDEfkU+3ici0PtacFrcuCd37DG4qat
         eX3ylqNKV3mFP+pA32tnkZaMJM7ginv+ZNaM+vsdgkcsefgx2rDEBerRHYpbvd8Rcbm4
         nWs02R9qvr6z8HaMR08Ku1XtK0ObW7NnnnM/csAff02PikbQDgwNwqDHTyewVa+V7455
         mX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wxonV3wt+bR4lbLfVRrU/YbhbCVY+7kUprtBptpf3qY=;
        b=h8Z1k1l8hChE3ML0X7ttUcW/bkonYX73HDLdmOE8csNTrsScT63QPz9EhMgMgGf2XS
         FNOkGFgK75swS1/bp+cjlzJzqcAKoc3fpsSN+aUesHjZpGhx1dBCR5oyddO7lQNeJn3p
         sXO6owJiXKCbut7W1VPoZRlUTOC8SB8RpiBdTjmh6Rg3lPl+ViaVV4pZ3k7bey4lnT2m
         colN62RNDfqe/ToFtnFq5s/KjqhIwhOZqydqNRB+wXVCMkWgUqZeT8Sdypd0NHxq4Ylj
         JWoPtfSAv4sfi4SY5LIr4gGqjeUq5j/rSibGI/WSiCTDfddMvHBD/XgBEhNkSz9DVT46
         e9uQ==
X-Gm-Message-State: AOAM53133KFeidTkiQ2we2UeDnIBceN+K2izememze31Eau1FMi0YKG+
        LwqepJyn+Yo7PcmKj0OrpEU=
X-Google-Smtp-Source: ABdhPJzeE0xZHqeThLBD8ehELW5voiAC5xzCp0zHKY1wMdV+N5oWWQIdLttRr5LySOKQcjPIz+XvRg==
X-Received: by 2002:a9d:741a:: with SMTP id n26mr26902848otk.223.1622669281996;
        Wed, 02 Jun 2021 14:28:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a24sm231219otr.3.2021.06.02.14.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:28:01 -0700 (PDT)
Date:   Wed, 02 Jun 2021 16:28:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b7f7e03fc64_16925f208d4@natae.notmuch>
In-Reply-To: <87eedktq4x.fsf@osv.gnss.ru>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87wnrd6wqj.fsf@osv.gnss.ru>
 <60b6c08f75c1c_40442086d@natae.notmuch>
 <87eedktq4x.fsf@osv.gnss.ru>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> > These are the configurations I've chosen:
> >> >
> >> >   [merge]
> >> >     conflictstyle = diff3
> >> >   [sendemail]
> >> >     smtpserver = /usr/bin/msmtp
> >> >
> >> 
> >> [pull]
> >> 	rebase = merges
> >
> > Can you do `git pull --rebase=merges` for a while?
> 
> I never use 'git pull' for merging, and all the time with rebasing, so
> what's the point? I mean, whenever I do 'git pull' I mean 'git pull
> --rebase', and whenever I need to merge, I exclusively use'git merge'.

So you can remove that configuration.

And afterwareds set pull.rebase=true so you don't need to specify
--rebase.

> >> [rerere]
> >> 	enabled = true
> >> 	autoupdate = true
> >
> > We are seeing a pattern here.
> >
> >> [diff]
> >> 	algorithm = patience
> >
> > Does this make a lot of difference?
> 
> As far as I recall, I had some mismerges long time ago that this setting
> affected positively, so I've tweaked it.

Try running without it for a while. If you see issues then parhaps it's
an indication that patience is a better default algorithm.

Cheers.

-- 
Felipe Contreras
