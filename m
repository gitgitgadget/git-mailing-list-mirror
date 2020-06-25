Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3609FC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0B220707
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LdjoTphX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406949AbgFYRwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:52:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:40993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405562AbgFYRwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 13:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593107559;
        bh=D07/MadSeBdY4XR7TAC1eLZEJEvXIMsPPnVk8hsjkj0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LdjoTphXvEVXBZLU28uBo7RSs2mpPOoXa7XTmbUQlgPGHMvjop2XU5j9dkycvRrHy
         3bxvHKLtBnbH2oCkVl70Rcf0d2pjGtsksyljviW+Jir4kMAkYlAsz9Xz4RTwY0xmEe
         YafuH2SuhIdJvaQKTx66vYNasIHOsnDybVYSw4KU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([213.196.213.24]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1jHfLC1daz-00bqN4; Thu, 25
 Jun 2020 19:52:39 +0200
Date:   Thu, 25 Jun 2020 19:52:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files
 correctly
In-Reply-To: <xmqqy2oc8oye.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006251618070.54@tvgsbejvaqbjf.bet>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com> <pull.654.v2.git.1592916485.gitgitgadget@gmail.com> <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com> <xmqqzh8t9vf5.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006241517320.54@tvgsbejvaqbjf.bet> <xmqqy2oc8oye.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jGEUb0+RXp/IZKJTMlnNf2VzEAPgbFJ8mPrAoq6Hya3JGExz5Ki
 jg4w5+/8dwKMItxIXoBUY86XacEugRdDuSenOkASE6bNChQ1AsrzVDHvbEZJKrB8DY+3GZn
 2klZGzEDJrK3H9HAMrpc/5dcY8xfcXSD1B3Tbhw78UfTC0wohLSVbt+oAT8lRVo8vFibXcD
 1rojVnyuFZb3iSTuG5w6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V999OsKnhAI=:+v+FyAPNsc8E0eg2zXflsZ
 K3wfNKPeJoM+OpSztF8E+dwz6372DbI+Z/J5vhqElfHcT5n4IXmQyJSe32F9D5JceiZUuhqtf
 d1DyNFi2Reavhhzv376oOWBZ4uxsLefu1CKnvDomMh3SidX68iL9TFb4Ld24ieh88ydHEAFDK
 DW5sairwk0mafKCwI5ptV1U+19pDmeR/kEe/7OD89xACyyiU2LPXUZwU8J213UC082fpSsTGf
 WxgbC0hSPD18OpH/cxO2cUX3q09GaSs4cRSlydAoZOuyx4IaIxUBhN1JNM90D1FxB4SNArWDP
 pzbo/OP68kHKWDieVckE7IlKlQ1o0xw9ZhArs4FA4cXU69eieQErRxnz2Ac9NzE/sppwZA2Pl
 mXUXDtJ1H94H51GWBKyKkDBoOo5xJpMS+3LDp6H/9NieWOP221tJvKv2Pm7+CLG3AGvDy3MHv
 RtVwFuV4lc0jhyoimZIEscdK+MDAP0VfAOue0cQQYNu/aZE6BSiqBsGCKTv/NgWQhqix2ossq
 7HwZarbFaqNlauANJuew83hvG7JqZMtR9pT/6pESGRYsp1zHgRtOEvGpY3KUX9q7sd9hX0HD6
 j35y3fPXgyU08DItT1bBucKiDt74Zkt3OtlRTm7t8NpGX8W8dw148QH6uJPTwVBqyvucWw8W8
 ULzMr0KVbvyPTtkxHGNZje5XrDyOJdiibhFuBmnmAGt+YW+UxcR0ZTh+Urmzbb1+QXpPv72+h
 ld0hG9eGpBtiDI2Aj2QI7UtBRQoJ3DwPwvvCUlNUZ1Wpuxwz1rZpc+6op/otOKJfp7izZCjwt
 zdO8askDsQIjK26ko69ryNXAArz2diXSd0gVEokboLo3RUKNLTH9wMC1sZhCXY9TFoniU149Z
 ndCb85yeoEyIvKebJH3fpefnludaRkL/dTRvBC4p/+ei+PXtvYGqfFGwfG+Nbd3EUxndpd0Ey
 0vrG6+IqULKC98X/0udipM804JgFJ0ETsSW3vlTtj9CjZOBSr4aMEqm+nYcDfrn6R1jmY7UZT
 OY3pafaRHmUtdeP0Z64EtHNEVe5x+xypFIhY8ic1rXqSJTdzOMcNa1zj6f2dV9vzHOVjSGnNp
 2h2RBDHIbnbu4MJOg5smxjjRIDGdluNhKquAqPGNh4KcgbCL4osfkdoMnVMwOLYaVZteqmm+n
 rJYeA6dvL47IZtfes+kwgrkEt5YBUHdGDBtxePC8tmcSIMWvDl+2jGHVxZ8RBbXPmfJXa5G2j
 eqhkOQbdCUXO6wBZd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Sure, but my intention was to synchronize the `--raw` vs the `--patch`
> > output: the latter _already_ shows the correct hash. This here patch m=
akes
> > the hash in the former's output match the latter's.
>
> That is shooting for a wrong uniformity and breaking consistency
> among the `--raw` modes.
>
>  $ git reset --hard
>  $ echo "/* end */" >cache.h ;# taint
>  $ git diff-files --raw
>  ... this shows (M)odified with 0{40} on the postimage
>  ... 0{40} for side that is known to have contents from low-level diff
>  ... means "object name unknown; figure it out yourself if you need it"
>  $ git update-index cache.h
>  $ git diff-files --raw
>  ... of course we see nothing here.  Wait for a bit.
>  $ touch cache.h ;# smudge
>  $ git diff-files --raw
>  ... this shows (M)odified with 0{40} on the postimage
>  ... again, it says "it is stat dirty so I do not bother to compute"
>  $ git update-index --refresh
>  $ git diff-files --raw
>  ... again we see nothing.
>
> Any tools that work on "--raw" output must be already prepared to
> see 0{40} on the side that is known to have contents and must know
> to grab the contents from the working tree file if they need them,
> so showing the 0{40} for i-t-a entry (whose definition is "the user
> said in the past that the final contents of the file will be added
> later, but Git does not know what object it will be yet") cannot
> break them.  And the behaviour of giving 0{40} in such a case aligns
> well with what is already done for paths already added to the index
> when Git does not have an already-computed object name handy.

Well, don't you know, I never realized that the hash shown by `git
diff-files --raw` for modified files was all-zero while `git diff-files
-p` showed the computed one matching the current worktree version!

> > Besides, we're talking about the post-image of `diff-files`, i.e. the
> > worktree version, here. I seem to remember that the pre-image already =
uses
> > the all-zero hash to indicate precisely what you mentioned above.
>
> The 0{40} you see for pre-image for (A)dded paths means a completely
> different thing from the 0{40} I have been explaining in the above,
> so that is not relevant here.
>
> By definition, there is *no* contents for the pre-image side of
> (A)dded paths (that is why I stressed the "side that must have
> contents" in the above description---it is determined by the type of
> the change), but because the format requires us to place some
> hexadecimal there, we fill the space with 0{40}.
>
> When we do not know the object name for the side that is known to
> have contents without performing extra computation (including "stat
> dirty so we cannot tell without rehashing"), we also use 0{40} as a
> signal to say "we do not know the actual contents", but the consumer
> of "--raw" format is expected to know the difference between "this
> side is known to have no data and 0{40} is here as filler" and "this
> side must have contents but we see 0{40} because Git does not have
> it handy in precomputed form".
>
> The above is the same for "diff-index --raw" without "--cached";
> when we have to hash before we can give the object name (e.g. the
> path is stat-dirty), we give 0{40} and let the consumer figure it
> out if it needs to.
>
>  $ git reset --hard
>  $ touch COPYING
>  $ git diff-index --raw HEAD
>  ... we see (M)odified with 0{40} on the right hand side.
>
> When the caller asks for "--patch" or any other output format that
> actually needs contents for output, however, these low-level tools
> do read the contents, and as a side effect, they may hash to obtain
> the object name and show it [*1*].
>
> By the way, as I do not want to see you waste your time going in a
> wrong direction just to be "different", let me make it clear that as
> far as the design of low level diff plumbing is concerned, what I
> said here is final.  Please don't waste your time on arguing for
> changing the design now after 15 years.  I want to see your time
> used in a more productive way for the project.

Thank you for patienty explaining to me something I managed to miss for a
decade and a half.

I'll send out v4 in a moment.

Ciao,
Dscho

>
> Thanks.
>
>
> [Footnote]
>
> *1* This division of labor to free "--raw" mode of anything remotely
>     unnecessary stems from the original diff plumbing design in May
>     2005 where the "--raw" mode was the only output mode, and there
>     was a separate "git-diff-helper" (look for it in the mailing
>     list archive if you want to learn more) that reads a "--raw"
>     output and transforms it into the patch form.  That "once we
>     have the raw diff, we can pipe it to post-processing and do more
>     interesting things" eventually led to the design of the diffcore
>     pipeline where we match up (A)dded and (D)eleted entries to
>     detect renames, etc.
>
>
