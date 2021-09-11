Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8DBC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9F9611F0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhIKREn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:04:43 -0400
Received: from mout.web.de ([212.227.15.14]:38657 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhIKREm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631379802;
        bh=00qWB3Ed81icwmnW0MgR8DvKxvS3RyH1kX/lKRoBll0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=BbsOEl603SvxycjHWz9pDKEojyHt1dS7gDkdaCgx/BSj/ZqjMVGa71QaTbvvz4D6O
         Jke63YehdXDdpnk9fuzSMde+XQnKacnbs6dQqEHbisePCxZqZxIqbWWmOAPtV0/lR5
         4ItTpatikWysNezxhaaGuqAOxlO0+WsBsFEmOriU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M1rTQ-1mMuY62RVg-002Ltw; Sat, 11 Sep 2021 19:03:22 +0200
Subject: Re: [PATCH 4/3] midx: inline nth_midxed_pack_entry()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
Message-ID: <165ffe5c-f8b0-a4e3-cb01-71ad74778f09@web.de>
Date:   Sat, 11 Sep 2021 19:03:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AhrlfaPQ9/5qUZFZV0ueoJpTDu0BzxCWhT/ihHK0RUkBQviz9SI
 tK1ysOL8neNQGXCOjYZIAO/WSGJcITdlooJ+dFOYYfd1uQ2XA23sovuDX9m5s96FvKh7sdY
 v8A+8XnGMggX4AWxx4KvmVtPtS5ryJt7o+N4ypTsSCzahqOcguwWWIUQt0payVIxuZpXzQz
 y2TOOWn8pBEAbW8yY4jkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kFpohrmglTw=:cQsoSWDCPbWiJ4Kll4XTrN
 29gzL8wbA5iMPc//Qa9ct2D9SdSNKZFnoKBwirCb2gf/2o4LUMMF02ZJDafwmtRglcV/BhjQe
 bJKC+4dgf6ckMhC4YHTpXNgBolH+Z8ZkLL5SG+pZEldElzhTxBTy0I4f9PLWsM7gwZQsGYpTJ
 hnY6Rc1HgSMrHrd8+mY6Pb43diFg9VwJIweWObqnEKAHpLN+7w6+Bw/1Dme9CTo+j32q33k73
 JhK4nLv/9W/VBawF2DmYD7jEiiK7bFzSVW8ePTL6KAPzFYpjRTonBX8Kqbrc4dUqBpHfjUY8N
 +bbb6M4VGaPy9Wb1ZaP3+qVShJOV5X0Cf2zXV3PLln0vdJTB0avHBtTFZXGhXIHM2IK6elXwS
 6f+J0yk3SjruQidpYpOVWXeS5n8D0PMoyqCwEECFu3LPMWxAyoG0DiJauujbK8KYazFaoI11J
 jh30vy2K+ll5yK49cUOKap3TJ3Kr2tQr0e4yKWSFPVT3JIRN6p2mR8PS17xmwtg6gbT7oXf1l
 9uerZ9joID/ARyPox8E1Y7d5HGggUWOqnv/xAKVi7VyYCQLLfdpS8xhx0L38/JZcSxc8T+nu1
 4a3z6NfWTkKIZZhSJzdD27LKlkg6siZUdHZ+eCJjvL+D9ViR0j3JLKm84jdSKhnJBog5sPy/4
 2nnbBrmnhdRsLwDuaI2wJo09TIDvt0nekV+AM80uYgralUT4NUyF6ysICk5VU2LJ/2edv7DuT
 9cKrBggaDIPSXtzvde3HZEJhZWpLBh5AZBQRaLhb8VKyP005/Qy3clm1lbx0XjBDCNmyqja93
 d/kbgMDxu8hIjS742n66QPuyIAie4YW0/ITVMxCUwaBatogb34y0oncIyjNwC0tUu/OO5i7Hj
 glHKOQVB4UZLFye/+vEtMagDRHK6x/nGVCmQoI1e9kA1uhfQWSLVgFAs+DYgbHCMepxHnfpb8
 SamXFRUM0aS/q0/NS39QRlJw9OiSCQP2hwkf/NDIxT07qxmYgOS+3crfrs1nujxTSjY4oK29U
 VZ3R4X3eAr/+xotmTRO/PRBXTs5hVbDynPXlPDfRznUmw/zNeXkWE2bCBurkT5ysoQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.21 um 18:08 schrieb Ren=C3=A9 Scharfe:
> fill_midx_entry() finds the position of an object ID and passes it to
> nth_midxed_pack_entry(), which uses the position to look up the object
> ID for its own purposes.  Inline the latter into the former to avoid
> that lookup.
>

Forgot:

Reported-by: Jeff King <peff@peff.net>

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Ren=C3=A9
