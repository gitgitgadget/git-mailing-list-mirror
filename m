Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031F61F453
	for <e@80x24.org>; Wed,  3 Oct 2018 07:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJCOgp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 Oct 2018 10:36:45 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:33803 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeJCOgp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 10:36:45 -0400
Received: by mail-qt1-f170.google.com with SMTP id x23-v6so4938337qtr.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 00:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9BZm1h2hbY6X91cR83HNjs7mh+cogK7ZdbykIBMUuHk=;
        b=dq2R1uMcCJEuhknIWuDAbhR6PG3ppAeykQeZ7Wb0lkmWvgFhwbRlkj0OQV1BUe3ouh
         Emr7uXED1SuMW5ixM9eHU7ohCdFX7WHndY98yKIgSybjxMs/uRfY3AV9tMROuMrLlKoB
         hlzupdQNuHwFhCMy913ngjjqrBm1y2HdTKph2+SMtuyo7jMfGTm9pKlBXTxegXZmM/RP
         Atd1LSAgxvkfsD5JmcpxjKpxagwd++yjQB8NThTSxo892vu/Cpr5wJjmk8HcoKgYh1+L
         xPw8Lekfed0Vv2b2CtikjuY1XPOlhYSn23OUEDG8uvbLAGF6wZiYvNh3gmX/A9aiDJDd
         aNyQ==
X-Gm-Message-State: ABuFfoiUkp7eBxDApAtyyf3Du8ZbRtcBB7Q5BeEicGynkHvIs6av74Ia
        Cr6jz0zDNqzWRVeqLf29MwHzjwZTmyUv0N0Xrv0=
X-Google-Smtp-Source: ACcGV60TCZcppBfoG/HSAAfWuzR/1bX2/gO7qlp/h6ihgAgxHSn8/I4gcEkQEVw28SluKvybTx6zaBLss5aZ1Mw2axw=
X-Received: by 2002:a0c:b3d6:: with SMTP id b22-v6mr181371qvf.203.1538552970379;
 Wed, 03 Oct 2018 00:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180929191029.13994-1-pclouds@gmail.com>
 <20180929191029.13994-9-pclouds@gmail.com> <CAPig+cQBiXRvzf6skmmyVap-6fLEbmVRGNBQqD4H-HfAPampjA@mail.gmail.com>
 <CACsJy8C1niWzC8GPiKkXmyBwxbctb-vmM51CVts12TMzLFnJVA@mail.gmail.com>
In-Reply-To: <CACsJy8C1niWzC8GPiKkXmyBwxbctb-vmM51CVts12TMzLFnJVA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Oct 2018 03:49:20 -0400
Message-ID: <CAPig+cSHRus=zTd0reWoFMi+ERbjQO92tNhJBT9jnmUP8vvm3Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] reflog expire: cover reflog from all worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 12:16 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Sep 30, 2018 at 7:36 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, Sep 29, 2018 at 3:11 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > > +--single-worktree::
> > > +       By default when `--all` is specified, reflogs from all working
> > > +       trees are processed. This option limits the processing to reflogs
> > > +       from the current working tree only.
> >
> > Bikeshedding: I wonder if this should be named "--this-worktree" or
> > "--this-worktree-only" or if it should somehow be orthogonal to --all
> > rather than modifying it. (Genuine questions. I don't have the
> > answers.)
>
> It follows a precedent (made by me :p) which is rev-list
> --single-worktree. I doubt that option is widely used though so we
> could still rename it if there's a better name. I made
> --single-worktree to contrast "all worktrees" by default. Even if it's
> "this/current worktree" it still has to somehow say "everything in
> this worktree" so I felt modifying --all was a good idea.

Precedent overrides bikeshedding, so leaving it as-is is fine.
