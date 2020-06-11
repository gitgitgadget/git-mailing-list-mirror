Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F359C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56823206C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 13:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HwxeLF1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgFKN5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:57:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:33735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFKN5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 09:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591883836;
        bh=Z1b+cJomWCoV75Btct7yLT8yEJR/D0d+ezgK3OSW62I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HwxeLF1pgWF1M2Y3VhNuTTmWRY6LHg7LHghMasPK/NUh8mblIFkX/uDqhrnk8sZlt
         kJ+/NyVJp2oDqy4qex9hQD70JpmOwJP5DkFau3VBez0iEAWU6RzbYztmbBuQc1q20U
         IHMoo8J7nnhYgPB4GPJTcac8x51MqVclROxysztQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.212.132]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1ioL9w1jsm-014CcL; Thu, 11
 Jun 2020 15:57:16 +0200
Date:   Thu, 11 Jun 2020 15:57:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matt Rogers <mattr94@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com,
        Jeff King <peff@peff.net>, sandals@crustytoothpaste.net
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default
 branch name
In-Reply-To: <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006111556090.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gKGCOBSACKwAVo544K+BGW6bEjWBvRo/l7t507sfQzuWI2jxTcr
 sx4mqHdegYQTt3BtKIFgwRCWHuA04VQxseDCPO3d8YKUr5GT3z9P9xz3KjubxTwdGz+0/Oy
 9NvBlw8MaveHmO8DzZQYuzyLlVx/k+svrYDai04bTkkF4jDK9YyAVMa1FaZolCqc+KPFQPT
 OWA7wsgGx9IB3DiPMPKAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BY/K0eHyg5I=:sg78i8pX3hgmvm4BX5n1Sw
 n0C4sYdP49/SWDqHjguo2RwwFA66waRv8gKpweYJj8SsJGRGX859yFMls9IkC4Ri8y/9UQq1o
 x/0a8PxNigBR1rUlz37rb7AJ1tHKfEkiRTP/0v8EUuZeKsNnFx/xdUPRCpfzU5VoxfKGu15Tb
 rQnW3HPkqdmbpGJtqgAtmEzl4U7/JYwvZNS7gZWshbeXtVQSirrrMJBbhfK/YdqBC0HbLoBhP
 SlQ/C/HUtjyxRC37cqppvrg0wseKxtJy/rjz0xFFl8UU7Pipjvz2FeaZve5CdNAN7uLQt41BC
 kuEOgPf/Q4dbQsgM6KqTDpQOSCJB2XMN5qYZ7EEBwW7FafgyQm3GWK4lL43NtVi98cLwQikHJ
 NS3WZIInfZRzUYywb10MldeFahlYpA5trpKWU3rlp4+TCG2qb+HhPOUfgwyjpejLXSEEpmUTb
 wsb4Y0mQH2aR7A9ro7B+1VNLYLGDsD2KvSZ2BZvGSjH4CRNBvn1WauT0ybWF9OiUZAxieWDON
 JYDMOl0l288VrqNpORUJhZsTYhuzCORqEHH/QqtaehvjKBOEk60cOhj+EaG0EtaTbYsN0vYZq
 qYICdlc7R10EezTipuLxmpkjwYalCPDvC5wrv1xRj1+jvY2CLbA5wCW+nNVqNTfh9i/88jjDN
 +Er92QpJZqXbETH+DMpWqkqisK35lhg6taollFt/NU7qBnH+XCqbUciYUzPAxc0tTAwwp+UUY
 kOToEKoazBwpB0JofUGiUMhhE4suA1B72ADKiG2ykA+vSMOC7wVYuO6nryq88seuWwrxM5dZF
 uajV4ofmW77tkTYXqC9ySoGnLt/hKhCwfEFgZ4vyHrOraFyc/uDGYlfCwdTzZBpkMvuxePHjD
 O6alHpLD9MSS0lvIZjrBeVNT+Bw2tkjPs2GxybH8niBSmWPPwluIwx7NPj8XGOMiZzUzN/5oA
 lr45GEEyE3iaAWlzW/ka5uPMRc77aKk0KpLEHnTAroh5u1peyjN6SoBMAs2LSXaOrpzsMtVIf
 ZKa1TDgmsnG8N/hfW20FstqD9/lPEC2fNJ9sgzl93dn2SI57W3Yvt/BVVfh8/MyGNC6lGIbj/
 hYWj0RM3dMmF9Iti1YAsf9/4gu8hy3x7j6OzPDY/OwrlMcL94n4pgUGcWnIdcSfqx7t/g0g9K
 VKssR8tvmD0TFEKBWMtNWFG4XMD77tlvNs23QdCiogf4SQrDdhmScgH989OL5aMktSdymn3P9
 O24tJmngxPJftmG3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matt,

On Wed, 10 Jun 2020, Matt Rogers wrote:

> > -        * We also leave "master" as a special case, since it does not reveal
> > -        * anything interesting.
> > +        * We also leave the default branch name as a special case, since it
> > +        * does not reveal anything interesting.
> >          */
> I feel this is a weird thing to do, since you're trying to anonymize the branch
> name,and now the default branch is identifiable with your config file.  For
> example, if the default branch contains the name of my project/repo then this
> sounds like a recipe for accidentally sharing it. I feel a better
> alternative would
> be to exclude nothing from the anonymization or the proposed default default
> branch name

I don't think that the name of the main branch should be subject to
anonymizing, whether it be `master` or anything else.

Ciao,
Dscho
