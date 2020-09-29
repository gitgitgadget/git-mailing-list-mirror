Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708CCC4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4512083B
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2qaEQPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgI2Vfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2Vfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 17:35:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BDAC0613D2
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 14:35:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so7057181wrx.7
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3eT36w2GhD+DcWbvGOcpHR9AqOCr1Dl8n2v0thRSYcU=;
        b=p2qaEQPzBqU26K1Q9cAScBd7hfrC6BhZ++IYRYiaNeALiOos7TCsnO9hACEQwJFcfF
         CHc5T+ylkREz4lip92WBpnmCUCUqEjGs4pkLL4+ojsjJF3wQNhIJElcwt10+Afjv6des
         9aV6HEJCJ94iNC2OyigkQk+e36fvFjeVSdakxx6Gx4Xd7rmFJEJsHO3qMg1uehpcnBN3
         4otJRyAcmetTxGi1AuPljYZ8G7SIaCYWIZlOwk8XmWFjLampA8oSnZCRbhpZJ94HWIlM
         gwZKheOt3hOHQQ4zN2bUou/asOx9b56i7B9X6Si6jTW2ndvfcVJP6USe9HvwnAe+RQfl
         dsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3eT36w2GhD+DcWbvGOcpHR9AqOCr1Dl8n2v0thRSYcU=;
        b=K7+gsEYJSY2cL7kXATLmUzl/T2CuMMvbQOlgpCrkyTlaectVzAJMGi5sDiQHfEh0dq
         7Gpj81vK4TMPm1w27Bwep8zlDSnViT1a6NOYGx0N+oiBFkTrZi+rJiRR79KYm5x46cLt
         GbT5nMk9L6BU08nw30JOQtykk9sO4a/T7eBIYFzZ2JGlv0mXP722OVwF9dHxR5EP+Gkf
         nX5h5T0U4AdbkNeSwE4PX40ExrQx5sPbxJ/2hTwKjYJ491f8o4lcRWeNjwd89Bvbg5we
         qAxhl5l3/EKrL5vgCqncEcY+hpZccaoqNhVaus7kNqZgF98/BQ4IcSssS5X1ufjkpVYh
         aYnQ==
X-Gm-Message-State: AOAM532fYShVmM2ggoTWgobx/zmei9CYOb4JYwyjUykGk1nBFxSP+dek
        Kucm1r4E7ma/85XjcCq0RM93eE+Vsi8=
X-Google-Smtp-Source: ABdhPJyBweRKZnv12R6M7Dnq/IMQbA858Fkv1+EwWF9tDKUM6tUUXgClAI3uFaVfnni0HKLg8vzavg==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr6281614wrw.379.1601415331610;
        Tue, 29 Sep 2020 14:35:31 -0700 (PDT)
Received: from contrib-buster.localdomain ([212.86.35.59])
        by smtp.gmail.com with ESMTPSA id n10sm7356237wmk.7.2020.09.29.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 14:35:30 -0700 (PDT)
Date:   Tue, 29 Sep 2020 21:35:29 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] teach `worktree list` to mark locked worktrees
Message-ID: <20200929213529.GA1336@contrib-buster.localdomain>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <xmqqft71lhty.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqft71lhty.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for all the feedback, I will work on a another
patch that will address all the feedback provided on this series,
including having the changes into a single patch.

On Mon, Sep 28, 2020 at 02:19:53PM -0700, Junio C Hamano wrote:
> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
> 
> > This patch series introduces a new information on the git `worktree list`
> > command output, to mark when a worktree is locked with a (locked) text mark.
> >
> > The intent is to improve the user experience to earlier sinalize that a linked
> > worktree is locked, instead of realising later when attempting to remove it
> > with `remove` command as it happened to me twice :)
> 
> Change with a good intention, it seems.
> 
> > The patches are divided into two parts. First part introduces
> > the new marker to the worktree list command and small documentation
> > change. And the second adds one test case into t2402 to test
> > if the (locked) text will be properly set for a locked worktree, and
> > not mistankely set to a unlocked or master worktree.
> 
> Probably they belong together in a single patch (I am saying this
> after only seeing the above five lines, without reading either of
> these two patches, so there may be some things in them that makes it
> make sense to have them separate).
> 

Yes, I believe it make sense to have them in a single patch.

> > This is the output of the worktree list with locked marker:
> >
> >   $ git worktree list
> >   /repo/to/main                abc123 [master]
> >   /path/to/unlocked-worktree1  456def [brancha]
> >   /path/to/locked-worktree     123abc (detached HEAD) (locked)
> 
> Looks OK to me
> 
> > This patches are marked with RFC mainly due to:
> >
> >   - This will change the default behaviour of the worktree list, I am
> >     not sure whether will be better to make this tuned via a config
> >     and/or a git parameter. (assuming this change is a good idea ;) )
> 
> The default output is meant for human consumption (scripts that want
> to read from the command and expect stable output would be using the
> "--porcelain" option).
> 
> The ideal case is a new output is universally useful for everybody,
> in which case we can just change it without any new configuration or
> command line option.

Thanks for the explanation, will keep that in mind.

> 
> >   - Perhaps the `(locked)` marker is not the best suitable way to output
> >     this information and we might need to come with a better way.
> 
> It looks good enough to me.  I am not qualified to have a strong
> opinion on this part, as I do not use the command all that often.
> 
>     $ git shortlog --no-merges --since=18.months builtin/worktree.c
> 
> tells me that Eric Sunshine (CC'ed) may be a good source of wisdom
> on this command.
> 

Thank you, I will keep Eric Sunshine in the loop as well.

> >   - I am a new contributor to the code base, still learning a lot of git
> >     internals data structure and commands. Likely this patch will require
> >     updates.
> 
> Welcome.

Thank you.

> 
> > Rafael Silva (2):
> >   teach `list` to mark locked worktree
> >   t2402: add test to locked linked worktree marker
> >
> >  Documentation/git-worktree.txt |  5 +++--
> >  builtin/worktree.c             |  6 +++++-
> >  t/t2402-worktree-list.sh       | 13 +++++++++++++
> >  3 files changed, 21 insertions(+), 3 deletions(-)
