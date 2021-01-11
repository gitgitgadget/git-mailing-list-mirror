Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78579C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E854225AB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 18:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390353AbhAKSZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389665AbhAKSZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 13:25:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A7C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 10:25:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d13so729865wrc.13
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jH4qFLgiRzYz3yoWNjznkfSOMGko+8U8hUI8hndWlcM=;
        b=Ue6MHysMGB7YfcbY27e2whBFly8AcHlhFebjeJ9P+yWQn4tAGaxxAmYLZGIuu58yR+
         tWZezIT752d9gyYSQ+UOMyNdM/5DLVg3fo6cGr33Gh0jFEScrNOEhXrLxJTyzEgyQIVm
         Jo3K4gkYETYzGv1ed43MKxSxVvV1Veo7lvBtm/M6pywKS8oeeTZDElU7HAQo0ob4ag6O
         RraxpFkCnRWwUNfxppdD1+yo7DqgQj3LslYH2dIdPdYXCub6EOvSrAB+DI9lG7vzZkl4
         2rHYjhxTBF35m91VGlE9wcC3XLUF5A+Me34kKgvbY+F1lQsdvIWpQhLb6yuc9EsYnF3D
         c7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jH4qFLgiRzYz3yoWNjznkfSOMGko+8U8hUI8hndWlcM=;
        b=qp15hTHpO7z0Qd4MizrUQwDg3Ct637lLQKL82uPywEdd9kg6x2TsjlfN7FNeNJcpRW
         M/VodQ/peas0y9ExpWzOWeB5URt0azOIDXqsm3GaHnITWaeSUOxECQLhTp5PBb3OgbZ3
         k7TDpiMOtoOD7MfNP9eutNffkbDYxaa6gf8TXuEUDBo7b+5Rb1Fy5SC79O5XnvVDdgQv
         MtdwZ/+pRFGjie3CvFCvqkM0ltYLH3gUr3mbC78lhrlTGXnihoLAnmYMa6M63o4P+I3W
         hDsZ0wz9b9NPb6CqzT72s23WEfUL64UCWRkQG++ffp5qEJNEqssBqmYWcLsMgZ/NJTLT
         5ygQ==
X-Gm-Message-State: AOAM53258fghMfXE333NdclLUDU41bCC5Piz4FQL6S9rUea7lphHRdXI
        EQC6JLT2LEJg3iAKQcznDN1aW5Ut+tpi
X-Google-Smtp-Source: ABdhPJxlciL7FRl4AFxmizARPNpY7y39aHzv+/SpGcazSrEHhm/PxIu5LketSovUC8s4ZU/SpfTREw==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr470771wrw.62.1610389502884;
        Mon, 11 Jan 2021 10:25:02 -0800 (PST)
Received: from sync (90.ip-167-114-239.eu. [167.114.239.90])
        by smtp.gmail.com with ESMTPSA id d18sm155583wmb.30.2021.01.11.10.25.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jan 2021 10:25:01 -0800 (PST)
Date:   Mon, 11 Jan 2021 18:25:01 +0000
From:   Arnaud Morin <arnaud.morin@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: rev-list with multiple commits sharing same patch-id
Message-ID: <20210111182501.GB32482@sync>
References: <20210109162440.GM31701@sync>
 <CAP8UFD3qt4xr4S1BgjPU-vm4qsb=+1JWc=LR_p1CUzTKaAcAoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3qt4xr4S1BgjPU-vm4qsb=+1JWc=LR_p1CUzTKaAcAoA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the link to the test file.

I patched the test file to add this new case (where the same patch-id is
duplicated in the tree).
This patch can be find in [1]
I had to patch two existing tests to make them work again.
I also added a new test with this new test-case (two identical patch-id
in the same tree.)
Note that I still have one test (outside my new one) which is failing:

not ok 10 - name-rev --exclude excludes matched patterns

I dont know why yet.

Moreover, I am willing to help fixing the code.
I have the feeling that a patch needs to be done in revision.c, maybe
in static void cherry_pick_list?

If you have any clue to help me?

Thanks.


[1] https://github.com/arnaudmorin/git/pull/1


-- 
Arnaud Morin

On 11.01.21 - 10:54, Christian Couder wrote:
> Hi,
> 
> On Sat, Jan 9, 2021 at 5:29 PM Arnaud Morin <arnaud.morin@gmail.com> wrote:
> 
> > I am struggling with a rev-list command, hope someone can give me a
> > clue on what is going on.
> 
> [...]
> 
> > However, when using git rev-list to perform a symmetric difference, git
> > is giving me a commit ID:
> > $ git rev-list --left-right --cherry-pick B...master
> > >dbf86d8aafc897a25a3093139b4237a62395041e
> 
> It looks like a bug. You might want to check the following test file
> and let us know if a similar case is tested in it, or not:
> 
> t6007-rev-list-cherry-pick-file.sh
> 
> If not, it might be a good idea to add one using 'test_expect_failure'
> instead of 'test_expect_success' to document the failure.
> 
> Thanks,
> Christian.
> 
> 
> > Note that this commit is not empty
> > $ git show dbf86d8aafc897a25a3093139b4237a62395041e --stat
> > commit dbf86d8aafc897a25a3093139b4237a62395041e (origin/master, master)
> > Author: Arnaud Morin <hidden@mail>
> > Date:   Sat Jan 9 10:30:10 2021 +0100
> >
> >     remove line2 and add line4 (bis)
> >
> >  a | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> >
> > So, from git rev-list perspective, there is a diff.
> >
> > After digging a little bit, the thing is that this commit is having the
> > following patch-id:
> > $ git show dbf86d8aafc897a25a3093139b4237a62395041e | git patch-id
> > 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
> >
> > Which is also already existing in an other commit:
> > $ for c in $(git rev-list HEAD) ; do git show $c |git patch-id |grep 20f4ace68e80a751b07d78a27c94e83d6c5314bc; done
> > 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
> > 20f4ace68e80a751b07d78a27c94e83d6c5314bc 8969d3fa9159730fd3b23199873bfb26e3d20027
> >
> > So, is it normal that rev-list is not able to figure out that a commit
> > is existing in both branch when 2 commits share the same patch-id?
> >
> > Is there any way to prevent rev-list from showing this commit?
> >
> > Thanks for your help.
> >
> >
> > PS. I have uploaded my test repo here:
> > https://gitlab.com/arnaudmorin/git-rev-list
> >
> >
> > --
> > Arnaud Morin
> >
