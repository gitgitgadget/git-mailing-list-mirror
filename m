Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC47C2BA19
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 22:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2038120672
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 22:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RVn/Kofu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgDEWNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 18:13:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:57259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDEWNB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 18:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586124774;
        bh=CCeKKwbskogwj2O5Sy8Rd4dA4SzY7kl7hwWal2+URBY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RVn/Kofu9RvnWskOLxHrtEbPiynvUJmtAtNnTqr3bQbEjgd6PQS2bpAnSUA61KcMJ
         Nxy99VKr+b7VMTvzG6r+eykz29vZqkqFg2cHKHt+9WAy2R81Pc/3s8FiVIDuPWbQw0
         tUbEMVPI+2fsMzlZtsaEzvOG3PeM8H1i+rVlMguk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.211]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVeI8-1jmfyc201s-00RbfI; Mon, 06 Apr 2020 00:12:54 +0200
Date:   Mon, 6 Apr 2020 00:12:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: avoid running curl-config unnecessarily
In-Reply-To: <CAPig+cR_ViZ2GWSs=grT=5bzQq44w+AAbXFsZaM_-CVMCELXQw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004060012120.46@tvgsbejvaqbjf.bet>
References: <20200326080540.GA2200522@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet> <20200404145829.GB679473@coredump.intra.peff.net> <CAPig+cR_ViZ2GWSs=grT=5bzQq44w+AAbXFsZaM_-CVMCELXQw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9uytI/0Dm2uway6I4fNginznHwiYNVZsKlitiW+GQNq9moMBSyh
 QGdifZu03y5UI1NgzcZWJTHAbM1GcKQ91WlO2AJUkOCa6FmaUCittA963odbC44ne7a0E8K
 3SAn6QBjAvt6TXCldlI6qKFV9K+7oEjWdBOSg6BavvUBh3nwY4c1kho6lSEVsM26TQnPX6N
 1A5W8FXA/HN4CAAPTj3CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jQuhnB4CjtA=:XizSVpIyaAp35uKBkjUVdL
 KiX59/cIphDf+3i9FoHsnvmRMhAal2M7BlpZ2RvukuqJ23RV5PQFLN3M1vAtXKu/wE//0reVp
 PGWwFg20hFZl/PKRSAoX50lYWZQX+ePkmUlAJdkXcuBKVnR+bPTfFqzRH+kPIg6Pq8t/bLb0G
 iTd1+REu6znXnSB6qTbRDoWvZ27zxiHzDdfHwgmwtrtd/nUu2HpkmrEJSRhAHbyy7aT9epG7C
 V1Uj+D/lOBGJlKN+HH/fPagOWLvflYTsPk9VRifgdgx9o8M6y+h4EYS56EJI56AhrtJSTxhNA
 zZfZoh7XTQSxfYlMVv4WJmk00/Ii0Wt0eHdr4rrNRgr3roGy68jZ6LXwq6GWotescdATDvyY4
 shiDNqHvljSofuiGPPY7ljbDZ111j5r80PKp0BG6fa7HL+AQQ/VQDWCvoNOeoXoTZKZ1B1Etz
 wah5jHTQ8APZHJYLNshSuAo1cALJk2S+ejNHK26l3T4+oJSHMqiSe/29HfS6csMDxc86kr/fi
 ExqJalNHMf2/IiXtfQy/Geim4nq4I/hQevNX7EA3YYf42XpuTBV8SBICGiY5j1xWXpvi+lqFZ
 ra1Fcuw3z/xs59hymybyZzo+Cpb1q4Auu83VBe5LFOFS2LCSHzfzm8Yv7yKGk5nHE+dqMm3oc
 xYKi7cEK9anraAmDpIscnrlEglHEBSHSOrRdyDGCcqz3DMQ/wgE6EJ8cPHq7iIUT0hhWKnR7C
 t6Dik6r09yhXoK9VU6m0NUL2FDqXyWzX4c3ATAYo+O2o/yAAjG4BC25qYOJW52PZ+e92Q/imr
 li5ngEzapwfZQLOI35zc8k/HZdmarGYeCbMKhq4YfvCuZfCzWVE0WusA0OWxQi6P2txToVrs1
 BbKM7tmTbCMdpFoX69863ntzGOW7sz86sre0a4YGVk5/GmMQyexDZW4wwWnTnucxVzFj/axvg
 nuL0EmoXmOpBfwrwmib/ANbqju5an07ICgxCq23N5SZbwB+TrV/gxS8rxAXWAjTliANKsAB5S
 XH/bSjsrt48BYicZeA1RA38jDTQr2gx3mg6jyh6I+BzNS1ufoYfMnDgxaFElV2NTAsPFA7lt2
 KJujl3XGW4tQAxaF2epfrmfsWuh7DHmM1QZM/N2EaXKyj0KSOnZFObcZET8bF4PiCbKImnSzd
 b3X3CQRsDNLmcmNlGYG60MQMk60IdOVvI+PVyTcp/Lc64lrFOxmXxZUFVLvaSrPHYDTLPDOnh
 iUZmfqln7jxSUSj92
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 4 Apr 2020, Eric Sunshine wrote:

> On Sat, Apr 4, 2020 at 10:58 AM Jeff King <peff@peff.net> wrote:
> > This is our first use of eval in the Makefile, but that goes back to G=
NU
> > make v3.80, which is from 2002. I think that should be OK.
>
> Upon reading this, I was worried that it might trip up Mac OS which
> has (often very) old versions of tools, but it's alright in this case,
> as Apple ships GNU 'make' 3.81 from 2006.

I share this concern. It may be more robust, after all, to squelch the
`curl-config` warning specifically in the `Documentation` job of our CI/PR
runs.

Ciao,
Dscho
