Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56A1C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4332225F
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="e4RPOtae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503537AbgJURb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503534AbgJURb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 13:31:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3EC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:31:57 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h12so2784979qtu.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bfe2KH6t0nEEBdoCOsUSeFYsDOCmYCTuSQRo9khsa2E=;
        b=e4RPOtaeeu2pIAufqkdcjD80FD+bG277weCBM3voNQbMeOHqudJPFAJoASXoglwGWE
         dc49LS+Sqm053Msf+INvXj1xwQ6jYzTaixd3tkS/HcUwx06YntZH64Jx8D1oB2dBGEUl
         4/Bsn3SNFyGZ4CBqsJCWbuG6Kp8VovxkI8+jNhg2HPGYn1a7JrWBhkPIbf0P5w6wY3cM
         ofciEb/IELbhPkB/ZORCzBuaIEqoljxjDgjiKFfEOpsNwjNelOVgW08vXTtOlygdpsho
         JyynGvzUjwc49+OpKUNBfZUzx8Dat5Iigs5Z2SCAUIVM4QXCry09RZs/CMNlBzNNyGSM
         z/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bfe2KH6t0nEEBdoCOsUSeFYsDOCmYCTuSQRo9khsa2E=;
        b=tAEXNW58MRYw7syj7vqVtYhjIU+I8zjD2/LIvBeHV2IFLB1rwjKupvy2T4WHMf4EkU
         D4XkExdu/HJqe3vC0gfqH1+GrH+a5h/ixrvDMS+wdQ6fa9iWGOnVqckn7jLw942tlxLI
         H8Mrn3cUcLoj3GQhUGI9hupPt2WwzGePPtWADravIUarLjisGP154xKRFd4GqUET3iIc
         2jOaqyyWI//Y+RjR7QdsyaHbGKhyM6OJ+iCllF2oU9rjHfplF1At4bNWoChXNCZGGgsu
         i9ct7qM16/NunG9CCdDeMBV3RVNezApwq26yYa+39n8MMUwV6sOKYtK//jeO61GUwdLe
         KILQ==
X-Gm-Message-State: AOAM531Y5aa6UTbHSjfP36bAUnScNsmUbGn46SCXNoWQXg01oWg8RvP+
        vqM5+YbPSKNmBVVhjHBi2Jv3XQ==
X-Google-Smtp-Source: ABdhPJxaeL6CzdGqbCduK0gf2P6bAitVjq/YQk3mZRUfTAtm11t/iXpCt7rl4mdKeymNUOTNY22rmg==
X-Received: by 2002:ac8:74d:: with SMTP id k13mr4154126qth.54.1603301516618;
        Wed, 21 Oct 2020 10:31:56 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id b191sm1728430qkg.81.2020.10.21.10.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 10:31:55 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:31:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        christian.couder@gmail.com, jonathantanmy@google.com,
        Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Questions about partial clone with '--filter=tree:0'
Message-ID: <20201021173153.GC1237181@nand.local>
References: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
 <20201020222934.GB93217@nand.local>
 <a4a20c67-4ee3-77b2-8d57-f30843572aa4@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4a20c67-4ee3-77b2-8d57-f30843572aa4@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 07:10:02PM +0200, Alexandr Miloslavskiy wrote:
> We currently do not intend to use '--filter=tree:0' ourself, but we are
> trying to support all kinds of user repositories with our UI. So we
> basically have these choices:
>
> A) Declare '--filter=tree:0' repos as completely wrong and unsupported
>    in out UI, also giving an option to "un-partial" them.
>
> B) Support '--filter=tree:0' repos, but don't support operations such
>    as blame and file log
>
> C) Use some magic to efficiently download objects that will be needed
>    for a command such as Blame, while keeping the rest of the repository
>    partial. This is where the command described in (3) will help a lot.
>
> We would of course prefer (C) if it's reasonably possible.

(C) is probably the most reasonable. If you have a promisor remote which
is missing objects, running 'git blame' etc. will transparently download
whatever objects it is missing.

> Unfortunately this does not work as expected. Try the following steps:
>
> A) Clone repo with '--filter=tree:0'
>    $ git clone --bare --filter=tree:0 --branch master
> https://github.com/git/git.git
>
> B) Change filter to 'blob:none'
>    $ cd git.git
>    $ git config remote.origin.partialclonefilter 'blob:none'
>
> C) fetch
>    $ git fetch origin
>    Note that there is no 'Receiving objects:' output.

Ah; I would have thought that the server would have sent objects, even
though we have lots of 'have' lines, since we are treating the server as
a promisor remote and might not have the full reachability closure over
the haves.

Jonathan Tan knows better than I do here. Maybe he could chime in.

> > I think what you probably want is a step 1.5 to tell Git "I'm not going
> > to ask for or care about the entirety of my working copy, I really just
> > want objects in path...", and you can do that with sparse checkouts. See
> > https://git-scm.com/docs/git-sparse-checkout for more.
>
> For simplicity of discussion, let's focus on the problem of running
> Blame efficiently in a repo that was cloned with '--filter=tree:0'. In
> order to blame file '/1/2/Foo.txt', we will need the following:
>
> * Trees '/1'
> * Trees '/1/2'
> * Blobs '/1/2/Foo.txt'
>
> All of these will be needed to unknown commit depth. For simplicity,
> the proposed command will download these for all commits. Specifying
> a range of revisions could be nice, but I feel that it's not worth the
> complexity.
>
> Correct me if I'm wrong: I think that sparse checkout will not help to
> achieve the goal?

I see what you're saying. Here sparse-checkout and partial clones
confusingly diverge: what you really want is to say "I want all of the
objects that I need to construct this directory at any point in history"
so that you can run "git blame" on some path within that directory
without the need for a follow-up fetch.

> This is why I suggest a command that will accept paths and send
> requested objects, also forcing server to assume that all of them are
> missing in client's repository.

In any case the '--filter=sparse:<oid>' bit is not recommended for use,
but perhaps this is a convincing use-case. I didn't follow the partial
clone development close enough to know whether this has already been
discussed, but I'm sure that it has.

Thanks,
Taylor
