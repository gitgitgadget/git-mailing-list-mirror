Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D5DC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 09:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0648C20724
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCMzBNiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDXJCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgDXJCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 05:02:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC8C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 02:02:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so9816623wmg.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DMal3ZlVmmBC2mJ5pIo7LODxp8H5RwHJNWR0yLevA1c=;
        b=bCMzBNiPkzB27AReApPvHRAe1kB6l0U+MmqN6+8Z1yGS20GzNMIHUYgrCI8tsD7Wmy
         wfu78dez4Qd4gguigvUtv8wCXdHhMWSzErEsgzzfhfoKVCJ8Z38zuUrBTl4LAb5Mt1FQ
         Gso+j1aEWRIzv6xaSv7xDg8cdAB/tUvJYoeVQKLiovCWMLg3TSPT66pbOHECD0MjnBng
         djTI3ZQPs5ccol9vjFRTni1VI2BzQHmtCMAGfn0fmn95zf4EjWCOZjvYGhZYnW8Njl/X
         uMBoE1IGtKOeOkNTxfbill790BFRmtV80b/RnnZP13YswA2LSeYuaC4YiuunUojMl1ub
         ROwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DMal3ZlVmmBC2mJ5pIo7LODxp8H5RwHJNWR0yLevA1c=;
        b=LN3VNOEv2o5WpXeitkKE+/B7DPScwOsbAd3Cxtp6gAOT855Y92yMQB5qcOPcG9ys9V
         n+dYpSLqf1N/bBR+OdRRpnLwNmhJEub8TJ4QpmHQsiQwJjzNMSwWUqDxGtW3ga7r3qCh
         Z36GU08sBoWuaCLlkDM56pKcZbSEBSLe2ltAQXOXfsN5D/Bg/nHkUpkNWb8taUbBL/QW
         aLZ3X21INAWhbnqWYzn67JtFSYufQfWMtMPwj3C7XTwjfs4XI8ABxhnijuxzRrN7z4+7
         dG5NDggiuAEt4oJUaQL072IksSIU9IgnffALx/d5ozArhD9rKdxPDjgBqqXoyLvP3iAw
         gvcA==
X-Gm-Message-State: AGi0PuYSxEo7edwpE+GCzl9d+XRNxbJRXEknpW6WHsxNX05dW5wpD3Nd
        xcCMNG7wuQmQM8OFvpdmWbo=
X-Google-Smtp-Source: APiQypJETBuDgXQN/vq3WXz2le2HSRDS8B13H+vSXqTZvVjGWf0slj7nx97dnWYc3iqmDDufFHhCDw==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr8702015wmi.173.1587718968193;
        Fri, 24 Apr 2020 02:02:48 -0700 (PDT)
Received: from szeder.dev (92-249-246-129.pool.digikabel.hu. [92.249.246.129])
        by smtp.gmail.com with ESMTPSA id z1sm1964225wmf.15.2020.04.24.02.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 02:02:46 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:02:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFC PATCH 0/5] line-log: towards a more responsive, incremental
 'git log -L'
Message-ID: <20200424090241.GA5925@szeder.dev>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <459f2978-03f1-a58f-0dec-d0376fec5201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459f2978-03f1-a58f-0dec-d0376fec5201@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 08:17:41AM -0400, Derrick Stolee wrote:
> On 8/18/2019 2:27 PM, SZEDER Gábor wrote:
> > Line-level log performs a preprocessing step in
> > prepare_revision_walk(), during which it filters and rewrites history
> > to keep only commits modifying the given line range.  This
> > preprocessing causes significant delay before the first commit is
> > shown, wastes CPU time when the user asks only for a few commits, and
> > does parent rewriting with no way to turn it off.
> > 
> > This patch series addresses these issues by integrating line-level log
> > filtering into the revision walking machinery and making it work
> > together with generation number-based topo-ordering (though for now
> > only in the case when the user doesn't explicitly asks for parent
> > rewriting, which is probably the common case).
> > 
> > The first two patches are quite straightforward (and arguably somewhat
> > unrelated), but the rest deals with history traversal and parent
> > rewriting, which I don't usually do, hence the RFC.
> > 
> > 
> > SZEDER Gábor (5):
> >   completion: offer '--(no-)patch' among 'git log' options
> >   line-log: remove unused fields from 'struct line_log_data'
> >   t4211-line-log: add tests for parent oids
> >   line-log: more responsive, incremental 'git log -L'
> >   line-log: try to use generation number-based topo-ordering
> 
> Hi Szeder,
> 
> I was taking inventory of our issues especially around history now
> that the changed-path Bloom filters are close to wrapping up.

Well, I'm about to stir it up over the weekend...

> What's
> the status on this RFC? Looking at it now, I understand the situation
> better and could help review a bit more than before. Do you have more
> context as to the situation on this series?

Sadly, I haven't touched this patch series since then, other than
rebasing it on top of new releases once or twice, but since v2.23 not
even that.  I think I run into some conflicts and was not in the mood
to resolve them, because with a2bb801f6a (line-log: avoid unnecessary
full tree diffs, 2019-08-21) the performance benefits are much lower,
so it was not that pressing...

I think patch 4 in itself is not really the right way to integrate
line-log into the revision walking machinery:

  - Line-log follows full-file renames, but it doesn't actually use
    '--follow', but rather implements its own logic to detect them.
    This logic is in some ways better, than '--follow', notably it can
    follow multiple paths at once, while '--follow' only allows a
    single path.
    I think the rename following logic should be extracted from
    line-log, and it should be used to implement '--follow', removing
    some of its restrictions.

  - Line-log should then be ported to use the revamped '--follow'.

  - And then it's finally time for something like that patch 4, and to
    have some "fun" with making explicitly requested parent rewriting
    work (I can only remember that whenever I tried to make that work
    my brain started to hurt :)
 
Anyway, I think the first three patches are worth having.

