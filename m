Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5D51F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757201AbcIHHzS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:55:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:56729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752892AbcIHHzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:55:17 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MK0Np-1bijW42YIn-001UQU; Thu, 08 Sep 2016 09:54:53
 +0200
Date:   Thu, 8 Sep 2016 09:54:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Use the newly-introduced regexec_buf() function
In-Reply-To: <324ecba64eb0436988aca846fb444eafda290d13.1473319844.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1609080954010.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <cover.1473319844.git.johannes.schindelin@gmx.de> <324ecba64eb0436988aca846fb444eafda290d13.1473319844.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:i/A9V1pWD8CXPiImq6Kqzp8dKic6YKonzAJ4B7MYCALGYL36gZB
 D4GX98blu/uomlgCgLgLFmdnQGsyxTl1PQ4wcf1riTibfr7CkhIi/16k+wtBjVfcp/2W82s
 H9ivm8HSuUEaECJLpPCfVWC/Y+T92apztNdhDsAZImiF2nKvxyQCSzLgJ0rngq/7wty1iZX
 m9Zl6y98PtM6rLr3y/vTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6wjBIRS0M8s=:ckVyQ1kO7Tqu+0Zz0nxF6a
 BDOjeFtGHOmxjK0a6dbwcRclPO+IICIChjeLSFi4P6pMCtvoqw1fpUTxwjxt8W22KG164/whn
 E0veYiHCoofuZkodrj8+x6zOqvXKWDG5wu/YbgLwVRL+lxQh24le70Q9NG7v4Aj19juSQitep
 F9R2MphCJGDFDSj9/mSss24lPS9+40m77xofUS1XMQneVVvZ/2nE1DUDDD7QKZmwnm1OcF6Jj
 YAXmPahc+aN6CMdd7wFg4NYUfpohihJXf250rhZQUvk+eKnqVPqwmYiOT/sHOAKG+AaPNEsjR
 2XrYJPzYFLV1vD8Rr1wPXfHvn1bdKGMysRCa1dWI/um5yntUAYBuhOr0rkfAGbvf9D4BJdgbQ
 FIB5piVO5FVIGE+++FmV2bPRfOndTYZdVDz13Wr5+0i3NgfcFaLPvAHN4eFzvCDqGI2qSagm2
 qBBGDM98IzPqObOI7J96DwtWDRSPi/HO2YW9iiSjr2uPN2p/TaViTkxQwXyehmTnOw+e0Wvgc
 Em/VUA8/ohEhDiR8/4rSqKgeX5HZz/N5/IHBJeLWEzWii5e49GGlkCsuRuM6QLFl6qtu1JNXu
 4DSnQF4uufLmUePSw08HjfzHcLq6YxtRPy8OXg6Wdqh5u2/VO8xz5Tq5Xyfx1kkiYkQ7pTFpk
 ZTaya0uqNx4YnYx9yLyKFFT906L8u1GWxztfvL/q0UpY3g0qVyrfTsdJsoTuK3rfliUtn7wi9
 eLyJVSVLy6JeCl24cxRBoPehfy+XWzJp3GgYC7j/ke9+dx3Np7fCK1FOrHSucfDE6wkJYjapp
 4yC9vYW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 8 Sep 2016, Johannes Schindelin wrote:

> The new regexec_buf() function operates on buffers with an explicitly
> specified length, rather than NUL-terminated strings.
> 
> We need to use this function whenever the buffer we want to pass to
> regexec() may have been mmap()ed (and is hence not NUL-terminated).
> 
> Note: the original motivation for this patch was to fix a bug where
> `git diff -G <regex>` would crash. This patch converts more callers,
> though, some of which explicitly allocated and constructed
> NUL-terminated strings (or worse: modified read-only buffers to insert
> NULs).
> 
> Some of the buffers actually may be NUL-terminated. As regexec_buf()
> uses REG_STARTEND where available, but has to fall back to allocating
> and constructing NUL-terminated strings where REG_STARTEND is not
> available, this makes the code less efficient in the latter case.
> 
> However, given the widespread support for REG_STARTEND, combined with
> the improved ease of code maintenance, we strike the balance in favor
> of REG_STARTEND.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c             |  3 ++-
>  diffcore-pickaxe.c | 18 ++++++++----------
>  xdiff-interface.c  | 13 ++++---------
>  3 files changed, 14 insertions(+), 20 deletions(-)

I just realized that this should switch the test_expect_failure from 1/3
to a test_expect_success.

Will send out v3 in a moment.

Ciao,
Dscho
