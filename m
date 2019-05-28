Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F361F462
	for <e@80x24.org>; Tue, 28 May 2019 00:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfE1AL6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 20:11:58 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41874 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfE1AL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 20:11:58 -0400
Received: by mail-ua1-f65.google.com with SMTP id l14so7143854uah.8
        for <git@vger.kernel.org>; Mon, 27 May 2019 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpZ5YHMW83OAVGzHIT1QjvKLRzPXFd4hcUJ4SLkWbLw=;
        b=AsOHuF+Jn89nZqMevfavJvl3LvG1CthNG5s7OVbPte/7IEkKTF9o7UA7C/Pez7BxJL
         7ynaxdlDjmcF3+zR+yHp2ovZ9h4CCEY1O6qmxMlxmGsfRhNwZIIKLT5reCmiRMHrMx/a
         m4HTnEtRmpJkIJKkJtitT53eA85mg1cau5xJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpZ5YHMW83OAVGzHIT1QjvKLRzPXFd4hcUJ4SLkWbLw=;
        b=cISk0r5BLZbA3DVpOIjBzty/Pb3MuBUqRcTJvV+2liTg9OOP9TEjOzWf9HM3x6jbUy
         6L+r3n9hLROFEueSHLOeXTzJCpN9KwKK9twIFfejtDzg1t4s1lRbDOxN4GFl1eMcqRfG
         aLrnZ7Dtaln4a805WWp31WQDRMKZv9nhN7j/CmmsSo/1q5UE0V7ayNC9/zuhtfodvb+W
         tojKaz4KaazKXRYvUpY26Flf2ucbSz71cF3HFJuIjrcjBsRxQigiOM/Pq4nQsp2Wvnv+
         uBGbCNX/QrFTqxUXTcSEMwRQzRQ/L/AmmFFRw/nNYzT1Nq2MRT2fpnSYQXzuuSFIajJg
         mtLQ==
X-Gm-Message-State: APjAAAVHxsCN27C6dJwk6NGxnWsofnZyhARe2E3rRc8ShFz8O8NxOqLc
        AUAVYz7DGDs3tkeK8DPtxSDJYJwNztssL9KF4oVuow11
X-Google-Smtp-Source: APXvYqydLkR5kK0/VWA0PtXqsdwkEzmgn4J5IdmS1gvd/6t3Pt0mWfYVIHJCd76SVRfxJ2g+tWk9ztbwy7HYZhG+m3Y=
X-Received: by 2002:ab0:7150:: with SMTP id k16mr28369256uao.22.1559002317016;
 Mon, 27 May 2019 17:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH_=xoYQEvXKnhyZsUeZ=VTEMOpOdgbd-57f7-6M+2KQLSAAUQ@mail.gmail.com>
 <20190527211245.12292-1-newren@gmail.com> <CAH_=xoZ5Lt2nn50cfDbTA-ZVeshi8HZ91Od4btuUXpBGCanGng@mail.gmail.com>
 <CABPp-BFkqyGT_YHReKPJKy-nX5eWYhb9AVE2UeD7M+nhKT0dqg@mail.gmail.com>
In-Reply-To: <CABPp-BFkqyGT_YHReKPJKy-nX5eWYhb9AVE2UeD7M+nhKT0dqg@mail.gmail.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Mon, 27 May 2019 17:11:45 -0700
Message-ID: <CAH_=xoY+3_uEJ0VRVwP6vqLKdWzzU8hjLosf6sjjJtqP4mW=ng@mail.gmail.com>
Subject: Re: [PATCH v4] fast-import: checkpoint: only write out refs and tags
 if we changed them
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 27, 2019 at 4:27 PM Elijah Newren <newren@gmail.com> wrote:
> That sounds good...though it's taking my short patch and just about
> amounts to completely rewriting it.  Would you like to take it over
> including authorship, and just add either a "Original-patch-by:" or
> "Based-on-patch-by:" for me in the commit message (these two tags
> appear to be the two most common attribution mechanism used in
> git.git's history when someone does this)?

Sure. Co-authored-by is an option too. I'll turn all of this in 3
patches: improve background_import, your patch, the rest of mine.


> > > +       cat >input <<-INPUT_END &&
> > > +       feature done
> > > +       commit refs/heads/V3
> > > +       mark :3
> > > +       committer Me My <self@and.eye> 1234567890 +0123
> >
> > You likely want to use:
> > committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
>
> I see other tests in that testsuite using this, and using it here
> certainly wouldn't hurt; I'm not opposed to it.  But I'm
> curious...other than "other tests in the same testcase use it a lot" I
> don't see why the choice of committer name/email/date matters at all.
> Is there an actual reason for this that I just missed?

There is no direct benefit here except consistency.

These vars are set the same on every test run so that the SHA1 of
generated patches is the same as in a previous run (see also
test_tick() to increment the date by one minute). So in general this
makes it easier to debug tests as hashes can be compared between runs.
But your hand-picked values do give you that property.

However, as normal git commands use the vars automatically, by using
them here, fast-import commands and direct git commands produce the
same hashes if they're doing the same work. That's the main benefit of
using them here: while the test does not currently rely on that
property, maybe it will (or someone debugging down the road will
expect that).
