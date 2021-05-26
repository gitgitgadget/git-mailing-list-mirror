Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08323C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D654E611AE
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhEZQIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhEZQIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 12:08:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7EAC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:06:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so827694wmg.3
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hBUE8CZx6yt2X6XhRB+EjJkvKJt6jO2cdhntBI9kb1g=;
        b=DC8Tatv1NCm2gshqw8j5tK0Rr4GIh8YP39zLI9SyLKAuD37Aslmy6Ew3gLoRUwfyaC
         MOOjsmOf1UX6hntJY6YkcKiHoTnKYWyg1boxklc7e4s4WkaKXDXajMWTJwj025fqypMd
         lWDi+pST9DrUKnsg9urM8hZWCzwPozL8amHUYgH8fse1FlEdmOAA/0q1OLZaawnMxpza
         QTQYvldg3baARvYjYcfqBNhaMCZH1MuTgwmlrRndvmEjC6eoRSCBnApwsJghgmCy2G27
         w2neChDnDf+xu5OiNP/ORPn261T9zNXLvoka0gW6CY6Y6NSBiUv9dZ6UPM2gNWWWGgt9
         3WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hBUE8CZx6yt2X6XhRB+EjJkvKJt6jO2cdhntBI9kb1g=;
        b=MyimVfC0xX5DGwgz56Bp0lgv957OC+t2prYObyM16gucMbPlMZe+8nATvzxZcF/JSo
         /ETvJtxAndetZKhRyvotPW+wvZGsnwNeGBtPTsonrwKZyQyUUdgVGy0AJHxYKjw+UNZF
         CVlfugeAROdqI3TWx/umc+83Yd9h7UEAPyFXE8/lnAtIsKVnq2SFoFjU92cELec7O7ic
         AKOEbaUoVepWUVCiyq93XseB41sJLj/09ZFr65xmweXNPvLalXlbILuKR6OtKk9nYqu3
         eFXKoMVJyqHk8smxy0C0buEabWMwZy87COcoyzP7u1o887bqplgpMDghxp2m99vQ+mcT
         X6qw==
X-Gm-Message-State: AOAM530xCMh4+Zw5cc2vffFcVzaQQRtk9g6cbCnRsUkC1KricKvg16Bt
        KS8WxlIsNg8LiuPqVNXzO3wccprnqhU=
X-Google-Smtp-Source: ABdhPJy4gnGPgHJ54j11CVBpUSTZuiUZEVs54P9x9jVeEcYZ/hTl1V+DbGkGczSe0O0YrI2WqiO77Q==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr29716934wml.81.1622045194530;
        Wed, 26 May 2021 09:06:34 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.163.147])
        by smtp.gmail.com with ESMTPSA id a11sm21131925wrr.48.2021.05.26.09.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 09:06:33 -0700 (PDT)
Subject: Re: git status when merging non-conflicted 3-way merge says "All
 conflicts fixed"
To:     Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
 <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <365cecf9-2ce7-9d8d-6898-3234807df963@gmail.com>
Date:   Wed, 26 May 2021 18:06:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2021 16:30, Elijah Newren wrote:
> On Tue, May 25, 2021 at 1:22 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > Hi,
> >
> > Supposed that we have following commit graph:
> >
> > ----A----B----C----D <- master
> >                \
> >                 ----E <- e
> >
> > When we merge e branch by `git merge e`, obviously we will do 3-way
> > merge. Assumed that the merge doesn't conflict, Git will fire up
> > editor to edit `COMMIT_EDITMSG` for us to enter merge commit
> > message. Then we abort the commit by either delete all the lines
> > there, or comment all of them.
> >
> > But when we check status by `git status`, Git says:
> >
> > > On branch master
> > > All conflicts fixed but you are still merging.
> > >   (use "git commit" to conclude merge)
> >
> > That message above is misleading, because we know that our merge
> > doesn't conflict (3-way merge applied successfully without conflict).
> > However, it makes sense only when we have resolved all conflicts
> > on the conflicted merge.
> 
> Once upon a time, that message would have always been right.  Then a
> --no-commit option was introduced to git merge, and editing of commit
> messages for merges was also added.  As you note, both of those can
> yield cases where the message is misleading/surprising.
> 
> > So for non-conflicted merge, we can say instead:
> >
> > > On branch <branch>
> > > You are still merging, and the merge applied without any conflicts.
> > >   (use "git commit" to conclude merge)
> 
> At the time this message is printed, there is no way for us to know
> whether there had been conflicts.  We'd have to record that
> information somewhere (probably the index, though introducing another
> index format just for this seems like a really high lift for such a
> small thing, and may conflict with other efforts to extend the index
> format, such as the sparse-index work), OR re-do the merge when the
> user runs status just to find out whether there had been conflicts
> (which seems like overkill, and would require you to know which merge
> backend had been used and with which flags so you could re-check with
> the same one; further, three of the merge backends -- recursive,
> resolve, and octopus -- all update the working tree and index and thus
> could not be used for a case like this).
> 
> Seems like opening a really big can of worms.

All said, would it be an improvement if current message would be 
simply reworded to say "No conflicts but you are still merging"
(instead of "All conflicts fixed but you are still merging"), thus 
stating the fact (there are no conflicts, indeed) but not implying 
how we got there (whether conflicts were fixed, or there were none to 
begin with)...?

Regards, Buga
