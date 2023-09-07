Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73364EC8738
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjIGPYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjIGPWV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05D1BEF
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694100110; x=1694704910; i=johannes.schindelin@gmx.de;
 bh=jgvHBqSZtDZnggCirPfxmJn0E3bpLTGXj6gVtRlKkzo=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=dA0HEG775WSHGWL4+IsPN6XrN6yDkS0E6JjRlusEPNOPaN2m/IaUZtdwAfidaM0ojahmdG9
 PFR62fCrd3rktYnwLcuULf+t6PF8Au4YtQCq/ihlrFrfKKIQDkk3AH5c3EAkFz83LRzyacJAP
 cSmeZKUu+bV6F23coAW+KkWm4oIizi1qGKFNWgkbwSkMqZ01e+c+rhEncUI88H0DvpS0W4zeR
 rdH4RC3FFrTHYMAEtyslVvlucE8TC8c6whwmm9lIomAtcgp6AUD9xj7MARER27Ekr2Hk1JD+r
 wS14NJajpeFIABwhMpqEIVGdlHjOHOt7HnrYhIPUuE2OZ2Lu9AXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([80.151.253.86]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1qQ9UI2ilz-00HPmp; Thu, 07
 Sep 2023 13:03:17 +0200
Date:   Thu, 7 Sep 2023 12:24:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 12/15] replay: disallow revision specific options and
 pathspecs
In-Reply-To: <20230907092521.733746-13-christian.couder@gmail.com>
Message-ID: <f0e75d47-c277-9fbb-7bcd-53e4e5686f3c@gmx.de>
References: <20230602102533.876905-1-christian.couder@gmail.com> <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-13-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UQxI3iZ7A9OfVQUZKdUIXRUy3ewBCs1sU/owUuO0fsPTUpAvNpS
 0Nv4cCx9A0iVoOOpxp+1/JnKQXB8wL8l0/gpJCnkuVPe+Y8Y/RAp/aUcNCFGlxgjBCxfcjP
 qdjyztw1q1S82DRE/Tb5OkEAnFsRNzcLdbh6y7uRTPAkvpPk0xtT1Ady+wBpmH8X3cxyvF0
 UT1CNtWU31SWSdiLPD9CA==
UI-OutboundReport: notjunk:1;M01:P0:+LpJcgZz/aA=;674p+0VB+4EpJQVU04HwQ+Zp0er
 JHphjlNX4+yyshaSqtmV1bsHLlTtqLuPHz5K5KuTVQdJqotZdkl7ulwzDQOrZuEUFVXRXhi5S
 HxpOSnpAVI/zmzyHqq5+GH3ZNJRj+Xaem5kKdcyYUw7UO7E5FrznIkvu0C6iLEueFEgMWQxk3
 5RCTzfdS/6gCIFSgnHCro47KzAzyJ7KDTNhYlaGBYyM2YkHYxN7LeLN6lw0CWdKo2xwJjDFHK
 /rM6Nm5DuCEKfM7Ko8SI1AmUrq40q8d/qwX3pmHwFQyMNYsRBHGyIxxh3wYHIPnionSgqc4o6
 EhAYNWtAAUP6UxeX/KbNJk6mUcH0v45uWDE1wHO2YbuIfjnKfAunvIlCCi6Iq0FMWD7vCFQBV
 m0S9Ri7WFQw69bzjga/40IpAZu0z4J626C5uNdsC25Ds0YZY2ExC9k6odLT3w9kQb/ZYW3tk8
 m+m5ahKWPx8DLADEySE9nErKtqjYYRGVIifcQkzNBKDxoDk+QX3Ak+BDeofSTLeb7dhk/f+lR
 yDHgjC0ZdVGKZxSKODp/ml3eUWZN7qXUErTGkwhHh1v56GOh++c3eyZ9fgqOulClu+4xczm9O
 w4XQLQKaVy3XqtO057+PnUNU4pzoTK9SRodDTt4vqf1zZW/1iPBxVS1UbSu62Hj9b1S+Ee5Wn
 v0yfusMXnOEZ8kn7jI70chOEFgbrZELn5HkWVsiqx9unyWqE5gHMnP0/94PFJttOaxqIqZW3W
 78B/tZNcrNXOtQdCYWne8tyTTdq0l5eBBXu2spycGRVZ3WFG7DPrXLUMs1+VjkzNxWTI6VuTn
 AivHfQ0RTUp2I0IN9dKBXks9FJq0gGMIV7+7Ru7t6wLAUxPUGVwibWPFR1wtW3g6gDqzFVahO
 PGS0/60QzNRLI/OTvJasGS4dOutFdGJgN55Q9P4kTqbwz5HedSoq1i4xTvJGLI2evEU9Wv4GT
 LS7Pc/nDsMk3M04pR6vLIVx7064=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian & Elijah,

On Thu, 7 Sep 2023, Christian Couder wrote:

> A previous commit changed `git replay` to make it accept standard
> revision ranges using the setup_revisions() function. While this is a
> good thing to make this command more standard and more flexible, it has
> the downside of enabling many revision related options accepted and eate=
n
> by setup_revisions().
>
> Some of these options might make sense, but others, like those
> generating non-contiguous history, might not. Anyway those we might want
> to allow should probably be tested and perhaps documented a bit, which
> could be done in future work.
>
> For now it is just simpler and safer to just disallow all of them, so
> let's do that.
>
> Other commands, like `git fast-export`, currently allow all these
> revision specific options even though some of them might not make sense,
> as these commands also use setup_revisions() but do not check the
> options that might be passed to this function.
>
> So a way to fix those commands as well as git replay could be to improve
> or refactor the setup_revisions() mechanism to let callers allow and
> disallow options in a relevant way for them. Such improvements are
> outside the scope of this work though.
>
> Pathspecs, which are also accepted and eaten by setup_revisions(), are
> likely to result in disconnected history. That could perhaps be useful,
> but that would need tests and documentation, which can be added in
> future work. So, while at it, let's disallow them too.

As pointed out elsewhere in this mail thread, I consider this patch to do
more harm than good. After switching the command to plumbingmanipulators
it should be possible to just forego all command-line validation and leave
that job to the caller.

Therefore I would love to see this patch dropped.

Ciao,
Johannes
