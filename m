Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959BAC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 13:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiKRNdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242063AbiKRNcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 08:32:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406A8E0B6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 05:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668778350; bh=PNe474CGk7aSClml3U3Dc/hEjSlEu6XbVKyIQKqMxgA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=o6rK/nlq/MhqwkvZaOPhOj6USAuQt1YvuMinU90Za4N1yWWIDzU68Yqs2ZoV9qR79
         cQPRIU7rleiydN+cw/llujr4Ymji3wVqeheIuX8KwDUePXL1ftD/vlsEdDk2H2QN5Z
         9Q/8mCl+1IFQ/w1ywIy49h1GTutukfz0Z5y3uJNdSxRMwdRg6nE6SKKCKtCqDz5eXj
         fFeAgvGNGVwd7gzYdER/AZjEb/zl2IKxaCW+TLYOM5eSKk6kmly0KlIYawMeDURxKC
         SXNnlbK+kk5mABUt7PQTPgka7TKW8R/HwPoc44oi4UcAYMRUYnMNBqMtUYPlkrehcl
         UkNsbAfRklszQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1pHw5u0uO0-00mcFB; Fri, 18
 Nov 2022 14:32:30 +0100
Date:   Fri, 18 Nov 2022 14:32:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
In-Reply-To: <Y3LD1CtKBoDhPdSZ@nand.local>
Message-ID: <qp0556o2-6q18-8556-0n8s-p28831qr6qs6@tzk.qr>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com> <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com> <128b1f348d8fad730cac1c36d3082fab49904b2c.1668434812.git.gitgitgadget@gmail.com> <Y3LD1CtKBoDhPdSZ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QBVbvYMsx365rNWf8HyzaS+9GTJwp4nBVG+q/VOeKyxs6y+k9Ga
 gbR/NgrZrlAd5amLKwCYxtwmAAOTopK558nOqBebLBn1NuJuv90opcK8TgCPt0hpxuHasUF
 zHcP0OVUgzkhRlXPOaB20FBp74G6W1Q2Qnt/yQAhq/CXc3E2sp5NBr1KFoWeBmrduSlnSrU
 xjJr5LromolHCCiKJMI+Q==
UI-OutboundReport: notjunk:1;M01:P0:yWU79Gp2czU=;mn2eHdaxgIjNEj0frgzbzugmZfK
 p1D/9WxGub5VEZYToB2pOW1Agp5hc7D6F1nAtj3h7ADBmayiZSWjxl7NvgGGG+h+Ol54WM1EN
 lmbPT27E8GQtSneLMKhCBx5VA/CRZU9bVpdDD+nMKhX5G28XCE61eYqr0y1AskoWOPHFoaP8E
 fkrq1Dr6STdCN7QOCHHQ70HV9gfKOfxiNzqY8w/jDtm5xsGc/0SUT6zcTNzR3MakaYpLAQWc9
 QHYl5RvIvlXTDjEEq94ZZxu4+TnsXZ4IzOhBQ7s4IwtS1rHPWdJg3Io2GOWzF0xPvpuqAUGn9
 p9EaAwLrAvI3nsum9URC+ntK+5apqzMm4jYfefRRIOB7GquHa2f9X5V4O/yZbEBaKqoVHeFOf
 /d1vdcT3H3KA4ry1I3K112KTq2PptXsFNuLCljNoVWuHK1cKYnjnIVqBWD8LwxuCT82WPHdp7
 v4bPCXPBal9Ba2OtnCiX8AHTkBh3+eSl/Q9PzZeRtt7tT9Bywuldhgf7e3CatzQrQK2u6WDTJ
 srtRAhj0+bXhu9BGYiSMStRRe2yNvJGK2Q50N4Q3hpSExYZiQz/9bl0ruM/DjYR5cRlCPEoIt
 LfP3xdq7kePhKmYcO/Gpb0KHfUD6BbNsWrIJI6mXej0+mrQGIB6BWU/r59AD74QfrrchyNhtk
 CIlNUJmu6qXCNMzPPNfVFapIO5xPEa3R/mO2TaG78lI/QcH+bqcyh9QkAFBOs1W0dMNw1eOZX
 dPOqZjzVrFn5W1TdSRwl12dzGfMOaYG1NII6vBGW7pFo4qYOPjVWNc4XTNuIIKdq9MgxEYV6d
 hQEeJK5ZyOfeQ+TAy7d2oeM/6PIhOaZj6Q/jN5zRGuBViDGbUCfAvZPh8UNdwpi9ZNxOKf8a5
 tfgeU/nJ8BktHdQQ4dMFxgfZwvARErQ1vkuXn9rbr0lGMzkD6qR9zSuG4GTtniKBEL9fnm741
 1fwh0smqyi8NouKxni6zb/j/bgM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Mon, 14 Nov 2022, Taylor Blau wrote:

> On Mon, Nov 14, 2022 at 02:06:52PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It is more performant to run `git diff --no-index` than running the
> > `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
> > Windows uses. And a lot more readable.
> >
> > The original reason why Git's test suite needs the `mingw_test_cmp`
> > function at all (and why `cmp` is not good enough) is that Git's test
> > suite is not actually trying to compare binary files when it calls
> > `test_cmp`, but it compares text files. And those text files can conta=
in
> > CR/LF line endings depending on the circumstances.
> >
> > Note: The original fix in the Git for Windows project implemented a te=
st
> > helper that avoids the overhead of the diff machinery, in favor of
> > implementing a behavior that is more in line with what `mingw_test_cmp=
`
> > does now. This was done to minimize the risk in using something as
> > complex as the diff machinery to perform something as simple as
> > determining whether text output is identical to the expected output or
> > not. This approach has served Git for Windows well for years, but the
> > attempt to upstream this saw a lot of backlash and distractions during
> > the review, was disliked by the Git maintainer and was therefore
> > abandoned. For full details, see the thread at
> > https://lore.kernel.org/git/pull.1309.git.1659106382128.gitgitgadget@g=
mail.com/t
>
> In the previous round, you wrote that this paragraph:
>
>     It explains why we replace a relatively simple logic with a relative=
ly
>     complex one.

Yes. And I obviously got myself misunderstood.

The simple logic I refer to is the `t/helper/test-cmp.c` that I abandoned.

The complex logic is the diff machinery we now call, which is a lot more
involved and goes through a lot more code paths.

> But I'm not sure the rewritten version does what you claim, at least in
> my own personal opinion.
>
> It is not helpful to say the original approach "saw a lot of backlash".

It is the nicest thing I can say about it.

And I want people who are curious what happened to Git for Windows' custom
code to have an explanation in the commit messages.

> It is helpful, on the other hand, to say what about the original
> approach gave reviewers pause, and why that alternative approach isn't
> pursued here.
>
> Maybe I'm splitting hairs here, but I really do stand by my original
> suggestion from back in [1].

We can also keep hitting a dead horse, but I don't think that will make
anything any better.

Thanks,
Johannes

>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/Y3B36HjDJhIY5jNz@nand.local/
>
