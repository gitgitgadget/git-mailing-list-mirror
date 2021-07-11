Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB0CC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 23:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A1860FE6
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 23:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGKXxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 19:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKXxg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 19:53:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D92C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 16:50:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bu12so30655507ejb.0
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OpNtP2YpDm1dvGCJqIe3bJWXS3O0G+zmFAMyOlwzbVY=;
        b=nK+iBTJ+5m3CREfcwkDmDQCAajT722yBvJrtwkGMZKWEEEUU0MEkNZfrtjrwUmagJZ
         opXfrJfdifoqIxFJvQZF2fwP97a7gck/nVGtWFHPU8rjkoIdsdBpZfhd9YvjBQV/EZUM
         j7Zdw9bzX3PGjyE/Ea+3N4cQvQWNcp5b2E42bdoo+yw+nlj+RK6mP5OHH+yfhrYHkDPM
         e1XDQv0l4fitRGrMiIHuoMKgVjL9IQ6iWe55aRtFlrzmTvNBtw65mvlg0IHOxUUC569p
         HtlrSmRpm8E7xbNXH66wK3QFObzgZIq2oY+4x+/DkSvlVlNfA3ayybUHZFnN3gIvKlge
         tmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OpNtP2YpDm1dvGCJqIe3bJWXS3O0G+zmFAMyOlwzbVY=;
        b=WsSdFc7nJlJGM+kXhTQTAIZhnN/n+SDKOsbLLkMAF9v1uQqOy6Cs9J9Ssf4UgTeUhh
         o4J0Dep4jErqXkDt6M6qzeEuLmHlxHB/Sw2REXsXDoRj5bfSosRp59jr9fuSOaH2ZDs8
         29CYOSZHdEtj9NHCgaA49DdMVGW+vmzDqjYJsfcCM1DPEsMubq1tvbjBo2N3rWaMGpED
         R1nSQblfEsyorMUF9Iu8fXfimslsb2GCOLF5TcAG6ZZ6UQjD/ejiX1i7CI8LeRzEHzLc
         pqWytpb6Na9jp7zxbMvSfOw3qAH+8cgn3QKjRZnnrFM7s8tIBXBKp03jyUNqcs9tZ6m9
         Pvcw==
X-Gm-Message-State: AOAM530MaqIqSmc22TGuvSDBiq/QEO/LIaMuOzA8mf+mb9EOqHLtaCV8
        jamRrw6xZmv5UGBjaNWuypc=
X-Google-Smtp-Source: ABdhPJw5txLECidlnwRSJOIJ9VGjk+wORoHUVyBQJc+HcSXBS2pW1kjQOupgRTbotOPY198Q6UkXVg==
X-Received: by 2002:a17:906:7fcd:: with SMTP id r13mr22314252ejs.547.1626047446948;
        Sun, 11 Jul 2021 16:50:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ce21sm3115067ejc.25.2021.07.11.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 16:50:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sun Chao <16657101987@163.com>
Subject: Re: [PATCH] packfile: enhance the mtime of packfile by idx file
Date:   Mon, 12 Jul 2021 01:44:15 +0200
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
Message-ID: <874kd04dgo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 10 2021, Sun Chao via GitGitGadget wrote:

> From: Sun Chao <16657101987@163.com>
>
> Commit 33d4221c79 (write_sha1_file: freshen existing objects,
> 2014-10-15) avoid writing existing objects by freshen their
> mtime (especially the packfiles contains them) in order to
> aid the correct caching, and some process like find_lru_pack
> can make good decision. However, this is unfriendly to
> incremental backup jobs or services rely on file system
> cache when there are large '.pack' files exists.
>
> For example, after packed all objects, use 'write-tree' to
> create same commit with the same tree and same environments
> such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
> notice the '.pack' file's mtime changed, but '.idx' file not.
>
> So if we update the mtime of packfile by updating the '.idx'
> file instead of '.pack' file, when we check the mtime
> of packfile, get it from '.idx' file instead. Large git
> repository may contains large '.pack' files, but '.idx'
> files are smaller enough, this can avoid file system cache
> reload the large files again and speed up git commands.
>
> Signed-off-by: Sun Chao <16657101987@163.com>

Does this have the unstated trade-off that in a mixed-version
environment (say two git versions coordinating writes to an NFS share)
where one is old and thinks *.pack needs updating, and the other is new
and thinks *.idx is what should be checked, that until both are upgraded
we're effectively back to pre-33d4221c79.

I don't think it's a dealbreaker, just wondering if I've got that right
& if it is's a trade-off you thought about, maybe we should check the
mtime of both. The stat() is cheap, it's the re-sync that matters for
you.

But just to run with that thought, wouldn't it be even more helpful to
you to have say a config setting to create a *.bump file next to the
*.{idx,pack}.

Then you'd have an empty file (the *.idx is smaller, but still not
empty), and as a patch it seems relatively simple, i.e. some core.* or
gc.* or pack.* setting changing what we touch/stat().
