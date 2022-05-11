Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEA8C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbiEKQOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiEKQOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 12:14:40 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74466FA0D
        for <git@vger.kernel.org>; Wed, 11 May 2022 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1652285655;
        bh=KqruA2Rjx/O8EtrWzTQL8kUCotjLmDjmxeENaooV1fs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UgQKvV9/6oe2jq5bkJTQBXRrN8792z6Zc3KyxoQRsvUY4EJtoiMpsUyvIefY3FkUW
         274Wf3+5GegX0Jg2e/w0ziF/sCI96ZlWhVNF7Cwflgr3i8PF1TSQ3fHk/CXKcEXRDG
         3Rr3RUdRUCawVOZqVBAY8L8ud0u5ItRUAQ/HAEcM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqTV-1oAOHu2fL7-00mXyg; Wed, 11
 May 2022 18:14:15 +0200
Message-ID: <3cf6e4f8-9151-6d68-21ca-b94d6a7557e6@web.de>
Date:   Wed, 11 May 2022 18:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com
Cc:     'Johannes Schindelin via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org, 'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Johannes Schindelin' <johannes.schindelin@gmx.de>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
 <xmqqtu9x6ovh.fsf@gitster.g> <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
 <xmqq8rr955zf.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8rr955zf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JeyadmIpK0Y4+R7bII+TYBvp20ZfvFSY06dibZDu+OBOlVdOB8z
 6ragH073hhSzn+rmMvvncX+7rBbAwWXCX2m/fTG5Xr9+wQTdmOC293MD4NeghoJ3SSAT+nv
 hMeqXTuwW6UhP6s0Xh5zHdIw7rd/NoR7UyiTaDEdQzs/kuIP52qWpsopAtPLgAp1l/gbBiC
 Le7YubHzrj8+WhdMlp4og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FDURS9nEhtE=:TyT+lp08zwq55Mg2DN00Td
 nN6Fw3JaKJEQUDG2wlW81kOVNyxIwNRuQRYt9CXdUYwlAn9EBIpH0C6tWaPErWWhyVul8MZsz
 1cb892Uf+LSgxOBPbkNoeUQg8Oq0M8X55r9K9K8fAxBXiS+4tXz1dM6yY7z3Nj5LX0iwqfMLo
 r9r61j67J6szuIJGMniAc7Rpjr8DTVEX0Jobvcsiw99J3+0T6g2s30/J3EyYhEi1k74Up+/Iq
 Oh+nNv8LTYiNIbCSlXfsHp0MBh+ECwAZBsbAQmaB8xF30TrkWKcY0cN3QU1rjol/ryt77+jM7
 DM7ObZi6Qv/eEuCyUTcNPnbO9oqetsfkCtDsDzLImDmewSfezml6R7dJ9VpGbFfPMCHzRUic5
 JldpxqXxC4MQ/urEHKPTgRP4V7uf5zbbYWsQR3Ut3t3ltQP6O9UikaMFvBsp5zVCnK4kvpSDC
 /bLz2nw9VoUxXB3Wh/yfBYAomoYGckVZkA+UtFZdD2H9v4Y34fm5llYtwGfGELExraJFIkNhl
 ZHaFDbz3bYV2ldR44Mu3QBuLGQxhHOcyaoSVVlkj6U5ZgX+p9vnMVE/LfEE/Ms75WaRTDfgRQ
 Labkju5ap7ro4T70ZQ8bZuEF3jedrT8+JXKzpoxSiOnx0n4WD9Zx5njTG6z9c67GXJNPLEXWZ
 CWHpgreDTz556HfyBS1fKlMoAl2KoK5VjeS4j6AjGpSzDHlYlIPcoRlMJNtkVUH0sMp87CDjI
 OK0Od+N+tFAg9SKyElwK5HhopTqTI8L7/Hfe7Co8D7s1+Tc0l3FrKO3DS8wgCP7+CcJtb4huS
 zFL3UouRnhvXhURNqFJ2o4dlejvsH0epyrWcp0R5C8lHtJSM2qH/GUr67BegCTRl24Yo4H6RX
 w45KmEZ4I6z305Lt+a2RjfxnG4cAVeScLJJJNZw3GtcFCPIfoJ1ufKi0Hm4whNFIrScdGSlRB
 t/b+jDzq3iACtmIBqVjcS4MJlkSTN4wUdfEUwKOYqdfAJDJuJX5lniEg5EOGYpfh23s+wWakv
 cMfaXY/GqpU2HiPN2qfWi17G54kHQsuUXI5wSuSK1Dor2YdNnSVFS4V2oi8rESILP7ZM3iE5k
 WKXxj2uwferCnZCWC4YxgKuKnA77xd5qvKs
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.05.22 um 01:21 schrieb Junio C Hamano:
> <rsbecker@nexbridge.com> writes:
>
>>> If we did "--add-virtual-file=3D<path>:0644:<contents>" instead from d=
ay one, it
>>> certainly adds a few more lines of logic to this patch, and the callin=
g "scalar
>>> diagnose" may have to pass a few more bytes, but I suspect that such a=
 change
>>> would help the project in the longer run.

> I did say "scalar diagnose" may not care.  But a patch to "git
> archive" will affect other people, and among them there would be
> people who say "gee, now I can add a handful of files from the
> command line with their contents, without actually having them in
> throw-away untracked files, when running 'git archive'.  That's
> handy!", try it out and get disappointed by their inability to
> create executable files that way.

Which might motivate them to contribute a patch to add that feature.
Give them a chance! :)

> And obviously I care more about
> "git archive" than "scalar diagnose".  I very welcome to enhance the
> former to support the need for the latter.  I do not see a good
> reason to stop at a half-feature added to the former, even that
> added half is enough to satisfy the latter, when the other half is
> not all that hard to add, and it is reasonably expected that users
> other than "scalar diagnose" would naturally want the other half,
> too.

FWIW, I'd already be satisfied by a convincing outline of a way towards
a complete solution to accept the partial feature, just to be sure we
don't paint ourselves into a corner.  But I'm bad at both strategy and
saying no, so that's that.

Regarding file modes: We only effectively support the executable bit,
so an additional option --add-virtual-executable-file=3D<path>:<contents>
would suffice.  It would also prevent the false impression that
arbitrary file modes can be used ("I said 0123 and got 0644, bug!").
And it would not even be the longest Git option..

Ren=C3=A9
