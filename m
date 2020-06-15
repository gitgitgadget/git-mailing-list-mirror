Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94ACC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B552065F
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTjI+aHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgFOMzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgFOMze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:55:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C11C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:55:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n24so18981549lji.10
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kcUsFHeOl0rtig5F4RByUx0MmzDE11Gef2eZdtEZxuM=;
        b=PTjI+aHEDr+vJXs5Gy9yLtPFGsphu/Ed/bGviISZw41JuoP202KrG/OzovyMQ7hgHE
         dWeC4o/IMnaagtPs0Bbsh2IFy3jL9jva7/l/zAoHVe7ZZQ5YXInkUCms5XrXIpVzjI9D
         jr6WpkOf4OblHirVXBIJccWiPspbrhaXD5mk0L6+a+xA3pwM8i8cSc3cZa/zbUeJPRwj
         h4TKPpqDm25dDR3etkakanwoMo9IoJIayUdphWvQ+tofAHshZmhWuClxIHBjj6xLd0up
         EuaaPD/hRDGn0cEfvexv+7zutYSVrEb1xM4elyvAxRu6TRsHSG2Eqkjl8g9fRyK7OjY4
         s13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=kcUsFHeOl0rtig5F4RByUx0MmzDE11Gef2eZdtEZxuM=;
        b=rD5uW8xG5PZADnJz0Df9IiGXT+n3xEx6bvLLw2jnHIvC6CsjhOGhIjgKn0xX+HgGrD
         SGIPGsV6FJrQzELR01ZV19F6Ol/TjvklS3gJ6WgahS94ZldsFe+pi/3Vg/Bb42mFyI5m
         lJo1Sht47Jkvq/Xz5X60Xw8sZlofEqqo6u7r9udgJE8NU6hFVVrxv+AsbXi7OdyWDBYn
         Kwf+Eu214icvgIoOJGahhZUT5+AHBQGHIUN4dTK+4fExXcrpvWF4J5H6dzgIgHtaMeXw
         FVanyJW0sOpGUNS8S0F7m4/lN/2/iZIvSYyohluoC+5vJYNTRX2bveqn40BZnnicshoI
         MbaQ==
X-Gm-Message-State: AOAM530RdaEKumBeCVNi0x2wESX4wOIZ/GkuP3Hyzb70FMCrm74KqQLM
        PBKXCZdTb0rTD/ZRGugFNm8=
X-Google-Smtp-Source: ABdhPJwmcQ1msTudimOckK8mstwmhouVUWA3yfUmTO8eyICIzepxacJRCB3UKLqfD2vBcvWASlbV5g==
X-Received: by 2002:a05:651c:23a:: with SMTP id z26mr11590522ljn.239.1592225732123;
        Mon, 15 Jun 2020 05:55:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x28sm4510179lfg.86.2020.06.15.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:55:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
Date:   Mon, 15 Jun 2020 15:55:30 +0300
In-Reply-To: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
        (Eric Curtin's message of "Fri, 12 Jun 2020 14:08:05 +0000")
Message-ID: <874krczdx9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Curtin, Eric" <Eric.Curtin@dell.com> writes:
> Hi Guys,
>
> Sometimes in our private git instance in the company I work for we
> merge branches that have been forked for months and there can be
> several or more people involved in the conflict resolution.
>
> At the moment we have two options:
>
> - One person, a branch manager, solves them by ringing people, holding
> meetings, using best judgement, etc.
> - Somebody solves the conflicts they are involved with, marks
> everything as resolved and pushes (leaving <<< ==== >>>> delimiters in
> for unsolved conflicts) for the next person to continue. This sort of
> works although you falsely mark everything as resolved, leaving merge
> tools useless and many broken, unbuildable commits around in the
> branch.
>
> Note: rebase and squashing commits is banned in our org, basically
> anything that would rewrite history on a remote branch.
>
> Is there any existing or upcoming feature in git that could help make
> conflict resolution a more distributed, collaborative kind of task?

That'd be great.

What we sometimes do when such a case appears (rather rarely due to
frequent merges, I admit) is to copy /entire/ git directory holding the
merge in progress to the next person in charge. This is the only way
that I'm aware of that keeps ability to do things like:

  $ f=foo.cc; git diff :1:./$f  :3:./$f

and

  $ f=foo.cc; git diff :1:./$f  :2:./$f

that helps a lot with complicated conflicts.

So, if such a solution ever appears, it'd apparently need a method of
sharing or re-creating (parts of) the index? Doesn't sound as an easy
problem.

-- Sergey
