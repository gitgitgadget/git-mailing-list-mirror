Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41F220248
	for <e@80x24.org>; Tue, 12 Mar 2019 19:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfCLTXW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 15:23:22 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38351 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfCLTXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 15:23:22 -0400
Received: by mail-ua1-f66.google.com with SMTP id d4so1198086uap.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TINCbcjI2bzAgsTD0F744QzMGZpF5ZeHeAC0Tel949w=;
        b=oorwZ4TPI9bLpPcmt6Qm46eJbdtT0dcSR2a9WExrGekPjsHFzPIqW0AAaeUdOiQhMx
         rcz4b0oVCJ31yquGDXlpl9dgyyfFbxVQfPz03A/V4uHteB/DU3PZpri3xLA35D+VcH0E
         3NDS0KtEygEX18sx7aJ3P5+0VzZk97xEmx8O2fhwMnc7tIf7naF/aS4NS/gUcM+npMTX
         NR23WIa6EbJn3TL4rs65ej4YUA6XKcjQC5tD2ARLnnA7lLNWo7U0FJRZM7b94QGILwPp
         tJPG/O0ljUxYJ6ZxI03LeeNFb1/2UO+C773TvJJxowXqaT65jME0aGZ7ETFixltUjDOl
         NuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TINCbcjI2bzAgsTD0F744QzMGZpF5ZeHeAC0Tel949w=;
        b=CbzJ66KlqnlG/ctbMzeLAtsY/pLv+Dwj6UVxjo97aio1viYXjXW4RHluG5jccwPO1U
         4BRCqwGAsStY8ifotjYBr4cW+OXYBrerq2HPVt3AcRNv0TxKtUCFqnBfjsIe4SRq9PyQ
         ZV+I4lv3VBzaNKbC47CjeZs/ghNzVJd663PVJ+o1h5nwhLSwAyHPSN5fX0O/1Tq7RX+h
         RifYHCCB1V/8z6UddNphoCiUUFUpIby5FkA7OGbFJIWpOrXxqBX9Q5BsAgwTQSWB1005
         hObWpFPyYbcVRkFNzzmnCtMtc8IFNPoFvCUVYV4uSeWnV+UiyKBg9j91GAwMuq+3aXzn
         dRyw==
X-Gm-Message-State: APjAAAXj/AVUWGHr4EtnUpX25wuigP31DS3iI+Jga5qJ1kBP0cx2ECpo
        TYZ9u3msRNTo+atZDnS5LdxUgAVf7MOQ9012SLQ=
X-Google-Smtp-Source: APXvYqyd9PhtWxH6PtQIGc8ou+sgJ10NLq+zbjr5dHKD86l0FeCJDLPrkATXtfPurf82Rw7Jg8X9VfniTuoMr0t8izE=
X-Received: by 2002:a9f:3205:: with SMTP id x5mr19800826uad.104.1552418600786;
 Tue, 12 Mar 2019 12:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <87k1h55bx0.fsf@sergiodj.net> <CACsJy8ANLkz=3cj1dAuHdUCkrgQzos=90EEG0n901o3QAp3PUQ@mail.gmail.com>
 <877ed459eh.fsf@sergiodj.net>
In-Reply-To: <877ed459eh.fsf@sergiodj.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Mar 2019 12:23:09 -0700
Message-ID: <CABPp-BFnxhiXfvZUZndD-_htMEw0bZzrLRFpAF9u5YV3wi6qnA@mail.gmail.com>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
To:     Sergio Durigan Junior <sergiodj@sergiodj.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 9:48 AM Sergio Durigan Junior
<sergiodj@sergiodj.net> wrote:
> On Tuesday, March 12 2019, Duy Nguyen wrote:
>
> > On Tue, Mar 12, 2019 at 5:18 AM Sergio Durigan Junior
> > <sergiodj@sergiodj.net> wrote:
> >> This works without problems most of the time (well, usually there are
> >> conflicts and all, but that's a burden I have to carry).  However,
> >> sometimes I notice that git fails with:
> >>
> >>   # git rebase origin/master
> >>   ...
> >>   Applying: commitX
> >>   Applying: commitY
> >>   Applying: commitZ
> >>   fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exists.
> >>
> >> The first thing I did was to check whether the index.lock file existed,
> >> but it doesn't.
> >
> > Is the output this clean? What I'm looking for is signs of automatic
> > garbage collection kicking in the middle of the rebase. Something like
> > "Auto packing the repository blah blah for optimum performance".
>
> Yeah, this is the exact output.  I also thought about "git gc", but I
> don't see any output related to it.  Is it possible that it's being
> executed in the background and not printing anything?

Any chance you have a cronjob or other task execution mechanism that
is running git commands in various directories (even simple commands
like 'git status' since it's not read-only contrary to what some
expect, or 'git fetch' which might trigger a background gc)?
