Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA4BC35280
	for <git@archiver.kernel.org>; Sun, 10 May 2020 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322592064A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 06:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyxZ9Abu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgEJGis (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgEJGis (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 02:38:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E36C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 23:38:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2535064plo.7
        for <git@vger.kernel.org>; Sat, 09 May 2020 23:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2q9GZedIrg2KUPKtDKmIEUWyoJ/IdYxDoKP8sF4lD18=;
        b=CyxZ9AbunD7QrzfBvP5SgvKUOXJAohe8NUfu/vuNaL/Wt3UKzw3gGKnQJr540RYek0
         ncbMGoiJ8JRMWuaF7m+MGQzaF3OFjSogm6+6c2edlmWLDSdYCJL7+OP5S/xMZrJJcbdr
         C+9bmCxJQ88SDLue0GhBCgxviMazwS5asv63QhQgP+KGhIMpmtjGVHhJv5CX5bk8NbXw
         m+3q/HN83DNpqyd9JC2p0kNpzpDWQMrNy5dkAI3OtUD4VVEoJCCpF/2RwaZcTlIy/vfk
         KGpGEmTVh8gGgDvBmlO+290CscNu9Vque9hjEu0PAqH5T2MKFfFql+L4LVAEJ2yOk0vC
         8yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2q9GZedIrg2KUPKtDKmIEUWyoJ/IdYxDoKP8sF4lD18=;
        b=LPk6UZbKJkDixTPO2liRisZHzYsE8mUFnozz1QhPzIdvr1RibdJCrL/4mVJPFmml2t
         wHk8Q3QCR1OWGqPSkvs6u41PPEYNjUQZfKt9fYOvqiSE/Xe32xQ/S9Zyfy3HNaofwC7R
         OKLsK0c4LXJIQ58Vbb2OzSr2VYD00toFaTwncM4HfR7aXg4P9CWeBxVHjczhdwbou+0h
         DB4ykvzWCuaTDntrL9i9Gn87jzouRvhVJFAVOzAFnodluC3cnU8ErJOQ3HrqIbGnSe/K
         mA/aOpMr0JEY1CNug3BkMeVxWzYrEtZELQkIN9YTuuH9txvPJu77n6rBJFANqc744Y5A
         DuNg==
X-Gm-Message-State: AGi0PuZDc1qgfUF6fCg0hm1DOPnGZAfz5PJZtHsZUEEFBaYDWDbu4agI
        +gBV38SookF/3cfAAlutPPXVKZ4E
X-Google-Smtp-Source: APiQypJJm5gmnOwLk4pE+ILfu076FhmPhIOZLygbdRlnQ0XJ0GuwJ4qbqrzd3JCFwSAv7twtcilA8A==
X-Received: by 2002:a17:90b:f13:: with SMTP id br19mr15864477pjb.153.1589092727296;
        Sat, 09 May 2020 23:38:47 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id 9sm5002809pgr.17.2020.05.09.23.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 23:38:46 -0700 (PDT)
Date:   Sun, 10 May 2020 13:38:44 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/3] multi-pack-index: respect
 repack.packKeptObjects=false
Message-ID: <20200510063844.GA14311@danh.dev>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
 <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
 <988697dd5121430cd3ddfa60b1ebcf26027566ef.1589034270.git.gitgitgadget@gmail.com>
 <20200509161159.GA15146@danh.dev>
 <xmqqlfm1ui6t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlfm1ui6t.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-09 10:33:30-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > On 2020-05-09 14:24:29+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >> 
> >> +test_expect_success 'repack respects repack.packKeptObjects=false' '
> >> +	test_when_finished rm -f dup/.git/objects/pack/*keep &&
> >> +	(
> >> +		cd dup &&
> >> +		ls .git/objects/pack/*idx >idx-list &&
> >
> > I think ls(1) is an overkill.
> > I think:
> >
> > 	echo .git/objects/pack/*idx
> >
> > is more efficient.
> 
> When there is no file whose name ends with idx, what happens?
> 
>     $ ls *idx && echo OK
>     ls: cannot access '*idx': No such file or directory
>     $ echo *idx && echo OK
>     *idx
>     OK

Yes, but I think the next line is checking for the number of lines.
This is better to fail faster.

(My suggestion was wrong anyway, it should be "printf "%s\\n" *idx)

> >> +		test_line_count = 5 idx-list &&
> >> +		for keep in $(cat keep-list)
> >> +		do
> >> +			touch $keep || return 1
> >
> > Is this intended?
> > Since touch(1) accepts multiple files as argument.
> 
> Good suggestion, but doesn't .keep file record why the pack is kept
> in real life (i.e. not an empty file)?

Yes, in real life, we usually provide a reason in this .keep file.
But, we also allow empty file with git-index-pack --keep
I think simple touch is fine for this test.

Missing piece for my previous command:
if `keep-list` is empty, we may want to fail fast,
touch with empty list will error out (at least in my system).


-- 
Danh
