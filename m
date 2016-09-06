Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061661F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 13:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933797AbcIFNVq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 09:21:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:59774 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932806AbcIFNVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 09:21:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MdKDb-1bPJnF10Lr-00ITHU; Tue, 06 Sep 2016 15:21:38
 +0200
Date:   Tue, 6 Sep 2016 15:21:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609061509070.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TH0a12KBkSZNaKyg/tSfavuoCdX0w6Q8z4Y5ORG8d4I7BDtzz5B
 xbrYTelSCpsmBZH5u9ZQ/XfafxGfX3oG6YEpw7iHranPnFtJ4ir6L3qHaQJgBZSXZyMXL+2
 F3Lz4zXf/t3JM2H6FzILShVItGRy1Yd/sFAKuYwl0w0+So0gBCp4N5JE8+j8GYZfmxuL98K
 4EuuXWr2KVfM3wzcWh9iA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8gQtPIIdsVM=:fo9LrXeZYiS3AweIPIKVH7
 Pa6Y6fq4NJss4FtADYqom44VdI7roeo1joku325RgdWajUQVTeYoZT9RjSgTI3WHAp23yWH4u
 Lv9dIkjCWaupuwqlMq3fvVKW1CF8vTTvFfQYzVqSGhO3fbGhaUvHm2R7jDdTHyXoMt3ZUYvOL
 mYICefk6mryZe91V36B6TEZM9TtI/CHudMEoSRxaK0CUBcxP3peyFrxvmvhgoPCvfn9GD3fiB
 pFqkRg6J5Nqr23qFEXEB43GjeDaB28RMRaUF8TGo6ywPObb4xWTQbhWuZ+dRUlFH6s2Qw/FNk
 jVmjIjLIU/LKZRa5c3D0Ie0a8n/KAr+M0yulM70Ka+PvU53f2mtU8e173Uq+qyW9VvYcLoCYQ
 p1nPNuKFmpauSYr4aao7Xyi7cSOghP7j0NsnBZG4MvIxQ6+wQ9OUq1giJWAuAcY0+ragZ8J49
 Tdkmvo99wGzEq3nreYqUZS9X8vkNRcBcy2s2BtM7Kird61lsPoUn4L/u3/S9sZKwaHwWJrDma
 mTAZ5Wryy2hCwGWnMDefJq+96S8tV9B6V+4pUNDYCjk8mRUr2NYghFxrlI8q6e1H2FmwGLCl/
 gPALlslBaYivVXgulfxNX7a3lBC+97j6KkHUR2JwMYbkO8EVr4ArYh81PexE0SsSzOSiK0ljt
 Ov5ZKinSUytV9Wq/q0MC67iW7TqvYHzQ2DJb3J25CEVStanqHmxcFTGoSipsH487AGruoYAZW
 nHQowgUpsQM1bVofws1xTalyM4fItUSWOWHf+FA4rlMiwsZce8woglGuNske8k/cbKXPSGv6G
 LPpxEK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 5 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This patch series addresses a problem where `git diff` is called using
> > `-G` or `-S --pickaxe-regex` on new-born files that are configured
> > without user diff drivers, and that hence get mmap()ed into memory.
> 
> Good spotting.  This has been with us almost forever; I do not think
> the original pickaxe had it, but I am sure it is broken after the
> "--pickaxe-regex" enhancement.

Agreed, regexec() is the call where it segfaults.

> I am somehow surprised that this is a problem on Windows, though.
> Wouldn't we be at least running CRLF conversions, and causing diff
> or grep machinery to work on a NUL-terminated buffer?

It is true that the CR/LF conversion hides this problem. In fact, in the
case reported to me, it turned out that the segfault happened only
recently, when the repository was switched from LF line endings to CR/LF
line endings.

That switch is unfortunately required: it saves *tons* of time because the
regular CR/LF conversion just takes too much time. It was worse before the
repository defined the .gitattributes: the auto-detection contributed to
the time spent by Git.

So yes: the CR/LF conversion hid the bug, but no, we cannot re-introduce
the CR/LF conversion into said repository.

> The convesion code would have to look at mmap'ed memory but I do not
> think it assumes NUL-termination.  Perhaps people on Windows do not
> usually use straight-through and that is why this was discovered after
> many years, or something?  In any case, that is a digression.

Indeed, it is.

> > Windows (the bug does not trigger a segmentation fault for me on
> > Linux, strangely enough, but it is really a problem on Windows).
> 
> I think it is an issue on all platforms that lets us use mmap().
> When the size of a file is multiple of pagesize, the byte past the
> end of the file can very well fall on an unmapped address.

Correct.

> > So at least I have a workaround in place. Ideally, though, we would
> > NUL-terminate the buffers only when needed, or somehow call regexec()
> > on ptr/size parameters instead of passing a supposedly NUL-terminated
> > string to it?
> 
> I see two reasonable approaches.
> 
>  * We may want to revisit the performance numbers to see if using
>    mmap() to read from the working tree files still buys us much.
>    If not, we should stop borrowing from the working tree using
>    mmap(); instead just slurp in and NUL-terminate it.

I would like to warn against putting too much stock into such a test,
unless it is performed on Linux, MacOSX, Windows and various BSDs. That
would make it hard, of course, to come up with a definitive result, but we
simply should not make the mistake of over-optimizing for one platform.
We used to, of course, and look how much performance it costs e.g. on
Windows.

>  * We could use <ptr,len> variant of regexp engine as you proposed,
>    which I think is a preferrable solution.  Do people know of a
>    widely accepted implementation that we can throw into compat/ as
>    fallback that is compatible with GPLv2?

As suggested by Peff, there is a compat/regex/, and I will spout my
thoughts in a reply to his mail.

Ciao,
Dscho
