Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA671C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 14:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjBUOFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 09:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjBUOFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 09:05:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03692A6C6
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 06:04:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k37so354535wms.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 06:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RiCt4HkRKvhKCqabDJ22a2WgQAFlEVgrN3RK6hikebo=;
        b=DvXN5n93iRu7VGAH3tuJFq/70JgduVmkA8HZQSmhkZZXDfKVAMmxMaIcFzcRBfD008
         0mZzziVoR7HmoPmTUHlkwid1S9mYGHZsoVWOSM/SfijOuOC68EuRd3Rhl03qs+4LyNOF
         5TLsznnuLLARbEQEwoKd+bvs05tEoofA9gtQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiCt4HkRKvhKCqabDJ22a2WgQAFlEVgrN3RK6hikebo=;
        b=NpD0u9EU5ESMW7xIv/WhDmYrjWVep99bo7I6wyWbePfB74UFu1FsX2W+rMEVeB2QuG
         o8gnZ/rx9UpdcinD0Z95pWKUKHKTeG/po9JkQEJVyo7u1uktKMpm3FoT3zjHQKBzYIIY
         GE0xDIAr17FnIEsKRBnAmYCjFx8ah+CMo3Hchws1X8SW/HHC1JCGEN4e6H8KLxmxq2mm
         uINTX155R5E0aIWJ+5MLEOlXRyb3MPMw9uOvo4Tza+M/QmkzIb+7oHWHtKBLVqMv6Hz4
         +fPDxc9bgcvVkfQ0sMx3FT0jhgPXieXcmbsCxyRCnHOIquI7a2sHFAbu2hQ7hZ93KmBo
         9beQ==
X-Gm-Message-State: AO0yUKVFjC3GB8R33GDLaA8lkePkWdZUQenKJH7qEhhEmdY17p1McE4D
        ZdKBqaXlM3ho8DbJFoscppSdjhnlQRglomXLDhlkAw==
X-Google-Smtp-Source: AK7set/tk4GdtrzCxpgLFkJREu+RGlMDJ88oltejLjw9JMU0LRCHXLiB8pepV4cPVfHxYwSBT1o2zfqZ8/8cqfYSClM=
X-Received: by 2002:a05:600c:5112:b0:3e8:53bc:cb59 with SMTP id
 o18-20020a05600c511200b003e853bccb59mr48010wms.2.1676988295106; Tue, 21 Feb
 2023 06:04:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk> <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
 <CABPp-BFhvX6eg04+qTk7P64NfmUKnCTV7o1ufp447z6-XdUcJw@mail.gmail.com>
In-Reply-To: <CABPp-BFhvX6eg04+qTk7P64NfmUKnCTV7o1ufp447z6-XdUcJw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 21 Feb 2023 15:04:43 +0100
Message-ID: <CAPMMpohd=sqP+RwyWZ7+nuGgYxELcOkxsLHpNc8BY0daN2uUbg@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Elijah Newren <newren@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 5:56 PM Elijah Newren <newren@gmail.com> wrote:
>
> The strategies described by Buga and others in that mega-thread were
> suboptimal solutions, in my opinion.  Johannes went and implemented
> some and found them wanting; see the thread over at
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/.

Ah, thank you! I think you had mentioned this before, and I somehow
lost track of this.

At first I want to summarize this concern as "any strategy that treats
a merge rebase as a *pair* of cherry-picks risks encountering
nested/overlapping merge conflicts", but I must be understanding too
superficially, as you then mention arbitrary conflict nesting (and I
assume this is not about octopus merges).

> There were follow-ups with an improved strategy in the thread over at
> https://lore.kernel.org/git/CABPp-BHWVO5VRhr1-Ou60F1wjKzJZ1e_dC01Mmzs+qB9kGayww@mail.gmail.com/
> (Note that this route has also independently been discovered and
> implemented in jj and found to work well, though it does handle
> conflicts much differently).  And I've since improved the strategy
> further at https://github.com/newren/git/blob/e84f5f3585fd770ed21f398d2ae5f96e90a51b1e/replay-design-notes.txt#L264-L341.
> However, note that this isn't a case of merely performing the proper
> series of merges, it needs some specialized logic and some new
> capabilities at the xdiff level.

Understood - thanks for the update, and of course for all your
continued work on this.

Is it fair to say that, for the simple situations that Phillip's
cherry-pick strategy *does* kick in for, the outcome should be exactly
the same as the outcome of the replay strategy?
