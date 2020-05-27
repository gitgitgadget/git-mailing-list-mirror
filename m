Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BDDC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F1C206C3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k1FmXf1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbgE1McD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 08:32:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:37425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389439AbgE1McC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 08:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590669107;
        bh=jFiWMu0fdJsEDeoffep+yBo46ggZSo6/SgnEBsBg6OY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k1FmXf1bmr25s1GQvCQdO8cYTxp1sc2/gePgIhX6/gF3IXZ1jIa6C/rS4DdBRv55k
         3tkuafoYZN5FzkdX1waAcMzT294JFAgmcA1KllxuKpe2YwzLunQrn5SkAFH1m3uK/G
         RbMAjCTTr6an3y8jBX8eSVCRBclaBy/YcelXn4C0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.188]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1j5VAz2nC2-00hfvG; Thu, 28
 May 2020 14:31:47 +0200
Date:   Wed, 27 May 2020 21:58:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Merlin_B=C3=BCge?= <toni@bluenox07.de>
Subject: Re: [PATCH] checkout -p: handle new files correctly
In-Reply-To: <nycvar.QRO.7.76.6.2005272150220.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2005272157120.56@tvgsbejvaqbjf.bet>
References: <pull.646.git.1590613746507.gitgitgadget@gmail.com> <20200527230357.GB546534@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2005272150220.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:45T8T/JgSE8sIvo85dkNeihTvm2fNI7nyQMolQB1B3j+a5D6X2V
 jAQS8bpsGIs05FtamSs32CEOZ+K3EihIZjoKlzdaY2+eoX8GfX5YgO0s2ANtvOsFyr4xCHl
 NuKzIwZy/IntvNKoN0XsDK9zbTTzaPiCBmGLCIufh25DT6XYLkSHUbZUQEosM21dl/5y9z/
 5eap/s1RwGXLnhesAKhAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9s9/NLngmg0=:3NuSF7v+0sJ/zSWneVkKIE
 M4LCa+V/FrGPmd1tihGpfq+BfZYkI9FF0B+R1DGjv749ZrRekjfAMJIZub9f2hozQx6A2/euq
 BZNqw5WbuDEbqJDrVyOxlujwI7Re1SmGeIoIQDegV4omyjyIQ+xQxn17iWC0gLnMnLBHu6xaI
 3I7oKIOcLfyF9+EmZ5WuqLoveyVZFaNZNVzBZXhWcGExDz4wXaWwtRMgDkTzfQj6CCVVRUZ+v
 0g5vwMj233DRKOjgba4LHqyDeyMW3pQNjhEAcJcfW5W9sFg6JVScal2aTgY7N5ODrLQndkJLu
 QnYEC1MQnaCIuwpF4yGasLrc4D0ivf0NjpLn0Zg2J9M8uPiNTGYULt4vdfu4Kd+MOgxA9WJnh
 v2VkQl/lLXG/PSBbs2rqC96/7CnNJ9100hJoCgvcv6XYUrpWR785jNMiUxGKCxMy8OmQdZLHo
 Sin28Nc+PIBahc4EXETylPuVsj6Ip9Bjlt04X2g1RTu/OEQCdf4Oul2TDe4UyjlQjw1jTxfOJ
 +9b+RtrwF1RsqHVO5qxOsZWAg7BrXybM9UtPQfOGZrF7EPboGEnzEZYsFIGrSYS/5LxGtfT9F
 CJRnEpleW+qMy+N5EHf/TQumLNBMUNkHk7fKzxhqRxAwvR2XvZScfhyuQ4Hkvh7N3Iu3aBCm3
 mqRZ7BqkCV7iXpUq+paK0uE1S7CTzwJMUWcXdsz+RpNZgQpOo4wjltHgEWQ+Df4i8J7xZRBaV
 FUQYgZ+2z0DcRwYyeAgTFN975uxWi/nNda5fCUghVDMsF4R/v1l4g3I7FDjn09w1lHikWfO2L
 /DQl1GLuUM/0oEQdshExmiRo7o6AOJL8BwevYH/FxrTIGQevQ89zvbkCvdMfVYz/5rNGaxHOO
 XPumKL66R5bORXe8r++6G/ycDFGPbQXZPCDFFzHImIYEbcxken6ZjY49ICjvvG1ZQAq0rRtSo
 /9L8tlNr/nbbePjL6jYeFtBECT0AkdffYEcx6wdoICiCPVEQB7u1GlXYZnAN93Ee7+Kuo5zvj
 bXUSMAHEMop+Ccvn66fyh9/27D/1h0gRodDiVdQU2db0tkHA/7KQB3Lcp5qFKD/JdZC8pE3Ct
 n8RpmGYCoYPfwsTz4fj38b6rK9KczYZUMhCBO69pVAGwNaEj7ZdqH0bhcupCqh6e1Q65W6ycn
 okwfieSFGUGhSeedWMsMV8r9gyepliZoZWiwII3sJuCZRyCyqbUh8LkPtASyEdRJCbovSRXFp
 pXND2BeZkYIGAEZa4
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 27 May 2020, Johannes Schindelin wrote:

> On Wed, 27 May 2020, Jeff King wrote:
>
> > I lied a little with "would never see a new file". There _is_ a
> > related case with "add -p" that might be worth thinking about:
> > intent-to-add files.
>
> Indeed. Maybe I can leave that as #leftoverbits?

Added as https://github.com/gitgitgadget/git/issues/647

Ciao,
Dscho
