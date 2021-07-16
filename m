Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D341C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7734F613D4
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhGPQrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGPQru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 12:47:50 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DE7C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:44:55 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so10455316otp.8
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RN5+Pe56KQvdrpTssQ0ziVUGa1hIzfBja9WYdXva7+c=;
        b=fzMggxpEs4+zqTZVQ82RclNAE7dZ8RrxSpPbPrxmTcrnFu8uUqWBnAH2czFSX0Eqv1
         0T4Rxg6kj81tifHnSUg/KhEZEflAcV/uYidX4uw10COiLfsEKLjeu12i9niIYjAdbq0z
         M7CWxOl6bgj+6Qz+UFnOq4WL/SHIu0z4b+yPxulQGh0rxeqTdzCpvMMG2WiAENZkZv/c
         vXnNSHwE6QTg1zS1ix+woef+XvLXu6UW3E28cNpOrqkNJ8mDiONnrUYmbf4mgBtyuShi
         CcmB8Qi+3WbWyEW/Gv5Nu+kwqOQWx4rqKbandvlQQ0+kAWuKTEy//praRnX7wIcmb8XI
         /Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RN5+Pe56KQvdrpTssQ0ziVUGa1hIzfBja9WYdXva7+c=;
        b=JdwdXhVGHCxoDKIj4pvDGeQjvycf6RRs1f3rumjzFNTaG/4W2YBWIvRPTyYopButTl
         5G0Vr3LoprZvFDBjI7KCFLleDA1Vi3ydfR/dAeM01VRYG0QL2SPyDm+cINb+POOMYMb4
         P1lzliSWp26zYKgPZ2AFPUPlqw7TsYGvV1MFia3sN+A/QjiBv1y11xzTiT6HnOkTGrYu
         yELY25BCTQCFjYSv5vZGwtbz8bXDo18ygG0Fta04rQYCtneoU2VE/hoZFnWh7J52gOTL
         d2wu0O2gvJZrxZzqqIHlq/yJBa0pQAx7WKpipgW9vWqyCsQG5+G+B9oNWkohr30FjSX2
         8hKw==
X-Gm-Message-State: AOAM533om33eQOxQq61RKkMxnlKEzgcgabgd19siWCtif8QF6mEbC/2O
        ijMVBOGKxzA+Qz0wQERhg4c=
X-Google-Smtp-Source: ABdhPJw6mj7boI5aH6yukMjn5kIJ1V0Iu0cvmU7AMHa4HjJykCgjzlZoC1e1Z88gW1L0sTPc7nRhOg==
X-Received: by 2002:a05:6830:10e:: with SMTP id i14mr960167otp.242.1626453894829;
        Fri, 16 Jul 2021 09:44:54 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id p9sm1948488otl.64.2021.07.16.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:44:54 -0700 (PDT)
Date:   Fri, 16 Jul 2021 11:44:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60f1b7853b8a2_ade9208c1@natae.notmuch>
In-Reply-To: <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
 <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
Subject: Re: pull.rebase config vs. --ff-only on command line
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, Jul 16, 2021 at 7:52 AM Matthias Baumgarten
> <matthias.baumgarten@aixigo.com> wrote:
> > this is my first time contacting you guys and girls so I hope this mail
> > achieves the expected standard. I've discovered the following behaviour
> > of git:
> >
> > If pull.rebase is configured to true and git pull --ff-only is executed
> > it seems like the config wins, i.e. issuing "Successfully rebased and
> > updated refs/heads/...", which is not what I would expect. I always
> > believed that command line options would overwrite configured options.
> >
> > Is my assumption that command line options always win wrong or is this a
> > bug?
> 
> It's a bug.

No it isn't.

Elijah is elevating to fact his opinion of what --ff-only should be
changed to.

But it has not been changed. Today --ff-only is meant only for the merge
mode of `git pull`, and like other merge-only options (e.g. --ff,
--no-ff, and --squash) it's ignored in the rebase mode.

-- 
Felipe Contreras
