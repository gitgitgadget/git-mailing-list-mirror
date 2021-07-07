Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF103C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 00:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DF261C98
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 00:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhGGAdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 20:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGAdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 20:33:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A629FC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 17:30:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d27-20020a05683018fbb02904ae64d1b56bso574142otf.9
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QO5xXJAwtw7BXeXE7ZNh+asSSPJnteadcqJ2VvAQ3eA=;
        b=ngFk491YziA6LOMJVnshpjQDpnRN1KKDNGnjAuxFqjdNJb/HZs3MTVwgfFsXWk1+Jc
         OnlrlALYKGWX/fu1VZtSesUw40R32dUjxm5KLH+ARUSR18UppSUxGsDBtbchM0cj21GY
         VQre/EBLT0f58Plhlu2oQteHvFeBqkkPkglo5vc7spRG4uQ7qHErcsaLMeB5RbDsxTIc
         RZwDzF6KgLKrlY1N3jOfV/GkZ2CYa94APd1Yd7z2lCllm/1FOvsY7iJBT4FRS5z+7fjV
         xo/SH3pnvXh/MJ88/tBlGovNkYiH77NsRUkwHiGDVJ8lZgIjm0gWLFdXm1N8gXy4NXKX
         7xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QO5xXJAwtw7BXeXE7ZNh+asSSPJnteadcqJ2VvAQ3eA=;
        b=a1DlTwZYDui+qKwg1ck4Ndio98eYf9IOlGYXvOEW9aHcrIb3bJsKjD8Qwaj/wlJFX3
         vRDPZdgK9jSKrGo6sKQEMGXzBPcjVHSd6nFrVM0lq14DxfPosdXiZcUEhv5CEEFeGlyv
         kIIpU/0ALxKgYPU1hzPAsPWZFmvGcnpGk3oTaotBa0r8HX4wq3hJpU5AKDVs3iK1/0wl
         PShsP190XHgiZrSHxbP/OkPzEXCcRTW0MmJq2lBZiztE0teTWEbk4P9X+Im4DfJB4Lxj
         QfMmMt84sDtyPFxyeBpaaxBiRMecoXEXNrvuw/eXiNbn8Vig4p3y8pG4e6g15cu/Tgzd
         Qx+Q==
X-Gm-Message-State: AOAM5325fEXRmr2Jw90WHL/LKB4Zqsl8FDbvGWpN04mYHVdwZ7QR/rnG
        33LC/AlbZBkgGvEfP4P6UvA=
X-Google-Smtp-Source: ABdhPJwQkaXBtarbWgR8L4slpzu4sf5ifuj/eMU0dqiDOhe4XnzrwTtJUZgCyIyq1Ae89xD4m/anQw==
X-Received: by 2002:a9d:62d6:: with SMTP id z22mr17639862otk.220.1625617829062;
        Tue, 06 Jul 2021 17:30:29 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id m3sm3625153otf.12.2021.07.06.17.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 17:30:28 -0700 (PDT)
Date:   Tue, 06 Jul 2021 19:30:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
Message-ID: <60e4f5a354142_1c5ca520819@natae.notmuch>
In-Reply-To: <41852b7c-6ac7-3a3b-9f2d-6e537f52cd2a@gmail.com>
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
 <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
 <xmqq8s2lnkta.fsf@gitster.g>
 <41852b7c-6ac7-3a3b-9f2d-6e537f52cd2a@gmail.com>
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 05/07/2021 10:58, Junio C Hamano wrote:

> My main concern with the new rebase option was about a user invoking 
> 'git rebase -i --ff-only' directly.
> 
> If a user has pull.rebase=interactive and runs 'git pull --ff-only' then 
> I'm not clear what they expect to happen. Assuming we can fast-forward 
> would they expect pull to run 'rebase -i' which would open their editor 
> with the todo list or would they expect that '--ff-only' means "I just 
> want to fast-forward, I don't want to run 'rebase -i'". If it is the 
> latter then we can just invoke 'git merge --ff-only' (so long as we 
> don't mind running the post-merge hook in this case) and not worry about 
> adding more complexity to 'git rebase'

Once again my suggestion is to keep these as orthogonal, then everything
becomes clear:

  git -c pull.mode=ff-only -c pull.rebase=interactive pull

This is just a fast-forward merge (git merge --ff-only).

  git -c pull.mode=ff-only -c pull.rebase=interactive pull --rebase

This is an interactive rebase (--ff-only is ignored).

  git -c pull.mode=ff-only -c pull.rebase=interactive pull --merge

This is a real merge (both --ff-only and --rebase=interactive are ignored).

  git -c pull.mode=ff-only -c pull.rebase=interactive pull --merge --ff-only

This is a --ff-only merge.

> The relevant section of the pull man page only talks about merging in 
> relation to --ff-only

And my suggestion is that it should stay that way.

> > or post-merge
> > operations would want to be carried out even when the history would
> > fast-forward, and making "pull" to perform the fast-forwarding and
> > know which hooks should be called with what parameter so that we
> > could pretend as if the "merge" or "rebase" backend was indeed ran,
> > breaks the abstraction.
> > 
> > So, even though I wish that the world was simpler and we could
> > handle "ff logic" inside "pull", I am not sure if it is a realistic
> > wish.
> 
> I think if we decide that 'pull --ff-only' always implies merging then 
> the world stays fairly simple.

Indeed, which is my suggestion.

> On the other hand if we want to somehow 
> combine rebasing with --ff-only it will be more complicated. If we go 
> for the latter then unless someone comes up with a good use for 'rebase 
> --ff-only' in another context I would prefer the new rebase option to be 
> marked with PARSE_OPT_HIDDEN and that we also avoid making incidental 
> changes the existing rebase options.

Once again, we cannot do that, because then this will be broken:

  git -c pull.ff=only pull --rebase

-- 
Felipe Contreras
