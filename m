Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACEEC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A18206D4
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TcPXq3bG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgI1Tvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:51:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:37163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgI1Tvg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601322689;
        bh=jS2qkcW/lfIsC0Qy9Y3uVqK+HCKW/VggH/6yCUUxP10=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TcPXq3bGLPsNVMVvNt9E/QSHZYmy/ZH7RruSp4ouVqFelgFWWlXIjkEv5UbRRMh3l
         k5069ynXZwNCJLC7UPaaEmRAGwXC/hfJ9lGWo7O0YxeuH89rX1JCZVD3B2iVCyaROr
         00pC6uYN1+skDVlN1k3uyMTYwYqsuFRhG5lxm0VU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.212.27]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4QsY-1kWV3n2nLS-011UUp; Mon, 28
 Sep 2020 21:51:29 +0200
Date:   Mon, 28 Sep 2020 21:51:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [RFH] sequencer: simplify logic around stopped-sha file
In-Reply-To: <xmqqo8lsgjxt.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009282150190.50@tvgsbejvaqbjf.bet>
References: <xmqq8scymmo1.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009262320530.50@tvgsbejvaqbjf.bet> <xmqqo8lsgjxt.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OIb37IQysQg8dLQawfbBffFOwP5TvzMmEhcKgiVQfMjAx6o7Wsb
 eHtzIuVCyJGbUvswjRpCgccJvpaqfzc7NS+kvLrlNj/1JXNSxsdsZuJ0ydljW1Ax0eFm2+c
 TYBFpg9MVFWah6IDHQYnfmOxSw7NpoqFuCL0Ban2aivEUyF3kCBZSQFwpS+c5Pk3lJFVOxQ
 BlgWq1m5Vd4EFR4cx/Z3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ahDLgqzYhPc=:V0+BChOpwge9QNmSmJ2a47
 fD3zNRwm3xqmR4ReR7iPq5hB/b+v/ZjiFf998MLcvuZ5jrOyF0iPoss7OjW3kI+GaKAtYuqh5
 QTHGCo7rCdj6jP0lDyMLrJws/fnZYFREKqQnNQcRGU2+XuDbAxLEE5bPqIFl4n6YWtW/mwTQg
 jxIhpmGkRsUz9cyHLHzBegywEvoiBdimdcXBotVZ59fB6tr/Et2Ypnu/g5bpHdMD1oWcf2+KD
 7+azkIU+Zmra36JNDOiEGpTZUxq/ZQTDag2ybM5cByaYNOW/xMoU0F/4X9tRckIuvwendxsNT
 BnwxEe1vhUdIdlsZznIzTnUCXZWCvgF/y7+eu1/nYm7C5L/F0M6G1In7pntIWp+6Qr+OHd234
 8xpoasOoTMQ7BrGUVS3t9w6Ni5dHfQ6ZdiszwXE6HnV3a0Us9BwnLuo53fc2vaxP2qODXECJ2
 D3hTPiW6y7jdcmzB2KWGrRFxAr0Rz6b1RXIKynnTaugWghUQzjJFAjSHG4WasUeullusa4oPE
 OJNxibN8RHxy4dE/6aIPy4JH4QvrDzAMHKHwfrfzNugLNh5yKnu+Tdk7JiGRndUW9uU1BnTiP
 hJt5p5uWu5qMddW0Z+Af1ExRS5keGlEhbu5zO4WI5kraObVIZTGulLmtI/YkWec2ce2UEM8wl
 VlTrKIiyD2dU6eYOh4GZz84hIlt2WqUX4HtccDReSi/5Xt/Voy/DqvbNpfQitY6QxSoQLN/7C
 fwZf1cNHkEk//vyVY2PquxdQDmNXo8DsBeHQwSXkvsxilnWywIXH9IOwKjVqOpLUvYFRIBHv0
 g4aeSPMZ1NWWQgZcoHuKVRV1hLUY2n9jDWDpk35uUADouFa0lH4reL2UOWDTJjkN8ZpkmqYEm
 +JoTcnwfhs4yXDqbu80S6YT79g24zu0V+aAzMSNXodWTvz2HH5wzTA599EfDvJiLAor9tViNO
 1yclpICjfoqRMGMHjiK14+GGNmsnsH2TCgta4bCTTYAc4RXlUcEvS6y2R0zWTr6Ww3GJbuVOQ
 AkFNCOQxAwnPhb4pwrEQ/smqo4a/szVHtQScZwnlFIimH1k04PWPFB3tq0uXxu1vAG/VJph/j
 2MnqvSlb984EDwdJqRCy0lR+vXmpGOHj+FkJ2cUma0pxcTTBYHgpum9uo4D4ro6kgKtdnGpNG
 T01JoHcakgtHUxJ2ptA9qEF2EJH9lRvJ6KkuRRwZ/BgUdtW2YSk/02W/BQ2g+zr8vpzHAKEky
 eV7Tc2rK6THlawCGCR3McntadBMJEg5k+NgjtJw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 26 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Is there something obvious I am not seeing that makes this change a
> >> bad idea (other than "somebody may be in the middle of a rebase and
> >> all of a sudden, version of Git gets updated to contain this one,
> >> which is unable to read abbreviated object name the current version
> >> left on disk", which I am deliberately ignoring)?
> >
> > [...]
> > - and most importantly: just like we expand the commit IDs in the todo
> >   list, we actually want to expand them in `stopped-sha` because it _i=
s_
> >   possible that a new object is written that makes the previous
> >   unambiguously abbreviated object ID now ambiguous (e.g. when the use=
r
> >   commits in a separate worktree while the rebase is interrupted, befo=
re
> >   continuing the rebase).
>
> Exactly.  I just wasn't sure if stopped-sha is handled with the same
> carefulness as the object names in todo, which are expanded after
> read and shortened before given back to the users.

The main purpose of `stopped-sha` is to let `git rebase --continue` after
an `edit` command amend the commit where it stopped _iff_ it is still
`HEAD`.

So yes, I think we need to be as careful here.

Ciao,
Dscho
