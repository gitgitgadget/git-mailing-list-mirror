Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C9C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E417F613D3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhGPSDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhGPSDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:03:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5797DC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:00:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10677683otu.10
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ay7zy6mOpJc4t4sFetT/vFSKGRF7lIUWG4ooDBywI60=;
        b=T4xJGXaLW2uTRIUwmMlIOuunVgbnhG8+8/T+SdrjKoqDHlUu3mWZwKahWigsgkVlLB
         FbfqIUKtQW6nu2cfJzuRTrajxuWrwadXh1uccGxe0kxnfb1VQY42+J5a7QQezj8F+JtO
         jknwLqlgx9dUIu6h7BSaSqQAs7UJ+Mzkhg/h30QM76CNxbnbajHnhi54fgnMzt/byfti
         oVU2E3pZ/KLIx5aN78lRneutnjuwga/+R5SvN5YAcmqjV4jBswuEnyRoLsoknofmWhnw
         tuVrHTnPa8/BXl5nuawTCHzs806EJ9WK37rDo3tfFh+rdhX+NQ0nlSQNnRKbYzu8HPTY
         b/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ay7zy6mOpJc4t4sFetT/vFSKGRF7lIUWG4ooDBywI60=;
        b=ELXjLEk4rFw9oqNbXESuy1ZTxWXrNvXY6I7Nd0yOuTxwV/bqyxLP2ceGgwzVHRq3Y1
         CzX0l0zw5j1+6ysYwvbKhujxpBVt1bWe2Htz76ErN0wjZsxk7mbAsYk3tsXEMoAU7Y/x
         1u8B7AY7WpFz/YamdpHST4dIrqMjL/eBuVSvs7nJGNtTwUIXWoSYkdbdggTIR0H6DPoc
         7pOH5Gu18QGK37rotRhSq27c7CrOK7olxtqg27lrD5T53MjRBl0OSi0ROe4B1JY1SB+y
         20CqzTwxe7F+Ugb944+vICcDxMcylYxt/cHihV+/60Q5FGy+yiTiVKXYvF/aSianZrVc
         henw==
X-Gm-Message-State: AOAM5334phDW+FkWZJLmk5mIayDirkpYWcvLj40+LRUa0ykTG2zjdbsR
        0m5jxHA5rAUduy2W/NizE6o=
X-Google-Smtp-Source: ABdhPJz5jcF7ZsNw43i9cCB0Kbo+DMK2r0yUJ6Ar0YNxdOHAH5rte4/KV7/nOU66QY/7jDeghFWHKQ==
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr9293127otb.281.1626458425408;
        Fri, 16 Jul 2021 11:00:25 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id v3sm2028604ood.16.2021.07.16.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:00:24 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:00:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60f1c9378d5a1_3302085c@natae.notmuch>
In-Reply-To: <00b50aa6-9b61-9f80-1d8d-2db3ed5e7638@aixigo.com>
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
 <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
 <60f1b7853b8a2_ade9208c1@natae.notmuch>
 <00b50aa6-9b61-9f80-1d8d-2db3ed5e7638@aixigo.com>
Subject: Re: pull.rebase config vs. --ff-only on command line
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten wrote:
> On 7/16/21 6:44 PM, Felipe Contreras wrote:
> > Elijah Newren wrote:
> >> On Fri, Jul 16, 2021 at 7:52 AM Matthias Baumgarten
> >> <matthias.baumgarten@aixigo.com> wrote:
> >>> this is my first time contacting you guys and girls so I hope this mail
> >>> achieves the expected standard. I've discovered the following behaviour
> >>> of git:
> >>>
> >>> If pull.rebase is configured to true and git pull --ff-only is executed
> >>> it seems like the config wins, i.e. issuing "Successfully rebased and
> >>> updated refs/heads/...", which is not what I would expect. I always
> >>> believed that command line options would overwrite configured options.
> >>>
> >>> Is my assumption that command line options always win wrong or is this a
> >>> bug?
> >>
> >> It's a bug.
> > 
> > No it isn't.
> > 
> > Elijah is elevating to fact his opinion of what --ff-only should be
> > changed to.
> > 
> > But it has not been changed. Today --ff-only is meant only for the merge
> > mode of `git pull`, and like other merge-only options (e.g. --ff,
> > --no-ff, and --squash) it's ignored in the rebase mode.
> 
> Shouldn't every explicitly given merge option (like --ff-only) overwrite 
> any configured option that would not even result in a merge, i.e. 
> forcing a merge and thus forcing ff-only?

Perhaps. Other developers have suggested that before.

The problem is that everyone wants to make --ff-only the default, and
then we start to get into a tricky situation, because what should these
do:

  git -c pull.ff=only pull
  git -c pull.ff=only pull --merge
  git -c pull.ff=only pull --rebase

One of these will always fail, when it shouldn't.

I proposed a solution for that, but is has been ignored.

-- 
Felipe Contreras
