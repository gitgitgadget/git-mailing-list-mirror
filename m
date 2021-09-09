Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0218CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D380161100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhIILGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:06:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:52673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233990AbhIILGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631185504;
        bh=08umJsBGy0vg37ayVXHTfm6c20YA5EYXoA3Z8cumugM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BX2RH1sAAj43rzzQ3GGRuI1oA2vwRSBAYfPlVgIgLz51pDo2dUD1kuJjYRucxmzUC
         bRQI06ihsebNhS4yjIFYicjEreuzKIqeRf00iFpb6/c40+WttAKuAF/49FxINVm/Se
         BPYPePbEMEBSwt9reeSUOIEF5g2qJwvQvjZAw0Gg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1mYdRG2Bok-00S4U0; Thu, 09
 Sep 2021 13:05:04 +0200
Date:   Thu, 9 Sep 2021 13:05:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: rs/range-diff-avoid-segfault-with-I, was Re: What's cooking in
 git.git (Sep 2021, #02; Wed, 8)
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091304360.59@tvgsbejvaqbjf.bet>
References: <xmqqsfyf5b74.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5Yoykexpb0F9A2VsKFURfhD5qWUiXepTYrFMinrmBWQEklgGpwj
 +GG0aqtkaYqmtpqknUruYARkNB1v/yn+womIbejhCrAzML5Vy/7KV+IgKJVuKLKQNkVpx0L
 RCNPAs++apiXEuD/WkNCllhD0UCTtZWxLlYsRogOq+mZ8OmDbI5yK/NqVVkbz8hWBb7lMW1
 zpRcFZZoCxf++nJtmmcMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJCzMi7mKdM=:eiqE0f3HVyXQhKZN3GNsIS
 NLWPrQEANT8Hnu6pagpVm5gwoOZ6wBwvR+QBsci5ro4BJqm/IPWiBidMa0KBfux9BFOj94SdJ
 qooYwY3Y06ClZF2rLxDzTDg807wDd0a8sV+ps9hK++ugiC4MIj/yOPosBQRaOZz4Mfp/FgaXg
 X3F92euWKIgWH4Bdivp5LEB84PiQ7E3y60/+0n74RYE74Jj4Jgsr4gjJX3l0faUxOYN2bIPSA
 rrp9A4mshdfrusUaigKOUOeU+YqN9SvAzJhmRwB/3cM10Am8AB3zDAk0IO53PVMs1iitOx9Xn
 EBO/hAHwBP6h8z2gSKlRrBVlLC2bCDsE78ZG5h5RmBcLu6kGxyzImqoaChgFaUW+eIR59NCk+
 fgMDJ8jISRBPL0PaVBCjeECjNPMQwJQUU566C89xU65/N+q61o14P+fBy5jtBkKpcGX5lEEaK
 xq/6aUXoouyc4bHfXfy/FCi8acyklFbniUODtzeHTEiWF0hZqlzuBKxK2Yu032GEeiaKoPJFG
 RV/C/DP18XHsmKi5k/SI0rPgFZaNktWWv0jXBY9dgvNV5RsZnaFiHZoehkgb2/oRv6s7Cgsqr
 XA3hBSvNf+Fl+oAqkOFmlpZ6qshS6vXBM6F/o63txUy/jXuQGk02xcnmnsPqvvWOe7KgV8n4a
 QejL8rAJ3LpyJcN/jIEP0oOoVZG2EjooO7o4VBIlnEXc8YtfN5cxQFRq8yfFzXz2FtM1/aZq0
 8VlUtGWMyRqQ4K32/XtsTElPcoKWt4uI4zwEM1nFFzWUVVeBY4kKfMVxGQxFi/kClPVtKfI5N
 NCYglhrYxnx0VaWa8lHxSuxVPkBpLhTdWgsdC80+/ci8NF0ODzZqqDinwLY/b0ldYn00/WWEM
 Ps7mnItTI63UODLgxR4D2Rk/O149tHQDyvXl1/j1+zTLCFSVrhccuJD701umST0r7cOZwIbhq
 yIiv0CCD18roMTDvhwTABtWAh+Is7Z7onQFwDBs2s5un5Ut3XjFz6BYSWTkaMVltE3rde6/+h
 UYhjYxeiGUWLR7mzmGR3Ux4974v5VI9VJuJMctJceI+n65SVGuhZRmDop5KQcNhTW+4wrVzBc
 COpt2S1lFsl8oY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Sep 2021, Junio C Hamano wrote:

> * rs/range-diff-avoid-segfault-with-I (2021-09-07) 1 commit
>  - range-diff: avoid segfault with -I
>
>  "git range-diff -I... <range> <range>" segfaulted, which has been
>  corrected.
>
>  Will merge to 'next'?

Sounds good to me,
Dscho
