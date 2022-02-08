Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4D7C43219
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 05:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiBHFcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiBHFSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 00:18:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26BC0401DC
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 21:18:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id da4so12984151edb.4
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 21:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtOLBWGbTcuB3pCKRPdJh0vDrvfpWfAftVtHciKFrKQ=;
        b=k8UemWj1/wwPpDKpJYdfPwU9qTGhzbBeJrKaH7mwV0tcfhfLdYPmg1OlRyZVSlm7b9
         id7ni6JCHNQjsR6us0RS8cYOwZJqmXd5iEa/qUqkBr48MMhcD50lrmNn3cadU8SRzB5c
         CAGvSgA4WiwJqttlMhdISMqA13jxWlXoJVobB7hBEtgQCB1p0I16W1/Csmpjfi9mKDzM
         Dm1mvqDoKsLfV9WOF/iih1QL0+NSb57+Tw6xzkMifXXhuVwBpyV9av6ZahOlaTLejR8D
         duQG2h3X42M72FM1ToGwOthzw2ol9Y6D1aiy8j+SLoXLxo7omxpVezL2q/COyqBP71uM
         btWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtOLBWGbTcuB3pCKRPdJh0vDrvfpWfAftVtHciKFrKQ=;
        b=PbQ7g/L5yrHBhhCvGDSRHATnqhMPYfILHcGp+BalmVvo2rmcy79wuuTGLXT/tfMS4g
         yemBIqLqN1GCCVmK6RBIm5i/MR4c1HyuyUkgluGKpparTFvnw2HP7cBONzTD21xqtdXb
         7dg7Cpxkc5H9AHpcdJf/w/6dI46BVuyzCncOSC0YvkUR7RDiMzer47t35APmASocmV9F
         1cO+/NIozQWcs1vGTf70VLCi9mBKZLXT+Bel3agTPy3EKJN5i7khHWLiw/521EySdC6e
         bsJWJ/zsHBIDb0LWu+JSoJYMBEYW2+i5Ykji09NO6chQumDrHg9ZhdSb9lRHEyldVNXC
         yi6w==
X-Gm-Message-State: AOAM533LCwsjErBkfBO/0xPvDllpY3PKsWRWdnN6ZED+XScxUb+lNeX6
        Zk27JpAVOLN8sGUT2QH7hSOZQNE6yIWz5M6yxsQWc9PnA4g=
X-Google-Smtp-Source: ABdhPJxBGYkfjnIdXQacRgkZv6nYJvVltSJP71+Lzs4cdPf+aLBkl/sm2Cp8Jmst0Ug+k6DSEXFnvY4M+mOiTa6Db5Q=
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr2726071edd.126.1644297510296;
 Mon, 07 Feb 2022 21:18:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <CABPp-BG4m6i+yobjnD6UC5S5n3k-HbB7Y5uUNEvrD79ErOoYHg@mail.gmail.com>
 <CAPig+cT7GwyhPOBdqDDh8jGm+mWK1x9Gt4Zebcw34dgFyaufkw@mail.gmail.com>
In-Reply-To: <CAPig+cT7GwyhPOBdqDDh8jGm+mWK1x9Gt4Zebcw34dgFyaufkw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Feb 2022 21:18:19 -0800
Message-ID: <CABPp-BGZoGwpMaqo2px1SqOBk1xLHtwkkBBAaqU5sNfTvKD1og@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Eric Sunshine <sunshine@sunshineco.com>
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

On Mon, Feb 7, 2022 at 9:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Feb 7, 2022 at 11:14 PM Elijah Newren <newren@gmail.com> wrote:
> > On Mon, Feb 7, 2022 at 1:33 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > Updates in v6
> > >  * Updated documentation to use "working tree" over "worktree" and "" over
> > >    ""
> >
> > Not sure what "" over "" means.
>
> Probably related to my review comment[1] about spelling it
> "$GIT_DIR/worktrees/<id>/" rather than
> "$GIT_DIR/worktrees/<worktree-name>/".
>
> > >  * Delay some allocations to avoid leaking memory in error conditions.
> > >  * Use "main worktree" over "base worktree" in comments.
> > >  *
> >
> > Was the empty bullet point meant to cover the new patch 6?
>
> The "Updates in v6" section was botched a bit. If you look closely,
> the remaining bullet points actually ended up in the "Updates in v5"
> section. The complete "Updates in v6" section should have been
> (approximately):
>
>  * Updated documentation to use "working tree" over "worktree" and
>    "<id>" over "<worktree-name>"
>  * Delay some allocations to avoid leaking memory in error conditions.
>  * Use "main worktree" over "base worktree" in comments.
>  * Removed use of git_configset_get_string_tmp() and added a patch that
>    removes its public declaration.
>  * Fragile variables are replaced with better ones.
>  * Variable names and code style improved.
>  * Several test cleanups in patch 5.
>
> [1]: https://lore.kernel.org/git/pull.1101.v4.git.1643136134.gitgitgadget@gmail.com/T/#m4926177771017bbea82c33e9e03e6a9a004ebf24

So, you clearly also read the patches in this round.  Do they also
look good to you?   :-)
