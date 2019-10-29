Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41DA1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbfJ2OSn (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:18:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:34447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfJ2OSn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572358710;
        bh=XPUoLyenjcCJkLKcW7LLiJtORUpLdA52gh79TuyXp+8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H1IlOkxa4U39MeQUmWqXEam8AlgeBs16tosDgfo6NVtnS9fHDrXAePb09UwkMa0N0
         6Jp2O3LC1Zfw0APpDDMEijXhkjvQSBRVb86PUSwwPobIIizEjakGLHUueyiT3vpt7y
         CpwGJ+FyEmsHQE/9moNMZ/cc2BBsWZ5nOqBizrL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1hdWZo4Ai1-00mprs; Tue, 29
 Oct 2019 15:18:30 +0100
Date:   Tue, 29 Oct 2019 15:18:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered
 one
In-Reply-To: <20191029135221.GB2843@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910291514090.46@tvgsbejvaqbjf.bet>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com> <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com> <20191029103842.GV4348@szeder.dev> <nycvar.QRO.7.76.6.1910291334210.46@tvgsbejvaqbjf.bet>
 <20191029135221.GB2843@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UQja1YZkL+RLa1p2TGzzqKc0+FqRbjUuupmTCKOLZEz2nu69Mwv
 JeYIo2LkJ68ncsXGeYMWJhcqXpI4Iam3Skb0INAkUwzF/VN/ATkJLZF/5dK6Imr5bpkz4Zc
 VxiUrEdCNZ2veGojeS9EixYQ22e95ozC5/64AYuN0qGo7K4Os04MzT8pc2FQ/9rbhcMhQV1
 iwv1sYAIbXTSxMr4/wJWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UHnFF2u0Mho=:m4gA3QJeS2a2NeaJltANuD
 FIGvYSEioeNG6ORB4mS8saHgzTALhj8zK3M4MvGqTYA7ZWsRJQ1iby/69Jcs+M88hbEs1oLKT
 /lDgplexEEmdR1tjKDx4hshQZBI7wPNWCh3q85DPjcyZ6zpZupQTb7VCM5JO/2SEnBirj/gZX
 l6LCVXX3niQn+NuGgI54qWY1pg+fdyh4QhaN5PUR7hJ/5CPviT+GNYpECdJDKqrE9W23vxt7f
 HaIwI/3YbpgP/JDtlCBCsudaId0z1uMbKdRqSuPlIMSvepLMf0A2xF1ZClvIHVkvkA0TiIe38
 OYLKW2DfPzoCWI9TpkwQFagCDC9S7X3rlX9pYtTY9joddYCRfgfDiFamGsG6rarHknckpIOel
 rzMcSj9jxVV6OQoeD5SW8OI5IXM0HtAIgcVnpIEJoBx0A45JrCX/RzOTxWFib+qCTgB/Gahak
 88motJ8bfvGw3T/EUt/5UMHN+CMEojBdHJWRy0+/ZKaYrbCHkz9zFfyOfyO0gTUTph2T5iqXE
 AfxZwDpLfkwqZqIvjOslwJsrs3r7BYmeCwJpqdWakqBD7NJp+MOuH3yGRSMMoSUHDDcfZbkOs
 TzPkJ2NAhx/kgS+7lS558AT/wa3G9JGGZM5kve0NKUCVbBKI68fo3tJ2wuwRNvlObe8Rbu6Tz
 E7Nr1WNJ6dT9uPNKLaQlDo/G8ak6KtgouwV0nGPyiom/NoR3k77Z4Rk11B5j/hFQCMSPyfSXD
 xGVXdu9p4EhSwltNYClTgaYAK+3+MwhiJ4fpLfZHbEOnxlXhj+60y5zVsa5zt3KBo45EzGxIj
 PAl49MERLSkkrqWi66LZwcyu5dPu0q29spZebVVyN/O6dsTg3HqDEN8UwL446GOybCZxc3OUt
 ybqOHDS9yYK5TPAVjtd4g2NB/MYr31dzhymTfxsrh33Wri11eVGKHr8PvZoyKu37V0jmi437V
 +8tGtOadD/70GFqJWJxPE766xfhZiW5aVWfZ/q6EqWdzobVSO+uJoXuXywKgbww6NaDBwtj9b
 YrAMl56ok1dXzcEMnXopj9W1/HgmnSQ/4CemkOG1b/mHAAi3r1Hw2qpVCn8cqMenA62roxX/F
 xnbsT8VwmLMtDQ3IoIHnjqNBO8tJ0tuY5RN7tHenYoo/gEn0MRlCVl9/o36jZOo6+gPKyzjN3
 /TPdEbPULFlXFJgmUw4EMLOD6u8h4kACDaPGsVz8pMIpO8Lcktz9n6oRlQUfyYhu+oSPaQy8P
 YcoFfBk6w+U8gpmmZYxBRlvSfr9ioboL2pf34Ss//17NPsfYand42r9qPUdU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 29 Oct 2019, Jeff King wrote:

> On Tue, Oct 29, 2019 at 01:38:49PM +0100, Johannes Schindelin wrote:
>
> > > > Let's avoid this predicament altogether by rendering the entire me=
ssage,
> > > > including the prefix and the trailing newline, into the buffer we
> > > > already have (and which is still fixed size) and then write it out=
 via
> > > > `write_in_full()`.
> > >
> > > s/write_in_full/xwrite/ perhaps?  Both the cover letter and the patc=
h
> > > below use xwrite().
> >
> > Excellent eyes! I had originally used `write_in_full()` before realizi=
ng
> > that `xwrite()` would be more appropriate.
>
> What's your reasoning there? We wouldn't expect xwrite() to ever return
> with a partial write. But if it did for whatever reason, surely we'd
> prefer to keep trying to print the rest of the error rather than leave
> it truncated? We might see an error on the subsequent write(), but it's
> worth calling it to find out, I'd think.

Oh, `xwrite()` does not write in full, eh? But at least it continues on
`EINTR`...

Will fix.
Dscho
