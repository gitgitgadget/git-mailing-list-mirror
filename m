Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7290C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F47B61159
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbhI1H4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbhI1H43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 03:56:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883CCC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:54:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bd28so18351844edb.9
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FsWivvARV/J5ANrf3dlr1VSyEKlVqAHuSFk7Xr+gjsk=;
        b=O6O94I16TKMuWsN/93SDt+5hgk2q0O+U5axcA3r2mr+sv6fjHLItZxQ60bVuEUS3ig
         yeoaIHEZwuZkE5gnPXhSPAOsxahVIJt/rImdXugtLE7gt5lPn5c5U+G/X4koHELcXt7C
         ma6Cud9hZW8tl5GzRNTxldgTYO83Bcgs2RPjPbjDRvjMLXFoU0ryluj4JckOVfO8Ifa3
         CtCjdsrBQrjb9tFxbeyXvk28F0iSGWm8w7bQHTZgmm4ww/wCnHbzOyVVNUS3shz6WL1Z
         ptrzpFNVUI3lag8JB30NHllwCyb+Swzp9iOJYVI0PPUHsMowx65fwgpqHmsgdCOEW94H
         PuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FsWivvARV/J5ANrf3dlr1VSyEKlVqAHuSFk7Xr+gjsk=;
        b=fwIvBoPVI7XTyquWh2HpeEr9IoPxyZyHwjmJcf77QO4xmn/fH4fuAVw20vzEDYch+f
         ghvdGf7Td/sDvvEktCnR0N5SuzvaNpTZqb5mGkCRddi/YrsUcWbocLxeON5k6MKGVsVA
         7oCdAeapGcebwyQEh0dfMMuv2Ufr2AepZ+w9Vuu672CMr9FqV0c0s9I19OPZVbzL6KFx
         limSFVNr7wmoUkgonoVkngS7KK8DFA+nISgW1MJpa+r6/EsX111yLJyZlUUOKHFr/rUS
         goP4x+TrdzrMGJVWwA8dKaRngcdGUdBcQLn/+mVWrWDJaOEt/hBGSfbmEgP/ew7jXpCK
         QSeg==
X-Gm-Message-State: AOAM531us7EvNh2RrZC5caDno2yHAoInilIZdzAcBdFBRKJ/BrXZ2SCC
        w5x/uQ3Zdh8KvRFXFmULCfQcu3UhQIW2JQ==
X-Google-Smtp-Source: ABdhPJwa+1ZYU0sHTsa+VthJ5JxDGmz7SLXrvQLAFZ2T0CANNgTUSvba25dxiCVMvIacknUPuTAgPQ==
X-Received: by 2002:a17:906:1ed7:: with SMTP id m23mr5009585ejj.558.1632815689007;
        Tue, 28 Sep 2021 00:54:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yc11sm10351659ejb.59.2021.09.28.00.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:54:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Date:   Tue, 28 Sep 2021 09:45:25 +0200
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
Message-ID: <87v92lxhh4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Elijah Newren wrote:

> [Did some slight re-ordering of topics]
>
> On Mon, Sep 27, 2021 at 5:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>> * en/remerge-diff (2021-08-31) 7 commits
>>  - doc/diff-options: explain the new --remerge-diff option
>>  - show, log: provide a --remerge-diff capability
>>  - tmp-objdir: new API for creating and removing primary object dirs
>>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>>  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
>>  - merge-ort: add ability to record conflict messages in a file
>>  - merge-ort: mark a few more conflict messages as omittable
>>
>>  A new presentation for two-parent merge "--remerge-diff" can be
>>  used to show the difference between mechanical (and possibly
>>  conflicted) merge results and the recorded resolution.
>>
>>  Will merge to 'next'?
>
> It has been a month that it's been cooking with no issues brought up,
> and it's been in production for nearly a year...
>
> But just this morning I pinged peff and jrnieder if they might have
> time to respectively look at the tmp-objdir stuff (patch 5, plus its
> integration into log-tree.c in patch 7) and the ll-merge.[ch] changes
> (patch 3).  I don't know if either will have time to do it, but
> perhaps wait half a week or so to see if they'll mention they have
> time?  Otherwise, yeah, it's probably time to merge this down.

I haven't poked at it much, but haven't you and Neeraj Singh (CC'd)
independently come up with two slightly different changes in
tmp-objdir.c to do the same thing? See the tmp-objdir.c part of:

http://lore.kernel.org/git/543ea3569342165363c1602ce36683a54dce7a0b.1632527609.git.gitgitgadget@gmail.com

And your:

http://lore.kernel.org/git/67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com

I.e. yours has the object database managed outside, his has it added to
"struct tmp_objdir", but it's the same objdir dance isn't it?

I started reading the combined code in "seen" and found it quite
confusing until I saw what was going on.

For both, if you can agree on some common API: I'd prefer if the
"%s/incoming-XXXXXX" part of the "tmp_objdir_create()" was passed as
some template, perhaps just the string "incoming" as a prefix?

I.e. this was for receive-pack.c originally, now it's for bulk-checkin.c
and log.c, if either of those segfault or is long-running it's quite
confusing to have something called "incoming" if you're manually
inspecting it.  Perhaps "core-fsyncObjectFiles-batch" (or even
"core.fsyncObjectFiles=batch") and "log-remerge-diff" as prefixes for
the two, and "incoming" for the one existing caller in "master"?

>> * en/removing-untracked-fixes (2021-09-27) 12 commits
>>  - Documentation: call out commands that nuke untracked files/directories
>>  - Comment important codepaths regarding nuking untracked files/dirs
>>  - unpack-trees: avoid nuking untracked dir in way of locally deleted file
>>  - unpack-trees: avoid nuking untracked dir in way of unmerged file
>>  - Change unpack_trees' 'reset' flag into an enum
>>  - Remove ignored files by default when they are in the way
>>  - unpack-trees: make dir an internal-only struct
>>  - unpack-trees: introduce preserve_ignored to unpack_trees_options
>>  - read-tree, merge-recursive: overwrite ignored files by default
>>  - checkout, read-tree: fix leak of unpack_trees_options.dir
>>  - t2500: add various tests for nuking untracked files
>>  - Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes
>>
>>  Various fixes in code paths that move untracked files away to make room.
>>
>>  Will merge to 'next'?
>
> I just sent out v3 this morning with five new patches (included in
> your list above).  While I think my patches are good, and I'd like to
> see them merged down to next so I can send my
> current-working-directory-deletion fixes that build on top of it, I'm
> a little surprised you're proposing to merge this series down this
> quickly instead of waiting a little longer for review of the new
> patches.  I'm not complaining...but was that intentional?

