Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0B6C4332F
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 05:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiBHFcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiBHFDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 00:03:06 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43ADC0401DC
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 21:03:02 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id e6so16853195pfc.7
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 21:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAoLDVlyqrmLtdlA1p0gcf27mWjFv1Y6B8F72rVMMsk=;
        b=qroVn/SD6k7yr5HGc144VGP2lYjjUHdquMLH3UvWin1DotRuaCbU1YE0zphvzdI4mr
         7NTjt8UJPaX/qi+M3RksZ8SveU1T8ETzGk/hb8NeDszWepJtXnAw4XEn4VCoaQUc+s3p
         2IHlJyJhorg4gpp48vOLmy54IXUwaKsKbo/T3FmysdQIeTdCldqK5xpsvXxhevoDC7hv
         6WzU8yfcl94et3Y6P2nGy4MWOrVRNBfF6kBbwu9xOj/fHQuuhF1kWo/+xiBM3Zn5RAqJ
         LdUM9fQS8trqE6aLjP0Is1owfNCoeJM/Y/GARXV7KhrmUUy1PAkJI43fqL+dCXTELq9y
         IAJw==
X-Gm-Message-State: AOAM530uTg3W1BD6fN3jYkc7cEw2fi3nuXFrBYTy2yfINe366XHdnXmZ
        Sy0Q9zGIXBAR/JPy1d/oJsCeN9wJLeb5E2YWQN4=
X-Google-Smtp-Source: ABdhPJyHADmY9hsLPX65n+TbAREf5n0NF7wJiPGGU9fsd4N1++uV2bBtq6J9+G/63JZSfr8JeWAtYmlVjbITrui0gNc=
X-Received: by 2002:a63:2f82:: with SMTP id v124mr2149732pgv.139.1644296581942;
 Mon, 07 Feb 2022 21:03:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <CABPp-BG4m6i+yobjnD6UC5S5n3k-HbB7Y5uUNEvrD79ErOoYHg@mail.gmail.com>
In-Reply-To: <CABPp-BG4m6i+yobjnD6UC5S5n3k-HbB7Y5uUNEvrD79ErOoYHg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Feb 2022 00:02:50 -0500
Message-ID: <CAPig+cT7GwyhPOBdqDDh8jGm+mWK1x9Gt4Zebcw34dgFyaufkw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 7, 2022 at 11:14 PM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Feb 7, 2022 at 1:33 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Updates in v6
> >  * Updated documentation to use "working tree" over "worktree" and "" over
> >    ""
>
> Not sure what "" over "" means.

Probably related to my review comment[1] about spelling it
"$GIT_DIR/worktrees/<id>/" rather than
"$GIT_DIR/worktrees/<worktree-name>/".

> >  * Delay some allocations to avoid leaking memory in error conditions.
> >  * Use "main worktree" over "base worktree" in comments.
> >  *
>
> Was the empty bullet point meant to cover the new patch 6?

The "Updates in v6" section was botched a bit. If you look closely,
the remaining bullet points actually ended up in the "Updates in v5"
section. The complete "Updates in v6" section should have been
(approximately):

 * Updated documentation to use "working tree" over "worktree" and
   "<id>" over "<worktree-name>"
 * Delay some allocations to avoid leaking memory in error conditions.
 * Use "main worktree" over "base worktree" in comments.
 * Removed use of git_configset_get_string_tmp() and added a patch that
   removes its public declaration.
 * Fragile variables are replaced with better ones.
 * Variable names and code style improved.
 * Several test cleanups in patch 5.

[1]: https://lore.kernel.org/git/pull.1101.v4.git.1643136134.gitgitgadget@gmail.com/T/#m4926177771017bbea82c33e9e03e6a9a004ebf24
