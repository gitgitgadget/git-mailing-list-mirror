Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ABCC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D6264E24
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhBWTe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhBWTeI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:34:08 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517FC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 11:33:28 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id n68so11693643qke.10
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 11:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Z51VY4NaVi5WqoTIs0VRSQ2jW8kwd0fvn4UGx5tZXcg=;
        b=lRSJruqJcUaZEvwF5i9ucxIr0T/3DXnxnKctvspftXYKFzL943sermaIPMQNmu/vdr
         FxSMUf492jkWneqWrQNdeUGuaJkD+/8jKLVqxvIsA8Pd8Xmx9QDtld2ZvStK/5c+Pzgb
         Q/vyySA5GXnqHROtnhPEFR8+ujUx2gcExhmH5qrWTWZA8u46FR0SfKoHBzJuYX8/kNqT
         11TbUa7cUfU4GFp4D23/XFjOGCN8UdlUg6afGKnxDp9kxucdvCTAn6JtTgiiTmJqW1TS
         0CpyMc7KQxL485lsxu+gpr5xp4ouZb+/dB00ZWCiARlt+jvN7f+IsNDM40pMSrMferqF
         Zyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z51VY4NaVi5WqoTIs0VRSQ2jW8kwd0fvn4UGx5tZXcg=;
        b=gFin+e0YMbsJqN9GJ+1Kbkzl649w1GZXK7CCvZzhkXCBxvk7pWI39n2Vg55Pj35uCx
         ZL2OlMmXAVGEvivZUsBHN9bhz+M71u9SfJj0u0xC6fTAZnbZXXLADsoFLK9gw74LytMp
         Ko66qapPZHTEykd0L1/GV7CXRyqnfu3nva0lOYSbZ5tYOlVkQH4irvBCRSSAx0RAdPNG
         ShIYWPqg029zrZqBcP6N802COAcwSxCVHMItKTvTxcVxL4Pri/Yl1zUHkXLvjDQnIGgm
         SJ6w7Zn51WFN3j+rJ+U7b1m0r2PPYlAgrIxwNt4TXXzEaPHgLuZ9mS6HJ8uVMCoTEJwx
         voRg==
X-Gm-Message-State: AOAM530ph4kiDc4IyFcQhXV/Qkv2k56aEKIQ493P8R+nGVm6LVWlEfES
        UXUGpaTGo/Ad9wSw+B1dUrVgNTpxgYn9D/vL1Rog
X-Google-Smtp-Source: ABdhPJzslA4vMB17mlHAj3kdNvd9QDGMt95OUjXO032vb8Jyk+y3Frc+wyYjzf2n1PCrZCfF4DqvNtFbbQKWmx7Jtn50
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:8f09:: with SMTP id
 z9mr26619546qvd.25.1614108807089; Tue, 23 Feb 2021 11:33:27 -0800 (PST)
Date:   Tue, 23 Feb 2021 11:33:24 -0800
In-Reply-To: <YDRAbcqtWRpVn703@google.com>
Message-Id: <20210223193324.1660502-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YDRAbcqtWRpVn703@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v7 14/17] run-command: add stdin callback for parallelization
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > +/**
> > > + * This callback is called repeatedly on every child process who requests
> > > + * start_command() to create a pipe by setting child_process.in < 0.
> > > + *
> > > + * pp_cb is the callback cookie as passed into run_processes_parallel, and
> > > + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> > > + * The contents of 'send' will be read into the pipe and passed to the pipe.
> > > + *
> > > + * Return nonzero to close the pipe.
> > > + */
> > > +typedef int (*feed_pipe_fn)(struct strbuf *pipe,
> > > +			    void *pp_cb,
> > > +			    void *pp_task_cb);
> > > +
> > 
> > As you mention above in the commit message, I think the clearest API to
> > support what we need is to just have a callback (that has access to
> > child_process) that is executed between process start and finish.
> > 
> > As it is, I think this callback is too specific in that it takes a
> > struct strbuf. I think that this struct strbuf will just end up being
> > unnecessary copying much of the time, when the user could have just
> > written to the fd directly.
> 
> Since the rest of the run_processes_parallel() API passes strings around
> with strbufs, I'd prefer to leave it as-is to match the general API
> expectations and style.
> 
>  - Emily

By the rest of the run_processes_parallel() API, do you mean
get_next_task_fn, start_failure_fn, and task_finished_fn? If yes, I
think that it makes sense for them to be strbuf, because buffering is
needed to avoid outputs from individual child processes interleaving,
but that's not true here.

Having said that, this is an internal API so we could just leave it
as-is and then refactor it if we ever need something more flexible.
