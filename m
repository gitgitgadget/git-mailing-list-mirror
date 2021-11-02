Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58BC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B6E6109D
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKBOoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:44:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:44617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhKBOoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635864075;
        bh=c4S1YbtuZms7RLTDCJzowF+SkirYYu28De5tdd0jARY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F1YX6SQHl7JbaPKGXPq9S7Va/aM/uMly4R6VTCrNee9f+D7Zi81q2eLxqnjxyqXeD
         IOB+jkCeo20z9GGmlGAR5mLgufqplski3/Rv0PA74Rz9nwIKo9umeLZFn6LY2UJvXS
         8dXdL5k1ZGHVkIgYmMzIcEOFWiTNWau5ifpDfm0Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1nBIMo1a3h-00Tzup; Tue, 02
 Nov 2021 15:41:15 +0100
Date:   Tue, 2 Nov 2021 15:41:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
In-Reply-To: <xmqqk0hvllxp.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111021535240.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <xmqqk0hvllxp.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q+Chd3c/FES1HmY9rU45vBAYe90MOyilItuHxBhb3yxWPLy3JHG
 khgPFP7/z1yL6yOTDMlqh7YcYD1924ZhDkGrIAxhB4XEsPq1qprzopJ66ZjWRZWxf4nfj1q
 gVxRWPEgsJAX1AxoUyvRoSQ/wNW4Zcyt2ltQdeOF5eiQCqlhodPjv/ayySbAnINrWEoDQby
 crsBUGb2Vy0rzFSnRPkyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:csEL9CoQI30=:vZVdc2qxuRk/j1FZxNNcuT
 PWzrnVd0yvQYC48dhJAgLP4FWmgdym/zGzs8WVK3qXoMK4af0laLlBIfGn9VybmTFDRFooY5D
 tYy8GTgzV6Vh5rlOOLFVh32UklxXC7hR0WPyFUSQ9V6lBaA+u2ut6Hm1+3weCn5ESG0LinLHs
 58CCKun2NtkQMeZdWuwxA8VGfOhigB7GXvfDGs/WwMQXhjF3YudhVwaG0ZAtWWHuB51o8APa5
 yNVWwfbX59KNy8/JNejeXLKvL89VQstMjQKT/LTS+i8QSZIX+5LTOXSuMgVbJLCLYNzDxqwMb
 KchP/rZmU2ZXvghPurV6syiN9XVPcdjSowwCOXzGbdkgDd0BGbtQtJJnIEArEcqhzAQQH97H4
 D0nVZW8u+mYNMOWhTECTSzUXHgBBnazLo8qrGMD4+wPoSmwYGkmCqNsrWTY8rbyeMqW6Zf1JI
 YaDvMAsXbtuYNi2bfxtHkEAFYcZdngWayMIQB79ZcenN5ws608N1gZfRfxNO2xDhYrRmnPLvb
 oAm6DU7bsW/ynb8LIuPbCfEjEmzlKOgH/bjKaklghom6AWqj/sbhO+WElV1lcmKH2v1lxLkG7
 EVkXO+g62gpnLpLJRQNUXXUmSubAU11qEI+UKkgf5QWtnEEU1jC/MLG3IpkFDg12y2RGLJJxS
 +x16YFxL1+LGYZIyrshNsV1V23SpFg7Z5IJhwLQHVQAPc1+8CNsouUyE1q1A6XIxQwE+4y1j5
 mqwtTt6e8jOFfEFmMSAhR2GctHuzfCjHoqlLlpfe5N0s0uAoQ3nNRfQiFQeo3WTN7WjKtLL3I
 BhRos1kRKMi+ogivLqjEbwyR87apKFvfYOOpWu46B+wZfLLt9KmNMU65Y+g4k4RxduX95U/v5
 85VkGacYUpbnz95gCDBjrC8L5OiWnsUfgLLxVSxyhzriudli5bK1PZ3IkWxdJcgg9ZfjCu8em
 EGMrt0CAk+C4vF4wrIsPiiKt0gK2cDJfoteC/ucvwzhxH2yU0IqkFdbDoyOeEJX1q9VcpCwyI
 YFD7Z3BCCX5DbL3V8hyJkDCsI4lGjPmU4xyV9dTwkqgtDPLMrJS+NwP3DxJapiWqAYD/w5A1t
 YO0Tazu1azw7hk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Oct 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > This patch series came in via the Git for Windows fork
> > [https://github.com/git-for-windows/git/pull/3487], and I intend to me=
rge it
> > before v2.34.0-rc0, therefore I appreciate every careful review you ge=
ntle
> > people can spare.
>
> It is way too late for my tree to go in before -rc0,

As I said, the intention was to merge this into Git _for Windows_ before
-rc0. And I did. The non-Windows platforms are much less likely to benefit
from this patch series.

> but the patches in the last round, with the "Changes since v2"
> description below, all sound sensible, including the decision to stop
> here, instead of doing "everything should be either size_t or intmax_t"
> conversion.

Yep, if you want to weep, you can have a look at
https://github.com/git-for-windows/git/pull/2179/files, which tries to do
that `unsigned long` -> `size_t` thing (although admittedly in an as yet
unreviewable shape).

> 7/8 did not apply for me to the tip of 'master', but "am -3" wiggled
> it in.  You may want to double check the results.

The range-diff looks good.

> As the primary author of the series, given the cover title matches
> the title of one step in the series, seems to be Matt, let me queue
> them under mc/clean-smudge-with-llp64 topic.

Yep, this came in via Git for Windows, traditionally I take it upon me
to shepherd those contributions into upstream Git.

Ciao,
Dscho
