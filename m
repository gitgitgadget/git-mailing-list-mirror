Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33523C77B7A
	for <git@archiver.kernel.org>; Wed, 24 May 2023 20:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjEXU3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXU3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 16:29:48 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E8122
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1684960180; i=l.s.r@web.de;
        bh=zfSvO1tStPaaab7aVvICUs+reYYqKDAqXLgR9BZ+EXE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nzfZjfUQqtz64rAVEGiV1o8ztYEflDg8PfKvjw5lPFLzwpHeSOGYP/ECBhJJeP6kR
         75NbSL+s9P33aBhTJM7k3q1KB/2WPcso9Fcmza5rMX2XZbyEyH0zzV5YTMvsFIVoRx
         mh+6rWIKK8Ur8ywTR3Wl5Hvhc42a+OeagOOfHK264KmRxJnFYH0rgR7/V5wGcKZidH
         qIlgzbkaspwRu92bB4iYpKh1/B5tRL5GEwHcsG8d+pei3xZKEafbfd+sH9bLCuwOhg
         0P9HLpNo/9SxT/G1CHUeaKmkXbXk8h5or9rGXOIfZp5dnR1s2n68jJ4phxJF+k8d3h
         tdpxBl/8UctDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.75]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1qZ40Z3gKW-00bs1Z; Wed, 24
 May 2023 22:29:39 +0200
Message-ID: <c8d32d5a-9803-9eb7-baaa-49b4521f0c37@web.de>
Date:   Wed, 24 May 2023 22:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3] builtin/submodule--helper.c: handle missing submodule
 URLs
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
 <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:birfdftro0nmH/WZhkJIFV/tSwKJ4uOAONjWjGBnUoSFJslBuNY
 NG3jGyY6xQbamsgGoaxkrdTZfL3u28fUi8qtrcMdgu/2kcOzhpfgDh0mVptF9wB/UJeMLEv
 EIFLfTJYs/8/lvYccGDnbuj8iMNrS4PoA6HyogIzCDPQ8PLNaYFP7ddlVFDoHE7LeU2UsD3
 MKVhBsEzA1TdZkgR8FMiQ==
UI-OutboundReport: notjunk:1;M01:P0:TFpm3w+by3o=;VBWYagOs16RnnTwdtEEwz8Hcs+I
 ag3r2j4NQohV9btHolBnWxoy5OUM4cbTAIEbsm4uT7Pjlw6q0l+V6ja4FgjR/Ha4GKmgagEB6
 LGKHuy2Y9VP2rpaBiXo6CDqp88OOPB3SuVBx35QdRN7vI2QyqdlHP3hPzORicIfpEDmD2Aa95
 Rk6UW6VVZhg72S3WM6mtwFK3wxqZaPmnfZ/d9v4THUsWPwMzSe1u0j8SrNLHgKnfQwsONGEDD
 a8h1nFkpAD4Vdgc4CMhplFe4QZhtrcaBPizbmspcYYtdEfj632TT2uM19swE/JpecMAEcumqk
 9z5A6UY3iIIukV1MwTcH61A4Bf9ecW1BDW1HXoxDKT00PZXGu8rWbGnnwRbXabYkrFEzt9LC6
 +lcTtSU0+6mBbHNDV0C8+YGplfZ6lZAcdSNtq81wYkucjh6/m7arIsCYCf4tL66Ckrn2ErDqk
 H0qXd13Cji6xFWGmAtQJo1rFwRaZcO8XJ0lOxDacMyTrE9XvUbqAzGy9cHdvPpyarsE0rsu70
 J8dAcamgL0M9Lxqh24ipR+sxr4yKp/lPa5p+oE4/hsz+sVJhekZijdI9EuGizuq5psmrAQpCm
 KfCG2Y6XopHYZloXuSnI1S9jAVUMK0yDCw1FgNZ0GiHRmnf4XYMuwOVP8mM2JFSbKqLj9B8PD
 VvQlCIal+9iuhQVvpOhyugDWwJLB34K/cIfpYhcsdSfjEIYQZpfNtKZWQYIpAuEWHwPugwnuR
 6QXYDMeTHRw2WTgfYS/0tZfQYf0KBOUFf4Os3iuRIUPEHk3dQ7pWx8IV+qTlSG8FCpOphAVy7
 Petdf2oNLbasPhmbk4b53tF6eVHgl7ZN7ANfJthgVc0nDRnWXvh4ZKBFWIvxsRcLB0y8tlzmh
 KsY9HQUCPkZrZ/GOeMT3BNDQAccKbSCdZjQDthgrtmq4UUfSuhlHZ79Xq2mm36fUZ8JZ+DHxX
 HIlhuZnPgKP7bA9rh+czoioVUe4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.05.23 um 21:51 schrieb Taylor Blau:
> There is no need to check whether `sub`
> itself is NULL, since we already perform this check earlier in
> `prepare_to_clone_next_submodule()`.

Right, and if "sub" is NULL then next_submodule_warn_missing() is called
and prepare_to_clone_next_submodule() is exited early.

> By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
> branch, setting `url` to `sub->url` (which is NULL). Before attempting
> to invoke `git submodule--helper clone`, check whether `url` is NULL,
> and die() if it is.

Why die() here instead of just warn and skip as well?

Ren=C3=A9

