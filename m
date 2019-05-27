Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393BD1F462
	for <e@80x24.org>; Mon, 27 May 2019 23:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfE0X1Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 19:27:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36810 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfE0X1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 19:27:25 -0400
Received: by mail-vs1-f67.google.com with SMTP id l20so11600457vsp.3
        for <git@vger.kernel.org>; Mon, 27 May 2019 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLCwGywsEwF5VjXfrWgvD5lR8Z8r6MyaV3Rzltm4eCQ=;
        b=BsdUZwSxJ4CO0hayMRzmHulmaP92yThbBnH9DWFO8Y8xfU0FNSGZ6x8Je/DEKzQcdz
         iYr9xK2F3yjmq8sZXYLVo9N22ATsbeSno7qRoDlUoRPVnndQTOUq8LSBxJGiZ9cPQxI4
         2m7NeukxHvx9u7Q773+nTvjyFjHjAoPZdPOnKADZ7FLjzPlNZuudrcd3xZc3qvJimJN7
         T41hQvau7hdKoqI7VhMy7jEfHnE7PUJ4sUiN91gZkQoD7hXnvKni3hXWazf913IIfWWJ
         2I19CEeKrf3exQWB3vpTr/Vn/rvBlmVwaXzxLNEjqkboixQmMI6MYh0x5RD7Gag3L8le
         N6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLCwGywsEwF5VjXfrWgvD5lR8Z8r6MyaV3Rzltm4eCQ=;
        b=TtAlQWTFFKPSdlZZiyZ8YL8UV7WgJAo5Jr+dy/x74ZxfwMjlGix+59JeixpR8a7nvL
         FR//8qt+FTOW5364ktng7hAcjsEuErUA8bofmpJfnCfOd6jIzM6+QFLvjzO0ik0LfG6q
         KQ+uYARvUNr+kI04n5zexfVyENcz1HBk5AGJSrUpz8NYy0u+3lanKsbWsJrQUfrXa+Wn
         TjaEuHqIV1CGTMlxuibOksUmsU7z3Cwm+6X//urO6DdpppKcg0dvzzIy3xWlFDaeZk3Y
         8ArkNFOvsb4CFStE4PBfe4/XN5tFWbeCqTJDK/NZCyIXVte1XeBDRN+LGkiKKZqHhnfX
         w52A==
X-Gm-Message-State: APjAAAXSGBIVpKswJTw2CABx7CHCEqgIEdqrcs3YnMPU6+pgGY/tRP6q
        54BixEcZJaAowjYsj8PM5cROVAQG4EpT9ZJ1DAr4pdUg
X-Google-Smtp-Source: APXvYqwnyFBMVSBkXX9GNshgaj42CNrRAO/xZiK/6NKSMkMaZGwH0KFndGaFqwFOrpaCKrEqBl2juPaLUsW5dqfHb4M=
X-Received: by 2002:a67:6484:: with SMTP id y126mr41487967vsb.117.1558999644591;
 Mon, 27 May 2019 16:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAH_=xoYQEvXKnhyZsUeZ=VTEMOpOdgbd-57f7-6M+2KQLSAAUQ@mail.gmail.com>
 <20190527211245.12292-1-newren@gmail.com> <CAH_=xoZ5Lt2nn50cfDbTA-ZVeshi8HZ91Od4btuUXpBGCanGng@mail.gmail.com>
In-Reply-To: <CAH_=xoZ5Lt2nn50cfDbTA-ZVeshi8HZ91Od4btuUXpBGCanGng@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 May 2019 16:27:13 -0700
Message-ID: <CABPp-BFkqyGT_YHReKPJKy-nX5eWYhb9AVE2UeD7M+nhKT0dqg@mail.gmail.com>
Subject: Re: [PATCH v4] fast-import: checkpoint: only write out refs and tags
 if we changed them
To:     Eric Rannaud <e@nanocritical.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, May 27, 2019 at 3:46 PM Eric Rannaud <e@nanocritical.com> wrote:
> On Mon, May 27, 2019 at 2:12 PM Elijah Newren <newren@gmail.com> wrote:
> > On Fri, May 24, 2019 at 4:10 PM Eric Rannaud <e@nanocritical.com> wrote:
>
> I think the test will not fail without the patch (and therefore won't
> catch a regression): while checkpoint doesn't currently check the
> failure flag, it will be checked when cmd_main() returns so
> exit_status will be 1.

Ooh, good catch.

> You either want to:
> - (a) add more independent commands after the checkpoint and check
> that they were not run,
> - or (b) run with --done, do not include a done command, and check
> that fast-import does exit (but it's racy),
> - or (c) you can reuse background_import to have a more explicit
> sequence of events (in which case improvements to background_import
> from my patch would have to be committed first).

That sounds good...though it's taking my short patch and just about
amounts to completely rewriting it.  Would you like to take it over
including authorship, and just add either a "Original-patch-by:" or
"Based-on-patch-by:" for me in the commit message (these two tags
appear to be the two most common attribution mechanism used in
git.git's history when someone does this)?

> > +       cat >input <<-INPUT_END &&
> > +       feature done
> > +       commit refs/heads/V3
> > +       mark :3
> > +       committer Me My <self@and.eye> 1234567890 +0123
>
> You likely want to use:
> committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE

I see other tests in that testsuite using this, and using it here
certainly wouldn't hurt; I'm not opposed to it.  But I'm
curious...other than "other tests in the same testcase use it a lot" I
don't see why the choice of committer name/email/date matters at all.
Is there an actual reason for this that I just missed?

Cheers,
Elijah
