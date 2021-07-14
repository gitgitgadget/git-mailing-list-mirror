Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4BC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B50613AF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhGNRG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhGNRG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:06:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3699EC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:04:05 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h6so3010021iok.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nMKCUcnMm5C0L3BCqmlPYhJdhLeND7bzpl3Ab9WD7nE=;
        b=ARUTbSADQPK791sYKYTfZE2fmSUrMq80AV2wnjAJ1KNiJ7STbu6iUulaZOvGBU/N6M
         3EsV69AvI7chgMNum4ydLHq/+Ne1de4Dd6lNAcf4Emt9As8vh6cvYwv3yHQWrxZfR7f/
         E3ni8JoSQj2yIrQzCySuObeO3HR3497uFq8HzdbrgflDZsXi4buYOrcUA8oZsvSpbnwy
         /5cwTYKeKHzABjM3BXmaM2JuNyYz6VyX5lg1NgEl/KQdxzA6r8rTBaoGZhGYZpVUFzt6
         dNeQowgoh4UGktuS/ivhxE5ruhhYq+VvtMZhXtzFdOE8SkpW60uvLVpQYLfTxXEoTr5q
         iASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMKCUcnMm5C0L3BCqmlPYhJdhLeND7bzpl3Ab9WD7nE=;
        b=hzjWM1BVOBw2j+SaMMIKuDxQ//Qk4PFGZIJ+PKf8t3kiquUbhiO6sNoSlfTbfXDUeN
         QLwe60zbPcuMWahNY5kNI7S+y0WnRJ3AnO20CFZYjrV2PylpM+yUzL9QkVpDI7eaIeE3
         tCCRLlMDCtCN1ZFFt8fGu/TQ/U6OhMseQ0XlmHq+qoshyLhCyuQbdOP6p9YNOohxTVTN
         6yYaATLwfjg6TgGbUqQaYEfoyWSJlbAAAJ+7KHDbxwe3Ev02ka8eEzar40crRHWs+sZ0
         UKQltcZHnHsEQO46cVn5Kkzrcj+jnx9rKu32qSZ7vhfFivALEjbbAhd7wGDojpetXbKG
         n4bw==
X-Gm-Message-State: AOAM533WJld0Ke+uVLqBQqY7/SyBIZPiZLK2Q9tkhwfuhM9EAWaIeyLa
        uxha3+bkk47HMYb+Gt4p7S1v/Q==
X-Google-Smtp-Source: ABdhPJxFAx7GxYYdWl+XVQmTukuj8aBfVFGV3HjgDuslbNDlFFrGt+9SpBmY2ucEqf+V7ZIVMwFGTg==
X-Received: by 2002:a05:6638:22f:: with SMTP id f15mr9612658jaq.141.1626282244402;
        Wed, 14 Jul 2021 10:04:04 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id m26sm1514605ioo.23.2021.07.14.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:04:03 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Wed, 14 Jul 2021 13:04:03 -0400
To:     Sun Chao <16657101987@163.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Message-ID: <YO8XrOChAtxhpuxS@nand.local>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com>
 <YO5RZ0Wix/K5q53Z@nand.local>
 <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 12:46:47AM +0800, Sun Chao wrote:
> > Stepping back, I'm not sure I understand why freshening a pack is so
> > slow for you. freshen_file() just calls utime(2), and any sync back to
> > the disk shouldn't need to update the pack itself, just a couple of
> > fields in its inode. Maybe you could help explain further.
> >
> > [ ... ]
>
> The reason why we want to avoid freshen the mtime of ".pack" file is to
> improve the reading speed of Git Servers.
>
> We have some large repositories in our Git Severs (some are bigger than 10GB),
> and we created '.keep' files for large ".pack" files, we want the big files
> unchanged to speed up git upload-pack, because in our mind the file system
> cache will reduce the disk IO if a file does not changed.
>
> However we find the mtime of ".pack" files changes over time which makes the
> file system always reload the big files, that takes a lot of IO time and result
> in lower speed of git upload-pack and even further the disk IOPS is exhausted.

That's surprising behavior to me. Are you saying that calling utime(2)
causes the *page* cache to be invalidated and that most reads are
cache-misses lowering overall IOPS?

If so, then I am quite surprised ;). The only state that should be
dirtied by calling utime(2) is the inode itself, so the blocks referred
to by the inode corresponding to a pack should be left in-tact.

If you're on Linux, you can try observing the behavior of evicting
inodes, blocks, or both from the disk cache by changing "2" in the
following:

    hyperfine 'git pack-objects --all --stdout --delta-base-offset >/dev/null'
      --prepare='sync; echo 2 | sudo tee /proc/sys/vm/drop_caches'

where "1" drops the page cache, "2" drops the inodes, and "3" evicts
both.

I wonder if you could share the results of running the above varying
the value of "1", "2", and "3", as well as swapping the `--prepare` for
`--warmup=3` to warm your caches (and give us an idea of what your
expected performance is probably like).

Thanks,
Taylor
