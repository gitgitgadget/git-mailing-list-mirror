Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF231C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 17:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C075C6124F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 17:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbhI2RGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243396AbhI2RGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 13:06:00 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD09C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 10:04:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 62-20020aed2044000000b002a6aa209efaso9182365qta.18
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w8go7dyEKqo23ESH4wJMb0ReorPPLNgISJPkN4mD8aM=;
        b=Bp0QkTxcKGnvpFcksVJeLKGf31ynz+nj9cAweNQvmVRdAImgBY6CPJdfW+Ag6PxPLE
         TqW/ee90EmQUDKhJpv6ghfrb6gjeI1weL419+rN4uiOwol6TnyT2yV36rMeuyUWl+Rkt
         M/tBC16VUMjY/YUZ3iH2yPpsdQ0WvgZ97/aykcyvIAm11cySSNr8SkafRZLAR4CYPXc8
         gpVAbR7aNqHsS+iDohLThFE74S68j5x4JSdO3hFxneOB1ZqdthnaAsa/rcXeidA6TbZT
         DomPbSouWwzmzK/wyKnTt/SUEmVPgKnC5SCozE7bDSgIEeixP7PkpucuyPo2sS3jlTLY
         wgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w8go7dyEKqo23ESH4wJMb0ReorPPLNgISJPkN4mD8aM=;
        b=G//jgDwW2L+ncrFaoqU3zFhI10dBaLlWmiS2VhxBsVorpyAIlovGkNWZJPk0+PCip8
         0Eu4vKz0Fish8XOI8z6XBCsZ3qp1yFcWZas5V5S8zXaEC0rg3Z+Ax/rUmS7+Fx0w93li
         4UxDfZH695BG7csi5VLmQxlC3TMsNOj2oneVCoPLvkQek412XZiWjJdeXzn/SymHe8N+
         Yfw/vP4M1wcd4CTwn4pLrE7rTI5XB7aGWTnwQV4/P1E2tGSbtlRadu40Mat/yACCdGo/
         fCYr5fwkwfjT7FrSbuu1pJQKSCHbNH8RXvtbFS3GHMDnAJZZvCoabMm4Hjay312XnfR8
         BsPg==
X-Gm-Message-State: AOAM533903/xcyv6alay4FZVG/A2/PWpxhW/fPdohyejoHhiZBcMwMoD
        3H2gPQavKnWhNUjhzvM7A0HuRC25IJ5IBcW1mV/S
X-Google-Smtp-Source: ABdhPJzeMMTBOxx9GFutij6G5Ou+3dcTYzcXNRBqR23AD0PwrNi754cwE3tq3mShuy50UsAVZNIuJuBArz5f1Pdi/0m3
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:8045:: with SMTP id
 63mr1011931qva.63.1632935058503; Wed, 29 Sep 2021 10:04:18 -0700 (PDT)
Date:   Wed, 29 Sep 2021 10:04:15 -0700
In-Reply-To: <xmqqlf3gib0p.fsf@gitster.g>
Message-Id: <20210929170415.1236650-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqlf3gib0p.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH v2 2/9] refs: teach arbitrary repo support to iterators
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The two steps so far seems to give the necessary information to code
> paths that want them, so it is not wrong per-se, but this makes me
> wonder a few things.
> 
>  - There may be multiple ref backends and iterators corresponding to
>    them.  Is it reasonable to assume that there are backends that do
>    not need "repo"?  Otherwise, shouldn't this be added to the base
>    class "struct ref_iterator base"?

All backends need repos, but not all iterators need backends - there is
a merge_ref_iterator and a prefix_ref_iterator, for example.

>  - The iterator_begin() and other functions have been taught to take
>    the repository in addition to the ref_store in the previous step,
>    but
> 
>    . Doesn't iterator iterate over a single ref_store?  Shouldn't it
>      have a pointer to the ref_store it is iterating over?

No - as above, merge_ref_iterator, for example, does not iterate over a
ref_store but combines the results of 2 other iterators.

>    . Doesn't a ref_store belong to a single repository?  Shouldn't
>      it have a pointer to the repository it is part of?
> 
>    If the answers to both are 'yes', then we wouldn't need to add a
>    repository pointer as a new parameter to functions that already
>    took a ref store.
> 
> In other words, I am wondering if the right pieces of information
> are stored in the right structure.
> 
> Thanks.

A ref_store does belong to a single repository. The reason why it
doesn't have a pointer to that repository is probably because struct
ref_store (00eebe351c ("refs: create a base class "ref_store" for
files_ref_store", 2016-09-09)) predates struct repository (359efeffc1
("repository: introduce the repository object", 2017-06-23)). I've been
avoiding introducing a pointer to the repository in struct ref_store to
avoid unnecessary coupling, but it is looking more and more necessary,
as you mention in your reply [1] to another patch about how this would
eliminate certain other "user" codepaths needing to know about the repo.
I'll take a look at introducing a pointer to the repo in struct
ref_store and report back with my findings.

[1] https://lore.kernel.org/git/xmqqh7e4iacw.fsf@gitster.g/
